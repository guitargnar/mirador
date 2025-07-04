# Ollama & Mirador Reference Card

## Direct Ollama Commands (Simplest)

```bash
# Run any model directly with Ollama CLI
ollama run fast-agent "What is the capital of France?"
ollama run master_coder "Write a Python function to sort a list"
ollama run guitar_expert_precise "Show me how to play a G chord"

# List available models
ollama list

# Examine model details
ollama show fast-agent
```

## Ultra-Simple Script (~/run-ollama.sh)

```bash
# Use default model (fast-agent)
./run-ollama.sh "What is Python?"

# Specify a model
./run-ollama.sh guitar_expert_precise "Show me a G chord"
./run-ollama.sh creative_entrepreneur "Marketing plan for a food truck"
```

## Original Mirador Chain Commands

```bash
# Basic model chain (sequence multiple models)
cd ~/ai_framework_git
./scripts/run_chain.sh "Create a Python API" master_coder code_reviewer_fix

# Role-based chain for code analysis
./scripts/run_role_chain.sh "def example(): pass" master_coder code_reviewer_fix

# Run specialized workflow
./scripts/run_workflow.sh practice
```

## Advanced Mirador Features

```bash
# Bidirectional Specialist Communication
cd ~/ai_framework_git
./mirador-collaborate "Create a secure authentication system"

# Specific specialists with collaboration
./mirador-collaborate --specialists master_coder security_expert code_reviewer_fix "Design a database schema"

# Dynamic specialist selection
./mirador-conductor "Create a secure login system in Python"

# Interactive session
./mirador-interactive

# User intervention in specialist communication
./mirador-intervene start
```

## Python-Based Mirador Commands

```bash
# Run standard Python Mirador
cd ~/ai_framework
./mirador run "Help me plan my week"

# Run specific chain
./mirador chain finance_advisor task_manager

# List domains
./mirador domains
```

## What Makes Each Approach Different

| Approach | Pros | Cons | Best For |
|----------|------|------|----------|
| **Direct Ollama** | • Simplest<br>• Most reliable<br>• No dependencies | • One model at a time<br>• No chain capabilities | Quick questions or specific tasks |
| **run-ollama.sh** | • Simplified syntax<br>• Default model handling<br>• Still very simple | • No multi-model chains<br>• No advanced features | Daily use for single-model tasks |
| **Basic Chain** | • Combine multiple models<br>• Sequential processing<br>• Organized outputs | • More complex syntax<br>• No bidirectional communication | Complex problems needing multiple viewpoints |
| **Bidirectional** | • Models can communicate<br>• Self-questioning capabilities<br>• Higher quality output | • Most complex<br>• More can go wrong | Sophisticated problems where specialists must collaborate |
| **Python Interface** | • Structured outputs<br>• Integration with Python<br>• Domain templates | • Separate system<br>• Different command structure | Integration with other tools/systems |

## Choosing the Right Approach

1. **For quick questions**: Use direct Ollama commands or run-ollama.sh
2. **For single-specialist tasks**: Use run-ollama.sh with specific model
3. **For complex problems**: Use bidirectional communication
4. **For code reviews**: Use role-based chains
5. **For specific domains**: Use domain-specific workflows
