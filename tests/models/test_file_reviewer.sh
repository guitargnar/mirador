#!/usr/bin/env bash
# Test for file_reviewer

echo "Testing file_reviewer..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/file_reviewer_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Appropriate prompt for documentation model - simplified to avoid parsing issues
PROMPT="Create comprehensive documentation for a Node.js authentication API module that handles user registration, login with rate limiting, and token refresh functionality. Include the following sections: 1) Overview of the API's purpose, 2) Endpoint documentation with parameters and return values, 3) Authentication flow explanation, 4) Security considerations, and 5) Usage examples."

# Run test with appropriate prompt for this model type
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"file_reviewer\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/response.json"

# Extract response
cat "$OUTPUT_DIR/response.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/output.txt"

# Log test metadata
echo "Model: file_reviewer" > "$OUTPUT_DIR/metadata.txt"
echo "Timestamp: $(date)" >> "$OUTPUT_DIR/metadata.txt"
echo "Prompt: $PROMPT" >> "$OUTPUT_DIR/metadata.txt"
echo "Response size: $(wc -c < $OUTPUT_DIR/output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
DURATION=$(cat "$OUTPUT_DIR/response.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
echo "Response time: $DURATION nanoseconds" >> "$OUTPUT_DIR/metadata.txt"

echo "Test completed. Results in $OUTPUT_DIR"