#!/bin/bash
# Validate Critical Mirador Models
# Tests basic functionality of newly built models

echo "🧪 Validating critical models..."

echo "Testing matthew_context_provider_v2..."
if timeout 30 ollama run matthew_context_provider_v2 "Provide context about Matthew's current situation and goals." > /dev/null 2>&1; then
    echo "✅ matthew_context_provider_v2 is working"
else
    echo "❌ matthew_context_provider_v2 failed validation"
fi

echo "Testing financial_planning_expert_v6..."
if timeout 30 ollama run financial_planning_expert_v6 "Create a basic budget framework for someone earning $75,000 annually." > /dev/null 2>&1; then
    echo "✅ financial_planning_expert_v6 is working"
else
    echo "❌ financial_planning_expert_v6 failed validation"
fi

echo "Testing decision_simplifier_v2..."
if timeout 30 ollama run decision_simplifier_v2 "Help me decide between saving for a house vs investing in retirement." > /dev/null 2>&1; then
    echo "✅ decision_simplifier_v2 is working"
else
    echo "❌ decision_simplifier_v2 failed validation"
fi

echo "Testing louisville_expert_v3..."
if timeout 30 ollama run louisville_expert_v3 "What are good neighborhoods in Louisville for young professionals?" > /dev/null 2>&1; then
    echo "✅ louisville_expert_v3 is working"
else
    echo "❌ louisville_expert_v3 failed validation"
fi

echo "Testing enhanced_agent_enforcer_v2..."
if timeout 30 ollama run enhanced_agent_enforcer_v2 "Review this statement for accuracy: Louisville is the capital of Kentucky." > /dev/null 2>&1; then
    echo "✅ enhanced_agent_enforcer_v2 is working"
else
    echo "❌ enhanced_agent_enforcer_v2 failed validation"
fi

echo "Testing enhanced_agent_fast_v6..."
if timeout 30 ollama run enhanced_agent_fast_v6 "Quick check: Is this a reasonable financial goal - save $10,000 in 6 months on $50,000 salary?" > /dev/null 2>&1; then
    echo "✅ enhanced_agent_fast_v6 is working"
else
    echo "❌ enhanced_agent_fast_v6 failed validation"
fi

echo "🎉 Validation complete!"
