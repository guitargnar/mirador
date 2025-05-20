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

## Quick Start

1. Clone this repository
2. Run the setup script: `./scripts/setup.sh`
3. Try a chain: `./scripts/run_chain.sh "Your prompt" model1 model2`

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