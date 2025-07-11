"""
WebSocket client implementation for Mirador SDK
"""
import json
import logging
import threading
from typing import Optional, Dict, Any, Callable, Iterator
from urllib.parse import urlparse

import websocket

from .exceptions import WebSocketError, AuthenticationError
from .models import StreamToken


logger = logging.getLogger("mirador.websocket")


class WebSocketConnection:
    """
    WebSocket connection for real-time communication with Mirador API
    """
    
    def __init__(
        self,
        client,
        on_message: Optional[Callable[[StreamToken], None]] = None,
        on_error: Optional[Callable[[Exception], None]] = None,
        on_close: Optional[Callable[[], None]] = None
    ):
        self.client = client
        self.on_message = on_message
        self.on_error = on_error
        self.on_close = on_close
        
        self._ws = None
        self._thread = None
        self._connected = False
        self._messages = []
        self._lock = threading.Lock()
        
        # Parse WebSocket URL from base URL
        parsed = urlparse(self.client.config.base_url)
        ws_scheme = "wss" if parsed.scheme == "https" else "ws"
        self._ws_url = f"{ws_scheme}://{parsed.netloc}/ws"
    
    def connect(self):
        """Connect to WebSocket server"""
        if self._connected:
            return
        
        # Build headers
        headers = {}
        if self.client.config.api_key:
            headers["X-API-Key"] = self.client.config.api_key
        elif self.client.config.jwt_token:
            headers["Authorization"] = f"Bearer {self.client.config.jwt_token}"
        
        # Create WebSocket
        self._ws = websocket.WebSocketApp(
            self._ws_url,
            header=headers,
            on_open=self._on_open,
            on_message=self._on_message,
            on_error=self._on_error,
            on_close=self._on_close
        )
        
        # Start connection in background thread
        self._thread = threading.Thread(
            target=self._ws.run_forever,
            kwargs={"ping_interval": 30, "ping_timeout": 10}
        )
        self._thread.daemon = True
        self._thread.start()
        
        # Wait for connection
        import time
        timeout = 5
        start_time = time.time()
        while not self._connected and time.time() - start_time < timeout:
            time.sleep(0.1)
        
        if not self._connected:
            raise WebSocketError("Failed to connect to WebSocket server")
    
    def send_query(self, prompt: str, options: Optional[Dict[str, Any]] = None):
        """Send a query through WebSocket"""
        if not self._connected:
            raise WebSocketError("WebSocket not connected")
        
        message = {
            "type": "query",
            "data": {
                "prompt": prompt,
                "options": options or {}
            }
        }
        
        self._ws.send(json.dumps(message))
        logger.debug(f"Sent query: {prompt}")
    
    def send_command(self, command: str, data: Optional[Dict[str, Any]] = None):
        """Send a command through WebSocket"""
        if not self._connected:
            raise WebSocketError("WebSocket not connected")
        
        message = {
            "type": "command",
            "command": command,
            "data": data or {}
        }
        
        self._ws.send(json.dumps(message))
        logger.debug(f"Sent command: {command}")
    
    def close(self):
        """Close WebSocket connection"""
        if self._ws:
            self._ws.close()
            self._connected = False
        
        if self._thread and self._thread.is_alive():
            self._thread.join(timeout=2)
    
    def _on_open(self, ws):
        """Handle WebSocket open event"""
        self._connected = True
        logger.info("WebSocket connected")
        
        # Send authentication if needed
        if self.client.config.api_key:
            self.send_command("authenticate", {"api_key": self.client.config.api_key})
    
    def _on_message(self, ws, message):
        """Handle WebSocket message"""
        try:
            data = json.loads(message)
            
            if data.get("type") == "error":
                error = data.get("error", "Unknown error")
                if "authentication" in error.lower():
                    raise AuthenticationError(error)
                raise WebSocketError(error)
            
            elif data.get("type") == "token":
                token = StreamToken(**data.get("data", {}))
                
                # Store message
                with self._lock:
                    self._messages.append(token)
                
                # Call callback if provided
                if self.on_message:
                    self.on_message(token)
            
            elif data.get("type") == "complete":
                logger.debug("Query completed")
            
            else:
                logger.debug(f"Received message: {data}")
                
        except json.JSONDecodeError:
            logger.error(f"Failed to parse WebSocket message: {message}")
        except Exception as e:
            logger.error(f"Error handling WebSocket message: {e}")
            if self.on_error:
                self.on_error(e)
    
    def _on_error(self, ws, error):
        """Handle WebSocket error"""
        logger.error(f"WebSocket error: {error}")
        if self.on_error:
            self.on_error(WebSocketError(str(error)))
    
    def _on_close(self, ws, close_status_code, close_msg):
        """Handle WebSocket close"""
        self._connected = False
        logger.info(f"WebSocket closed: {close_status_code} - {close_msg}")
        if self.on_close:
            self.on_close()
    
    def __iter__(self) -> Iterator[StreamToken]:
        """Iterate over received messages"""
        while self._connected or self._messages:
            with self._lock:
                if self._messages:
                    yield self._messages.pop(0)
                else:
                    import time
                    time.sleep(0.01)
    
    def __enter__(self):
        """Context manager entry"""
        self.connect()
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        """Context manager exit"""
        self.close()