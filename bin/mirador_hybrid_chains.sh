#!/bin/bash
# Mirador Hybrid Chains - Combining multiple base LLMs for optimal results

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
RESET='\033[0m'

# Check arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <chain_type> <prompt> [options]"
    echo ""
    echo "Hybrid chain types:"
    echo "  synthesis     - Multi-LLM synthesis (Llama + Gemma + Qwen)"
    echo "  research      - Research chain (Command-R + Gemma + Mistral)"
    echo "  creative      - Creative chain (Llama + Phi + Mistral)"
    echo "  technical     - Technical chain (DeepSeek + Command-R + Gemma)"
    echo "  decision      - Decision chain (Phi + Gemma + Llama)"
    echo "  cultural      - Cultural chain (Qwen + Gemma + Command-R)"
    echo ""
    echo "Options:"
    echo "  --fast        Use optimized models for speed"
    echo "  --quality     Prioritize quality over speed"
    echo "  --parallel    Run models in parallel (experimental)"
    exit 1
fi

CHAIN_TYPE=$1
PROMPT=$2
shift 2

# Parse options
FAST_MODE=false
QUALITY_MODE=false
PARALLEL_MODE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --fast)
            FAST_MODE=true
            shift
            ;;
        --quality)
            QUALITY_MODE=true
            shift
            ;;
        --parallel)
            PARALLEL_MODE=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Create output directory
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="outputs/hybrid_${CHAIN_TYPE}_${TIMESTAMP}"
mkdir -p "$OUTPUT_DIR"

# Select models based on chain type and options
case "$CHAIN_TYPE" in
    "synthesis")
        if [ "$FAST_MODE" = true ]; then
            MODELS=(
                "matthew_context_provider_v6_complete:latest"
                "llama3.2:3b"                    # Llama perspective
                "gemma2_fast:latest"             # Gemma perspective
                "qwen2_fast:latest"              # Qwen perspective
                "cross_model_synthesizer:latest" # Synthesis
            )
        else
            MODELS=(
                "matthew_context_provider_v6_complete:latest"
                "universal_strategy_architect:latest"  # Llama-based
                "analytical_expert_gemma:latest"       # Gemma-based
                "multilingual_assistant_qwen:latest"   # Qwen-based
                "cross_model_synthesizer:latest"       # Final synthesis
            )
        fi
        ;;
    
    "research")
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "command_r_rag_specialist:latest"    # Document analysis
            "analytical_expert_gemma:latest"     # Deep reasoning
            "mistral:latest"                     # Additional perspective
            "universal_strategy_architect:latest" # Synthesis
        )
        ;;
    
    "creative")
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "creative_catalyst:latest"           # Llama-based creativity
            "speed_optimizer_phi:latest"         # Quick ideation
            "mistral:latest"                     # European perspective
            "digital_storyteller:latest"         # Final narrative
        )
        ;;
    
    "technical")
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "code_reviewer:latest"               # DeepSeek code analysis
            "command_r_code_analyst:latest"      # Command-R code understanding
            "analytical_expert_gemma:latest"     # Technical reasoning
            "solution_architect:latest"          # Architecture design
        )
        ;;
    
    "decision")
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "speed_optimizer_phi:latest"         # Quick analysis
            "analytical_expert_gemma:latest"     # Deep reasoning
            "practical_implementer:latest"       # Practical perspective
            "action_crystallizer:latest"         # Action items
        )
        ;;
    
    "cultural")
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "multilingual_assistant_qwen:latest" # Cultural understanding
            "analytical_expert_gemma:latest"     # Analysis
            "command_r_rag_specialist:latest"    # Context integration
            "engagement_optimizer:latest"        # Communication strategy
        )
        ;;
    
    *)
        echo -e "${RED}Invalid chain type: $CHAIN_TYPE${RESET}"
        exit 1
        ;;
esac

echo -e "${PURPLE}🔀 Hybrid Chain: ${CHAIN_TYPE}${RESET}"
echo -e "${GREEN}Models: ${MODELS[*]}${RESET}"
echo -e "${YELLOW}Options: Fast=$FAST_MODE, Quality=$QUALITY_MODE, Parallel=$PARALLEL_MODE${RESET}"
echo ""

# Function to run model
run_model() {
    local model=$1
    local input=$2
    local output_file=$3
    
    echo "$input" | ollama run "$model" 2>/dev/null > "$output_file"
}

# Initialize context
CONTEXT=""
FULL_OUTPUT=""

# Run models
if [ "$PARALLEL_MODE" = true ]; then
    echo -e "${PURPLE}Running models in parallel...${RESET}"
    
    # First model (context provider) must run first
    echo -e "${BLUE}Running ${MODELS[0]}...${RESET}"
    CONTEXT=$(echo "$PROMPT" | ollama run "${MODELS[0]}" 2>/dev/null)
    echo "$CONTEXT" > "$OUTPUT_DIR/response_1_${MODELS[0]//:/_}.md"
    
    # Run remaining models in parallel
    for i in $(seq 1 $((${#MODELS[@]} - 1))); do
        MODEL="${MODELS[$i]}"
        echo -e "${BLUE}Launching $MODEL in background...${RESET}"
        
        INPUT="Original request: $PROMPT

Context from analysis:
$CONTEXT

Please add your unique perspective based on your specialized training."
        
        run_model "$MODEL" "$INPUT" "$OUTPUT_DIR/response_$(($i + 1))_${MODEL//:/_}.md" &
    done
    
    # Wait for all background jobs
    wait
    echo -e "${GREEN}All models completed!${RESET}"
    
    # Collect outputs
    for i in $(seq 1 $((${#MODELS[@]} - 1))); do
        MODEL="${MODELS[$i]}"
        OUTPUT=$(cat "$OUTPUT_DIR/response_$(($i + 1))_${MODEL//:/_}.md")
        FULL_OUTPUT="$FULL_OUTPUT

## Model $(($i + 1)): $MODEL

$OUTPUT"
    done
    
else
    # Sequential execution
    for i in "${!MODELS[@]}"; do
        MODEL="${MODELS[$i]}"
        echo -e "${BLUE}Running $MODEL ($(($i + 1))/${#MODELS[@]})...${RESET}"
        
        # Prepare input
        if [ $i -eq 0 ]; then
            INPUT="$PROMPT"
        else
            INPUT="Original request: $PROMPT

Previous analysis from diverse AI models:
$CONTEXT

Please add your unique perspective based on your specialized training and base model."
        fi
        
        # Run model
        OUTPUT=$(echo "$INPUT" | ollama run "$MODEL" 2>/dev/null)
        
        # Save output
        echo "$OUTPUT" > "$OUTPUT_DIR/response_$(($i + 1))_${MODEL//:/_}.md"
        
        # Update context
        CONTEXT="$CONTEXT

=== $MODEL (Base: $(get_base_llm $MODEL)) ===
$OUTPUT"
        
        FULL_OUTPUT="$FULL_OUTPUT

## Model $(($i + 1)): $MODEL

$OUTPUT"
    done
fi

# Function to identify base LLM
get_base_llm() {
    local model=$1
    case "$model" in
        *llama*|*matthew*|*strategic*|*practical*|*creative*)
            echo "Llama"
            ;;
        *gemma*|*analytical*)
            echo "Gemma"
            ;;
        *qwen*|*multilingual*)
            echo "Qwen"
            ;;
        *phi*|*speed*)
            echo "Phi"
            ;;
        *command*|*rag*|*code_analyst*)
            echo "Command-R"
            ;;
        *mistral*)
            echo "Mistral"
            ;;
        *deepseek*|*code_reviewer*)
            echo "DeepSeek"
            ;;
        *)
            echo "Unknown"
            ;;
    esac
}

# Generate synthesis report
echo -e "${PURPLE}Generating hybrid synthesis report...${RESET}"

cat > "$OUTPUT_DIR/hybrid_synthesis.md" << EOMD
# Hybrid Chain Analysis Report

**Chain Type**: $CHAIN_TYPE
**Timestamp**: $(date)
**Base LLMs Used**: $(for model in "${MODELS[@]}"; do echo -n "$(get_base_llm $model) "; done | tr ' ' '\n' | sort -u | tr '\n' ' ')

## Query
$PROMPT

## Model Diversity Analysis

This hybrid chain leveraged the following AI models:
$(for i in "${!MODELS[@]}"; do
    echo "- **${MODELS[$i]}** (Base: $(get_base_llm ${MODELS[$i]}))"
done)

## Synthesis

### Key Insights by Model Type

#### Llama-based Models
$(echo "$FULL_OUTPUT" | grep -A 20 "matthew_context\|strategic\|practical\|creative" | grep -E "^[-•*]|^[0-9]\." | head -10)

#### Gemma-based Models  
$(echo "$FULL_OUTPUT" | grep -A 20 "gemma\|analytical" | grep -E "^[-•*]|^[0-9]\." | head -10)

#### Other Diverse Models
$(echo "$FULL_OUTPUT" | grep -A 20 "qwen\|phi\|command\|mistral\|deepseek" | grep -E "^[-•*]|^[0-9]\." | head -10)

## Full Analysis

$FULL_OUTPUT

---
*Generated by Mirador Hybrid Chains - Leveraging model diversity for comprehensive insights*
EOMD

# Display summary
echo ""
echo -e "${GREEN}✅ Hybrid chain complete!${RESET}"
echo ""
echo "Model diversity achieved:"
for model in "${MODELS[@]}"; do
    echo "  - $model ($(get_base_llm $model))"
done | sort -k3 -u
echo ""
echo -e "${GREEN}Results saved to: $OUTPUT_DIR/hybrid_synthesis.md${RESET}"

# Save metadata
cat > "$OUTPUT_DIR/metadata.json" << EOJSON
{
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "chain_type": "$CHAIN_TYPE",
    "models": $(echo "${MODELS[@]}" | jq -R -s -c 'split(" ")'),
    "base_llms": $(for model in "${MODELS[@]}"; do echo -n "\"$(get_base_llm $model)\" "; done | jq -s -c .),
    "options": {
        "fast_mode": $FAST_MODE,
        "quality_mode": $QUALITY_MODE,
        "parallel_mode": $PARALLEL_MODE
    },
    "prompt": $(echo "$PROMPT" | jq -R -s -c .)
}
EOJSON