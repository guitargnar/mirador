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

## Current Development Status

The project has evolved from a basic chain runner to an intelligent multi-agent system with:

✅ **Dynamic agent selection** through the conductor that analyzes tasks and selects specialists
✅ **Interactive user experience** with conversational interface for refining tasks
✅ **Bidirectional communication** between specialists
✅ **User intervention points** for guiding specialist communication
⬜ Chain-of-thought standardization for better analysis
⬜ Parallel processing of compatible specialist tasks

Recent improvements:
- The conductor agent now provides task analysis, specialist recommendations, and selection rationale
- Interactive mode allows users to refine tasks through dialogue with the conductor
- Bidirectional communication enables specialists to query each other for information
- User intervention points allow approving, modifying, or rejecting specialist communications
- Progress visualization provides real-time feedback on specialist contributions
- Conversation history is saved for future reference and continuity