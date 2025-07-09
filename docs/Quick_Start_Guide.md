# Mirador AI Framework - Quick Start Guide

## 🚀 Getting Started with the Improved Framework

### 1. Basic Usage - Run a Simple Query

```bash
# Using the improved error handling
python -c "
from src.error_handler import ChainExecutor

chain = ChainExecutor()
result = chain.execute_chain(
    ['universal_context_provider', 'universal_action_generator'],
    'What should I focus on today?'
)
print(result['final_output'])
"
```

### 2. Smart Model Selection

```python
from src.model_registry import ModelRegistry, DynamicRouter

# Initialize
registry = ModelRegistry()
router = DynamicRouter(registry)

# Let the system choose models for you
query = "Help me balance work and family commitments"
intent = router.classifier.classify_query_intent(query)

# Get recommended models
requirements = {
    'needs': ['work_life_balance', 'scheduling'],
    'constraints': {'max_time': 30}
}
models = router.classifier.match_models_to_requirements(requirements)

# Execute with selected models
from src.error_handler import ChainExecutor
chain = ChainExecutor()
model_ids = [m['id'] for m in models]
result = chain.execute_chain(model_ids, query)
```

### 3. Optimized Prompting

```python
from src.prompt_optimizer import PromptOptimizer

optimizer = PromptOptimizer()

# Create optimized prompt
context = {
    'query': 'Plan my week',
    'user_context': {
        'role': 'Risk Manager',
        'family': 'Married with children'
    },
    'required_capabilities': ['scheduling', 'priority_setting']
}

# Generate efficient prompt
prompt = optimizer.generate_dynamic_prompt('universal_life_optimizer', context)
```

## 📊 Key Improvements at a Glance

| Feature | Before | After | Benefit |
|---------|--------|-------|---------|
| Model Count | 80+ | 7 | 91% simpler |
| Prompt Tokens | ~1000 | ~400-600 | 40-60% reduction |
| Error Recovery | Manual | Automatic | Zero downtime |
| Model Selection | Manual chain building | AI-powered routing | Optimal performance |

## 🎯 Common Use Cases

### Daily Planning
```python
result = chain.execute_chain(
    ['universal_context_provider', 'universal_life_optimizer'],
    'What are my top 3 priorities today?'
)
```

### Financial Analysis
```python
result = chain.execute_chain(
    ['universal_financial_advisor', 'universal_action_generator'],
    'Analyze my budget and suggest improvements'
)
```

### Strategic Planning
```python
result = chain.execute_chain(
    ['universal_strategic_advisor', 'universal_synthesizer'],
    'Create a 90-day plan for my career growth'
)
```

## ⚡ Performance Tips

1. **Use Fewer Models**: 2-3 models usually suffice (vs old 5-6)
2. **Trust Fallbacks**: System automatically handles failures
3. **Cache Benefits**: Repeated queries are faster (5-min cache)
4. **Capability Matching**: Let the system pick models based on needs

## 🔧 Troubleshooting

### If models fail repeatedly:
```python
# Check circuit breaker status
is_available = chain.executor.circuit_breaker.is_available('model_name')

# Reset circuit breaker if needed
chain.executor.circuit_breaker.failures.clear()
chain.executor.circuit_breaker.circuit_open.clear()
```

### If results seem generic:
```python
# Add more specific capabilities
context['required_capabilities'] = ['financial_analysis', 'investment_planning']

# Provide richer context
context['user_context'] = {
    'role': 'Your role',
    'goals': 'Specific goals',
    'constraints': 'Time/resource limits'
}
```

## 🚦 Health Check

```python
# Quick system health check
def health_check():
    from src.model_registry import ModelRegistry
    from src.error_handler import ChainExecutor
    
    registry = ModelRegistry()
    chain = ChainExecutor()
    
    # Test basic execution
    result = chain.execute_chain(
        ['universal_context_provider'],
        'System health check'
    )
    
    return {
        'models_available': len(registry.consolidated_models),
        'execution_success': result.get('partial_success', False),
        'fallback_ready': 'llama3.2:3b' in str(result)
    }

print(health_check())
```

## 📈 Monitoring Performance

```python
# Track execution metrics
result = chain.execute_chain(models, query)

print(f"Execution time: {result['total_execution_time']:.2f}s")
print(f"Models completed: {len(result['completed_models'])}")
print(f"Warnings: {len(result['warnings'])}")
print(f"Cache hits: {'cache_hit' in str(result)}")
```

## 🎉 You're Ready!

Start with the basic usage examples above and gradually explore advanced features as needed. The improved framework handles complexity behind the scenes, letting you focus on getting results.

Remember: **Less is more** - fewer models, optimized prompts, automatic recovery!