"""
Configuration classes for Mirador SDK
"""
from typing import Optional, List, Dict, Any
from dataclasses import dataclass, field


@dataclass
class RetryConfig:
    """Configuration for request retries"""
    max_retries: int = 3
    backoff_factor: float = 2.0
    retry_on: List[int] = field(default_factory=lambda: [500, 502, 503, 504])
    max_backoff: float = 60.0
    

@dataclass
class ClientConfig:
    """Configuration for Mirador client"""
    api_key: Optional[str] = None
    jwt_token: Optional[str] = None
    base_url: str = "http://localhost:5000"
    timeout: float = 30.0
    streaming_timeout: float = 300.0
    headers: Dict[str, str] = field(default_factory=dict)
    retry_config: RetryConfig = field(default_factory=RetryConfig)
    verify_ssl: bool = True
    proxies: Optional[Dict[str, str]] = None
    
    def __post_init__(self):
        """Validate configuration"""
        if not self.api_key and not self.jwt_token:
            raise ValueError("Either api_key or jwt_token must be provided")
        
        if self.api_key and self.jwt_token:
            raise ValueError("Cannot use both api_key and jwt_token authentication")
        
        # Ensure base_url doesn't end with slash
        self.base_url = self.base_url.rstrip("/")
        
        # Add default headers
        if "User-Agent" not in self.headers:
            self.headers["User-Agent"] = "Mirador-Python-SDK/0.1.0"
        
        if "Accept" not in self.headers:
            self.headers["Accept"] = "application/json"