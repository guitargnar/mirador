"""
GraphQL views for Mirador API

Provides GraphQL endpoint with authentication and rate limiting
"""
import json
from flask import Blueprint, request, jsonify, g
from flask_graphql import GraphQLView
from graphql_server.flask import GraphQLView as AsyncGraphQLView
from graphene import Schema

from .schema import schema
from ..auth import require_auth
from ..middleware import rate_limit
from ..core.exceptions import APIError


# Create blueprint
graphql_bp = Blueprint('graphql', __name__)


class AuthenticatedGraphQLView(GraphQLView):
    """GraphQL view with authentication"""
    
    def get_context(self):
        """Add authentication context"""
        context = super().get_context()
        context['user'] = g.get('current_user')
        context['user_id'] = g.get('current_user', {}).get('id')
        context['session_id'] = g.get('session_id')
        return context
    
    @staticmethod
    def format_error(error):
        """Format GraphQL errors"""
        formatted = GraphQLView.format_error(error)
        
        # Add error code if available
        if hasattr(error, 'original_error'):
            original = error.original_error
            if isinstance(original, APIError):
                formatted['extensions'] = {
                    'code': original.code,
                    'details': original.details
                }
        
        return formatted


# Add GraphQL endpoint
graphql_view = AuthenticatedGraphQLView.as_view(
    'graphql',
    schema=schema,
    graphiql=True,  # Enable GraphiQL interface in development
    graphiql_version='1.0.0',
    graphiql_template=None,
    graphiql_html_title='Mirador GraphQL Explorer',
    batch=True  # Enable query batching
)

# Apply authentication and rate limiting
graphql_bp.add_url_rule(
    '/graphql',
    view_func=require_auth(['read'])(rate_limit()(graphql_view))
)


# Add introspection endpoint (for development)
@graphql_bp.route('/graphql/schema', methods=['GET'])
@require_auth(['read'])
def get_schema():
    """Get GraphQL schema for introspection"""
    from graphql import get_introspection_query, graphql_sync
    
    introspection_query = get_introspection_query()
    result = graphql_sync(schema.graphql_schema, introspection_query)
    
    return jsonify(result.data)


# Add subscription endpoint
@graphql_bp.route('/graphql/subscriptions', methods=['GET'])
@require_auth(['read', 'stream'])
def graphql_subscriptions():
    """WebSocket endpoint for GraphQL subscriptions"""
    from ..websocket import socketio
    from graphql import graphql, parse, subscribe
    import asyncio
    
    @socketio.on('graphql_subscribe')
    def handle_subscription(data):
        """Handle GraphQL subscription"""
        query = data.get('query')
        variables = data.get('variables', {})
        operation_name = data.get('operationName')
        
        # Parse and validate query
        try:
            document = parse(query)
        except Exception as e:
            socketio.emit('graphql_error', {
                'message': f'Query parsing failed: {str(e)}'
            })
            return
        
        # Create context
        context = {
            'user': g.current_user,
            'user_id': g.current_user.get('id'),
            'session_id': request.sid
        }
        
        # Execute subscription
        async def run_subscription():
            try:
                result = await subscribe(
                    schema.graphql_schema,
                    document,
                    root_value=None,
                    context_value=context,
                    variable_values=variables,
                    operation_name=operation_name
                )
                
                async for item in result:
                    if item.errors:
                        socketio.emit('graphql_error', {
                            'errors': [str(e) for e in item.errors]
                        })
                    else:
                        socketio.emit('graphql_data', {
                            'data': item.data
                        })
                        
            except Exception as e:
                socketio.emit('graphql_error', {
                    'message': f'Subscription failed: {str(e)}'
                })
        
        # Run subscription in background
        asyncio.create_task(run_subscription())
    
    return jsonify({
        'message': 'Connect via WebSocket to /socket.io for GraphQL subscriptions'
    })


# Add GraphQL playground (development only)
@graphql_bp.route('/graphql/playground')
def graphql_playground():
    """GraphQL Playground interface"""
    from flask import current_app
    
    if not current_app.debug:
        return jsonify({'error': 'Playground only available in debug mode'}), 403
    
    playground_html = """
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset=utf-8/>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Mirador GraphQL Playground</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/graphql-playground-react/build/static/css/index.css" />
        <link rel="shortcut icon" href="https://cdn.jsdelivr.net/npm/graphql-playground-react/build/favicon.png" />
        <script src="https://cdn.jsdelivr.net/npm/graphql-playground-react/build/static/js/middleware.js"></script>
    </head>
    <body>
        <div id="root"></div>
        <script>
            window.addEventListener('load', function (event) {
                GraphQLPlayground.init(document.getElementById('root'), {
                    endpoint: '/api/v5/graphql',
                    subscriptionEndpoint: 'ws://localhost:5000/socket.io',
                    settings: {
                        'request.credentials': 'include',
                        'editor.theme': 'dark',
                        'editor.fontSize': 14,
                        'editor.reuseHeaders': true,
                        'tracing.hideTracingResponse': false,
                        'editor.theme': 'dark',
                        'general.betaUpdates': false,
                        'prettier.printWidth': 80,
                        'prettier.tabWidth': 2,
                        'prettier.useTabs': false,
                    },
                    headers: {
                        'X-API-Key': localStorage.getItem('mirador_api_key') || 'your-api-key'
                    },
                    tabs: [
                        {
                            endpoint: '/api/v5/graphql',
                            query: `# Welcome to Mirador GraphQL Playground
#
# Mirador provides a GraphQL API as an alternative to REST.
# Use this playground to explore the schema and test queries.
#
# Example Query:

query GetModels {
  models {
    name
    description
    type
    version
  }
}

# Example Mutation:

mutation ExecuteQuery($input: QueryInput!) {
  executeQuery(input: $input) {
    response {
      id
      content
      chainType
      executionTime
    }
  }
}

# Example Subscription:

subscription StreamQuery($query: String!) {
  queryStream(query: $query) {
    content
    stage
    model
    confidence
  }
}`,
                            variables: JSON.stringify({
                                input: {
                                    prompt: "What are the key benefits of GraphQL?",
                                    format: "QUICK"
                                }
                            }, null, 2)
                        }
                    ]
                })
            })
        </script>
    </body>
    </html>
    """
    
    return playground_html, 200, {'Content-Type': 'text/html'}