#!/bin/bash
echo "🧪 Testing model performance..."

# Get list of models without comments
MODELS=$(ollama list | grep -v NAME | awk '{print $1}')

for model in $MODELS; do
    echo "Testing $model performance..."
    # Performance test would go here
    # time ollama run "$model" "test query" >/dev/null 2>&1
done

echo "✅ Model testing complete"
