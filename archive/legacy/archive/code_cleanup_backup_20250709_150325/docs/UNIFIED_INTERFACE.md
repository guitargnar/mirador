# Mirador & Ollama Integration Design

The integration between your Ollama models and the Mirador framework is elegantly simple. This document explains how your modelfiles and system prompts serve as the perfect foundation for Mirador.

## Understanding Ollama Modelfiles

Your Ollama modelfiles contain two key elements that allow Mirador to build on top of them without overengineering:

1. **Specialized System Prompts**
   - **Fast Agent**: Optimized for concise, direct responses (temp 0.3)
   - **Guitar Expert**: Specialized in music with tablature generation (temp 0.4)
   - **Master Coder**: Deep software engineering expertise (temp 0.4)

2. **Optimized Parameters**
   - Custom temperature settings for different tasks
   - Specialized context windows (guitar_expert: 16384, fast_agent: 2048)
   - Fine-tuned top_p, top_k values for different models

## How Mirador Leverages Your Modelfiles

Mirador doesn't replace or duplicate your model customizations - it uses them as building blocks:

1. **Direct Access Layer**
   ```bash
   # When you run
   domain-collab fast "What is Paris?"
   
   # It simply runs
   ollama run fast-agent "What is Paris?"
   ```

2. **Message Bus & Collaboration**
   - Mirador's advanced features aren't reimplementations - they're orchestration
   - The message bus coordinates between your existing specialized models
   - Each model uses its own optimized parameters and system prompt

3. **Domain Specialization**
   - Domain configurations are just groupings of your existing models
   - No duplicated system prompts or parameters
   - The domain-collab script translates domain names into specific model combinations

## Simplicity Pattern

The architecture follows a "thin orchestration layer" pattern:

```
User Request → domain-collab → Ollama API → Your Modelfiles → Response
```

When more advanced features are needed, domain-collab adds minimal routing:

```
User Request → domain-collab → Message Bus → Specialists → Ollama API → Response
```

## Benefits of This Approach

1. **Single Source of Truth**: Your model customizations live only in Ollama
2. **Minimal Overhead**: No duplication of system prompts or parameters
3. **Maintainability**: Update system prompts in one place (Ollama)
4. **Flexibility**: Use direct Ollama access or advanced collaboration as needed
5. **Stability**: If Mirador has issues, you can always fall back to direct Ollama
