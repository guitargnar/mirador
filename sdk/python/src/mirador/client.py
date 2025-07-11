"""
Main client for Mirador SDK
"""
import json
import time
import logging
from typing import Optional, List, Dict, Any, Iterator, Union
from urllib.parse import urljoin

import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry
from sseclient import SSEClient
import websocket

from .config import ClientConfig, RetryConfig
from .exceptions import (
    MiradorError,
    AuthenticationError,
    RateLimitError,
    ValidationError,
    APIError,
    NetworkError,
    TimeoutError,
    StreamingError,
    ModelNotFoundError,
    ChainNotFoundError,
    SessionNotFoundError
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
    WebhookEvent,
    ChainType,
    OutputFormat
)
from .resources import (
    ChainsResource,
    ModelsResource,
    SessionsResource,
    WebhooksResource
)


logger = logging.getLogger("mirador")


class MiradorClient:
    """
    Main client for interacting with Mirador API
    
    Args:
        api_key: API key for authentication
        jwt_token: JWT token for authentication (alternative to api_key)
        base_url: Base URL for the API (default: http://localhost:5000)
        timeout: Default timeout for requests in seconds
        streaming_timeout: Timeout for streaming requests
        headers: Additional headers to include in requests
        retry_config: Configuration for request retries
        verify_ssl: Whether to verify SSL certificates
        proxies: Proxy configuration
    """
    
    def __init__(
        self,
        api_key: Optional[str] = None,
        jwt_token: Optional[str] = None,
        base_url: str = "http://localhost:5000",
        timeout: float = 30.0,
        streaming_timeout: float = 300.0,
        headers: Optional[Dict[str, str]] = None,
        retry_config: Optional[RetryConfig] = None,
        verify_ssl: bool = True,
        proxies: Optional[Dict[str, str]] = None
    ):
        # Create config
        self.config = ClientConfig(
            api_key=api_key,
            jwt_token=jwt_token,
            base_url=base_url,
            timeout=timeout,
            streaming_timeout=streaming_timeout,
            headers=headers or {},
            retry_config=retry_config or RetryConfig(),
            verify_ssl=verify_ssl,
            proxies=proxies
        )
        
        # Setup session
        self._session = self._create_session()
        
        # Initialize resources
        self.chains = ChainsResource(self)
        self.models = ModelsResource(self)
        self.sessions = SessionsResource(self)
        self.webhooks = WebhooksResource(self)
        
        logger.debug(f"Initialized MiradorClient with base_url: {self.config.base_url}")
    
    def _create_session(self) -> requests.Session:
        """Create a requests session with retry configuration"""
        session = requests.Session()
        
        # Add authentication
        if self.config.api_key:
            session.headers["X-API-Key"] = self.config.api_key
        elif self.config.jwt_token:
            session.headers["Authorization"] = f"Bearer {self.config.jwt_token}"
        
        # Add custom headers
        session.headers.update(self.config.headers)
        
        # Configure retries
        retry_strategy = Retry(
            total=self.config.retry_config.max_retries,
            backoff_factor=self.config.retry_config.backoff_factor,
            status_forcelist=self.config.retry_config.retry_on,
            allowed_methods=["GET", "POST", "PUT", "DELETE"]
        )
        adapter = HTTPAdapter(max_retries=retry_strategy)
        session.mount("http://", adapter)
        session.mount("https://", adapter)
        
        # Set proxies if provided
        if self.config.proxies:
            session.proxies.update(self.config.proxies)
        
        return session
    
    def _make_request(
        self,
        method: str,
        endpoint: str,
        data: Optional[Dict[str, Any]] = None,
        params: Optional[Dict[str, Any]] = None,
        timeout: Optional[float] = None,
        stream: bool = False
    ) -> Union[Dict[str, Any], requests.Response]:
        """Make an HTTP request to the API"""
        url = urljoin(self.config.base_url + "/", endpoint.lstrip("/"))
        timeout = timeout or self.config.timeout
        
        logger.debug(f"{method} {url}")
        
        try:
            response = self._session.request(
                method=method,
                url=url,
                json=data,
                params=params,
                timeout=timeout,
                verify=self.config.verify_ssl,
                stream=stream
            )
            
            # Handle rate limiting
            if response.status_code == 429:
                retry_after = int(response.headers.get("Retry-After", 60))
                raise RateLimitError(
                    "Rate limit exceeded",
                    retry_after=retry_after,
                    status_code=429,
                    response=response.json() if not stream else None
                )
            
            # Handle authentication errors
            if response.status_code in [401, 403]:
                raise AuthenticationError(
                    "Authentication failed",
                    status_code=response.status_code,
                    response=response.json() if not stream else None
                )
            
            # Handle not found errors
            if response.status_code == 404:
                error_data = response.json() if not stream else {}
                message = error_data.get("error", "Resource not found")
                
                # Check for specific resource types
                if "model" in endpoint:
                    raise ModelNotFoundError(endpoint.split("/")[-1])
                elif "chain" in endpoint:
                    raise ChainNotFoundError(endpoint.split("/")[-1])
                elif "session" in endpoint:
                    raise SessionNotFoundError(endpoint.split("/")[-1])
                else:
                    raise APIError(message, status_code=404, response=error_data)
            
            # Handle other errors
            if response.status_code >= 400:
                try:
                    error_data = response.json()
                    message = error_data.get("error", "API request failed")
                except:
                    message = f"API request failed with status {response.status_code}"
                    error_data = None
                
                raise APIError(
                    message,
                    status_code=response.status_code,
                    response=error_data
                )
            
            # Return raw response for streaming
            if stream:
                return response
            
            # Parse JSON response
            return response.json()
            
        except requests.exceptions.Timeout:
            raise TimeoutError(f"Request timed out after {timeout}s")
        except requests.exceptions.ConnectionError as e:
            raise NetworkError(f"Network error: {str(e)}")
        except requests.exceptions.RequestException as e:
            raise MiradorError(f"Request failed: {str(e)}")
    
    def query(
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
            chain_type: Type of chain to use (optional, auto-selected if not provided)
            format: Output format (quick, summary, detailed, export)
            session_id: Session ID to continue conversation
            options: Additional options for the query
            metadata: Metadata to attach to the query
            
        Returns:
            QueryResponse object with the results
        """
        # Create query object
        query_obj = Query(
            prompt=prompt,
            chain_type=chain_type,
            format=format,
            session_id=session_id,
            options=options or {},
            metadata=metadata or {}
        )
        
        # Make request
        response = self._make_request(
            "POST",
            "/api/v5/query",
            data=query_obj.model_dump(exclude_none=True)
        )
        
        return QueryResponse(**response)
    
    def stream(
        self,
        prompt: str,
        chain_type: Optional[Union[str, ChainType]] = None,
        session_id: Optional[str] = None,
        options: Optional[Dict[str, Any]] = None
    ) -> Iterator[StreamToken]:
        """
        Stream a query response using Server-Sent Events
        
        Args:
            prompt: The query prompt
            chain_type: Type of chain to use
            session_id: Session ID to continue conversation
            options: Additional options for the query
            
        Yields:
            StreamToken objects as they arrive
        """
        data = {
            "prompt": prompt,
            "chain_type": chain_type,
            "session_id": session_id,
            "options": options or {}
        }
        
        # Make streaming request
        response = self._make_request(
            "POST",
            "/api/v5/stream",
            data=data,
            timeout=self.config.streaming_timeout,
            stream=True
        )
        
        try:
            # Create SSE client
            client = SSEClient(response)
            
            for event in client.events():
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
    
    def websocket(self, **kwargs):
        """
        Create a WebSocket connection for real-time communication
        
        Returns:
            WebSocketConnection object
        """
        from .websocket import WebSocketConnection
        return WebSocketConnection(self, **kwargs)
    
    def health_check(self) -> Dict[str, Any]:
        """Check API health status"""
        return self._make_request("GET", "/api/v5/health")
    
    def __enter__(self):
        """Context manager entry"""
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        """Context manager exit"""
        self.close()
    
    def close(self):
        """Close the client and cleanup resources"""
        if hasattr(self, "_session"):
            self._session.close()