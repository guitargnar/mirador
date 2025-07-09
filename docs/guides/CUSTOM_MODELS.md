# Creating Custom Models

Mirador allows you to create specialized AI models tailored to your specific needs while maintaining complete privacy.

## Model Structure

A Mirador model consists of:
1. Base model (usually Llama)
2. System prompt defining behavior
3. Parameters for performance tuning

## Basic Model Template

Create a file `my_custom_model.modelfile`:

```dockerfile
FROM llama3.2:latest

PARAMETER temperature 0.7
PARAMETER top_p 0.9
PARAMETER num_ctx 8192

SYSTEM """You are a specialized assistant focused on [YOUR DOMAIN].

Core capabilities:
- [Capability 1]
- [Capability 2]
- [Capability 3]

Always:
- Provide practical, actionable advice
- Consider multiple perspectives
- Respect user privacy
- Maintain professional boundaries
"""
```

## Creating the Model

```bash
# Create model from modelfile
ollama create my_custom_model -f my_custom_model.modelfile

# Test it
ollama run my_custom_model "Test prompt"
```

## Model Examples

### Domain Expert Model
```dockerfile
FROM llama3.2:latest

SYSTEM """You are a domain expert in sustainable living and environmental practices.

Your role:
- Provide eco-friendly alternatives
- Calculate environmental impact
- Suggest practical changes
- Consider budget constraints

Always prioritize practical, achievable solutions."""
```

### Creative Writing Assistant
```dockerfile
FROM llama3.2:latest

PARAMETER temperature 0.9
PARAMETER top_p 0.95

SYSTEM """You are a creative writing assistant specializing in storytelling.

Focus on:
- Character development
- Plot structure
- Narrative techniques
- Genre conventions

Provide constructive feedback and creative suggestions."""
```

### Technical Advisor
```dockerfile
FROM llama3.2:latest

PARAMETER temperature 0.5

SYSTEM """You are a technical advisor for software architecture.

Expertise:
- System design patterns
- Performance optimization
- Security best practices
- Scalability considerations

Provide clear, implementable technical guidance."""
```

## Adding Models to Chains

1. Create your model
2. Add it to a chain configuration:

```bash
# Edit the chain runner script
vim bin/mirador_universal_runner_v2.sh

# Add your model to the appropriate chain
case "$CHAIN_TYPE" in
    "custom_chain")
        MODELS=(
            "context_provider"
            "my_custom_model"    # Add here
            "decision_simplifier"
        )
        ;;
esac
```

## Best Practices

### 1. Clear System Prompts
- Define the model's role clearly
- List specific capabilities
- Set behavioral boundaries
- Include output format preferences

### 2. Temperature Settings
- Lower (0.3-0.5): Factual, consistent responses
- Medium (0.6-0.8): Balanced creativity and accuracy
- Higher (0.9-1.0): Creative, varied responses

### 3. Context Window
- Default: 8192 tokens
- Increase for complex analysis
- Decrease for faster responses

### 4. Testing Your Models
```bash
# Test single model
ollama run my_model "Test prompt"

# Test in chain
./mirador custom_chain "Complex query"

# Compare outputs
./scripts/test/compare_models.sh my_model baseline_model "Same prompt"
```

## Personal Context Models

For personal use (not for public sharing):

```dockerfile
FROM llama3.2:latest

SYSTEM """You are a personal assistant with knowledge of:

Professional Context:
- Industry: [Your industry]
- Role: [Your role]
- Skills: [Your key skills]

Personal Preferences:
- Communication style: [Your style]
- Work hours: [Your schedule]
- Priorities: [Your priorities]

This information stays local and private."""
```

## Privacy Guidelines

1. **Never commit personal models** to version control
2. **Use generic templates** in public repositories
3. **Keep personal context** in separate, local files
4. **Test thoroughly** before sharing model definitions

## Troubleshooting

### Model Creation Fails
```bash
# Check Ollama is running
ollama list

# Verify base model exists
ollama pull llama3.2:latest

# Check modelfile syntax
cat -n my_model.modelfile
```

### Poor Model Performance
- Adjust temperature
- Refine system prompt
- Add more specific examples
- Test different base models

### Memory Issues
- Reduce context window size
- Use smaller base models
- Close other applications

## Advanced Techniques

### Multi-Stage Models
Create models that work well in sequence:

1. **Analyzer Model**: Breaks down problems
2. **Strategy Model**: Develops approaches
3. **Implementation Model**: Provides specific steps

### Domain-Specific Chains
Combine models for specialized workflows:

```bash
# Financial planning chain
MODELS=(
    "context_provider"
    "financial_analyzer"
    "risk_assessor"
    "portfolio_optimizer"
    "action_planner"
)
```

## Resources

- [Ollama Modelfile Reference](https://github.com/ollama/ollama/blob/main/docs/modelfile.md)
- [Parameter Tuning Guide](https://ollama.ai/docs/parameters)
- [Example Models](../../models/README.md)