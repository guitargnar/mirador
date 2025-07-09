# Mirador Model Consolidation Analysis

**Generated:** 2025-06-19T09:48:34.018620

## Executive Summary

- **Current Models:** 89
- **Recommended for Retirement:** 20
- **Estimated Disk Space Savings:** 0.0 MB
- **Target Model Count:** 69

## Category Analysis

### Other

- **Current Count:** 40
- **Recommendation:** keep_all

### Enhanced Agent

- **Current Count:** 13
- **Recommendation:** consolidate
- **Models to Keep:**
  - enhanced_agent_enforcer_v2
  - enhanced_agent_fast_v6
- **Models to Retire:**
  - enhanced_agent_fast_v1
  - enhanced_agent_fast_v2
  - enhanced_agent_fast_v3
  - enhanced_agent_fast_v4
  - enhanced_agent_fast_v5
  - enhanced_agent_fast_v7
  - enhanced_agent_v1
  - enhanced_agent_v2

### Local Expert

- **Current Count:** 4
- **Recommendation:** consolidate
- **Models to Keep:**
  - louisville_expert_v3
- **Models to Retire:**
  - louisville_expert_v1
  - louisville_expert_v2

### Financial Planning

- **Current Count:** 16
- **Recommendation:** consolidate
- **Models to Keep:**
  - financial_planning_expert_v6
  - financial_planning_expert_fast
- **Models to Retire:**
  - financial_planning_expert_v1
  - financial_planning_expert_v2
  - financial_planning_expert_v3
  - financial_planning_expert_v4
  - financial_planning_expert_v5
  - financial_planning_expert_v7
  - financial_planning_expert_v8

### System Specialist

- **Current Count:** 3
- **Recommendation:** consolidate
- **Models to Keep:**
  - mirador_system_specialist_v2
- **Models to Retire:**
  - mirador_system_specialist_v1

### Context Provider

- **Current Count:** 8
- **Recommendation:** consolidate
- **Models to Keep:**
  - matthew_context_provider_v2
- **Models to Retire:**
  - matthew_context_provider_v1

### Content Creation

- **Current Count:** 1
- **Recommendation:** keep_all

### Domain Specialist

- **Current Count:** 2
- **Recommendation:** keep_all

### Decision Support

- **Current Count:** 2
- **Recommendation:** consolidate
- **Models to Keep:**
  - decision_simplifier_v2
- **Models to Retire:**
  - decision_simplifier_v1

## Implementation Plan

### Phase 1 Immediate

Safe retirement of clearly redundant models

- **Backup And Retire**: enhanced_agent_fast_v1 (superseded_by_newer_version)
- **Backup And Retire**: enhanced_agent_fast_v2 (superseded_by_newer_version)
- **Backup And Retire**: enhanced_agent_fast_v3 (superseded_by_newer_version)
- **Backup And Retire**: enhanced_agent_fast_v4 (superseded_by_newer_version)
- **Backup And Retire**: enhanced_agent_fast_v5 (superseded_by_newer_version)
- **Backup And Retire**: enhanced_agent_fast_v7 (superseded_by_newer_version)
- **Backup And Retire**: enhanced_agent_v1 (superseded_by_newer_version)
- **Backup And Retire**: enhanced_agent_v2 (superseded_by_newer_version)
- **Backup And Retire**: louisville_expert_v1 (superseded_by_newer_version)
- **Backup And Retire**: louisville_expert_v2 (superseded_by_newer_version)
- **Backup And Retire**: financial_planning_expert_v1 (superseded_by_newer_version)
- **Backup And Retire**: financial_planning_expert_v2 (superseded_by_newer_version)
- **Backup And Retire**: financial_planning_expert_v3 (superseded_by_newer_version)
- **Backup And Retire**: financial_planning_expert_v4 (superseded_by_newer_version)
- **Backup And Retire**: financial_planning_expert_v5 (superseded_by_newer_version)
- **Backup And Retire**: financial_planning_expert_v7 (superseded_by_newer_version)
- **Backup And Retire**: financial_planning_expert_v8 (superseded_by_newer_version)
- **Backup And Retire**: mirador_system_specialist_v1 (superseded_by_newer_version)
- **Backup And Retire**: matthew_context_provider_v1 (superseded_by_newer_version)
- **Backup And Retire**: decision_simplifier_v1 (superseded_by_newer_version)

### Phase 2 Testing

Test consolidated models before final retirement

- **Performance Test**: enhanced_agent_enforcer_v2
- **Performance Test**: enhanced_agent_fast_v6
- **Performance Test**: louisville_expert_v3
- **Performance Test**: financial_planning_expert_v6
- **Performance Test**: financial_planning_expert_fast
- **Performance Test**: mirador_system_specialist_v2
- **Performance Test**: matthew_context_provider_v2
- **Performance Test**: decision_simplifier_v2

### Phase 3 Cleanup

Final cleanup and documentation update

- **Update Documentation**
- **Update Configuration**
- **Create Migration Guide**

