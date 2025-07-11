"""
Main FastAPI application with monitoring integration.
"""
import asyncio
from contextlib import asynccontextmanager

from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.middleware.gzip import GZipMiddleware
from fastapi.responses import JSONResponse

from .monitoring import health_check, metrics_collector, MonitoringService
from .middleware import AuthenticationMiddleware, RateLimitMiddleware
from .routers import api_router
from .websocket import websocket_router
from .graphql import graphql_app
from .config import settings


# Create monitoring service
monitoring_service = MonitoringService()


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Manage application lifecycle."""
    # Startup
    print("Starting Mirador API v5...")
    
    # Start monitoring service
    await monitoring_service.start()
    
    yield
    
    # Shutdown
    print("Shutting down Mirador API...")
    await monitoring_service.stop()


# Create FastAPI app
app = FastAPI(
    title="Mirador API",
    description="Production-ready API for Mirador AI Framework",
    version="5.0.0",
    docs_url="/api/v5/docs",
    redoc_url="/api/v5/redoc",
    openapi_url="/api/v5/openapi.json",
    lifespan=lifespan
)

# Add middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.add_middleware(GZipMiddleware, minimum_size=1000)
app.add_middleware(AuthenticationMiddleware)
app.add_middleware(RateLimitMiddleware)

# Add exception handler
@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    """Handle uncaught exceptions."""
    return JSONResponse(
        status_code=500,
        content={
            "error": "Internal server error",
            "message": str(exc) if settings.DEBUG else "An error occurred",
            "request_id": getattr(request.state, "request_id", None)
        }
    )

# Mount routers
app.include_router(api_router, prefix="/api/v5")
app.include_router(websocket_router, prefix="/api/v5/ws")
app.include_router(health_check.router, prefix="/api/v5")
app.include_router(metrics_collector.router, prefix="/api/v5")

# Mount GraphQL
app.mount("/api/v5/graphql", graphql_app)

# Root endpoint
@app.get("/")
async def root():
    """Root endpoint."""
    return {
        "name": "Mirador API",
        "version": "5.0.0",
        "status": "running",
        "docs": "/api/v5/docs",
        "health": "/api/v5/health",
        "metrics": "/api/v5/metrics"
    }

# Add startup event
@app.on_event("startup")
async def startup_event():
    """Additional startup tasks."""
    # Initialize database connections
    # Warm up models
    # Load caches
    pass

# Add shutdown event
@app.on_event("shutdown")
async def shutdown_event():
    """Cleanup tasks."""
    # Close database connections
    # Clear caches
    # Save state
    pass


if __name__ == "__main__":
    import uvicorn
    
    uvicorn.run(
        "app:app",
        host="0.0.0.0",
        port=5000,
        reload=settings.DEBUG,
        workers=1 if settings.DEBUG else settings.WORKERS,
        log_config={
            "version": 1,
            "disable_existing_loggers": False,
            "formatters": {
                "default": {
                    "format": "%(asctime)s - %(name)s - %(levelname)s - %(message)s",
                },
                "json": {
                    "format": "%(asctime)s %(name)s %(levelname)s %(message)s",
                    "class": "pythonjsonlogger.jsonlogger.JsonFormatter"
                }
            },
            "handlers": {
                "default": {
                    "formatter": "json" if settings.LOG_FORMAT == "json" else "default",
                    "class": "logging.StreamHandler",
                    "stream": "ext://sys.stdout"
                }
            },
            "root": {
                "level": settings.LOG_LEVEL.upper(),
                "handlers": ["default"]
            }
        }
    )