#!/usr/bin/env bash
# Test for llama3.2_balanced

echo "Testing llama3.2_balanced..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/llama3.2_balanced_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Appropriate prompt for balanced general-purpose model
PROMPT="Create a personal financial planning guide for a mid-career professional with the following situation:
- Current salary: $85,000/year
- Student loan debt: $20,000 (5% interest)
- Credit card debt: $5,000 (18% interest)
- Monthly expenses: $3,500
- Current savings: $15,000
- Goals: Save for home down payment, build emergency fund, and start retirement planning

Provide clear, actionable advice with specific steps, reasonable timeframes, and strategies to balance competing financial priorities."

# Run test with appropriate prompt for this model type
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"llama3.2_balanced\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/response.json"

# Extract response
cat "$OUTPUT_DIR/response.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/output.txt"

# Log test metadata
echo "Model: llama3.2_balanced" > "$OUTPUT_DIR/metadata.txt"
echo "Timestamp: $(date)" >> "$OUTPUT_DIR/metadata.txt"
echo "Prompt: $PROMPT" >> "$OUTPUT_DIR/metadata.txt"
echo "Response size: $(wc -c < $OUTPUT_DIR/output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
DURATION=$(cat "$OUTPUT_DIR/response.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
echo "Response time: $DURATION nanoseconds" >> "$OUTPUT_DIR/metadata.txt"

echo "Test completed. Results in $OUTPUT_DIR"