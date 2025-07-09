

echo "=== Mirador Accuracy Validation Suite ==="
echo "Timestamp: $(date)"
echo ""


echo "1. Financial Accuracy Tests:"
echo "   Testing income processing accuracy..."
mirador-ez ask financial_planning_expert_v2 "Create budget for Louisville family earning exactly $65,000 annually" > temp_financial_test.txt


if grep -q "65,000\|$65,000\|65000" temp_financial_test.txt; then
    echo "   ✓ Income processing: PASS"
else
    echo "   ✗ Income processing: FAIL - Check output for correct income amount"
fi


echo "2. Local Information Accuracy:"
echo "   Testing Louisville contact information..."
mirador-ez ask louisville_expert_v2 "Provide Louisville Metro Government contact information" > temp_local_test.txt


if grep -q "502.*574.*5000\|(502) 574-5000" temp_local_test.txt; then
    echo "   ✓ Contact information: PASS"
else
    echo "   ✗ Contact information: FAIL - Check for correct Metro Government number"
fi


echo "3. Chain Coherence Test:"
echo "   Testing model collaboration..."
mirador-ez chain "Analyze housing affordability for $70,000 income in Louisville" financial_planning_expert_v2 louisville_expert_v2 enhanced_agent_fast_v2 > temp_chain_test.txt


income_mentions=$(grep -o "70,000\|$70,000\|70000" temp_chain_test.txt | wc -l)
if [ $income_mentions -ge 2 ]; then
    echo "   ✓ Chain coherence: PASS"
else
    echo "   ✗ Chain coherence: FAIL - Income not consistently referenced"
fi


rm -f temp_*.txt

echo ""
echo "Accuracy validation complete."
