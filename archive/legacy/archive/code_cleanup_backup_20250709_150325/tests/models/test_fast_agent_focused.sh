#!/usr/bin/env bash
# Test for fast_agent_focused

echo "Testing fast_agent_focused..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/fast_agent_focused_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Appropriate prompt for task management/organization model
PROMPT="Organize these tasks into a prioritized plan:
1. Complete project proposal (3 hours)
2. Reply to client emails (30 minutes)
3. Review team code changes (1 hour)
4. Prepare for tomorrow's presentation (2 hours)
5. Update documentation (1 hour)
6. Schedule team meeting (15 minutes)
7. Guitar practice (45 minutes)

I have 6 working hours available today. Some tasks can be moved to tomorrow if needed. Important context: the presentation is tomorrow morning and client responses are expected by end of day."

# Run test with appropriate prompt for this model type
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"fast_agent_focused\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/response.json"

# Extract response
cat "$OUTPUT_DIR/response.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/output.txt"

# Log test metadata
echo "Model: fast_agent_focused" > "$OUTPUT_DIR/metadata.txt"
echo "Timestamp: $(date)" >> "$OUTPUT_DIR/metadata.txt"
echo "Prompt: $PROMPT" >> "$OUTPUT_DIR/metadata.txt"
echo "Response size: $(wc -c < $OUTPUT_DIR/output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
DURATION=$(cat "$OUTPUT_DIR/response.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
echo "Response time: $DURATION nanoseconds" >> "$OUTPUT_DIR/metadata.txt"

echo "Test completed. Results in $OUTPUT_DIR"