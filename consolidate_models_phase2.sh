#!/bin/bash
# Model Consolidation Phase 2 - Remove redundant versions

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

echo -e "${BLUE}🧹 Model Consolidation Phase 2${RESET}"
echo "================================"
echo ""
echo "This script will remove redundant model versions to free up storage."
echo "Target: Free up 20-30 GB by consolidating duplicate versions."
echo ""

# Backup current model list
BACKUP_FILE="ollama_models_backup_phase2_$(date +%Y%m%d_%H%M%S).txt"
ollama list > "$BACKUP_FILE"
echo -e "${GREEN}✓ Backup saved to: $BACKUP_FILE${RESET}"
echo ""

# Define models to remove (keeping only the latest/best versions)
MODELS_TO_REMOVE=(
    # Matthew context providers - keep only v5_complete
    "matthew_context_provider_v2:latest"
    "matthew_context_provider_v3:latest"
    "matthew_context_provider_v4:latest"
    "matthew_context_provider_v4_accurate:latest"
    "matthew_context_provider_optimized:latest"
    
    # Strategic accelerators - keep only v2
    "matthews_strategic_accelerator:latest"
    
    # Advocates meeting optimizers - keep only v2
    "advocates_meeting_optimizer:latest"
    
    # Enhanced agents - keep only latest enforcer
    "enhanced_agent_enforcer_v2:latest"
    "enhanced_agent_fast_v6:latest"
    
    # Financial planners - keep only v6
    "financial_planning_expert_optimized:latest"
    
    # Matthew advisors - keep none (redundant with context provider)
    "matthew_advisor:latest"
    "matthew_advisor_enhanced:latest"
    
    # Test models
    "test_balanced_specialist:latest"
    
    # Duplicate llama models
    "llama3.2_balanced:latest"
    "fast_agent_llama:latest"
    "fast_agent_ultimate:latest"
    "fast_agent_focused:latest"
    
    # Old baseline models
    "baseline_llama_compact:latest"
)

echo "Models to be removed:"
for model in "${MODELS_TO_REMOVE[@]}"; do
    echo "  - $model"
done
echo ""

# Confirm before proceeding
read -p "Continue with consolidation? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Consolidation cancelled."
    exit 0
fi

echo ""
echo -e "${YELLOW}Removing redundant models...${RESET}"

SUCCESS_COUNT=0
FAIL_COUNT=0
TOTAL_FREED=0

for model in "${MODELS_TO_REMOVE[@]}"; do
    echo -n "Removing $model... "
    
    # Get size before removal
    SIZE_BEFORE=$(ollama list | grep "^$model" | awk '{print $3}')
    
    if ollama rm "$model" 2>/dev/null; then
        echo -e "${GREEN}✓${RESET}"
        ((SUCCESS_COUNT++))
        
        # Calculate freed space (rough estimate)
        if [[ $SIZE_BEFORE =~ ([0-9.]+)\ GB ]]; then
            FREED=${BASH_REMATCH[1]}
            TOTAL_FREED=$(echo "$TOTAL_FREED + $FREED" | bc)
        fi
    else
        echo -e "${RED}✗ Failed or not found${RESET}"
        ((FAIL_COUNT++))
    fi
done

echo ""
echo -e "${BLUE}📊 Consolidation Summary${RESET}"
echo "========================"
echo "Models removed: $SUCCESS_COUNT"
echo "Failed removals: $FAIL_COUNT"
echo "Estimated space freed: ${TOTAL_FREED} GB"
echo ""

# Show remaining models
echo -e "${BLUE}💾 Remaining models:${RESET}"
ollama list | head -20
echo "..."
echo ""

# Count remaining models
TOTAL_MODELS=$(ollama list | tail -n +2 | wc -l)
echo "Total remaining models: $TOTAL_MODELS"

# Update chain scripts to use consolidated models
echo ""
echo -e "${YELLOW}⚠️  Important Next Steps:${RESET}"
echo "1. Update any scripts that reference removed models"
echo "2. Test chains to ensure they still function correctly"
echo "3. Run './update_chains_consolidated.sh' to update all references"
echo ""
echo -e "${GREEN}✅ Consolidation complete!${RESET}"