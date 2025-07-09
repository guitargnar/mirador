#!/bin/bash

echo "=== Mirador Production Readiness Validation ==="
echo "Timestamp: $(date)"
echo ""

VALIDATION_PASSED=true

# Test 1: Model Availability
echo "1. Model Availability Check:"
models=("enhanced_agent_fast_v2" "financial_planning_expert_v2" "louisville_expert_v2")

for model in "${models[@]}"; do
    if ollama list | grep -q "$model"; then
        echo "   ✓ $model: Available"
    else
        echo "   ✗ $model: Missing"
        VALIDATION_PASSED=false
    fi
done

# Test 2: Performance Standards
echo ""
echo "2. Performance Standards Check:"

# Enhanced agent should complete in under 60 seconds
echo "   Testing enhanced_agent_fast_v2 performance..."
timeout 60s mirador-ez ask enhanced_agent_fast_v2 "Strategic analysis test" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "   ✓ Enhanced agent: Under 60s"
else
    echo "   ✗ Enhanced agent: Over 60s or failed"
    VALIDATION_PASSED=false
fi

# Financial expert should complete in under 90 seconds
echo "   Testing financial_planning_expert_v2 performance..."
timeout 90s mirador-ez ask financial_planning_expert_v2 "Budget test for $70,000" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "   ✓ Financial expert: Under 90s"
else
    echo "   ✗ Financial expert: Over 90s or failed"
    VALIDATION_PASSED=false
fi

# Test 3: Chain Functionality
echo ""
echo "3. Chain Functionality Check:"
echo "   Testing 2-model chain..."
timeout 180s mirador-ez chain "Test production readiness" financial_planning_expert_v2 enhanced_agent_fast_v2 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "   ✓ 2-model chain: Success"
else
    echo "   ✗ 2-model chain: Failed"
    VALIDATION_PASSED=false
fi

# Test 4: Accuracy Validation
echo ""
echo "4. Accuracy Validation:"
echo "   Testing income processing accuracy..."
mirador-ez ask financial_planning_expert_v2 "Budget for exactly $72,000 income" > temp_accuracy_check.txt 2>&1

if grep -q "72,000\|$72,000" temp_accuracy_check.txt; then
    echo "   ✓ Income processing: Accurate"
else
    echo "   ✗ Income processing: Inaccurate"
    VALIDATION_PASSED=false
fi

rm -f temp_accuracy_check.txt

# Final Assessment
echo ""
echo "=== PRODUCTION READINESS ASSESSMENT ==="
if [ "$VALIDATION_PASSED" = true ]; then
    echo "✓ PASS: System ready for production deployment"
    echo ""
    echo "Deployment approved. You can proceed with confidence."
    echo ""
    echo "Recommended next steps:"
    echo "1. Update your regular Mirador usage to use the v2 models"
    echo "2. Monitor performance for the first week"
    echo "3. Run weekly validation checks"
    exit 0
else
    echo "✗ FAIL: System not ready for production"
    echo ""
    echo "Issues must be resolved before deployment."
    echo "Review the failed checks above and re-run validation."
    exit 1
fi
