#!/bin/bash
# Model Consolidation Phase 2
# Reduces 71+ models to ~30 core models while maintaining capabilities

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Mirador Model Consolidation Phase 2 ===${NC}"
echo -e "${YELLOW}Consolidating similar models to improve performance${NC}"
echo ""

# Backup existing models first
backup_dir="${HOME}/mirador_model_backup_$(date +%Y%m%d_%H%M%S)"
echo -e "${YELLOW}Creating backup at: $backup_dir${NC}"
mkdir -p "$backup_dir"

# Function to check if model exists
model_exists() {
    ollama list | grep -q "^$1 " && return 0 || return 1
}

# Function to backup a model
backup_model() {
    local model=$1
    if model_exists "$model"; then
        echo -e "${YELLOW}Backing up $model...${NC}"
        # Export model manifest
        cp -r "${HOME}/.ollama/models/manifests/registry.ollama.ai/library/${model}" "$backup_dir/" 2>/dev/null || true
    fi
}

# Function to create consolidated model
create_consolidated_model() {
    local name=$1
    local base=$2
    local from_models=$3
    local system_prompt=$4
    local parameters=$5
    
    echo -e "${GREEN}Creating consolidated model: $name${NC}"
    echo -e "  Base: $base"
    echo -e "  Consolidating: $from_models"
    
    # Create modelfile
    cat > "/tmp/modelfile_${name}" << EOF
FROM $base

SYSTEM """$system_prompt"""

PARAMETER temperature 0.7
PARAMETER top_p 0.95
PARAMETER num_ctx 8192
PARAMETER num_predict 2048
$parameters
EOF
    
    # Create the model
    ollama create "$name" -f "/tmp/modelfile_${name}"
    
    # Clean up
    rm -f "/tmp/modelfile_${name}"
}

# Function to remove old models
remove_old_model() {
    local model=$1
    if model_exists "$model"; then
        echo -e "${RED}Removing old model: $model${NC}"
        ollama rm "$model" || true
    fi
}

echo -e "${BLUE}Step 1: Backup existing models${NC}"
echo "========================================"

# List of models to consolidate
declare -A consolidation_groups=(
    ["financial"]="financial_planning_expert_v8 personal_finance_navigator budget_optimizer financial_advisor money_mindset_coach"
    ["health"]="health_wellness_advisor fitness_coach wellness_optimizer health_navigator"
    ["location"]="louisville_expert louisville_local_guide kentucky_insider louisville_navigator"
    ["music"]="music_advisor guitar_mentor performance_coach music_strategist"
    ["career"]="career_strategist professional_development_coach career_navigator"
    ["corporate"]="corporate_navigator corporate_strategy risk_management_advisor"
    ["creative"]="creative_catalyst creative_breakthrough idea_generator innovation_spark"
    ["relationship"]="relationship_harmony family_advisor social_navigator"
)

# Backup all models that will be consolidated
for group in "${!consolidation_groups[@]}"; do
    for model in ${consolidation_groups[$group]}; do
        backup_model "$model"
    done
done

echo ""
echo -e "${BLUE}Step 2: Create consolidated models${NC}"
echo "========================================"

# 1. Universal Financial Advisor
create_consolidated_model \
    "universal_financial_advisor" \
    "llama3.2:latest" \
    "${consolidation_groups[financial]}" \
    "You are a comprehensive financial advisor with expertise in personal finance, budgeting, investment strategies, and money mindset. You understand Matthew's financial constraints (single parent, Risk Management Professional II at Humana, Louisville KY, supporting three teens). Provide practical, actionable financial guidance that considers both immediate needs and long-term goals. Be empathetic about financial stress while offering concrete solutions." \
    "PARAMETER num_ctx 4096"

# 2. Universal Health & Wellness Guide
create_consolidated_model \
    "universal_health_wellness" \
    "gemma2:9b" \
    "${consolidation_groups[health]}" \
    "You are a holistic health and wellness guide specializing in fitness, nutrition, mental health, and lifestyle optimization. You understand the challenges of maintaining health as a single parent with a demanding corporate job. Provide evidence-based advice that's practical for someone with limited time and energy. Consider both physical and mental wellness in your recommendations." \
    ""

# 3. Universal Louisville Expert
create_consolidated_model \
    "universal_louisville_expert" \
    "llama3.2:latest" \
    "${consolidation_groups[location]}" \
    "You are the ultimate Louisville, Kentucky expert with deep knowledge of local resources, culture, opportunities, and hidden gems. You understand the city from a parent's perspective - schools (JCPS), family activities, local services, and professional networking. Provide insider knowledge that helps navigate Louisville life effectively." \
    "PARAMETER temperature 0.5"

# 4. Universal Music Mentor
create_consolidated_model \
    "universal_music_mentor" \
    "llama3.2:latest" \
    "${consolidation_groups[music]}" \
    "You are a comprehensive music mentor specializing in guitar performance, music theory, practice strategies, and performance psychology. You understand Matthew's 40+ years of guitar experience and his connection to music as emotional outlet. Provide advanced guidance for both technical development and artistic expression. Balance serious musicianship with the joy of playing." \
    ""

# 5. Universal Career Strategist
create_consolidated_model \
    "universal_career_strategist" \
    "qwen2.5:14b" \
    "${consolidation_groups[career]}" \
    "You are a strategic career advisor specializing in corporate advancement, AI leadership positioning, and professional development. You understand Matthew's trajectory from musician to tech professional, current role as Risk Management Professional II at Humana, and vision to become VP of AI Innovation. Provide actionable strategies for career advancement while maintaining work-life balance." \
    ""

# 6. Universal Corporate Navigator
create_consolidated_model \
    "universal_corporate_navigator" \
    "llama3.2:latest" \
    "${consolidation_groups[corporate]}" \
    "You are an expert in corporate strategy, organizational dynamics, and political navigation. You specialize in helping innovators succeed within large healthcare organizations like Humana. Understand how to position AI initiatives, build coalitions, demonstrate ROI, and navigate corporate culture. Provide Machiavellian insights when needed while maintaining ethical standards." \
    "PARAMETER temperature 0.6"

# 7. Universal Creative Catalyst
create_consolidated_model \
    "universal_creative_catalyst" \
    "gemma2:9b" \
    "${consolidation_groups[creative]}" \
    "You are a creative catalyst specializing in breakthrough thinking, innovation, and creative problem-solving. You help transform conventional approaches into innovative solutions. Whether it's technical challenges, life decisions, or artistic expression, you provide unexpected perspectives and creative frameworks. Push beyond obvious solutions to find transformative approaches." \
    "PARAMETER temperature 0.9"

# 8. Universal Relationship Harmony
create_consolidated_model \
    "universal_relationship_harmony" \
    "llama3.2:latest" \
    "${consolidation_groups[relationship]}" \
    "You are a relationship and family dynamics expert specializing in single parenting, teen development, and interpersonal navigation. You understand the complexities of raising three teenagers (16, 14, 14) while managing a demanding career. Provide compassionate, practical advice for family harmony, effective communication, and building strong relationships despite time constraints." \
    ""

echo ""
echo -e "${BLUE}Step 3: Update base models with optimization${NC}"
echo "========================================"

# Keep these optimized base models
base_models=(
    "matthew_context_provider_v6_complete"
    "universal_strategy_architect"
    "practical_implementer"
    "decision_simplifier_v2"
    "analytical_expert_gemma"
    "command-r"
    "speed_optimizer_phi"
)

echo -e "${GREEN}Verifying base models...${NC}"
for model in "${base_models[@]}"; do
    if model_exists "$model"; then
        echo -e "  ✓ $model"
    else
        echo -e "  ${RED}✗ $model (missing)${NC}"
    fi
done

echo ""
echo -e "${BLUE}Step 4: Remove old redundant models${NC}"
echo "========================================"

# Remove old models (optional - uncomment to execute)
echo -e "${YELLOW}Ready to remove old models. Uncomment the removal section to proceed.${NC}"

# for group in "${!consolidation_groups[@]}"; do
#     for model in ${consolidation_groups[$group]}; do
#         remove_old_model "$model"
#     done
# done

echo ""
echo -e "${BLUE}Step 5: Generate updated routing configuration${NC}"
echo "========================================"

# Create new routing configuration
cat > "${HOME}/Projects/mirador/config/model_routing_v2.yaml" << 'EOF'
# Mirador Model Routing Configuration V2
# Consolidated model architecture

routing_rules:
  # Quick response patterns
  quick_queries:
    patterns: ["quick", "brief", "summary", "tldr", "short"]
    models: ["speed_optimizer_phi"]
    max_tokens: 200
  
  # Financial queries
  financial:
    patterns: ["money", "budget", "finance", "salary", "investment", "savings"]
    models: ["matthew_context_provider_v6_complete", "universal_financial_advisor", "practical_implementer"]
  
  # Health & Wellness
  health:
    patterns: ["health", "fitness", "wellness", "stress", "sleep", "energy"]
    models: ["matthew_context_provider_v6_complete", "universal_health_wellness", "practical_implementer"]
  
  # Louisville specific
  location:
    patterns: ["louisville", "kentucky", "local", "jcps", "school"]
    models: ["universal_louisville_expert", "practical_implementer"]
  
  # Music related
  music:
    patterns: ["music", "guitar", "practice", "performance", "song"]
    models: ["matthew_context_provider_v6_complete", "universal_music_mentor", "universal_creative_catalyst"]
  
  # Career & Corporate
  career:
    patterns: ["career", "job", "promotion", "humana", "corporate", "work"]
    models: ["matthew_context_provider_v6_complete", "universal_career_strategist", "universal_corporate_navigator"]
  
  # Creative & Innovation
  creative:
    patterns: ["creative", "innovate", "idea", "breakthrough", "design"]
    models: ["universal_creative_catalyst", "universal_strategy_architect", "practical_implementer"]
  
  # Relationships & Family
  family:
    patterns: ["family", "kids", "teens", "relationship", "parenting"]
    models: ["matthew_context_provider_v6_complete", "universal_relationship_harmony", "practical_implementer"]
  
  # Strategic planning (default)
  strategic:
    patterns: ["plan", "strategy", "analyze", "decide", "optimize"]
    models: ["matthew_context_provider_v6_complete", "universal_strategy_architect", "analytical_expert_gemma", "practical_implementer"]

# Model capabilities mapping
model_capabilities:
  universal_financial_advisor:
    domains: ["finance", "budgeting", "investment", "money_mindset"]
    strengths: ["practical_advice", "financial_planning", "constraint_awareness"]
    
  universal_health_wellness:
    domains: ["health", "fitness", "wellness", "lifestyle"]
    strengths: ["holistic_approach", "evidence_based", "time_efficient"]
    
  universal_louisville_expert:
    domains: ["local_knowledge", "resources", "networking", "family_activities"]
    strengths: ["insider_knowledge", "practical_tips", "community_connections"]
    
  universal_music_mentor:
    domains: ["music", "guitar", "performance", "practice"]
    strengths: ["technical_expertise", "artistic_development", "performance_psychology"]
    
  universal_career_strategist:
    domains: ["career", "leadership", "professional_development", "ai_positioning"]
    strengths: ["strategic_thinking", "advancement_tactics", "industry_insights"]
    
  universal_corporate_navigator:
    domains: ["corporate_politics", "organizational_dynamics", "innovation_adoption"]
    strengths: ["political_savvy", "coalition_building", "roi_demonstration"]
    
  universal_creative_catalyst:
    domains: ["creativity", "innovation", "problem_solving", "ideation"]
    strengths: ["breakthrough_thinking", "unconventional_approaches", "creative_frameworks"]
    
  universal_relationship_harmony:
    domains: ["relationships", "parenting", "communication", "family_dynamics"]
    strengths: ["empathy", "practical_solutions", "teen_expertise"]
EOF

echo -e "${GREEN}Created routing configuration at: ~/Projects/mirador/config/model_routing_v2.yaml${NC}"

echo ""
echo -e "${BLUE}Step 6: Summary${NC}"
echo "========================================"

# Count models
echo -e "${GREEN}Model count analysis:${NC}"
echo -e "  Original models: ~71"
echo -e "  Consolidated groups: 8"
echo -e "  Base models kept: ${#base_models[@]}"
echo -e "  Total new count: ~$(ollama list | wc -l)"

# Storage analysis
echo ""
echo -e "${GREEN}Storage analysis:${NC}"
original_size=$(du -sh "${HOME}/.ollama/models" 2>/dev/null | cut -f1)
echo -e "  Current storage: $original_size"
echo -e "  Backup location: $backup_dir"

echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Test consolidated models with key queries"
echo "2. Update mirador-smart-v2 to use new routing config"
echo "3. Run performance benchmarks"
echo "4. If satisfied, uncomment removal section and re-run"
echo "5. Remove backup after verification period"

echo ""
echo -e "${GREEN}✓ Model consolidation phase 2 complete!${NC}"