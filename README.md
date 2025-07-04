# Mirador AI Framework

A personal AI orchestration system for chaining specialized Ollama models across different domains.

## Overview

Mirador enables you to chain specialized AI models in sequence to solve complex problems across different domains:

- **Guitar/Music**: Practice routines, technique analysis, tablature generation
- **Business/Productivity**: Task management, project planning, content creation
- **Financial Planning**: Budget management, investment strategies
- **Career Development**: Skill development, learning paths, job strategies
- **Code/Development**: Code generation, documentation, architecture design

## Features

- **Model Chaining**: Sequence multiple specialized models for complex problems
- **Workflow Integration**: Domain-specific templates and workflows
- **Output Management**: Categorized storage with search and export capabilities
- **Progress Visualization**: Visual feedback showing how specialists transform solutions
- **Robust Logging**: Structured logging with error handling
- **Shell Integration**: Simplified domain-collab script and aliases for easy access
- **Comprehensive Testing**: Test suites for model and chain evaluation

## Requirements

- Ollama (latest version)
- jq
- bash/zsh
- Optional: pandoc (for export features)

### Test Environment

This framework has been tested on:
- Macbook Pro with M3 Max chip, 36GB RAM, 1TB SSD
- All test outputs and performance metrics are based on this configuration

## Quick Start

1. Clone this repository
2. Run the setup script: `./scripts/setup.sh`
3. Use the simplified interface: `~/bin/domain-collab setup`
4. Try a chain: `domain-collab fast "Your question"` or `domain-collab domain dev "Your question"`

### Compact Mode Commands

For compact mode in Claude Code (/compact), the most useful commands are:

```bash
# Direct model access - simplest approach
./scripts/direct-ollama.sh fast-agent "What is Python?"

# Run with default model (fast-agent)
./scripts/run-ollama.sh "How do I create a Python function?"

# Domain-specific chains
domain-collab domain dev "Create a secure login system"
domain-collab domain music "Show me sweep picking technique"
```

### Unified Interface

This repository now includes a unified interface that connects both the bash-based implementation (this repository) and the Python-based implementation (located at `~/ai_framework`):

```bash
# Use the unified launcher
~/ai_framework_git/mirador-unified

# Run a prompt through both implementations
~/ai_framework_git/mirador-unified run "Your prompt here"

# Use specialized modes
~/ai_framework_git/mirador-unified mode dev "Create a function"
```

For more details, see [Unified Interface Documentation](docs/UNIFIED_INTERFACE.md) and [Progress Visualization Documentation](docs/PROGRESS_VISUALIZATION.md).

### Rapid Prototyping

A simplified interface for rapid prototyping that leverages the emergent multi-agent system:

```bash
# Generate ideas with the collaborative multi-agent system
~/ai_framework_git/mirador-rapid "Design a secure user authentication system"
```

This tool focuses on the "accidental brilliance" found in our multi-agent approach, where specialists progressively enhance each other's work.

### Dynamic Specialist Selection

The conductor agent analyzes your task and selects the optimal specialists:

```bash
# Analyze task and select specialists
~/ai_framework_git/mirador-conductor "Create a secure login system in Python"
```

The conductor analyzes your requirements, recommends the most appropriate specialists, and explains its selection rationale.

### Interactive Conversation

The interactive mode provides a conversational interface for refining tasks:

```bash
# Start an interactive session
~/ai_framework_git/mirador-interactive
```

This mode allows you to discuss your task with the conductor, refine it with additional details, and execute the recommended specialist chains.

### Collaborative Communication

The collaborative mode enables specialists to communicate bidirectionally:

```bash
# Run a chain with bidirectional specialist communication
~/ai_framework_git/mirador-collaborate "Create a secure authentication system in Python"

# Run with specific specialists
~/ai_framework_git/mirador-collaborate --specialists master_coder security_expert code_reviewer_fix "Design a database schema for a banking app"

# Run a test to see how it works
~/ai_framework_git/mirador-collaborate --test
```

This powerful mode creates a collaborative multi-agent system where specialists can query each other for information, resulting in more comprehensive and higher-quality outputs.

## Documentation

Comprehensive documentation is available to help you get the most out of the Mirador framework:

- [Model & Prompt Guide](docs/ollama/MODEL_PROMPT_GUIDE.md) - Detailed guide for each model's optimal use
- [Quick Reference](docs/ollama/ONE_PAGE_REFERENCE.md) - One-page cheat sheet for model selection
- [Command Reference](docs/ollama/OLLAMA_REFERENCE_CARD.md) - All available commands and interfaces
- [Model Architecture](docs/ollama/MODEL_ARCHITECTURE.md) - Technical details on model optimization and integration
- [Workflow Patterns](docs/ollama/WORKFLOW_PATTERNS.md) - Established patterns for combining models
- [Temperature Guide](docs/ollama/TEMPERATURE_GUIDE.md) - How temperature affects model behavior
- [Model Selection Card](docs/ollama/MODEL_SELECTION_CARD.md) - Visual quick reference for model selection
- [FAQ](docs/ollama/OLLAMA_FAQ.md) - Frequently asked questions about Ollama and Mirador

## Future Enhancements

The Mirador framework continues to evolve with planned enhancements:

### System Architecture
- **Dynamic Agent Selection**: A "conductor" agent to select only relevant specialists ✅
- **Bidirectional Communication**: Allow specialists to request information from each other ✅
- **Ultra-Simple Interface**: Direct, stateless access to specialized models ✅
- **Knowledge Persistence**: Store specialist outputs for reuse across projects

### Technical Implementation
- **Chain-of-Thought Standardization**: Structured format for reasoning capture
- **Evaluation Metrics**: Measure value added by each specialist
- **Parallel Processing**: Run compatible specialists in parallel

### User Experience
- **Progress Visualization**: Real-time visualization showing specialist contributions ✅
- **Bidirectional Communication**: Specialists can query each other for information ✅
- **Interactive Decision Points**: Allow users to guide the specialist chain ✅
- **Domain-Specific Chains**: Pre-configured specialist sequences for common workflows ✅
- **Model Specialization Guide**: Reference for optimal model-prompt pairings ✅
- **Comprehensive Documentation**: Reference for model architecture and workflows ✅

These enhancements aim to transform Mirador from a rapid prototyping tool into a comprehensive AI-augmented development platform.

## Available Models

### Quick Reference Table

| Model | Purpose | Base Model | Temperature | Context | Best For |
|-------|---------|------------|-------------|---------|----------|
| `fast-agent` | Quick answers | llama3 | 0.3 | 2048 | Factual questions, concise info |
| `fast_agent_focused` | Structured responses | fast-agent | 0.3 | 2048 | Step-by-step instructions |
| `guitar_expert_precise` | Guitar instruction | guitar-expert | 0.4 | 16384 | Tablature generation, technique explanation |
| `llama3.2_balanced` | General assistance | llama3.2 | 0.6 | 8192 | Creative writing, discussions |
| `code_reviewer_fix` | Code review | code-reviewer-fix | 0.3 | 8192 | Security analysis, bug detection |
| `master_coder` | Code generation | master-coder | 0.4 | 8192 | Clean code implementation |
| `creative_entrepreneur` | Business analysis | creative-entrepreneur | 0.7 | 8192 | Business ideas, market opportunities |
| `enhanced_agent` | Deep research | enhanced-agent | 0.7 | 8192 | Complex questions, thorough analysis |
| `file_reviewer` | Documentation | file-reviewer | 0.4 | 8192 | API docs, technical writing |
| `ux_designer` | Interface design | enhanced-agent | 0.7 | 16384 | User flows, interface mockups |

### Model Categories

#### Speed-Optimized Models
- **fast-agent**: Ultra-fast responses for simple queries
- **fast_agent_focused**: Structured information with lists and steps

#### Technical Models
- **master_coder**: Clean, modular code implementation
- **code_reviewer_fix**: Security analysis and bug detection
- **file_reviewer**: Technical documentation and explanations

#### Creative Models
- **creative_entrepreneur**: Business innovation and market analysis
- **ux_designer**: User interface design and user experience
- **llama3.2_balanced**: Balanced creativity and precision

#### Specialized Models
- **guitar_expert_precise**: Guitar technique with tablature generation
- **enhanced_agent**: Comprehensive research and analysis

### How to Choose the Right Model

1. **For facts and quick answers**: Use `fast-agent`
2. **For code implementation**: Use `master_coder`
3. **For business ideas**: Use `creative_entrepreneur`
4. **For guitar instruction**: Use `guitar_expert_precise`
5. **For security reviews**: Use `code_reviewer_fix`

For complete documentation on model selection and optimal usage patterns:
- [Model & Prompt Guide](docs/ollama/MODEL_PROMPT_GUIDE.md) - Detailed guide for each model
- [Quick Reference](docs/ollama/ONE_PAGE_REFERENCE.md) - One-page cheat sheet
- [Temperature Guide](docs/ollama/TEMPERATURE_GUIDE.md) - How temperature affects behavior
- [Model Architecture](docs/ollama/MODEL_ARCHITECTURE.md) - Technical details on optimization

## Directory Structure

```
.
├── config/             # Configuration files
├── docs/               # Documentation
├── logs/               # Log files
├── outputs/            # Output storage
├── scripts/            # Utility scripts
├── src/                # Source code
│   ├── chains/         # Chain definitions
│   ├── core/           # Core functionality
│   ├── models/         # Model definitions
│   ├── utils/          # Utility functions
│   └── workflows/      # Workflow templates
├── templates/          # Templates for workflows
└── tests/              # Test suites for models and chains
```

## Usage Examples

### Ultra-Simple Interface

```bash
# Direct, stateless model access (no session)
./scripts/direct-ollama.sh fast-agent "What is the capital of France?"
./scripts/direct-ollama.sh guitar_expert_precise "Show me a G major scale"

# Simple model access with default model
./scripts/run-ollama.sh "What is the capital of France?"
./scripts/run-ollama.sh guitar_expert_precise "Show me a G major scale"
```

### Domain-Specific Interface

```bash
# Domain-specific specialist chains
domain-collab domain music "Create a practice routine for sweep picking"
domain-collab domain dev "Design a secure authentication system in Python"
domain-collab domain business "Develop a marketing plan for a guitar teaching app"

# Interactive domain selection
domain-collab interactive
```

### Running a Basic Chain (Original Method)

```bash
# Guitar practice chain
./scripts/run_chain.sh "Create a practice routine for sweep picking" guitar_expert_precise fast_agent_focused

# Code development chain
./scripts/run_chain.sh "Create a secure authentication system" master_coder code_reviewer_fix

# Business strategy chain
./scripts/run_chain.sh "Develop a marketing plan for a guitar teaching app" llama3.2_balanced creative_entrepreneur
```

### Running a Role-Based Chain for Technical Solutions

The role-based chain is specialized for analyzing code and technical solutions with clearly defined roles:

```bash
# Code review and business application chain
./scripts/run_role_chain.sh "function authenticate(user, pass) { 
  if (user === 'admin' && pass === 'password123') {
    return true;
  }
  return false;
}" master_coder code_reviewer_fix creative_entrepreneur

# Generate documentation and UI for a solution
./scripts/run_role_chain.sh "const fetchUserData = async (userId) => {
  try {
    const response = await fetch(`/api/users/${userId}`);
    return await response.json();
  } catch (error) {
    console.error('Error fetching user data:', error);
    return null;
  }
}" file_reviewer enhanced_agent
```

Available roles and their specializations:
- `creative_entrepreneur`: Identify business applications for the solution
- `enhanced_agent`: Provide comprehensive analysis and insights
- `master_coder`: Optimize and improve code
- `code_reviewer_fix`: Identify and fix bugs and security issues
- `file_reviewer`: Create detailed documentation
- `ux_designer`: Design user interfaces for implementations

### Using Domain Workflows

```bash
# Use the guitar practice workflow
./scripts/run_workflow.sh practice

# Use the financial planning workflow
./scripts/run_workflow.sh finance

# Use the career development workflow
./scripts/run_workflow.sh career
```

### Running Tests

```bash
# Run all model and chain tests
./tests/run_all_tests.sh

# Test a specific model
./tests/models/test_guitar_expert_precise.sh

# Test a specific chain
./tests/chains/test_guitar_chain.sh
```

## License

[MIT](LICENSE)