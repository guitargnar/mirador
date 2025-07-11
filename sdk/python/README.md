# Mirador Python SDK

The official Python SDK for the Mirador AI Orchestration Platform.

## Installation

```bash
pip install mirador-sdk
```

For async support:
```bash
pip install mirador-sdk[async]
```

## Quick Start

```python
from mirador import MiradorClient

# Initialize the client
client = MiradorClient(
    api_key="your-api-key",
    base_url="https://api.mirador.ai"  # Optional, defaults to localhost
)

# Run a simple query
response = client.query("Help me optimize my daily schedule")
print(response.content)

# Run a specific chain
result = client.chains.run(
    "life_optimization",
    "What are my top priorities for personal growth?",
    format="detailed"
)

# Stream responses
for token in client.stream("Explain quantum computing"):
    print(token.content, end="", flush=True)
```

## Features

### Authentication

```python
# API Key authentication (recommended)
client = MiradorClient(api_key="your-api-key")

# JWT authentication
client = MiradorClient(jwt_token="your-jwt-token")
```

### Chain Execution

```python
# Run a chain with options
result = client.chains.run(
    chain_type="business_acceleration",
    prompt="How can I improve my startup's growth?",
    format="summary",
    options={
        "temperature": 0.7,
        "max_tokens": 2000
    }
)

# List available chains
chains = client.chains.list()
for chain in chains:
    print(f"{chain.name}: {chain.description}")
```

### Streaming Responses

```python
# Server-Sent Events streaming
for event in client.stream("Generate a business plan"):
    print(f"[{event.stage}] {event.content}")

# WebSocket streaming (async)
import asyncio

async def stream_websocket():
    async with client.websocket() as ws:
        await ws.send_query("Real-time analysis needed")
        async for message in ws:
            print(f"Received: {message}")

asyncio.run(stream_websocket())
```

### Model Management

```python
# List available models
models = client.models.list()

# Get model info
model = client.models.get("matthew_context_provider_v6")
print(f"Model: {model.name}, Parameters: {model.parameters}")

# Test a specific model
response = client.models.test(
    "universal_strategy_architect",
    "Create a 5-year plan"
)
```

### Session Management

```python
# Create a persistent session
session = client.sessions.create(name="Strategic Planning")

# Continue in the same session
response = client.query(
    "What should I focus on first?",
    session_id=session.id
)

# List sessions
sessions = client.sessions.list()

# Get session history
history = client.sessions.get_history(session.id)
```

### Webhooks

```python
# Register a webhook
webhook = client.webhooks.create(
    name="Slack Notifier",
    url="https://hooks.slack.com/services/YOUR/WEBHOOK/URL",
    events=["query_completed", "chain_completed"],
    transformer="slack"
)

# List webhooks
webhooks = client.webhooks.list()

# Update webhook
client.webhooks.update(
    webhook.id,
    active=False
)

# Delete webhook
client.webhooks.delete(webhook.id)
```

### Error Handling

```python
from mirador import MiradorError, RateLimitError, AuthenticationError

try:
    response = client.query("Complex analysis")
except RateLimitError as e:
    print(f"Rate limited. Retry after: {e.retry_after} seconds")
except AuthenticationError:
    print("Invalid API key")
except MiradorError as e:
    print(f"API error: {e.message}")
```

### Async Support

```python
import asyncio
from mirador import AsyncMiradorClient

async def main():
    async with AsyncMiradorClient(api_key="your-key") as client:
        # Async query
        response = await client.query("Async analysis")
        
        # Async streaming
        async for token in client.stream("Stream this"):
            print(token.content)
        
        # Concurrent requests
        tasks = [
            client.query("Query 1"),
            client.query("Query 2"),
            client.query("Query 3")
        ]
        results = await asyncio.gather(*tasks)

asyncio.run(main())
```

## Advanced Usage

### Custom Headers

```python
client = MiradorClient(
    api_key="your-key",
    headers={
        "X-Custom-Header": "value"
    }
)
```

### Timeout Configuration

```python
client = MiradorClient(
    api_key="your-key",
    timeout=30,  # Default timeout in seconds
    streaming_timeout=300  # Timeout for streaming requests
)
```

### Retry Configuration

```python
from mirador import RetryConfig

client = MiradorClient(
    api_key="your-key",
    retry_config=RetryConfig(
        max_retries=3,
        backoff_factor=2,
        retry_on=[500, 502, 503, 504]
    )
)
```

### Logging

```python
import logging

# Enable debug logging
logging.basicConfig(level=logging.DEBUG)

# Or configure specific logger
logger = logging.getLogger("mirador")
logger.setLevel(logging.INFO)
```

## CLI Tool

The SDK includes a CLI tool for quick interactions:

```bash
# Configure credentials
mirador configure

# Run a query
mirador query "What should I work on today?"

# Run a specific chain
mirador chain life_optimization "How can I improve my health?"

# List available models
mirador models list

# Stream a response
mirador stream "Explain machine learning"
```

## Development

### Running Tests

```bash
# Install dev dependencies
pip install -e .[dev]

# Run tests
pytest

# Run with coverage
pytest --cov=mirador
```

### Type Checking

```bash
mypy src/mirador
```

### Code Formatting

```bash
# Format code
black src/mirador

# Sort imports
isort src/mirador
```

## License

MIT License - see LICENSE file for details.

## Support

- Documentation: https://docs.mirador.ai
- Issues: https://github.com/mirador-ai/python-sdk/issues
- Email: support@mirador.ai