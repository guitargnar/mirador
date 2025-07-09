# 🏰 Mirador - Local AI Orchestration Framework

[\![Version](https://img.shields.io/badge/Version-5.0.0-gold?style=for-the-badge)](https://github.com/guitargnar/mirador/releases)
[\![Privacy](https://img.shields.io/badge/Privacy-Local%20Only-green?style=for-the-badge)](https://github.com/guitargnar/mirador)
[\![Platform](https://img.shields.io/badge/Platform-Apple%20Silicon-black?style=for-the-badge&logo=apple)](https://github.com/guitargnar/mirador)

Mirador is a local AI orchestration framework that coordinates multiple specialized models to provide comprehensive analysis for complex decision-making and creative problem-solving.

## Features

- 🔒 **100% Local Processing** - All AI runs on your machine via Ollama
- 🧠 **89 Specialized Models** - Domain-specific AI models for comprehensive analysis  
- 🔗 **6 Universal Chains** - Pre-configured workflows for common use cases
- 📊 **Session Memory** - SQLite-based context persistence
- 🍎 **Apple Silicon Optimized** - Designed for M1/M2/M3 Macs

## Quick Start

```bash
# Install
./setup_mirador.sh

# Run a chain
./mirador life_optimization "How do I balance work and personal projects?"
```

## Requirements

- macOS with Apple Silicon
- [Ollama](https://ollama.ai) installed
- Python 3.8+
- 16GB+ RAM recommended

## Documentation

See the [docs](docs/) directory for detailed guides and technical documentation.

## License

MIT License - see [LICENSE](LICENSE) file
EOF < /dev/null