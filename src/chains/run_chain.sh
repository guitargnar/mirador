#!/usr/bin/env bash
# Mirador chain runner

# Initialize the environment
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$( cd "$SCRIPT_DIR/../.." && pwd )"
source "$ROOT_DIR/src/utils/init.sh"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check arguments
if [ $# -lt 3 ]; then
  echo -e "${RED}Error: Not enough arguments${NC}"
  echo "Usage: $0 \"Your prompt\" model1 model2 [model3]"
  echo "Example: $0 \"Create a guitar practice routine\" guitar_expert_precise fast_agent_focused"
  exit 1
fi

PROMPT="$1"
MODEL1="$2"
MODEL2="$3"
MODEL3="$4"  # Optional third model

# Create output directory with timestamped name
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="$MIRADOR_OUTPUTS_DIR/chain_${TIMESTAMP}"
mkdir -p "$OUTPUT_DIR"

log_info "Running chain with prompt: ${PROMPT}"
log_info "Model 1: ${MODEL1}"
log_info "Model 2: ${MODEL2}"
if [ -n "$MODEL3" ]; then
  log_info "Model 3: ${MODEL3}"
fi
log_info "Saving results to: ${OUTPUT_DIR}"

echo -e "${BLUE}Running chain with prompt: ${PROMPT}${NC}"
echo -e "${BLUE}Model 1: ${MODEL1}${NC}"
echo -e "${BLUE}Model 2: ${MODEL2}${NC}"
if [ -n "$MODEL3" ]; then
  echo -e "${BLUE}Model 3: ${MODEL3}${NC}"
fi
echo -e "${BLUE}Saving results to: ${OUTPUT_DIR}${NC}"

# Step 1: Run first model with explicit parameters
echo -e "${YELLOW}Step 1: Running ${MODEL1}...${NC}"
log_debug "Executing model: $MODEL1"
time_cmd "$MODEL1 inference" curl -s -X POST http://localhost:11434/api/generate \
  -d "{
    \"model\": \"$MODEL1\", 
    \"prompt\": \"$PROMPT\", 
    \"stream\": false,
    \"temperature\": 0.7,
    \"num_predict\": 1024
  }" | jq -r '.response' > "$OUTPUT_DIR/step1_output.txt"

if [ $? -ne 0 ] || [ ! -s "$OUTPUT_DIR/step1_output.txt" ]; then
  log_error "Error running ${MODEL1} or empty response"
  echo -e "${RED}Error running ${MODEL1} or empty response${NC}"
  exit 1
fi

# Step 2: Run second model with first model's output and explicit parameters
echo -e "${YELLOW}Step 2: Running ${MODEL2}...${NC}"
STEP1_OUTPUT=$(cat "$OUTPUT_DIR/step1_output.txt")
STEP2_PROMPT="Here is an analysis from a previous agent: 

$STEP1_OUTPUT

Based on this information, please provide your specialized perspective and expand upon these ideas. Focus on practical implementation and actionable next steps."

echo "$STEP2_PROMPT" > "$OUTPUT_DIR/step2_prompt.txt"

log_debug "Executing model: $MODEL2"
time_cmd "$MODEL2 inference" curl -s -X POST http://localhost:11434/api/generate \
  -d "{
    \"model\": \"$MODEL2\", 
    \"prompt\": \"$STEP2_PROMPT\", 
    \"stream\": false,
    \"temperature\": 0.7,
    \"num_predict\": 1024
  }" | jq -r '.response' > "$OUTPUT_DIR/step2_output.txt"

if [ $? -ne 0 ] || [ ! -s "$OUTPUT_DIR/step2_output.txt" ]; then
  log_error "Error running ${MODEL2} or empty response"
  echo -e "${RED}Error running ${MODEL2} or empty response${NC}"
  exit 1
fi

# Step 3: Run third model if provided
if [ -n "$MODEL3" ]; then
  echo -e "${YELLOW}Step 3: Running ${MODEL3}...${NC}"
  STEP2_OUTPUT=$(cat "$OUTPUT_DIR/step2_output.txt")
  STEP3_PROMPT="Here are insights from two previous agents:

First agent's analysis:
$STEP1_OUTPUT

Second agent's perspective:
$STEP2_OUTPUT

Based on these insights, please provide your specialized perspective and create a final integrated solution. Focus on practical implementation and actionable next steps."

  echo "$STEP3_PROMPT" > "$OUTPUT_DIR/step3_prompt.txt"

  log_debug "Executing model: $MODEL3"
  time_cmd "$MODEL3 inference" curl -s -X POST http://localhost:11434/api/generate \
    -d "{
      \"model\": \"$MODEL3\", 
      \"prompt\": \"$STEP3_PROMPT\", 
      \"stream\": false,
      \"temperature\": 0.7,
      \"num_predict\": 1024
    }" | jq -r '.response' > "$OUTPUT_DIR/step3_output.txt"

  if [ $? -ne 0 ] || [ ! -s "$OUTPUT_DIR/step3_output.txt" ]; then
    log_error "Error running ${MODEL3} or empty response"
    echo -e "${RED}Error running ${MODEL3} or empty response${NC}"
    exit 1
  fi
fi

# Create summary file
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
if [ -n "$MODEL3" ]; then
  echo "3. $MODEL3" >> "$OUTPUT_DIR/summary.md"
fi
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Step 1: $MODEL1" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
cat "$OUTPUT_DIR/step1_output.txt" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Step 2: $MODEL2" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
cat "$OUTPUT_DIR/step2_output.txt" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

if [ -n "$MODEL3" ]; then
  echo "## Step 3: $MODEL3" >> "$OUTPUT_DIR/summary.md"
  echo "" >> "$OUTPUT_DIR/summary.md"
  cat "$OUTPUT_DIR/step3_output.txt" >> "$OUTPUT_DIR/summary.md"
  echo "" >> "$OUTPUT_DIR/summary.md"
fi

log_info "Chain execution complete!"
echo -e "${GREEN}Chain execution complete!${NC}"
echo -e "${BLUE}Results saved to: ${OUTPUT_DIR}${NC}"

# Determine category and organize output
echo -e "${BLUE}Organizing output...${NC}"

# Try to determine category
CATEGORY=""
if [[ "$MODEL1" == *"guitar"* || "$MODEL2" == *"guitar"* || "$MODEL3" == *"guitar"* || 
      "$PROMPT" == *"guitar"* || "$PROMPT" == *"music"* || "$PROMPT" == *"practice"* ]]; then
  CATEGORY="guitar_learning"
elif [[ "$MODEL1" == *"finance"* || "$MODEL2" == *"finance"* || "$MODEL3" == *"finance"* || 
        "$PROMPT" == *"budget"* || "$PROMPT" == *"finance"* || "$PROMPT" == *"money"* ]]; then
  CATEGORY="financial_plans"
elif [[ "$MODEL1" == *"career"* || "$MODEL2" == *"career"* || "$MODEL3" == *"career"* || 
        "$PROMPT" == *"career"* || "$PROMPT" == *"job"* || "$PROMPT" == *"profession"* ]]; then
  CATEGORY="career_plans"
elif [[ "$MODEL1" == *"debug"* || "$MODEL2" == *"debug"* || "$MODEL3" == *"debug"* || 
        "$OUTPUT_DIR" == *"debug"* ]]; then
  CATEGORY="debug_logs"
else
  CATEGORY="business_strategies"
fi

log_info "Categorized as: $CATEGORY"

# Create a symlink in the category directory
CATEGORY_DIR="$MIRADOR_OUTPUTS_DIR/$CATEGORY"
mkdir -p "$CATEGORY_DIR"
ln -s "$OUTPUT_DIR" "$CATEGORY_DIR/$(basename "$OUTPUT_DIR")"

echo -e "${GREEN}Output organized under category: ${CATEGORY}${NC}"

# Ask to view summary
echo -e "${BLUE}Would you like to view the summary? (y/n)${NC}"
read -r view_summary
if [[ "$view_summary" == "y" ]]; then
  less "$OUTPUT_DIR/summary.md"
fi

log_info "Chain execution and organization complete"
exit 0
