"""
Cache manager for Mirador API using Redis

Provides caching for:
- Query responses
- Chain execution results
- Model outputs
- Session data
"""
import json
import hashlib
import time
import logging
from typing import Optional, Dict, Any, List, Union, Callable
from datetime import datetime, timedelta
from enum import Enum

import redis
from redis.exceptions import RedisError, ConnectionError as RedisConnectionError

from ..core.config import settings


logger = logging.getLogger(__name__)


class CacheNamespace(str, Enum):
    """Cache namespaces for different types of data"""
    QUERY = "query"
    CHAIN = "chain"
    MODEL = "model"
    SESSION = "session"
    METADATA = "metadata"
    STATS = "stats"


class CacheTTL:
    """Cache TTL settings in seconds"""
    QUERY_RESPONSE = 3600  # 1 hour
    CHAIN_RESULT = 1800    # 30 minutes
    MODEL_OUTPUT = 900     # 15 minutes
    SESSION_DATA = 86400   # 24 hours
    METADATA = 300         # 5 minutes
    STATS = 60            # 1 minute


class CacheManager:
    """
    Manages caching for the Mirador API
    """
    
    def __init__(
        self,
        redis_url: Optional[str] = None,
        key_prefix: str = "mirador",
        enabled: bool = True,
        default_ttl: int = 3600
    ):
        self.redis_url = redis_url or settings.REDIS_URL
        self.key_prefix = key_prefix
        self.enabled = enabled and settings.CACHE_ENABLED
        self.default_ttl = default_ttl
        
        self._redis_client: Optional[redis.Redis] = None
        self._pipeline_mode = False
        self._pipeline = None
        
        if self.enabled:
            self._init_redis()
    
    def _init_redis(self):
        """Initialize Redis connection"""
        try:
            self._redis_client = redis.from_url(
                self.redis_url,
                decode_responses=True,
                socket_connect_timeout=5,
                socket_timeout=5,
                retry_on_timeout=True,
                health_check_interval=30
            )
            # Test connection
            self._redis_client.ping()
            logger.info("Redis cache initialized successfully")
        except (RedisError, RedisConnectionError) as e:
            logger.error(f"Failed to connect to Redis: {e}")
            self.enabled = False
            self._redis_client = None
    
    def _make_key(
        self,
        namespace: Union[str, CacheNamespace],
        identifier: str,
        suffix: Optional[str] = None
    ) -> str:
        """Create a cache key"""
        parts = [self.key_prefix, namespace]
        if suffix:
            parts.extend([identifier, suffix])
        else:
            parts.append(identifier)
        return ":".join(str(p) for p in parts)
    
    def _hash_query(self, query: str, options: Optional[Dict[str, Any]] = None) -> str:
        """Create a hash for a query and its options"""
        cache_data = {
            "query": query,
            "options": options or {}
        }
        # Sort keys for consistent hashing
        cache_str = json.dumps(cache_data, sort_keys=True)
        return hashlib.sha256(cache_str.encode()).hexdigest()[:16]
    
    def get(
        self,
        namespace: Union[str, CacheNamespace],
        identifier: str,
        suffix: Optional[str] = None
    ) -> Optional[Any]:
        """Get a value from cache"""
        if not self.enabled or not self._redis_client:
            return None
        
        key = self._make_key(namespace, identifier, suffix)
        
        try:
            value = self._redis_client.get(key)
            if value:
                # Update access stats
                self._update_stats(namespace, "hits")
                return json.loads(value)
            else:
                self._update_stats(namespace, "misses")
                return None
        except (RedisError, json.JSONDecodeError) as e:
            logger.warning(f"Cache get error for {key}: {e}")
            return None
    
    def set(
        self,
        namespace: Union[str, CacheNamespace],
        identifier: str,
        value: Any,
        ttl: Optional[int] = None,
        suffix: Optional[str] = None
    ) -> bool:
        """Set a value in cache"""
        if not self.enabled or not self._redis_client:
            return False
        
        key = self._make_key(namespace, identifier, suffix)
        ttl = ttl or self.default_ttl
        
        try:
            serialized = json.dumps(value)
            
            if self._pipeline_mode and self._pipeline:
                self._pipeline.setex(key, ttl, serialized)
                return True
            else:
                return bool(self._redis_client.setex(key, ttl, serialized))
        except (RedisError, json.JSONEncodeError) as e:
            logger.warning(f"Cache set error for {key}: {e}")
            return False
    
    def delete(
        self,
        namespace: Union[str, CacheNamespace],
        identifier: str,
        suffix: Optional[str] = None
    ) -> bool:
        """Delete a value from cache"""
        if not self.enabled or not self._redis_client:
            return False
        
        key = self._make_key(namespace, identifier, suffix)
        
        try:
            return bool(self._redis_client.delete(key))
        except RedisError as e:
            logger.warning(f"Cache delete error for {key}: {e}")
            return False
    
    def delete_pattern(self, pattern: str) -> int:
        """Delete all keys matching a pattern"""
        if not self.enabled or not self._redis_client:
            return 0
        
        try:
            keys = self._redis_client.keys(f"{self.key_prefix}:{pattern}")
            if keys:
                return self._redis_client.delete(*keys)
            return 0
        except RedisError as e:
            logger.warning(f"Cache delete pattern error for {pattern}: {e}")
            return 0
    
    def cache_query_response(
        self,
        query: str,
        response: Dict[str, Any],
        chain_type: Optional[str] = None,
        options: Optional[Dict[str, Any]] = None,
        ttl: Optional[int] = None
    ) -> bool:
        """Cache a query response"""
        # Create cache key
        query_hash = self._hash_query(query, options)
        
        # Add metadata
        cache_data = {
            "response": response,
            "query": query,
            "chain_type": chain_type,
            "options": options,
            "cached_at": datetime.utcnow().isoformat(),
            "ttl": ttl or CacheTTL.QUERY_RESPONSE
        }
        
        # Store in cache
        return self.set(
            CacheNamespace.QUERY,
            query_hash,
            cache_data,
            ttl=ttl or CacheTTL.QUERY_RESPONSE
        )
    
    def get_cached_query(
        self,
        query: str,
        options: Optional[Dict[str, Any]] = None
    ) -> Optional[Dict[str, Any]]:
        """Get a cached query response"""
        query_hash = self._hash_query(query, options)
        cached = self.get(CacheNamespace.QUERY, query_hash)
        
        if cached:
            # Check if still valid
            cached_time = datetime.fromisoformat(cached["cached_at"])
            age = (datetime.utcnow() - cached_time).total_seconds()
            
            if age < cached.get("ttl", CacheTTL.QUERY_RESPONSE):
                return cached["response"]
            else:
                # Expired, delete it
                self.delete(CacheNamespace.QUERY, query_hash)
        
        return None
    
    def cache_chain_result(
        self,
        chain_type: str,
        prompt: str,
        result: Dict[str, Any],
        format: str = "detailed",
        ttl: Optional[int] = None
    ) -> bool:
        """Cache a chain execution result"""
        # Create cache key
        chain_data = f"{chain_type}:{format}:{prompt}"
        chain_hash = hashlib.sha256(chain_data.encode()).hexdigest()[:16]
        
        cache_data = {
            "result": result,
            "chain_type": chain_type,
            "prompt": prompt,
            "format": format,
            "cached_at": datetime.utcnow().isoformat()
        }
        
        return self.set(
            CacheNamespace.CHAIN,
            chain_hash,
            cache_data,
            ttl=ttl or CacheTTL.CHAIN_RESULT
        )
    
    def get_cached_chain(
        self,
        chain_type: str,
        prompt: str,
        format: str = "detailed"
    ) -> Optional[Dict[str, Any]]:
        """Get a cached chain result"""
        chain_data = f"{chain_type}:{format}:{prompt}"
        chain_hash = hashlib.sha256(chain_data.encode()).hexdigest()[:16]
        
        cached = self.get(CacheNamespace.CHAIN, chain_hash)
        return cached.get("result") if cached else None
    
    def cache_model_output(
        self,
        model_name: str,
        prompt: str,
        output: str,
        options: Optional[Dict[str, Any]] = None,
        ttl: Optional[int] = None
    ) -> bool:
        """Cache a model output"""
        # Create cache key
        model_data = {
            "model": model_name,
            "prompt": prompt,
            "options": options or {}
        }
        model_str = json.dumps(model_data, sort_keys=True)
        model_hash = hashlib.sha256(model_str.encode()).hexdigest()[:16]
        
        cache_data = {
            "output": output,
            "model": model_name,
            "prompt": prompt,
            "options": options,
            "cached_at": datetime.utcnow().isoformat()
        }
        
        return self.set(
            CacheNamespace.MODEL,
            model_hash,
            cache_data,
            ttl=ttl or CacheTTL.MODEL_OUTPUT
        )
    
    def get_cached_model(
        self,
        model_name: str,
        prompt: str,
        options: Optional[Dict[str, Any]] = None
    ) -> Optional[str]:
        """Get a cached model output"""
        model_data = {
            "model": model_name,
            "prompt": prompt,
            "options": options or {}
        }
        model_str = json.dumps(model_data, sort_keys=True)
        model_hash = hashlib.sha256(model_str.encode()).hexdigest()[:16]
        
        cached = self.get(CacheNamespace.MODEL, model_hash)
        return cached.get("output") if cached else None
    
    def invalidate_session(self, session_id: str) -> int:
        """Invalidate all cache entries for a session"""
        pattern = f"*:{session_id}:*"
        return self.delete_pattern(pattern)
    
    def invalidate_user(self, user_id: str) -> int:
        """Invalidate all cache entries for a user"""
        count = 0
        # Invalidate queries
        count += self.delete_pattern(f"{CacheNamespace.QUERY}:*{user_id}*")
        # Invalidate sessions
        count += self.delete_pattern(f"{CacheNamespace.SESSION}:{user_id}:*")
        return count
    
    def get_cache_stats(self) -> Dict[str, Any]:
        """Get cache statistics"""
        if not self.enabled or not self._redis_client:
            return {"enabled": False}
        
        try:
            info = self._redis_client.info()
            stats = {
                "enabled": True,
                "connected": True,
                "memory_used": info.get("used_memory_human", "0"),
                "total_keys": self._redis_client.dbsize(),
                "hit_rate": self._calculate_hit_rate(),
                "namespaces": {}
            }
            
            # Get stats per namespace
            for namespace in CacheNamespace:
                ns_stats = self.get(CacheNamespace.STATS, namespace.value) or {}
                stats["namespaces"][namespace.value] = ns_stats
            
            return stats
        except RedisError as e:
            logger.error(f"Failed to get cache stats: {e}")
            return {"enabled": True, "connected": False, "error": str(e)}
    
    def _update_stats(self, namespace: Union[str, CacheNamespace], metric: str):
        """Update cache statistics"""
        if not self.enabled or not self._redis_client:
            return
        
        try:
            stats_key = self._make_key(CacheNamespace.STATS, str(namespace))
            
            # Get current stats
            stats = self.get(CacheNamespace.STATS, str(namespace)) or {
                "hits": 0,
                "misses": 0,
                "sets": 0,
                "deletes": 0
            }
            
            # Update metric
            if metric in stats:
                stats[metric] += 1
            
            # Calculate hit rate
            total = stats["hits"] + stats["misses"]
            stats["hit_rate"] = (stats["hits"] / total * 100) if total > 0 else 0
            
            # Save stats
            self.set(CacheNamespace.STATS, str(namespace), stats, ttl=CacheTTL.STATS)
        except RedisError:
            pass  # Don't fail on stats errors
    
    def _calculate_hit_rate(self) -> float:
        """Calculate overall cache hit rate"""
        total_hits = 0
        total_misses = 0
        
        for namespace in CacheNamespace:
            if namespace == CacheNamespace.STATS:
                continue
            stats = self.get(CacheNamespace.STATS, namespace.value) or {}
            total_hits += stats.get("hits", 0)
            total_misses += stats.get("misses", 0)
        
        total = total_hits + total_misses
        return (total_hits / total * 100) if total > 0 else 0
    
    def pipeline(self):
        """Start a pipeline for batch operations"""
        if not self.enabled or not self._redis_client:
            return self
        
        self._pipeline = self._redis_client.pipeline()
        self._pipeline_mode = True
        return self
    
    def execute(self) -> List[Any]:
        """Execute pipeline operations"""
        if not self._pipeline_mode or not self._pipeline:
            return []
        
        try:
            results = self._pipeline.execute()
            return results
        finally:
            self._pipeline_mode = False
            self._pipeline = None
    
    def __enter__(self):
        """Context manager entry"""
        return self.pipeline()
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        """Context manager exit"""
        if self._pipeline_mode:
            self.execute()


# Singleton instance
cache_manager = CacheManager()