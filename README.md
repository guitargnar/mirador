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

## Requirements

- Ollama (latest version)
- jq
- bash/zsh
- Optional: pandoc (for export features)

## Quick Start

1. Clone this repository
2. Run the setup script: `./scripts/setup.sh`
3. Try a chain: `./scripts/run_chain.sh "Your prompt" model1 model2`

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
└── templates/          # Templates for workflows
```

## Usage

See the [documentation](docs/USAGE.md) for detailed usage instructions.

## License

[MIT](LICENSE)
