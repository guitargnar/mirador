#!/usr/bin/env bash
# Test for guitar expertise + task organization chain

echo "Testing guitar_expert_precise + fast_agent_focused chain..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/chain_guitar_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Appropriate prompt for guitar practice chain
PROMPT="I want to improve my sweep picking technique over a 30-day practice plan with just 45 minutes available daily. I'm currently at an intermediate level and can play some basic sweep patterns but struggle with cleanliness and speed."

# Step 1: Run first model
echo "Step 1: Running guitar_expert_precise..."
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"guitar_expert_precise\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/step1_raw.json"

# Extract response
cat "$OUTPUT_DIR/step1_raw.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/step1_output.txt"

# Step 2: Run second model with first output
STEP1_OUTPUT=$(cat "$OUTPUT_DIR/step1_output.txt")
STEP2_PROMPT="Here is a guitar expert's analysis of sweep picking practice: 

$STEP1_OUTPUT

Based on this information, create an organized 30-day practice schedule with daily tasks, time allocations, and progress tracking metrics. Structure it for maximum efficiency within the 45-minute daily time constraint."

echo "Step 2: Running fast_agent_focused..."
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"fast_agent_focused\", \"prompt\": \"$STEP2_PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/step2_raw.json"

# Extract response
cat "$OUTPUT_DIR/step2_raw.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/step2_output.txt"

# Create summary
echo "# Guitar Expertise Chain Test" > "$OUTPUT_DIR/summary.md"
echo "Generated: $(date)" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Initial Prompt" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
echo "$PROMPT" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Chain Configuration" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
echo "1. guitar_expert_precise (Technical music instruction)" >> "$OUTPUT_DIR/summary.md"
echo "2. fast_agent_focused (Task organization)" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Step 1: Guitar Expert Analysis" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
cat "$OUTPUT_DIR/step1_output.txt" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Step 2: Practice Organization" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
cat "$OUTPUT_DIR/step2_output.txt" >> "$OUTPUT_DIR/summary.md"

# Log test metadata
echo "Chain: guitar_expert_precise + fast_agent_focused" > "$OUTPUT_DIR/metadata.txt"
echo "Timestamp: $(date)" >> "$OUTPUT_DIR/metadata.txt"
echo "Prompt: $PROMPT" >> "$OUTPUT_DIR/metadata.txt"
echo "Step 1 Response size: $(wc -c < $OUTPUT_DIR/step1_output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
echo "Step 2 Response size: $(wc -c < $OUTPUT_DIR/step2_output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
DURATION1=$(cat "$OUTPUT_DIR/step1_raw.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
DURATION2=$(cat "$OUTPUT_DIR/step2_raw.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
echo "Step 1 Response time: $DURATION1 nanoseconds" >> "$OUTPUT_DIR/metadata.txt"
echo "Step 2 Response time: $DURATION2 nanoseconds" >> "$OUTPUT_DIR/metadata.txt"

echo "Chain test completed. Results in $OUTPUT_DIR"