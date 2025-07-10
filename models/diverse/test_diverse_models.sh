#!/bin/bash
# Test diverse models with the same prompt

PROMPT="How can I improve my productivity while maintaining work-life balance?"

echo "🧪 Testing Diverse Models"
echo "========================"
echo "Prompt: $PROMPT"
echo ""

# Test each model
for model in analytical_expert_gemma:latest multilingual_assistant_qwen:latest speed_optimizer_phi:latest baseline_llama_compact:latest; do
    echo "Testing $model..."
    echo "---"
    response=$(echo "$PROMPT" | ollama run "$model" --verbose 2>&1)
    
    # Extract timing info
    timing=$(echo "$response" | grep -E "eval count|duration" | tail -2)
    
    echo "$response" | head -20
    echo "..."
    echo "Timing: $timing"
    echo ""
done
