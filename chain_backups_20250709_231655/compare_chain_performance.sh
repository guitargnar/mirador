#!/bin/bash
# Compare performance between old and new chains

echo "📊 Comparing Chain Performance"
echo "============================="
echo ""

TEST_PROMPT="How can I balance immediate work priorities with long-term career growth?"

echo "Test prompt: $TEST_PROMPT"
echo ""

# Test old chain
echo "1. Testing OLD chain (v2)..."
START_TIME=$(date +%s)
./bin/mirador_universal_runner_v2.sh life_optimization "$TEST_PROMPT" quick > /tmp/old_output.txt 2>&1
END_TIME=$(date +%s)
OLD_DURATION=$((END_TIME - START_TIME))

echo "   Duration: ${OLD_DURATION}s"
echo "   Output size: $(wc -l < /tmp/old_output.txt) lines"
echo ""

# Test new chain
echo "2. Testing NEW chain (v3 optimized)..."
START_TIME=$(date +%s)
./bin/mirador_universal_runner_v3_optimized.sh life_optimization "$TEST_PROMPT" quick > /tmp/new_output.txt 2>&1
END_TIME=$(date +%s)
NEW_DURATION=$((END_TIME - START_TIME))

echo "   Duration: ${NEW_DURATION}s"
echo "   Output size: $(wc -l < /tmp/new_output.txt) lines"
echo ""

# Test diverse chain
echo "3. Testing DIVERSE chain (deep_analysis)..."
START_TIME=$(date +%s)
./bin/mirador_universal_runner_v3_optimized.sh deep_analysis "$TEST_PROMPT" quick > /tmp/diverse_output.txt 2>&1
END_TIME=$(date +%s)
DIVERSE_DURATION=$((END_TIME - START_TIME))

echo "   Duration: ${DIVERSE_DURATION}s"
echo "   Output size: $(wc -l < /tmp/diverse_output.txt) lines"
echo ""

# Summary
echo "Summary:"
echo "--------"
echo "Old chain (v2): ${OLD_DURATION}s"
echo "New chain (v3): ${NEW_DURATION}s"
echo "Diverse chain: ${DIVERSE_DURATION}s"

if [ $NEW_DURATION -lt $OLD_DURATION ]; then
    IMPROVEMENT=$((100 * (OLD_DURATION - NEW_DURATION) / OLD_DURATION))
    echo ""
    echo "✅ New chain is ${IMPROVEMENT}% faster!"
else
    echo ""
    echo "⚠️  New chain is slower - may need optimization"
fi

echo ""
echo "Output samples:"
echo ""
echo "OLD chain first 5 lines:"
head -5 /tmp/old_output.txt
echo ""
echo "NEW chain first 5 lines:"
head -5 /tmp/new_output.txt
echo ""
echo "DIVERSE chain first 5 lines:"
head -5 /tmp/diverse_output.txt
