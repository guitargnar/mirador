#!/bin/bash

echo "=== Mirador Performance Test (macOS) ==="
echo "Date: $(date)"
echo ""

# Function to time commands on macOS
time_command() {
    local model=$1
    local prompt=$2
    local start=$(date +%s)
    
    # Run with timeout using perl (built-in on macOS)
    perl -e 'alarm shift; exec @ARGV' 30 mirador-ez ask "$model" "$prompt" > /dev/null 2>&1
    local exit_code=$?
    
    local end=$(date +%s)
    local duration=$((end - start))
    
    if [ $exit_code -eq 0 ]; then
        echo "✓ $model: ${duration}s"
    elif [ $exit_code -eq 142 ]; then
        echo "⚠️ $model: TIMEOUT (>30s)"
    else
        echo "✗ $model: FAILED (exit code: $exit_code)"
    fi
}

# Test individual models
echo "Testing Individual Models:"
time_command "financial_planning_expert_v6" "Performance test"
time_command "enhanced_agent_enforcer" "Performance test"
time_command "louisville_expert_v3" "Performance test"
time_command "matthew_context_provider_v2" "Performance test"

echo ""
echo "Testing Chain Execution:"
start=$(date +%s)
mirador-ez chain "Performance test chain" financial_planning_expert_v6 enhanced_agent_enforcer > /dev/null 2>&1
end=$(date +%s)
duration=$((end - start))
echo "✓ 2-Model Chain: ${duration}s"
