"""
Data models for Mirador SDK
"""
from typing import Optional, List, Dict, Any, Union
from datetime import datetime
from enum import Enum
from pydantic import BaseModel, Field, ConfigDict


class ChainType(str, Enum):
    """Available chain types"""
    LIFE_OPTIMIZATION = "life_optimization"
    BUSINESS_ACCELERATION = "business_acceleration"
    CREATIVE_BREAKTHROUGH = "creative_breakthrough"
    RELATIONSHIP_HARMONY = "relationship_harmony"
    TECHNICAL_MASTERY = "technical_mastery"
    STRATEGIC_SYNTHESIS = "strategic_synthesis"
    DEEP_ANALYSIS = "deep_analysis"
    GLOBAL_INSIGHT = "global_insight"
    RAPID_DECISION = "rapid_decision"


class OutputFormat(str, Enum):
    """Output format options"""
    QUICK = "quick"
    SUMMARY = "summary"
    DETAILED = "detailed"
    EXPORT = "export"


class WebhookEventType(str, Enum):
    """Webhook event types"""
    QUERY_STARTED = "query_started"
    QUERY_COMPLETED = "query_completed"
    QUERY_FAILED = "query_failed"
    CHAIN_STARTED = "chain_started"
    CHAIN_COMPLETED = "chain_completed"
    CHAIN_FAILED = "chain_failed"
    MODEL_STARTED = "model_started"
    MODEL_COMPLETED = "model_completed"
    MODEL_FAILED = "model_failed"
    STREAM_STARTED = "stream_started"
    STREAM_TOKEN = "stream_token"
    STREAM_COMPLETED = "stream_completed"
    STREAM_FAILED = "stream_failed"


class Query(BaseModel):
    """Query request model"""
    prompt: str
    chain_type: Optional[ChainType] = None
    format: OutputFormat = OutputFormat.DETAILED
    session_id: Optional[str] = None
    options: Dict[str, Any] = Field(default_factory=dict)
    metadata: Dict[str, Any] = Field(default_factory=dict)

    model_config = ConfigDict(use_enum_values=True)


class StreamToken(BaseModel):
    """Streaming token model"""
    content: str
    stage: Optional[str] = None
    model: Optional[str] = None
    confidence: float = 1.0
    timestamp: datetime = Field(default_factory=datetime.utcnow)
    metadata: Dict[str, Any] = Field(default_factory=dict)


class QueryResponse(BaseModel):
    """Query response model"""
    id: str
    session_id: str
    content: str
    chain_type: Optional[str] = None
    models_used: List[str] = Field(default_factory=list)
    execution_time: float
    token_count: Optional[int] = None
    created_at: datetime
    metadata: Dict[str, Any] = Field(default_factory=dict)


class Chain(BaseModel):
    """Chain configuration model"""
    name: str
    type: ChainType
    description: str
    models: List[str]
    default_options: Dict[str, Any] = Field(default_factory=dict)
    supported_formats: List[OutputFormat] = Field(default_factory=list)
    
    model_config = ConfigDict(use_enum_values=True)


class ChainResponse(BaseModel):
    """Chain execution response"""
    id: str
    chain_type: str
    session_id: str
    results: List[Dict[str, Any]]
    summary: Optional[str] = None
    execution_time: float
    tokens_used: Dict[str, int] = Field(default_factory=dict)
    created_at: datetime


class Model(BaseModel):
    """Model information"""
    name: str
    description: Optional[str] = None
    type: str
    version: str
    parameters: Dict[str, Any] = Field(default_factory=dict)
    capabilities: List[str] = Field(default_factory=list)
    performance: Dict[str, float] = Field(default_factory=dict)
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None


class Session(BaseModel):
    """Session model"""
    id: str
    name: Optional[str] = None
    created_at: datetime
    updated_at: datetime
    query_count: int = 0
    context: Dict[str, Any] = Field(default_factory=dict)
    metadata: Dict[str, Any] = Field(default_factory=dict)


class Webhook(BaseModel):
    """Webhook configuration"""
    id: str
    name: str
    url: str
    events: List[WebhookEventType]
    active: bool = True
    headers: Dict[str, str] = Field(default_factory=dict)
    transformer: Optional[str] = None
    retry_config: Dict[str, Any] = Field(default_factory=dict)
    created_at: datetime
    updated_at: datetime
    last_triggered: Optional[datetime] = None
    trigger_count: int = 0
    
    model_config = ConfigDict(use_enum_values=True)


class WebhookEvent(BaseModel):
    """Webhook event data"""
    id: str
    type: WebhookEventType
    session_id: Optional[str] = None
    data: Dict[str, Any]
    timestamp: datetime = Field(default_factory=datetime.utcnow)
    
    model_config = ConfigDict(use_enum_values=True)


class ErrorResponse(BaseModel):
    """Error response model"""
    error: str
    code: Optional[str] = None
    message: str
    details: Optional[Dict[str, Any]] = None
    request_id: Optional[str] = None
    timestamp: datetime = Field(default_factory=datetime.utcnow)