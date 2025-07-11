"""
Metrics collection and Prometheus integration.
"""
import time
import asyncio
from typing import Dict, List, Optional, Any, Union
from datetime import datetime, timedelta
from collections import defaultdict
from dataclasses import dataclass, field

from prometheus_client import (
    Counter, Histogram, Gauge, Summary,
    CollectorRegistry, generate_latest,
    CONTENT_TYPE_LATEST
)
from fastapi import APIRouter, Response
from fastapi.responses import PlainTextResponse

from ..database import get_db_connection


@dataclass
class MetricPoint:
    """Single metric data point."""
    name: str
    value: float
    labels: Dict[str, str] = field(default_factory=dict)
    timestamp: datetime = field(default_factory=datetime.utcnow)


class MetricsCollector:
    """
    Centralized metrics collection for monitoring.
    
    Collects and exposes metrics in Prometheus format.
    """
    
    def __init__(self):
        self.registry = CollectorRegistry()
        self.router = APIRouter(tags=["metrics"])
        self._setup_metrics()
        self._setup_routes()
        
        # Internal metrics storage for custom metrics
        self._custom_metrics: Dict[str, List[MetricPoint]] = defaultdict(list)
        self._retention_hours = 24
    
    def _setup_metrics(self):
        """Initialize Prometheus metrics."""
        # Request metrics
        self.request_count = Counter(
            'mirador_api_requests_total',
            'Total number of API requests',
            ['method', 'endpoint', 'status'],
            registry=self.registry
        )
        
        self.request_duration = Histogram(
            'mirador_api_request_duration_seconds',
            'Request duration in seconds',
            ['method', 'endpoint'],
            registry=self.registry
        )
        
        self.request_size = Summary(
            'mirador_api_request_size_bytes',
            'Request size in bytes',
            ['method', 'endpoint'],
            registry=self.registry
        )
        
        self.response_size = Summary(
            'mirador_api_response_size_bytes',
            'Response size in bytes',
            ['method', 'endpoint'],
            registry=self.registry
        )
        
        # Model metrics
        self.model_requests = Counter(
            'mirador_model_requests_total',
            'Total model requests',
            ['model', 'chain_type'],
            registry=self.registry
        )
        
        self.model_latency = Histogram(
            'mirador_model_latency_seconds',
            'Model inference latency',
            ['model'],
            buckets=[0.1, 0.5, 1.0, 2.5, 5.0, 10.0, 30.0],
            registry=self.registry
        )
        
        self.model_errors = Counter(
            'mirador_model_errors_total',
            'Total model errors',
            ['model', 'error_type'],
            registry=self.registry
        )
        
        # Cache metrics
        self.cache_hits = Counter(
            'mirador_cache_hits_total',
            'Cache hit count',
            ['cache_type'],
            registry=self.registry
        )
        
        self.cache_misses = Counter(
            'mirador_cache_misses_total',
            'Cache miss count',
            ['cache_type'],
            registry=self.registry
        )
        
        # Session metrics
        self.active_sessions = Gauge(
            'mirador_active_sessions',
            'Number of active sessions',
            registry=self.registry
        )
        
        self.session_duration = Histogram(
            'mirador_session_duration_seconds',
            'Session duration',
            buckets=[60, 300, 900, 1800, 3600, 7200],
            registry=self.registry
        )
        
        # System metrics
        self.cpu_usage = Gauge(
            'mirador_cpu_usage_percent',
            'CPU usage percentage',
            registry=self.registry
        )
        
        self.memory_usage = Gauge(
            'mirador_memory_usage_bytes',
            'Memory usage in bytes',
            registry=self.registry
        )
        
        self.disk_usage = Gauge(
            'mirador_disk_usage_percent',
            'Disk usage percentage',
            ['mount_point'],
            registry=self.registry
        )
        
        # Database metrics
        self.db_connections = Gauge(
            'mirador_db_connections',
            'Database connection count',
            ['state'],
            registry=self.registry
        )
        
        self.db_query_duration = Histogram(
            'mirador_db_query_duration_seconds',
            'Database query duration',
            ['query_type'],
            registry=self.registry
        )
        
        # Webhook metrics
        self.webhook_deliveries = Counter(
            'mirador_webhook_deliveries_total',
            'Webhook delivery attempts',
            ['webhook_id', 'status'],
            registry=self.registry
        )
        
        self.webhook_latency = Histogram(
            'mirador_webhook_latency_seconds',
            'Webhook delivery latency',
            ['webhook_id'],
            registry=self.registry
        )
    
    def _setup_routes(self):
        """Configure metrics routes."""
        self.router.get("/metrics")(self.prometheus_metrics)
        self.router.get("/metrics/custom")(self.custom_metrics)
        self.router.post("/metrics/custom")(self.record_custom_metric)
        self.router.get("/metrics/summary")(self.metrics_summary)
    
    async def prometheus_metrics(self) -> Response:
        """
        Expose metrics in Prometheus format.
        
        Returns:
            PlainTextResponse with Prometheus metrics
        """
        # Update system metrics before serving
        await self._update_system_metrics()
        
        metrics_data = generate_latest(self.registry)
        return Response(
            content=metrics_data,
            media_type=CONTENT_TYPE_LATEST
        )
    
    async def custom_metrics(
        self,
        metric_name: Optional[str] = None,
        start_time: Optional[datetime] = None,
        end_time: Optional[datetime] = None
    ) -> Dict[str, Any]:
        """
        Retrieve custom metrics.
        
        Args:
            metric_name: Filter by metric name
            start_time: Start of time range
            end_time: End of time range
            
        Returns:
            Dictionary of custom metrics
        """
        # Clean old metrics
        self._clean_old_metrics()
        
        # Filter metrics
        results = {}
        for name, points in self._custom_metrics.items():
            if metric_name and name != metric_name:
                continue
            
            filtered_points = points
            if start_time:
                filtered_points = [p for p in filtered_points if p.timestamp >= start_time]
            if end_time:
                filtered_points = [p for p in filtered_points if p.timestamp <= end_time]
            
            if filtered_points:
                results[name] = [
                    {
                        "value": p.value,
                        "labels": p.labels,
                        "timestamp": p.timestamp.isoformat()
                    }
                    for p in filtered_points
                ]
        
        return results
    
    async def record_custom_metric(
        self,
        metric_name: str,
        value: float,
        labels: Optional[Dict[str, str]] = None
    ) -> Dict[str, str]:
        """
        Record a custom metric.
        
        Args:
            metric_name: Name of the metric
            value: Metric value
            labels: Optional labels
            
        Returns:
            Confirmation message
        """
        point = MetricPoint(
            name=metric_name,
            value=value,
            labels=labels or {}
        )
        
        self._custom_metrics[metric_name].append(point)
        
        # Also store in database for persistence
        await self._store_metric_in_db(point)
        
        return {"status": "recorded", "metric": metric_name}
    
    async def metrics_summary(self) -> Dict[str, Any]:
        """
        Get a summary of key metrics.
        
        Returns:
            Dictionary with metric summaries
        """
        async with get_db_connection() as db:
            # Get request stats
            request_stats = await db.fetchrow("""
                SELECT 
                    COUNT(*) as total_requests,
                    AVG(execution_time) as avg_latency,
                    COUNT(DISTINCT user_id) as unique_users,
                    COUNT(DISTINCT session_id) as total_sessions
                FROM queries
                WHERE created_at > NOW() - INTERVAL '24 hours'
            """)
            
            # Get model usage
            model_usage = await db.fetch("""
                SELECT 
                    unnest(models_used) as model,
                    COUNT(*) as usage_count
                FROM queries
                WHERE created_at > NOW() - INTERVAL '24 hours'
                GROUP BY model
                ORDER BY usage_count DESC
                LIMIT 10
            """)
            
            # Get error rate
            error_stats = await db.fetchrow("""
                SELECT 
                    COUNT(*) FILTER (WHERE response->>'error' IS NOT NULL) as error_count,
                    COUNT(*) as total_count
                FROM queries
                WHERE created_at > NOW() - INTERVAL '1 hour'
            """)
        
        error_rate = (
            error_stats['error_count'] / error_stats['total_count'] 
            if error_stats['total_count'] > 0 else 0
        )
        
        return {
            "timestamp": datetime.utcnow().isoformat(),
            "period": "24h",
            "requests": {
                "total": request_stats['total_requests'],
                "avg_latency_ms": round(request_stats['avg_latency'] * 1000, 2) if request_stats['avg_latency'] else 0,
                "unique_users": request_stats['unique_users'],
                "total_sessions": request_stats['total_sessions'],
                "error_rate": round(error_rate * 100, 2)
            },
            "models": {
                model['model']: model['usage_count'] 
                for model in model_usage
            },
            "system": await self._get_system_summary()
        }
    
    async def _update_system_metrics(self):
        """Update system resource metrics."""
        import psutil
        
        # CPU usage
        self.cpu_usage.set(psutil.cpu_percent(interval=0.1))
        
        # Memory usage
        memory = psutil.virtual_memory()
        self.memory_usage.set(memory.used)
        
        # Disk usage
        for partition in psutil.disk_partitions():
            if partition.mountpoint:
                usage = psutil.disk_usage(partition.mountpoint)
                self.disk_usage.labels(mount_point=partition.mountpoint).set(usage.percent)
        
        # Database connections
        try:
            async with get_db_connection() as db:
                conn_stats = await db.fetchrow("""
                    SELECT 
                        COUNT(*) FILTER (WHERE state = 'active') as active,
                        COUNT(*) FILTER (WHERE state = 'idle') as idle,
                        COUNT(*) FILTER (WHERE state = 'idle in transaction') as idle_in_transaction
                    FROM pg_stat_activity
                    WHERE datname = current_database()
                """)
                
                self.db_connections.labels(state='active').set(conn_stats['active'])
                self.db_connections.labels(state='idle').set(conn_stats['idle'])
                self.db_connections.labels(state='idle_in_transaction').set(conn_stats['idle_in_transaction'])
        except Exception:
            pass
    
    async def _get_system_summary(self) -> Dict[str, Any]:
        """Get system resource summary."""
        import psutil
        
        cpu_percent = psutil.cpu_percent(interval=0.1)
        memory = psutil.virtual_memory()
        disk = psutil.disk_usage('/')
        
        return {
            "cpu_percent": cpu_percent,
            "memory": {
                "used_gb": round(memory.used / (1024**3), 2),
                "total_gb": round(memory.total / (1024**3), 2),
                "percent": memory.percent
            },
            "disk": {
                "used_gb": round(disk.used / (1024**3), 2),
                "total_gb": round(disk.total / (1024**3), 2),
                "percent": disk.percent
            }
        }
    
    async def _store_metric_in_db(self, point: MetricPoint):
        """Store metric in database."""
        try:
            async with get_db_connection() as db:
                await db.execute("""
                    INSERT INTO metrics (metric_name, metric_value, tags, timestamp)
                    VALUES ($1, $2, $3, $4)
                """, point.name, point.value, point.labels, point.timestamp)
        except Exception:
            # Don't fail if DB write fails
            pass
    
    def _clean_old_metrics(self):
        """Remove metrics older than retention period."""
        cutoff = datetime.utcnow() - timedelta(hours=self._retention_hours)
        
        for name in list(self._custom_metrics.keys()):
            self._custom_metrics[name] = [
                p for p in self._custom_metrics[name]
                if p.timestamp > cutoff
            ]
            
            # Remove empty lists
            if not self._custom_metrics[name]:
                del self._custom_metrics[name]
    
    # Decorator methods for easy metric collection
    def track_request(self, method: str, endpoint: str):
        """Decorator to track request metrics."""
        def decorator(func):
            async def wrapper(*args, **kwargs):
                start_time = time.time()
                status = "success"
                
                try:
                    result = await func(*args, **kwargs)
                    return result
                except Exception as e:
                    status = "error"
                    raise
                finally:
                    duration = time.time() - start_time
                    self.request_count.labels(
                        method=method,
                        endpoint=endpoint,
                        status=status
                    ).inc()
                    self.request_duration.labels(
                        method=method,
                        endpoint=endpoint
                    ).observe(duration)
            
            return wrapper
        return decorator
    
    def track_model_call(self, model: str, chain_type: str = "default"):
        """Decorator to track model metrics."""
        def decorator(func):
            async def wrapper(*args, **kwargs):
                start_time = time.time()
                
                self.model_requests.labels(
                    model=model,
                    chain_type=chain_type
                ).inc()
                
                try:
                    result = await func(*args, **kwargs)
                    return result
                except Exception as e:
                    self.model_errors.labels(
                        model=model,
                        error_type=type(e).__name__
                    ).inc()
                    raise
                finally:
                    duration = time.time() - start_time
                    self.model_latency.labels(model=model).observe(duration)
            
            return wrapper
        return decorator


# Create singleton instance
metrics_collector = MetricsCollector()