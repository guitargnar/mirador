#!/usr/bin/env bash
# Test for enhanced_agent

echo "Testing enhanced_agent..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/enhanced_agent_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Appropriate prompt for comprehensive analysis model
PROMPT="Analyze the current state and future of AI-powered music education from multiple perspectives:

1. Technological feasibility (current limitations and future possibilities)
2. Educational impact (compared to traditional learning methods)
3. Market adoption barriers and opportunities
4. Ethical considerations (data privacy, cultural implications)
5. Long-term impact on music industry and education

Provide a comprehensive, balanced analysis that considers multiple viewpoints and includes evidence-based reasoning."

# Run test with appropriate prompt for this model type
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"enhanced_agent\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/response.json"

# Extract response
cat "$OUTPUT_DIR/response.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/output.txt"

# Log test metadata
echo "Model: enhanced_agent" > "$OUTPUT_DIR/metadata.txt"
echo "Timestamp: $(date)" >> "$OUTPUT_DIR/metadata.txt"
echo "Prompt: $PROMPT" >> "$OUTPUT_DIR/metadata.txt"
echo "Response size: $(wc -c < $OUTPUT_DIR/output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
DURATION=$(cat "$OUTPUT_DIR/response.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
echo "Response time: $DURATION nanoseconds" >> "$OUTPUT_DIR/metadata.txt"

echo "Test completed. Results in $OUTPUT_DIR"