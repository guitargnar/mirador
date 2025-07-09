#!/bin/bash
#############################################################################
# Mirador AI Framework - Master Test Runner
# Execute this script in a separate terminal to run all tests
#############################################################################

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Create test logs directory
mkdir -p "$PROJECT_ROOT/test_logs"

# Function to print colored output
print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Function to check prerequisites
check_prerequisites() {
    print_header "Checking Prerequisites"
    
    # Check Python 3
    if command -v python3 &> /dev/null; then
        PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
        print_success "Python 3 installed: $PYTHON_VERSION"
    else
        print_error "Python 3 is not installed"
        exit 1
    fi
    
    # Check Ollama
    if command -v ollama &> /dev/null; then
        if ollama list &> /dev/null; then
            print_success "Ollama is running"
        else
            print_warning "Ollama is installed but not running. Start with: ollama serve"
        fi
    else
        print_error "Ollama is not installed"
    fi
    
    # Check psutil
    if python3 -c "import psutil" 2>/dev/null; then
        print_success "psutil module installed"
    else
        print_warning "psutil not installed. Installing..."
        pip3 install psutil
    fi
}

# Function to run a test with timeout
run_test() {
    local test_name=$1
    local test_command=$2
    local timeout=${3:-300}  # Default 5 minutes
    
    echo -e "\n${BLUE}Running: $test_name${NC}"
    echo "Command: $test_command"
    echo "Timeout: ${timeout}s"
    echo "----------------------------------------"
    
    # Run the test with timeout
    timeout $timeout bash -c "$test_command"
    local exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        print_success "$test_name completed successfully"
    elif [ $exit_code -eq 124 ]; then
        print_error "$test_name timed out after ${timeout}s"
    else
        print_error "$test_name failed with exit code $exit_code"
    fi
    
    return $exit_code
}

# Main test execution
main() {
    clear
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════╗"
    echo "║   MIRADOR AI FRAMEWORK TEST SUITE      ║"
    echo "║   Comprehensive System Testing         ║"
    echo "╚════════════════════════════════════════╝"
    echo -e "${NC}"
    
    echo "Project Root: $PROJECT_ROOT"
    echo "Test Logs: $PROJECT_ROOT/test_logs"
    echo "Start Time: $(date)"
    
    # Check prerequisites
    check_prerequisites
    
    # Get test mode from user
    echo -e "\n${YELLOW}Select test mode:${NC}"
    echo "1) Quick tests (5 minutes)"
    echo "2) Standard tests (15 minutes)"
    echo "3) Comprehensive tests (30+ minutes)"
    echo "4) Custom selection"
    read -p "Enter choice (1-4): " TEST_MODE
    
    case $TEST_MODE in
        1)
            print_header "Running Quick Tests"
            run_test "System Test" "cd '$PROJECT_ROOT' && python3 tests/mirador_test_suite.py --fail-fast" 300
            ;;
        2)
            print_header "Running Standard Tests"
            run_test "System Test" "cd '$PROJECT_ROOT' && python3 tests/mirador_test_suite.py" 300
            run_test "Chain Tests" "cd '$PROJECT_ROOT' && python3 tests/test_chains.py" 600
            ;;
        3)
            print_header "Running Comprehensive Tests"
            run_test "System Test" "cd '$PROJECT_ROOT' && python3 tests/mirador_test_suite.py" 300
            run_test "Chain Tests" "cd '$PROJECT_ROOT' && python3 tests/test_chains.py" 600
            run_test "Model Tests" "cd '$PROJECT_ROOT' && python3 tests/test_models.py" 600
            run_test "Performance Tests" "cd '$PROJECT_ROOT' && python3 tests/test_performance.py" 600
            ;;
        4)
            print_header "Custom Test Selection"
            echo "Available tests:"
            echo "a) System tests (imports, configs, basic functionality)"
            echo "b) Chain tests (all chain runners)"
            echo "c) Model tests (Ollama model availability)"
            echo "d) Performance tests (speed, memory, concurrency)"
            read -p "Enter tests to run (e.g., 'abc'): " CUSTOM_TESTS
            
            if [[ $CUSTOM_TESTS == *"a"* ]]; then
                run_test "System Test" "cd '$PROJECT_ROOT' && python3 tests/mirador_test_suite.py" 300
            fi
            if [[ $CUSTOM_TESTS == *"b"* ]]; then
                run_test "Chain Tests" "cd '$PROJECT_ROOT' && python3 tests/test_chains.py" 600
            fi
            if [[ $CUSTOM_TESTS == *"c"* ]]; then
                run_test "Model Tests" "cd '$PROJECT_ROOT' && python3 tests/test_models.py" 600
            fi
            if [[ $CUSTOM_TESTS == *"d"* ]]; then
                run_test "Performance Tests" "cd '$PROJECT_ROOT' && python3 tests/test_performance.py" 600
            fi
            ;;
        *)
            print_error "Invalid choice"
            exit 1
            ;;
    esac
    
    # Generate summary
    print_header "Test Summary"
    echo "End Time: $(date)"
    echo -e "\n${YELLOW}Test logs available in: $PROJECT_ROOT/test_logs${NC}"
    
    # Show latest test reports
    echo -e "\n${BLUE}Latest test reports:${NC}"
    ls -lt "$PROJECT_ROOT/test_logs"/*.txt 2>/dev/null | head -5 | awk '{print "  " $9}'
    ls -lt "$PROJECT_ROOT/test_logs"/*.json 2>/dev/null | head -5 | awk '{print "  " $9}'
}

# Run main function
main