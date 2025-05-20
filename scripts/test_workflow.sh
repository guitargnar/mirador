#!/usr/bin/env bash
# Test script for Mirador workflow

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

echo "🧪 Running Mirador workflow test"
echo "==============================="
echo ""

# Create a temporary directory for the test
TEST_DIR="$ROOT_DIR/outputs/test_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$TEST_DIR"

# Create a test template file
TEST_TEMPLATE="$TEST_DIR/test_guitar_practice.txt"

cat > "$TEST_TEMPLATE" << 'EOF'
Guitar Practice Request:

Current skill level: Intermediate
Specific techniques I want to work on: Sweep picking and alternate picking

Musical goals:
1. Improve speed and accuracy on sweep arpeggios
2. Develop better coordination between picking and fretting hands
3. Apply techniques to a metal context

Time available for practice daily: 30 minutes
EOF

echo "Created test template at: $TEST_TEMPLATE"
echo ""
echo "Running test workflow with predefined input (no interaction required)..."
echo ""

# Run the workflow command with the test input
"$ROOT_DIR/src/chains/run_chain.sh" "$(cat "$TEST_TEMPLATE")" guitar_expert_precise fast_agent_focused

echo ""
echo "Test completed! Check the output directory for results."
echo "You can review the generated output by answering 'y' when prompted."

# Clean up test template
echo "Cleaning up temporary files..."
rm -f "$TEST_TEMPLATE"
rmdir "$TEST_DIR" 2>/dev/null || true