# Mirador Models Guide

This document explains how to configure and optimize models for use with Mirador.

## Supported Base Models

Mirador works with any Ollama model, but has been specifically tested with:

- llama3.2
- llama3
- llama2
- mistral
- gemma2
- codellama
- phi
- mixtral

## Optimized Models

Mirador includes optimized modelfiles for specific purposes:

| Model | Purpose | Base Model | Optimization |
|-------|---------|------------|-------------|
| `guitar_expert_precise` | Guitar instruction | guitar-expert | Lower temperature (0.4), higher context |
| `llama3.2_balanced` | General assistance | llama3.2 | Balanced temperature (0.6), broad knowledge |
| `fast_agent_focused` | Task management | fast-agent | Focused on actionable plans |

## Building Optimized Models

To build the optimized models:

```bash
# Build the balanced general-purpose model
ollama create llama3.2_balanced -f ~/ai_framework_git/src/models/optimized/llama3.2_balanced.modelfile

# Build the precise guitar instruction model
ollama create guitar_expert_precise -f ~/ai_framework_git/src/models/optimized/guitar_expert_precise.modelfile

# Build the focused task management model
ollama create fast_agent_focused -f ~/ai_framework_git/src/models/optimized/fast_agent_focused.modelfile
```

## Creating Custom Models

To create a custom model, create a new modelfile in `src/models/optimized/` with the following structure:

```
FROM base_model

# Optimized parameters
PARAMETER temperature 0.X
PARAMETER top_p 0.XX
PARAMETER num_ctx XXXXX
PARAMETER num_gpu X
PARAMETER num_thread X

# Enhanced system prompt
SYSTEM """Your detailed system prompt here"""
```

Then build it with:

```bash
ollama create your_model_name -f ~/ai_framework_git/src/models/optimized/your_model_name.modelfile
```

## Parameter Recommendations

### Temperature

- **0.3-0.5**: More deterministic, better for precise technical responses
- **0.6-0.8**: Good balance for general-purpose use
- **0.9-1.2**: More creative, better for brainstorming

### Context Length (num_ctx)

- **4096**: Minimal context, use for very simple tasks
- **8192**: Standard context, good for most uses
- **16384**: Extended context, better for complex tasks with lots of context
- **32768**: Maximum context, use for extremely complex chains of reasoning

### Other Parameters

- **top_p**: Controls diversity of token selection (0.8-0.95 recommended)
- **num_gpu**: Number of GPUs to use (typically 1)
- **num_thread**: Number of CPU threads (4-8 recommended, adjust based on your system)

## System Prompts

A good system prompt should include:

1. Clear role definition
2. Specific capabilities or skills
3. Expected output format
4. Any constraints or rules

Example system prompt template:

```
You are a [SPECIFIC ROLE] with expertise in [DOMAIN]. Your capabilities include:

1. [CAPABILITY 1]: [DETAIL]
2. [CAPABILITY 2]: [DETAIL]
3. [CAPABILITY 3]: [DETAIL]
4. [CAPABILITY 4]: [DETAIL]
5. [CAPABILITY 5]: [DETAIL]

[ADDITIONAL INSTRUCTIONS OR CONSTRAINTS]

[OUTPUT FORMAT INSTRUCTIONS IF APPLICABLE]
```
