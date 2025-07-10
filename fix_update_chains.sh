#!/bin/bash
# Fixed version of update_chains_consolidated.sh

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

echo -e "${BLUE}🔧 Updating Chain Scripts for Consolidated Models${RESET}"
echo "================================================"
echo ""

# Backup directory
BACKUP_DIR="chain_backups_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Define model replacements using arrays instead of associative array
OLD_MODELS=(
    "matthew_context_provider_v2:latest"
    "matthew_context_provider_v3:latest"
    "matthew_context_provider_v4:latest"
    "matthew_context_provider_v4_accurate:latest"
    "matthew_context_provider_optimized:latest"
    "matthews_strategic_accelerator:latest"
    "advocates_meeting_optimizer:latest"
    "enhanced_agent_enforcer_v2:latest"
    "enhanced_agent_fast_v6:latest"
    "financial_planning_expert_optimized:latest"
    "matthew_advisor:latest"
    "matthew_advisor_enhanced:latest"
    "test_balanced_specialist:latest"
    "llama3.2_balanced:latest"
    "fast_agent_llama:latest"
    "fast_agent_ultimate:latest"
    "fast_agent_focused:latest"
    "baseline_llama_compact:latest"
)

NEW_MODELS=(
    "matthew_context_provider_v5_complete:latest"
    "matthew_context_provider_v5_complete:latest"
    "matthew_context_provider_v5_complete:latest"
    "matthew_context_provider_v5_complete:latest"
    "matthew_context_provider_v5_complete:latest"
    "matthews_strategic_accelerator_v2:latest"
    "advocates_meeting_optimizer_v2:latest"
    "enhanced_agent_enforcer:latest"
    "enhanced_agent_enforcer:latest"
    "financial_planning_expert_v6:latest"
    "matthew_context_provider_v5_complete:latest"
    "matthew_context_provider_v5_complete:latest"
    "creative_catalyst:latest"
    "llama3.2:3b"
    "speed_optimizer_phi:latest"
    "speed_optimizer_phi:latest"
    "speed_optimizer_phi:latest"
    "llama3.2:3b"
)

echo "Model replacement mappings:"
for i in "${!OLD_MODELS[@]}"; do
    echo "  ${OLD_MODELS[$i]} → ${NEW_MODELS[$i]}"
done
echo ""

# Find chain scripts
CHAIN_SCRIPTS=$(find . -name "*.sh" -type f | grep -E "(mirador|chain|runner)" | grep -v backup | grep -v fix_update)

# Process each file
for file in $CHAIN_SCRIPTS; do
    if [ -f "$file" ]; then
        echo -n "Updating $file... "
        
        # Backup original
        cp "$file" "$BACKUP_DIR/" 2>/dev/null || true
        
        # Create temporary file
        temp_file="${file}.tmp"
        cp "$file" "$temp_file"
        
        # Apply replacements
        for i in "${!OLD_MODELS[@]}"; do
            old_model="${OLD_MODELS[$i]}"
            new_model="${NEW_MODELS[$i]}"
            sed -i '' "s|$old_model|$new_model|g" "$temp_file"
        done
        
        # Special case: Update matthew_context_provider_v3 without :latest suffix
        sed -i '' "s|matthew_context_provider_v3\"|matthew_context_provider_v5_complete:latest\"|g" "$temp_file"
        sed -i '' "s|matthew_context_provider_v3 |matthew_context_provider_v5_complete:latest |g" "$temp_file"
        
        # Move temp file to original
        mv "$temp_file" "$file"
        
        echo -e "${GREEN}✓${RESET}"
    fi
done

echo ""
echo -e "${GREEN}✅ Chain update complete!${RESET}"
echo ""
echo "Backups saved to: $BACKUP_DIR/"
echo "Please test your chains to ensure they work correctly."