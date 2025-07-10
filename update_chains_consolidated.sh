#!/bin/bash
# Update chain scripts to use consolidated models

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

# Define model replacements
declare -A MODEL_REPLACEMENTS=(
    ["matthew_context_provider_v5_complete:latest"]="matthew_context_provider_v5_complete:latest"
    ["matthew_context_provider_v5_complete:latest"]="matthew_context_provider_v5_complete:latest"
    ["matthew_context_provider_v5_complete:latest"]="matthew_context_provider_v5_complete:latest"
    ["matthew_context_provider_v5_complete:latest"]="matthew_context_provider_v5_complete:latest"
    ["matthew_context_provider_v5_complete:latest"]="matthew_context_provider_v5_complete:latest"
    ["matthews_strategic_accelerator_v2:latest"]="matthews_strategic_accelerator_v2:latest"
    ["advocates_meeting_optimizer_v2:latest"]="advocates_meeting_optimizer_v2:latest"
    ["enhanced_agent_enforcer:latest"]="enhanced_agent_enforcer:latest"
    ["enhanced_agent_enforcer:latest"]="enhanced_agent_enforcer:latest"
    ["financial_planning_expert_v6:latest"]="financial_planning_expert_v6:latest"
    ["matthew_context_provider_v5_complete:latest"]="matthew_context_provider_v5_complete:latest"
    ["matthew_context_provider_v5_complete:latest"]="matthew_context_provider_v5_complete:latest"
    ["creative_catalyst:latest"]="creative_catalyst:latest"
    ["llama3.2:3b"]="llama3.2:3b"
    ["speed_optimizer_phi:latest"]="speed_optimizer_phi:latest"
    ["speed_optimizer_phi:latest"]="speed_optimizer_phi:latest"
    ["speed_optimizer_phi:latest"]="speed_optimizer_phi:latest"
    ["llama3.2:3b"]="llama3.2:3b"
)

# Files to update
FILES_TO_UPDATE=(
    "mirador-smart-v2"
    "mirador_universal_runner_v2.sh"
    "bin/mirador_universal_runner_v3_optimized.sh"
    "humana_chain_runner.sh"
    "mirador-ez"
    "company_chain_runner.sh"
    "robust_chain_runner.sh"
    "role_based_chain_runner.sh"
)

echo "Model replacement mappings:"
for old_model in "${!MODEL_REPLACEMENTS[@]}"; do
    new_model="${MODEL_REPLACEMENTS[$old_model]}"
    echo "  $old_model → $new_model"
done
echo ""

# Process each file
for file in "${FILES_TO_UPDATE[@]}"; do
    if [ -f "$file" ]; then
        echo -n "Updating $file... "
        
        # Backup original
        cp "$file" "$BACKUP_DIR/"
        
        # Create temporary file
        temp_file="${file}.tmp"
        cp "$file" "$temp_file"
        
        # Apply replacements
        for old_model in "${!MODEL_REPLACEMENTS[@]}"; do
            new_model="${MODEL_REPLACEMENTS[$old_model]}"
            sed -i '' "s|$old_model|$new_model|g" "$temp_file"
        done
        
        # Special case: Update matthew_context_provider_v5_complete:latest without :latest suffix
        sed -i '' "s|matthew_context_provider_v3\"|matthew_context_provider_v5_complete:latest\"|g" "$temp_file"
        sed -i '' "s|matthew_context_provider_v5_complete:latest |matthew_context_provider_v5_complete:latest |g" "$temp_file"
        
        # Move temp file to original
        mv "$temp_file" "$file"
        
        echo -e "${GREEN}✓${RESET}"
    else
        echo -e "${YELLOW}Warning: $file not found${RESET}"
    fi
done

echo ""
echo -e "${BLUE}📝 Creating Consolidated Model Reference${RESET}"

cat > "CONSOLIDATED_MODELS.md" << 'EOMD'
# Consolidated Model Reference

## Primary Models (Keep These)

### Context Providers
- `matthew_context_provider_v5_complete:latest` - Main context provider (replaced v2, v3, v4)

### Strategic Models
- `universal_strategy_architect:latest`
- `matthews_strategic_accelerator_v2:latest` (replaced v1)
- `advocates_meeting_optimizer_v2:latest` (replaced v1)

### Domain Experts
- `financial_planning_expert_v6:latest` (replaced optimized version)
- `humana_innovation_catalyst:latest`
- `humana_politics_navigator:latest`
- `louisville_expert_v3:latest`

### Implementation Models
- `practical_implementer:latest`
- `action_crystallizer:latest`
- `solution_architect:latest`
- `enhanced_agent_enforcer:latest` (replaced v2, fast_v6)

### Creative Models
- `creative_catalyst:latest`
- `digital_storyteller:latest`
- `engagement_optimizer:latest`

### Diverse Base Models
- `analytical_expert_gemma:latest` (Gemma 2)
- `multilingual_assistant_qwen:latest` (Qwen 2.5)
- `speed_optimizer_phi:latest` (Phi-3)
- `command_r_rag_specialist:latest` (Command-R)
- `command_r_code_analyst:latest` (Command-R)

### Core Base Models
- `gemma2:27b`
- `qwen2.5:32b`
- `phi3:medium`
- `command-r:35b`
- `llama3.2:3b`
- `mistral:latest`
- `deepseek-coder:latest`

## Removed Models (Consolidated)
- All matthew_context_provider versions except v5_complete
- All matthews_strategic_accelerator versions except v2
- All advocates_meeting_optimizer versions except v2
- All test models
- All fast_agent variants
- All matthew_advisor variants

## Migration Notes
1. All context provider references now use v5_complete
2. Fast agent models replaced with speed_optimizer_phi
3. Test models replaced with appropriate production models
EOMD

echo -e "${GREEN}✓ Reference created: CONSOLIDATED_MODELS.md${RESET}"

echo ""
echo -e "${GREEN}✅ Chain update complete!${RESET}"
echo ""
echo "Backups saved to: $BACKUP_DIR/"
echo "Please test your chains to ensure they work correctly."
echo ""
echo "Next step: Run consolidation script to remove old models:"
echo "  ./consolidate_models_phase2.sh"