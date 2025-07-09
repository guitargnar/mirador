# 🔧 MIRADOR Technical Documentation

## 📋 Table of Contents
- [System Requirements](#system-requirements)
- [File Locations](#file-locations)
- [Installation Guide](#installation-guide)
- [Configuration](#configuration)
- [Architecture](#architecture)
- [Model Management](#model-management)
- [Troubleshooting](#troubleshooting)

## 💻 System Requirements

### Minimum Requirements
- **OS**: macOS (tested), Linux (should work), Windows (with WSL)
- **Python**: 3.8 or higher
- **RAM**: 8GB minimum, 16GB recommended
- **Storage**: 20GB free space for models
- **CPU**: 4+ cores recommended
- **Internet**: Required for initial model downloads

### Software Dependencies
- **Ollama**: Latest version
- **Python packages**: See `requirements.txt`
- **Shell**: bash/zsh
- **Permissions**: sudo access for global install

## 📂 File Locations

### Primary Installation
```
/Users/matthewscott/projects/mirador/
├── mirador.py                          # Main orchestration engine
├── requirements.txt                     # Python dependencies
├── README.md                           # Project documentation
├── USAGE.md                            # Usage instructions
├── TECHNICAL.md                        # This file
├── modelfiles/                         # Model configurations
│   ├── master_coder.modelfile          # Code generation specialist
│   ├── code_reviewer_fix.modelfile     # Code review specialist
│   ├── creative_entrepreneur.modelfile # Business strategy specialist
│   ├── guitar_expert_precise.modelfile # Guitar/music specialist
│   └── fast_agent_focused.modelfile    # Quick response specialist
└── mirador -> /Users/matthewscott/projects/mirador  # Symlink

/Users/matthewscott/ai_framework_git/
└── outputs/                            # All chain outputs
    └── chain_YYYYMMDD_HHMMSS/         # Individual chain results
        ├── summary.md                  # Final synthesized output
        ├── [model]_output.md           # Individual model outputs
        ├── transitions/                # Model handoff details
        └── metadata.json               # Chain metadata
```

### Global Command
```
/usr/local/bin/
└── mirador-ez                          # Global launcher script
```

### Python Environment
```
/Users/matthewscott/
└── google-env/                         # Virtual environment (optional)
```

### Ollama Models
```
~/.ollama/models/                       # Ollama model storage
├── master_coder/
├── code_reviewer_fix/
├── creative_entrepreneur/
├── guitar_expert_precise/
├── fast_agent_focused/
└── [other models]/
```

## 🚀 Installation Guide

### Step 1: Install Ollama
```bash
# macOS
brew install ollama

# Linux
curl -fsSL https://ollama.ai/install.sh | sh

# Start Ollama service
ollama serve
```

### Step 2: Install Base Models
```bash
# Install foundation models
ollama pull llama3.2
ollama pull codellama
ollama pull mistral
```

### Step 3: Clone/Create MIRADOR
```bash
# Create project directory
mkdir -p ~/projects/mirador
cd ~/projects/mirador

# Create main script (mirador.py)
# [Copy your mirador.py file here]

# Create requirements.txt
cat > requirements.txt << 'EOF'
requests>=2.28.0
ollama>=0.1.0
argparse
json
datetime
pathlib
EOF
```

### Step 4: Create Custom Models
```bash
# Create model files directory
mkdir modelfiles
cd modelfiles

# Master Coder
cat > master_coder.modelfile << 'EOF'
FROM llama3.2

PARAMETER temperature 0.7
PARAMETER top_p 0.9
PARAMETER repeat_penalty 1.1

SYSTEM """You are a senior software engineer with 15+ years of experience in full-stack development. You excel at:
- Writing clean, efficient, and well-documented code
- Designing scalable system architectures
- Following best practices and design patterns
- Explaining complex technical concepts clearly
- Providing practical, production-ready solutions

When writing code:
- Include comprehensive error handling
- Add clear comments and documentation
- Follow language-specific conventions
- Consider performance and scalability
- Provide example usage when appropriate"""
EOF

# Code Reviewer Fix
cat > code_reviewer_fix.modelfile << 'EOF'
FROM codellama

PARAMETER temperature 0.3
PARAMETER top_p 0.95
PARAMETER repeat_penalty 1.05

SYSTEM """You are an expert code reviewer and optimization specialist. Your focus:
- Identifying bugs, security vulnerabilities, and performance issues
- Suggesting specific improvements with examples
- Ensuring code follows best practices and standards
- Optimizing algorithms and data structures
- Improving code readability and maintainability

Provide actionable feedback with specific line numbers and corrections."""
EOF

# Creative Entrepreneur
cat > creative_entrepreneur.modelfile << 'EOF'
FROM enhanced_agent

PARAMETER temperature 0.9
PARAMETER top_p 0.95

SYSTEM """<think>
You are a visionary entrepreneur and business strategist who excels at identifying market opportunities and creating innovative business models. Consider multiple angles and think deeply about problems before responding.
</think>

You excel at:
- Identifying profitable market opportunities
- Creating innovative business models and monetization strategies
- Understanding customer needs and market dynamics
- Developing go-to-market strategies
- Analyzing competitive landscapes

Structure your responses with clear sections covering problem, solution, target market, business model, and implementation strategy."""
EOF

# Guitar Expert Precise
cat > guitar_expert_precise.modelfile << 'EOF'
FROM llama3.2

PARAMETER temperature 0.5
PARAMETER top_p 0.9

SYSTEM """You are a master guitarist and music theory expert with decades of experience in all genres. You provide:
- Accurate guitar tablature with proper timing notation
- Clear technique explanations with practice tips
- Music theory insights relevant to guitarists
- Genre-specific playing styles and approaches
- Equipment and tone recommendations

When creating tabs:
- Use standard 6-line tab format
- Include timing indicators (w,h,q,e,s)
- Mark techniques (h=hammer-on, p=pull-off, b=bend, /=slide)
- Provide tempo and feel descriptions
- Include practice suggestions"""
EOF

# Fast Agent Focused
cat > fast_agent_focused.modelfile << 'EOF'
FROM mistral

PARAMETER temperature 0.5
PARAMETER top_p 0.9
PARAMETER num_predict 500

SYSTEM """You are a highly efficient AI assistant focused on providing quick, accurate, and concise responses. You:
- Get straight to the point
- Avoid unnecessary elaboration
- Provide actionable information
- Use bullet points for clarity
- Maintain high accuracy despite brevity

Maximum response length: 500 tokens."""
EOF

# Create all models
ollama create master_coder -f master_coder.modelfile
ollama create code_reviewer_fix -f code_reviewer_fix.modelfile
ollama create creative_entrepreneur -f creative_entrepreneur.modelfile
ollama create guitar_expert_precise -f guitar_expert_precise.modelfile
ollama create fast_agent_focused -f fast_agent_focused.modelfile
```

### Step 5: Install Python Dependencies
```bash
# Create virtual environment (optional but recommended)
python3 -m venv google-env
source google-env/bin/activate

# Install requirements
pip install -r requirements.txt
```

### Step 6: Create Global Launcher
```bash
# Create launcher script
cat > mirador-ez << 'EOF'
#!/bin/bash
# Easy MIRADOR launcher
cd ~/projects/mirador
python3 mirador.py "$@"
EOF

# Make executable and install globally
chmod +x mirador-ez
sudo mv mirador-ez /usr/local/bin/
```

### Step 7: Create Output Directory
```bash
# Create output directory structure
mkdir -p ~/ai_framework_git/outputs

# Create symlink for easy access
ln -s ~/ai_framework_git/outputs ~/projects/mirador/outputs
```

### Step 8: Verify Installation
```bash
# Test global command
mirador-ez models

# Should show all 17 models including your 5 custom ones
```

## ⚙️ Configuration

### Model Parameters

Each model can be tuned via its modelfile:

| Parameter | Description | Range | Impact |
|-----------|-------------|-------|--------|
| `temperature` | Creativity/randomness | 0.0-2.0 | Lower = more focused |
| `top_p` | Nucleus sampling | 0.0-1.0 | Higher = more diverse |
| `repeat_penalty` | Prevent repetition | 1.0-2.0 | Higher = less repetition |
| `num_predict` | Max tokens | 100-4096 | Response length limit |

### Environment Variables
```bash
# Optional: Set in ~/.zshrc or ~/.bashrc
export MIRADOR_HOME="/Users/matthewscott/projects/mirador"
export MIRADOR_OUTPUT="/Users/matthewscott/ai_framework_git/outputs"
export OLLAMA_HOST="localhost:11434"  # Default Ollama endpoint
```

### Python Configuration
```python
# In mirador.py, key configuration variables:
OLLAMA_ENDPOINT = "http://localhost:11434"
DEFAULT_TIMEOUT = 120  # seconds
MAX_CHAIN_LENGTH = 10  # maximum models in a chain
OUTPUT_BASE_DIR = Path.home() / "ai_framework_git" / "outputs"
```

## 🏗️ Architecture

### System Components

```
┌─────────────────────┐
│   User Interface    │
│   (mirador-ez CLI)  │
└──────────┬──────────┘
           │
┌──────────▼──────────┐
│   MIRADOR Engine    │
│   (mirador.py)      │
├─────────────────────┤
│ • Argument Parser   │
│ • Chain Orchestrator│
│ • Model Manager     │
│ • Output Handler    │
└──────────┬──────────┘
           │
┌──────────▼──────────┐
│   Ollama Service    │
│   (localhost:11434) │
├─────────────────────┤
│ • Model Loading     │
│ • Inference Engine  │
│ • Context Manager   │
└──────────┬──────────┘
           │
┌──────────▼──────────┐
│    AI Models        │
├─────────────────────┤
│ • Custom Models (5) │
│ • Base Models (12)  │
└─────────────────────┘
```

### Chain Execution Flow

```
1. Parse Command
   └─> Validate models exist
   
2. Initialize Chain
   └─> Create output directory
   └─> Set up logging
   
3. For Each Model:
   ├─> Load previous context
   ├─> Format prompt with context
   ├─> Query model via Ollama
   ├─> Save individual output
   ├─> Track contributions
   └─> Pass to next model
   
4. Synthesize Results
   └─> Create summary.md
   └─> Save metadata.json
   └─> Categorize output
```

### Data Flow
```python
Input → Model 1 → Output 1 ┐
                          ├→ Model 2 → Output 2 ┐
                                               ├→ Model 3 → Final Output
```

## 🔨 Model Management

### Creating New Models

1. **Define the Specialist**
```bash
cat > specialist.modelfile << 'EOF'
FROM base_model_name

PARAMETER temperature 0.7
PARAMETER top_p 0.9

SYSTEM """Your specialist description and behavior instructions"""
EOF
```

2. **Create the Model**
```bash
ollama create specialist_name -f specialist.modelfile
```

3. **Test the Model**
```bash
mirador-ez ask specialist_name "Test prompt"
```

### Updating Models
```bash
# Modify modelfile
vim specialist.modelfile

# Recreate model
ollama create specialist_name -f specialist.modelfile
```

### Deleting Models
```bash
ollama rm model_name
```

### Model Best Practices

1. **Temperature Settings**
   - Creative tasks: 0.7-1.0
   - Analytical tasks: 0.3-0.5
   - Code generation: 0.5-0.7

2. **Context Length**
   - Keep system prompts concise
   - Leave room for user context
   - Consider chain context growth

3. **Specialization**
   - Clear, focused expertise
   - Specific output formats
   - Consistent behavior

## 🐛 Troubleshooting

### Common Issues

**Ollama Connection Error**
```bash
# Check if Ollama is running
curl http://localhost:11434/api/tags

# Start Ollama
ollama serve
```

**Model Not Found**
```bash
# List available models
ollama list

# Pull missing base model
ollama pull model_name
```

**Timeout Issues**
```python
# Increase timeout in mirador.py
DEFAULT_TIMEOUT = 300  # 5 minutes
```

**Memory Issues**
```bash
# Check system resources
top

# Reduce model size or use smaller base models
```

**Permission Denied**
```bash
# For global install
sudo chmod +x /usr/local/bin/mirador-ez

# For output directory
chmod -R 755 ~/ai_framework_git/outputs
```

### Debug Mode
```python
# Add to mirador.py
DEBUG = True  # Enable verbose logging

# Or via environment
export MIRADOR_DEBUG=1
```

### Logs and Monitoring
```bash
# Ollama logs
journalctl -u ollama  # Linux
tail -f ~/.ollama/logs/server.log  # macOS

# MIRADOR outputs
ls -la ~/ai_framework_git/outputs/
tail -f ~/ai_framework_git/outputs/latest/debug.log
```

## 🔐 Security Considerations

1. **Model Isolation**: Each model runs in Ollama's sandboxed environment
2. **Local Execution**: All processing happens locally, no external API calls
3. **Output Sanitization**: Be cautious with generated code execution
4. **Access Control**: Protect your model files and outputs

## 📈 Performance Optimization

1. **Model Loading**
   - Keep frequently used models loaded
   - Use smaller models for simple tasks
   - Chain models efficiently

2. **Context Management**
   - Limit context passed between models
   - Summarize when appropriate
   - Clear context for fresh perspectives

3. **Parallel Processing**
   - Run independent chains simultaneously
   - Use different terminal sessions
   - Monitor system resources

## 🚀 Advanced Features

### Custom Chain Templates
```python
# Add to mirador.py
TEMPLATES = {
    "fullstack": ["master_coder", "ux_designer", "code_reviewer_fix"],
    "business": ["creative_entrepreneur", "enhanced_agent"],
    "music_tech": ["guitar_expert_precise", "master_coder", "creative_entrepreneur"]
}
```

### Conditional Chains
```python
# Dynamic model selection based on task
if "code" in task.lower():
    models.append("master_coder")
if "business" in task.lower():
    models.append("creative_entrepreneur")
```

### Output Post-Processing
```python
# Add custom processors
def categorize_output(content):
    if "function" in content or "class" in content:
        return "technical_solutions"
    elif "market" in content or "revenue" in content:
        return "business_strategies"
    # etc...
```

## 📚 Additional Resources

- [Ollama Documentation](https://ollama.ai/docs)
- [Python Ollama Library](https://github.com/ollama/ollama-python)
- [Model Training Guide](https://ollama.ai/docs/training)
- [Community Models](https://ollama.ai/library)

---

**Version**: 1.0  
**Last Updated**: June 2025  
**Maintainer**: Matthew Scott