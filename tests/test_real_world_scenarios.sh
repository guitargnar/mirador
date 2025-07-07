#!/bin/bash
#############################################################################
# Mirador Real-World Scenario Test Runner
# Tests practical use cases with actual executable commands
#############################################################################

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Project root
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Test configuration
TEST_MODE="${1:-basic}"  # basic, strategic, or full
TIMEOUT="${2:-60}"       # Timeout in seconds per test

# Create test results directory
RESULTS_DIR="$PROJECT_ROOT/test_logs/scenario_tests_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$RESULTS_DIR"

# Function to print headers
print_header() {
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

# Function to test a scenario
test_scenario() {
    local scenario_name="$1"
    local chain_type="$2"
    local prompt="$3"
    local test_id="$4"
    
    echo -e "${BLUE}🧪 Testing Scenario: ${scenario_name}${NC}"
    echo "Chain Type: $chain_type"
    echo "Test ID: $test_id"
    echo -e "${YELLOW}Prompt Preview:${NC} ${prompt:0:100}..."
    
    # Create individual test log
    local log_file="$RESULTS_DIR/test_${test_id}_${chain_type}.log"
    
    # Execute the command with timeout
    echo -e "\n${GREEN}Executing...${NC}"
    local start_time=$(date +%s)
    
    if timeout $TIMEOUT bash -c "cd '$PROJECT_ROOT' && ./humana_chain_runner.sh $chain_type '$prompt' > '$log_file' 2>&1"; then
        local end_time=$(date +%s)
        local duration=$((end_time - start_time))
        echo -e "${GREEN}✅ Success${NC} (${duration}s)"
        
        # Show first few lines of output
        echo -e "\n${CYAN}Output Preview:${NC}"
        head -n 10 "$log_file" | sed 's/^/  /'
        echo "  ..."
        echo -e "  ${YELLOW}Full output in: $log_file${NC}"
    else
        echo -e "${RED}❌ Failed or timed out${NC}"
        echo -e "${RED}Check log: $log_file${NC}"
    fi
    
    echo -e "\n${CYAN}────────────────────────────────────────────────────────${NC}\n"
}

# Function to run basic scenarios
run_basic_scenarios() {
    print_header "🎯 BASIC DAILY OPERATION SCENARIOS"
    
    # Scenario 1: Morning Planning
    test_scenario \
        "Morning Strategic Planning" \
        "strategic_synthesis" \
        "Today is $(date '+%A, %B %d, %Y'). My calendar shows: 9am team meeting, 2pm Advocates meeting. My top 3 priorities are: 1) Complete automation project, 2) Build innovation support, 3) Enhance visibility. What are the 3 highest-leverage actions I should take today?" \
        "01_morning_planning"
    
    # Scenario 2: Quick Win Generator
    test_scenario \
        "Quick Win Identification" \
        "quick_win_generator" \
        "I have 2 hours before meetings. What's a quick automation I can build that would save immediate time for my team and be visible in today's meeting?" \
        "02_quick_win"
    
    # Scenario 3: Meeting Preparation
    test_scenario \
        "Pre-Meeting Intelligence" \
        "corporate_nav" \
        "I have a meeting with IT Security in 30 minutes about my automation tools. They care about compliance and security. How should I navigate this conversation to get their support?" \
        "03_meeting_prep"
}

# Function to run strategic scenarios
run_strategic_scenarios() {
    print_header "🚀 STRATEGIC INNOVATION SCENARIOS"
    
    # Scenario 4: Innovation Discovery
    test_scenario \
        "Department Expansion Analysis" \
        "innovation_discovery" \
        "Risk Management automation saved 75% time. Looking at Claims Processing, Provider Relations, and Member Services - which department should be next for automation? Consider political feasibility and Star Ratings impact." \
        "04_expansion_analysis"
    
    # Scenario 5: ROI Calculation
    test_scenario \
        "Enterprise ROI Modeling" \
        "solution_design" \
        "Calculate ROI if we scale automation to Claims (200 people), Provider Relations (150 people), Member Services (300 people). Include hours saved, cost reduction, and Star Ratings impact." \
        "05_roi_calculation"
    
    # Scenario 6: Coalition Building
    test_scenario \
        "Strategic Coalition Building" \
        "advocates_strategy" \
        "Current allies: Mike Searcy, Lisa Chen. Potential supporters: Tom Rodriguez, Sarah Williams. How do I build critical mass for innovation adoption without triggering resistance?" \
        "06_coalition_building"
}

# Function to run advanced scenarios
run_advanced_scenarios() {
    print_header "🎭 ADVANCED POLITICAL & CAREER SCENARIOS"
    
    # Scenario 7: Executive Positioning
    test_scenario \
        "Executive Visibility Strategy" \
        "ai_leadership" \
        "I need to get on the CDO's radar within 30 days. He cares about digital transformation and Star Ratings. Create a visibility plan that feels organic." \
        "07_executive_positioning"
    
    # Scenario 8: Opposition Handling
    test_scenario \
        "Converting Skeptics Strategy" \
        "corporate_nav" \
        "A senior IT leader is questioning my automation tools and raising security concerns. How do I convert them from blocker to supporter?" \
        "08_opposition_handling"
    
    # Scenario 9: Victory Planning
    test_scenario \
        "AI Center of Excellence Planning" \
        "strategic_synthesis" \
        "If approved to lead an AI Center of Excellence, create a 100-day plan that delivers rapid wins while building sustainable capability." \
        "09_victory_planning"
}

# Function to generate summary report
generate_summary() {
    local report_file="$RESULTS_DIR/test_summary_report.md"
    
    cat > "$report_file" << EOF
# Mirador Real-World Scenario Test Report

**Test Date**: $(date)
**Test Mode**: $TEST_MODE
**Results Directory**: $RESULTS_DIR

## Test Execution Summary

### Scenarios Tested:
EOF
    
    # Add list of executed tests
    for log in "$RESULTS_DIR"/test_*.log; do
        if [ -f "$log" ]; then
            local test_name=$(basename "$log" .log)
            local size=$(wc -c < "$log")
            echo "- $test_name (${size} bytes)" >> "$report_file"
        fi
    done
    
    cat >> "$report_file" << EOF

## Key Observations:

1. **Response Time**: Average response time per scenario
2. **Output Quality**: Relevance and actionability of responses
3. **Chain Performance**: Which chains performed best
4. **System Stability**: Any errors or timeouts

## Recommendations:

1. Optimize slow-performing chains
2. Enhance context handling for complex scenarios
3. Improve error recovery mechanisms

## Next Steps:

1. Review individual test logs for detailed analysis
2. Run failed tests with extended timeouts
3. Implement suggested improvements

---
*Generated by Mirador Test Framework*
EOF
    
    echo -e "\n${GREEN}📄 Summary report saved to: $report_file${NC}"
}

# Main execution
main() {
    clear
    echo -e "${CYAN}"
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║     MIRADOR REAL-WORLD SCENARIO TEST RUNNER           ║"
    echo "║     Testing Practical Use Cases & Applications         ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    
    echo "Test Mode: $TEST_MODE"
    echo "Timeout per test: ${TIMEOUT}s"
    echo "Results directory: $RESULTS_DIR"
    
    # Check if Ollama is running
    if ! ollama list &> /dev/null; then
        echo -e "\n${RED}❌ ERROR: Ollama is not running!${NC}"
        echo "Start Ollama with: ollama serve"
        exit 1
    fi
    
    # Check if humana_chain_runner.sh exists
    if [ ! -f "$PROJECT_ROOT/humana_chain_runner.sh" ]; then
        echo -e "\n${RED}❌ ERROR: humana_chain_runner.sh not found!${NC}"
        echo "Expected location: $PROJECT_ROOT/humana_chain_runner.sh"
        exit 1
    fi
    
    echo -e "\n${YELLOW}Starting scenario tests...${NC}\n"
    
    case $TEST_MODE in
        basic)
            run_basic_scenarios
            ;;
        strategic)
            run_basic_scenarios
            run_strategic_scenarios
            ;;
        full)
            run_basic_scenarios
            run_strategic_scenarios
            run_advanced_scenarios
            ;;
        *)
            echo -e "${RED}Invalid test mode. Use: basic, strategic, or full${NC}"
            exit 1
            ;;
    esac
    
    # Generate summary report
    generate_summary
    
    echo -e "\n${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✅ Scenario testing complete!${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    # Show quick stats
    local total_tests=$(ls -1 "$RESULTS_DIR"/test_*.log 2>/dev/null | wc -l)
    echo -e "\nTests executed: $total_tests"
    echo -e "Results saved in: ${YELLOW}$RESULTS_DIR${NC}"
    
    # Offer to show a sample result
    echo -e "\n${CYAN}Would you like to view a sample test result? (y/n)${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        local sample_log=$(ls -1 "$RESULTS_DIR"/test_*.log 2>/dev/null | head -1)
        if [ -f "$sample_log" ]; then
            echo -e "\n${YELLOW}Sample output from: $(basename "$sample_log")${NC}"
            echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
            head -n 50 "$sample_log"
            echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        fi
    fi
}

# Script execution starts here
if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "Usage: $0 [test_mode] [timeout]"
    echo ""
    echo "Test modes:"
    echo "  basic     - Run daily operational scenarios (default)"
    echo "  strategic - Run basic + strategic innovation scenarios"
    echo "  full      - Run all scenarios including advanced"
    echo ""
    echo "Timeout: Number of seconds per test (default: 60)"
    echo ""
    echo "Examples:"
    echo "  $0                    # Run basic tests with 60s timeout"
    echo "  $0 strategic 120      # Run strategic tests with 2min timeout"
    echo "  $0 full 180          # Run all tests with 3min timeout"
    exit 0
fi

# Run main function
main