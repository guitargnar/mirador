"""
GraphQL schema for Mirador API

Defines the GraphQL types, queries, mutations, and subscriptions
"""
import graphene
from graphene import relay
from graphene_sqlalchemy import SQLAlchemyObjectType, SQLAlchemyConnectionField
from datetime import datetime
from typing import Optional, List

from ..models import User, Session, APIKey
from ..schemas import ChainType, OutputFormat


# Enums
class ChainTypeEnum(graphene.Enum):
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


class OutputFormatEnum(graphene.Enum):
    """Output format options"""
    QUICK = "quick"
    SUMMARY = "summary"
    DETAILED = "detailed"
    EXPORT = "export"


# Object Types
class ModelType(graphene.ObjectType):
    """AI Model type"""
    name = graphene.String(required=True)
    description = graphene.String()
    type = graphene.String(required=True)
    version = graphene.String(required=True)
    parameters = graphene.JSONString()
    capabilities = graphene.List(graphene.String)
    performance = graphene.JSONString()
    created_at = graphene.DateTime()
    updated_at = graphene.DateTime()


class ChainConfigType(graphene.ObjectType):
    """Chain configuration type"""
    name = graphene.String(required=True)
    type = graphene.Field(ChainTypeEnum, required=True)
    description = graphene.String()
    models = graphene.List(graphene.String)
    default_options = graphene.JSONString()
    supported_formats = graphene.List(OutputFormatEnum)


class QueryResponseType(graphene.ObjectType):
    """Query response type"""
    id = graphene.ID(required=True)
    session_id = graphene.String(required=True)
    content = graphene.String(required=True)
    chain_type = graphene.String()
    models_used = graphene.List(graphene.String)
    execution_time = graphene.Float(required=True)
    token_count = graphene.Int()
    created_at = graphene.DateTime(required=True)
    metadata = graphene.JSONString()
    cached = graphene.Boolean()


class ChainResultType(graphene.ObjectType):
    """Chain execution result"""
    model = graphene.String(required=True)
    output = graphene.String(required=True)
    confidence = graphene.Float()
    execution_time = graphene.Float()


class ChainResponseType(graphene.ObjectType):
    """Chain response type"""
    id = graphene.ID(required=True)
    chain_type = graphene.Field(ChainTypeEnum, required=True)
    session_id = graphene.String(required=True)
    results = graphene.List(ChainResultType)
    summary = graphene.String()
    execution_time = graphene.Float(required=True)
    tokens_used = graphene.JSONString()
    created_at = graphene.DateTime(required=True)


class SessionType(graphene.ObjectType):
    """Session type"""
    id = graphene.ID(required=True)
    name = graphene.String()
    created_at = graphene.DateTime(required=True)
    updated_at = graphene.DateTime(required=True)
    query_count = graphene.Int()
    context = graphene.JSONString()
    metadata = graphene.JSONString()


class WebhookType(graphene.ObjectType):
    """Webhook configuration type"""
    id = graphene.ID(required=True)
    name = graphene.String(required=True)
    url = graphene.String(required=True)
    events = graphene.List(graphene.String)
    active = graphene.Boolean()
    headers = graphene.JSONString()
    transformer = graphene.String()
    created_at = graphene.DateTime(required=True)
    updated_at = graphene.DateTime(required=True)
    last_triggered = graphene.DateTime()
    trigger_count = graphene.Int()


class CacheStatsType(graphene.ObjectType):
    """Cache statistics type"""
    enabled = graphene.Boolean(required=True)
    connected = graphene.Boolean()
    memory_used = graphene.String()
    total_keys = graphene.Int()
    hit_rate = graphene.Float()
    namespaces = graphene.JSONString()


class StreamTokenType(graphene.ObjectType):
    """Stream token for subscriptions"""
    content = graphene.String(required=True)
    stage = graphene.String()
    model = graphene.String()
    confidence = graphene.Float()
    timestamp = graphene.DateTime()
    metadata = graphene.JSONString()


# Input Types
class QueryInput(graphene.InputObjectType):
    """Input for query execution"""
    prompt = graphene.String(required=True)
    chain_type = graphene.Field(ChainTypeEnum)
    format = graphene.Field(OutputFormatEnum, default_value="detailed")
    session_id = graphene.String()
    options = graphene.JSONString()
    metadata = graphene.JSONString()
    use_cache = graphene.Boolean(default_value=True)


class ChainInput(graphene.InputObjectType):
    """Input for chain execution"""
    prompt = graphene.String(required=True)
    format = graphene.Field(OutputFormatEnum, default_value="detailed")
    session_id = graphene.String()
    options = graphene.JSONString()
    use_cache = graphene.Boolean(default_value=True)


class ModelTestInput(graphene.InputObjectType):
    """Input for model testing"""
    prompt = graphene.String(required=True)
    options = graphene.JSONString()
    use_cache = graphene.Boolean(default_value=True)


class SessionInput(graphene.InputObjectType):
    """Input for session creation"""
    name = graphene.String()
    metadata = graphene.JSONString()


class WebhookInput(graphene.InputObjectType):
    """Input for webhook creation"""
    name = graphene.String(required=True)
    url = graphene.String(required=True)
    events = graphene.List(graphene.String, required=True)
    active = graphene.Boolean(default_value=True)
    headers = graphene.JSONString()
    transformer = graphene.String()


# Queries
class Query(graphene.ObjectType):
    """Root query type"""
    
    # Models
    models = graphene.List(ModelType, description="List all available models")
    model = graphene.Field(
        ModelType,
        name=graphene.String(required=True),
        description="Get a specific model"
    )
    
    # Chains
    chains = graphene.List(ChainConfigType, description="List all available chains")
    chain = graphene.Field(
        ChainConfigType,
        type=graphene.Field(ChainTypeEnum, required=True),
        description="Get a specific chain configuration"
    )
    
    # Sessions
    sessions = graphene.List(
        SessionType,
        limit=graphene.Int(default_value=100),
        offset=graphene.Int(default_value=0),
        description="List user sessions"
    )
    session = graphene.Field(
        SessionType,
        id=graphene.ID(required=True),
        description="Get a specific session"
    )
    session_history = graphene.List(
        graphene.JSONString,
        session_id=graphene.ID(required=True),
        description="Get session history"
    )
    
    # Webhooks
    webhooks = graphene.List(
        WebhookType,
        active_only=graphene.Boolean(default_value=False),
        description="List webhooks"
    )
    webhook = graphene.Field(
        WebhookType,
        id=graphene.ID(required=True),
        description="Get a specific webhook"
    )
    
    # Cache
    cache_stats = graphene.Field(
        CacheStatsType,
        description="Get cache statistics"
    )
    
    # Health
    health = graphene.JSONString(description="API health status")
    
    def resolve_models(self, info):
        """Resolve list of models"""
        from ..orchestrator import orchestrator_manager
        return orchestrator_manager.list_models()
    
    def resolve_model(self, info, name):
        """Resolve specific model"""
        from ..orchestrator import orchestrator_manager
        return orchestrator_manager.get_model(name)
    
    def resolve_chains(self, info):
        """Resolve list of chains"""
        from ..orchestrator import orchestrator_manager
        return orchestrator_manager.list_chains()
    
    def resolve_chain(self, info, type):
        """Resolve specific chain"""
        from ..orchestrator import orchestrator_manager
        return orchestrator_manager.get_chain(type)
    
    def resolve_sessions(self, info, limit, offset):
        """Resolve user sessions"""
        from ..sessions import session_manager
        user_id = info.context.get('user_id')
        return session_manager.list_sessions(user_id, limit, offset)
    
    def resolve_session(self, info, id):
        """Resolve specific session"""
        from ..sessions import session_manager
        return session_manager.get_session(id)
    
    def resolve_session_history(self, info, session_id):
        """Resolve session history"""
        from ..sessions import session_manager
        return session_manager.get_session_history(session_id)
    
    def resolve_webhooks(self, info, active_only):
        """Resolve webhooks"""
        from ..webhooks import webhook_manager
        user_id = info.context.get('user_id')
        return webhook_manager.list_webhooks(user_id, active_only)
    
    def resolve_webhook(self, info, id):
        """Resolve specific webhook"""
        from ..webhooks import webhook_manager
        return webhook_manager.get_webhook(id)
    
    def resolve_cache_stats(self, info):
        """Resolve cache statistics"""
        from ..cache import cache_manager
        return cache_manager.get_cache_stats()
    
    def resolve_health(self, info):
        """Resolve health status"""
        from ..health import get_health_status
        return get_health_status()


# Mutations
class ExecuteQuery(graphene.Mutation):
    """Execute a query mutation"""
    class Arguments:
        input = QueryInput(required=True)
    
    response = graphene.Field(QueryResponseType)
    
    def mutate(self, info, input):
        """Execute the query"""
        from ..orchestrator import orchestrator_manager
        
        user_id = info.context.get('user_id')
        result = orchestrator_manager.execute_query(
            query=input.prompt,
            chain_type=input.chain_type,
            format_type=input.format,
            session_id=input.session_id,
            user_id=user_id,
            options=input.options,
            metadata=input.metadata,
            use_cache=input.use_cache
        )
        
        return ExecuteQuery(response=QueryResponseType(**result))


class RunChain(graphene.Mutation):
    """Run a specific chain mutation"""
    class Arguments:
        chain_type = graphene.Field(ChainTypeEnum, required=True)
        input = ChainInput(required=True)
    
    response = graphene.Field(ChainResponseType)
    
    def mutate(self, info, chain_type, input):
        """Run the chain"""
        from ..orchestrator import orchestrator_manager
        
        user_id = info.context.get('user_id')
        result = orchestrator_manager.execute_chain(
            chain_type=chain_type,
            prompt=input.prompt,
            format_type=input.format,
            session_id=input.session_id,
            user_id=user_id,
            options=input.options,
            use_cache=input.use_cache
        )
        
        return RunChain(response=ChainResponseType(**result))


class TestModel(graphene.Mutation):
    """Test a model mutation"""
    class Arguments:
        model_name = graphene.String(required=True)
        input = ModelTestInput(required=True)
    
    output = graphene.String()
    execution_time = graphene.Float()
    cached = graphene.Boolean()
    
    def mutate(self, info, model_name, input):
        """Test the model"""
        from ..orchestrator import orchestrator_manager
        
        result = orchestrator_manager.test_model(
            model_name=model_name,
            prompt=input.prompt,
            options=input.options,
            use_cache=input.use_cache
        )
        
        return TestModel(
            output=result['output'],
            execution_time=result.get('execution_time'),
            cached=result.get('cached', False)
        )


class CreateSession(graphene.Mutation):
    """Create a new session mutation"""
    class Arguments:
        input = SessionInput()
    
    session = graphene.Field(SessionType)
    
    def mutate(self, info, input=None):
        """Create session"""
        from ..sessions import session_manager
        
        user_id = info.context.get('user_id')
        session = session_manager.create_session(
            user_id=user_id,
            name=input.name if input else None,
            metadata=input.metadata if input else None
        )
        
        return CreateSession(session=SessionType(**session))


class CreateWebhook(graphene.Mutation):
    """Create a webhook mutation"""
    class Arguments:
        input = WebhookInput(required=True)
    
    webhook = graphene.Field(WebhookType)
    
    def mutate(self, info, input):
        """Create webhook"""
        from ..webhooks import webhook_manager
        
        user_id = info.context.get('user_id')
        webhook = webhook_manager.create_webhook(
            user_id=user_id,
            name=input.name,
            url=input.url,
            events=input.events,
            active=input.active,
            headers=input.headers,
            transformer=input.transformer
        )
        
        return CreateWebhook(webhook=WebhookType(**webhook))


class UpdateWebhook(graphene.Mutation):
    """Update a webhook mutation"""
    class Arguments:
        id = graphene.ID(required=True)
        input = WebhookInput()
    
    webhook = graphene.Field(WebhookType)
    
    def mutate(self, info, id, input):
        """Update webhook"""
        from ..webhooks import webhook_manager
        
        webhook = webhook_manager.update_webhook(
            webhook_id=id,
            **input
        )
        
        return UpdateWebhook(webhook=WebhookType(**webhook))


class DeleteWebhook(graphene.Mutation):
    """Delete a webhook mutation"""
    class Arguments:
        id = graphene.ID(required=True)
    
    success = graphene.Boolean()
    
    def mutate(self, info, id):
        """Delete webhook"""
        from ..webhooks import webhook_manager
        
        success = webhook_manager.delete_webhook(id)
        return DeleteWebhook(success=success)


class ClearCache(graphene.Mutation):
    """Clear cache mutation"""
    class Arguments:
        namespace = graphene.String()
        pattern = graphene.String()
        user_id = graphene.String()
        session_id = graphene.String()
    
    cleared = graphene.Int()
    message = graphene.String()
    
    def mutate(self, info, namespace=None, pattern=None, user_id=None, session_id=None):
        """Clear cache"""
        from ..cache import cache_manager
        
        # Admin check for clearing other users' cache
        current_user = info.context.get('user')
        if user_id and user_id != current_user['id'] and current_user['role'] != 'admin':
            raise Exception("Unauthorized to clear other users' cache")
        
        cleared = 0
        if user_id:
            cleared = cache_manager.invalidate_user(user_id)
        elif session_id:
            cleared = cache_manager.invalidate_session(session_id)
        elif pattern:
            cleared = cache_manager.delete_pattern(pattern)
        elif namespace:
            cleared = cache_manager.delete_pattern(f"{namespace}:*")
        
        return ClearCache(
            cleared=cleared,
            message=f"Cleared {cleared} cache entries"
        )


class Mutation(graphene.ObjectType):
    """Root mutation type"""
    execute_query = ExecuteQuery.Field()
    run_chain = RunChain.Field()
    test_model = TestModel.Field()
    create_session = CreateSession.Field()
    create_webhook = CreateWebhook.Field()
    update_webhook = UpdateWebhook.Field()
    delete_webhook = DeleteWebhook.Field()
    clear_cache = ClearCache.Field()


# Subscriptions
class Subscription(graphene.ObjectType):
    """Root subscription type"""
    
    query_stream = graphene.Field(
        StreamTokenType,
        query=graphene.String(required=True),
        chain_type=graphene.Field(ChainTypeEnum),
        session_id=graphene.String(),
        description="Subscribe to streaming query responses"
    )
    
    chain_stream = graphene.Field(
        StreamTokenType,
        chain_type=graphene.Field(ChainTypeEnum, required=True),
        prompt=graphene.String(required=True),
        session_id=graphene.String(),
        description="Subscribe to streaming chain execution"
    )
    
    async def resolve_query_stream(self, info, query, chain_type=None, session_id=None):
        """Stream query execution"""
        from ..streaming import streaming_orchestrator
        
        user_id = info.context.get('user_id')
        async for token in streaming_orchestrator.stream_query(
            query=query,
            chain_type=chain_type,
            session_id=session_id,
            user_id=user_id
        ):
            yield StreamTokenType(
                content=token.content,
                stage=token.stage,
                model=token.model,
                confidence=token.confidence,
                timestamp=token.timestamp,
                metadata=token.metadata
            )
    
    async def resolve_chain_stream(self, info, chain_type, prompt, session_id=None):
        """Stream chain execution"""
        from ..streaming import streaming_orchestrator
        
        user_id = info.context.get('user_id')
        async for token in streaming_orchestrator.stream_chain(
            chain_type=chain_type,
            prompt=prompt,
            session_id=session_id,
            user_id=user_id
        ):
            yield StreamTokenType(
                content=token.content,
                stage=token.stage,
                model=token.model,
                confidence=token.confidence,
                timestamp=token.timestamp,
                metadata=token.metadata
            )


# Create schema
schema = graphene.Schema(
    query=Query,
    mutation=Mutation,
    subscription=Subscription
)