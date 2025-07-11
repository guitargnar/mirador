"""
GraphQL-specific error handling

Provides enhanced error formatting and handling for GraphQL endpoints
"""
from typing import Dict, Any, Optional, List
from graphql import GraphQLError
from flask import current_app
import traceback

from ..core.exceptions import APIError, ErrorCode


class GraphQLAPIError(GraphQLError):
    """Enhanced GraphQL error with API error code support"""
    
    def __init__(
        self,
        message: str,
        code: Optional[str] = None,
        details: Optional[Dict[str, Any]] = None,
        nodes=None,
        source=None,
        positions=None,
        path=None,
        original_error=None,
        extensions=None
    ):
        """Initialize GraphQL API error"""
        if extensions is None:
            extensions = {}
            
        if code:
            extensions['code'] = code
            
        if details:
            extensions['details'] = details
            
        super().__init__(
            message,
            nodes=nodes,
            source=source,
            positions=positions,
            path=path,
            original_error=original_error,
            extensions=extensions
        )


def format_graphql_error(error: GraphQLError) -> Dict[str, Any]:
    """Format GraphQL error for response"""
    formatted = {
        'message': str(error),
        'path': error.path,
        'locations': [
            {'line': loc.line, 'column': loc.column}
            for loc in (error.locations or [])
        ] if error.locations else None
    }
    
    # Add extensions
    if hasattr(error, 'extensions') and error.extensions:
        formatted['extensions'] = error.extensions
    
    # Handle original API errors
    if hasattr(error, 'original_error') and error.original_error:
        original = error.original_error
        if isinstance(original, APIError):
            formatted['extensions'] = {
                'code': original.code,
                'details': original.details
            }
    
    # Add stack trace in development
    if current_app.debug and hasattr(error, 'original_error'):
        formatted['extensions'] = formatted.get('extensions', {})
        formatted['extensions']['stacktrace'] = traceback.format_exception(
            type(error.original_error),
            error.original_error,
            error.original_error.__traceback__
        )
    
    return formatted


def handle_graphql_errors(errors: List[GraphQLError]) -> List[Dict[str, Any]]:
    """Handle multiple GraphQL errors"""
    return [format_graphql_error(error) for error in errors]


def convert_api_error_to_graphql(api_error: APIError) -> GraphQLAPIError:
    """Convert API error to GraphQL error"""
    return GraphQLAPIError(
        message=api_error.message,
        code=api_error.code,
        details=api_error.details,
        original_error=api_error
    )


class GraphQLErrorHandler:
    """GraphQL error handler"""
    
    @staticmethod
    def authentication_error(message: str = "Authentication required") -> GraphQLAPIError:
        """Create authentication error"""
        return GraphQLAPIError(
            message=message,
            code=ErrorCode.AUTHENTICATION_REQUIRED.value
        )
    
    @staticmethod
    def authorization_error(message: str = "Insufficient permissions") -> GraphQLAPIError:
        """Create authorization error"""
        return GraphQLAPIError(
            message=message,
            code=ErrorCode.INSUFFICIENT_PERMISSIONS.value
        )
    
    @staticmethod
    def validation_error(field: str, message: str) -> GraphQLAPIError:
        """Create validation error"""
        return GraphQLAPIError(
            message=f"Validation error on field '{field}': {message}",
            code=ErrorCode.VALIDATION_ERROR.value,
            details={'field': field, 'error': message}
        )
    
    @staticmethod
    def not_found_error(resource: str, id: str) -> GraphQLAPIError:
        """Create not found error"""
        return GraphQLAPIError(
            message=f"{resource} with id '{id}' not found",
            code=ErrorCode.RESOURCE_NOT_FOUND.value,
            details={'resource': resource, 'id': id}
        )
    
    @staticmethod
    def rate_limit_error(limit: int, window: str) -> GraphQLAPIError:
        """Create rate limit error"""
        return GraphQLAPIError(
            message=f"Rate limit exceeded: {limit} requests per {window}",
            code=ErrorCode.RATE_LIMIT_EXCEEDED.value,
            details={'limit': limit, 'window': window}
        )
    
    @staticmethod
    def server_error(message: str = "Internal server error") -> GraphQLAPIError:
        """Create server error"""
        return GraphQLAPIError(
            message=message,
            code=ErrorCode.INTERNAL_ERROR.value
        )