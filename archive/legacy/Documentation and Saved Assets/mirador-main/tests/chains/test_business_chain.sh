#!/usr/bin/env bash
# Test for balanced analysis + business opportunity chain

echo "Testing llama3.2_balanced + creative_entrepreneur chain..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/chain_business_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Appropriate prompt for business chain
PROMPT="I'm considering starting a side business offering virtual guitar lessons that integrate AI-powered feedback with personal coaching. I want to understand the market potential and how to structure this as a sustainable business."

# Step 1: Run first model
echo "Step 1: Running llama3.2_balanced..."
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"llama3.2_balanced\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/step1_raw.json"

# Extract response
cat "$OUTPUT_DIR/step1_raw.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/step1_output.txt"

# Step 2: Run second model with first output
STEP1_OUTPUT=$(cat "$OUTPUT_DIR/step1_output.txt")
STEP2_PROMPT="Here is an initial analysis of a virtual guitar teaching business with AI components:

$STEP1_OUTPUT

As an entrepreneurial strategist, identify specific business opportunities, market segments, monetization models, and go-to-market strategies for this concept. Provide 5-7 potential revenue streams, growth projections, competitive analysis, and key partnerships that would be needed. Focus on practical, market-focused insights that bridge technical capabilities with viable business opportunities."

echo "Step 2: Running creative_entrepreneur..."
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"creative_entrepreneur\", \"prompt\": \"$STEP2_PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/step2_raw.json"

# Extract response
cat "$OUTPUT_DIR/step2_raw.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/step2_output.txt"

# Create summary
echo "# Business Strategy Chain Test" > "$OUTPUT_DIR/summary.md"
echo "Generated: $(date)" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Initial Prompt" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
echo "$PROMPT" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Chain Configuration" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
echo "1. llama3.2_balanced (Initial analysis)" >> "$OUTPUT_DIR/summary.md"
echo "2. creative_entrepreneur (Business opportunity identification)" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Step 1: Initial Analysis" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
cat "$OUTPUT_DIR/step1_output.txt" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Step 2: Business Opportunities" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
cat "$OUTPUT_DIR/step2_output.txt" >> "$OUTPUT_DIR/summary.md"

# Log test metadata
echo "Chain: llama3.2_balanced + creative_entrepreneur" > "$OUTPUT_DIR/metadata.txt"
echo "Timestamp: $(date)" >> "$OUTPUT_DIR/metadata.txt"
echo "Prompt: $PROMPT" >> "$OUTPUT_DIR/metadata.txt"
echo "Step 1 Response size: $(wc -c < $OUTPUT_DIR/step1_output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
echo "Step 2 Response size: $(wc -c < $OUTPUT_DIR/step2_output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
DURATION1=$(cat "$OUTPUT_DIR/step1_raw.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
DURATION2=$(cat "$OUTPUT_DIR/step2_raw.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
echo "Step 1 Response time: $DURATION1 nanoseconds" >> "$OUTPUT_DIR/metadata.txt"
echo "Step 2 Response time: $DURATION2 nanoseconds" >> "$OUTPUT_DIR/metadata.txt"

echo "Chain test completed. Results in $OUTPUT_DIR"