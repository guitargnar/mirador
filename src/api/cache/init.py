"""
Cache initialization for Mirador API
"""
import logging
import asyncio
from typing import Optional

from flask import Flask
from .cache_manager import cache_manager
from .warmup import cache_warmup_service
from ..core.config import settings


logger = logging.getLogger(__name__)


def init_cache(app: Optional[Flask] = None) -> bool:
    """
    Initialize the caching system
    
    Args:
        app: Flask application instance
        
    Returns:
        bool: True if cache initialized successfully
    """
    try:
        # Initialize cache manager
        if app:
            # Use app config if available
            cache_manager.redis_url = app.config.get('REDIS_URL', settings.REDIS_URL)
            cache_manager.enabled = app.config.get('CACHE_ENABLED', settings.CACHE_ENABLED)
        
        # Test Redis connection
        if cache_manager.enabled and cache_manager._redis_client:
            cache_manager._redis_client.ping()
            logger.info("Cache system initialized successfully")
            
            # Log cache configuration
            logger.info(f"Cache settings: {settings.cache_settings}")
            
            return True
        else:
            logger.warning("Cache system is disabled or not available")
            return False
            
    except Exception as e:
        logger.error(f"Failed to initialize cache: {e}")
        return False


def start_cache_warmup():
    """
    Start the cache warmup service in background
    """
    if not cache_warmup_service.enabled:
        logger.info("Cache warmup is disabled")
        return
    
    try:
        # Create event loop for warmup service
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)
        
        # Run warmup in background
        loop.create_task(cache_warmup_service.start())
        
        logger.info("Cache warmup service started")
        
    except Exception as e:
        logger.error(f"Failed to start cache warmup: {e}")


def stop_cache_warmup():
    """Stop the cache warmup service"""
    cache_warmup_service.stop()
    logger.info("Cache warmup service stopped")


def get_cache_health() -> dict:
    """
    Get cache system health status
    
    Returns:
        dict: Health status information
    """
    health = {
        "enabled": cache_manager.enabled,
        "connected": False,
        "error": None
    }
    
    if cache_manager.enabled and cache_manager._redis_client:
        try:
            cache_manager._redis_client.ping()
            health["connected"] = True
            
            # Get basic stats
            info = cache_manager._redis_client.info()
            health["version"] = info.get("redis_version")
            health["memory_used"] = info.get("used_memory_human")
            health["connected_clients"] = info.get("connected_clients")
            
        except Exception as e:
            health["error"] = str(e)
    
    return health


def clear_all_cache() -> int:
    """
    Clear all cache entries
    
    Returns:
        int: Number of entries cleared
    """
    if not cache_manager.enabled:
        return 0
    
    try:
        cleared = 0
        # Clear all namespaces
        for namespace in ['query', 'chain', 'model', 'session', 'metadata']:
            pattern = f"{namespace}:*"
            cleared += cache_manager.delete_pattern(pattern)
        
        logger.info(f"Cleared {cleared} cache entries")
        return cleared
        
    except Exception as e:
        logger.error(f"Failed to clear cache: {e}")
        return 0


def register_cache_commands(app: Flask):
    """
    Register Flask CLI commands for cache management
    
    Args:
        app: Flask application instance
    """
    @app.cli.command()
    def cache_stats():
        """Display cache statistics"""
        stats = cache_manager.get_cache_stats()
        print("Cache Statistics:")
        print(f"  Enabled: {stats.get('enabled')}")
        print(f"  Connected: {stats.get('connected')}")
        print(f"  Memory Used: {stats.get('memory_used')}")
        print(f"  Total Keys: {stats.get('total_keys')}")
        print(f"  Hit Rate: {stats.get('hit_rate', 0):.1f}%")
        
        if stats.get('namespaces'):
            print("\nNamespace Statistics:")
            for ns, ns_stats in stats['namespaces'].items():
                print(f"  {ns}:")
                print(f"    Hits: {ns_stats.get('hits', 0)}")
                print(f"    Misses: {ns_stats.get('misses', 0)}")
                print(f"    Hit Rate: {ns_stats.get('hit_rate', 0):.1f}%")
    
    @app.cli.command()
    def cache_clear():
        """Clear all cache entries"""
        cleared = clear_all_cache()
        print(f"Cleared {cleared} cache entries")
    
    @app.cli.command()
    def cache_warmup():
        """Run cache warmup"""
        import asyncio
        
        async def run_warmup():
            results = await cache_warmup_service.warmup_batch()
            print(f"Warmup Results:")
            print(f"  Queries Warmed: {results['queries_warmed']}")
            print(f"  Models Warmed: {results['models_warmed']}")
            print(f"  Errors: {results['errors']}")
            print(f"  Duration: {results['duration']:.2f}s")
        
        asyncio.run(run_warmup())
    
    @app.cli.command()
    def cache_health():
        """Check cache health"""
        health = get_cache_health()
        print("Cache Health:")
        print(f"  Enabled: {health['enabled']}")
        print(f"  Connected: {health['connected']}")
        if health.get('version'):
            print(f"  Redis Version: {health['version']}")
        if health.get('memory_used'):
            print(f"  Memory Used: {health['memory_used']}")
        if health.get('error'):
            print(f"  Error: {health['error']}")


# Export functions
__all__ = [
    'init_cache',
    'start_cache_warmup',
    'stop_cache_warmup',
    'get_cache_health',
    'clear_all_cache',
    'register_cache_commands'
]