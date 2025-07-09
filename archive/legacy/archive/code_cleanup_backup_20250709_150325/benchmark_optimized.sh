#!/bin/bash
# Quick benchmark for optimized models

echo "🚀 Mirador Optimized Model Benchmark"
echo "===================================="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Test prompt
TEST_PROMPT="I have 2 hours free. Should I practice guitar or work on AI portfolio? Consider my 6-month goals."

echo "Test prompt: \"$TEST_PROMPT\""
echo ""

# Function to benchmark a model
benchmark_model() {
    local model=$1
    echo -e "${BLUE}Testing: $model${NC}"
    
    # Time the execution
    START=$(date +%s)
    
    # Run the model (capturing output but not displaying it all)
    OUTPUT=$(echo "$TEST_PROMPT" | timeout 60s ollama run "$model" 2>&1)
    EXIT_CODE=$?
    
    END=$(date +%s)
    DURATION=$((END - START))
    
    if [ $EXIT_CODE -eq 0 ]; then
        # Count words in output
        WORDS=$(echo "$OUTPUT" | wc -w)
        echo -e "${GREEN}✅ Success - Time: ${DURATION}s, Words: $WORDS${NC}"
    else
        echo -e "${RED}❌ Failed or timeout${NC}"
    fi
    echo ""
}

# Test original models
echo "📊 Baseline Models:"
echo "-------------------"
benchmark_model "matthew_advisor_enhanced"
benchmark_model "financial_planning_expert_v6"

# Test optimized models
echo "🔥 Optimized Models:"
echo "--------------------"
benchmark_model "optimized_decision_simplifier_v3"
benchmark_model "optimized_action_prioritizer"

# Summary
echo "💡 Performance Summary:"
echo "----------------------"
echo "• Optimized models should respond in 10-15 seconds"
echo "• Original models typically take 30-60 seconds"
echo "• Both should produce 200-1000 words of output"
echo ""
echo "Next steps:"
echo "1. Update mirador-smart to use optimized models"
echo "2. Test with real-world prompts from ENHANCED_PROMPT_LIBRARY.md"
echo "3. Monitor performance over 24-48 hours"