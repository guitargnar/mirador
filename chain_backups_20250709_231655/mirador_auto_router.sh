#!/bin/bash
# Mirador Auto Router - Automatic chain and model selection

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
RESET='\033[0m'

# Check arguments
if [ $# -lt 1 ]; then
    echo "Usage: $0 \"your query\" [options]"
    echo ""
    echo "Options:"
    echo "  --fast        Prioritize speed"
    echo "  --quality     Prioritize quality"
    echo "  --verbose     Show routing decisions"
    echo ""
    echo "The auto router will analyze your query and select:"
    echo "  - Optimal chain type"
    echo "  - Best model combination"
    echo "  - Appropriate parameters"
    exit 1
fi

QUERY=$1
shift

# Parse options
FAST_MODE=false
QUALITY_MODE=false
VERBOSE=false

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
        --verbose)
            VERBOSE=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

echo -e "${PURPLE}🤖 Mirador Auto Router${RESET}"
echo -e "${YELLOW}Analyzing query...${RESET}"
echo ""

# Use Python model selector to analyze query
ANALYSIS=$(python3 select_optimal_model.py "$QUERY" 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$ANALYSIS" ]; then
    echo -e "${YELLOW}Warning: Could not run advanced analysis. Using pattern matching.${RESET}"
    ANALYSIS="{\"query_analysis\": {\"type\": \"general\"}}"
fi

# Extract query type
QUERY_TYPE=$(echo "$ANALYSIS" | jq -r '.query_analysis.type // "general"')

if [ "$VERBOSE" = true ]; then
    echo -e "${BLUE}Query Analysis:${RESET}"
    echo "$ANALYSIS" | jq .
    echo ""
fi

# Route to appropriate chain based on analysis
route_query() {
    local query="$1"
    local query_type="$2"
    
    # Check for specific patterns first
    if [[ "$query" =~ (document|file|pdf|analyze.*text|review.*code) ]]; then
        echo "rag"
        return
    fi
    
    if [[ "$query" =~ (translate|language|cultural|international|global) ]]; then
        echo "hybrid:cultural"
        return
    fi
    
    if [[ "$query" =~ (code|programming|debug|refactor|architecture) ]]; then
        echo "hybrid:technical"
        return
    fi
    
    if [[ "$query" =~ (creative|story|content|write|compose) ]]; then
        echo "hybrid:creative"
        return
    fi
    
    if [[ "$query" =~ (research|paper|study|literature|academic) ]]; then
        echo "hybrid:research"
        return
    fi
    
    if [[ "$query" =~ (decide|choose|recommend|should.*I|option) ]]; then
        echo "hybrid:decision"
        return
    fi
    
    # Use query type from analysis
    case "$query_type" in
        "quick")
            echo "rapid_decision"
            ;;
        "analytical")
            echo "deep_analysis"
            ;;
        "multilingual")
            echo "global_insight"
            ;;
        "document")
            echo "rag"
            ;;
        "complex")
            echo "hybrid:synthesis"
            ;;
        *)
            # Default routing based on general patterns
            if [[ "$query" =~ (financial|money|investment|budget) ]]; then
                echo "business_acceleration"
            elif [[ "$query" =~ (health|wellness|exercise|lifestyle) ]]; then
                echo "life_optimization"
            elif [[ "$query" =~ (relationship|communication|family|social) ]]; then
                echo "relationship_harmony"
            else
                echo "strategic_synthesis"
            fi
            ;;
    esac
}

# Determine chain type
CHAIN_ROUTE=$(route_query "$QUERY" "$QUERY_TYPE")

echo -e "${GREEN}Selected route: $CHAIN_ROUTE${RESET}"

# Execute appropriate chain
case "$CHAIN_ROUTE" in
    rag)
        echo -e "${BLUE}Routing to RAG chain for document analysis...${RESET}"
        ./bin/mirador_rag_chain.sh document "$QUERY"
        ;;
    
    hybrid:*)
        HYBRID_TYPE=${CHAIN_ROUTE#hybrid:}
        echo -e "${BLUE}Routing to hybrid chain: $HYBRID_TYPE...${RESET}"
        OPTIONS=""
        [ "$FAST_MODE" = true ] && OPTIONS="$OPTIONS --fast"
        [ "$QUALITY_MODE" = true ] && OPTIONS="$OPTIONS --quality"
        ./bin/mirador_hybrid_chains.sh "$HYBRID_TYPE" "$QUERY" $OPTIONS
        ;;
    
    rapid_decision|deep_analysis|global_insight)
        echo -e "${BLUE}Routing to optimized chain: $CHAIN_ROUTE...${RESET}"
        ./bin/mirador_universal_runner_v3_optimized.sh "$CHAIN_ROUTE" "$QUERY"
        ;;
    
    *)
        echo -e "${BLUE}Routing to universal chain: $CHAIN_ROUTE...${RESET}"
        # Try v3 first, fallback to v2 if not available
        if [ -f "./bin/mirador_universal_runner_v3_optimized.sh" ]; then
            ./bin/mirador_universal_runner_v3_optimized.sh "$CHAIN_ROUTE" "$QUERY"
        elif [ -f "./mirador_universal_runner_v2.sh" ]; then
            ./mirador_universal_runner_v2.sh "$CHAIN_ROUTE" "$QUERY"
        else
            echo -e "${YELLOW}Warning: No universal runner found. Using mirador-smart-v2 fallback.${RESET}"
            ./mirador-smart-v2 "$QUERY"
        fi
        ;;
esac

echo ""
echo -e "${GREEN}✅ Auto-routed execution complete!${RESET}"