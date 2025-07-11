"""
GraphQL middleware for request processing

Provides middleware for logging, metrics, and error handling
"""
import time
import json
from typing import Callable, Any, Dict, Optional
from graphql import GraphQLError, MiddlewareManager
from flask import g, current_app

from ..core.logging import get_logger
from ..core.exceptions import APIError
from .errors import convert_api_error_to_graphql


logger = get_logger(__name__)


class GraphQLLoggingMiddleware:
    """Middleware for logging GraphQL operations"""
    
    def resolve(self, next: Callable, root, info, **args) -> Any:
        """Log GraphQL operations"""
        start_time = time.time()
        field_name = info.field_name
        parent_type = info.parent_type.name
        
        # Log operation start
        logger.debug(
            "GraphQL operation started",
            field=field_name,
            parent_type=parent_type,
            user_id=g.get('current_user', {}).get('id'),
            session_id=g.get('session_id')
        )
        
        try:
            # Execute resolver
            result = next(root, info, **args)
            
            # Log successful operation
            duration = time.time() - start_time
            logger.info(
                "GraphQL operation completed",
                field=field_name,
                parent_type=parent_type,
                duration_ms=round(duration * 1000, 2),
                user_id=g.get('current_user', {}).get('id')
            )
            
            return result
            
        except Exception as e:
            # Log error
            duration = time.time() - start_time
            logger.error(
                "GraphQL operation failed",
                field=field_name,
                parent_type=parent_type,
                duration_ms=round(duration * 1000, 2),
                error=str(e),
                user_id=g.get('current_user', {}).get('id')
            )
            raise


class GraphQLMetricsMiddleware:
    """Middleware for collecting GraphQL metrics"""
    
    def __init__(self, metrics_collector=None):
        """Initialize metrics middleware"""
        self.metrics = metrics_collector
    
    def resolve(self, next: Callable, root, info, **args) -> Any:
        """Collect metrics for GraphQL operations"""
        if not self.metrics:
            return next(root, info, **args)
        
        start_time = time.time()
        field_name = info.field_name
        parent_type = info.parent_type.name
        operation_name = f"{parent_type}.{field_name}"
        
        try:
            result = next(root, info, **args)
            
            # Record success metric
            duration = time.time() - start_time
            self.metrics.record_graphql_operation(
                operation=operation_name,
                duration=duration,
                status='success'
            )
            
            return result
            
        except Exception as e:
            # Record error metric
            duration = time.time() - start_time
            self.metrics.record_graphql_operation(
                operation=operation_name,
                duration=duration,
                status='error',
                error_type=type(e).__name__
            )
            raise


class GraphQLErrorHandlingMiddleware:
    """Middleware for handling GraphQL errors"""
    
    def resolve(self, next: Callable, root, info, **args) -> Any:
        """Handle errors in GraphQL operations"""
        try:
            return next(root, info, **args)
            
        except APIError as e:
            # Convert API errors to GraphQL errors
            raise convert_api_error_to_graphql(e)
            
        except GraphQLError:
            # Re-raise GraphQL errors as-is
            raise
            
        except Exception as e:
            # Convert unexpected errors
            logger.exception("Unexpected error in GraphQL resolver")
            
            # Add debug info in development
            if current_app.debug:
                raise GraphQLError(
                    f"Internal server error: {str(e)}",
                    extensions={
                        'exception': type(e).__name__,
                        'traceback': str(e.__traceback__)
                    }
                )
            else:
                raise GraphQLError("Internal server error")


class GraphQLCachingMiddleware:
    """Middleware for caching GraphQL queries"""
    
    def __init__(self, cache_manager):
        """Initialize caching middleware"""
        self.cache = cache_manager
    
    def resolve(self, next: Callable, root, info, **args) -> Any:
        """Cache GraphQL query results"""
        # Only cache queries, not mutations or subscriptions
        if info.operation.operation != 'query':
            return next(root, info, **args)
        
        # Skip caching for certain fields
        skip_cache_fields = {'health', 'cache_stats'}
        if info.field_name in skip_cache_fields:
            return next(root, info, **args)
        
        # Generate cache key
        cache_key = self._generate_cache_key(info, args)
        
        # Check cache
        cached_result = self.cache.get(cache_key)
        if cached_result is not None:
            logger.debug(
                "GraphQL cache hit",
                field=info.field_name,
                cache_key=cache_key
            )
            return cached_result
        
        # Execute resolver
        result = next(root, info, **args)
        
        # Cache result (with appropriate TTL based on field)
        ttl = self._get_cache_ttl(info.field_name)
        if ttl > 0:
            self.cache.set(cache_key, result, ttl=ttl)
            logger.debug(
                "GraphQL result cached",
                field=info.field_name,
                cache_key=cache_key,
                ttl=ttl
            )
        
        return result
    
    def _generate_cache_key(self, info, args: Dict[str, Any]) -> str:
        """Generate cache key for GraphQL query"""
        user_id = g.get('current_user', {}).get('id', 'anonymous')
        
        # Create stable key from field and arguments
        key_parts = [
            'graphql',
            info.parent_type.name,
            info.field_name,
            user_id,
            json.dumps(args, sort_keys=True)
        ]
        
        return ':'.join(key_parts)
    
    def _get_cache_ttl(self, field_name: str) -> int:
        """Get cache TTL for field"""
        # Field-specific TTLs
        ttl_map = {
            'models': 3600,  # 1 hour
            'chains': 3600,  # 1 hour
            'sessions': 300,  # 5 minutes
            'session_history': 300,  # 5 minutes
            'webhooks': 600,  # 10 minutes
        }
        
        return ttl_map.get(field_name, 300)  # Default 5 minutes


class GraphQLDepthLimitMiddleware:
    """Middleware for limiting query depth"""
    
    def __init__(self, max_depth: int = 10):
        """Initialize depth limit middleware"""
        self.max_depth = max_depth
    
    def resolve(self, next: Callable, root, info, **args) -> Any:
        """Check query depth before executing"""
        # Calculate current depth
        depth = self._calculate_depth(info.path)
        
        if depth > self.max_depth:
            raise GraphQLError(
                f"Query depth {depth} exceeds maximum allowed depth {self.max_depth}",
                extensions={'code': 'DEPTH_LIMIT_EXCEEDED'}
            )
        
        return next(root, info, **args)
    
    def _calculate_depth(self, path) -> int:
        """Calculate query depth from path"""
        if not path:
            return 0
        
        depth = 0
        current = path
        while current:
            depth += 1
            current = getattr(current, 'prev', None)
        
        return depth


def create_graphql_middleware(cache_manager=None, metrics_collector=None) -> list:
    """Create GraphQL middleware stack"""
    middleware = []
    
    # Always include error handling and logging
    middleware.append(GraphQLErrorHandlingMiddleware())
    middleware.append(GraphQLLoggingMiddleware())
    
    # Add metrics if collector provided
    if metrics_collector:
        middleware.append(GraphQLMetricsMiddleware(metrics_collector))
    
    # Add caching if manager provided
    if cache_manager:
        middleware.append(GraphQLCachingMiddleware(cache_manager))
    
    # Add depth limiting
    middleware.append(GraphQLDepthLimitMiddleware())
    
    return middleware