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
- **Robust Logging**: Structured logging with error handling
- **Shell Integration**: Aliases and functions for command-line convenience
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
3. Try a chain: `./scripts/run_chain.sh "Your prompt" model1 model2`

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

For more details, see [Unified Interface Documentation](docs/UNIFIED_INTERFACE.md).

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

## Future Enhancements

The Mirador framework continues to evolve with planned enhancements:

### System Architecture
- **Dynamic Agent Selection**: A "conductor" agent to select only relevant specialists
- **Bidirectional Communication**: Allow specialists to request information from each other
- **Knowledge Persistence**: Store specialist outputs for reuse across projects

### Technical Implementation
- **Chain-of-Thought Standardization**: Structured format for reasoning capture
- **Evaluation Metrics**: Measure value added by each specialist
- **Parallel Processing**: Run compatible specialists in parallel

### User Experience
- **Progress Visualization**: Show how each specialist transforms the project
- **Interactive Decision Points**: Allow users to guide the specialist chain
- **Domain-Specific Chains**: Pre-configured specialist sequences for common workflows

These enhancements aim to transform Mirador from a rapid prototyping tool into a comprehensive AI-augmented development platform.

## Available Models

| Model | Purpose | Base Model | Optimization |
|-------|---------|------------|-------------|
| `guitar_expert_precise` | Guitar instruction | guitar-expert | Lower temperature (0.4), higher context (16384) |
| `llama3.2_balanced` | General assistance | llama3.2 | Balanced temperature (0.6), broad knowledge |
| `fast_agent_focused` | Task management | fast-agent | Low temperature (0.3), focused responses |
| `code_reviewer_fix` | Code review | code-reviewer-fix | Low temperature (0.3), detailed analysis |
| `master_coder` | Code generation | master-coder | Precise implementation (0.4 temp) |
| `creative_entrepreneur` | Business analysis | creative-entrepreneur | Higher creativity (0.7 temp) |
| `enhanced_agent` | General analysis | enhanced-agent | Comprehensive responses (0.7 temp) |
| `file_reviewer` | Documentation | file-reviewer | Structured documentation (0.4 temp) |

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

### Running a Basic Chain

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