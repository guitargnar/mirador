"""
Query endpoints for Mirador API with caching support
"""
from flask import Blueprint, request, jsonify, g
from marshmallow import ValidationError

from ..auth import require_auth
from ..middleware import rate_limit
from ..cache import (
    cache_manager,
    cached_query,
    cached_chain,
    invalidate_cache,
    cache_control,
    CacheNamespace
)
from ..core.exceptions import (
    APIError,
    ModelNotFoundError,
    ChainNotFoundError
)
from ..schemas import (
    QueryRequestSchema,
    QueryResponseSchema,
    ChainRequestSchema,
    ChainResponseSchema
)
from ..orchestrator import orchestrator_manager
from ..utils import track_request


query_bp = Blueprint('query', __name__)

# Initialize schemas
query_request_schema = QueryRequestSchema()
query_response_schema = QueryResponseSchema()
chain_request_schema = ChainRequestSchema()
chain_response_schema = ChainResponseSchema()


@query_bp.route('/query', methods=['POST', 'OPTIONS'])
@require_auth(['read'])
@rate_limit()
@track_request
def execute_query():
    """
    Execute a query with smart routing and caching
    
    The query will be routed to the appropriate chain based on content analysis.
    Results are cached to improve performance for repeated queries.
    """
    if request.method == 'OPTIONS':
        return '', 204
    
    try:
        # Validate request
        data = query_request_schema.load(request.json)
    except ValidationError as e:
        raise APIError("Invalid request data", details=e.messages)
    
    # Extract parameters
    query = data['query']
    chain_type = data.get('chain_type')
    format_type = data.get('format', 'detailed')
    session_id = data.get('session_id')
    options = data.get('options', {})
    use_cache = data.get('use_cache', True)
    
    # Check cache if enabled
    if use_cache and request.method == 'GET':
        cached_response = cache_manager.get_cached_query(query, options)
        if cached_response:
            # Add cache hit header
            response = jsonify(cached_response)
            response.headers['X-Cache'] = 'HIT'
            response.headers['X-Cache-TTL'] = str(cache_manager.CacheTTL.QUERY_RESPONSE)
            return response
    
    # Execute query
    try:
        result = orchestrator_manager.execute_query(
            query=query,
            chain_type=chain_type,
            format_type=format_type,
            session_id=session_id,
            user_id=g.current_user.get('id'),
            options=options
        )
        
        # Prepare response
        response_data = {
            'id': result.get('id'),
            'session_id': result.get('session_id'),
            'content': result.get('content'),
            'chain_type': result.get('chain_type'),
            'models_used': result.get('models_used', []),
            'execution_time': result.get('execution_time'),
            'created_at': result.get('created_at')
        }
        
        # Cache the response if caching is enabled
        if use_cache:
            cache_manager.cache_query_response(
                query=query,
                response=response_data,
                chain_type=chain_type,
                options=options
            )
        
        # Return response with cache miss header
        response = jsonify(query_response_schema.dump(response_data))
        response.headers['X-Cache'] = 'MISS'
        return response
        
    except ModelNotFoundError as e:
        raise APIError(f"Model not found: {e.model_name}", code="MODEL_NOT_FOUND")
    except ChainNotFoundError as e:
        raise APIError(f"Chain not found: {e.chain_name}", code="CHAIN_NOT_FOUND")
    except Exception as e:
        raise APIError(f"Query execution failed: {str(e)}")


@query_bp.route('/chains/<chain_type>/run', methods=['POST', 'OPTIONS'])
@require_auth(['read'])
@rate_limit()
@track_request
@cached_chain()  # Apply caching decorator
def run_chain(chain_type):
    """
    Run a specific chain with caching
    
    Executes the specified chain type with the given prompt.
    Results are cached based on chain type, prompt, and format.
    """
    if request.method == 'OPTIONS':
        return '', 204
    
    try:
        # Validate request
        data = chain_request_schema.load(request.json)
    except ValidationError as e:
        raise APIError("Invalid request data", details=e.messages)
    
    # Extract parameters
    prompt = data['prompt']
    format_type = data.get('format', 'detailed')
    session_id = data.get('session_id')
    options = data.get('options', {})
    use_cache = data.get('use_cache', True)
    
    # Check cache if enabled
    if use_cache:
        cached_result = cache_manager.get_cached_chain(
            chain_type=chain_type,
            prompt=prompt,
            format=format_type
        )
        if cached_result:
            response = jsonify(cached_result)
            response.headers['X-Cache'] = 'HIT'
            return response
    
    # Execute chain
    try:
        result = orchestrator_manager.execute_chain(
            chain_type=chain_type,
            prompt=prompt,
            format_type=format_type,
            session_id=session_id,
            user_id=g.current_user.get('id'),
            options=options
        )
        
        # Prepare response
        response_data = {
            'id': result.get('id'),
            'chain_type': chain_type,
            'session_id': result.get('session_id'),
            'results': result.get('results', []),
            'summary': result.get('summary'),
            'execution_time': result.get('execution_time'),
            'tokens_used': result.get('tokens_used', {}),
            'created_at': result.get('created_at')
        }
        
        # Cache the result if caching is enabled
        if use_cache:
            cache_manager.cache_chain_result(
                chain_type=chain_type,
                prompt=prompt,
                result=response_data,
                format=format_type
            )
        
        # Return response
        response = jsonify(chain_response_schema.dump(response_data))
        response.headers['X-Cache'] = 'MISS'
        return response
        
    except ChainNotFoundError:
        raise APIError(f"Chain type '{chain_type}' not found", code="CHAIN_NOT_FOUND")
    except Exception as e:
        raise APIError(f"Chain execution failed: {str(e)}")


@query_bp.route('/query/cache', methods=['DELETE'])
@require_auth(['admin'])
def clear_query_cache():
    """Clear query cache for the current user"""
    user_id = g.current_user.get('id')
    count = cache_manager.invalidate_user(user_id)
    
    return jsonify({
        'success': True,
        'cleared': count,
        'message': f"Cleared {count} cache entries"
    })


@query_bp.route('/cache/stats', methods=['GET'])
@require_auth(['read'])
@cache_control(no_cache=True)
def get_cache_stats():
    """Get cache statistics"""
    stats = cache_manager.get_cache_stats()
    
    # Add warmup stats if available
    from ..cache import cache_warmup_service
    warmup_stats = cache_warmup_service.get_warmup_stats()
    stats['warmup'] = warmup_stats
    
    return jsonify(stats)


@query_bp.route('/cache/warmup', methods=['POST'])
@require_auth(['admin'])
async def trigger_cache_warmup():
    """Manually trigger cache warmup"""
    from ..cache import cache_warmup_service
    
    results = await cache_warmup_service.warmup_batch()
    
    return jsonify({
        'success': True,
        'results': results
    })


@query_bp.route('/models/<model_name>/test', methods=['POST'])
@require_auth(['read'])
@rate_limit('premium')
@cached_model()  # Cache model test results
def test_model(model_name):
    """
    Test a specific model with caching
    
    Useful for testing individual model responses.
    Results are cached to avoid repeated model calls.
    """
    try:
        data = request.json
        prompt = data.get('prompt')
        options = data.get('options', {})
        use_cache = data.get('use_cache', True)
        
        if not prompt:
            raise APIError("Prompt is required")
        
        # Check cache if enabled
        if use_cache:
            cached_output = cache_manager.get_cached_model(
                model_name=model_name,
                prompt=prompt,
                options=options
            )
            if cached_output:
                return jsonify({
                    'model': model_name,
                    'output': cached_output,
                    'cached': True
                })
        
        # Test model
        output = orchestrator_manager.test_model(
            model_name=model_name,
            prompt=prompt,
            options=options
        )
        
        # Cache the output
        if use_cache:
            cache_manager.cache_model_output(
                model_name=model_name,
                prompt=prompt,
                output=output,
                options=options
            )
        
        return jsonify({
            'model': model_name,
            'output': output,
            'cached': False
        })
        
    except ModelNotFoundError:
        raise APIError(f"Model '{model_name}' not found", code="MODEL_NOT_FOUND")
    except Exception as e:
        raise APIError(f"Model test failed: {str(e)}")


# Error handlers
@query_bp.errorhandler(APIError)
def handle_api_error(error):
    """Handle API errors"""
    response = jsonify(error.to_dict())
    response.status_code = error.status_code
    return response


@query_bp.errorhandler(ValidationError)
def handle_validation_error(error):
    """Handle validation errors"""
    return jsonify({
        'error': 'Validation failed',
        'details': error.messages
    }), 400