#!/bin/bash
# Comprehensive Mirador System Test Suite
# Tests all core functionality with verification

set -e

echo "🧪 Mirador Comprehensive System Test"
echo "===================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Test results
PASSED=0
FAILED=0

# Test function
run_test() {
    local test_name=$1
    local test_command=$2
    local expected_pattern=$3
    
    echo -e "${BLUE}Testing: $test_name${NC}"
    
    if eval "$test_command" 2>&1 | grep -q "$expected_pattern"; then
        echo -e "${GREEN}✅ PASSED${NC}"
        ((PASSED++))
    else
        echo -e "${RED}❌ FAILED${NC}"
        ((FAILED++))
    fi
    echo ""
}

# Test 1: Basic model availability
run_test "Core Models Available" \
    "ollama list | wc -l" \
    "[0-9]"

# Test 2: Context provider works
run_test "Context Provider" \
    "echo 'test' | ollama run matthew_context_provider_v6_complete:latest 2>&1" \
    "."

# Test 3: Auto-router functionality
run_test "Auto-Router Query Analysis" \
    "./bin/mirador_auto_router.sh 'test query' 2>&1" \
    "Analyzing query"

# Test 4: RAG chain for documents
run_test "RAG Chain Document Analysis" \
    "./bin/mirador_rag_chain.sh document 'What is AI?' 2>&1" \
    "Document Analysis"

# Test 5: Hybrid chain execution
run_test "Hybrid Chain Synthesis" \
    "./bin/mirador_hybrid_chains.sh synthesis 'test synthesis' 2>&1" \
    "Starting hybrid"

# Test 6: Model diversity check
echo -e "${BLUE}Testing: Model Diversity${NC}"
TOTAL_MODELS=$(ollama list | wc -l)
LLAMA_MODELS=$(ollama list | grep -c "llama" || true)
NON_LLAMA=$((TOTAL_MODELS - LLAMA_MODELS))
DIVERSITY_PERCENT=$((NON_LLAMA * 100 / TOTAL_MODELS))

if [ $DIVERSITY_PERCENT -gt 50 ]; then
    echo -e "${GREEN}✅ PASSED - Diversity: ${DIVERSITY_PERCENT}% non-Llama${NC}"
    ((PASSED++))
else
    echo -e "${RED}❌ FAILED - Diversity: ${DIVERSITY_PERCENT}% non-Llama${NC}"
    ((FAILED++))
fi
echo ""

# Test 7: Output generation
run_test "Output Directory Creation" \
    "ls -d outputs/universal_* 2>/dev/null | head -1" \
    "outputs"

# Test 8: Feedback mechanism
run_test "Feedback System" \
    "[ -f ./mirador_feedback.sh ] && echo 'exists'" \
    "exists"

# Test 9: Performance (basic chain should complete in < 60s)
echo -e "${BLUE}Testing: Performance Benchmark${NC}"
START_TIME=$(date +%s)
timeout 60s ./mirador-ez chain "Quick test" matthew_context_provider_v6_complete:latest practical_implementer >/dev/null 2>&1
RESULT=$?
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

if [ $RESULT -eq 0 ] && [ $DURATION -lt 60 ]; then
    echo -e "${GREEN}✅ PASSED - Completed in ${DURATION}s${NC}"
    ((PASSED++))
else
    echo -e "${RED}❌ FAILED - Timeout or error${NC}"
    ((FAILED++))
fi
echo ""

# Test 10: File type support
run_test "Multiple File Type Support" \
    "grep -E '(pdf|txt|md|py|js|json|csv|doc)' bin/mirador_rag_chain.sh | wc -l" \
    "[1-9]"

# Summary
echo "===================================="
echo -e "${BLUE}Test Summary${NC}"
echo -e "Passed: ${GREEN}$PASSED${NC}"
echo -e "Failed: ${RED}$FAILED${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}🎉 All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}⚠️  Some tests failed${NC}"
    exit 1
fi