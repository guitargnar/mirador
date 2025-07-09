# 🏰 Mirador - Local AI Orchestration Framework

[![Version](https://img.shields.io/badge/Version-5.0.0-gold?style=for-the-badge)](https://github.com/your-username/mirador/releases)
[![Privacy](https://img.shields.io/badge/Privacy-Local%20Only-green?style=for-the-badge&logo=shield)](https://github.com/your-username/mirador)
[![Chains](https://img.shields.io/badge/Universal%20Chains-6-blue?style=for-the-badge&logo=link)](https://github.com/your-username/mirador)
[![Platform](https://img.shields.io/badge/Platform-Apple%20Silicon-black?style=for-the-badge&logo=apple)](https://github.com/your-username/mirador)

## What is Mirador?

**Mirador** (Spanish: "watchtower") is a local AI orchestration framework that runs entirely on your machine. It coordinates multiple specialized AI models through Ollama to provide comprehensive analysis for complex decision-making and creative problem-solving.

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/your-username/mirador.git
cd mirador

# Run a universal chain (requires Ollama)
./mirador_universal_runner.sh life_optimization "How do I balance work, family, and personal projects?"
```

## 🎯 Features

### Six Universal Chains
- **life_optimization** - Holistic life improvement strategies
- **business_acceleration** - Career and business growth
- **creative_breakthrough** - Innovation and artistic projects
- **relationship_harmony** - Personal and professional relationships
- **technical_mastery** - Technology and automation solutions
- **strategic_synthesis** - Complex multi-domain analysis

### Privacy-First Architecture
- 🔒 100% local processing via Ollama
- 🚫 Zero data leaves your machine
- 🍎 Optimized for Apple Silicon
- 📊 No analytics or tracking

## 💻 Requirements

- macOS with Apple Silicon (M1/M2/M3)
- Ollama installed locally
- 16GB+ RAM recommended
- ~10GB storage for models

## 🛠️ Installation

1. Install Ollama: https://ollama.ai
2. Clone this repository
3. Run setup script: `./setup_mirador.sh`
4. Start using the chains!

## 📖 How It Works

Mirador orchestrates multiple AI models in sequence, with each model adding context and refinement:

```
User Query → Context Provider → Domain Expert → Strategy Model → Implementation Model → Actionable Output
```

The framework includes:
- 89 specialized AI models
- 6 universal chain types
- Context accumulation between models
- Session archiving and feedback system

## 🎨 Example Use Cases

### Personal Planning
```bash
./mirador_universal_runner.sh life_optimization "Plan my week to include exercise, family time, and project work"
```

### Creative Projects
```bash
./mirador_universal_runner.sh creative_breakthrough "Help me develop a concept for a mobile app that solves a real problem"
```

### Technical Solutions
```bash
./mirador_universal_runner.sh technical_mastery "Design a backup strategy for my personal data"
```

## 🔧 Customization

### Creating Custom Models
1. Copy an existing modelfile as template
2. Modify the system prompt for your use case
3. Create with: `ollama create your_model -f your_modelfile`
4. Add to a chain in the runner scripts

### Adjusting Parameters
- Temperature: 0.7 (balanced creativity/accuracy)
- Context window: 8192 tokens
- Top-p: 0.9 for diverse responses

## 📊 Performance

- Response time: 15-60 seconds per chain
- Memory usage: ~4-6GB active
- Storage: ~150MB per model
- Accuracy: Optimized for thoughtfulness over speed

## 🤝 Contributing

This is a personal project, but contributions are welcome:

1. Fork the repository
2. Create a feature branch
3. Ensure changes maintain local-only processing
4. Submit a pull request

## ⚠️ Limitations

- Requires significant local computing resources
- Not suitable for real-time applications
- Context limited to 8192 tokens per model
- No cloud sync or collaboration features

## 📜 License

MIT License - See [LICENSE](LICENSE) file

## 🙏 Acknowledgments

- Built during 8 weeks of focused development
- Inspired by the need for private, powerful AI tools
- Thanks to the Ollama team for making local AI accessible

---

**Note**: This is a personal project for local AI experimentation. All processing happens on your machine. Your data stays yours.

For questions or issues: [Create an issue](https://github.com/your-username/mirador/issues)