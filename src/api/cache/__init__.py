"""
Cache module for Mirador API

Provides Redis-based caching for:
- Query responses
- Chain execution results  
- Model outputs
- Session data
"""

from .cache_manager import (
    CacheManager,
    cache_manager,
    CacheNamespace,
    CacheTTL
)

from .decorators import (
    cached_response,
    cached_query,
    cached_chain,
    cached_model,
    invalidate_cache,
    cache_control,
    conditional_cache,
    user_specific_cache
)

from .warmup import (
    CacheWarmupService,
    cache_warmup_service
)

__all__ = [
    # Manager
    'CacheManager',
    'cache_manager',
    'CacheNamespace',
    'CacheTTL',
    
    # Decorators
    'cached_response',
    'cached_query',
    'cached_chain',
    'cached_model',
    'invalidate_cache',
    'cache_control',
    'conditional_cache',
    'user_specific_cache',
    
    # Warmup
    'CacheWarmupService',
    'cache_warmup_service'
]