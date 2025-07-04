#!/bin/bash
echo "=== Mirador Performance Analysis ==="
echo "Date: $(date)"
echo ""

# Test individual model latency
models=("financial_planning_expert_v6" "enhanced_agent_enforcer" "louisville_expert_v3")
for model in "${models[@]}"; do
    echo "Testing $model..."
    start=$(date +%s)
    timeout 60s mirador-ez ask "$model" "Performance benchmark test" > /dev/null 2>&1
    end=$(date +%s)
    duration=$((end - start))
    echo "  Response time: ${duration}s"
done

echo ""
echo "Chain execution test..."
start=$(date +%s)
timeout 180s mirador-ez chain "Performance test chain" "${models[@]}" > /dev/null 2>&1
end=$(date +%s)
duration=$((end - start))
echo "  Chain completion time: ${duration}s"
