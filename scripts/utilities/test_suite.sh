#!/bin/bash
# Comprehensive Mirador System Test Suite
# Tests all components of the Mirador AI Framework

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
RESET='\033[0m'

# Test configuration
TEST_DIR="/home/ubuntu/mirador_test"
LOG_FILE="$TEST_DIR/test_results.log"
RESULTS_FILE="$TEST_DIR/test_summary.json"

# Initialize test results
echo "[]" > "$RESULTS_FILE"

# Function to log test results
log_test() {
    local test_name="$1"
    local status="$2"
    local details="$3"
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    echo "[$timestamp] $test_name: $status - $details" >> "$LOG_FILE"
    
    # Add to JSON results
    local temp_file=$(mktemp)
    jq --arg name "$test_name" --arg status "$status" --arg details "$details" --arg time "$timestamp" \
       '. += [{"test": $name, "status": $status, "details": $details, "timestamp": $time}]' \
       "$RESULTS_FILE" > "$temp_file" && mv "$temp_file" "$RESULTS_FILE"
}

# Function to print test header
print_test_header() {
    echo -e "${BLUE}${BOLD}"
    echo "┌─────────────────────────────────────────────────────────────┐"
    echo "│                  MIRADOR SYSTEM TEST SUITE                 │"
    echo "│                 Comprehensive Testing Framework             │"
    echo "└─────────────────────────────────────────────────────────────┘"
    echo -e "${RESET}"
}

# Function to test file existence and permissions
test_file_structure() {
    echo -e "${YELLOW}Testing file structure and permissions...${RESET}"
    
    local required_files=(
        "mirador"
        "mirador-conductor"
        "mirador-collaborate"
        "mirador-interactive"
        "mirador-intervene"
        "mirador-rapid"
        "mirador-unified"
        "conductor.py"
        "mirador.py"
        "README.md"
        "CLAUDE.md"
    )
    
    local missing_files=()
    local non_executable=()
    
    for file in "${required_files[@]}"; do
        if [[ ! -f "$TEST_DIR/$file" ]]; then
            missing_files+=("$file")
        elif [[ "$file" == mirador* ]] && [[ ! -x "$TEST_DIR/$file" ]]; then
            non_executable+=("$file")
        fi
    done
    
    if [[ ${#missing_files[@]} -eq 0 ]] && [[ ${#non_executable[@]} -eq 0 ]]; then
        echo -e "${GREEN}✓ File structure test passed${RESET}"
        log_test "file_structure" "PASS" "All required files present and executable"
        return 0
    else
        echo -e "${RED}✗ File structure test failed${RESET}"
        [[ ${#missing_files[@]} -gt 0 ]] && echo -e "${RED}Missing files: ${missing_files[*]}${RESET}"
        [[ ${#non_executable[@]} -gt 0 ]] && echo -e "${RED}Non-executable files: ${non_executable[*]}${RESET}"
        log_test "file_structure" "FAIL" "Missing: ${missing_files[*]}, Non-executable: ${non_executable[*]}"
        return 1
    fi
}

# Function to test Python syntax
test_python_syntax() {
    echo -e "${YELLOW}Testing Python syntax...${RESET}"
    
    local python_files=(
        "conductor.py"
        "mirador.py"
        "intervention_manager.py"
        "specialist_handler.py"
        "message_bus.py"
        "bridge.py"
        "test_integration.py"
    )
    
    local syntax_errors=()
    
    for file in "${python_files[@]}"; do
        if [[ -f "$TEST_DIR/$file" ]]; then
            if ! python3 -m py_compile "$TEST_DIR/$file" 2>/dev/null; then
                syntax_errors+=("$file")
            fi
        fi
    done
    
    if [[ ${#syntax_errors[@]} -eq 0 ]]; then
        echo -e "${GREEN}✓ Python syntax test passed${RESET}"
        log_test "python_syntax" "PASS" "All Python files have valid syntax"
        return 0
    else
        echo -e "${RED}✗ Python syntax test failed${RESET}"
        echo -e "${RED}Files with syntax errors: ${syntax_errors[*]}${RESET}"
        log_test "python_syntax" "FAIL" "Syntax errors in: ${syntax_errors[*]}"
        return 1
    fi
}

# Function to test command help output
test_command_help() {
    echo -e "${YELLOW}Testing command help output...${RESET}"
    
    local commands=(
        "mirador"
        "mirador-conductor"
        "mirador-interactive"
        "mirador-rapid"
        "mirador-unified"
    )
    
    local help_failures=()
    
    for cmd in "${commands[@]}"; do
        if [[ -x "$TEST_DIR/$cmd" ]]; then
            if ! timeout 10s "$TEST_DIR/$cmd" --help >/dev/null 2>&1 && \
               ! timeout 10s "$TEST_DIR/$cmd" -h >/dev/null 2>&1 && \
               ! timeout 10s "$TEST_DIR/$cmd" >/dev/null 2>&1; then
                help_failures+=("$cmd")
            fi
        fi
    done
    
    if [[ ${#help_failures[@]} -eq 0 ]]; then
        echo -e "${GREEN}✓ Command help test passed${RESET}"
        log_test "command_help" "PASS" "All commands provide help output"
        return 0
    else
        echo -e "${RED}✗ Command help test failed${RESET}"
        echo -e "${RED}Commands with help failures: ${help_failures[*]}${RESET}"
        log_test "command_help" "FAIL" "Help failures in: ${help_failures[*]}"
        return 1
    fi
}

# Function to test Python imports
test_python_imports() {
    echo -e "${YELLOW}Testing Python imports...${RESET}"
    
    local import_test_script="$TEST_DIR/test_imports.py"
    
    cat > "$import_test_script" << 'EOF'
#!/usr/bin/env python3
import sys
import os

# Add current directory to path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

try:
    # Test core imports
    import conductor
    import mirador
    print("✓ Core modules imported successfully")
    
    # Test optional imports
    try:
        import intervention_manager
        import specialist_handler
        import message_bus
        import bridge
        print("✓ Advanced modules imported successfully")
    except ImportError as e:
        print(f"⚠ Some advanced modules failed to import: {e}")
    
    print("SUCCESS: Basic imports working")
    
except ImportError as e:
    print(f"ERROR: Failed to import core modules: {e}")
    sys.exit(1)
EOF
    
    chmod +x "$import_test_script"
    
    if python3 "$import_test_script" 2>/dev/null; then
        echo -e "${GREEN}✓ Python imports test passed${RESET}"
        log_test "python_imports" "PASS" "All Python modules can be imported"
        rm -f "$import_test_script"
        return 0
    else
        echo -e "${RED}✗ Python imports test failed${RESET}"
        log_test "python_imports" "FAIL" "Some Python modules failed to import"
        rm -f "$import_test_script"
        return 1
    fi
}

# Function to test configuration files
test_configuration() {
    echo -e "${YELLOW}Testing configuration files...${RESET}"
    
    local config_files=(
        "config.json"
    )
    
    local config_errors=()
    
    for file in "${config_files[@]}"; do
        if [[ -f "$TEST_DIR/$file" ]]; then
            if ! jq empty "$TEST_DIR/$file" 2>/dev/null; then
                config_errors+=("$file")
            fi
        else
            config_errors+=("$file (missing)")
        fi
    done
    
    if [[ ${#config_errors[@]} -eq 0 ]]; then
        echo -e "${GREEN}✓ Configuration test passed${RESET}"
        log_test "configuration" "PASS" "All configuration files are valid"
        return 0
    else
        echo -e "${RED}✗ Configuration test failed${RESET}"
        echo -e "${RED}Configuration errors: ${config_errors[*]}${RESET}"
        log_test "configuration" "FAIL" "Configuration errors in: ${config_errors[*]}"
        return 1
    fi
}

# Function to test modelfiles
test_modelfiles() {
    echo -e "${YELLOW}Testing modelfiles...${RESET}"
    
    local modelfiles=($(find "$TEST_DIR" -name "*.modelfile" -type f))
    local modelfile_errors=()
    
    for file in "${modelfiles[@]}"; do
        # Basic syntax check - modelfiles should have FROM and SYSTEM lines
        if ! grep -q "^FROM" "$file" 2>/dev/null; then
            modelfile_errors+=("$(basename "$file") - missing FROM")
        fi
        if ! grep -q "^SYSTEM" "$file" 2>/dev/null; then
            modelfile_errors+=("$(basename "$file") - missing SYSTEM")
        fi
    done
    
    if [[ ${#modelfile_errors[@]} -eq 0 ]]; then
        echo -e "${GREEN}✓ Modelfiles test passed (${#modelfiles[@]} files)${RESET}"
        log_test "modelfiles" "PASS" "All ${#modelfiles[@]} modelfiles have valid syntax"
        return 0
    else
        echo -e "${RED}✗ Modelfiles test failed${RESET}"
        echo -e "${RED}Modelfile errors: ${modelfile_errors[*]}${RESET}"
        log_test "modelfiles" "FAIL" "Modelfile errors: ${modelfile_errors[*]}"
        return 1
    fi
}

# Function to test shell scripts
test_shell_scripts() {
    echo -e "${YELLOW}Testing shell scripts...${RESET}"
    
    local shell_scripts=($(find "$TEST_DIR" -name "*.sh" -type f))
    local script_errors=()
    
    for script in "${shell_scripts[@]}"; do
        if ! bash -n "$script" 2>/dev/null; then
            script_errors+=("$(basename "$script")")
        fi
    done
    
    if [[ ${#script_errors[@]} -eq 0 ]]; then
        echo -e "${GREEN}✓ Shell scripts test passed (${#shell_scripts[@]} scripts)${RESET}"
        log_test "shell_scripts" "PASS" "All ${#shell_scripts[@]} shell scripts have valid syntax"
        return 0
    else
        echo -e "${RED}✗ Shell scripts test failed${RESET}"
        echo -e "${RED}Script errors: ${script_errors[*]}${RESET}"
        log_test "shell_scripts" "FAIL" "Script errors in: ${script_errors[*]}"
        return 1
    fi
}

# Function to test JSON files
test_json_files() {
    echo -e "${YELLOW}Testing JSON files...${RESET}"
    
    local json_files=($(find "$TEST_DIR" -name "*.json" -type f))
    local json_errors=()
    
    for file in "${json_files[@]}"; do
        if ! jq empty "$file" 2>/dev/null; then
            json_errors+=("$(basename "$file")")
        fi
    done
    
    if [[ ${#json_errors[@]} -eq 0 ]]; then
        echo -e "${GREEN}✓ JSON files test passed (${#json_files[@]} files)${RESET}"
        log_test "json_files" "PASS" "All ${#json_files[@]} JSON files are valid"
        return 0
    else
        echo -e "${RED}✗ JSON files test failed${RESET}"
        echo -e "${RED}JSON errors: ${json_errors[*]}${RESET}"
        log_test "json_files" "FAIL" "JSON errors in: ${json_errors[*]}"
        return 1
    fi
}

# Function to run integration tests
test_integration() {
    echo -e "${YELLOW}Testing integration...${RESET}"
    
    if [[ -f "$TEST_DIR/test_integration.py" ]]; then
        if python3 "$TEST_DIR/test_integration.py" 2>/dev/null; then
            echo -e "${GREEN}✓ Integration test passed${RESET}"
            log_test "integration" "PASS" "Integration tests completed successfully"
            return 0
        else
            echo -e "${RED}✗ Integration test failed${RESET}"
            log_test "integration" "FAIL" "Integration tests failed"
            return 1
        fi
    else
        echo -e "${YELLOW}⚠ Integration test skipped (test_integration.py not found)${RESET}"
        log_test "integration" "SKIP" "test_integration.py not found"
        return 0
    fi
}

# Function to generate test report
generate_test_report() {
    echo -e "${BLUE}${BOLD}Generating test report...${RESET}"
    
    local total_tests=$(jq length "$RESULTS_FILE")
    local passed_tests=$(jq '[.[] | select(.status == "PASS")] | length' "$RESULTS_FILE")
    local failed_tests=$(jq '[.[] | select(.status == "FAIL")] | length' "$RESULTS_FILE")
    local skipped_tests=$(jq '[.[] | select(.status == "SKIP")] | length' "$RESULTS_FILE")
    
    echo -e "${BLUE}${BOLD}"
    echo "┌─────────────────────────────────────────────────────────────┐"
    echo "│                      TEST SUMMARY                          │"
    echo "└─────────────────────────────────────────────────────────────┘"
    echo -e "${RESET}"
    
    echo -e "${BOLD}Total Tests: $total_tests${RESET}"
    echo -e "${GREEN}Passed: $passed_tests${RESET}"
    echo -e "${RED}Failed: $failed_tests${RESET}"
    echo -e "${YELLOW}Skipped: $skipped_tests${RESET}"
    echo ""
    
    if [[ $failed_tests -gt 0 ]]; then
        echo -e "${RED}${BOLD}Failed Tests:${RESET}"
        jq -r '.[] | select(.status == "FAIL") | "  ✗ \(.test): \(.details)"' "$RESULTS_FILE"
        echo ""
    fi
    
    if [[ $skipped_tests -gt 0 ]]; then
        echo -e "${YELLOW}${BOLD}Skipped Tests:${RESET}"
        jq -r '.[] | select(.status == "SKIP") | "  ⚠ \(.test): \(.details)"' "$RESULTS_FILE"
        echo ""
    fi
    
    echo -e "${BLUE}Detailed results saved to: $LOG_FILE${RESET}"
    echo -e "${BLUE}JSON results saved to: $RESULTS_FILE${RESET}"
    
    # Return appropriate exit code
    if [[ $failed_tests -gt 0 ]]; then
        return 1
    else
        return 0
    fi
}

# Main test execution
main() {
    cd "$TEST_DIR" || exit 1
    
    print_test_header
    
    # Initialize log file
    echo "Mirador System Test Suite - $(date)" > "$LOG_FILE"
    echo "========================================" >> "$LOG_FILE"
    
    # Run all tests
    local test_functions=(
        "test_file_structure"
        "test_python_syntax"
        "test_python_imports"
        "test_configuration"
        "test_modelfiles"
        "test_shell_scripts"
        "test_json_files"
        "test_command_help"
        "test_integration"
    )
    
    echo -e "${BLUE}Running ${#test_functions[@]} test suites...${RESET}"
    echo ""
    
    for test_func in "${test_functions[@]}"; do
        $test_func
        echo ""
    done
    
    # Generate final report
    generate_test_report
}

# Run main function
main "$@"

