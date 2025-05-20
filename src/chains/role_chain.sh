#!/usr/bin/env bash
# Mirador role-based chain runner

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

# Define a function to get role prompts instead of using associative arrays
get_role_prompt() {
  local role=$1
  
  case "$role" in
    "creative_entrepreneur")
      echo "Identify potential applications for this code/solution: {input}"
      ;;
    "enhanced_agent")
      echo "Using your knowledge base, analyze this solution and provide additional insights: {input}"
      ;;
    "master_coder")
      echo "Examine this code and suggest optimizations, improvements, or alternative approaches: {input}"
      ;;
    "code_reviewer_fix")
      echo "Review this code for bugs, security issues, and suggest fixes: {input}"
      ;;
    "file_reviewer")
      echo "Document this solution thoroughly with examples, edge cases, and usage guidelines: {input}"
      ;;
    "ux_designer")
      echo "Design a user interface for implementing this solution: {input}"
      ;;
    *)
      echo "Analyze this code/solution and provide insights: {input}"
      ;;
  esac
}

# Check arguments
if [ $# -lt 3 ]; then
  echo -e "${RED}Error: Not enough arguments${NC}"
  echo "Usage: $0 \"Your technical solution or code\" model1 model2 [model3]"
  echo "Available models/roles: creative_entrepreneur, enhanced_agent, master_coder, code_reviewer_fix, file_reviewer, ux_designer"
  echo "Example: $0 \"function authenticate(user, pass) { ... }\" master_coder code_reviewer_fix creative_entrepreneur"
  exit 1
fi

SOLUTION="$1"
MODEL1="$2"
MODEL2="$3"
MODEL3="$4"  # Optional third model

# Create output directory with timestamped name
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="$MIRADOR_OUTPUTS_DIR/chain_${TIMESTAMP}"
mkdir -p "$OUTPUT_DIR"

log_info "Running role chain with solution input"
log_info "Model 1: ${MODEL1}"
log_info "Model 2: ${MODEL2}"
if [ -n "$MODEL3" ]; then
  log_info "Model 3: ${MODEL3}"
fi
log_info "Saving results to: ${OUTPUT_DIR}"

echo -e "${BLUE}Running role chain with technical solution/code${NC}"
echo -e "${BLUE}Model 1: ${MODEL1}${NC}"
echo -e "${BLUE}Model 2: ${MODEL2}${NC}"
if [ -n "$MODEL3" ]; then
  echo -e "${BLUE}Model 3: ${MODEL3}${NC}"
fi
echo -e "${BLUE}Saving results to: ${OUTPUT_DIR}${NC}"

# Save the original solution
echo "$SOLUTION" > "$OUTPUT_DIR/original_solution.txt"

# Step 1: Run first model with explicit parameters
echo -e "${YELLOW}Step 1: Running ${MODEL1} role...${NC}"
log_debug "Executing model: $MODEL1"

# Get the appropriate prompt for this role
ROLE1_PROMPT=$(get_role_prompt "$MODEL1")
# Replace {input} with the solution
STEP1_PROMPT="${ROLE1_PROMPT//\{input\}/$SOLUTION}"

echo "$STEP1_PROMPT" > "$OUTPUT_DIR/step1_prompt.txt"

# Escape JSON properly
JSON_PROMPT=$(echo "$STEP1_PROMPT" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')

time_cmd "$MODEL1 inference" curl -s -X POST http://localhost:11434/api/generate \
  -d "{
    \"model\": \"$MODEL1\", 
    \"prompt\": \"$JSON_PROMPT\", 
    \"stream\": false,
    \"temperature\": 0.7,
    \"num_predict\": 2048
  }" > "$OUTPUT_DIR/step1_raw.json"

# Extract the response safely
log_debug "Extracting response from raw output"

# Create a simple function to extract response content
extract_response() {
  local input_file=$1
  local output_file=$2
  
  # Try something very simple first - extract everything after "response":
  grep -o '"response":[^}]*' "$input_file" | sed 's/"response"://g' > "$output_file"
  
  # If that didn't work, try an even simpler approach
  if [ ! -s "$output_file" ]; then
    log_debug "Simple extraction failed, trying fallback method"
    # Just save everything after response":
    sed -n 's/.*"response"://p' "$input_file" > "$output_file"
  fi
  
  # Final fallback - just use the raw response if all else fails
  if [ ! -s "$output_file" ]; then
    log_warn "All extraction methods failed, using raw response"
    cp "$input_file" "$output_file"
  fi
}

# Just try the simplest possible approach for maximum reliability
log_info "Extracting response for model 1"
extract_response "$OUTPUT_DIR/step1_raw.json" "$OUTPUT_DIR/step1_output.txt"

if [ $? -ne 0 ] || [ ! -s "$OUTPUT_DIR/step1_output.txt" ]; then
  log_error "Error running ${MODEL1} or empty response"
  echo -e "${RED}Error running ${MODEL1} or empty response${NC}"
  exit 1
fi

# Step 2: Run second model with first model's output and explicit parameters
echo -e "${YELLOW}Step 2: Running ${MODEL2} role...${NC}"
STEP1_OUTPUT=$(cat "$OUTPUT_DIR/step1_output.txt")

# Get the appropriate prompt for this role
ROLE2_PROMPT=$(get_role_prompt "$MODEL2")
# Replace {input} with the combined solution and first model output
STEP2_PROMPT="Original solution:
$SOLUTION

${MODEL1}'s analysis:
$STEP1_OUTPUT

${ROLE2_PROMPT//\{input\}/Based on the above information}"

echo "$STEP2_PROMPT" > "$OUTPUT_DIR/step2_prompt.txt"

log_debug "Executing model: $MODEL2"

# Escape JSON properly
JSON_PROMPT=$(echo "$STEP2_PROMPT" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')

time_cmd "$MODEL2 inference" curl -s -X POST http://localhost:11434/api/generate \
  -d "{
    \"model\": \"$MODEL2\", 
    \"prompt\": \"$JSON_PROMPT\", 
    \"stream\": false,
    \"temperature\": 0.7,
    \"num_predict\": 2048
  }" > "$OUTPUT_DIR/step2_raw.json"

# Extract the response safely
log_info "Extracting response for model 2"
extract_response "$OUTPUT_DIR/step2_raw.json" "$OUTPUT_DIR/step2_output.txt"

if [ $? -ne 0 ] || [ ! -s "$OUTPUT_DIR/step2_output.txt" ]; then
  log_error "Error running ${MODEL2} or empty response"
  echo -e "${RED}Error running ${MODEL2} or empty response${NC}"
  exit 1
fi

# Step 3: Run third model if provided
if [ -n "$MODEL3" ]; then
  echo -e "${YELLOW}Step 3: Running ${MODEL3} role...${NC}"
  STEP2_OUTPUT=$(cat "$OUTPUT_DIR/step2_output.txt")
  
  # Get the appropriate prompt for this role
  ROLE3_PROMPT=$(get_role_prompt "$MODEL3")
  # Replace {input} with all previous context
  STEP3_PROMPT="Original solution:
$SOLUTION

${MODEL1}'s analysis:
$STEP1_OUTPUT

${MODEL2}'s analysis:
$STEP2_OUTPUT

${ROLE3_PROMPT//\{input\}/Based on all the above information}"

  echo "$STEP3_PROMPT" > "$OUTPUT_DIR/step3_prompt.txt"

  log_debug "Executing model: $MODEL3"
  
  # Escape JSON properly
  JSON_PROMPT=$(echo "$STEP3_PROMPT" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')
  
  time_cmd "$MODEL3 inference" curl -s -X POST http://localhost:11434/api/generate \
    -d "{
      \"model\": \"$MODEL3\", 
      \"prompt\": \"$JSON_PROMPT\", 
      \"stream\": false,
      \"temperature\": 0.7,
      \"num_predict\": 2048
    }" > "$OUTPUT_DIR/step3_raw.json"

  # Extract the response safely
  log_info "Extracting response for model 3"
  extract_response "$OUTPUT_DIR/step3_raw.json" "$OUTPUT_DIR/step3_output.txt"

  if [ $? -ne 0 ] || [ ! -s "$OUTPUT_DIR/step3_output.txt" ]; then
    log_error "Error running ${MODEL3} or empty response"
    echo -e "${RED}Error running ${MODEL3} or empty response${NC}"
    exit 1
  fi
fi

# Create summary file
echo "# Role Chain Execution Results" > "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
echo "## Original Solution/Code" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
echo '```' >> "$OUTPUT_DIR/summary.md"
echo "$SOLUTION" >> "$OUTPUT_DIR/summary.md"
echo '```' >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"

echo "## Models Used" >> "$OUTPUT_DIR/summary.md"
echo "" >> "$OUTPUT_DIR/summary.md"
echo "1. $MODEL1: $(get_role_prompt "$MODEL1")" >> "$OUTPUT_DIR/summary.md"
echo "2. $MODEL2: $(get_role_prompt "$MODEL2")" >> "$OUTPUT_DIR/summary.md"
if [ -n "$MODEL3" ]; then
  echo "3. $MODEL3: $(get_role_prompt "$MODEL3")" >> "$OUTPUT_DIR/summary.md"
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
echo -e "${GREEN}Role chain execution complete!${NC}"
echo -e "${BLUE}Results saved to: ${OUTPUT_DIR}${NC}"

# Determine category and organize output
echo -e "${BLUE}Organizing output...${NC}"

# Technical solution always goes to technical_solutions category
CATEGORY="technical_solutions"
log_info "Categorized as: $CATEGORY"

# Create a symlink in the category directory
CATEGORY_DIR="$MIRADOR_OUTPUTS_DIR/$CATEGORY"
mkdir -p "$CATEGORY_DIR"

# Create symlink with appropriate permissions
ln -sf "$OUTPUT_DIR" "$CATEGORY_DIR/$(basename "$OUTPUT_DIR")"
log_info "Created symlink in $CATEGORY_DIR"

echo -e "${GREEN}Output organized under category: ${CATEGORY}${NC}"

# Ask to view summary
echo -e "${BLUE}Would you like to view the summary? (y/n)${NC}"
read -r view_summary
if [[ "$view_summary" == "y" ]]; then
  less "$OUTPUT_DIR/summary.md"
fi

log_info "Role chain execution and organization complete"
exit 0