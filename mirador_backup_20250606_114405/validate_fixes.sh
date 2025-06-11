#!/bin/bash

echo "=== Validating Critical Fixes ==="
echo "Timestamp: $(date)"
echo ""

# Test income processing accuracy
echo "1. Testing Income Processing Accuracy:"
mirador-ez ask financial_planning_expert_v3 "Create budget for Louisville family earning exactly $82,000 annually" > temp_income_test.txt

if grep -q "82,000\|$82,000\|82000" temp_income_test.txt; then
    echo "   ✓ Income processing: FIXED"
else
    echo "   ✗ Income processing: STILL BROKEN"
fi

# Test chain content addition
echo "2. Testing Chain Content Addition:"
mirador-ez chain "Analyze housing affordability for $70,000 income in Louisville" financial_planning_expert_v3 enhanced_agent_fast_v3 > temp_chain_test.txt

# Check if enhanced agent added content
word_count=$(wc -w < temp_chain_test.txt)
if [ $word_count -gt 500 ]; then
    echo "   ✓ Content addition: FIXED"
else
    echo "   ✗ Content addition: STILL BROKEN"
fi

# Cleanup
rm -f temp_*.txt

echo ""
echo "Validation complete."
