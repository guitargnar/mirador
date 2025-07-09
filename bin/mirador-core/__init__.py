"""
Mirador Core Library
====================

A unified library for all Mirador ecosystem components.

This package provides shared functionality across all Mirador tools:
- Error handling with circuit breakers and fallbacks
- Configuration management
- Data persistence and session management
- Dashboard frameworks (terminal and web)
- Integration utilities
- Common utilities and helpers

Version: 2.0.0
"""

__version__ = "2.0.0"
__author__ = "User"

# Core components
from . import core
from . import dashboards
from . import integrations
from . import utils

__all__ = [
    "core",
    "dashboards", 
    "integrations",
    "utils",
    "__version__"
]