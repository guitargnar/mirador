# 🚀 MIRADOR AI Framework

> **M**ulti-model **I**ntelligent **R**esponse **A**rchitecture for **D**ynamic **O**rchestrated **R**easoning

MIRADOR is an advanced AI orchestration framework that enables sophisticated multi-model chains, allowing different AI specialists to collaborate on complex tasks. Think of it as conducting an orchestra of AI models, where each musician (model) contributes their unique expertise to create a harmonious solution.

## 🌟 Key Features

- **🎭 Multi-Model Orchestration**: Chain multiple AI models together for comprehensive solutions
- **🤖 17 Specialized Models**: From code generation to business strategy to music theory
- **🔗 Intelligent Handoffs**: Each model builds upon the previous model's output
- **📊 Automatic Categorization**: Outputs are organized by type (technical, business, creative, etc.)
- **💾 Persistent Results**: All outputs saved with detailed contribution tracking
- **🚀 Global Access**: Use from anywhere with the `mirador-ez` command

## 🎯 What Makes MIRADOR Special?

Unlike single-model AI interactions, MIRADOR enables:
- **Specialist Collaboration**: A code expert can hand off to a business strategist
- **Emergent Solutions**: Chains often produce insights beyond individual model capabilities  
- **Quality Iteration**: Code can be generated, reviewed, and optimized in one flow
- **Cross-Domain Synthesis**: Combine technical, creative, and strategic thinking

## 📁 Project Structure

```
/Users/matthewscott/projects/mirador/
├── mirador.py                    # Main orchestration engine
├── requirements.txt               # Python dependencies
├── *.modelfile                    # Model configurations
│   ├── master_coder.modelfile
│   ├── code_reviewer_fix.modelfile
│   ├── creative_entrepreneur.modelfile
│   ├── guitar_expert_precise.modelfile
│   └── fast_agent_focused.modelfile
└── outputs/                       # Chain results (symlinked)

/Users/matthewscott/ai_framework_git/outputs/
└── chain_[timestamp]/             # Individual chain outputs
    ├── summary.md                 # Final synthesized result
    ├── model_1_output.md          # Individual model contributions
    ├── model_2_output.md
    └── ...

/usr/local/bin/
└── mirador-ez                     # Global command launcher
```

## 🚀 Quick Start

```bash
# List available models
mirador-ez models

# Ask a single model
mirador-ez ask enhanced_agent "Explain quantum computing"

# Run a multi-model chain
mirador-ez chain "Build a web app" master_coder ux_designer creative_entrepreneur

# View help
mirador-ez --help
```

## 🤖 Available Models

### Custom Specialists
- `master_coder` - Senior software engineering expert
- `code_reviewer_fix` - Code analysis and optimization specialist
- `creative_entrepreneur` - Business strategy and monetization expert
- `guitar_expert_precise` - Guitar techniques and music theory master
- `fast_agent_focused` - Quick, concise response specialist

### Enhanced Models
- `enhanced_agent` - Deep analysis and comprehensive research
- `llama3.2_balanced` - Balanced general-purpose assistant
- `ux_designer` - User interface and experience design expert

### Base Models
- `llama3.2`, `mistral`, `codellama` - Foundation models
- `deepseek-extended`, `deepseek-coder-lowtemp` - Specialized variants

## 📚 Documentation

- [Usage Instructions](./USAGE.md) - Detailed command guide and examples
- [Technical Documentation](./TECHNICAL.md) - Setup, configuration, and architecture
- [Model Reference](./MODELS.md) - Detailed model capabilities and best practices

## 🎪 Example Use Cases

### Full-Stack Development
```bash
mirador-ez chain "E-commerce platform" master_coder ux_designer creative_entrepreneur code_reviewer_fix
```

### Business Strategy
```bash
mirador-ez chain "AI startup idea" creative_entrepreneur enhanced_agent master_coder
```

### Creative Projects
```bash
mirador-ez chain "Guitar learning app" guitar_expert_precise master_coder ux_designer creative_entrepreneur
```

## 🛠️ Requirements

- macOS (tested on Mac)
- Python 3.8+
- Ollama (for model management)
- 16GB+ RAM recommended
- Active internet connection for model downloads

## 📝 License

This project is for personal/educational use. Model licenses vary - check Ollama documentation.

## 🙏 Acknowledgments

Built on top of Ollama's excellent model management system. Special thanks to the open-source AI community.

---

**Created by**: Matthew Scott  
**Location**: Louisville, Kentucky  
**Version**: 1.0 (June 2025)