#!/bin/bash
# Mirador Model Validation Script
# Tests all consolidated models for basic functionality

echo "🧪 Validating Mirador models..."

echo "Testing matthew_context_provider_v2..."
if ollama run matthew_context_provider_v2 "Hello, please confirm you are working correctly." > /dev/null 2>&1; then
    echo "✅ matthew_context_provider_v2 is working"
else
    echo "❌ matthew_context_provider_v2 failed validation"
fi

echo "Testing decision_simplifier_v2..."
if ollama run decision_simplifier_v2 "Hello, please confirm you are working correctly." > /dev/null 2>&1; then
    echo "✅ decision_simplifier_v2 is working"
else
    echo "❌ decision_simplifier_v2 failed validation"
fi

echo "Testing financial_planning_expert_v6..."
if ollama run financial_planning_expert_v6 "Hello, please confirm you are working correctly." > /dev/null 2>&1; then
    echo "✅ financial_planning_expert_v6 is working"
else
    echo "❌ financial_planning_expert_v6 failed validation"
fi

echo "Testing financial_planning_expert_fast..."
if ollama run financial_planning_expert_fast "Hello, please confirm you are working correctly." > /dev/null 2>&1; then
    echo "✅ financial_planning_expert_fast is working"
else
    echo "❌ financial_planning_expert_fast failed validation"
fi

echo "Testing louisville_expert_v3..."
if ollama run louisville_expert_v3 "Hello, please confirm you are working correctly." > /dev/null 2>&1; then
    echo "✅ louisville_expert_v3 is working"
else
    echo "❌ louisville_expert_v3 failed validation"
fi

echo "Testing enhanced_agent_enforcer_v2..."
if ollama run enhanced_agent_enforcer_v2 "Hello, please confirm you are working correctly." > /dev/null 2>&1; then
    echo "✅ enhanced_agent_enforcer_v2 is working"
else
    echo "❌ enhanced_agent_enforcer_v2 failed validation"
fi

echo "Testing enhanced_agent_fast_v6..."
if ollama run enhanced_agent_fast_v6 "Hello, please confirm you are working correctly." > /dev/null 2>&1; then
    echo "✅ enhanced_agent_fast_v6 is working"
else
    echo "❌ enhanced_agent_fast_v6 failed validation"
fi

echo "Testing mirador_system_specialist_v2..."
if ollama run mirador_system_specialist_v2 "Hello, please confirm you are working correctly." > /dev/null 2>&1; then
    echo "✅ mirador_system_specialist_v2 is working"
else
    echo "❌ mirador_system_specialist_v2 failed validation"
fi

echo "Testing linkedin_content_expert..."
if ollama run linkedin_content_expert "Hello, please confirm you are working correctly." > /dev/null 2>&1; then
    echo "✅ linkedin_content_expert is working"
else
    echo "❌ linkedin_content_expert failed validation"
fi

echo "Testing real_estate_analyzer..."
if ollama run real_estate_analyzer "Hello, please confirm you are working correctly." > /dev/null 2>&1; then
    echo "✅ real_estate_analyzer is working"
else
    echo "❌ real_estate_analyzer failed validation"
fi

echo "Testing health_wellness_optimizer..."
if ollama run health_wellness_optimizer "Hello, please confirm you are working correctly." > /dev/null 2>&1; then
    echo "✅ health_wellness_optimizer is working"
else
    echo "❌ health_wellness_optimizer failed validation"
fi

echo "Testing productivity_optimizer..."
if ollama run productivity_optimizer "Hello, please confirm you are working correctly." > /dev/null 2>&1; then
    echo "✅ productivity_optimizer is working"
else
    echo "❌ productivity_optimizer failed validation"
fi

echo "🎉 Model validation complete!"
