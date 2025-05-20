# Mirador Usage Guide

This document provides detailed instructions for using the Mirador AI Framework.

## Basic Commands

### Running a Chain

```bash
./scripts/run_chain.sh "Your prompt" model1 model2 [model3]
```

Example:
```bash
./scripts/run_chain.sh "Create a guitar practice routine for sweep picking" guitar_expert_precise fast_agent_focused
```

### Domain-Specific Workflows

```bash
./scripts/mirador_workflow.sh [domain] [template]
```

Available domains:
- `finance` - Financial planning and budget management
- `practice` - Guitar practice planning
- `career` - Career development planning
- `tasks` - Daily task management

Example:
```bash
./scripts/mirador_workflow.sh practice
```

## Specialized Shortcut Commands

```bash
# Guitar-focused workflow
plan-practice "Create a practice routine for blues scales"

# Financial planning workflow
plan-finances "Review my monthly budget"

# Career development workflow
plan-career "Design a learning path for AI engineering"

# Daily planning workflow
plan-day "Organize my task list for today"
```

## Output Management

```bash
# Organize existing outputs
./scripts/output_manager.sh organize

# Archive old outputs
./scripts/output_manager.sh archive

# Search through outputs
./scripts/output_search.sh [keyword]

# Export outputs to different formats
./scripts/output_export.sh [output_dir] [format]
```

## Advanced Usage

### Custom Model Chains

You can create custom chains by specifying multiple models in sequence:

```bash
./scripts/run_chain.sh "Your complex prompt" model1 model2 model3
```

The output of each model becomes the input to the next, with appropriate prompting to maintain context.

### Customizing Models

Create custom Modelfiles in `src/models/` to optimize models for specific tasks.

Example Modelfile structure:
```
FROM base_model
PARAMETER temperature 0.4
PARAMETER top_p 0.85
SYSTEM """Your detailed system prompt here"""
```

### Logging and Debugging

Adjust log levels by setting the environment variable:

```bash
export MIRADOR_LOG_LEVEL=0  # DEBUG level (most verbose)
export MIRADOR_LOG_LEVEL=1  # INFO level (default)
export MIRADOR_LOG_LEVEL=2  # WARN level
export MIRADOR_LOG_LEVEL=3  # ERROR level (least verbose)
```

View logs in the `logs/` directory.
