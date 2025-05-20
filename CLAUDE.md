# CLAUDE.md - Instructions for Claude Code

## Project Overview

Mirador is a personal AI orchestration framework that chains specialized Ollama models together for enhancing different aspects of life: music learning, financial planning, career development, coding, and business analysis.

## Current Project Status

- **Repository**: ~/ai_framework_git
- **Implementation**: Bash-based model chaining via direct Ollama API calls
- **Core Components**: Chain runner, workflow integration, output management, logging
- **Models**: 8 specialized Ollama models with different temperature/context settings

## Key Files

- **Chain Runner**: src/chains/run_chain.sh (core model chaining functionality)
- **Workflows**: src/workflows/mirador_workflow.sh (domain-specific templates)
- **Utils**: src/utils/init.sh, src/utils/logging.sh (common utilities)
- **Config**: config/config.json (model and workflow configuration)
- **Testing**: tests/ (comprehensive test suite for all models and chains)

## Available Models

- **guitar_expert_precise**: Guitar instruction (temperature 0.4)
- **llama3.2_balanced**: General purpose (temperature 0.6)
- **fast_agent_focused**: Task organization (temperature 0.3)
- **code_reviewer_fix**: Code analysis (temperature 0.3)
- **master_coder**: Code generation (temperature 0.4)
- **creative_entrepreneur**: Business analysis (temperature 0.7)
- **enhanced_agent**: Comprehensive analysis (temperature 0.7)
- **file_reviewer**: Documentation (temperature 0.4)

## Progress Timeline

1. **Initial Work**: Evaluated storage usage and identified Ollama models (~56GB)
2. **Framework Development**: Created bash-based chaining scripts to replace non-functioning Python framework
3. **Specialized Chains**: Developed domain-specific chain shortcuts (guitar, business, code)
4. **Modular Logging**: Implemented structured logging with error handling
5. **Output Management**: Built organized output system with categories
6. **Git Implementation**: Established clean repository with proper structure
7. **Test Suite**: Created comprehensive testing system for models and chains
8. **CURRENT**: Fixing test script issues and preparing for full system validation

## Next Steps

1. Complete test script debugging
2. Run full system testing
3. Refine model configurations based on test results
4. Implement advanced chains for specific use cases
5. Create more specialized templates
6. Enhance error recovery for production reliability

## Command Reference

See the README.md file for the latest command reference.