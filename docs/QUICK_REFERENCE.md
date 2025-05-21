# Mirador & Ollama - Simplified Guide

## Super Simple Commands (Just Works)

```bash
# Use any Ollama model directly
ollama-easy fast-agent "What is the capital of France?"
ollama-easy enhanced-agent "Deep research on AI history"
ollama-easy guitar_expert_precise "How to play barre chords"

# Source the updated aliases (do this once)
source ~/.zshrc
```

## Basic Commands (After setup)

```bash
# Quick questions - lightning fast answers
fast "What is the capital of France?"

# Deep research - more thoughtful responses
deep "Explain quantum computing"

# Run a specific model
domain-collab model creative-entrepreneur "Create a business plan"
```

## Domain-Specific Commands (Multiple Specialists)

```bash
# Music & Guitar focus
domain-collab domain music "Create a practice routine for sweep picking"

# Software Development with security focus
domain-collab domain dev "Design a secure authentication system in Python"

# Business & Marketing
domain-collab domain business "Create a content strategy for a new product"

# Financial Planning
domain-collab domain finance "How to create a budget for saving $10,000"

# Cross-domain projects
domain-collab domain cross "Design a guitar learning app business"
```

## Interactive Mode

```bash
# Start with domain selection menu
domain-collab interactive
```

## How It Works

This simplified interface connects your custom Ollama models with the Mirador framework:

1. **Ollama Direct**: Fast responses from single models with specialized training
2. **Domain Chains**: Multiple specialists collaborate on complex problems
3. **Mirador Integration**: Full access to advanced bidirectional communication

Your custom model optimizations (temperature settings, specialized roles) are preserved and utilized automatically.
