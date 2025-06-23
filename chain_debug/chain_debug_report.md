# Mirador Chain Execution Debug Report

**Generated:** Fri Jun 20 08:04:22 EDT 2025

## Executive Summary

**Chains Tested:** 3
**Successful Chains:** 2
**Failed Chains:** 1
**Success Rate:** 66.7%

## Model Performance Summary

**Working Models:** enhanced_agent_enforcer, financial_planning_expert_v6
**Problematic Models:** decision_simplifier, matthew_context_provider

## Detailed Chain Analysis

### simple_financial_chain

**Query:** Create a basic budget for someone earning $75,000 annually
**Models:** financial_planning_expert_v6 → enhanced_agent_enforcer
**Success:** ✅
**Total Time:** 21.0s
**Final Output Length:** 3577 characters

**Step-by-Step Execution:**

| Step | Model | Status | Output Length | Time (s) | Error |
|------|-------|--------|---------------|----------|-------|
| 1 | financial_planning_expert_v6 | ✅ | 1710 | 10.4 |  |
| 2 | enhanced_agent_enforcer | ✅ | 3577 | 10.6 |  |

**Sample Outputs:**

**financial_planning_expert_v6:** **Basic Budget Framework for $75,000 Annual Income**

This budget framework is designed to provide a starting point for managing finances effectively. It's essential to note that individual circumstan...

**enhanced_agent_enforcer:** **Enhanced Strategic Insights**

Based on the previous analysis, the following enhanced strategic insights have been identified:

1.  **Income Allocation**: The budget framework allocates 50% of month...

---

### context_financial_chain

**Query:** Develop financial strategy for healthcare professional
**Models:** matthew_context_provider → financial_planning_expert_v6
**Success:** ✅
**Total Time:** 16.2s
**Final Output Length:** 2860 characters

**Step-by-Step Execution:**

| Step | Model | Status | Output Length | Time (s) | Error |
|------|-------|--------|---------------|----------|-------|
| 1 | matthew_context_provider | ❌ | 0 | 0.2 | Command failed: [?2026h[?25l... |
| 2 | financial_planning_expert_v6 | ✅ | 2860 | 16.0 |  |

**Sample Outputs:**

**financial_planning_expert_v6:** **Continuation of Financial Strategy Analysis for Healthcare Professional**

**Summary of Current Situation:**
As previously discussed, our target audience is a healthcare professional seeking a compr...

---

### full_decision_chain

**Query:** Should I save for house or invest in retirement first?
**Models:** matthew_context_provider → enhanced_agent_enforcer → decision_simplifier
**Success:** ❌
**Total Time:** 8.6s
**Final Output Length:** 0 characters

**Issues Detected:**
- Content generated but lost in final step

**Step-by-Step Execution:**

| Step | Model | Status | Output Length | Time (s) | Error |
|------|-------|--------|---------------|----------|-------|
| 1 | matthew_context_provider | ❌ | 0 | 0.2 | Command failed: [?2026h[?25l... |
| 2 | enhanced_agent_enforcer | ✅ | 2784 | 8.2 |  |
| 3 | decision_simplifier | ❌ | 0 | 0.2 | Command failed: [?2026h[?25l... |

**Sample Outputs:**

**enhanced_agent_enforcer:** **Strategic Synthesis Overview**

The previous analysis has highlighted the importance of balancing short-term and long-term financial goals. Saving for a house and investing in retirement are both cr...

---

## Recommendations

⚠️ **PARTIAL FUNCTIONALITY**: Some chains work, others don't.

**Recommended Actions:**
1. Focus on fixing problematic models
2. Use working models for immediate needs
3. Investigate chain-specific issues

## Next Steps

### Fix Problematic Models
- **decision_simplifier**: Run individual diagnostic and repair
- **matthew_context_provider**: Run individual diagnostic and repair

### Leverage Working Models
Consider creating simplified chains using only working models:
- **enhanced_agent_enforcer**: Confirmed functional
- **financial_planning_expert_v6**: Confirmed functional

### Validation Commands
```bash
# Test individual models
python3 mirador_content_diagnostic.py

# Re-run chain debugging after fixes
python3 mirador_chain_debugger.py
```
