#!/bin/bash
echo "=== Mirador System Maintenance ==="
echo "Date: $(date)"
echo ""

# Check Ollama service
echo "Checking Ollama service..."
if pgrep ollama > /dev/null; then
    echo "✓ Ollama is running"
else
    echo "✗ Ollama is not running - starting..."
    brew services start ollama
fi

# Verify all models are available
echo ""
echo "Verifying AI models..."
for model in mirador_system_specialist financial_planning_expert_v6 louisville_expert_v3 enhanced_agent_enforcer opportunity_validator_v2 decision_simplifier matthew_context_provider; do
    if ollama list | grep -q "$model"; then
        echo "✓ $model available"
    else
        echo "✗ $model missing"
    fi
done

# Check disk space for outputs
echo ""
echo "Storage status:"
df -h ~/ai_framework_git/outputs | tail -1

# Recent activity
echo ""
echo "Recent analyses (last 5):"
ls -lt ~/ai_framework_git/outputs | grep chain_ | head -5

echo ""
echo "System health check complete."
