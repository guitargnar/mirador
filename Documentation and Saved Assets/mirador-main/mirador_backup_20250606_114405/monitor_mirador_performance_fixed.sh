#!/bin/bash

echo "=== Mirador Performance Monitor ==="
echo "Timestamp: $(date)"
echo ""

# Test individual model performance (macOS compatible)
echo "Individual Model Performance:"

echo "1. Enhanced Agent Fast V3:"
start_time=$(date +%s)
mirador-ez ask enhanced_agent_fast_v3 "Quick strategic analysis test" > /dev/null 2>&1
end_time=$(date +%s)
duration=$((end_time - start_time))
if [ $duration -lt 60 ]; then
    echo "   ✓ Success (${duration}s)"
else
    echo "   ✗ Slow or failed (${duration}s)"
fi

echo "2. Financial Planning Expert V3:"
start_time=$(date +%s)
mirador-ez ask financial_planning_expert_v3 "Budget test for $70,000 income" > /dev/null 2>&1
end_time=$(date +%s)
duration=$((end_time - start_time))
if [ $duration -lt 90 ]; then
    echo "   ✓ Success (${duration}s)"
else
    echo "   ✗ Slow or failed (${duration}s)"
fi

echo "3. Louisville Expert V2:"
start_time=$(date +%s)
mirador-ez ask louisville_expert_v2 "Local resources test" > /dev/null 2>&1
end_time=$(date +%s)
duration=$((end_time - start_time))
if [ $duration -lt 60 ]; then
    echo "   ✓ Success (${duration}s)"
else
    echo "   ✗ Slow or failed (${duration}s)"
fi

echo ""
echo "Performance monitoring complete."
