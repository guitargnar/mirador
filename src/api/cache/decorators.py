"""
Cache decorators for Mirador API endpoints
"""
import functools
import hashlib
import json
from typing import Optional, Callable, Any, Dict, Union
from flask import request, g, current_app

from .cache_manager import cache_manager, CacheNamespace, CacheTTL


def cache_key_from_request(
    prefix: str,
    include_body: bool = True,
    include_args: bool = True,
    include_user: bool = True
) -> str:
    """Generate cache key from Flask request"""
    parts = [prefix]
    
    # Include user ID if authenticated
    if include_user and hasattr(g, 'current_user'):
        parts.append(f"user:{g.current_user['id']}")
    
    # Include request args
    if include_args and request.args:
        args_str = "&".join(f"{k}={v}" for k, v in sorted(request.args.items()))
        parts.append(f"args:{hashlib.md5(args_str.encode()).hexdigest()[:8]}")
    
    # Include request body
    if include_body and request.is_json:
        body_str = json.dumps(request.get_json(), sort_keys=True)
        parts.append(f"body:{hashlib.md5(body_str.encode()).hexdigest()[:8]}")
    
    return ":".join(parts)


def cached_response(
    namespace: Union[str, CacheNamespace] = CacheNamespace.QUERY,
    ttl: Optional[int] = None,
    key_func: Optional[Callable] = None,
    unless: Optional[Callable] = None,
    cache_errors: bool = False
):
    """
    Decorator to cache endpoint responses
    
    Args:
        namespace: Cache namespace to use
        ttl: Time to live in seconds
        key_func: Custom function to generate cache key
        unless: Function that returns True to skip caching
        cache_errors: Whether to cache error responses
    """
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            # Check if caching should be skipped
            if unless and unless():
                return func(*args, **kwargs)
            
            # Check if caching is enabled
            if not cache_manager.enabled:
                return func(*args, **kwargs)
            
            # Generate cache key
            if key_func:
                cache_key = key_func(*args, **kwargs)
            else:
                cache_key = cache_key_from_request(func.__name__)
            
            # Try to get from cache
            cached = cache_manager.get(namespace, cache_key)
            if cached is not None:
                current_app.logger.debug(f"Cache hit for {cache_key}")
                # Add cache headers
                response = current_app.response_class(
                    json.dumps(cached),
                    mimetype='application/json'
                )
                response.headers['X-Cache'] = 'HIT'
                return response
            
            # Execute function
            result = func(*args, **kwargs)
            
            # Cache the result if successful
            if hasattr(result, 'status_code'):
                # Flask Response object
                if result.status_code == 200 or (cache_errors and result.status_code >= 400):
                    try:
                        data = result.get_json()
                        cache_manager.set(namespace, cache_key, data, ttl=ttl)
                        result.headers['X-Cache'] = 'MISS'
                    except:
                        pass
            else:
                # Direct return value
                cache_manager.set(namespace, cache_key, result, ttl=ttl)
            
            return result
        
        return wrapper
    return decorator


def cached_query(ttl: Optional[int] = None):
    """Decorator specifically for caching query endpoints"""
    return cached_response(
        namespace=CacheNamespace.QUERY,
        ttl=ttl or CacheTTL.QUERY_RESPONSE,
        unless=lambda: request.method != 'GET'
    )


def cached_chain(ttl: Optional[int] = None):
    """Decorator specifically for caching chain results"""
    return cached_response(
        namespace=CacheNamespace.CHAIN,
        ttl=ttl or CacheTTL.CHAIN_RESULT
    )


def cached_model(ttl: Optional[int] = None):
    """Decorator specifically for caching model outputs"""
    return cached_response(
        namespace=CacheNamespace.MODEL,
        ttl=ttl or CacheTTL.MODEL_OUTPUT
    )


def invalidate_cache(
    namespace: Union[str, CacheNamespace],
    key_func: Optional[Callable] = None
):
    """
    Decorator to invalidate cache after endpoint execution
    
    Args:
        namespace: Cache namespace to invalidate
        key_func: Function to generate keys to invalidate
    """
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            # Execute function first
            result = func(*args, **kwargs)
            
            # Invalidate cache if successful
            if hasattr(result, 'status_code') and 200 <= result.status_code < 300:
                if key_func:
                    keys = key_func(*args, **kwargs)
                    if isinstance(keys, str):
                        cache_manager.delete(namespace, keys)
                    else:
                        for key in keys:
                            cache_manager.delete(namespace, key)
                else:
                    # Invalidate by pattern
                    if hasattr(g, 'current_user'):
                        cache_manager.invalidate_user(g.current_user['id'])
            
            return result
        
        return wrapper
    return decorator


def cache_control(
    no_cache: bool = False,
    no_store: bool = False,
    max_age: Optional[int] = None,
    must_revalidate: bool = False
):
    """
    Decorator to add HTTP cache control headers
    
    Args:
        no_cache: Prevent caching
        no_store: Prevent storing in any cache
        max_age: Maximum age in seconds
        must_revalidate: Force revalidation
    """
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            result = func(*args, **kwargs)
            
            # Build cache control header
            directives = []
            if no_cache:
                directives.append('no-cache')
            if no_store:
                directives.append('no-store')
            if max_age is not None:
                directives.append(f'max-age={max_age}')
            if must_revalidate:
                directives.append('must-revalidate')
            
            if directives and hasattr(result, 'headers'):
                result.headers['Cache-Control'] = ', '.join(directives)
            
            return result
        
        return wrapper
    return decorator


def conditional_cache(
    condition_func: Callable[[], bool],
    namespace: Union[str, CacheNamespace] = CacheNamespace.QUERY,
    ttl: Optional[int] = None
):
    """
    Decorator for conditional caching based on runtime conditions
    
    Args:
        condition_func: Function that returns True to enable caching
        namespace: Cache namespace
        ttl: Time to live
    """
    return cached_response(
        namespace=namespace,
        ttl=ttl,
        unless=lambda: not condition_func()
    )


def user_specific_cache(
    namespace: Union[str, CacheNamespace] = CacheNamespace.QUERY,
    ttl: Optional[int] = None,
    include_session: bool = False
):
    """
    Decorator for user-specific caching
    
    Args:
        namespace: Cache namespace
        ttl: Time to live
        include_session: Include session ID in cache key
    """
    def key_func(*args, **kwargs):
        parts = [request.endpoint]
        
        # Add user ID
        if hasattr(g, 'current_user'):
            parts.append(f"user:{g.current_user['id']}")
        
        # Add session ID if requested
        if include_session and hasattr(g, 'session_id'):
            parts.append(f"session:{g.session_id}")
        
        # Add request specifics
        if request.args:
            args_str = "&".join(f"{k}={v}" for k, v in sorted(request.args.items()))
            parts.append(hashlib.md5(args_str.encode()).hexdigest()[:8])
        
        return ":".join(parts)
    
    return cached_response(
        namespace=namespace,
        ttl=ttl,
        key_func=key_func
    )