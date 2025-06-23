# Mirador Model Consolidation Migration Guide

This guide will help you safely migrate to the consolidated model set.

## Pre-Migration Checklist

- [ ] Review the consolidation analysis report
- [ ] Test critical workflows with current models
- [ ] Ensure you have sufficient disk space for backups
- [ ] Schedule maintenance window for migration

## Migration Steps

### Step 1: Backup Current Models
```bash
./backup_models.sh
```

### Step 2: Test Consolidated Models
Before retiring old models, test the recommended models:

**Enhanced Agent Models:**
- Test `enhanced_agent_enforcer_v2` with typical queries
- Test `enhanced_agent_fast_v6` with typical queries

**Local Expert Models:**
- Test `louisville_expert_v3` with typical queries

**Financial Planning Models:**
- Test `financial_planning_expert_v6` with typical queries
- Test `financial_planning_expert_fast` with typical queries

**System Specialist Models:**
- Test `mirador_system_specialist_v2` with typical queries

**Context Provider Models:**
- Test `matthew_context_provider_v2` with typical queries

**Decision Support Models:**
- Test `decision_simplifier_v2` with typical queries

### Step 3: Update Configuration
Update your Mirador configuration to use the consolidated models:

```python
# Update your model references in orchestrator configuration
CONSOLIDATED_MODELS = {
    'enhanced_agent': ['enhanced_agent_enforcer_v2', 'enhanced_agent_fast_v6'],
    'local_expert': ['louisville_expert_v3'],
    'financial_planning': ['financial_planning_expert_v6', 'financial_planning_expert_fast'],
    'system_specialist': ['mirador_system_specialist_v2'],
    'context_provider': ['matthew_context_provider_v2'],
    'decision_support': ['decision_simplifier_v2'],
}
```

### Step 4: Retire Old Models
Once testing is complete and configuration is updated:
```bash
./retire_models.sh
```

### Step 5: Verify Migration
- [ ] Run test chains with consolidated models
- [ ] Verify all expected functionality works
- [ ] Update documentation
- [ ] Clean up backup files (after verification period)

## Rollback Plan

If issues are discovered after migration:

1. Stop using consolidated models
2. Restore from backup directory
3. Revert configuration changes
4. Investigate issues before re-attempting migration

## Support

If you encounter issues during migration:
- Check the backup directory for original models
- Review the consolidation analysis for model mappings
- Test individual models in isolation
