"""
Cache management endpoints for Mirador API
"""
from flask import Blueprint, request, jsonify, g
from datetime import datetime

from ..auth import require_auth
from ..cache import cache_manager, cache_warmup_service, CacheNamespace
from ..core.exceptions import APIError
from ..schemas import SuccessResponseSchema


cache_bp = Blueprint('cache', __name__)
success_schema = SuccessResponseSchema()


@cache_bp.route('/cache/stats', methods=['GET'])
@require_auth(['read'])
def get_cache_statistics():
    """
    Get comprehensive cache statistics
    
    Returns information about cache usage, hit rates, and memory consumption.
    """
    stats = cache_manager.get_cache_stats()
    
    # Add warmup service stats
    warmup_stats = cache_warmup_service.get_warmup_stats()
    
    return jsonify({
        'cache': stats,
        'warmup': warmup_stats,
        'timestamp': datetime.utcnow().isoformat()
    })


@cache_bp.route('/cache/clear', methods=['POST', 'DELETE'])
@require_auth(['admin'])
def clear_cache():
    """
    Clear cache entries
    
    Clears cache based on the provided criteria.
    """
    if request.method in ['POST', 'DELETE']:
        data = request.json or {}
        
        # Extract parameters
        namespace = data.get('namespace')
        pattern = data.get('pattern')
        user_id = data.get('user_id')
        session_id = data.get('session_id')
        
        cleared = 0
        
        try:
            if user_id:
                # Clear user-specific cache
                cleared = cache_manager.invalidate_user(user_id)
            elif session_id:
                # Clear session-specific cache
                cleared = cache_manager.invalidate_session(session_id)
            elif pattern:
                # Clear by pattern
                cleared = cache_manager.delete_pattern(pattern)
            elif namespace:
                # Clear entire namespace
                pattern = f"{namespace}:*"
                cleared = cache_manager.delete_pattern(pattern)
            else:
                # Clear all cache (admin only)
                if g.current_user.get('role') != 'admin':
                    raise APIError("Admin access required to clear all cache", status_code=403)
                
                for ns in CacheNamespace:
                    cleared += cache_manager.delete_pattern(f"{ns}:*")
            
            return jsonify({
                'success': True,
                'cleared': cleared,
                'message': f"Cleared {cleared} cache entries"
            })
            
        except Exception as e:
            raise APIError(f"Failed to clear cache: {str(e)}")


@cache_bp.route('/cache/warmup', methods=['POST'])
@require_auth(['admin'])
async def trigger_warmup():
    """
    Manually trigger cache warmup
    
    Runs the cache warmup process to pre-populate common queries.
    """
    try:
        results = await cache_warmup_service.warmup_batch()
        
        return jsonify({
            'success': True,
            'results': results,
            'message': f"Warmed up {results['queries_warmed']} queries and {results['models_warmed']} models"
        })
    except Exception as e:
        raise APIError(f"Cache warmup failed: {str(e)}")


@cache_bp.route('/cache/warmup/config', methods=['GET', 'PUT'])
@require_auth(['admin'])
def manage_warmup_config():
    """
    Get or update cache warmup configuration
    """
    if request.method == 'GET':
        return jsonify({
            'enabled': cache_warmup_service.enabled,
            'interval': cache_warmup_service.warmup_interval,
            'queries': cache_warmup_service.warmup_queries
        })
    
    elif request.method == 'PUT':
        data = request.json or {}
        
        # Update configuration
        if 'enabled' in data:
            cache_warmup_service.enabled = data['enabled']
        
        if 'interval' in data:
            cache_warmup_service.warmup_interval = data['interval']
        
        if 'queries' in data:
            cache_warmup_service.warmup_queries = data['queries']
        
        return jsonify({
            'success': True,
            'message': 'Warmup configuration updated'
        })


@cache_bp.route('/cache/keys', methods=['GET'])
@require_auth(['admin'])
def list_cache_keys():
    """
    List cache keys matching a pattern
    
    Admin endpoint for debugging cache contents.
    """
    pattern = request.args.get('pattern', '*')
    namespace = request.args.get('namespace')
    limit = int(request.args.get('limit', 100))
    
    if namespace:
        pattern = f"{namespace}:{pattern}"
    
    try:
        # Get keys from Redis
        full_pattern = f"{cache_manager.key_prefix}:{pattern}"
        
        if cache_manager._redis_client:
            keys = []
            cursor = 0
            
            # Use SCAN for better performance
            while True:
                cursor, batch = cache_manager._redis_client.scan(
                    cursor=cursor,
                    match=full_pattern,
                    count=100
                )
                keys.extend(batch)
                
                if cursor == 0 or len(keys) >= limit:
                    break
            
            # Limit results
            keys = keys[:limit]
            
            # Remove prefix for cleaner display
            prefix_len = len(cache_manager.key_prefix) + 1
            keys = [key[prefix_len:] for key in keys]
            
            return jsonify({
                'keys': keys,
                'count': len(keys),
                'pattern': pattern,
                'limited': len(keys) == limit
            })
        else:
            raise APIError("Cache not available")
            
    except Exception as e:
        raise APIError(f"Failed to list cache keys: {str(e)}")


@cache_bp.route('/cache/key/<path:key>', methods=['GET', 'DELETE'])
@require_auth(['admin'])
def manage_cache_key(key):
    """
    Get or delete a specific cache key
    
    Admin endpoint for cache debugging.
    """
    if request.method == 'GET':
        # Get cache value
        try:
            # Try to determine namespace from key
            namespace = key.split(':')[0] if ':' in key else CacheNamespace.QUERY
            parts = key.split(':', 2)
            
            if len(parts) >= 2:
                value = cache_manager.get(namespace, parts[1], parts[2] if len(parts) > 2 else None)
                
                if value is not None:
                    return jsonify({
                        'key': key,
                        'value': value,
                        'exists': True
                    })
                else:
                    return jsonify({
                        'key': key,
                        'exists': False
                    }), 404
            else:
                raise APIError("Invalid key format")
                
        except Exception as e:
            raise APIError(f"Failed to get cache key: {str(e)}")
    
    elif request.method == 'DELETE':
        # Delete cache key
        try:
            # Parse key components
            namespace = key.split(':')[0] if ':' in key else CacheNamespace.QUERY
            parts = key.split(':', 2)
            
            if len(parts) >= 2:
                deleted = cache_manager.delete(
                    namespace,
                    parts[1],
                    parts[2] if len(parts) > 2 else None
                )
                
                return jsonify({
                    'success': True,
                    'deleted': deleted,
                    'key': key
                })
            else:
                raise APIError("Invalid key format")
                
        except Exception as e:
            raise APIError(f"Failed to delete cache key: {str(e)}")


@cache_bp.route('/cache/user/<user_id>', methods=['DELETE'])
@require_auth(['admin'])
def clear_user_cache(user_id):
    """Clear all cache entries for a specific user"""
    cleared = cache_manager.invalidate_user(user_id)
    
    return jsonify({
        'success': True,
        'user_id': user_id,
        'cleared': cleared,
        'message': f"Cleared {cleared} cache entries for user {user_id}"
    })


@cache_bp.route('/cache/session/<session_id>', methods=['DELETE'])
@require_auth(['read'])
def clear_session_cache(session_id):
    """Clear all cache entries for a specific session"""
    # Users can only clear their own sessions
    if g.current_user.get('role') != 'admin':
        # Verify session belongs to user
        # TODO: Add session ownership check
        pass
    
    cleared = cache_manager.invalidate_session(session_id)
    
    return jsonify({
        'success': True,
        'session_id': session_id,
        'cleared': cleared,
        'message': f"Cleared {cleared} cache entries for session {session_id}"
    })


# Error handlers
@cache_bp.errorhandler(APIError)
def handle_api_error(error):
    """Handle API errors"""
    response = jsonify(error.to_dict())
    response.status_code = error.status_code
    return response