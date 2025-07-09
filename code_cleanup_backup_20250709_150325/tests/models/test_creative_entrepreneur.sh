#!/usr/bin/env bash
# Test for creative_entrepreneur

echo "Testing creative_entrepreneur..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/creative_entrepreneur_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Appropriate prompt for business analysis model
PROMPT="Analyze the business potential for an AI-powered guitar teaching application with the following features:
- Real-time feedback on playing technique using camera input
- Customized lesson plans based on skill level and musical interests
- Virtual community for sharing progress and getting peer feedback
- Integration with popular music streaming services
- Subscription-based model with tiered pricing

Identify potential market segments, monetization strategies, growth opportunities, competitive landscape, key partnerships needed, and a potential go-to-market approach."

# Run test with appropriate prompt for this model type
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"creative_entrepreneur\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/response.json"

# Extract response
cat "$OUTPUT_DIR/response.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/output.txt"

# Log test metadata
echo "Model: creative_entrepreneur" > "$OUTPUT_DIR/metadata.txt"
echo "Timestamp: $(date)" >> "$OUTPUT_DIR/metadata.txt"
echo "Prompt: $PROMPT" >> "$OUTPUT_DIR/metadata.txt"
echo "Response size: $(wc -c < $OUTPUT_DIR/output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
DURATION=$(cat "$OUTPUT_DIR/response.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
echo "Response time: $DURATION nanoseconds" >> "$OUTPUT_DIR/metadata.txt"

echo "Test completed. Results in $OUTPUT_DIR"