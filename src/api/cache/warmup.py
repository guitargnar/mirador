"""
Cache warmup service for Mirador API

Pre-populates cache with common queries and responses
"""
import asyncio
import logging
from typing import List, Dict, Any, Optional
from datetime import datetime, timedelta

from .cache_manager import cache_manager, CacheTTL
from ..core.config import settings


logger = logging.getLogger(__name__)


class CacheWarmupService:
    """
    Service for warming up the cache with common queries
    """
    
    def __init__(self):
        self.warmup_queries = self._load_warmup_queries()
        self.warmup_interval = settings.CACHE_WARMUP_INTERVAL  # seconds
        self.enabled = settings.CACHE_WARMUP_ENABLED
        self._running = False
    
    def _load_warmup_queries(self) -> List[Dict[str, Any]]:
        """Load queries to warm up from configuration"""
        # Default warmup queries
        default_queries = [
            {
                "query": "What are the most important things to focus on today?",
                "chain_type": "life_optimization",
                "format": "quick"
            },
            {
                "query": "Give me a productivity tip",
                "chain_type": "rapid_decision",
                "format": "quick"
            },
            {
                "query": "How can I improve my health?",
                "chain_type": "life_optimization",
                "format": "summary"
            },
            {
                "query": "What's a good business strategy?",
                "chain_type": "business_acceleration",
                "format": "summary"
            },
            {
                "query": "Help me with a creative idea",
                "chain_type": "creative_breakthrough",
                "format": "quick"
            }
        ]
        
        # Load from settings if available
        return getattr(settings, 'CACHE_WARMUP_QUERIES', default_queries)
    
    async def warmup_query(self, query_config: Dict[str, Any]) -> bool:
        """Warm up a single query"""
        try:
            from ..orchestrator import MiradorOrchestrator
            
            orchestrator = MiradorOrchestrator()
            
            # Execute query
            query = query_config.get("query")
            chain_type = query_config.get("chain_type")
            format_type = query_config.get("format", "detailed")
            
            logger.info(f"Warming up query: {query[:50]}...")
            
            # Run the query
            result = await orchestrator.process_query(
                query=query,
                chain_type=chain_type,
                format_type=format_type
            )
            
            # Cache the result
            if result:
                cache_manager.cache_query_response(
                    query=query,
                    response=result,
                    chain_type=chain_type,
                    options={"format": format_type},
                    ttl=CacheTTL.QUERY_RESPONSE * 2  # Longer TTL for warmup
                )
                logger.info(f"Successfully warmed up query: {query[:50]}...")
                return True
            
        except Exception as e:
            logger.error(f"Failed to warm up query: {e}")
        
        return False
    
    async def warmup_popular_models(self) -> int:
        """Pre-warm popular models"""
        try:
            from ..models import model_manager
            
            popular_models = [
                "matthew_context_provider_v6",
                "universal_strategy_architect",
                "creative_catalyst",
                "practical_implementer",
                "decision_simplifier"
            ]
            
            warmed = 0
            for model_name in popular_models:
                try:
                    logger.info(f"Pre-warming model: {model_name}")
                    await model_manager.warm_model(model_name)
                    warmed += 1
                except Exception as e:
                    logger.warning(f"Failed to warm model {model_name}: {e}")
            
            return warmed
            
        except Exception as e:
            logger.error(f"Failed to warm models: {e}")
            return 0
    
    async def warmup_batch(self) -> Dict[str, Any]:
        """Run a batch of warmup queries"""
        results = {
            "queries_warmed": 0,
            "models_warmed": 0,
            "errors": 0,
            "start_time": datetime.utcnow(),
            "duration": 0
        }
        
        # Warm up models first
        results["models_warmed"] = await self.warmup_popular_models()
        
        # Warm up queries
        tasks = []
        for query_config in self.warmup_queries:
            task = self.warmup_query(query_config)
            tasks.append(task)
        
        # Run warmup tasks concurrently
        warmup_results = await asyncio.gather(*tasks, return_exceptions=True)
        
        # Count results
        for result in warmup_results:
            if isinstance(result, Exception):
                results["errors"] += 1
            elif result:
                results["queries_warmed"] += 1
        
        # Calculate duration
        results["duration"] = (datetime.utcnow() - results["start_time"]).total_seconds()
        
        logger.info(
            f"Cache warmup completed: "
            f"{results['queries_warmed']} queries, "
            f"{results['models_warmed']} models, "
            f"{results['errors']} errors, "
            f"{results['duration']:.2f}s"
        )
        
        return results
    
    async def start(self):
        """Start the warmup service"""
        if not self.enabled:
            logger.info("Cache warmup service is disabled")
            return
        
        self._running = True
        logger.info("Starting cache warmup service")
        
        # Run initial warmup
        await self.warmup_batch()
        
        # Schedule periodic warmups
        while self._running:
            await asyncio.sleep(self.warmup_interval)
            if self._running:
                await self.warmup_batch()
    
    def stop(self):
        """Stop the warmup service"""
        self._running = False
        logger.info("Stopping cache warmup service")
    
    async def warmup_session(self, session_id: str, user_id: str) -> bool:
        """Warm up cache for a specific session"""
        try:
            from ..sessions import session_manager
            
            # Get session history
            history = await session_manager.get_session_history(session_id)
            
            if not history:
                return False
            
            # Cache recent queries from session
            cached = 0
            for entry in history[-5:]:  # Last 5 queries
                if "query" in entry and "response" in entry:
                    cache_manager.cache_query_response(
                        query=entry["query"],
                        response=entry["response"],
                        ttl=CacheTTL.SESSION_DATA
                    )
                    cached += 1
            
            logger.info(f"Warmed up {cached} queries for session {session_id}")
            return cached > 0
            
        except Exception as e:
            logger.error(f"Failed to warm up session {session_id}: {e}")
            return False
    
    def get_warmup_stats(self) -> Dict[str, Any]:
        """Get statistics about cache warmup"""
        stats = {
            "enabled": self.enabled,
            "running": self._running,
            "queries_configured": len(self.warmup_queries),
            "warmup_interval": self.warmup_interval,
            "cache_stats": cache_manager.get_cache_stats()
        }
        
        return stats


# Singleton instance
cache_warmup_service = CacheWarmupService()