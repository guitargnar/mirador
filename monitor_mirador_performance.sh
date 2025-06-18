

echo "=== Mirador Performance Monitor ==="
echo "Timestamp: $(date)"
echo ""


echo "Individual Model Performance:"
echo "1. Enhanced Agent Fast V2:"
time timeout 60s mirador-ez ask enhanced_agent_fast_v2 "Quick strategic analysis test" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "   ✓ Success (under 60s)"
else
    echo "   ✗ Failed or timeout"
fi

echo "2. Financial Planning Expert V2:"
time timeout 90s mirador-ez ask financial_planning_expert_v2 "Budget test for $70,000 income" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "   ✓ Success (under 90s)"
else
    echo "   ✗ Failed or timeout"
fi

echo "3. Louisville Expert V2:"
time timeout 60s mirador-ez ask louisville_expert_v2 "Local resources test" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "   ✓ Success (under 60s)"
else
    echo "   ✗ Failed or timeout"
fi


echo ""
echo "Chain Performance:"
echo "Testing 2-model chain..."
time timeout 180s mirador-ez chain "Test chain performance" financial_planning_expert_v2 enhanced_agent_fast_v2 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "   ✓ Chain Success (under 3 minutes)"
else
    echo "   ✗ Chain Failed or timeout"
fi

echo ""
echo "Performance monitoring complete."
