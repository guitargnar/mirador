#!/bin/bash

# Mirador Universal Chain Runner - Multi-faceted AI orchestration
# Usage: ./mirador_universal_runner.sh <chain_type> "Your prompt"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

if [ $# -lt 2 ]; then
    echo -e "${RED}Usage: $0 <chain_type> \"Your prompt\"${RESET}"
    echo -e "\n${YELLOW}Available Universal Chains:${RESET}"
    echo "  - life_optimization      : Holistic life improvement across all domains"
    echo "  - business_acceleration  : Startup and business growth strategies"
    echo "  - creative_breakthrough  : Unlock creative potential and artistic growth"
    echo "  - relationship_harmony   : Optimize personal and professional relationships"
    echo "  - technical_mastery      : AI, automation, and technical project success"
    echo "  - strategic_synthesis    : Comprehensive multi-domain analysis"
    echo -e "\n${BLUE}Example:${RESET}"
    echo "  $0 life_optimization \"How do I balance business growth, creative fulfillment, and relationship health?\""
    exit 1
fi

CHAIN_TYPE=$1
PROMPT=$2

# Map chain types to model sequences
case $CHAIN_TYPE in
    "life_optimization")
        MODELS="matthew_context_provider_v5_complete universal_strategy_architect practical_implementer"
        ;;
    "business_acceleration")
        MODELS="universal_strategy_architect matthew_context_provider_v5_complete practical_implementer"
        ;;
    "creative_breakthrough")
        MODELS="creative_catalyst matthew_context_provider_v5_complete practical_implementer"
        ;;
    "relationship_harmony")
        MODELS="matthew_context_provider_v5_complete universal_strategy_architect practical_implementer"
        ;;
    "technical_mastery")
        MODELS="matthew_context_provider_v5_complete universal_strategy_architect practical_implementer"
        ;;
    "strategic_synthesis")
        MODELS="matthew_context_provider_v5_complete universal_strategy_architect creative_catalyst practical_implementer"
        ;;
    *)
        echo -e "${RED}Unknown chain type: $CHAIN_TYPE${RESET}"
        exit 1
        ;;
esac

# Display chain information
echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║         Mirador Universal AI Chain Runner - v2.0             ║${RESET}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${RESET}"
echo -e "\n${YELLOW}Chain Type:${RESET} $CHAIN_TYPE"
echo -e "${YELLOW}Models:${RESET} $MODELS"
echo -e "${YELLOW}Prompt:${RESET} $PROMPT\n"

# Create output directory
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="outputs/universal_${CHAIN_TYPE}_${TIMESTAMP}"
mkdir -p "$OUTPUT_DIR"

# Save initial prompt
echo "$PROMPT" > "$OUTPUT_DIR/prompt.txt"
echo "$MODELS" > "$OUTPUT_DIR/models.txt"

# Initialize context
CURRENT_CONTEXT="$PROMPT"

# Run the chain
MODEL_ARRAY=($MODELS)
TOTAL_MODELS=${#MODEL_ARRAY[@]}

for i in "${!MODEL_ARRAY[@]}"; do
    MODEL=${MODEL_ARRAY[$i]}
    STEP=$((i + 1))
    
    echo -e "\n${GREEN}[Step $STEP/$TOTAL_MODELS]${RESET} Running ${YELLOW}$MODEL${RESET}..."
    
    # Create step-specific prompt
    if [ $i -eq 0 ]; then
        STEP_PROMPT="$CURRENT_CONTEXT"
    else
        STEP_PROMPT="Building on the previous analysis:

$CURRENT_CONTEXT

Please provide your specialized perspective and detailed recommendations."
    fi
    
    # Save step prompt
    echo "$STEP_PROMPT" > "$OUTPUT_DIR/step${STEP}_prompt.txt"
    
    # Run the model
    echo -e "${BLUE}Processing with optimized parameters...${RESET}"
    RESPONSE=$(echo "$STEP_PROMPT" | timeout 120 ollama run "$MODEL" 2>/dev/null)
    
    if [ $? -eq 0 ] && [ -n "$RESPONSE" ]; then
        echo "$RESPONSE" > "$OUTPUT_DIR/step${STEP}_output.txt"
        CURRENT_CONTEXT="$RESPONSE"
        echo -e "${GREEN}✓ Completed${RESET}"
        
        # Show preview
        SNIPPET=$(echo "$RESPONSE" | head -n 2)
        echo -e "${BLUE}Preview:${RESET} $SNIPPET..."
    else
        echo -e "${RED}✗ Error running $MODEL${RESET}"
        exit 1
    fi
done

# Create final summary
echo -e "\n${GREEN}Creating comprehensive summary...${RESET}"
cat > "$OUTPUT_DIR/summary.md" << EOF
# Mirador Universal Chain Execution Summary

**Chain Type:** $CHAIN_TYPE  
**Date:** $(date '+%Y-%m-%d %H:%M:%S')  
**Models Used:** $MODELS
**Optimization:** Apple Silicon Metal acceleration, quality-focused parameters

## Original Prompt
$PROMPT

## Final Strategic Output
$CURRENT_CONTEXT

## Execution Details
- Output Directory: $OUTPUT_DIR
- Total Steps: $TOTAL_MODELS
- Status: Completed Successfully
- Model Parameters: temperature=0.7, num_predict=2048, Metal acceleration enabled
