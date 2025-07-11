"""
Health check endpoints for monitoring API status.
"""
import asyncio
import time
from typing import Dict, List, Optional, Any
from datetime import datetime
from enum import Enum

from fastapi import APIRouter, Response, status
from pydantic import BaseModel, Field

from ..database import get_db_connection
from ..cache import redis_client
from ..models import check_model_availability


class HealthStatus(str, Enum):
    """Health status levels."""
    HEALTHY = "healthy"
    DEGRADED = "degraded"
    UNHEALTHY = "unhealthy"


class ComponentHealth(BaseModel):
    """Health status of a single component."""
    name: str
    status: HealthStatus
    response_time_ms: Optional[float] = None
    details: Optional[Dict[str, Any]] = None
    error: Optional[str] = None


class HealthCheckResponse(BaseModel):
    """Overall health check response."""
    status: HealthStatus
    timestamp: datetime = Field(default_factory=datetime.utcnow)
    version: str = "5.0.0"
    uptime_seconds: float
    components: List[ComponentHealth]
    metadata: Optional[Dict[str, Any]] = None


class HealthCheckEndpoint:
    """Health check endpoint implementation."""
    
    def __init__(self):
        self.start_time = time.time()
        self.router = APIRouter(tags=["health"])
        self._setup_routes()
    
    def _setup_routes(self):
        """Configure health check routes."""
        self.router.get("/health", response_model=HealthCheckResponse)(self.health_check)
        self.router.get("/health/live")(self.liveness_check)
        self.router.get("/health/ready")(self.readiness_check)
    
    async def health_check(self, detailed: bool = False) -> HealthCheckResponse:
        """
        Comprehensive health check.
        
        Args:
            detailed: Include detailed component information
            
        Returns:
            HealthCheckResponse with overall system health
        """
        components = await self._check_all_components(detailed)
        
        # Determine overall status
        statuses = [c.status for c in components]
        if all(s == HealthStatus.HEALTHY for s in statuses):
            overall_status = HealthStatus.HEALTHY
        elif any(s == HealthStatus.UNHEALTHY for s in statuses):
            overall_status = HealthStatus.UNHEALTHY
        else:
            overall_status = HealthStatus.DEGRADED
        
        return HealthCheckResponse(
            status=overall_status,
            uptime_seconds=time.time() - self.start_time,
            components=components,
            metadata={
                "environment": "production",
                "region": "us-east-1",
                "instance_id": "api-001"
            } if detailed else None
        )
    
    async def liveness_check(self, response: Response) -> Dict[str, str]:
        """
        Kubernetes liveness probe.
        
        Returns 200 if the service is alive, 503 otherwise.
        """
        try:
            # Basic check - can we respond?
            return {"status": "alive"}
        except Exception:
            response.status_code = status.HTTP_503_SERVICE_UNAVAILABLE
            return {"status": "dead"}
    
    async def readiness_check(self, response: Response) -> Dict[str, str]:
        """
        Kubernetes readiness probe.
        
        Returns 200 if ready to serve traffic, 503 otherwise.
        """
        # Check critical components
        checks = await asyncio.gather(
            self._check_database(),
            self._check_redis(),
            return_exceptions=True
        )
        
        if all(isinstance(c, ComponentHealth) and c.status == HealthStatus.HEALTHY 
               for c in checks if isinstance(c, ComponentHealth)):
            return {"status": "ready"}
        else:
            response.status_code = status.HTTP_503_SERVICE_UNAVAILABLE
            return {"status": "not ready"}
    
    async def _check_all_components(self, detailed: bool) -> List[ComponentHealth]:
        """Check all system components."""
        # Run checks concurrently
        checks = await asyncio.gather(
            self._check_api(),
            self._check_database(),
            self._check_redis(),
            self._check_models(),
            self._check_disk_space(),
            self._check_memory(),
            return_exceptions=True
        )
        
        components = []
        for check in checks:
            if isinstance(check, Exception):
                components.append(ComponentHealth(
                    name="unknown",
                    status=HealthStatus.UNHEALTHY,
                    error=str(check)
                ))
            elif isinstance(check, ComponentHealth):
                components.append(check)
        
        return components
    
    async def _check_api(self) -> ComponentHealth:
        """Check API service health."""
        start = time.time()
        
        return ComponentHealth(
            name="api",
            status=HealthStatus.HEALTHY,
            response_time_ms=(time.time() - start) * 1000,
            details={"version": "5.0.0", "environment": "production"}
        )
    
    async def _check_database(self) -> ComponentHealth:
        """Check database connectivity."""
        start = time.time()
        
        try:
            async with get_db_connection() as db:
                result = await db.fetchval("SELECT 1")
                if result == 1:
                    return ComponentHealth(
                        name="database",
                        status=HealthStatus.HEALTHY,
                        response_time_ms=(time.time() - start) * 1000
                    )
        except Exception as e:
            return ComponentHealth(
                name="database",
                status=HealthStatus.UNHEALTHY,
                response_time_ms=(time.time() - start) * 1000,
                error=str(e)
            )
    
    async def _check_redis(self) -> ComponentHealth:
        """Check Redis connectivity."""
        start = time.time()
        
        try:
            await redis_client.ping()
            info = await redis_client.info()
            
            return ComponentHealth(
                name="redis",
                status=HealthStatus.HEALTHY,
                response_time_ms=(time.time() - start) * 1000,
                details={
                    "version": info.get("redis_version"),
                    "connected_clients": info.get("connected_clients"),
                    "used_memory_human": info.get("used_memory_human")
                }
            )
        except Exception as e:
            return ComponentHealth(
                name="redis",
                status=HealthStatus.UNHEALTHY,
                response_time_ms=(time.time() - start) * 1000,
                error=str(e)
            )
    
    async def _check_models(self) -> ComponentHealth:
        """Check model availability."""
        start = time.time()
        
        try:
            available_models = await check_model_availability()
            
            if len(available_models) == 0:
                status = HealthStatus.UNHEALTHY
            elif len(available_models) < 10:  # Expected minimum
                status = HealthStatus.DEGRADED
            else:
                status = HealthStatus.HEALTHY
            
            return ComponentHealth(
                name="models",
                status=status,
                response_time_ms=(time.time() - start) * 1000,
                details={
                    "available_count": len(available_models),
                    "models": available_models[:5]  # First 5
                }
            )
        except Exception as e:
            return ComponentHealth(
                name="models",
                status=HealthStatus.UNHEALTHY,
                response_time_ms=(time.time() - start) * 1000,
                error=str(e)
            )
    
    async def _check_disk_space(self) -> ComponentHealth:
        """Check available disk space."""
        import psutil
        
        try:
            disk = psutil.disk_usage('/')
            
            if disk.percent > 90:
                status = HealthStatus.UNHEALTHY
            elif disk.percent > 80:
                status = HealthStatus.DEGRADED
            else:
                status = HealthStatus.HEALTHY
            
            return ComponentHealth(
                name="disk_space",
                status=status,
                details={
                    "total_gb": round(disk.total / (1024**3), 2),
                    "used_gb": round(disk.used / (1024**3), 2),
                    "free_gb": round(disk.free / (1024**3), 2),
                    "percent_used": disk.percent
                }
            )
        except Exception as e:
            return ComponentHealth(
                name="disk_space",
                status=HealthStatus.UNHEALTHY,
                error=str(e)
            )
    
    async def _check_memory(self) -> ComponentHealth:
        """Check memory usage."""
        import psutil
        
        try:
            memory = psutil.virtual_memory()
            
            if memory.percent > 90:
                status = HealthStatus.UNHEALTHY
            elif memory.percent > 80:
                status = HealthStatus.DEGRADED
            else:
                status = HealthStatus.HEALTHY
            
            return ComponentHealth(
                name="memory",
                status=status,
                details={
                    "total_gb": round(memory.total / (1024**3), 2),
                    "used_gb": round(memory.used / (1024**3), 2),
                    "available_gb": round(memory.available / (1024**3), 2),
                    "percent_used": memory.percent
                }
            )
        except Exception as e:
            return ComponentHealth(
                name="memory",
                status=HealthStatus.UNHEALTHY,
                error=str(e)
            )


# Create singleton instance
health_check = HealthCheckEndpoint()