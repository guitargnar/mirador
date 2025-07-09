

echo "=== Comprehensive Mirador Quality Assurance ==="
echo "Timestamp: $(date)"
echo ""


mkdir -p qa_results/$(date +%Y%m%d_%H%M%S)
QA_DIR="qa_results/$(date +%Y%m%d_%H%M%S)"

echo "Results will be saved to: $QA_DIR"


echo "1. Individual Model Quality Assessment:"
echo "   Testing enhanced_agent_fast_v2..."
mirador-ez ask enhanced_agent_fast_v2 "Provide strategic analysis for Louisville home buying process" > "$QA_DIR/enhanced_agent_test.txt"
echo "   ✓ Enhanced agent test saved"

echo "   Testing financial_planning_expert_v2..."
mirador-ez ask financial_planning_expert_v2 "Create detailed budget for Louisville family earning $75,000 with two children" > "$QA_DIR/financial_expert_test.txt"
echo "   ✓ Financial expert test saved"

echo "   Testing louisville_expert_v2..."
mirador-ez ask louisville_expert_v2 "Provide comprehensive guide to Louisville neighborhoods for families" > "$QA_DIR/louisville_expert_test.txt"
echo "   ✓ Louisville expert test saved"


echo "2. Chain Quality Assessment:"
echo "   Testing comprehensive 3-model chain..."
mirador-ez chain "Create complete home buying and financial plan for Louisville family earning $80,000" financial_planning_expert_v2 louisville_expert_v2 enhanced_agent_fast_v2 > "$QA_DIR/comprehensive_chain_test.txt"
echo "   ✓ Comprehensive chain test saved"


echo "3. Accuracy Validation:"
echo "   Testing specific income processing..."
mirador-ez ask financial_planning_expert_v2 "Budget analysis for exactly $67,500 annual income in Louisville" > "$QA_DIR/accuracy_income_test.txt"


if grep -q "67,500\|$67,500" "$QA_DIR/accuracy_income_test.txt"; then
    echo "   ✓ Income accuracy: PASS"
    echo "PASS" > "$QA_DIR/income_accuracy_result.txt"
else
    echo "   ✗ Income accuracy: FAIL"
    echo "FAIL" > "$QA_DIR/income_accuracy_result.txt"
fi


echo "4. Performance Metrics:"
echo "   Measuring execution times..."

start_time=$(date +%s)
mirador-ez ask enhanced_agent_fast_v2 "Quick strategic analysis" > /dev/null 2>&1
end_time=$(date +%s)
enhanced_time=$((end_time - start_time))
echo "   Enhanced agent time: ${enhanced_time}s"

start_time=$(date +%s)
mirador-ez ask financial_planning_expert_v2 "Quick budget analysis for $60,000" > /dev/null 2>&1
end_time=$(date +%s)
financial_time=$((end_time - start_time))
echo "   Financial expert time: ${financial_time}s"


echo "enhanced_agent_fast_v2: ${enhanced_time}s" > "$QA_DIR/performance_metrics.txt"
echo "financial_planning_expert_v2: ${financial_time}s" >> "$QA_DIR/performance_metrics.txt"


echo "5. Generating QA Summary..."
cat > "$QA_DIR/qa_summary.txt" << SUMMARY
Mirador Quality Assurance Summary
Generated: $(date)

Individual Model Tests:
- Enhanced Agent Fast V2: Completed
- Financial Planning Expert V2: Completed  
- Louisville Expert V2: Completed

Chain Tests:
- 3-Model Comprehensive Chain: Completed

Accuracy Tests:
- Income Processing: $(cat "$QA_DIR/income_accuracy_result.txt")

Performance Metrics:
- Enhanced Agent: ${enhanced_time}s
- Financial Expert: ${financial_time}s

All test outputs saved in: $QA_DIR

Next Steps:
1. Review individual model outputs for quality
2. Verify chain coherence and collaboration
3. Validate accuracy of financial calculations
4. Confirm Louisville-specific information accuracy
SUMMARY

echo "   ✓ QA Summary generated"
echo ""
echo "Quality assurance complete. Review results in: $QA_DIR"
echo "Key files to review:"
echo "- qa_summary.txt (overall summary)"
echo "- comprehensive_chain_test.txt (chain collaboration quality)"
echo "- financial_expert_test.txt (financial accuracy)"
echo "- accuracy_income_test.txt (income processing accuracy)"
