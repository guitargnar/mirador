"""
Configuration settings for Mirador API
"""
import os
from typing import List, Dict, Any, Optional
from pathlib import Path


class Settings:
    """API configuration settings"""
    
    # Basic settings
    PROJECT_NAME: str = "Mirador AI Orchestration API"
    VERSION: str = "5.0.0"
    API_V5_PREFIX: str = "/api/v5"
    DEBUG: bool = os.getenv("DEBUG", "False").lower() == "true"
    
    # Security
    SECRET_KEY: str = os.getenv("SECRET_KEY", "your-secret-key-change-this")
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    API_KEY_LENGTH: int = 32
    
    # Database
    DATABASE_URL: str = os.getenv(
        "DATABASE_URL",
        "sqlite:///./mirador_api.db"
    )
    
    # Redis settings
    REDIS_URL: str = os.getenv("REDIS_URL", "redis://localhost:6379/0")
    REDIS_MAX_CONNECTIONS: int = int(os.getenv("REDIS_MAX_CONNECTIONS", "50"))
    
    # Cache settings
    CACHE_ENABLED: bool = os.getenv("CACHE_ENABLED", "True").lower() == "true"
    CACHE_KEY_PREFIX: str = os.getenv("CACHE_KEY_PREFIX", "mirador")
    CACHE_DEFAULT_TTL: int = int(os.getenv("CACHE_DEFAULT_TTL", "3600"))  # 1 hour
    
    # Cache TTL settings (in seconds)
    CACHE_TTL_QUERY: int = int(os.getenv("CACHE_TTL_QUERY", "3600"))  # 1 hour
    CACHE_TTL_CHAIN: int = int(os.getenv("CACHE_TTL_CHAIN", "1800"))  # 30 minutes
    CACHE_TTL_MODEL: int = int(os.getenv("CACHE_TTL_MODEL", "900"))   # 15 minutes
    CACHE_TTL_SESSION: int = int(os.getenv("CACHE_TTL_SESSION", "86400"))  # 24 hours
    
    # Cache warmup settings
    CACHE_WARMUP_ENABLED: bool = os.getenv("CACHE_WARMUP_ENABLED", "True").lower() == "true"
    CACHE_WARMUP_INTERVAL: int = int(os.getenv("CACHE_WARMUP_INTERVAL", "3600"))  # 1 hour
    CACHE_WARMUP_QUERIES: List[Dict[str, Any]] = [
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
            "query": "How can I improve my work-life balance?",
            "chain_type": "life_optimization",
            "format": "summary"
        },
        {
            "query": "What's a good strategy for business growth?",
            "chain_type": "business_acceleration",
            "format": "summary"
        },
        {
            "query": "Help me with a creative solution",
            "chain_type": "creative_breakthrough",
            "format": "quick"
        }
    ]
    
    # Rate limiting
    RATE_LIMIT_ENABLED: bool = os.getenv("RATE_LIMIT_ENABLED", "True").lower() == "true"
    RATE_LIMIT_DEFAULT: str = os.getenv("RATE_LIMIT_DEFAULT", "100/hour")
    RATE_LIMIT_STORAGE_URL: str = os.getenv("RATE_LIMIT_STORAGE_URL", REDIS_URL)
    
    # CORS
    CORS_ORIGINS: List[str] = os.getenv(
        "CORS_ORIGINS",
        "http://localhost:3000,http://localhost:5173"
    ).split(",")
    
    # Logging
    LOG_LEVEL: str = os.getenv("LOG_LEVEL", "INFO")
    LOG_FORMAT: str = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    LOG_DIR: Path = Path("logs")
    
    # Model settings
    OLLAMA_HOST: str = os.getenv("OLLAMA_HOST", "http://localhost:11434")
    MODEL_TIMEOUT: int = int(os.getenv("MODEL_TIMEOUT", "120"))  # 2 minutes
    MODEL_MAX_RETRIES: int = int(os.getenv("MODEL_MAX_RETRIES", "3"))
    
    # WebSocket settings
    WEBSOCKET_PING_INTERVAL: int = int(os.getenv("WEBSOCKET_PING_INTERVAL", "30"))
    WEBSOCKET_PING_TIMEOUT: int = int(os.getenv("WEBSOCKET_PING_TIMEOUT", "10"))
    WEBSOCKET_MAX_MESSAGE_SIZE: int = int(os.getenv("WEBSOCKET_MAX_MESSAGE_SIZE", "10485760"))  # 10MB
    
    # SSE settings
    SSE_RETRY_TIMEOUT: int = int(os.getenv("SSE_RETRY_TIMEOUT", "3000"))  # milliseconds
    SSE_PING_INTERVAL: int = int(os.getenv("SSE_PING_INTERVAL", "30"))  # seconds
    
    # Session settings
    SESSION_LIFETIME: int = int(os.getenv("SESSION_LIFETIME", "86400"))  # 24 hours
    SESSION_CLEANUP_INTERVAL: int = int(os.getenv("SESSION_CLEANUP_INTERVAL", "3600"))  # 1 hour
    
    # Health check
    HEALTH_CHECK_INTERVAL: int = int(os.getenv("HEALTH_CHECK_INTERVAL", "60"))  # 1 minute
    
    # Performance settings
    MAX_WORKERS: int = int(os.getenv("MAX_WORKERS", "4"))
    WORKER_TIMEOUT: int = int(os.getenv("WORKER_TIMEOUT", "300"))  # 5 minutes
    GRACEFUL_TIMEOUT: int = int(os.getenv("GRACEFUL_TIMEOUT", "30"))
    
    # Feature flags
    ENABLE_METRICS: bool = os.getenv("ENABLE_METRICS", "True").lower() == "true"
    ENABLE_TRACING: bool = os.getenv("ENABLE_TRACING", "False").lower() == "true"
    ENABLE_PROFILING: bool = os.getenv("ENABLE_PROFILING", "False").lower() == "true"
    
    @property
    def redis_settings(self) -> Dict[str, Any]:
        """Get Redis connection settings"""
        return {
            "url": self.REDIS_URL,
            "max_connections": self.REDIS_MAX_CONNECTIONS,
            "decode_responses": True,
            "health_check_interval": 30
        }
    
    @property
    def cache_settings(self) -> Dict[str, Any]:
        """Get cache settings"""
        return {
            "enabled": self.CACHE_ENABLED,
            "key_prefix": self.CACHE_KEY_PREFIX,
            "default_ttl": self.CACHE_DEFAULT_TTL,
            "ttls": {
                "query": self.CACHE_TTL_QUERY,
                "chain": self.CACHE_TTL_CHAIN,
                "model": self.CACHE_TTL_MODEL,
                "session": self.CACHE_TTL_SESSION
            },
            "warmup": {
                "enabled": self.CACHE_WARMUP_ENABLED,
                "interval": self.CACHE_WARMUP_INTERVAL,
                "queries": self.CACHE_WARMUP_QUERIES
            }
        }
    
    class Config:
        """Pydantic config"""
        case_sensitive = True
        env_file = ".env"


# Create settings instance
settings = Settings()