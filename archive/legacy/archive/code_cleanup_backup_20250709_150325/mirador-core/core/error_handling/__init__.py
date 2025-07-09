"""
Error Handling Module
====================

Provides comprehensive error handling with circuit breakers,
fallback mechanisms, and input/output sanitization.
"""

from .error_handler import (
    ErrorHandler,
    CircuitBreaker,
    FallbackManager,
    InputSanitizer,
    OutputSanitizer,
    SafeExecutor,
    ErrorRecovery,
    create_error_handler
)

__all__ = [
    "ErrorHandler",
    "CircuitBreaker",
    "FallbackManager",
    "InputSanitizer",
    "OutputSanitizer",
    "SafeExecutor",
    "ErrorRecovery",
    "create_error_handler"
]