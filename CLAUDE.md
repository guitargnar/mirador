# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Mirador is a multi-agent AI orchestration framework for chaining specialized Ollama models together. The framework features emergent collaboration properties where specialists progressively enhance each other's work.

## Key Commands

- **Basic Chain**: `./scripts/run_chain.sh "Your prompt" model1 model2 [model3]` - Run a model chain
- **Role Chain**: `./scripts/run_role_chain.sh "Your code" model1 model2 [model3]` - Analyze code with specialized roles
- **Unified Interface**: `./mirador-unified run "Your prompt"` - Access both implementations
- **Rapid Prototype**: `./mirador-rapid "Your prompt"` - Use the streamlined multi-agent system
- **Run Tests**: `./tests/run_all_tests.sh` - Run comprehensive tests
- **Fix Tests**: `./tests/fix_tests.sh` - Repair test scripts if needed

## Directory Structure

- **scripts/**: User-facing launcher scripts
- **src/chains/**: Core chain implementation scripts
- **src/models/optimized/**: Specialized model definitions
- **src/bridge.py**: Bridge between bash and Python implementations
- **docs/**: Framework documentation
- **mirador-rapid**: Simplified interface for the multi-agent system

## Code Style Guidelines

- **Bash Scripts**:
  - Include proper error handling with set -e and explicit error messages
  - Add descriptive comments for complex operations
  - Use logging functions (log_info, log_debug, log_error) for traceability
  - Follow modular design with separate utility scripts

- **Python Scripts**:
  - Use type hints for function parameters and return values
  - Follow PEP 8 conventions for formatting
  - Use consistent exception handling with specific error messages
  - Implement proper docstrings for functions and classes

- **Model Configurations**:
  - Follow the established modelfile format with consistent parameter organization
  - Document temperature settings (0.3-0.8) and context window sizes
  - Include comprehensive system prompts for model specialization

## Error Handling

- Use the logging system (log_debug, log_info, log_warn, log_error) for operations
- Implement fallback mechanisms for API response extraction
- Always validate inputs and check error status after each command
- Handle Ollama API failures gracefully with retries or alternative approaches

## Naming Conventions

- Use snake_case for variables, functions, and file names
- Prefix functions with their module name (e.g., log_info, chain_run)
- Use descriptive names that indicate purpose
- For model files, follow pattern: [specialization]_[characteristic].modelfile

## Current Development Focus

The project is evolving from a basic chain runner to a sophisticated multi-agent system with:
- Dynamic agent selection based on task requirements
- Bidirectional communication between specialists
- Chain-of-thought standardization for better analysis
- Enhanced user experience with interactive decision points
- Parallel processing of compatible specialist tasks