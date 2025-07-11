# Mirador API Architecture Analysis

Generated: 2025-07-11T15:55:57.283931
API Version: 5.0.0

## Executive Summary

The Mirador API is a sophisticated, production-ready API layer that provides multiple access patterns to the underlying AI orchestration engine:

- **REST API**: Traditional HTTP endpoints built with Flask/FastAPI
- **GraphQL API**: Flexible query language for complex data fetching
- **WebSocket/Streaming**: Real-time progressive enhancement with <1s latency
- **Caching Layer**: Redis-based distributed cache for performance
- **Authentication**: JWT tokens with role-based access control

## API Statistics

- **REST Endpoints**: 16
- **GraphQL Operations**: 21
- **Streaming Protocols**: 5
- **Chain Types**: 9

## Key Endpoints

### Query Execution
- `POST /api/v5/query` - Smart routing to appropriate chain
- `POST /api/v5/chains/<chain_type>/run` - Direct chain execution
- GraphQL: `ExecuteQuery`, `RunChain` mutations

### Streaming
- WebSocket: `/api/v5/ws` - Real-time streaming
- GraphQL Subscriptions: `query_stream`, `chain_stream`
- Progressive enhancement with 3-stage processing

### Model Testing
- `POST /api/v5/models/<model_name>/test` - Test individual models
- GraphQL: `TestModel` mutation

## Streaming Pipeline

The streaming pipeline implements progressive enhancement for optimal UX:

1. **Quick Response** (<1s): Fast initial response using speed-optimized model
2. **Deep Analysis** (~5s): Enhanced analysis with more capable model
3. **Synthesis** (~10s): Final comprehensive response with personalization

## Chain Mappings

Each API call is routed to one of 9 specialized chain types:
- **life_optimization**: POST /api/v5/chains/life_optimization/run, POST /api/v5/query (with chain_type=life_optimization)
- **business_acceleration**: POST /api/v5/chains/business_acceleration/run, POST /api/v5/query (with chain_type=business_acceleration)
- **creative_breakthrough**: POST /api/v5/chains/creative_breakthrough/run, POST /api/v5/query (with chain_type=creative_breakthrough)
- **relationship_harmony**: POST /api/v5/chains/relationship_harmony/run, POST /api/v5/query (with chain_type=relationship_harmony)
- **technical_mastery**: POST /api/v5/chains/technical_mastery/run, POST /api/v5/query (with chain_type=technical_mastery)
- **strategic_synthesis**: POST /api/v5/chains/strategic_synthesis/run, POST /api/v5/query (with chain_type=strategic_synthesis)
- **deep_analysis**: POST /api/v5/chains/deep_analysis/run, POST /api/v5/query (with chain_type=deep_analysis)
- **global_insight**: POST /api/v5/chains/global_insight/run, POST /api/v5/query (with chain_type=global_insight)
- **rapid_decision**: POST /api/v5/chains/rapid_decision/run, POST /api/v5/query (with chain_type=rapid_decision)

## Performance Optimizations

1. **Caching Strategy**:
   - Query responses: 1 hour TTL
   - Chain results: 30 minutes TTL
   - Model outputs: 15 minutes TTL
   - Session context: 24 hours TTL

2. **Cache Warmup**: Pre-loads common queries for instant responses

3. **Connection Pooling**: Reuses model connections for efficiency

4. **Async Processing**: Non-blocking I/O for scalability

## Security Features

- JWT-based authentication
- Role-based access control (read/admin)
- Rate limiting per tier
- Request validation with Marshmallow/Pydantic
- CORS configuration for web clients

## Architecture Insights

- **Api Design**: Hybrid REST + GraphQL with real-time streaming
- **Performance**: Sub-1s first token latency via progressive enhancement
- **Scalability**: Redis caching, connection pooling, async processing
- **Security**: JWT auth, rate limiting, role-based access control
- **Monitoring**: Health checks, metrics collection, distributed tracing

## Integration Patterns

### REST API Example
```bash
curl -X POST https://api.mirador.ai/api/v5/query \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "What should I focus on today?",
    "chain_type": "life_optimization",
    "format": "quick"
  }'
```

### GraphQL Example
```graphql
mutation ExecuteQuery($input: QueryInput!) {
  executeQuery(input: $input) {
    response {
      id
      content
      chainType
      modelsUsed
      executionTime
    }
  }
}
```

### WebSocket Streaming Example
```javascript
const ws = new WebSocket('wss://api.mirador.ai/api/v5/ws');
ws.send(JSON.stringify({
  type: 'query',
  payload: {
    query: 'Help me plan my day',
    chainType: 'life_optimization'
  }
}));
```

## Monitoring & Health

- `/api/v5/health` - Comprehensive health check
- `/api/v5/metrics` - Performance metrics
- Component-level health monitoring
- Distributed tracing support

## Future Enhancements

1. **GraphQL Federation**: Microservices architecture
2. **gRPC Support**: High-performance binary protocol
3. **API Gateway**: Advanced routing and transformation
4. **Event Sourcing**: Complete audit trail
5. **Multi-region**: Global deployment with edge caching
