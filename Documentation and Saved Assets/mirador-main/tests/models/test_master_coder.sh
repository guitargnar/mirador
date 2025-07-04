#!/usr/bin/env bash
# Test for master_coder

echo "Testing master_coder..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/master_coder_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Appropriate prompt for code generation model
PROMPT="Create a Node.js utility module for securely handling user authentication with the following requirements:
1. Email/password based authentication
2. JWT token generation and validation
3. Password hashing using bcrypt
4. Rate limiting for failed login attempts
5. Session management with token refresh
6. Comprehensive error handling
7. Unit tests for key functions

Organize the code following best practices and include detailed comments explaining the implementation."

# Run test with appropriate prompt for this model type
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"master_coder\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/response.json"

# Extract response
cat "$OUTPUT_DIR/response.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/output.txt"

# Log test metadata
echo "Model: master_coder" > "$OUTPUT_DIR/metadata.txt"
echo "Timestamp: $(date)" >> "$OUTPUT_DIR/metadata.txt"
echo "Prompt: $PROMPT" >> "$OUTPUT_DIR/metadata.txt"
echo "Response size: $(wc -c < $OUTPUT_DIR/output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
DURATION=$(cat "$OUTPUT_DIR/response.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
echo "Response time: $DURATION nanoseconds" >> "$OUTPUT_DIR/metadata.txt"

echo "Test completed. Results in $OUTPUT_DIR"