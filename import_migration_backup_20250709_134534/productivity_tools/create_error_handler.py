#!/usr/bin/env python3
"""
Centralized error handling and logging utilities for Mirador.
Provides consistent error handling across all modules.
"""

import logging
import traceback
import functools
import json
import os
from typing import Any, Callable, Optional, Dict
from datetime import datetime


class MiradorError(Exception):
    """Base exception class for Mirador-specific errors."""
    def __init__(self, message: str, error_code: Optional[str] = None, details: Optional[Dict] = None):
        super().__init__(message)
        self.error_code = error_code
        self.details = details or {}
        self.timestamp = datetime.utcnow()


class ConfigurationError(MiradorError):
    """Raised when configuration is invalid or missing."""
    pass


class ModelError(MiradorError):
    """Raised when AI model operations fail."""
    pass


class DataError(MiradorError):
    """Raised when data processing fails."""
    pass


class ErrorHandler:
    """Centralized error handling for Mirador framework."""
    
    def __init__(self, log_dir: str = "ai_framework/logs"):
        self.log_dir = log_dir
        os.makedirs(log_dir, exist_ok=True)
        
        # Configure error logger
        self.error_logger = logging.getLogger("mirador.errors")
        error_handler = logging.FileHandler(
            os.path.join(log_dir, f"errors_{datetime.now().strftime('%Y%m%d')}.log")
        )
        error_handler.setFormatter(
            logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        )
        self.error_logger.addHandler(error_handler)
        self.error_logger.setLevel(logging.ERROR)
    
    def log_error(self, error: Exception, context: Optional[Dict] = None) -> None:
        """Log error with context information."""
        error_data = {
            "error_type": type(error).__name__,
            "error_message": str(error),
            "traceback": traceback.format_exc(),
            "context": context or {},
            "timestamp": datetime.utcnow().isoformat()
        }
        
        if isinstance(error, MiradorError):
            error_data["error_code"] = error.error_code
            error_data["details"] = error.details
        
        self.error_logger.error(json.dumps(error_data, indent=2))
    
    def handle_with_retry(self, func: Callable, max_retries: int = 3, 
                         delay: float = 1.0, backoff: float = 2.0) -> Callable:
        """Decorator to add retry logic with exponential backoff."""
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            last_error = None
            current_delay = delay
            
            for attempt in range(max_retries):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    last_error = e
                    self.log_error(e, {"attempt": attempt + 1, "function": func.__name__})
                    
                    if attempt < max_retries - 1:
                        time.sleep(current_delay)
                        current_delay *= backoff
                    else:
                        raise
            
            raise last_error
        
        return wrapper
    
    def safe_execute(self, func: Callable, default: Any = None, 
                    log_errors: bool = True) -> Callable:
        """Decorator to safely execute functions with error handling."""
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            try:
                return func(*args, **kwargs)
            except Exception as e:
                if log_errors:
                    self.log_error(e, {"function": func.__name__})
                return default
        
        return wrapper


# Global error handler instance
error_handler = ErrorHandler()


# Utility decorators
def with_error_handling(error_type: type = Exception, 
                        message: str = "Operation failed",
                        log: bool = True):
    """Decorator to add consistent error handling to functions."""
    def decorator(func: Callable) -> Callable:
        @functools.wraps(func)
        def wrapper(*args, **kwargs):
            try:
                return func(*args, **kwargs)
            except error_type as e:
                if log:
                    error_handler.log_error(e, {"function": func.__name__})
                raise MiradorError(f"{message}: {str(e)}")
        return wrapper
    return decorator


def retry_on_error(max_retries: int = 3, delay: float = 1.0):
    """Decorator to retry function on error."""
    def decorator(func: Callable) -> Callable:
        return error_handler.handle_with_retry(func, max_retries, delay)
    return decorator
