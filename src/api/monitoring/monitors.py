"""
Specialized monitors for different system components.
"""
import asyncio
import subprocess
from typing import Dict, List, Optional, Any, Tuple
from datetime import datetime, timedelta
from abc import ABC, abstractmethod

import psutil
from pydantic import BaseModel, Field

from ..database import get_db_connection
from ..cache import redis_client
from .metrics import metrics_collector


class MonitorResult(BaseModel):
    """Result from a monitor check."""
    component: str
    status: str  # ok, warning, critical
    message: str
    metrics: Dict[str, Any] = Field(default_factory=dict)
    timestamp: datetime = Field(default_factory=datetime.utcnow)


class BaseMonitor(ABC):
    """Base class for component monitors."""
    
    def __init__(self, name: str):
        self.name = name
        self.check_interval = 60  # seconds
        self._running = False
    
    @abstractmethod
    async def check(self) -> MonitorResult:
        """Perform health check on component."""
        pass
    
    async def start(self):
        """Start continuous monitoring."""
        self._running = True
        while self._running:
            try:
                result = await self.check()
                await self._process_result(result)
            except Exception as e:
                print(f"Monitor {self.name} error: {e}")
            
            await asyncio.sleep(self.check_interval)
    
    def stop(self):
        """Stop monitoring."""
        self._running = False
    
    async def _process_result(self, result: MonitorResult):
        """Process monitor result."""
        # Record metrics
        for metric_name, value in result.metrics.items():
            await metrics_collector.record_custom_metric(
                f"monitor_{self.name}_{metric_name}",
                value,
                {"status": result.status}
            )
        
        # Log warnings/critical
        if result.status in ["warning", "critical"]:
            print(f"[{result.status.upper()}] {self.name}: {result.message}")


class SystemMonitor(BaseMonitor):
    """Monitor system resources."""
    
    def __init__(self):
        super().__init__("system")
        self.thresholds = {
            "cpu_warning": 80,
            "cpu_critical": 95,
            "memory_warning": 80,
            "memory_critical": 90,
            "disk_warning": 80,
            "disk_critical": 90
        }
    
    async def check(self) -> MonitorResult:
        """Check system resources."""
        # CPU check
        cpu_percent = psutil.cpu_percent(interval=1)
        
        # Memory check
        memory = psutil.virtual_memory()
        
        # Disk check
        disk = psutil.disk_usage('/')
        
        # Determine overall status
        status = "ok"
        messages = []
        
        if cpu_percent >= self.thresholds["cpu_critical"]:
            status = "critical"
            messages.append(f"CPU usage critical: {cpu_percent}%")
        elif cpu_percent >= self.thresholds["cpu_warning"]:
            status = "warning"
            messages.append(f"CPU usage high: {cpu_percent}%")
        
        if memory.percent >= self.thresholds["memory_critical"]:
            status = "critical"
            messages.append(f"Memory usage critical: {memory.percent}%")
        elif memory.percent >= self.thresholds["memory_warning"]:
            if status != "critical":
                status = "warning"
            messages.append(f"Memory usage high: {memory.percent}%")
        
        if disk.percent >= self.thresholds["disk_critical"]:
            status = "critical"
            messages.append(f"Disk usage critical: {disk.percent}%")
        elif disk.percent >= self.thresholds["disk_warning"]:
            if status != "critical":
                status = "warning"
            messages.append(f"Disk usage high: {disk.percent}%")
        
        return MonitorResult(
            component=self.name,
            status=status,
            message="; ".join(messages) if messages else "System resources normal",
            metrics={
                "cpu_percent": cpu_percent,
                "memory_percent": memory.percent,
                "memory_available_gb": memory.available / (1024**3),
                "disk_percent": disk.percent,
                "disk_free_gb": disk.free / (1024**3),
                "load_average": psutil.getloadavg()[0]
            }
        )


class ModelMonitor(BaseMonitor):
    """Monitor Ollama model availability and performance."""
    
    def __init__(self):
        super().__init__("models")
        self.required_models = [
            "matthew_context_provider_v5",
            "universal_strategy_architect_v4",
            "creative_catalyst_v4",
            "practical_implementer_v4"
        ]
    
    async def check(self) -> MonitorResult:
        """Check model availability."""
        try:
            # Get list of available models
            result = subprocess.run(
                ["ollama", "list"],
                capture_output=True,
                text=True,
                timeout=10
            )
            
            if result.returncode != 0:
                return MonitorResult(
                    component=self.name,
                    status="critical",
                    message="Failed to query Ollama models",
                    metrics={"available_models": 0}
                )
            
            # Parse available models
            available_models = []
            for line in result.stdout.strip().split('\n')[1:]:  # Skip header
                if line:
                    model_name = line.split()[0]
                    available_models.append(model_name)
            
            # Check required models
            missing_models = [
                model for model in self.required_models
                if not any(model in available for available in available_models)
            ]
            
            if missing_models:
                status = "warning" if len(missing_models) < len(self.required_models) else "critical"
                message = f"Missing models: {', '.join(missing_models)}"
            else:
                status = "ok"
                message = f"All required models available ({len(available_models)} total)"
            
            return MonitorResult(
                component=self.name,
                status=status,
                message=message,
                metrics={
                    "available_models": len(available_models),
                    "missing_models": len(missing_models),
                    "required_models": len(self.required_models)
                }
            )
            
        except subprocess.TimeoutExpired:
            return MonitorResult(
                component=self.name,
                status="critical",
                message="Ollama command timed out",
                metrics={"available_models": 0}
            )
        except Exception as e:
            return MonitorResult(
                component=self.name,
                status="critical",
                message=f"Model check failed: {str(e)}",
                metrics={"available_models": 0}
            )


class DatabaseMonitor(BaseMonitor):
    """Monitor database health and performance."""
    
    def __init__(self):
        super().__init__("database")
        self.slow_query_threshold = 1.0  # seconds
        self.connection_limit_warning = 80  # percent
    
    async def check(self) -> MonitorResult:
        """Check database health."""
        try:
            async with get_db_connection() as db:
                # Check connectivity
                start_time = datetime.utcnow()
                await db.fetchval("SELECT 1")
                ping_time = (datetime.utcnow() - start_time).total_seconds()
                
                # Check connection usage
                conn_info = await db.fetchrow("""
                    SELECT 
                        COUNT(*) as total_connections,
                        MAX(connections) as max_connections,
                        COUNT(*) FILTER (WHERE state = 'active') as active_connections
                    FROM pg_stat_activity
                    CROSS JOIN (
                        SELECT setting::int as connections 
                        FROM pg_settings 
                        WHERE name = 'max_connections'
                    ) s
                """)
                
                connection_percent = (
                    conn_info['total_connections'] / conn_info['max_connections'] * 100
                )
                
                # Check for slow queries
                slow_queries = await db.fetch("""
                    SELECT 
                        COUNT(*) as count,
                        MAX(EXTRACT(epoch FROM now() - query_start)) as max_duration
                    FROM pg_stat_activity
                    WHERE state = 'active' 
                    AND query_start < now() - interval '1 second'
                    AND query NOT ILIKE '%pg_stat_activity%'
                """)
                
                slow_query_count = slow_queries[0]['count'] if slow_queries else 0
                max_query_duration = slow_queries[0]['max_duration'] if slow_queries else 0
                
                # Check table sizes
                table_sizes = await db.fetch("""
                    SELECT 
                        schemaname,
                        tablename,
                        pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size,
                        pg_total_relation_size(schemaname||'.'||tablename) as size_bytes
                    FROM pg_tables
                    WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
                    ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC
                    LIMIT 5
                """)
                
                # Determine status
                status = "ok"
                messages = []
                
                if ping_time > 0.1:
                    status = "warning"
                    messages.append(f"High ping time: {ping_time:.3f}s")
                
                if connection_percent >= self.connection_limit_warning:
                    status = "warning"
                    messages.append(f"High connection usage: {connection_percent:.1f}%")
                
                if slow_query_count > 0:
                    if status != "critical":
                        status = "warning"
                    messages.append(f"{slow_query_count} slow queries (max: {max_query_duration:.1f}s)")
                
                return MonitorResult(
                    component=self.name,
                    status=status,
                    message="; ".join(messages) if messages else "Database healthy",
                    metrics={
                        "ping_ms": ping_time * 1000,
                        "total_connections": conn_info['total_connections'],
                        "active_connections": conn_info['active_connections'],
                        "connection_percent": connection_percent,
                        "slow_query_count": slow_query_count,
                        "max_query_duration_s": max_query_duration,
                        "largest_table_mb": table_sizes[0]['size_bytes'] / (1024*1024) if table_sizes else 0
                    }
                )
                
        except Exception as e:
            return MonitorResult(
                component=self.name,
                status="critical",
                message=f"Database check failed: {str(e)}",
                metrics={}
            )


class RedisMonitor(BaseMonitor):
    """Monitor Redis cache health and performance."""
    
    def __init__(self):
        super().__init__("redis")
        self.memory_warning_mb = 1024  # 1GB
        self.memory_critical_mb = 2048  # 2GB
    
    async def check(self) -> MonitorResult:
        """Check Redis health."""
        try:
            # Ping Redis
            start_time = datetime.utcnow()
            await redis_client.ping()
            ping_time = (datetime.utcnow() - start_time).total_seconds()
            
            # Get Redis info
            info = await redis_client.info()
            
            # Extract key metrics
            used_memory_mb = int(info.get('used_memory', 0)) / (1024*1024)
            connected_clients = int(info.get('connected_clients', 0))
            total_commands = int(info.get('total_commands_processed', 0))
            keyspace_hits = int(info.get('keyspace_hits', 0))
            keyspace_misses = int(info.get('keyspace_misses', 0))
            
            hit_rate = (
                keyspace_hits / (keyspace_hits + keyspace_misses) * 100
                if (keyspace_hits + keyspace_misses) > 0 else 0
            )
            
            # Check evicted keys
            evicted_keys = int(info.get('evicted_keys', 0))
            
            # Determine status
            status = "ok"
            messages = []
            
            if ping_time > 0.05:
                status = "warning"
                messages.append(f"High ping time: {ping_time:.3f}s")
            
            if used_memory_mb >= self.memory_critical_mb:
                status = "critical"
                messages.append(f"Critical memory usage: {used_memory_mb:.1f}MB")
            elif used_memory_mb >= self.memory_warning_mb:
                if status != "critical":
                    status = "warning"
                messages.append(f"High memory usage: {used_memory_mb:.1f}MB")
            
            if evicted_keys > 0:
                if status == "ok":
                    status = "warning"
                messages.append(f"Keys evicted: {evicted_keys}")
            
            if hit_rate < 80 and (keyspace_hits + keyspace_misses) > 1000:
                if status == "ok":
                    status = "warning"
                messages.append(f"Low hit rate: {hit_rate:.1f}%")
            
            return MonitorResult(
                component=self.name,
                status=status,
                message="; ".join(messages) if messages else "Redis healthy",
                metrics={
                    "ping_ms": ping_time * 1000,
                    "used_memory_mb": used_memory_mb,
                    "connected_clients": connected_clients,
                    "total_commands": total_commands,
                    "hit_rate_percent": hit_rate,
                    "evicted_keys": evicted_keys
                }
            )
            
        except Exception as e:
            return MonitorResult(
                component=self.name,
                status="critical",
                message=f"Redis check failed: {str(e)}",
                metrics={}
            )


class MonitoringService:
    """Service to manage all monitors."""
    
    def __init__(self):
        self.monitors = {
            "system": SystemMonitor(),
            "models": ModelMonitor(),
            "database": DatabaseMonitor(),
            "redis": RedisMonitor()
        }
        self._tasks = []
    
    async def start(self):
        """Start all monitors."""
        for name, monitor in self.monitors.items():
            task = asyncio.create_task(monitor.start())
            self._tasks.append(task)
            print(f"Started {name} monitor")
    
    async def stop(self):
        """Stop all monitors."""
        for monitor in self.monitors.values():
            monitor.stop()
        
        # Wait for tasks to complete
        await asyncio.gather(*self._tasks, return_exceptions=True)
    
    async def check_all(self) -> List[MonitorResult]:
        """Run all checks once and return results."""
        results = []
        for monitor in self.monitors.values():
            try:
                result = await monitor.check()
                results.append(result)
            except Exception as e:
                results.append(MonitorResult(
                    component=monitor.name,
                    status="critical",
                    message=f"Check failed: {str(e)}"
                ))
        
        return results