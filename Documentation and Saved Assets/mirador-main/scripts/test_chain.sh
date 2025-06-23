#!/usr/bin/env bash
# Simple test script for Mirador chain runner

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

echo "🧪 Running Mirador test chain"
echo "=============================="
echo ""

# Test a simple guitar practice chain
echo "Testing guitar practice chain with guitar_expert_precise and fast_agent_focused models"
echo "Prompt: 'Create a 30-minute practice routine for improving sweep picking technique'"
echo ""
echo "Running test..."

"$ROOT_DIR/scripts/run_chain.sh" "Create a 30-minute practice routine for improving sweep picking technique" guitar_expert_precise fast_agent_focused

echo ""
echo "Test completed! Check the output directory for results."
echo "You can review the generated output by answering 'y' when prompted."