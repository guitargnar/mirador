#!/bin/bash

# Humana Chain Runner - Optimized for Humana-specific AI orchestration
# Usage: ./humana_chain_runner.sh <chain_name> "Your prompt"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

# Check if we have the required arguments
if [ $# -lt 2 ]; then
    echo -e "${RED}Usage: $0 <chain_name> \"Your prompt\"${RESET}"
    echo -e "\n${YELLOW}Available chains:${RESET}"
    echo "  - innovation_discovery    : Find and scale innovation opportunities"
    echo "  - ai_leadership          : Build AI leadership positioning"
    echo "  - corporate_nav          : Navigate corporate dynamics"
    echo "  - solution_design        : Design implementable solutions"
    echo "  - advocates_strategy     : Maximize Advocates Program impact"
    echo "  - quick_win             : Generate quick wins"
    echo "  - strategic_synthesis    : Comprehensive strategic analysis"
    echo -e "\n${BLUE}Example:${RESET}"
    echo "  $0 innovation_discovery \"How can we improve the vendor onboarding process?\""
    exit 1
fi

CHAIN_NAME=$1
PROMPT=$2

# Map short names to full model chains
case $CHAIN_NAME in
    "innovation_discovery")
        MODELS="matthew_context_provider_v3 humana_innovation_catalyst solution_architect enhanced_agent_enforcer"
        ;;
    "ai_leadership")
        MODELS="matthew_context_provider_v3 ai_leadership_strategist enhanced_agent_enforcer"
        ;;
    "corporate_nav")
        MODELS="matthew_context_provider_v3 humana_politics_navigator enhanced_agent_enforcer"
        ;;
    "solution_design")
        MODELS="humana_innovation_catalyst solution_architect enhanced_agent_enforcer"
        ;;
    "advocates_strategy")
        MODELS="matthew_context_provider_v3 advocates_meeting_optimizer_v2 ai_leadership_strategist enhanced_agent_enforcer"
        ;;
    "quick_win")
        MODELS="humana_innovation_catalyst solution_architect"
        ;;
    "strategic_synthesis")
        MODELS="matthew_context_provider_v3 humana_innovation_catalyst ai_leadership_strategist humana_politics_navigator enhanced_agent_enforcer"
        ;;
    *)
        echo -e "${RED}Unknown chain: $CHAIN_NAME${RESET}"
        exit 1
        ;;
esac

# Display chain information
echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║           Humana AI Chain Runner - Mirador System            ║${RESET}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${RESET}"
echo -e "\n${YELLOW}Chain:${RESET} $CHAIN_NAME"
echo -e "${YELLOW}Models:${RESET} $MODELS"
echo -e "${YELLOW}Prompt:${RESET} $PROMPT\n"

# Create output directory
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="$HOME/ai_framework_git/outputs/humana_${CHAIN_NAME}_${TIMESTAMP}"
mkdir -p "$OUTPUT_DIR"

# Save initial prompt
echo "$PROMPT" > "$OUTPUT_DIR/prompt.txt"
echo "$MODELS" > "$OUTPUT_DIR/models.txt"

# Initialize context with the original prompt
CURRENT_CONTEXT="$PROMPT"

# Run the chain
MODEL_ARRAY=($MODELS)
TOTAL_MODELS=${#MODEL_ARRAY[@]}

for i in "${!MODEL_ARRAY[@]}"; do
    MODEL=${MODEL_ARRAY[$i]}
    STEP=$((i + 1))
    
    echo -e "\n${GREEN}[Step $STEP/$TOTAL_MODELS]${RESET} Running ${YELLOW}$MODEL${RESET}..."
    
    # Create step-specific prompt based on model role
    if [ $i -eq 0 ]; then
        # First model gets original prompt
        STEP_PROMPT="$CURRENT_CONTEXT"
    else
        # Subsequent models build on previous output
        STEP_PROMPT="Based on the previous analysis:

$CURRENT_CONTEXT

Please provide your specialized perspective and recommendations."
    fi
    
    # Save step prompt
    echo "$STEP_PROMPT" > "$OUTPUT_DIR/step${STEP}_prompt.txt"
    
    # Run the model and capture output
    echo -e "${BLUE}Processing...${RESET}"
    RESPONSE=$(echo "$STEP_PROMPT" | ollama run "$MODEL" 2>/dev/null)
    
    if [ $? -eq 0 ]; then
        # Save step output
        echo "$RESPONSE" > "$OUTPUT_DIR/step${STEP}_output.txt"
        
        # Update context for next model
        CURRENT_CONTEXT="$RESPONSE"
        
        echo -e "${GREEN}✓ Completed${RESET}"
        
        # Show snippet of response
        SNIPPET=$(echo "$RESPONSE" | head -n 3)
        echo -e "${BLUE}Preview:${RESET} $SNIPPET..."
    else
        echo -e "${RED}✗ Error running $MODEL${RESET}"
        exit 1
    fi
done

# Create final summary
echo -e "\n${GREEN}Creating final summary...${RESET}"
cat > "$OUTPUT_DIR/summary.md" << EOF
# Humana Chain Execution Summary

**Chain:** $CHAIN_NAME  
**Date:** $(date '+%Y-%m-%d %H:%M:%S')  
**Models Used:** $MODELS

## Original Prompt
$PROMPT

## Final Output
$CURRENT_CONTEXT

## Execution Details
- Output Directory: $OUTPUT_DIR
- Total Steps: $TOTAL_MODELS
- Status: Completed Successfully
EOF

echo -e "\n${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║                    Chain Execution Complete!                  ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
echo -e "\n${YELLOW}Results saved to:${RESET} $OUTPUT_DIR"
echo -e "${YELLOW}Summary:${RESET} $OUTPUT_DIR/summary.md"

# Display final output
echo -e "\n${BLUE}Final Strategic Output:${RESET}"
echo "────────────────────────────────────────────────────────────────"
tail -n 50 "$OUTPUT_DIR/step${TOTAL_MODELS}_output.txt"