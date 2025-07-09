#!/usr/bin/env bash
# Test for role-based chain

echo "Testing role chain..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/chain_role_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Simple authentication function for testing - avoid internal double quotes
CODE_SOLUTION='function authenticate(username, password) {
  // Very basic authentication
  if (username === admin && password === password123) {
    return { authenticated: true, role: admin };
  } else if (username && password) {
    return { authenticated: true, role: user };
  }
  return { authenticated: false };
}'

echo "Using test code solution:" > "$OUTPUT_DIR/metadata.txt"
echo "$CODE_SOLUTION" >> "$OUTPUT_DIR/metadata.txt"
echo "" >> "$OUTPUT_DIR/metadata.txt"
echo "Models: master_coder, code_reviewer_fix, creative_entrepreneur" >> "$OUTPUT_DIR/metadata.txt"

# Run the role chain
~/ai_framework_git/src/chains/role_chain.sh "$CODE_SOLUTION" master_coder code_reviewer_fix creative_entrepreneur

# Find the most recent chain output directory
LATEST_OUTPUT=$(find ~/ai_framework_git/outputs -name "chain_*" -type d | sort | tail -1)

# Copy the summary if it exists
if [ -f "$LATEST_OUTPUT/summary.md" ]; then
  cp "$LATEST_OUTPUT/summary.md" "$OUTPUT_DIR/summary.md"
  echo "Summary copied from: $LATEST_OUTPUT"
else
  echo "No summary found. Check: $LATEST_OUTPUT"
fi

echo "Test completed. Results in $OUTPUT_DIR"