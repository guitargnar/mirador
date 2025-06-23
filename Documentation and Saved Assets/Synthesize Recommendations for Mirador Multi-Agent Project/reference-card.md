# 🎯 Mirador Quick Reference Card

## Daily Routine (5 min)
```bash
./daily_opportunity_scan.sh
```

## Power Prompts

### 💰 Financial Planning
```bash
mirador-ez ask financial_planning_expert_v6 \
"Best investment move with $X this month?"
```

### 🚀 Career Growth  
```bash
mirador-ez chain "Path to $120k consulting income" \
matthew_context_provider financial_planning_expert_v6 \
opportunity_validator_v2 decision_simplifier
```

### 🏠 Real Estate
```bash
mirador-ez chain "Louisville rental property analysis" \
louisville_expert_v3 financial_planning_expert_v6 \
opportunity_validator_v2 decision_simplifier
```

## Chain Formula
```
mirador-ez chain "[YOUR QUESTION]" \
  [CONTEXT] → [ANALYSIS] → [VALIDATION] → [SIMPLIFY]
```

## Model Cheat Sheet

**Context**: `matthew_context_provider`  
**Finance**: `financial_planning_expert_v6`  
**Local**: `louisville_expert_v3`  
**Validate**: `opportunity_validator_v2`  
**Enhance**: `enhanced_agent_enforcer`  
**Simplify**: `decision_simplifier`  
**Optimize**: `mirador_system_specialist`

## High-ROI Questions

1. "What's my highest-leverage opportunity this week?"
2. "How can I add $2k/month income in 90 days?"
3. "Should I invest in X vs Y vs Z? (with numbers)"
4. "What Medicare compliance service has no competition?"
5. "How to optimize taxes given my situation?"

## Optimal Chain Patterns

**Decision Making**
```
matthew_context → financial → validator → simplifier
```

**Opportunity Finding**
```
system_specialist → matthew → louisville → validator
```

**Implementation Planning**
```
matthew → financial → enforcer → simplifier
```

## Weekly Review
```bash
./weekly_deep_analysis.sh
./advanced_opportunity_analytics.sh
```

## Track Success
```bash
./track_mirador_roi.sh "Name" amount status
```

## Quick Fixes

**Ollama not running?**
```bash
brew services restart ollama
```

**Check system**
```bash
./version_info.sh
```

---

💡 **Golden Rule**: Specific numbers + timeframes = better insights

📊 **Success Metric**: 10x time ROI (1 hour analysis = 10 hours saved)