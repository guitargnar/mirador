# GraphQL API Guide

The Mirador API provides a GraphQL interface as an alternative to the REST API, offering more flexible queries and real-time subscriptions.

## Overview

GraphQL provides several advantages over REST:
- **Flexible queries**: Request exactly the data you need
- **Single endpoint**: All queries go through `/api/v5/graphql`
- **Type safety**: Strongly typed schema with introspection
- **Real-time updates**: Subscriptions for streaming responses
- **Batching**: Multiple operations in a single request

## Authentication

GraphQL uses the same authentication as the REST API:

```graphql
# Include API key in request headers
{
  "X-API-Key": "mirador_sk_your_key_here"
}
```

## Schema Overview

### Object Types

#### ModelType
Represents an AI model in the system.

```graphql
type ModelType {
  name: String!
  description: String
  type: String!
  version: String!
  parameters: JSON
  capabilities: [String]
  performance: JSON
  createdAt: DateTime
  updatedAt: DateTime
}
```

#### ChainConfigType
Configuration for a chain of models.

```graphql
type ChainConfigType {
  name: String!
  type: ChainTypeEnum!
  description: String
  models: [String]
  defaultOptions: JSON
  supportedFormats: [OutputFormatEnum]
}
```

#### QueryResponseType
Response from query execution.

```graphql
type QueryResponseType {
  id: ID!
  sessionId: String!
  content: String!
  chainType: String
  modelsUsed: [String]
  executionTime: Float!
  tokenCount: Int
  createdAt: DateTime!
  metadata: JSON
  cached: Boolean
}
```

### Enums

#### ChainTypeEnum
Available chain types for processing.

```graphql
enum ChainTypeEnum {
  LIFE_OPTIMIZATION
  BUSINESS_ACCELERATION
  CREATIVE_BREAKTHROUGH
  RELATIONSHIP_HARMONY
  TECHNICAL_MASTERY
  STRATEGIC_SYNTHESIS
  DEEP_ANALYSIS
  GLOBAL_INSIGHT
  RAPID_DECISION
}
```

#### OutputFormatEnum
Output format options.

```graphql
enum OutputFormatEnum {
  QUICK
  SUMMARY
  DETAILED
  EXPORT
}
```

## Common Queries

### List Models

```graphql
query ListModels {
  models {
    name
    description
    type
    version
    capabilities
  }
}
```

### Get Specific Model

```graphql
query GetModel($name: String!) {
  model(name: $name) {
    name
    description
    type
    version
    parameters
    capabilities
    performance
  }
}
```

### List Chains

```graphql
query ListChains {
  chains {
    name
    type
    description
    models
    supportedFormats
  }
}
```

### Get Sessions

```graphql
query GetSessions($limit: Int = 10, $offset: Int = 0) {
  sessions(limit: $limit, offset: $offset) {
    id
    name
    createdAt
    updatedAt
    queryCount
    metadata
  }
}
```

### Get Session History

```graphql
query GetSessionHistory($sessionId: ID!) {
  sessionHistory(sessionId: $sessionId)
}
```

### Get Cache Statistics

```graphql
query GetCacheStats {
  cacheStats {
    enabled
    connected
    memoryUsed
    totalKeys
    hitRate
    namespaces
  }
}
```

## Common Mutations

### Execute Query

```graphql
mutation ExecuteQuery($input: QueryInput!) {
  executeQuery(input: $input) {
    response {
      id
      content
      chainType
      modelsUsed
      executionTime
      tokenCount
      createdAt
      cached
    }
  }
}
```

Variables:
```json
{
  "input": {
    "prompt": "What are the key benefits of GraphQL?",
    "chainType": "TECHNICAL_MASTERY",
    "format": "DETAILED",
    "useCache": true
  }
}
```

### Run Specific Chain

```graphql
mutation RunChain($chainType: ChainTypeEnum!, $input: ChainInput!) {
  runChain(chainType: $chainType, input: $input) {
    response {
      id
      chainType
      sessionId
      results {
        model
        output
        confidence
        executionTime
      }
      summary
      executionTime
      tokensUsed
    }
  }
}
```

### Test Model

```graphql
mutation TestModel($modelName: String!, $input: ModelTestInput!) {
  testModel(modelName: $modelName, input: $input) {
    output
    executionTime
    cached
  }
}
```

### Create Session

```graphql
mutation CreateSession($input: SessionInput) {
  createSession(input: $input) {
    session {
      id
      name
      createdAt
    }
  }
}
```

### Manage Webhooks

```graphql
# Create webhook
mutation CreateWebhook($input: WebhookInput!) {
  createWebhook(input: $input) {
    webhook {
      id
      name
      url
      events
      active
    }
  }
}

# Update webhook
mutation UpdateWebhook($id: ID!, $input: WebhookInput) {
  updateWebhook(id: $id, input: $input) {
    webhook {
      id
      active
    }
  }
}

# Delete webhook
mutation DeleteWebhook($id: ID!) {
  deleteWebhook(id: $id) {
    success
  }
}
```

### Clear Cache

```graphql
mutation ClearCache($namespace: String, $pattern: String) {
  clearCache(namespace: $namespace, pattern: $pattern) {
    cleared
    message
  }
}
```

## Subscriptions

Subscriptions allow real-time streaming of responses.

### Stream Query Execution

```graphql
subscription StreamQuery($query: String!, $chainType: ChainTypeEnum) {
  queryStream(query: $query, chainType: $chainType) {
    content
    stage
    model
    confidence
    timestamp
    metadata
  }
}
```

### Stream Chain Execution

```graphql
subscription StreamChain(
  $chainType: ChainTypeEnum!,
  $prompt: String!,
  $sessionId: String
) {
  chainStream(
    chainType: $chainType,
    prompt: $prompt,
    sessionId: $sessionId
  ) {
    content
    stage
    model
    confidence
    timestamp
  }
}
```

## Using Subscriptions

Subscriptions require a WebSocket connection. Connect to `/socket.io` and emit GraphQL subscription events:

```javascript
// Connect to WebSocket
const socket = io('http://localhost:5000', {
  transports: ['websocket'],
  extraHeaders: {
    'X-API-Key': 'your_api_key'
  }
});

// Subscribe to GraphQL subscription
socket.emit('graphql_subscribe', {
  query: `
    subscription StreamQuery($query: String!) {
      queryStream(query: $query) {
        content
        stage
        model
      }
    }
  `,
  variables: {
    query: "Explain quantum computing"
  }
});

// Listen for data
socket.on('graphql_data', (data) => {
  console.log('Received:', data);
});

// Listen for errors
socket.on('graphql_error', (error) => {
  console.error('Error:', error);
});
```

## Error Handling

GraphQL errors follow a consistent format:

```json
{
  "errors": [
    {
      "message": "Error message",
      "path": ["field", "path"],
      "locations": [{"line": 2, "column": 3}],
      "extensions": {
        "code": "ERROR_CODE",
        "details": {}
      }
    }
  ]
}
```

Common error codes:
- `AUTH_001`: Authentication required
- `AUTH_002`: Invalid API key
- `AUTH_003`: Insufficient permissions
- `VALIDATION_ERROR`: Input validation failed
- `RATE_LIMIT_EXCEEDED`: Too many requests
- `RESOURCE_NOT_FOUND`: Resource not found
- `DEPTH_LIMIT_EXCEEDED`: Query too complex

## Introspection

Query the schema dynamically:

```graphql
query IntrospectionQuery {
  __schema {
    types {
      name
      description
      fields {
        name
        description
        type {
          name
        }
      }
    }
  }
}
```

## GraphQL Playground

Access the interactive GraphQL Playground at `/api/v5/graphql/playground` (development mode only).

The playground provides:
- Schema documentation
- Query autocompletion
- Variable editor
- Query history
- Real-time results

## Best Practices

1. **Use fragments** for reusable field selections:
   ```graphql
   fragment ModelInfo on ModelType {
     name
     description
     type
     version
   }
   
   query {
     models {
       ...ModelInfo
       capabilities
     }
   }
   ```

2. **Batch operations** to reduce network requests:
   ```graphql
   query BatchedQueries {
     models { name }
     chains { type }
     sessions { id }
   }
   ```

3. **Use variables** for dynamic queries:
   ```graphql
   query GetModel($name: String!) {
     model(name: $name) {
       ...ModelInfo
     }
   }
   ```

4. **Limit query depth** to avoid performance issues
5. **Cache queries** when appropriate using the `useCache` parameter

## Migration from REST

| REST Endpoint | GraphQL Query/Mutation |
|--------------|----------------------|
| `GET /models` | `query { models { ... } }` |
| `POST /query` | `mutation { executeQuery(input: ...) { ... } }` |
| `GET /sessions` | `query { sessions { ... } }` |
| `POST /webhooks` | `mutation { createWebhook(input: ...) { ... } }` |

## Performance Considerations

- GraphQL queries are automatically cached based on query and variables
- Use field-specific queries to minimize response size
- Subscriptions maintain persistent connections - use appropriately
- Query depth is limited to prevent abuse
- Rate limiting applies to GraphQL operations