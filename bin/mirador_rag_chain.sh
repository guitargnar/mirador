#!/bin/bash
# Mirador RAG Chain - Document Analysis with Command-R

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

# Check arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <analysis_type> <query> [document_path]"
    echo ""
    echo "Analysis types:"
    echo "  document    - General document analysis"
    echo "  code        - Code analysis and review"
    echo "  research    - Research paper analysis"
    echo "  report      - Business report analysis"
    echo "  comparison  - Compare multiple documents"
    echo ""
    echo "Examples:"
    echo "  $0 document \"Summarize the key findings\" /path/to/document.pdf"
    echo "  $0 code \"Explain the architecture\" /path/to/codebase"
    echo "  $0 research \"What methodology was used?\" /path/to/paper.pdf"
    exit 1
fi

ANALYSIS_TYPE=$1
QUERY=$2
DOCUMENT_PATH=${3:-""}

# Create output directory
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="outputs/rag_analysis_${ANALYSIS_TYPE}_${TIMESTAMP}"
mkdir -p "$OUTPUT_DIR"

echo -e "${BLUE}🔍 Mirador RAG Chain - ${ANALYSIS_TYPE} Analysis${RESET}"
echo -e "${YELLOW}Query: $QUERY${RESET}"

# Create models if they don't exist
echo -e "${BLUE}Ensuring RAG models are available...${RESET}"
if ! ollama list | grep -q "command_r_rag_specialist:latest"; then
    echo "Creating command_r_rag_specialist model..."
    ollama create command_r_rag_specialist -f models/command_r_rag_specialist.modelfile
fi

if ! ollama list | grep -q "command_r_code_analyst:latest"; then
    echo "Creating command_r_code_analyst model..."
    ollama create command_r_code_analyst -f models/command_r_code_analyst.modelfile
fi

# Select models based on analysis type
case "$ANALYSIS_TYPE" in
    "document")
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "command_r_rag_specialist:latest"
            "analytical_expert_gemma:latest"
            "practical_implementer:latest"
        )
        ;;
    
    "code")
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "command_r_code_analyst:latest"
            "master_coder:latest"
            "solution_architect:latest"
        )
        ;;
    
    "research")
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "command_r_rag_specialist:latest"
            "analytical_expert_gemma:latest"
            "universal_strategy_architect:latest"
        )
        ;;
    
    "report")
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "command_r_rag_specialist:latest"
            "business_strategist_fast:latest"
            "action_crystallizer:latest"
        )
        ;;
    
    "comparison")
        MODELS=(
            "matthew_context_provider_v6_complete:latest"
            "command_r_rag_specialist:latest"
            "analytical_expert_gemma:latest"
            "cross_model_synthesizer:latest"
        )
        ;;
    
    *)
        echo -e "${RED}Invalid analysis type: $ANALYSIS_TYPE${RESET}"
        exit 1
        ;;
esac

echo -e "${GREEN}Models: ${MODELS[*]}${RESET}"
echo ""

# Process document if provided
DOCUMENT_CONTEXT=""
if [ -n "$DOCUMENT_PATH" ] && [ -f "$DOCUMENT_PATH" ]; then
    echo -e "${BLUE}Processing document: $DOCUMENT_PATH${RESET}"
    
    # Extract text based on file type
    case "${DOCUMENT_PATH##*.}" in
        txt|md|log)
            DOCUMENT_CONTEXT=$(head -5000 "$DOCUMENT_PATH")
            ;;
        pdf)
            if command -v pdftotext &> /dev/null; then
                DOCUMENT_CONTEXT=$(pdftotext "$DOCUMENT_PATH" - | head -5000)
            else
                echo -e "${YELLOW}Warning: pdftotext not found. Install poppler-utils for PDF support.${RESET}"
                DOCUMENT_CONTEXT="[PDF content not extracted - pdftotext required]"
            fi
            ;;
        py|js|ts|go|rs|cpp|java)
            DOCUMENT_CONTEXT=$(head -5000 "$DOCUMENT_PATH")
            ;;
        *)
            DOCUMENT_CONTEXT=$(head -5000 "$DOCUMENT_PATH" 2>/dev/null || echo "[Unable to read file]")
            ;;
    esac
    
    # Save document context
    echo "$DOCUMENT_CONTEXT" > "$OUTPUT_DIR/document_context.txt"
fi

# Initialize context
CONTEXT=""
FULL_OUTPUT=""

# Run through model chain
for i in "${!MODELS[@]}"; do
    MODEL="${MODELS[$i]}"
    echo -e "${BLUE}Running $MODEL ($(($i + 1))/${#MODELS[@]})...${RESET}"
    
    # Prepare input
    if [ $i -eq 0 ]; then
        # First model gets the raw query
        INPUT="$QUERY"
    elif [[ "$MODEL" == *"command_r"* ]] && [ -n "$DOCUMENT_CONTEXT" ]; then
        # Command-R models get document context
        INPUT="Document/Code to analyze:
$DOCUMENT_CONTEXT

Previous analysis:
$CONTEXT

Query: $QUERY"
    else
        # Other models get accumulated context
        INPUT="Original query: $QUERY

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

# Generate final analysis report
cat > "$OUTPUT_DIR/analysis_report.md" << EOMD
# RAG Analysis Report

**Type**: $ANALYSIS_TYPE
**Query**: $QUERY
**Timestamp**: $(date)
**Document**: ${DOCUMENT_PATH:-"No document provided"}

## Analysis Chain

${MODELS[@]}

## Full Analysis

$FULL_OUTPUT

## Key Findings Summary

$(echo "$FULL_OUTPUT" | grep -E "^[-•*]|^[0-9]\." | head -20)

---
*Generated by Mirador RAG Chain*
EOMD

# Display summary
echo ""
echo -e "${GREEN}✅ Analysis complete!${RESET}"
echo ""
echo "Key findings:"
grep -E "^[-•*]|^[0-9]\." "$OUTPUT_DIR/analysis_report.md" | head -10
echo ""
echo -e "${GREEN}Full report saved to: $OUTPUT_DIR/analysis_report.md${RESET}"

# Save metadata
cat > "$OUTPUT_DIR/metadata.json" << EOJSON
{
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "analysis_type": "$ANALYSIS_TYPE",
    "query": $(echo "$QUERY" | jq -R -s -c .),
    "document_path": $(echo "${DOCUMENT_PATH:-null}" | jq -R -s -c .),
    "models": $(echo "${MODELS[@]}" | jq -R -s -c 'split(" ")'),
    "output_dir": "$OUTPUT_DIR"
}
EOJSON