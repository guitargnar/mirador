#!/bin/bash

# Load testing script for Mirador API

set -e

# Default values
HOST="${HOST:-http://localhost}"
ADMIN_KEY="${ADMIN_KEY:-}"
USERS="${USERS:-50}"
SPAWN_RATE="${SPAWN_RATE:-5}"
RUN_TIME="${RUN_TIME:-5m}"
SCENARIO="${SCENARIO:-default}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Help function
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help              Show this help message"
    echo "  -H, --host              API host URL (default: http://localhost)"
    echo "  -k, --key               Admin API key (required)"
    echo "  -u, --users             Number of users (default: 50)"
    echo "  -r, --spawn-rate        Spawn rate (default: 5)"
    echo "  -t, --time              Run time (default: 5m)"
    echo "  -s, --scenario          Load test scenario (default: default)"
    echo "  --headless              Run without web UI"
    echo "  --report                Generate HTML report"
    echo ""
    echo "Available scenarios:"
    echo "  default                 Mixed API usage"
    echo "  streaming               Heavy streaming usage"
    echo "  graphql                 GraphQL-focused"
    echo "  stress                  Stress testing"
    echo "  journey                 User journey simulation"
    echo "  mobile                  Mobile app patterns"
    echo "  all                     Run all scenarios sequentially"
    echo ""
    echo "Examples:"
    echo "  $0 -k YOUR_API_KEY"
    echo "  $0 -k YOUR_API_KEY -u 100 -r 10 -t 10m"
    echo "  $0 -k YOUR_API_KEY -s streaming --headless --report"
}

# Parse arguments
HEADLESS=false
GENERATE_REPORT=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -H|--host)
            HOST="$2"
            shift 2
            ;;
        -k|--key)
            ADMIN_KEY="$2"
            shift 2
            ;;
        -u|--users)
            USERS="$2"
            shift 2
            ;;
        -r|--spawn-rate)
            SPAWN_RATE="$2"
            shift 2
            ;;
        -t|--time)
            RUN_TIME="$2"
            shift 2
            ;;
        -s|--scenario)
            SCENARIO="$2"
            shift 2
            ;;
        --headless)
            HEADLESS=true
            shift
            ;;
        --report)
            GENERATE_REPORT=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Check if admin key is provided
if [ -z "$ADMIN_KEY" ]; then
    echo -e "${RED}Error: Admin API key is required${NC}"
    echo "Use -k or --key to provide the admin key"
    exit 1
fi

# Check if locust is installed
if ! command -v locust &> /dev/null; then
    echo -e "${RED}Error: Locust is not installed${NC}"
    echo "Install it with: pip install locust"
    exit 1
fi

# Function to run a single scenario
run_scenario() {
    local scenario_name=$1
    local locust_file=$2
    local class_filter=$3
    
    echo -e "${GREEN}Running $scenario_name scenario...${NC}"
    
    # Build command
    cmd="locust -f $locust_file"
    
    if [ ! -z "$class_filter" ]; then
        cmd="$cmd:$class_filter"
    fi
    
    cmd="$cmd --host=$HOST --admin-key=$ADMIN_KEY"
    cmd="$cmd --users=$USERS --spawn-rate=$SPAWN_RATE --run-time=$RUN_TIME"
    
    if [ "$HEADLESS" = true ]; then
        cmd="$cmd --headless"
    fi
    
    if [ "$GENERATE_REPORT" = true ]; then
        timestamp=$(date +%Y%m%d-%H%M%S)
        report_file="report-${scenario_name}-${timestamp}.html"
        cmd="$cmd --html=$report_file"
    fi
    
    echo "Command: $cmd"
    eval $cmd
    
    if [ "$GENERATE_REPORT" = true ] && [ -f "$report_file" ]; then
        echo -e "${GREEN}Report generated: $report_file${NC}"
    fi
}

# Main execution
cd "$(dirname "$0")"

echo -e "${YELLOW}Mirador Load Testing${NC}"
echo "Host: $HOST"
echo "Users: $USERS"
echo "Spawn Rate: $SPAWN_RATE"
echo "Run Time: $RUN_TIME"
echo "Scenario: $SCENARIO"
echo ""

# Check API health before starting
echo "Checking API health..."
if curl -f -s "$HOST/api/v5/health" > /dev/null; then
    echo -e "${GREEN}API is healthy${NC}"
else
    echo -e "${RED}API health check failed${NC}"
    echo "Make sure the API is running at $HOST"
    exit 1
fi

# Run the appropriate scenario
case $SCENARIO in
    default)
        run_scenario "default" "locustfile.py" ""
        ;;
    streaming)
        run_scenario "streaming" "test_scenarios.py" "StreamingPowerUser"
        ;;
    graphql)
        run_scenario "graphql" "locustfile.py" "GraphQLUser"
        ;;
    stress)
        run_scenario "stress" "test_scenarios.py" "StressTestUser"
        ;;
    journey)
        run_scenario "journey" "test_scenarios.py" "TypicalUserJourney"
        ;;
    mobile)
        run_scenario "mobile" "test_scenarios.py" "MobileAppUser"
        ;;
    all)
        # Run all scenarios sequentially
        scenarios=("default" "streaming" "graphql" "stress" "journey" "mobile")
        for s in "${scenarios[@]}"; do
            echo ""
            echo -e "${YELLOW}=== Running $s scenario ===${NC}"
            SCENARIO=$s
            $0 -k "$ADMIN_KEY" -H "$HOST" -u "$USERS" -r "$SPAWN_RATE" -t "$RUN_TIME" --headless --report
            echo "Waiting 30 seconds before next scenario..."
            sleep 30
        done
        ;;
    *)
        echo -e "${RED}Unknown scenario: $SCENARIO${NC}"
        echo "Available scenarios: default, streaming, graphql, stress, journey, mobile, all"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}Load testing completed!${NC}"

# If reports were generated, list them
if [ "$GENERATE_REPORT" = true ]; then
    echo ""
    echo "Generated reports:"
    ls -la report-*.html 2>/dev/null || echo "No reports found"
fi