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
