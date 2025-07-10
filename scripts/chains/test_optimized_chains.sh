#!/bin/bash
# Test optimized model chains
# Validates performance improvements

set -e

echo "🧪 Mirador Optimized Chain Testing"
echo "=================================="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Test directory
TEST_DIR="optimization_tests"
mkdir -p "$TEST_DIR"

# Function to test a chain
test_chain() {
    local chain_name=$1
    shift
    local models=("$@")
    
    echo -e "${BLUE}Testing chain: ${chain_name}${NC}"
    echo "Models: ${models[*]}"
    
    # Start timer
    START_TIME=$(date +%s)
    
    # Run the chain
    OUTPUT_FILE="${TEST_DIR}/${chain_name}_$(date +%Y%m%d_%H%M%S).txt"
    
    if timeout 120s ./mirador-ez chain "Test optimization performance" "${models[@]}" > "$OUTPUT_FILE" 2>&1; then
        END_TIME=$(date +%s)
        DURATION=$((END_TIME - START_TIME))
        
        # Check output quality
        WORD_COUNT=$(wc -w < "$OUTPUT_FILE")
        
        echo -e "${GREEN}✅ Success - Duration: ${DURATION}s, Words: ${WORD_COUNT}${NC}"
        
        # Save metrics
        echo "{\"chain\": \"${chain_name}\", \"duration\": ${DURATION}, \"words\": ${WORD_COUNT}, \"status\": \"success\"}" >> "${TEST_DIR}/metrics.jsonl"
    else
        echo -e "${RED}❌ Failed or timeout${NC}"
        echo "{\"chain\": \"${chain_name}\", \"duration\": 120, \"words\": 0, \"status\": \"failed\"}" >> "${TEST_DIR}/metrics.jsonl"
    fi
    
    echo ""
}

# Clear previous metrics
> "${TEST_DIR}/metrics.jsonl"

echo "🔄 Running baseline tests with original models..."
echo ""

# Test original chains
test_chain "baseline_financial" \
    "matthew_context_provider_v5_complete:latest" \
    "financial_planning_expert_v6" \
    "enhanced_agent_enforcer"

test_chain "baseline_decision" \
    "matthew_advisor_enhanced" \
    "cross_model_synthesizer"

echo "🚀 Running tests with optimized models..."
echo ""

# Test optimized chains (if models exist)
if ollama list | grep -q "optimized_decision_simplifier_v3"; then
    test_chain "optimized_financial" \
        "matthew_context_provider_v5_complete:latest" \
        "financial_planning_expert_v6" \
        "optimized_decision_simplifier_v3"
else
    echo -e "${YELLOW}⚠️  Optimized models not found. Run ./optimize_models.sh first${NC}"
fi

if ollama list | grep -q "optimized_action_prioritizer"; then
    test_chain "optimized_action" \
        "matthew_advisor_enhanced" \
        "optimized_action_prioritizer"
fi

# Analyze results
echo ""
echo "📊 Performance Analysis"
echo "====================="
echo ""

if [ -f "${TEST_DIR}/metrics.jsonl" ]; then
    # Calculate averages
    echo "Chain Performance Summary:"
    echo ""
    
    # Parse metrics (simple bash approach)
    while IFS= read -r line; do
        chain=$(echo "$line" | grep -o '"chain": "[^"]*"' | cut -d'"' -f4)
        duration=$(echo "$line" | grep -o '"duration": [0-9]*' | cut -d' ' -f2)
        words=$(echo "$line" | grep -o '"words": [0-9]*' | cut -d' ' -f2)
        status=$(echo "$line" | grep -o '"status": "[^"]*"' | cut -d'"' -f4)
        
        printf "%-25s %10s %10s %10s\n" "$chain" "${duration}s" "${words} words" "$status"
    done < "${TEST_DIR}/metrics.jsonl"
    
    echo ""
    echo "Detailed results saved in: ${TEST_DIR}/"
else
    echo -e "${RED}No metrics found${NC}"
fi

# Recommendations
echo ""
echo "💡 Optimization Recommendations"
echo "=============================="
echo ""

# Check if optimized models exist
if ollama list | grep -q "optimized_"; then
    echo "✅ Optimized models detected"
    echo ""
    echo "To use optimized models in production:"
    echo "1. Update mirador-smart chain configurations"
    echo "2. Replace model references in daily scripts"
    echo "3. Monitor performance over next 24-48 hours"
else
    echo "❌ No optimized models found"
    echo ""
    echo "Next steps:"
    echo "1. Run ./optimize_models.sh to create optimized models"
    echo "2. Re-run this test script"
    echo "3. Compare baseline vs optimized performance"
fi

echo ""
echo "📈 Target Metrics:"
echo "- Chain execution: < 45 seconds"
echo "- Output quality: 600-1000 words"
echo "- Success rate: > 99%"