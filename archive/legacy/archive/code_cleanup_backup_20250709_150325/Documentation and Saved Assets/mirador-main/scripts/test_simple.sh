#!/usr/bin/env bash
# Ultra-simplified test script for Mirador - direct Ollama API access

echo "🧪 Running Simple Mirador Test"
echo "============================"
echo ""

# Create output directory
OUTPUT_DIR=~/simple_test_$(date +%Y%m%d_%H%M%S)
mkdir -p "$OUTPUT_DIR"

# Define models and prompt
PROMPT="Create a 30-minute practice routine for improving sweep picking technique"
MODEL1="guitar_expert_precise"
MODEL2="fast_agent_focused"

echo "Testing with prompt: '$PROMPT'"
echo "Models: $MODEL1 → $MODEL2"
echo "Saving results to: $OUTPUT_DIR"
echo ""

# Step 1: Run first model directly
echo "Step 1: Running $MODEL1..."
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"$MODEL1\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/step1_raw.txt"

# Extract just the content we need using a safer method
echo "Extracting step 1 response..."
cat "$OUTPUT_DIR/step1_raw.txt" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/step1_output.txt"

# Step 2: Run second model directly with the output from the first
STEP1_OUTPUT=$(cat "$OUTPUT_DIR/step1_output.txt")
STEP2_PROMPT="Here is an analysis from a previous agent: $STEP1_OUTPUT. Based on this information, please provide your specialized perspective and expand upon these ideas. Focus on practical implementation and actionable next steps."

echo "Step 2: Running $MODEL2..."
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"$MODEL2\", \"prompt\": \"$STEP2_PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/step2_raw.txt"

# Extract just the content again
echo "Extracting step 2 response..."
cat "$OUTPUT_DIR/step2_raw.txt" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/step2_output.txt"

# Create a simple summary
echo "Creating summary..."
echo "# Chain Execution Results" > "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
echo "## Initial Prompt" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
echo "$PROMPT" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Models Used" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
echo "1. $MODEL1" >> "$OUTPUT_DIR/summary.md"
echo "2. $MODEL2" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Step 1: $MODEL1" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
cat "$OUTPUT_DIR/step1_output.txt" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Step 2: $MODEL2" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
cat "$OUTPUT_DIR/step2_output.txt" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "✅ Test completed successfully!"
echo "Results saved to: $OUTPUT_DIR"
echo ""
echo "Would you like to view the summary now? (y/n)"
read -r view_summary
if [[ "$view_summary" == "y" ]]; then
  less "$OUTPUT_DIR/summary.md"
fi