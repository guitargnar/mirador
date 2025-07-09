# Mirador AI Framework - User Guide

## Quick Start

### Prerequisites
- Ollama installed and running
- Python 3.11+ with required packages (requests, json)
- Bash/Zsh shell environment
- jq for JSON processing

### Installation and Setup
1. **Clone or download the Mirador framework**
2. **Run the initialization script**:
   ```bash
   ./scripts/init.sh
   ```
3. **Verify system health**:
   ```bash
   ./health_check.py
   ```
4. **Run the test suite**:
   ```bash
   ./test_suite.sh
   ```

## Command Reference

### Primary Commands

#### mirador
Main framework launcher with comprehensive features.

```bash
# Interactive mode (default)
./mirador

# Run a chain with specific models
./mirador chain "Create a Python function" --models master_coder code_reviewer_fix

# Use conductor for automatic specialist selection
./mirador conductor "Design a web application"

# Query a single model
./mirador ask fast_agent "What is Python?"

# List available models
./mirador models

# List specialized roles
./mirador roles
```

#### mirador-conductor
Intelligent specialist selection and recommendation system.

```bash
# Analyze task and recommend specialists
./mirador-conductor "Create a secure authentication system"

# Get recommendations without execution
./mirador-conductor "Design a mobile app" --analyze-only
```

#### mirador-collaborate
Bidirectional communication between specialists.

```bash
# Run with automatic specialist selection
./mirador-collaborate "Build a REST API with security features"

# Specify particular specialists
./mirador-collaborate --specialists master_coder code_reviewer_fix security_expert "Create a banking application"

# Run a test to see collaboration in action
./mirador-collaborate --test
```

#### mirador-interactive
Conversational interface for iterative development.

```bash
# Start interactive session
./mirador-interactive

# Within the session:
# - Discuss your requirements
# - Refine tasks with additional details
# - Execute recommended specialist chains
# - Review and iterate on results
```

#### mirador-rapid
Quick prototyping and idea generation.

```bash
# Generate ideas rapidly
./mirador-rapid "Design a productivity app for remote teams"

# Focus on specific domain
./mirador-rapid --domain business "Monetization strategies for SaaS"
```

#### mirador-intervene
Human-guided AI collaboration with intervention points.

```bash
# Run with intervention opportunities
./mirador-intervene "Create a complex data processing pipeline"

# Set intervention frequency
./mirador-intervene --intervention-level high "Design system architecture"
```

#### mirador-unified
Unified interface connecting all modes.

```bash
# Access all functionality through one command
./mirador-unified run "Your prompt here"

# Use specialized modes
./mirador-unified mode dev "Create a function"
./mirador-unified mode business "Market analysis"
```

## Usage Patterns

### Code Development Workflow
```bash
# 1. Initial code generation
./mirador chain "Create a user authentication system in Python" --models master_coder

# 2. Security review and improvements
./mirador chain "Review and improve this authentication code: [code]" --models code_reviewer_fix

# 3. Documentation generation
./mirador chain "Document this authentication system" --models file_reviewer

# 4. Business application analysis
./mirador chain "Identify business applications for this auth system" --models creative_entrepreneur
```

### Business Analysis Workflow
```bash
# 1. Market analysis
./mirador-conductor "Analyze the market for AI productivity tools"

# 2. Product ideation
./mirador-collaborate "Develop product concepts for identified market opportunities"

# 3. Business model development
./mirador chain "Create business models for these product concepts" --models creative_entrepreneur enhanced_agent
```

### Interactive Development
```bash
# Start interactive session
./mirador-interactive

# Example conversation flow:
User: "I want to build a guitar learning app"
Conductor: "I recommend starting with UX design, then technical architecture..."
User: "Focus on the practice tracking features first"
Conductor: "Let me connect you with the UX designer and data specialist..."
```

## Advanced Features

### Chain Templates
Pre-configured specialist sequences for common workflows:

```bash
# Code development chain
./mirador template code "Build a REST API"

# Business analysis chain  
./mirador template business "Evaluate market opportunity"

# Creative development chain
./mirador template creative "Design user experience"
```

### Custom Model Configuration
Modify `config.json` to customize model behavior:

```json
{
  "models": {
    "custom_specialist": {
      "temperature": 0.5,
      "context_length": 4096,
      "description": "Custom specialist for specific domain"
    }
  }
}
```

### Output Management
Results are automatically organized in the `outputs/` directory:

```
outputs/
├── chains/           # Chain execution results
├── conversations/    # Interactive session logs
├── collaborate/      # Collaboration session results
└── reports/         # Generated analysis reports
```

## Troubleshooting

### Common Issues

#### "Command not found"
```bash
# Make sure commands are executable
chmod +x mirador*

# Check if you're in the correct directory
ls -la mirador*
```

#### "Python import errors"
```bash
# Run the optimization script
./optimize_system.sh

# Verify Python environment
python3 -c "import requests, json; print('Dependencies OK')"
```

#### "Ollama connection failed"
```bash
# Check if Ollama is running
curl http://localhost:11434/api/tags

# Start Ollama if needed
ollama serve
```

#### "Configuration errors"
```bash
# Validate configuration
jq empty config.json

# Reset to default configuration
./optimize_system.sh
```

### Health Monitoring
Regular system health checks:

```bash
# Run comprehensive health check
./health_check.py

# Run full test suite
./test_suite.sh

# Check system logs
tail -f logs/system.log
```

## Best Practices

### Model Selection
- **fast_agent**: Quick factual queries, simple tasks
- **enhanced_agent**: Complex analysis, research tasks
- **master_coder**: Code generation, programming tasks
- **code_reviewer_fix**: Security analysis, code review
- **creative_entrepreneur**: Business analysis, innovation
- **guitar_expert_precise**: Music-related tasks

### Chain Design
- Start with conductor analysis for optimal specialist selection
- Use bidirectional collaboration for complex multi-domain tasks
- Include human intervention points for critical decisions
- Document and save successful chain patterns as templates

### Performance Optimization
- Use appropriate temperature settings for each task type
- Monitor chain execution times and optimize bottlenecks
- Regularly update model configurations based on usage patterns
- Maintain clean output directories to prevent storage issues

## Integration with Existing Workflows

### Shell Integration
Add to your `.bashrc` or `.zshrc`:

```bash
# Mirador aliases
alias m='./mirador'
alias mc='./mirador-conductor'
alias mi='./mirador-interactive'
alias mr='./mirador-rapid'

# Quick functions
mirador_code() {
    ./mirador chain "$1" --models master_coder code_reviewer_fix
}

mirador_business() {
    ./mirador chain "$1" --models creative_entrepreneur enhanced_agent
}
```

### IDE Integration
Configure your IDE to use Mirador for:
- Code review and suggestions
- Documentation generation
- Architecture analysis
- Business requirement analysis

### Automation Scripts
Create automated workflows:

```bash
#!/bin/bash
# Daily development workflow
./mirador-conductor "Review today's development priorities"
./mirador-collaborate "Analyze current project status and next steps"
./health_check.py
```

This user guide provides comprehensive coverage of the Mirador framework's capabilities and usage patterns. The system is designed to be both powerful for advanced users and accessible for newcomers to AI-assisted development workflows.

