# Mirador AI Framework Guidance for Claude

This document provides guidance for Claude when working with the Mirador AI Framework codebase.

## Project Overview

Mirador is an AI orchestration framework that chains specialized AI models together to create comprehensive solutions. Each model (persona) contributes its unique expertise, with outputs flowing from one model to the next, optionally allowing human review at each step.

## Core Architecture

### Framework Components

- **`framework.py`**: Core orchestration engine that manages the chain execution process
- **`api.py`**: REST API interface for remote control and integration
- **`webhook_handler.py`**: Event notification system for integration with external systems
- **`guitar_studio.py`**: Domain-specific extension for guitar expertise
- **`config.json`**: Configuration file defining personas, chains, and system settings

### Key Concepts

- **Personas**: Specialized AI models configured for specific roles (e.g., `master_coder`, `security_expert`)
- **Chains**: Sequences of personas executed in order to solve complex problems
- **Sessions**: Persistent records of chain executions with complete input/output history
- **Webhooks**: Event-based notifications for integration with external systems

## Development Guidelines

### Code Structure

- **Core Framework**: Maintain the modular architecture separating orchestration, API, and domain extensions
- **Persona System**: Follow the established pattern for persona definitions with model, role, and prompt template
- **Chain Execution**: Preserve the sequential processing model with optional human checkpoints

### Coding Standards

- **Python**: Follow PEP 8 conventions for code formatting
- **Documentation**: Include docstrings for all functions and classes
- **Type Hints**: Use type hints for function parameters and return values

### Testing

When suggesting code changes, consider:
- How to test the functionality
- Potential edge cases
- Error handling scenarios

## Command Reference

### Basic Commands

```bash
# Run a chain with a prompt
python3 -m ai_framework.framework --prompt "Your input text"

# Process a file
python3 -m ai_framework.framework --file /path/to/input.txt

# Run a specific segment of the chain
python3 -m ai_framework.framework --prompt "Generate code" --start master_coder --end code_reviewer

# Non-interactive mode
python3 -m ai_framework.framework --prompt "Write a REST API" --non-interactive
```

### Session Management

```bash
# List all sessions
python3 -m ai_framework.framework --list-sessions

# Get session info
python3 -m ai_framework.framework --session-info 20250511-202623

# Resume a session
python3 -m ai_framework.framework --session 20250511-202623 --prompt "Extend this implementation"
```

### API Server

```bash
# Start the API server
python3 -m ai_framework.api

# Test the API
curl http://localhost:5001/api/health
```

### Webhook Testing

```bash
# Run webhook test server
python3 -m ai_framework.webhook_test_server

# Run webhook demo
python3 -m ai_framework.webhook_demo --demo
```

## Specialized Personas

Mirador includes the following specialized personas:

### Core Development
- `master_coder`: Generates high-quality implementations
- `code_reviewer`: Identifies and fixes code issues
- `file_reviewer`: Creates comprehensive documentation

### Analysis
- `data_scientist`: Performs data analysis and visualization
- `security_expert`: Identifies security vulnerabilities
- `system_architect`: Designs scalable system architectures

### Content and Design
- `content_creator`: Creates engaging content
- `ux_designer`: Designs user interfaces
- `creative_entrepreneur`: Identifies business opportunities

### Specialized Domains
- `guitar_expert`: Provides guitar instruction and analysis
- `database_specialist`: Designs database structures
- `mobile_developer`: Creates mobile solutions
- `devops_engineer`: Implements CI/CD and infrastructure
- `ai_specialist`: Designs AI/ML solutions
- `task_planner`: Creates project plans

## Enhancement Recommendations

When suggesting enhancements to Mirador, consider these directions:

1. **Parallel Processing**: Enable simultaneous persona execution where appropriate
2. **Advanced Memory Systems**: Enhanced context persistence between sessions
3. **Web Interface**: Visual chain construction and monitoring
4. **Multi-Modal Processing**: Support for image, audio, and video
5. **Knowledge Base Integration**: Connection to external knowledge sources
6. **Customizable Personas**: User-defined specialized personas

## Security Considerations

Always consider these security aspects when working with Mirador:

- **Input Validation**: All user inputs should be properly validated
- **Authentication**: Consider adding authentication for the API in production
- **Webhook Security**: Ensure webhook endpoints use proper authentication
- **Model Safety**: Be aware of potential misuse of AI capabilities

## Future Development Focus

The highest priority areas for future development include:

1. Improving the robustness of the orchestration engine
2. Enhancing the API capabilities for better integration
3. Developing more specialized personas for different domains
4. Creating better visualization and monitoring tools
5. Implementing stronger security measures

By following these guidelines, Claude can provide consistent and helpful assistance with the Mirador AI Framework.