#!/usr/bin/env bash
# Test for guitar_expert_precise

echo "Testing guitar_expert_precise..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/guitar_expert_precise_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Appropriate prompt for guitar instruction model
PROMPT="Create a practice routine for sweep picking arpeggios in metal music. Include tablature examples and a progressive approach from beginner to intermediate level. Explain the music theory behind the arpeggios you're using."

# Run test with appropriate prompt for this model type
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"guitar_expert_precise\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/response.json"

# Extract response
cat "$OUTPUT_DIR/response.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/output.txt"

# Log test metadata
echo "Model: guitar_expert_precise" > "$OUTPUT_DIR/metadata.txt"
echo "Timestamp: $(date)" >> "$OUTPUT_DIR/metadata.txt"
echo "Prompt: $PROMPT" >> "$OUTPUT_DIR/metadata.txt"
echo "Response size: $(wc -c < $OUTPUT_DIR/output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
DURATION=$(cat "$OUTPUT_DIR/response.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
echo "Response time: $DURATION nanoseconds" >> "$OUTPUT_DIR/metadata.txt"

echo "Test completed. Results in $OUTPUT_DIR"