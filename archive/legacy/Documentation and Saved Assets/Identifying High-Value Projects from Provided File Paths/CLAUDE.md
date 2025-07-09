# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build/Lint/Test Commands

- **React/JavaScript**: `npm run dev` - Run development server
- **React/JavaScript Tests**: `npm test` - Run tests for React components
- **Python (Llama project)**: `python3 llama_chat.py` or `python3 hf_chat.py` - Run Llama chat interfaces
- **Text Generation WebUI**: `python3 server.py` - Start the text generation web UI server
- **Google Cloud Authentication**: `gcloud auth application-default login` - Authenticate with Google Cloud

## Code Style Guidelines

- **JavaScript/React**:
  - Use React 19+ functional components with hooks
  - Import organization: React core imports first, then third-party, then local components/utils
  - Use Tone.js for audio processing following the standard patterns

- **Python**:
  - Follow PEP 8 conventions for code formatting
  - Use descriptive variable names and docstrings for functions
  - Type hints encouraged for function parameters and return values
  - For AI projects, organize model code, utility functions, and interfaces separately

## Testing Focus

When using compact mode, focus on test output and code changes to provide concise feedback. For Mirador AI Framework:

- In compact mode, emphasize model selection guidance and command examples
- Show the most relevant script to use based on the user's need
- Highlight differences between model temperature settings that affect output
- For troubleshooting, focus on specific command fixes rather than explanations

## Error Handling

- Use appropriate try/catch blocks for error-prone operations
- Log errors with meaningful context
- Handle API failures gracefully with user-friendly fallbacks

## Naming Conventions

- Use camelCase for JavaScript variables and functions
- Use PascalCase for React components and TypeScript interfaces
- Use snake_case for Python variables and functions
- Use UPPER_CASE for constants in any language