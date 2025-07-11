"""
Async client for Mirador SDK
"""
import json
import logging
from typing import Optional, List, Dict, Any, AsyncIterator, Union

try:
    import aiohttp
    from aiohttp import ClientTimeout, ClientSession
    from aiohttp_sse_client import client as sse_client
except ImportError:
    raise ImportError(
        "Async support requires additional dependencies. "
        "Install with: pip install mirador-sdk[async]"
    )

from .config import ClientConfig, RetryConfig
from .exceptions import (
    MiradorError,
    AuthenticationError,
    RateLimitError,
    APIError,
    NetworkError,
    TimeoutError,
    StreamingError
)
from .models import (
    Query,
    QueryResponse,
    StreamToken,
    Chain,
    ChainResponse,
    Model,
    Session,
    Webhook,
    ChainType,
    OutputFormat
)
from .async_resources import (
    AsyncChainsResource,
    AsyncModelsResource,
    AsyncSessionsResource,
    AsyncWebhooksResource
)


logger = logging.getLogger("mirador.async")


class AsyncMiradorClient:
    """
    Async client for interacting with Mirador API
    
    Args:
        api_key: API key for authentication
        jwt_token: JWT token for authentication (alternative to api_key)
        base_url: Base URL for the API
        timeout: Default timeout for requests in seconds
        streaming_timeout: Timeout for streaming requests
        headers: Additional headers to include in requests
        retry_config: Configuration for request retries
    """
    
    def __init__(
        self,
        api_key: Optional[str] = None,
        jwt_token: Optional[str] = None,
        base_url: str = "http://localhost:5000",
        timeout: float = 30.0,
        streaming_timeout: float = 300.0,
        headers: Optional[Dict[str, str]] = None,
        retry_config: Optional[RetryConfig] = None
    ):
        # Create config
        self.config = ClientConfig(
            api_key=api_key,
            jwt_token=jwt_token,
            base_url=base_url,
            timeout=timeout,
            streaming_timeout=streaming_timeout,
            headers=headers or {},
            retry_config=retry_config or RetryConfig()
        )
        
        # Session will be created in __aenter__
        self._session: Optional[ClientSession] = None
        
        # Initialize resources
        self.chains = AsyncChainsResource(self)
        self.models = AsyncModelsResource(self)
        self.sessions = AsyncSessionsResource(self)
        self.webhooks = AsyncWebhooksResource(self)
        
        logger.debug(f"Initialized AsyncMiradorClient with base_url: {self.config.base_url}")
    
    def _get_headers(self) -> Dict[str, str]:
        """Get headers for requests"""
        headers = self.config.headers.copy()
        
        # Add authentication
        if self.config.api_key:
            headers["X-API-Key"] = self.config.api_key
        elif self.config.jwt_token:
            headers["Authorization"] = f"Bearer {self.config.jwt_token}"
        
        return headers
    
    async def _make_request(
        self,
        method: str,
        endpoint: str,
        data: Optional[Dict[str, Any]] = None,
        params: Optional[Dict[str, Any]] = None,
        timeout: Optional[float] = None
    ) -> Dict[str, Any]:
        """Make an async HTTP request to the API"""
        if not self._session:
            raise RuntimeError("Client must be used within async context manager")
        
        url = f"{self.config.base_url}/{endpoint.lstrip('/')}"
        timeout_config = ClientTimeout(total=timeout or self.config.timeout)
        
        logger.debug(f"{method} {url}")
        
        retry_count = 0
        last_error = None
        
        while retry_count <= self.config.retry_config.max_retries:
            try:
                async with self._session.request(
                    method=method,
                    url=url,
                    json=data,
                    params=params,
                    headers=self._get_headers(),
                    timeout=timeout_config
                ) as response:
                    # Handle rate limiting
                    if response.status == 429:
                        retry_after = int(response.headers.get("Retry-After", 60))
                        raise RateLimitError(
                            "Rate limit exceeded",
                            retry_after=retry_after,
                            status_code=429
                        )
                    
                    # Handle authentication errors
                    if response.status in [401, 403]:
                        raise AuthenticationError(
                            "Authentication failed",
                            status_code=response.status
                        )
                    
                    # Handle other errors
                    if response.status >= 400:
                        try:
                            error_data = await response.json()
                            message = error_data.get("error", "API request failed")
                        except:
                            message = f"API request failed with status {response.status}"
                            error_data = None
                        
                        raise APIError(
                            message,
                            status_code=response.status,
                            response=error_data
                        )
                    
                    # Parse JSON response
                    return await response.json()
                    
            except aiohttp.ClientTimeout:
                raise TimeoutError(f"Request timed out after {timeout or self.config.timeout}s")
            except aiohttp.ClientError as e:
                last_error = NetworkError(f"Network error: {str(e)}")
                
                # Check if we should retry
                if retry_count < self.config.retry_config.max_retries:
                    retry_count += 1
                    wait_time = min(
                        self.config.retry_config.backoff_factor ** retry_count,
                        self.config.retry_config.max_backoff
                    )
                    logger.warning(f"Request failed, retrying in {wait_time}s...")
                    await asyncio.sleep(wait_time)
                else:
                    raise last_error
            except Exception as e:
                if isinstance(e, MiradorError):
                    raise
                raise MiradorError(f"Request failed: {str(e)}")
    
    async def query(
        self,
        prompt: str,
        chain_type: Optional[Union[str, ChainType]] = None,
        format: Union[str, OutputFormat] = OutputFormat.DETAILED,
        session_id: Optional[str] = None,
        options: Optional[Dict[str, Any]] = None,
        metadata: Optional[Dict[str, Any]] = None
    ) -> QueryResponse:
        """
        Execute a query against the Mirador API
        
        Args:
            prompt: The query prompt
            chain_type: Type of chain to use
            format: Output format
            session_id: Session ID to continue conversation
            options: Additional options
            metadata: Metadata to attach
            
        Returns:
            QueryResponse object
        """
        query_obj = Query(
            prompt=prompt,
            chain_type=chain_type,
            format=format,
            session_id=session_id,
            options=options or {},
            metadata=metadata or {}
        )
        
        response = await self._make_request(
            "POST",
            "/api/v5/query",
            data=query_obj.model_dump(exclude_none=True)
        )
        
        return QueryResponse(**response)
    
    async def stream(
        self,
        prompt: str,
        chain_type: Optional[Union[str, ChainType]] = None,
        session_id: Optional[str] = None,
        options: Optional[Dict[str, Any]] = None
    ) -> AsyncIterator[StreamToken]:
        """
        Stream a query response using Server-Sent Events
        
        Args:
            prompt: The query prompt
            chain_type: Type of chain to use
            session_id: Session ID
            options: Additional options
            
        Yields:
            StreamToken objects
        """
        if not self._session:
            raise RuntimeError("Client must be used within async context manager")
        
        data = {
            "prompt": prompt,
            "chain_type": chain_type,
            "session_id": session_id,
            "options": options or {}
        }
        
        url = f"{self.config.base_url}/api/v5/stream"
        headers = self._get_headers()
        headers["Accept"] = "text/event-stream"
        
        try:
            async with sse_client.EventSource(
                url,
                session=self._session,
                headers=headers,
                json=data,
                timeout=self.config.streaming_timeout
            ) as event_source:
                async for event in event_source:
                    if event.event == "token":
                        try:
                            token_data = json.loads(event.data)
                            yield StreamToken(**token_data)
                        except json.JSONDecodeError:
                            logger.warning(f"Failed to parse SSE token: {event.data}")
                    elif event.event == "error":
                        try:
                            error_data = json.loads(event.data)
                            raise StreamingError(error_data.get("message", "Streaming error"))
                        except json.JSONDecodeError:
                            raise StreamingError("Unknown streaming error")
                    elif event.event == "done":
                        break
                        
        except Exception as e:
            if not isinstance(e, MiradorError):
                raise StreamingError(f"Streaming failed: {str(e)}")
            raise
    
    async def websocket(self, **kwargs):
        """
        Create a WebSocket connection for real-time communication
        
        Returns:
            AsyncWebSocketConnection object
        """
        from .async_websocket import AsyncWebSocketConnection
        return await AsyncWebSocketConnection.create(self, **kwargs)
    
    async def health_check(self) -> Dict[str, Any]:
        """Check API health status"""
        return await self._make_request("GET", "/api/v5/health")
    
    async def __aenter__(self):
        """Async context manager entry"""
        self._session = ClientSession()
        return self
    
    async def __aexit__(self, exc_type, exc_val, exc_tb):
        """Async context manager exit"""
        await self.close()
    
    async def close(self):
        """Close the client and cleanup resources"""
        if self._session:
            await self._session.close()
            self._session = None


# Import asyncio at module level
import asyncio