"""
Integration tests for API endpoints.
"""
import pytest
from httpx import AsyncClient


class TestHealthEndpoints:
    """Test health check endpoints."""
    
    @pytest.mark.asyncio
    async def test_health_check(self, async_client: AsyncClient):
        """Test basic health check."""
        response = await async_client.get("/api/v5/health")
        assert response.status_code == 200
        data = response.json()
        assert data["status"] in ["healthy", "degraded", "unhealthy"]
        assert "version" in data
        assert "timestamp" in data
    
    @pytest.mark.asyncio
    async def test_health_live(self, async_client: AsyncClient):
        """Test liveness probe."""
        response = await async_client.get("/api/v5/health/live")
        assert response.status_code == 200
        data = response.json()
        assert data["status"] == "ok"
    
    @pytest.mark.asyncio
    async def test_health_ready(self, async_client: AsyncClient):
        """Test readiness probe."""
        response = await async_client.get("/api/v5/health/ready")
        assert response.status_code in [200, 503]
        data = response.json()
        assert "status" in data
        assert "checks" in data


class TestAuthEndpoints:
    """Test authentication endpoints."""
    
    @pytest.mark.asyncio
    async def test_create_api_key_unauthorized(self, async_client: AsyncClient):
        """Test creating API key without admin privileges."""
        response = await async_client.post(
            "/api/v5/auth/api-keys",
            json={"name": "Test Key", "scopes": ["read"]}
        )
        assert response.status_code == 401
    
    @pytest.mark.asyncio
    async def test_create_api_key_admin(self, authenticated_client: AsyncClient):
        """Test creating API key with admin privileges."""
        response = await authenticated_client.post(
            "/api/v5/auth/api-keys",
            json={"name": "New Test Key", "scopes": ["read", "write"]}
        )
        assert response.status_code == 201
        data = response.json()
        assert "key" in data
        assert "name" in data
        assert data["name"] == "New Test Key"
    
    @pytest.mark.asyncio
    async def test_list_api_keys(self, authenticated_client: AsyncClient):
        """Test listing API keys."""
        response = await authenticated_client.get("/api/v5/auth/api-keys")
        assert response.status_code == 200
        data = response.json()
        assert isinstance(data, list)
    
    @pytest.mark.asyncio
    async def test_validate_api_key(self, authenticated_client: AsyncClient, test_api_key: str):
        """Test validating API key."""
        response = await authenticated_client.post(
            "/api/v5/auth/validate",
            json={"key": test_api_key}
        )
        assert response.status_code == 200
        data = response.json()
        assert data["valid"] is True
        assert "scopes" in data


class TestChainEndpoints:
    """Test chain execution endpoints."""
    
    @pytest.mark.asyncio
    async def test_execute_chain_unauthorized(self, async_client: AsyncClient, sample_chain_request):
        """Test executing chain without authentication."""
        response = await async_client.post(
            "/api/v5/chains/execute",
            json=sample_chain_request
        )
        assert response.status_code == 401
    
    @pytest.mark.asyncio
    async def test_execute_chain(self, authenticated_client: AsyncClient, sample_chain_request, mock_ollama_response):
        """Test executing chain with authentication."""
        response = await authenticated_client.post(
            "/api/v5/chains/execute",
            json=sample_chain_request
        )
        assert response.status_code == 200
        data = response.json()
        assert "session_id" in data
        assert "chain_type" in data
        assert "results" in data
    
    @pytest.mark.asyncio
    async def test_execute_chain_streaming(self, authenticated_client: AsyncClient, sample_chain_request, mock_ollama_response):
        """Test executing chain with streaming."""
        sample_chain_request["stream"] = True
        
        async with authenticated_client.stream(
            "POST",
            "/api/v5/chains/execute",
            json=sample_chain_request
        ) as response:
            assert response.status_code == 200
            assert response.headers["content-type"] == "text/event-stream"
            
            events = []
            async for line in response.aiter_lines():
                if line.startswith("data: "):
                    events.append(line[6:])
            
            assert len(events) > 0
    
    @pytest.mark.asyncio
    async def test_list_chains(self, authenticated_client: AsyncClient):
        """Test listing available chains."""
        response = await authenticated_client.get("/api/v5/chains")
        assert response.status_code == 200
        data = response.json()
        assert isinstance(data, list)
        assert len(data) > 0
        assert all("name" in chain and "description" in chain for chain in data)


class TestModelEndpoints:
    """Test model inference endpoints."""
    
    @pytest.mark.asyncio
    async def test_model_inference(self, authenticated_client: AsyncClient, sample_model_request, mock_ollama_response):
        """Test model inference."""
        response = await authenticated_client.post(
            "/api/v5/models/inference",
            json=sample_model_request
        )
        assert response.status_code == 200
        data = response.json()
        assert "response" in data
        assert "model" in data
        assert "metrics" in data
    
    @pytest.mark.asyncio
    async def test_model_inference_streaming(self, authenticated_client: AsyncClient, sample_model_request, mock_ollama_response):
        """Test model inference with streaming."""
        sample_model_request["stream"] = True
        
        async with authenticated_client.stream(
            "POST",
            "/api/v5/models/inference",
            json=sample_model_request
        ) as response:
            assert response.status_code == 200
            assert response.headers["content-type"] == "text/event-stream"
            
            chunks = []
            async for line in response.aiter_lines():
                if line.startswith("data: "):
                    chunks.append(line[6:])
            
            assert len(chunks) > 0
    
    @pytest.mark.asyncio
    async def test_list_models(self, authenticated_client: AsyncClient):
        """Test listing available models."""
        response = await authenticated_client.get("/api/v5/models")
        assert response.status_code == 200
        data = response.json()
        assert isinstance(data, list)
        assert len(data) > 0
    
    @pytest.mark.asyncio
    async def test_model_info(self, authenticated_client: AsyncClient):
        """Test getting model information."""
        response = await authenticated_client.get("/api/v5/models/matthew_context_provider_v5")
        assert response.status_code == 200
        data = response.json()
        assert "name" in data
        assert "parameters" in data
        assert "description" in data


class TestWebSocketEndpoints:
    """Test WebSocket endpoints."""
    
    @pytest.mark.asyncio
    async def test_websocket_connection_unauthorized(self, async_client: AsyncClient):
        """Test WebSocket connection without authentication."""
        with pytest.raises(Exception):  # WebSocket should reject unauthorized connections
            async with async_client.websocket_connect("/api/v5/ws/chat") as websocket:
                pass
    
    @pytest.mark.asyncio
    async def test_websocket_chat(self, authenticated_client: AsyncClient, mock_ollama_response):
        """Test WebSocket chat connection."""
        headers = {"X-API-Key": authenticated_client.headers.get("X-API-Key")}
        
        async with authenticated_client.websocket_connect(
            "/api/v5/ws/chat",
            headers=headers
        ) as websocket:
            # Send a message
            await websocket.send_json({
                "type": "message",
                "content": "Hello, how are you?",
                "model": "matthew_context_provider_v5"
            })
            
            # Receive response
            response = await websocket.receive_json()
            assert response["type"] == "response"
            assert "content" in response
            assert "model" in response


class TestGraphQLEndpoints:
    """Test GraphQL endpoints."""
    
    @pytest.mark.asyncio
    async def test_graphql_query(self, authenticated_client: AsyncClient):
        """Test GraphQL query."""
        query = """
        query {
            chains {
                name
                description
                models
            }
        }
        """
        
        response = await authenticated_client.post(
            "/api/v5/graphql",
            json={"query": query}
        )
        assert response.status_code == 200
        data = response.json()
        assert "data" in data
        assert "chains" in data["data"]
    
    @pytest.mark.asyncio
    async def test_graphql_mutation(self, authenticated_client: AsyncClient, mock_ollama_response):
        """Test GraphQL mutation."""
        mutation = """
        mutation ExecuteChain($input: ChainExecutionInput!) {
            executeChain(input: $input) {
                sessionId
                chainType
                status
                results
            }
        }
        """
        
        variables = {
            "input": {
                "chainType": "life_optimization",
                "prompt": "How can I be more productive?",
                "parameters": {
                    "temperature": 0.7
                }
            }
        }
        
        response = await authenticated_client.post(
            "/api/v5/graphql",
            json={"query": mutation, "variables": variables}
        )
        assert response.status_code == 200
        data = response.json()
        assert "data" in data
        assert "executeChain" in data["data"]
        assert data["data"]["executeChain"]["status"] == "completed"


class TestRateLimiting:
    """Test rate limiting functionality."""
    
    @pytest.mark.asyncio
    async def test_rate_limit_enforcement(self, authenticated_client: AsyncClient):
        """Test that rate limits are enforced."""
        # Make multiple requests quickly
        responses = []
        for _ in range(15):  # Exceed the 10 requests per minute limit
            response = await authenticated_client.get("/api/v5/chains")
            responses.append(response)
        
        # Check that at least one request was rate limited
        status_codes = [r.status_code for r in responses]
        assert 429 in status_codes
        
        # Check rate limit headers
        limited_response = next(r for r in responses if r.status_code == 429)
        assert "X-RateLimit-Limit" in limited_response.headers
        assert "X-RateLimit-Remaining" in limited_response.headers
        assert "X-RateLimit-Reset" in limited_response.headers


class TestCaching:
    """Test caching functionality."""
    
    @pytest.mark.asyncio
    async def test_cache_headers(self, authenticated_client: AsyncClient):
        """Test cache headers on responses."""
        # First request
        response1 = await authenticated_client.get("/api/v5/models")
        assert response1.status_code == 200
        assert "ETag" in response1.headers
        etag = response1.headers["ETag"]
        
        # Second request with If-None-Match
        response2 = await authenticated_client.get(
            "/api/v5/models",
            headers={"If-None-Match": etag}
        )
        assert response2.status_code == 304  # Not Modified
    
    @pytest.mark.asyncio
    async def test_cache_invalidation(self, authenticated_client: AsyncClient, mock_ollama_response):
        """Test cache invalidation on writes."""
        # Get initial data
        response1 = await authenticated_client.get("/api/v5/chains")
        etag1 = response1.headers.get("ETag")
        
        # Execute a chain (should invalidate cache)
        await authenticated_client.post(
            "/api/v5/chains/execute",
            json={
                "chain_type": "life_optimization",
                "prompt": "Test prompt"
            }
        )
        
        # Get data again
        response2 = await authenticated_client.get("/api/v5/chains")
        etag2 = response2.headers.get("ETag")
        
        # ETags should be different
        assert etag1 != etag2