# Mirador Model Consolidation Guide

## Overview

Model Consolidation Phase 2 reduces Mirador's model count from 71+ to approximately 30 core models while maintaining all capabilities. This improves performance, reduces storage, and simplifies maintenance.

## Why Consolidate?

- **Storage**: Save ~50% disk space (from 120GB to ~60GB)
- **Performance**: Faster model loading and switching
- **Maintenance**: Easier to update and manage
- **Scalability**: Better for enterprise deployment

## Consolidation Strategy

### Groups Being Consolidated

1. **Financial Models** → `universal_financial_advisor`
   - financial_planning_expert_v8
   - personal_finance_navigator
   - budget_optimizer
   - financial_advisor
   - money_mindset_coach

2. **Health & Wellness** → `universal_health_wellness`
   - health_wellness_advisor
   - fitness_coach
   - wellness_optimizer
   - health_navigator

3. **Location/Louisville** → `universal_louisville_expert`
   - louisville_expert
   - louisville_local_guide
   - kentucky_insider
   - louisville_navigator

4. **Music** → `universal_music_mentor`
   - music_advisor
   - guitar_mentor
   - performance_coach
   - music_strategist

5. **Career** → `universal_career_strategist`
   - career_strategist
   - professional_development_coach
   - career_navigator

6. **Corporate** → `universal_corporate_navigator`
   - corporate_navigator
   - corporate_strategy
   - risk_management_advisor

7. **Creative** → `universal_creative_catalyst`
   - creative_catalyst
   - creative_breakthrough
   - idea_generator
   - innovation_spark

8. **Relationships** → `universal_relationship_harmony`
   - relationship_harmony
   - family_advisor
   - social_navigator

### Models Being Kept

Core models that remain unchanged:
- matthew_context_provider_v6_complete
- universal_strategy_architect
- practical_implementer
- decision_simplifier_v2
- analytical_expert_gemma
- command-r
- speed_optimizer_phi

## Implementation Steps

### 1. Run Consolidation Script

```bash
# Create consolidated models (with backup)
./scripts/consolidate_models_phase2.sh
```

This will:
- Create a backup of existing models
- Generate 8 new consolidated models
- Create updated routing configuration
- NOT remove old models (safety first)

### 2. Test Consolidated Models

```bash
# Test all consolidated models
./scripts/test_consolidated_models.sh
```

This verifies:
- All models respond correctly
- Chain execution works
- Performance is acceptable

### 3. Update Routing

```bash
# Update smart routing
./scripts/update_smart_routing.sh

# Test new routing
./bin/mirador-smart-v2-consolidated "What should I focus on today?"
```

### 4. Remove Old Models (Optional)

After verification period (recommended: 1 week):

```bash
# Edit consolidate_models_phase2.sh
# Uncomment the removal section (lines ~200-205)
# Re-run the script
./scripts/consolidate_models_phase2.sh
```

## New Routing Logic

Smart routing now uses intent detection:

| Intent | Keywords | Models Used |
|--------|----------|-------------|
| quick | quick, brief, tldr | speed_optimizer_phi |
| financial | money, budget, invest | context → financial → implementer |
| health | health, fitness, sleep | context → health → implementer |
| location | louisville, local | louisville_expert → implementer |
| music | guitar, practice | context → music → creative |
| career | job, promotion, work | context → career → corporate |
| creative | idea, innovate | creative → strategy → implementer |
| family | kids, parenting | context → relationship → implementer |
| strategic | (default) | context → strategy → analysis → implementer |

## Performance Impact

Expected improvements:
- **Model Loading**: 2-3x faster
- **First Token**: <1s maintained
- **Total Response**: 10-20% faster
- **Memory Usage**: 40-50% reduction

## Rollback Plan

If issues arise:

```bash
# Restore from backup
backup_dir=$(ls -t ~/mirador_model_backup_* | head -1)
cp -r "$backup_dir"/* ~/.ollama/models/manifests/registry.ollama.ai/library/

# Revert routing
git checkout bin/mirador-smart-v2
```

## Future Enhancements

### Phase 3: Dynamic Model Generation
- Base models + runtime parameters
- No pre-created variations
- Further 50% reduction possible

### Phase 4: Model Fusion
- Merge similar base models
- Create true universal models
- Reduce to ~10 core models

## Monitoring

Track success metrics:
- Response quality (user ratings)
- Performance (response times)
- Resource usage (memory/disk)
- Error rates

Use feedback system:
```bash
./mirador_feedback.sh SESSION_ID RATING "Comment"
```

## Best Practices

1. **Always backup before changes**
2. **Test thoroughly before removing models**
3. **Monitor performance after consolidation**
4. **Keep routing configuration updated**
5. **Document any custom models**

## Troubleshooting

### Model Not Found
```bash
# Check if consolidated model exists
ollama list | grep universal

# Re-run consolidation for specific group
./scripts/consolidate_models_phase2.sh
```

### Routing Issues
```bash
# Test routing logic
./bin/mirador-smart-v2-consolidated "test query" 2>&1 | grep "Intent detected"

# Check routing config
cat config/model_routing_v2.yaml
```

### Performance Degradation
- Check model parameters in consolidation script
- Verify base model selection
- Consider keeping more specialized models

---

*Model consolidation is a key step toward enterprise-ready Mirador deployment.*