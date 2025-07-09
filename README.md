# 🏰 Mirador - Local AI Orchestration Framework

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-macOS-black)](https://github.com/your-username/mirador)
[![Ollama](https://img.shields.io/badge/Powered%20by-Ollama-blue)](https://ollama.ai)
[![Privacy](https://img.shields.io/badge/Privacy-100%25%20Local-green)](https://github.com/your-username/mirador)

Mirador orchestrates multiple AI models locally to provide comprehensive analysis for complex decision-making. Built on Ollama, it chains specialized models together for deeper, more nuanced responses while keeping all data on your machine.

## ✨ Key Features

- **🔒 100% Local Processing** - Your data never leaves your machine
- **🔗 Multi-Model Chaining** - Orchestrates 89 specialized models for comprehensive analysis
- **🎯 6 Universal Workflows** - Pre-configured chains for common use cases
- **💾 Session Memory** - SQLite-based context persistence across conversations
- **🍎 Apple Silicon Optimized** - Designed for M1/M2/M3 Macs
- **🛡️ Privacy First** - No telemetry, no cloud dependencies, no data collection

## 🚀 Quick Start

```bash
# 1. Install Ollama (if not already installed)
brew install ollama

# 2. Clone Mirador
git clone https://github.com/your-username/mirador.git
cd mirador

# 3. Run setup
./setup_mirador.sh

# 4. Run your first chain
./mirador life_optimization "How can I better balance work and personal projects?"
```

## 🔗 Universal Chains

Mirador provides six pre-configured workflows:

| Chain | Use Case | Example |
|-------|----------|---------|
| `life_optimization` | Personal productivity & wellness | "Plan a balanced week with exercise, work, and family time" |
| `business_acceleration` | Career & business strategy | "Identify opportunities to monetize my skills" |
| `creative_breakthrough` | Innovation & problem-solving | "Design a unique mobile app concept" |
| `relationship_harmony` | Communication & relationships | "Improve team dynamics at work" |
| `technical_mastery` | Technology & programming | "Architect a scalable microservices system" |
| `strategic_synthesis` | Complex multi-domain analysis | "Evaluate career change considering all life factors" |

## 📖 How It Works

Mirador chains multiple specialized models in sequence, with each model adding its expertise:

```
Query → Context Model → Domain Expert → Strategy Model → Implementation Model → Result
         ↓                ↓                ↓                 ↓
     (Understands)   (Analyzes)      (Plans)         (Executes)
```

Each model receives the accumulated context from previous models, creating a rich, multi-perspective analysis.

## 💻 System Requirements

- **OS**: macOS 11+ (Apple Silicon recommended)
- **RAM**: 16GB minimum, 32GB recommended
- **Storage**: 10GB for base models
- **Dependencies**: Ollama, Python 3.8+

## 🛠️ Installation

### Automated Setup (Recommended)
```bash
./setup_mirador.sh
```

### Manual Setup
```bash
# Install dependencies
pip install -r requirements.txt

# Pull required Ollama model
ollama pull llama3.2:latest

# Initialize database
python -m src.setup.init_db

# Run first chain
./mirador strategic_synthesis "What should I focus on this quarter?"
```

## 📚 Documentation

- [Installation Guide](docs/guides/INSTALLATION.md)
- [Creating Custom Models](docs/guides/CUSTOM_MODELS.md)
- [API Reference](docs/technical/API_REFERENCE.md)
- [Architecture Overview](docs/technical/ARCHITECTURE_OVERVIEW.md)

## 🤝 Contributing

Contributions are welcome! Please see our [Contributing Guidelines](CONTRIBUTING.md).

## 📊 Performance

- **Response Time**: 15-60 seconds per chain (varies by complexity)
- **Memory Usage**: 4-6GB active RAM
- **Model Size**: ~150MB per specialized model
- **Context Window**: 8192 tokens

## 🔐 Privacy & Security

- All processing happens locally on your machine
- No internet connection required after model download
- No telemetry or usage tracking
- No API keys or cloud services needed

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [Ollama](https://ollama.ai) for local LLM inference
- Inspired by the need for private, powerful AI tools
- Special thanks to the open-source AI community

---

**Topics**: `ai`, `ollama`, `local-ai`, `macos`, `privacy`, `apple-silicon`, `llm`, `orchestration`, `framework`, `personal-assistant`