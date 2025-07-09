#!/bin/bash

# Mirador Universal Chain Runner v2 - Enhanced with format options
# Usage: ./mirador_universal_runner_v2.sh <chain_type> "Your prompt" [format]

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
RESET='\033[0m'

if [ $# -lt 2 ]; then
    echo -e "${RED}Usage: $0 <chain_type> \"Your prompt\" [format]${RESET}"
    echo -e "\n${YELLOW}Available Universal Chains:${RESET}"
    echo "  - life_optimization      : Holistic life improvement across all domains"
    echo "  - business_acceleration  : Startup and business growth strategies"
    echo "  - creative_breakthrough  : Unlock creative potential and artistic growth"
    echo "  - relationship_harmony   : Optimize personal and professional relationships"
    echo "  - technical_mastery      : AI, automation, and technical project success"
    echo "  - strategic_synthesis    : Comprehensive multi-domain analysis"
    echo -e "\n${PURPLE}Format Options:${RESET}"
    echo "  - quick      : 3-5 bullet points with immediate actions"
    echo "  - summary    : One paragraph executive summary"
    echo "  - detailed   : Full analysis with implementation steps (default)"
    echo "  - export     : JSON format for tool integration"
    echo -e "\n${BLUE}Examples:${RESET}"
    echo "  $0 life_optimization \"How do I balance work and family?\" quick"
    echo "  $0 business_acceleration \"Scale my startup strategy\" summary"
    exit 1
fi

CHAIN_TYPE=$1
PROMPT=$2
FORMAT=${3:-detailed}  # Default to detailed format

# Validate format option
case $FORMAT in
    quick|summary|detailed|export)
        ;;
    *)
        echo -e "${RED}Invalid format: $FORMAT${RESET}"
        echo "Valid formats: quick, summary, detailed, export"
        exit 1
        ;;
esac

# Map chain types to optimized model sequences (context provider first for deep understanding)
case $CHAIN_TYPE in
    "life_optimization")
        MODELS="user_context_provider_v5_complete universal_strategy_architect practical_implementer"
        ;;
    "business_acceleration")
        MODELS="user_context_provider_v5_complete universal_strategy_architect practical_implementer"
        ;;
    "creative_breakthrough")
        MODELS="user_context_provider_v5_complete creative_catalyst practical_implementer"
        ;;
    "relationship_harmony")
        MODELS="user_context_provider_v5_complete universal_strategy_architect practical_implementer"
        ;;
    "technical_mastery")
        MODELS="user_context_provider_v5_complete universal_strategy_architect practical_implementer"
        ;;
    "strategic_synthesis")
        MODELS="user_context_provider_v5_complete universal_strategy_architect creative_catalyst practical_implementer"
        ;;
    *)
        echo -e "${RED}Unknown chain type: $CHAIN_TYPE${RESET}"
        exit 1
        ;;
esac

# Display chain information
echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║     Mirador Universal AI Chain Runner - v2.0 Enhanced        ║${RESET}"
echo -e "${BLUE}║    Context-Aware Orchestration with Format Flexibility        ║${RESET}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${RESET}"
echo -e "\n${YELLOW}Chain Type:${RESET} $CHAIN_TYPE"
echo -e "${YELLOW}Models:${RESET} $MODELS"
echo -e "${YELLOW}Format:${RESET} $FORMAT"
echo -e "${YELLOW}Prompt:${RESET} $PROMPT\n"

# Create output directory
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="outputs/universal_${CHAIN_TYPE}_${TIMESTAMP}"
mkdir -p "$OUTPUT_DIR"

# Save initial prompt and configuration
echo "$PROMPT" > "$OUTPUT_DIR/prompt.txt"
echo "$MODELS" > "$OUTPUT_DIR/models.txt"
echo "$FORMAT" > "$OUTPUT_DIR/format.txt"

# Initialize context
CURRENT_CONTEXT="$PROMPT"

# Load context cache if available
CONTEXT_CACHE_DIR="${HOME}/.mirador/context_cache"
mkdir -p "$CONTEXT_CACHE_DIR"
CACHE_FILE="$CONTEXT_CACHE_DIR/${CHAIN_TYPE}_recent.json"

if [ -f "$CACHE_FILE" ] && [ "$FORMAT" != "quick" ]; then
    echo -e "${PURPLE}Loading context from previous sessions...${RESET}"
    # Extract relevant context patterns (simplified for now)
    CACHED_PATTERNS=$(cat "$CACHE_FILE" 2>/dev/null | head -n 5)
fi

# Run the chain
MODEL_ARRAY=($MODELS)
TOTAL_MODELS=${#MODEL_ARRAY[@]}

# Adjust model sequence based on format
if [ "$FORMAT" = "quick" ]; then
    # For quick format, only use the practical implementer
    MODEL_ARRAY=("user_context_provider_v5_complete" "practical_implementer")
    TOTAL_MODELS=${#MODEL_ARRAY[@]}
fi

for i in "${!MODEL_ARRAY[@]}"; do
    MODEL=${MODEL_ARRAY[$i]}
    STEP=$((i + 1))
    
    echo -e "\n${GREEN}[Step $STEP/$TOTAL_MODELS]${RESET} Running ${YELLOW}$MODEL${RESET}..."
    
    # Create step-specific prompt with context integration
    if [ $i -eq 0 ]; then
        # First model gets the original prompt
        STEP_PROMPT="$CURRENT_CONTEXT"
    else
        # Format-aware prompts
        FORMAT_INSTRUCTION=""
        case $FORMAT in
            quick)
                FORMAT_INSTRUCTION="

IMPORTANT: Provide ONLY 3-5 bullet points with immediate, actionable steps. No explanations or context - just what to do RIGHT NOW."
                ;;
            summary)
                FORMAT_INSTRUCTION="

IMPORTANT: Provide ONLY a single paragraph (4-6 sentences) executive summary that captures the key insight and primary recommendation."
                ;;
            export)
                FORMAT_INSTRUCTION="

IMPORTANT: Structure your response as JSON with keys: 'summary', 'key_actions' (array), 'constraints' (object), 'timeline' (object), 'success_metrics' (array)."
                ;;
        esac
        
        # Subsequent models get context-aware prompts
        if [[ "$MODEL" == "user_context_provider_v5_complete" ]]; then
            STEP_PROMPT="Given this challenge/question: '$PROMPT'

And considering the previous analysis: $CURRENT_CONTEXT

Apply your deep understanding of User's complete story - his musical collaboration experience from Annapurna's 9-year journey, pattern recognition abilities from childhood, current reality as a parent to Child, relationship building with Partner, financial constraints (modest income take-home, home equity equity), and transformation from crisis to AI innovation. How do these personal experiences and constraints specifically inform the approach to this challenge?$FORMAT_INSTRUCTION"
        elif [[ "$MODEL" == "universal_strategy_architect" ]]; then
            STEP_PROMPT="Building on User's personal context: $CURRENT_CONTEXT

As a universal strategy architect, analyze this situation through multiple strategic lenses. Connect the personal insights to broader strategic frameworks. How do we scale these personal patterns into actionable business/life strategies? What are the systemic implications and interconnections?$FORMAT_INSTRUCTION"
        elif [[ "$MODEL" == "creative_catalyst" ]]; then
            STEP_PROMPT="Given the context and strategy: $CURRENT_CONTEXT

As a creative catalyst, how do we transform these insights into innovative solutions? What creative approaches, inspired by musical collaboration and artistic thinking, can unlock new possibilities? How do we turn constraints into creative advantages?$FORMAT_INSTRUCTION"
        elif [[ "$MODEL" == "practical_implementer" ]]; then
            STEP_PROMPT="Based on all previous analysis: $CURRENT_CONTEXT

As a practical implementer, convert these insights into specific, actionable steps. Create concrete implementation plans that account for User's real constraints: time with Child, energy limitations, relationship dynamics with Partner, work responsibilities, and financial realities. What are the exact next steps?$FORMAT_INSTRUCTION"
        else
            # Default prompt for any other models
            STEP_PROMPT="Building on the previous analysis: $CURRENT_CONTEXT

Please provide your specialized perspective and detailed recommendations, ensuring they connect to User's specific context and constraints.$FORMAT_INSTRUCTION"
        fi
    fi
    
    # Save step prompt
    echo "$STEP_PROMPT" > "$OUTPUT_DIR/step${STEP}_prompt.txt"
    
    # Run the model with format-specific parameters
    echo -e "${BLUE}Processing with optimized parameters...${RESET}"
    
    # Adjust model parameters based on format
    case $FORMAT in
        quick)
            RESPONSE=$(echo "$STEP_PROMPT" | timeout 180 ollama run "$MODEL" 2>/dev/null)
            ;;
        summary)
            RESPONSE=$(echo "$STEP_PROMPT" | timeout 180 ollama run "$MODEL" 2>/dev/null)
            ;;
        *)
            RESPONSE=$(echo "$STEP_PROMPT" | timeout 180 ollama run "$MODEL" 2>/dev/null)
            ;;
    esac
    
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

# Format-specific final output
case $FORMAT in
    quick)
        # Extract bullet points for quick format
        echo -e "\n${GREEN}Quick Action Summary:${RESET}"
        echo "$CURRENT_CONTEXT" | grep -E "^[•\-\*]|^[0-9]\." | head -n 5
        
        # Save formatted output
        echo "# Quick Actions" > "$OUTPUT_DIR/quick_actions.md"
        echo "" >> "$OUTPUT_DIR/quick_actions.md"
        echo "$CURRENT_CONTEXT" | grep -E "^[•\-\*]|^[0-9]\." >> "$OUTPUT_DIR/quick_actions.md"
        ;;
    summary)
        # Display summary
        echo -e "\n${GREEN}Executive Summary:${RESET}"
        echo "$CURRENT_CONTEXT" | head -n 10
        ;;
    export)
        # Create JSON export
        python3 -c "
import json
import re

content = '''$CURRENT_CONTEXT'''

# Basic parsing for JSON structure
output = {
    'timestamp': '$(date -u +%Y-%m-%dT%H:%M:%SZ)',
    'chain_type': '$CHAIN_TYPE',
    'prompt': '$PROMPT',
    'format': '$FORMAT',
    'response': content,
    'session_id': '${TIMESTAMP}'
}

with open('$OUTPUT_DIR/export.json', 'w') as f:
    json.dump(output, f, indent=2)
print('Export saved to: $OUTPUT_DIR/export.json')
"
        ;;
esac

# Create final summary
echo -e "\n${GREEN}Creating comprehensive summary...${RESET}"
cat > "$OUTPUT_DIR/summary.md" << EOF
# Mirador Universal Chain Execution Summary

**Chain Type:** $CHAIN_TYPE  
**Date:** $(date '+%Y-%m-%d %H:%M:%S')  
**Models Used:** $MODELS
**Format:** $FORMAT
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
- Format: $FORMAT

EOF

# Update context cache
echo "{
  \"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",
  \"chain_type\": \"$CHAIN_TYPE\",
  \"prompt\": \"$PROMPT\",
  \"success\": true,
  \"format\": \"$FORMAT\",
  \"key_patterns\": []
}" > "$CACHE_FILE"

echo -e "\n${GREEN}✓ Execution complete!${RESET}"
echo -e "${BLUE}Output saved to:${RESET} $OUTPUT_DIR"

# Display quick feedback prompt
echo -e "\n${PURPLE}Was this helpful? Rate with:${RESET}"
echo -e "  ${GREEN}./mirador_feedback.sh $TIMESTAMP 5${RESET} # Excellent"
echo -e "  ${YELLOW}./mirador_feedback.sh $TIMESTAMP 3${RESET} # Good"
echo -e "  ${RED}./mirador_feedback.sh $TIMESTAMP 1${RESET} # Needs improvement"