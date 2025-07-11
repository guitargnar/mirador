"""
GraphQL module for Mirador API

Provides a GraphQL interface as an alternative to REST
"""
from .schema import schema
from .views import graphql_bp

__all__ = ['schema', 'graphql_bp']