#!/bin/bash
# Test script for consolidated models
# Verifies functionality before committing to consolidation

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Testing Consolidated Model Architecture ===${NC}"
echo ""

# Test queries for each domain (bash 3.2 compatible)
# Using parallel arrays instead of associative array
test_domains=("financial" "health" "location" "music" "career" "creative" "family" "strategic")
test_queries=(
    "What should my budget priorities be this month?"
    "How can I improve my energy levels?"
    "What's the best school district in Louisville?"
    "How should I structure my guitar practice?"
    "How do I position myself for AI leadership?"
    "Give me a breakthrough idea for AI adoption"
    "How do I help my teens with college prep?"
    "Create a 90-day plan for Mirador adoption"
)

# Function to test a consolidated model
test_model() {
    local model=$1
    local query=$2
    local domain=$3
    
    echo -e "${YELLOW}Testing $model for $domain domain...${NC}"
    echo "Query: $query"
    echo ""
    
    # Test if model exists
    if ollama list | grep -q "$model:latest"; then
        echo -e "${GREEN}✓ Model exists${NC}"
        
        # Quick test
        response=$(echo "$query" | timeout 30 ollama run "$model" --verbose 2>&1 | head -20)
        
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Model responds${NC}"
            echo "Sample response:"
            echo "$response" | head -5
        else
            echo -e "${RED}✗ Model failed to respond${NC}"
            return 1
        fi
    else
        echo -e "${RED}✗ Model not found${NC}"
        return 1
    fi
    
    echo ""
    return 0
}

# Test existing base models
echo -e "${BLUE}Step 1: Testing existing base models${NC}"
echo "========================================"

base_models=(
    "matthew_context_provider_v6_complete"
    "universal_strategy_architect"
    "practical_implementer"
    "speed_optimizer_phi"
)

for model in "${base_models[@]}"; do
    if ollama list | grep -q "$model:latest"; then
        echo -e "${GREEN}✓ $model${NC}"
    else
        echo -e "${RED}✗ $model (missing)${NC}"
    fi
done

echo ""
echo -e "${BLUE}Step 2: Testing consolidated models (if created)${NC}"
echo "========================================"

# Map of consolidated models to test (bash 3.2 compatible)
# Using parallel arrays
consolidated_model_names=(
    "universal_financial_advisor"
    "universal_health_wellness"
    "universal_louisville_expert"
    "universal_music_mentor"
    "universal_career_strategist"
    "universal_corporate_navigator"
    "universal_creative_catalyst"
    "universal_relationship_harmony"
)
consolidated_model_domains=(
    "financial"
    "health"
    "location"
    "music"
    "career"
    "career"
    "creative"
    "family"
)

# Count successes
success_count=0
total_count=0

# Test each consolidated model
for i in "${!consolidated_model_names[@]}"; do
    model="${consolidated_model_names[$i]}"
    domain="${consolidated_model_domains[$i]}"
    
    # Find the query for this domain
    query=""
    for j in "${!test_domains[@]}"; do
        if [ "${test_domains[$j]}" = "$domain" ]; then
            query="${test_queries[$j]}"
            break
        fi
    done
    
    ((total_count++))
    if test_model "$model" "$query" "$domain"; then
        ((success_count++))
    fi
done

echo ""
echo -e "${BLUE}Step 3: Test chain execution${NC}"
echo "========================================"

# Test a simple chain
echo -e "${YELLOW}Testing chain: context → strategy → implementation${NC}"

# Create test chain script
cat > /tmp/test_chain.sh << 'EOF'
#!/bin/bash
QUERY="What should I focus on today?"
MODELS="matthew_context_provider_v6_complete universal_strategy_architect practical_implementer"

echo "Testing chain with: $MODELS"
echo ""

# Simple chain execution
accumulated=""
for model in $MODELS; do
    echo "=== $model ==="
    if [ -z "$accumulated" ]; then
        response=$(echo "$QUERY" | timeout 20 ollama run "$model" 2>/dev/null | head -10)
    else
        response=$(echo "$QUERY. Context: $accumulated" | timeout 20 ollama run "$model" 2>/dev/null | head -10)
    fi
    echo "$response"
    accumulated="$accumulated $response"
    echo ""
done
EOF

chmod +x /tmp/test_chain.sh
/tmp/test_chain.sh

echo ""
echo -e "${BLUE}Step 4: Performance comparison${NC}"
echo "========================================"

# Compare response times
echo -e "${YELLOW}Comparing response times...${NC}"

# Test quick response
echo "Quick response test:"
time_quick=$(time (echo "Quick summary of today" | timeout 10 ollama run speed_optimizer_phi 2>/dev/null | head -5) 2>&1 | grep real | awk '{print $2}')
echo -e "Speed optimizer: ${GREEN}$time_quick${NC}"

# Test standard response (if consolidated model exists)
if ollama list | grep -q "universal_strategy_architect"; then
    time_standard=$(time (echo "Quick summary of today" | timeout 10 ollama run universal_strategy_architect 2>/dev/null | head -5) 2>&1 | grep real | awk '{print $2}')
    echo -e "Strategy architect: ${YELLOW}$time_standard${NC}"
fi

echo ""
echo -e "${BLUE}Test Summary${NC}"
echo "========================================"
echo -e "Base models available: ${GREEN}${#base_models[@]}${NC}"
echo -e "Consolidated models tested: $total_count"
echo -e "Successful tests: ${GREEN}$success_count${NC}"
echo -e "Failed tests: ${RED}$((total_count - success_count))${NC}"

if [ $success_count -eq 0 ]; then
    echo ""
    echo -e "${YELLOW}Note: No consolidated models found.${NC}"
    echo "Run ./scripts/consolidate_models_phase2.sh to create them."
else
    echo ""
    echo -e "${GREEN}✓ Consolidated models are working!${NC}"
fi

# Cleanup
rm -f /tmp/test_chain.sh

echo ""
echo -e "${BLUE}Done!${NC}"