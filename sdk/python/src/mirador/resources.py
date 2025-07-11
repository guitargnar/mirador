"""
Resource classes for different API endpoints
"""
from typing import List, Optional, Dict, Any, Union
from datetime import datetime

from .models import (
    Chain, ChainResponse, Model, Session, Webhook, WebhookEvent,
    ChainType, OutputFormat, WebhookEventType
)


class BaseResource:
    """Base class for API resources"""
    
    def __init__(self, client):
        self.client = client
    
    def _make_request(self, method: str, endpoint: str, **kwargs):
        """Make a request using the client"""
        return self.client._make_request(method, endpoint, **kwargs)


class ChainsResource(BaseResource):
    """Resource for chain operations"""
    
    def list(self) -> List[Chain]:
        """List all available chains"""
        response = self._make_request("GET", "/api/v5/chains")
        return [Chain(**chain) for chain in response.get("chains", [])]
    
    def get(self, chain_type: Union[str, ChainType]) -> Chain:
        """Get information about a specific chain"""
        response = self._make_request("GET", f"/api/v5/chains/{chain_type}")
        return Chain(**response)
    
    def run(
        self,
        chain_type: Union[str, ChainType],
        prompt: str,
        format: Union[str, OutputFormat] = OutputFormat.DETAILED,
        session_id: Optional[str] = None,
        options: Optional[Dict[str, Any]] = None
    ) -> ChainResponse:
        """Run a specific chain"""
        data = {
            "prompt": prompt,
            "format": format,
            "session_id": session_id,
            "options": options or {}
        }
        
        response = self._make_request(
            "POST",
            f"/api/v5/chains/{chain_type}/run",
            data=data
        )
        
        return ChainResponse(**response)


class ModelsResource(BaseResource):
    """Resource for model operations"""
    
    def list(self) -> List[Model]:
        """List all available models"""
        response = self._make_request("GET", "/api/v5/models")
        return [Model(**model) for model in response.get("models", [])]
    
    def get(self, model_name: str) -> Model:
        """Get information about a specific model"""
        response = self._make_request("GET", f"/api/v5/models/{model_name}")
        return Model(**response)
    
    def test(
        self,
        model_name: str,
        prompt: str,
        options: Optional[Dict[str, Any]] = None
    ) -> Dict[str, Any]:
        """Test a specific model"""
        data = {
            "prompt": prompt,
            "options": options or {}
        }
        
        return self._make_request(
            "POST",
            f"/api/v5/models/{model_name}/test",
            data=data
        )
    
    def warm(self, model_names: List[str]) -> Dict[str, bool]:
        """Pre-warm models for faster first response"""
        data = {"models": model_names}
        response = self._make_request("POST", "/api/v5/models/warm", data=data)
        return response.get("results", {})


class SessionsResource(BaseResource):
    """Resource for session operations"""
    
    def create(
        self,
        name: Optional[str] = None,
        metadata: Optional[Dict[str, Any]] = None
    ) -> Session:
        """Create a new session"""
        data = {
            "name": name,
            "metadata": metadata or {}
        }
        
        response = self._make_request("POST", "/api/v5/sessions", data=data)
        return Session(**response)
    
    def list(
        self,
        limit: int = 100,
        offset: int = 0,
        order_by: str = "created_at",
        order: str = "desc"
    ) -> List[Session]:
        """List sessions"""
        params = {
            "limit": limit,
            "offset": offset,
            "order_by": order_by,
            "order": order
        }
        
        response = self._make_request("GET", "/api/v5/sessions", params=params)
        return [Session(**session) for session in response.get("sessions", [])]
    
    def get(self, session_id: str) -> Session:
        """Get session information"""
        response = self._make_request("GET", f"/api/v5/sessions/{session_id}")
        return Session(**response)
    
    def get_history(self, session_id: str) -> List[Dict[str, Any]]:
        """Get session history"""
        response = self._make_request("GET", f"/api/v5/sessions/{session_id}/history")
        return response.get("history", [])
    
    def update(
        self,
        session_id: str,
        name: Optional[str] = None,
        metadata: Optional[Dict[str, Any]] = None
    ) -> Session:
        """Update session information"""
        data = {}
        if name is not None:
            data["name"] = name
        if metadata is not None:
            data["metadata"] = metadata
        
        response = self._make_request(
            "PUT",
            f"/api/v5/sessions/{session_id}",
            data=data
        )
        
        return Session(**response)
    
    def delete(self, session_id: str) -> bool:
        """Delete a session"""
        self._make_request("DELETE", f"/api/v5/sessions/{session_id}")
        return True


class WebhooksResource(BaseResource):
    """Resource for webhook operations"""
    
    def create(
        self,
        name: str,
        url: str,
        events: List[Union[str, WebhookEventType]],
        active: bool = True,
        headers: Optional[Dict[str, str]] = None,
        transformer: Optional[str] = None,
        retry_config: Optional[Dict[str, Any]] = None
    ) -> Webhook:
        """Create a new webhook"""
        data = {
            "name": name,
            "url": url,
            "events": events,
            "active": active,
            "headers": headers or {},
            "transformer": transformer,
            "retry_config": retry_config or {}
        }
        
        response = self._make_request("POST", "/api/v5/webhooks", data=data)
        return Webhook(**response)
    
    def list(self, active_only: bool = False) -> List[Webhook]:
        """List webhooks"""
        params = {"active_only": active_only} if active_only else {}
        response = self._make_request("GET", "/api/v5/webhooks", params=params)
        return [Webhook(**webhook) for webhook in response.get("webhooks", [])]
    
    def get(self, webhook_id: str) -> Webhook:
        """Get webhook information"""
        response = self._make_request("GET", f"/api/v5/webhooks/{webhook_id}")
        return Webhook(**response)
    
    def update(
        self,
        webhook_id: str,
        name: Optional[str] = None,
        url: Optional[str] = None,
        events: Optional[List[Union[str, WebhookEventType]]] = None,
        active: Optional[bool] = None,
        headers: Optional[Dict[str, str]] = None,
        transformer: Optional[str] = None,
        retry_config: Optional[Dict[str, Any]] = None
    ) -> Webhook:
        """Update a webhook"""
        data = {}
        if name is not None:
            data["name"] = name
        if url is not None:
            data["url"] = url
        if events is not None:
            data["events"] = events
        if active is not None:
            data["active"] = active
        if headers is not None:
            data["headers"] = headers
        if transformer is not None:
            data["transformer"] = transformer
        if retry_config is not None:
            data["retry_config"] = retry_config
        
        response = self._make_request(
            "PUT",
            f"/api/v5/webhooks/{webhook_id}",
            data=data
        )
        
        return Webhook(**response)
    
    def delete(self, webhook_id: str) -> bool:
        """Delete a webhook"""
        self._make_request("DELETE", f"/api/v5/webhooks/{webhook_id}")
        return True
    
    def test(self, webhook_id: str, event_type: Optional[str] = None) -> Dict[str, Any]:
        """Test a webhook"""
        data = {"event_type": event_type} if event_type else {}
        return self._make_request(
            "POST",
            f"/api/v5/webhooks/{webhook_id}/test",
            data=data
        )
    
    def get_deliveries(
        self,
        webhook_id: str,
        limit: int = 100,
        offset: int = 0
    ) -> List[Dict[str, Any]]:
        """Get webhook delivery history"""
        params = {"limit": limit, "offset": offset}
        response = self._make_request(
            "GET",
            f"/api/v5/webhooks/{webhook_id}/deliveries",
            params=params
        )
        return response.get("deliveries", [])