#!/bin/bash

echo "============================================="
echo "MIRADOR TEST SUITE RESULTS ANALYZER"
echo "Generated: $(date)"
echo "============================================="
echo ""

# Find the most recent test log
TEST_LOG=$(ls -t ~/ai_framework_git/test_suite_*.log | head -1)

if [ -z "$TEST_LOG" ]; then
    echo "❌ No test suite log found!"
    exit 1
fi

echo "📋 Analyzing log: $(basename $TEST_LOG)"
echo ""

# Extract key metrics
echo "📊 TEST EXECUTION METRICS:"
echo "=========================="
TOTAL_TESTS=$(grep -c "EXECUTING:" "$TEST_LOG" 2>/dev/null || echo "0")
COMPLETED_TESTS=$(grep -c "✅ Completed at" "$TEST_LOG" 2>/dev/null || echo "0")
CATEGORIES=$(grep "CATEGORY:" "$TEST_LOG" | awk -F': ' '{print $2}' | sort | uniq -c)

echo "Total tests executed: $TOTAL_TESTS"
echo "Successfully completed: $COMPLETED_TESTS"
echo "Success rate: $(( $COMPLETED_TESTS * 100 / $TOTAL_TESTS ))%"
echo ""

echo "📂 TESTS BY CATEGORY:"
echo "===================="
echo "$CATEGORIES"
echo ""

# Extract execution times
echo "⏱️ EXECUTION TIME ANALYSIS:"
echo "=========================="
START_TIME=$(grep "Started:" "$TEST_LOG" | awk -F': ' '{print $2}')
END_TIME=$(grep "Finished:" "$TEST_LOG" | awk -F': ' '{print $2}')
echo "Started: $START_TIME"
echo "Finished: $END_TIME"

# Calculate duration if possible
if command -v gdate &> /dev/null; then
    DURATION=$(gdate -d "$END_TIME" +%s 2>/dev/null || echo "0")
    START_SEC=$(gdate -d "$START_TIME" +%s 2>/dev/null || echo "0")
    if [ "$DURATION" -ne "0" ] && [ "$START_SEC" -ne "0" ]; then
        TOTAL_SEC=$((DURATION - START_SEC))
        echo "Total duration: $((TOTAL_SEC / 60)) minutes $((TOTAL_SEC % 60)) seconds"
    fi
fi

echo ""
echo "🎯 TEST TOPICS COVERED:"
echo "====================="
grep "TEST:" "$TEST_LOG" | sed 's/.*TEST: /- /' | head -20

echo ""
echo "📈 OUTPUT GENERATION ANALYSIS:"
echo "============================"
# Count new outputs created during test period
OUTPUTS_DIR="$HOME/ai_framework_git/outputs"
if [ -d "$OUTPUTS_DIR" ]; then
    # Find directories created in the last 4 hours
    NEW_OUTPUTS=$(find "$OUTPUTS_DIR" -type d -name "chain_*" -mmin -240 2>/dev/null | wc -l)
    echo "New chain outputs created: $NEW_OUTPUTS"
    
    # Sample recent outputs
    echo ""
    echo "Recent output samples:"
    find "$OUTPUTS_DIR" -type d -name "chain_*" -mmin -240 2>/dev/null | tail -5 | while read dir; do
        echo "  - $(basename $dir)"
    done
fi

echo ""
echo "============================================="
