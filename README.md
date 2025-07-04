<div align="center">
  <img src="assets/brand/logo/mirador-logo.svg" alt="Mirador Logo" width="300"/>
  
  **A sophisticated multi-agent AI system that chains specialized language models for personalized, actionable insights aligned with your unique personality, goals, and context.**
  
  [![Version](https://img.shields.io/badge/version-2.0-7B9E89)](https://github.com/guitargnar/mirador)
  [![License](https://img.shields.io/badge/license-Private-D17A47)](LICENSE)
  [![AI Models](https://img.shields.io/badge/models-79+-1B3A33)](docs/models.md)
  [![Response Time](https://img.shields.io/badge/response-5--25s-7B9E89)](docs/performance.md)
</div>

---

## 🏗️ Architecture

<div align="center">

```
┌─────────────────────────────────────────────────────────┐
│                  User Interface Layer                    │
│          (mirador-smart-v2, mirador-ez, CLI)           │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────┴───────────────────────────────┐
│              Orchestration & Chain Logic                 │
│        (Smart routing, Chain execution, Memory)         │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────┴───────────────────────────────┐
│                 Specialized AI Models                    │
│    Matthew Context │ Financial Expert │ Louisville Expert│
│    Enhanced Agent │ Decision Simplifier │ System Meta   │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────┴───────────────────────────────┐
│              Foundation Layer (Ollama)                   │
│          (Model management, Inference engine)            │
└─────────────────────────────────────────────────────────┘
```

</div>

## 🚀 Quick Start

```bash
# Daily opportunity scan (5 minutes)
./quick_opportunity.sh

# Smart financial planning
./mirador-smart-v2 "How can I optimize my income?"

# Music career development  
./mirador-smart-v2 "Create 90-day plan to become touring guitarist"

# System health check
./daily_check_enhanced.sh
```

## 🎯 Key Features

### 🧠 Personality-Aware Intelligence
Integrated Big Five (OCEAN) profile optimization for truly personalized recommendations that align with your cognitive style and values.

### 🔗 Multi-Model Orchestration
Chains up to 6 specialized models for comprehensive analysis, each contributing unique expertise to create nuanced, multi-perspective solutions.

### 💾 Persistent Memory System
SQLite-based context retention learns from your patterns and preferences, building deeper understanding over time.

### ⚡ Performance Excellence
- 5-25 second response times per model
- 100% completion rate across 450+ analyses
- 390 average words of actionable content per chain
- 22MB storage for complete analysis history

### 🔒 Privacy-First Design
100% local execution with no external API calls. Your data never leaves your machine.

## 📋 Requirements

- **Hardware**: MacBook M3 Max or equivalent (16GB+ RAM recommended)
- **OS**: macOS Sequoia 15.5+ (tested) or Linux
- **Software**:
  - Ollama 2.0+
  - Python 3.13+
  - 50GB+ available storage
  - Homebrew (for macOS dependencies)

## 🛠️ Installation

1. **Clone the repository**
   ```bash
   git clone git@github.com:guitargnar/mirador.git
   cd mirador
   ```

2. **Install dependencies**
   ```bash
   # Install Ollama
   brew install ollama
   
   # Install Python packages
   pip3 install -r requirements.txt
   
   # Install coreutils for timeout functionality
   brew install coreutils
   ```

3. **Pull base models**
   ```bash
   ollama pull llama3.2:3b-instruct-fp16
   ollama pull qwen2.5:3b-instruct-fp16
   ```

4. **Deploy specialized models**
   ```bash
   ./deploy_production_mirador.sh
   ```

5. **Verify installation**
   ```bash
   ./daily_check_enhanced.sh
   ```

## 💎 Core Models

| Model | Purpose | Specialty |
|-------|---------|-----------|
| `matthew_context_provider_v3` | Personal context & personality | Big Five profile, goals, values |
| `financial_planning_expert_v8` | Financial analysis & planning | Location-specific optimization |
| `louisville_expert_v3` | Local knowledge & resources | Venues, networks, opportunities |
| `enhanced_agent_enforcer` | Strategic synthesis | Cross-domain analysis |
| `decision_simplifier_v3` | Action generation | Timeline-based recommendations |
| `mirador_system_specialist_v2` | Meta-optimization | System improvement |

## 📊 Performance Metrics

- **Response Times**: 5-25 seconds per model, 45-60 seconds for 3-model chains
- **Success Rate**: 100% completion rate across 450+ analyses
- **Output Quality**: Average 390 words of actionable content
- **Storage Efficiency**: 22MB for 447 complete analyses

## 💡 Usage Examples

### Financial Optimization
```bash
./mirador-smart-v2 "Create comprehensive budget with savings strategy"
./mirador-smart-v2 "Investment opportunities for musicians in Louisville"
./mirador-smart-v2 "Tax optimization strategies for creative professionals"
```

### Music Career Development
```bash
./mirador-smart-v2 "90-day roadmap to join touring band"
./mirador-smart-v2 "Build guitar skills for country/rock touring"
./mirador-smart-v2 "Network with Nashville music industry from Louisville"
```

### Strategic Planning
```bash
./mirador-smart-v2 "Balance family life with touring ambitions"
./mirador-smart-v2 "Leverage high openness personality for success"
./mirador-smart-v2 "Build multiple income streams as musician"
```

## 🎨 Brand Philosophy

<div align="center">
  
### Observe. Adapt. Remain.

**Observe**: Gather intelligence from multiple AI perspectives  
**Adapt**: Evolve strategies based on comprehensive insights  
**Remain**: Maintain core values while embracing change  

</div>

## 📚 Documentation

- [Technical Architecture](docs/technical.md) - System design details
- [User Guide](docs/user-guide.md) - Comprehensive usage instructions
- [Model Catalog](docs/models.md) - All 79+ model specifications
- [Chain Templates](docs/chains.md) - Pre-configured workflows
- [Security Guidelines](docs/security.md) - Privacy best practices

## 🛡️ Security & Privacy

This repository implements enterprise-grade security:
- Comprehensive `.gitignore` with 245+ protection patterns
- Multi-layer credential protection
- Output sanitization for personal data
- No external API dependencies

**⚠️ Private Repository**: Authorized access only.

## 📈 Project Stats

- **Version**: 2.0 (Major restructuring)
- **Total Analyses**: 450+
- **Model Count**: 79+ specialized models
- **Success Rate**: 100%
- **Active Since**: May 2024
- **Last Updated**: June 23, 2025

## 🤝 Contributing

This is a private project. Contributions limited to authorized collaborators.

## 📄 License

Private and Confidential. All rights reserved.

---

<div align="center">
  <sub>Built with precision in Louisville, KY</sub>
  <br>
  <sub>Powered by local AI • No cloud dependencies • Your data stays yours</sub>
</div>