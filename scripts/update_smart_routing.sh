#!/bin/bash
# Updates mirador-smart-v2 to use consolidated models

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Updating Smart Routing for Consolidated Models ===${NC}"
echo ""

# Backup original
cp bin/mirador-smart-v2 bin/mirador-smart-v2.backup_$(date +%Y%m%d_%H%M%S)

# Create updated version
cat > bin/mirador-smart-v2-consolidated << 'EOF'
#!/bin/bash
# Mirador Smart Router V2 - Consolidated Models Edition
# Intelligently routes queries to optimal model chains

# Configuration
MIRADOR_HOME="${HOME}/Projects/mirador"
CONFIG_FILE="${MIRADOR_HOME}/config/model_routing_v2.yaml"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

# Function to analyze query intent
analyze_query() {
    local query="$1"
    local query_lower=$(echo "$query" | tr '[:upper:]' '[:lower:]')
    
    # Quick response patterns
    if [[ "$query_lower" =~ (quick|brief|summary|tldr|short|what.*now|immediate) ]]; then
        echo "quick"
        return
    fi
    
    # Financial patterns
    if [[ "$query_lower" =~ (money|budget|finance|salary|investment|savings|afford|cost|spend) ]]; then
        echo "financial"
        return
    fi
    
    # Health & wellness patterns
    if [[ "$query_lower" =~ (health|fitness|wellness|stress|sleep|energy|tired|exercise|nutrition) ]]; then
        echo "health"
        return
    fi
    
    # Louisville/location patterns
    if [[ "$query_lower" =~ (louisville|kentucky|local|jcps|school|neighborhood|downtown) ]]; then
        echo "location"
        return
    fi
    
    # Music patterns
    if [[ "$query_lower" =~ (music|guitar|practice|performance|song|play|band|chord) ]]; then
        echo "music"
        return
    fi
    
    # Career/corporate patterns
    if [[ "$query_lower" =~ (career|job|promotion|humana|corporate|work|meeting|boss|ai.*leader) ]]; then
        echo "career"
        return
    fi
    
    # Creative patterns
    if [[ "$query_lower" =~ (creative|innovate|idea|breakthrough|design|imagine|invent) ]]; then
        echo "creative"
        return
    fi
    
    # Family/relationship patterns
    if [[ "$query_lower" =~ (family|kids|teens|relationship|parenting|daughter|son|children) ]]; then
        echo "family"
        return
    fi
    
    # Default to strategic
    echo "strategic"
}

# Function to get model chain for intent
get_model_chain() {
    local intent="$1"
    
    case "$intent" in
        "quick")
            echo "speed_optimizer_phi"
            ;;
        "financial")
            echo "matthew_context_provider_v6_complete universal_financial_advisor practical_implementer"
            ;;
        "health")
            echo "matthew_context_provider_v6_complete universal_health_wellness practical_implementer"
            ;;
        "location")
            echo "universal_louisville_expert practical_implementer"
            ;;
        "music")
            echo "matthew_context_provider_v6_complete universal_music_mentor universal_creative_catalyst"
            ;;
        "career")
            echo "matthew_context_provider_v6_complete universal_career_strategist universal_corporate_navigator"
            ;;
        "creative")
            echo "universal_creative_catalyst universal_strategy_architect practical_implementer"
            ;;
        "family")
            echo "matthew_context_provider_v6_complete universal_relationship_harmony practical_implementer"
            ;;
        "strategic"|*)
            echo "matthew_context_provider_v6_complete universal_strategy_architect analytical_expert_gemma practical_implementer"
            ;;
    esac
}

# Main execution
if [ $# -eq 0 ]; then
    echo "Usage: $0 \"Your query here\""
    echo ""
    echo "Smart routing will automatically select the best model chain based on your query."
    echo ""
    echo "Available intents:"
    echo "  - quick: Fast responses for immediate needs"
    echo "  - financial: Money, budgeting, investment advice"
    echo "  - health: Wellness, fitness, lifestyle optimization"
    echo "  - location: Louisville-specific knowledge"
    echo "  - music: Guitar, practice, performance guidance"
    echo "  - career: Professional development, corporate strategy"
    echo "  - creative: Innovation, breakthrough thinking"
    echo "  - family: Parenting, relationships, family dynamics"
    echo "  - strategic: Deep analysis and planning (default)"
    exit 1
fi

QUERY="$1"

# Analyze query
echo -e "${YELLOW}🧠 Analyzing query intent...${NC}"
INTENT=$(analyze_query "$QUERY")
echo -e "${GREEN}Intent detected: ${INTENT}${NC}"

# Get model chain
MODELS=$(get_model_chain "$INTENT")
echo -e "${BLUE}Selected models: ${MODELS}${NC}"
echo ""

# Execute with selected models
if [ "$INTENT" = "quick" ]; then
    # For quick queries, use simple Ollama call
    echo -e "${GREEN}🚀 Quick Response:${NC}"
    echo "$QUERY" | ollama run speed_optimizer_phi --verbose
else
    # For complex queries, use the chain runner
    export MODELS
    "${MIRADOR_HOME}/bin/mirador_conductor.sh" "$QUERY"
fi
EOF

# Make executable
chmod +x bin/mirador-smart-v2-consolidated

echo -e "${GREEN}✓ Created consolidated routing at: bin/mirador-smart-v2-consolidated${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Test with: ./bin/mirador-smart-v2-consolidated \"Your test query\""
echo "2. If satisfied, replace original:"
echo "   mv bin/mirador-smart-v2-consolidated bin/mirador-smart-v2"
echo ""
echo -e "${GREEN}Done!${NC}"