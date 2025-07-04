#!/usr/bin/env bash
# Mirador Visualization Utilities
# Provides progress visualization for chain execution

# Initialize the environment if not already done
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$( cd "$SCRIPT_DIR/../.." && pwd )"
source "$ROOT_DIR/src/utils/init.sh"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Progress bar characters
BAR_CHAR="="
BAR_EMPTY=" "
BAR_PREFIX="["
BAR_SUFFIX="]"
BAR_SIZE=30

# Display a progress bar
# Usage: show_progress_bar <current> <total> [prefix] [suffix]
show_progress_bar() {
  local current=$1
  local total=$2
  local prefix="${3:-Progress}"
  local suffix="${4:-Complete}"
  
  # Calculate percentage and number of filled/empty slots
  local percent=$((current * 100 / total))
  local filled=$((current * BAR_SIZE / total))
  local empty=$((BAR_SIZE - filled))
  
  # Build the progress bar
  progress=""
  progress+="${BAR_PREFIX}"
  
  # Add filled portion
  for ((i=0; i<filled; i++)); do
    progress+="${BAR_CHAR}"
  done
  
  # Add empty portion
  for ((i=0; i<empty; i++)); do
    progress+="${BAR_EMPTY}"
  done
  
  progress+="${BAR_SUFFIX}"
  
  # Print the progress bar
  echo -ne "\r${prefix} ${progress} ${percent}% ${suffix}"
  
  # Add newline if complete
  if [ "$current" -eq "$total" ]; then
    echo ""
  fi
}

# Show specialist transition animation
# Usage: show_transition <from_model> <to_model>
show_transition() {
  local from_model=$1
  local to_model=$2
  
  echo -e "\n${YELLOW}${BOLD}Transition:${NC} ${BLUE}$from_model${NC} → ${MAGENTA}$to_model${NC}"
  
  # Show simple animation
  for ((i=0; i<20; i++)); do
    if (( i % 4 == 0 )); then
      echo -ne "\r○○○○"
    elif (( i % 4 == 1 )); then
      echo -ne "\r●○○○"
    elif (( i % 4 == 2 )); then
      echo -ne "\r●●○○"
    elif (( i % 4 == 3 )); then
      echo -ne "\r●●●○"
    fi
    sleep 0.1
  done
  echo -ne "\r●●●●"
  echo -e "\n"
}

# Show specialist start
# Usage: show_specialist_start <model_name> <step_number> <total_steps>
show_specialist_start() {
  local model=$1
  local step=$2
  local total=$3
  
  echo -e "\n${CYAN}${BOLD}Step $step/$total:${NC} Running ${YELLOW}$model${NC}"
  echo -e "${BLUE}${BOLD}Specialist Role:${NC} ${model}"
  
  # Show thinking animation
  echo -ne "${CYAN}Initializing${NC}"
  for ((i=0; i<3; i++)); do
    sleep 0.3
    echo -ne "."
  done
  echo -e "\n"
}

# Show specialist thinking
# Usage: show_specialist_thinking <model_name>
show_specialist_thinking() {
  local model=$1
  
  echo -ne "${YELLOW}$model${NC} is thinking"
  for ((i=0; i<5; i++)); do
    sleep 0.3
    echo -ne "."
  done
  echo -e "\n"
}

# Compare and visualize differences between steps
# Usage: show_diff <previous_output> <current_output> [model_name]
show_diff() {
  local prev_file=$1
  local curr_file=$2
  local model=${3:-"Specialist"}
  
  echo -e "\n${MAGENTA}${BOLD}Contributions from ${model}:${NC}"
  
  if command -v diff &> /dev/null && command -v colordiff &> /dev/null; then
    # Use colordiff if available
    echo -e "${CYAN}--- Changes made ---${NC}"
    colordiff -u "$prev_file" "$curr_file" | tail -n +3 | grep -E "^(\+|\-)" | head -n 20
    
    # Show number of lines changed
    local added=$(diff -u "$prev_file" "$curr_file" | grep -c "^+")
    local removed=$(diff -u "$prev_file" "$curr_file" | grep -c "^-")
    echo -e "\n${GREEN}Added $added lines${NC}, ${RED}removed $removed lines${NC}\n"
  else
    # Simple fallback without diff
    echo -e "${YELLOW}Diff tool not available, showing summary instead${NC}"
    echo -e "${BLUE}Previous length:${NC} $(wc -l < "$prev_file") lines"
    echo -e "${BLUE}Current length:${NC} $(wc -l < "$curr_file") lines"
  fi
}

# Track elapsed time for a step
# Usage: start_timer
start_timer() {
  STEP_START_TIME=$(date +%s)
  echo "STEP_START_TIME=$STEP_START_TIME" > /tmp/mirador_step_timer
}

# Get elapsed time since start_timer was called
# Usage: get_elapsed_time
get_elapsed_time() {
  if [ -f /tmp/mirador_step_timer ]; then
    source /tmp/mirador_step_timer
    local current_time=$(date +%s)
    local elapsed=$((current_time - STEP_START_TIME))
    echo $elapsed
  else
    echo "0"
  fi
}

# Format seconds as MM:SS
# Usage: format_time <seconds>
format_time() {
  local seconds=$1
  local minutes=$((seconds / 60))
  local remaining_seconds=$((seconds % 60))
  printf "%02d:%02d" $minutes $remaining_seconds
}

# Show step completion with elapsed time
# Usage: show_step_completion <model_name>
show_step_completion() {
  local model=$1
  local elapsed=$(get_elapsed_time)
  local formatted_time=$(format_time $elapsed)
  
  echo -e "\n${GREEN}${BOLD}Completed:${NC} ${YELLOW}$model${NC} (${BLUE}$formatted_time${NC})"
}

# Clean up temporary files
cleanup_visualization() {
  rm -f /tmp/mirador_step_timer
}

# Track chain start time
start_chain_timer() {
  CHAIN_START_TIME=$(date +%s)
  echo "CHAIN_START_TIME=$CHAIN_START_TIME" > /tmp/mirador_chain_timer
}

# Calculate total chain execution time
get_chain_elapsed_time() {
  if [ -f /tmp/mirador_chain_timer ]; then
    source /tmp/mirador_chain_timer
    local current_time=$(date +%s)
    local elapsed=$((current_time - CHAIN_START_TIME))
    echo $elapsed
  else
    echo "0"
  fi
}

# Show chain completion with total time
show_chain_completion() {
  local elapsed=$(get_chain_elapsed_time)
  local formatted_time=$(format_time $elapsed)
  
  echo -e "\n${GREEN}${BOLD}Chain Execution Complete${NC} (Total time: ${BLUE}$formatted_time${NC})"
  
  # Clean up
  rm -f /tmp/mirador_chain_timer
}

# Test visualization utilities (when run directly)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "Testing visualization utilities..."
  
  # Test progress bar
  echo "Testing progress bar:"
  for i in {0..10}; do
    show_progress_bar $i 10 "Processing" "of task complete"
    sleep 0.2
  done
  
  # Test transition
  show_transition "master_coder" "code_reviewer_fix"
  
  # Test specialist start/thinking
  show_specialist_start "creative_entrepreneur" 2 3
  show_specialist_thinking "creative_entrepreneur"
  
  # Test timer
  start_timer
  echo "Waiting 3 seconds..."
  sleep 3
  show_step_completion "creative_entrepreneur"
  
  echo "Tests complete!"
fi