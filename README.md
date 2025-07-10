# 🏰 Mirador - Local AI Orchestration Framework

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-macOS-black)](https://github.com/guitargnar/mirador)
[![Ollama](https://img.shields.io/badge/Powered%20by-Ollama-blue)](https://ollama.ai)
[![Privacy](https://img.shields.io/badge/Privacy-100%25%20Local-green)](https://github.com/guitargnar/mirador)

Mirador orchestrates multiple AI models locally to provide comprehensive analysis for complex decision-making. Built on Ollama, it chains specialized models together for deeper, more nuanced responses while keeping all data on your machine.

## ✨ Key Features

- **🔒 100% Local Processing** - Your data never leaves your machine
- **🔗 Multi-Model Chaining** - Orchestrates 80+ specialized models for comprehensive analysis
- **🌍 Diverse AI Models** - Leverages Llama, Gemma, Qwen, Phi, Command-R, Mistral & DeepSeek
- **🎯 9+ Universal Workflows** - Pre-configured chains for common use cases
- **🤖 Auto-Router** - Intelligent query analysis and chain selection
- **📄 RAG Support** - Document analysis with Command-R 35B
- **💾 Session Memory** - SQLite-based context persistence across conversations
- **🍎 Apple Silicon Optimized** - Designed for M1/M2/M3 Macs
- **🛡️ Privacy First** - No telemetry, no cloud dependencies, no data collection

## 🚀 Quick Start

```bash
# 1. Install Ollama (if not already installed)
brew install ollama

# 2. Clone Mirador
git clone https://github.com/guitargnar/mirador.git
cd mirador

# 3. Run setup (optional - pulls base models)
./setup_mirador.sh

# 4. Try the auto-router (recommended)
./bin/mirador_auto_router.sh "How can I better balance work and personal projects?"

# Or use specific chains:
./mirador-smart-v2 "What are my best opportunities this week?"
./bin/mirador_hybrid_chains.sh synthesis "Complex strategic question" --quality
./bin/mirador_rag_chain.sh document "Summarize key findings" /path/to/document.pdf
```

## 🔗 Chain Types

### Universal Chains (v2)
| Chain | Use Case | Example |
|-------|----------|---------|
| `life_optimization` | Personal productivity & wellness | "Plan a balanced week with exercise, work, and family time" |
| `business_acceleration` | Career & business strategy | "Identify opportunities to monetize my skills" |
| `creative_breakthrough` | Innovation & problem-solving | "Design a unique mobile app concept" |
| `relationship_harmony` | Communication & relationships | "Improve team dynamics at work" |
| `technical_mastery` | Technology & programming | "Architect a scalable microservices system" |
| `strategic_synthesis` | Complex multi-domain analysis | "Evaluate career change considering all life factors" |

### Advanced Chains (v3)
| Chain | Use Case | Example |
|-------|----------|---------|
| `deep_analysis` | Gemma-powered reasoning | "Analyze market trends and implications" |
| `global_insight` | Qwen-powered multilingual | "Cross-cultural business strategy" |
| `rapid_decision` | Phi-powered fast decisions | "Quick pros/cons analysis" |

### Hybrid Chains
| Chain | Model Mix | Best For |
|-------|-----------|----------|
| `synthesis` | Llama + Gemma + Qwen | Multi-perspective analysis |
| `research` | Command-R + Gemma + Mistral | Academic/document research |
| `technical` | DeepSeek + Command-R + Gemma | Code and architecture review |
| `cultural` | Qwen + Gemma + Command-R | Cross-cultural insights |

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
- **RAM**: 16GB minimum, 32GB recommended for large models
- **Storage**: 50-100GB for full model suite
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

- [Advanced Features Guide](ADVANCED_FEATURES.md) - RAG chains, hybrid models, auto-router
- [CLAUDE.md](CLAUDE.md) - Reference for Claude Code instances
- [Model Consolidation](CONSOLIDATED_MODELS.md) - Optimized model reference
- See `docs/` directory for additional guides

## 🤝 Contributing

Contributions are welcome! Please see our [Contributing Guidelines](CONTRIBUTING.md).

## 📊 Performance

- **Response Time**: 5-60 seconds per chain (varies by model size)
- **Memory Usage**: 4-20GB active RAM (depends on model)
- **Model Sizes**: 
  - Small (Llama 3.2): 2GB
  - Medium (Mistral, Phi): 4-8GB
  - Large (Gemma 27B, Qwen 32B, Command-R 35B): 15-20GB
- **Context Window**: 4096-16384 tokens (model dependent)

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