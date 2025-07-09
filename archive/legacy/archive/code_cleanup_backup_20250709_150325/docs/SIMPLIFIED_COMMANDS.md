# Mirador & Ollama Practical Examples

## Simple Direct Model Access

```bash
# Quick question about a programming language
domain-collab fast "What are the main features of Python?"

# Guitar technique question with tablature response
domain-collab model guitar_expert_precise "Show me a C major scale pattern on guitar"

# Coding example with best practices
domain-collab model master_coder "Create a secure password validation function in JavaScript"
```

## Combined Specialist Workflows

```bash
# Music practice planning (guitar_expert_precise + content_creator)
domain-collab domain music "Create a 30-day practice plan for improving sweep picking"

# Secure coding project (master_coder + code_reviewer_fix + security_expert)
domain-collab domain dev "Build a user authentication system with JWT tokens"

# Business plan (creative_entrepreneur + content_creator)
domain-collab domain business "Create a business plan for a guitar learning app"
```

## Using the Interactive Mode

```bash
domain-collab interactive
# Then follow the prompts to select domain and enter your question
```

## Creating Your Own Combinations

```bash
# Combine models for guitar app development
domain-collab domain custom "guitar_expert_precise master_coder creative_entrepreneur" "Design a guitar learning app with gamification features"
```

## Fallback to Pure Ollama

```bash
# If you want to skip Mirador and use Ollama directly
ollama-easy fast-agent "What's the capital of France?"
```
