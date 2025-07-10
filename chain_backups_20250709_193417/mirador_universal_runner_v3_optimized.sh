#!/bin/bash
# Mirador Universal Runner v3 - Optimized with diverse models

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

# Check arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <chain_type> <prompt> [format]"
    echo ""
    echo "Chain types:"
    echo "  life_optimization    - Personal productivity & wellness"
    echo "  business_acceleration - Career & business strategy"
    echo "  creative_breakthrough - Innovation & creative work"
    echo "  relationship_harmony  - Communication & relationships"
    echo "  technical_mastery    - Technology & programming"
    echo "  strategic_synthesis  - High-level planning"
    echo "  deep_analysis       - Complex reasoning (Gemma-powered)"
    echo "  global_insight      - Multilingual & cultural (Qwen-powered)"
    echo "  rapid_decision      - Fast decisions (Phi-powered)"
    echo ""
    echo "Formats: quick, summary, detailed (default), export"
    exit 1
fi

CHAIN_TYPE=$1
PROMPT=$2
FORMAT=${3:-detailed}

# Set models based on chain type
case "$CHAIN_TYPE" in
    "life_optimization")
        # Use latest context provider only (removed duplicates)
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "health_wellness_optimizer:latest"
            "productivity_optimizer:latest"
            "action_crystallizer:latest"
        )
        ;;
    
    "business_acceleration")
        # Removed duplicate accelerators
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "ai_career_strategist:latest"
            "matthews_strategic_accelerator_v2:latest"
            "solution_architect:latest"
        )
        ;;
    
    "creative_breakthrough")
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "creative_catalyst:latest"
            "digital_storyteller:latest"
            "engagement_optimizer:latest"
        )
        ;;
    
    "relationship_harmony")
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "relationship_communication_specialist:latest"
            "life_transition_coordinator:latest"
            "action_crystallizer:latest"
        )
        ;;
    
    "technical_mastery")
        # Use specialized code models
        MODELS=(
            "matthew_context_provider_v3:latest"  # Lighter for speed
            "master_coder:latest"
            "code_reviewer:latest"  # DeepSeek-based
            "solution_architect:latest"
        )
        ;;
    
    "strategic_synthesis")
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "universal_strategy_architect:latest"
            "cross_model_synthesizer:latest"
            "optimized_decision_simplifier_v3:latest"
        )
        ;;
    
    "deep_analysis")
        # NEW: Gemma-powered deep reasoning
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "analytical_expert_gemma:latest"
            "universal_strategy_architect:latest"
            "practical_implementer:latest"
        )
        ;;
    
    "global_insight")
        # NEW: Qwen-powered multilingual
        MODELS=(
            "matthew_context_provider_v3:latest"
            "multilingual_assistant_qwen:latest"
            "engagement_optimizer:latest"
            "action_crystallizer:latest"
        )
        ;;
    
    "rapid_decision")
        # NEW: Phi-powered fast decisions
        MODELS=(
            "speed_optimizer_phi:latest"
            "matthew_context_provider_v3:latest"
            "action_crystallizer:latest"
        )
        ;;
    
    *)
        echo "Invalid chain type: $CHAIN_TYPE"
        exit 1
        ;;
esac

# Create output directory
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="outputs/universal_${CHAIN_TYPE}_${TIMESTAMP}"
mkdir -p "$OUTPUT_DIR"

echo -e "${BLUE}🚀 Running Optimized ${CHAIN_TYPE} Chain${RESET}"
echo -e "${GREEN}Models: ${MODELS[*]}${RESET}"
echo -e "${YELLOW}Format: $FORMAT${RESET}"
echo ""

# Initialize context
CONTEXT=""
FULL_OUTPUT=""

# Run through model chain
for i in "${!MODELS[@]}"; do
    MODEL="${MODELS[$i]}"
    echo -e "${BLUE}Running $MODEL ($(($i + 1))/${#MODELS[@]})...${RESET}"
    
    # Prepare input
    if [ $i -eq 0 ]; then
        INPUT="$PROMPT"
    else
        INPUT="Original request: $PROMPT

Previous analysis:
$CONTEXT

Please add your perspective and insights."
    fi
    
    # Run model and capture output
    OUTPUT=$(echo "$INPUT" | ollama run "$MODEL" 2>/dev/null)
    
    # Save individual output
    echo "$OUTPUT" > "$OUTPUT_DIR/response_$(($i + 1))_${MODEL//:/_}.md"
    
    # Update context
    CONTEXT="$CONTEXT

=== $MODEL ===
$OUTPUT"
    
    FULL_OUTPUT="$FULL_OUTPUT

## Model $(($i + 1)): $MODEL

$OUTPUT"
done

# Generate final output based on format
case "$FORMAT" in
    "quick")
        # Extract key points only
        echo "$FULL_OUTPUT" | grep -E "^[-•*]|^[0-9]\." | head -20 > "$OUTPUT_DIR/summary.md"
        cat "$OUTPUT_DIR/summary.md"
        ;;
    
    "summary")
        # First 100 lines of combined output
        echo "$FULL_OUTPUT" | head -100 > "$OUTPUT_DIR/summary.md"
        cat "$OUTPUT_DIR/summary.md"
        ;;
    
    "detailed")
        # Full output
        echo "$FULL_OUTPUT" > "$OUTPUT_DIR/full_analysis.md"
        cat "$OUTPUT_DIR/full_analysis.md"
        ;;
    
    "export")
        # Save and notify
        echo "$FULL_OUTPUT" > "$OUTPUT_DIR/full_analysis.md"
        echo -e "${GREEN}✅ Analysis exported to: $OUTPUT_DIR/full_analysis.md${RESET}"
        ;;
esac

# Save metadata
cat > "$OUTPUT_DIR/metadata.json" << EOJSON
{
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "chain_type": "$CHAIN_TYPE",
    "format": "$FORMAT",
    "models": $(echo "${MODELS[@]}" | jq -R -s -c 'split(" ")'),
    "prompt": $(echo "$PROMPT" | jq -R -s -c .)
}
EOJSON

echo -e "\n${GREEN}✅ Chain complete! Results in: $OUTPUT_DIR${RESET}"
