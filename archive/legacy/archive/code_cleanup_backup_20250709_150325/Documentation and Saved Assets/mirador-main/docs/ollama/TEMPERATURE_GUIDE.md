# Understanding Temperature in Ollama Models

Temperature is one of the most important parameters affecting model behavior. This guide explains how temperature works in the Mirador framework and how to select the right setting for your task.

## What is Temperature?

Temperature controls the randomness in model outputs:

- **Higher temperature** (0.7+): More creative, diverse, and sometimes unpredictable responses
- **Lower temperature** (0.3-0.4): More deterministic, focused, and consistent responses
- **Balanced temperature** (0.5-0.6): Mix of creativity and precision

## Temperature Settings in Mirador Models

### Low Temperature Models (0.3-0.4)

| Model | Temp | Best For | Example Use |
|-------|------|----------|-------------|
| `fast-agent` | 0.3 | Quick factual answers | "What is the capital of France?" |
| `fast_agent_focused` | 0.3 | Structured information | "Steps to change a tire" |
| `code_reviewer_fix` | 0.3 | Security analysis, bug detection | "Review this authentication code" |
| `master_coder` | 0.4 | Clean code implementation | "Create a sorting function" |
| `file_reviewer` | 0.4 | Documentation, technical writing | "Document this API" |
| `guitar_expert_precise` | 0.4 | Accurate music instruction | "Show G major scale with tablature" |

### Medium Temperature Models (0.5-0.6)

| Model | Temp | Best For | Example Use |
|-------|------|----------|-------------|
| `llama3.2_balanced` | 0.6 | General knowledge, balanced creativity | "Write a short story about AI" |

### High Temperature Models (0.7+)

| Model | Temp | Best For | Example Use |
|-------|------|----------|-------------|
| `enhanced_agent` | 0.7 | Comprehensive analysis, research | "Analyze remote work impact" |
| `creative_entrepreneur` | 0.7 | Business ideas, innovation | "Business opportunities in AI fitness" |
| `ux_designer` | 0.7 | Interface design, user experience | "Design a password reset flow" |

## When to Use Each Temperature Range

### Low Temperature (0.3-0.4)

**Best for tasks requiring precision:**
- Factual information and answers
- Code generation and technical documentation
- Step-by-step instructions
- Technical specifications
- Security-sensitive applications

**Signs you need lower temperature:**
- Responses are too verbose or contain irrelevant information
- Code solutions include unnecessary features
- Answers contain factual errors or hallucinations
- You need consistent, reproducible outputs

### Medium Temperature (0.5-0.6)

**Best for balanced tasks:**
- General knowledge questions
- Explanations that require some creativity
- Content that balances facts with engagement
- Most everyday interactions

**Signs you need medium temperature:**
- Low temperature responses are too rigid or boring
- High temperature responses are too unpredictable
- You need a balance of creativity and accuracy

### High Temperature (0.7+)

**Best for creative tasks:**
- Idea generation and brainstorming
- Business innovation and market opportunities
- Design concepts and user experience
- Creative writing and content creation

**Signs you need higher temperature:**
- Responses are too predictable or generic
- You need multiple diverse perspectives
- The task requires thinking "outside the box"
- You want to explore possibilities rather than definitive answers

## Temperature in Model Combinations

When combining models in chains or collaborative sessions, consider the temperature mix:

1. **Pure Precision Chain**: All low-temperature models for technical work
   ```bash
   ./scripts/run_chain.sh "Create a secure login system" master_coder code_reviewer_fix file_reviewer
   ```

2. **Balanced Chain**: Mix of temperatures for comprehensive solutions
   ```bash
   ./scripts/run_chain.sh "Design a guitar learning app" master_coder creative_entrepreneur
   ```

3. **Creative Chain**: Primarily high-temperature models for innovation
   ```bash
   ./scripts/run_chain.sh "Generate business ideas" enhanced_agent creative_entrepreneur
   ```

## Practical Examples

### Code Development (Low Temperature)
```bash
# Precise implementation with security review
./scripts/direct-ollama.sh master_coder "Write a function to validate passwords"
./scripts/direct-ollama.sh code_reviewer_fix "Review this password validation code"
```

### Business Planning (High Temperature)
```bash
# Creative business ideation
./scripts/direct-ollama.sh creative_entrepreneur "Innovative business models for online education"
```

### Learning Material (Mixed Temperature)
```bash
# Technical accuracy with engaging presentation
./scripts/run_chain.sh "Create a guide for learning sweep picking" guitar_expert_precise creative_entrepreneur
```

## Temperature Fine-Tuning

For advanced users, you can modify temperature in modelfiles:

```
FROM fast-agent

# Adjust temperature to your preference
PARAMETER temperature 0.35
```

Then rebuild the model:
```bash
cd ~/ai_framework_git/src/models/optimized
ollama create custom_model -f custom_model.modelfile
```

## Best Practices

1. **Start low, go high**: Begin with lower temperatures and increase if needed
2. **Task-appropriate settings**: Match temperature to the nature of your task
3. **Combine complementary models**: Mix temperatures for comprehensive solutions
4. **Test different settings**: Compare outputs at different temperatures
5. **Consider context window**: Larger context windows often work better with lower temperatures

By understanding temperature and its effects, you can select the optimal model or create the perfect chain for any task in the Mirador framework.