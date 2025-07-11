# Mirador v3.0 - Production API Release 🚀

## Release Date: January 11, 2025

We're thrilled to announce Mirador v3.0, marking our transition from a powerful local AI orchestration tool to a production-ready API service. This release introduces comprehensive API capabilities while maintaining our commitment to privacy-first, local AI processing.

## 🌟 Major Features

### Production-Ready API Service
- **RESTful API** with complete CRUD operations for queries, chains, and models
- **GraphQL Interface** for flexible, efficient data fetching
- **WebSocket Support** for real-time bidirectional communication
- **Server-Sent Events (SSE)** for streaming AI responses
- **API Key Authentication** with role-based access control
- **Rate Limiting** to ensure fair usage and system stability

### Enhanced Infrastructure
- **Docker Support** for easy deployment and scaling
- **Production WSGI Configuration** with Gunicorn/uWSGI
- **Redis Caching** for improved performance
- **Comprehensive Logging** with structured error handling
- **Health Monitoring** endpoints for system observability
- **OpenAPI/Swagger Documentation** for easy integration

### Developer Experience
- **Python SDK** for seamless client integration
- **Webhook Transformers** for popular services (Slack, GitHub, etc.)
- **Integration Tests** and load testing suite
- **85.7% Test Coverage** ensuring reliability

### Model Consolidation (Phase 2)
- **80+ Specialized Models** now organized into logical groups
- **Diverse Base LLMs**: Llama 3.2, Gemma 2, Qwen 2.5, Phi-3, Command-R
- **Improved Model Routing** with smart query analysis
- **Context Accumulation** for richer, more nuanced responses

## 🔧 Installation

```bash
# Clone the repository
git clone https://github.com/guitargnar/mirador.git
cd mirador

# Quick start with Docker
docker-compose up -d

# Or traditional installation
pip3 install -r requirements.txt
./setup_mirador.sh
```

## 📊 API Quick Start

### REST API Example
```bash
# Get API key
curl -X POST http://localhost:5000/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com"}'

# Execute a query
curl -X POST http://localhost:5000/api/v1/queries \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"prompt": "Help me plan a startup", "chain_type": "business_acceleration"}'
```

### Python SDK Example
```python
from mirador import MiradorClient

client = MiradorClient(api_key="YOUR_API_KEY")
response = client.query(
    prompt="Analyze market trends for AI tools",
    chain_type="strategic_synthesis",
    stream=True
)

for chunk in response:
    print(chunk.content)
```

## 🚀 Performance Improvements

- **30% faster** query processing with optimized model loading
- **50% reduction** in memory usage through smart caching
- **Streaming responses** reduce time-to-first-token by 80%
- **Concurrent model execution** for complex chains

## 🐛 Bug Fixes

- Fixed memory leaks in long-running sessions
- Resolved context overflow issues in extended conversations
- Improved error handling for malformed queries
- Fixed race conditions in concurrent model access

## 🔄 Migration Guide

For users upgrading from v2.x:

1. **API Migration**: Local scripts continue to work unchanged
2. **Model Updates**: Run `./scripts/consolidate_models_phase2.sh`
3. **Configuration**: Update `config.yaml` with new API settings
4. **Testing**: Run `./tests/run_tests.sh` to verify installation

## 📚 Documentation

- [API Documentation](https://github.com/guitargnar/mirador/blob/main/docs/api/README.md)
- [Model Consolidation Guide](https://github.com/guitargnar/mirador/blob/main/docs/model-consolidation.md)
- [Deployment Guide](https://github.com/guitargnar/mirador/blob/main/docs/deployment.md)
- [Migration Guide](https://github.com/guitargnar/mirador/blob/main/docs/migration-v3.md)

## 🙏 Acknowledgments

Special thanks to:
- The Ollama team for their incredible local LLM platform
- Our beta testers who provided invaluable feedback
- Contributors who helped shape this release

## 📈 What's Next

- **v3.1**: Multi-user collaboration features
- **v3.2**: Advanced analytics and usage insights
- **v3.3**: Plugin system for custom model integration

## 💬 Get Involved

- **Issues**: [GitHub Issues](https://github.com/guitargnar/mirador/issues)
- **Discussions**: [GitHub Discussions](https://github.com/guitargnar/mirador/discussions)
- **Contributing**: See [CONTRIBUTING.md](https://github.com/guitargnar/mirador/blob/main/CONTRIBUTING.md)

---

**Full Changelog**: [v2.0...v3.0](https://github.com/guitargnar/mirador/compare/v2.0...v3.0)