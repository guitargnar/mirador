#!/usr/bin/env bash
# Test for code generation + review chain

echo "Testing master_coder + code_reviewer_fix chain..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/chain_code_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Appropriate prompt for code chain
PROMPT="Create a secure user authentication system in Node.js with Express that includes password hashing, JWT token generation, and proper error handling."

# Step 1: Run first model
echo "Step 1: Running master_coder..."
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"master_coder\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/step1_raw.json"

# Extract response
cat "$OUTPUT_DIR/step1_raw.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/step1_output.txt"

# Step 2: Run second model with first output
STEP1_OUTPUT=$(cat "$OUTPUT_DIR/step1_output.txt")
STEP2_PROMPT="Here is a Node.js authentication system implementation:

$STEP1_OUTPUT

As a code reviewer, analyze this implementation for:
1. Security vulnerabilities and improvements
2. Performance optimizations
3. Best practices alignment
4. Error handling completeness
5. Edge cases
6. Code organization improvements

Provide specific recommendations with code examples showing how to fix each issue."

echo "Step 2: Running code_reviewer_fix..."
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"code_reviewer_fix\", \"prompt\": \"$STEP2_PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/step2_raw.json"

# Extract response
cat "$OUTPUT_DIR/step2_raw.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/step2_output.txt"

# Create summary
echo "# Code Development Chain Test" > "$OUTPUT_DIR/summary.md"
echo "Generated: $(date)" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Initial Prompt" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
echo "$PROMPT" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Chain Configuration" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
echo "1. master_coder (Code generation)" >> "$OUTPUT_DIR/summary.md"
echo "2. code_reviewer_fix (Code review & improvement)" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Step 1: Code Implementation" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
echo '```javascript' >> "$OUTPUT_DIR/summary.md"
cat "$OUTPUT_DIR/step1_output.txt" >> "$OUTPUT_DIR/summary.md"
echo '```' >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Step 2: Code Review & Improvements" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
cat "$OUTPUT_DIR/step2_output.txt" >> "$OUTPUT_DIR/summary.md"

# Log test metadata
echo "Chain: master_coder + code_reviewer_fix" > "$OUTPUT_DIR/metadata.txt"
echo "Timestamp: $(date)" >> "$OUTPUT_DIR/metadata.txt"
echo "Prompt: $PROMPT" >> "$OUTPUT_DIR/metadata.txt"
echo "Step 1 Response size: $(wc -c < $OUTPUT_DIR/step1_output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
echo "Step 2 Response size: $(wc -c < $OUTPUT_DIR/step2_output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
DURATION1=$(cat "$OUTPUT_DIR/step1_raw.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
DURATION2=$(cat "$OUTPUT_DIR/step2_raw.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
echo "Step 1 Response time: $DURATION1 nanoseconds" >> "$OUTPUT_DIR/metadata.txt"
echo "Step 2 Response time: $DURATION2 nanoseconds" >> "$OUTPUT_DIR/metadata.txt"

echo "Chain test completed. Results in $OUTPUT_DIR"