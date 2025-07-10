#!/bin/bash
# Test V3 streaming performance

QUERY="I want to build an AI-powered music composition tool that can generate chord progressions in the style of specific artists. I know Python and basic music theory. Where do I start and what libraries should I use?"

echo "=== Mirador V3 Streaming Test ==="
echo "Query: $QUERY"
echo ""

# Test 1: V3 Streaming (default)
echo "1. Testing V3 Streaming Mode:"
echo "----------------------------"
START=$(date +%s.%N)
./bin/mirador-stream "$QUERY" > v3_streaming_output.txt 2>&1
END=$(date +%s.%N)
V3_TIME=$(echo "$END - $START" | bc)
echo "Total time: ${V3_TIME}s"
echo "First token time: $(grep "First token:" v3_streaming_output.txt | tail -1)"
echo ""

# Test 2: V2 Mode (mirador-ez chain)
echo "2. Testing V2 Mode (traditional chain):"
echo "--------------------------------------"
START=$(date +%s.%N)
./bin/mirador-ez chain "$QUERY" matthew_context_provider_v6_complete:latest music_industry_networker master_guitar_instructor optimized_decision_simplifier_v3 > v2_output.txt 2>&1
END=$(date +%s.%N)
V2_TIME=$(echo "$END - $START" | bc)
echo "Total time: ${V2_TIME}s"
echo ""

# Test 3: Enhanced ez-stream
echo "3. Testing Enhanced EZ-Stream:"
echo "-----------------------------"
START=$(date +%s.%N)
./bin/mirador-ez-stream chain "$QUERY" matthew_context_provider_v6_complete:latest music_industry_networker master_guitar_instructor optimized_decision_simplifier_v3 > v3_ez_output.txt 2>&1
END=$(date +%s.%N)
V3_EZ_TIME=$(echo "$END - $START" | bc)
echo "Total time: ${V3_EZ_TIME}s"
echo "First token time: $(grep "First token:" v3_ez_output.txt | tail -1)"
echo ""

# Summary
echo "=== Performance Summary ==="
echo "V2 Traditional: ${V2_TIME}s"
echo "V3 Streaming: ${V3_TIME}s ($(grep "First token:" v3_streaming_output.txt | tail -1))"
echo "V3 EZ-Stream: ${V3_EZ_TIME}s ($(grep "First token:" v3_ez_output.txt | tail -1))"

# Calculate speedup
SPEEDUP=$(echo "scale=2; $V2_TIME / $V3_TIME" | bc)
echo ""
echo "V3 is ${SPEEDUP}x faster than V2"

# Check quality
echo ""
echo "=== Output Quality Check ==="
echo "V2 word count: $(wc -w < v2_output.txt)"
echo "V3 word count: $(wc -w < v3_streaming_output.txt)"
echo "V3 EZ word count: $(wc -w < v3_ez_output.txt)"

# Technical accuracy check
echo ""
echo "=== Technical Terms Found ==="
echo "V2 mentions:"
grep -i -E "(python|library|midi|tensorflow|pytorch|music21|RNN|LSTM|transformer)" v2_output.txt | head -5
echo ""
echo "V3 mentions:"
grep -i -E "(python|library|midi|tensorflow|pytorch|music21|RNN|LSTM|transformer)" v3_streaming_output.txt | head -5