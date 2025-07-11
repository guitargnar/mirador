"""
Exceptions for Mirador SDK
"""
from typing import Optional, Dict, Any


class MiradorError(Exception):
    """Base exception for all Mirador SDK errors"""
    
    def __init__(
        self,
        message: str,
        code: Optional[str] = None,
        status_code: Optional[int] = None,
        response: Optional[Dict[str, Any]] = None
    ):
        super().__init__(message)
        self.message = message
        self.code = code
        self.status_code = status_code
        self.response = response


class AuthenticationError(MiradorError):
    """Raised when authentication fails"""
    pass


class RateLimitError(MiradorError):
    """Raised when rate limit is exceeded"""
    
    def __init__(
        self,
        message: str,
        retry_after: Optional[int] = None,
        **kwargs
    ):
        super().__init__(message, **kwargs)
        self.retry_after = retry_after


class ValidationError(MiradorError):
    """Raised when request validation fails"""
    
    def __init__(
        self,
        message: str,
        field: Optional[str] = None,
        **kwargs
    ):
        super().__init__(message, **kwargs)
        self.field = field


class APIError(MiradorError):
    """Raised when API returns an error"""
    pass


class NetworkError(MiradorError):
    """Raised when network request fails"""
    pass


class TimeoutError(MiradorError):
    """Raised when request times out"""
    pass


class StreamingError(MiradorError):
    """Raised when streaming fails"""
    pass


class WebSocketError(MiradorError):
    """Raised when WebSocket connection fails"""
    pass


class ModelNotFoundError(MiradorError):
    """Raised when requested model is not found"""
    
    def __init__(self, model_name: str, **kwargs):
        message = f"Model '{model_name}' not found"
        super().__init__(message, **kwargs)
        self.model_name = model_name


class ChainNotFoundError(MiradorError):
    """Raised when requested chain is not found"""
    
    def __init__(self, chain_name: str, **kwargs):
        message = f"Chain '{chain_name}' not found"
        super().__init__(message, **kwargs)
        self.chain_name = chain_name


class SessionNotFoundError(MiradorError):
    """Raised when requested session is not found"""
    
    def __init__(self, session_id: str, **kwargs):
        message = f"Session '{session_id}' not found"
        super().__init__(message, **kwargs)
        self.session_id = session_id