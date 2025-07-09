#!/bin/bash
# Consolidation Validation Script

echo "==================================="
echo "MIRADOR CONSOLIDATION VALIDATION"
echo "==================================="
echo "Date: $(date)"
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Function to run test
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    echo -n "Testing $test_name... "
    if eval "$test_command" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ PASSED${NC}"
        ((TESTS_PASSED++))
        return 0
    else
        echo -e "${RED}✗ FAILED${NC}"
        ((TESTS_FAILED++))
        return 1
    fi
}

echo "1. SYSTEM INTEGRITY CHECKS"
echo "--------------------------"

# Check git branch
run_test "Git branch" "[[ $(git branch --show-current) == 'feature/portfolio-consolidation' ]]"

# Check backups exist
run_test "Backups exist" "ls ~/mirador_consolidation_backup_20250709/*.tar.gz | wc -l | grep -q 3"

# Check core scripts are executable
run_test "mirador-smart-v2 executable" "test -x mirador-smart-v2"
run_test "mirador_universal_runner_v2 executable" "test -x mirador_universal_runner_v2.sh"

echo ""
echo "2. CORE FUNCTIONALITY TESTS"
echo "---------------------------"

# Test model availability
run_test "Models available" "ollama list | grep -q matthew_context"

# Test Python imports
run_test "Context manager" "python3 -c 'import context_manager'"
run_test "Constraint validator" "python3 -c 'import constraint_validator'"

# Test new imports
run_test "Model extractor" "test -f ollama_model_extractor.py"
run_test "Enhanced analyzer" "test -f enhanced_model_analyzer.py"

echo ""
echo "3. LIBRARY STRUCTURE TESTS"
echo "--------------------------"

# Check new core library structure
run_test "Core library exists" "test -d mirador-core"
run_test "Error handling module" "test -f mirador-core/core/error_handling/error_handler.py"
run_test "Setup.py exists" "test -f mirador-core/setup.py"

echo ""
echo "4. DEDUPLICATION TESTS"
echo "----------------------"

# Check deduplication files
run_test "Deduplication strategy" "test -f DEDUPLICATION_STRATEGY.md"
run_test "Remove duplicates script" "test -f remove_duplicates.sh"
run_test "Chain consolidator" "test -f consolidate_chain_results.py"

echo ""
echo "5. DOCUMENTATION TESTS"
echo "---------------------"

# Check documentation
run_test "Consolidation plan" "test -f PORTFOLIO_CONSOLIDATION_PLAN.md"
run_test "Work inventory" "test -f COMPLETE_WORK_INVENTORY.md"
run_test "Test plan" "test -f CONSOLIDATION_TEST_PLAN.md"

echo ""
echo "6. QUICK FUNCTIONALITY TEST"
echo "---------------------------"

# Run a quick chain test
echo "Running quick chain test..."
if timeout 30 ./mirador-smart-v2 "Quick test" 2>&1 | grep -q "Chain Progress Visualization"; then
    echo -e "${GREEN}✓ Chain execution working${NC}"
    ((TESTS_PASSED++))
else
    echo -e "${RED}✗ Chain execution failed${NC}"
    ((TESTS_FAILED++))
fi

echo ""
echo "==================================="
echo "VALIDATION SUMMARY"
echo "==================================="
echo -e "Tests Passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Tests Failed: ${RED}$TESTS_FAILED${NC}"
echo ""

if [[ $TESTS_FAILED -eq 0 ]]; then
    echo -e "${GREEN}✓ ALL TESTS PASSED - Safe to proceed with consolidation${NC}"
    exit 0
else
    echo -e "${RED}✗ VALIDATION FAILED - Review failures before proceeding${NC}"
    exit 1
fi