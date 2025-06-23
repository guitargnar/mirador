# Mirador Key Commands Reference

## 🚀 Essential Daily Commands

### Quick Analysis (Single Model)
```bash
# Financial insight
mirador-ez ask financial_planning_expert_v6 "What's my highest ROI financial move this month?"

# Career opportunity
mirador-ez ask matthew_context_provider "What Medicare compliance service gap can I fill?"

# Local intelligence  
mirador-ez ask louisville_expert_v3 "What's the next big opportunity in Louisville healthcare?"
```

### Power Chains (Multi-Model)
```bash
# Financial + Career Integration
mirador-ez chain "How to leverage Medicare expertise for $10k/month side income" \
  matthew_context_provider financial_planning_expert_v6 \
  opportunity_validator_v2 decision_simplifier

# Major Decision Analysis
mirador-ez chain "Should I buy rental property or max out retirement contributions?" \
  financial_planning_expert_v6 louisville_expert_v3 \
  enhanced_agent_enforcer decision_simplifier

# Life Optimization
mirador-ez chain "Design my optimal week for income, family, and health" \
  mirador_system_specialist matthew_context_provider \
  enhanced_agent_enforcer decision_simplifier
```

## 📊 Automation Commands

```bash
# Daily opportunity scan
./daily_opportunity_scan.sh

# Weekly comprehensive analysis  
./weekly_deep_analysis.sh

# Performance analytics
./advanced_opportunity_analytics.sh

# ROI tracking
./track_mirador_roi.sh "Opportunity Name" value status
```

## 🎯 High-Value Prompt Templates

### Financial Planning
```bash
mirador-ez chain \
  "Create tax-optimized investment strategy for $62k income with $20k to invest" \
  financial_planning_expert_v6 opportunity_validator_v2 decision_simplifier
```

### Career Advancement
```bash
mirador-ez chain \
  "Path from $62k employee to $150k consultant in 18 months" \
  matthew_context_provider financial_planning_expert_v6 \
  enhanced_agent_enforcer decision_simplifier
```

### Business Opportunity
```bash
mirador-ez chain \
  "Validate Medicare compliance SaaS idea with revenue projections" \
  matthew_context_provider louisville_expert_v3 \
  financial_planning_expert_v6 opportunity_validator_v2
```

### Real Estate Investment
```bash
mirador-ez chain \
  "Analyze Louisville rental property investment with $40k down payment" \
  louisville_expert_v3 financial_planning_expert_v6 \
  opportunity_validator_v2 decision_simplifier
```

## 🔧 System Commands

```bash
# Check system status
./version_info.sh

# System maintenance
./system_maintenance.sh

# View recent outputs
ls -la outputs/ | tail -10

# Search past analyses
grep -r "rental property" outputs/*/summary.md
```

## 💡 Advanced Techniques

### Opportunity Stacking
```bash
mirador-ez chain \
  "Find 3 synergistic income streams using Medicare + AI skills" \
  mirador_system_specialist matthew_context_provider \
  financial_planning_expert_v6 opportunity_validator_v2
```

### Decision Matrix
```bash
mirador-ez chain \
  "Compare: consulting vs course creation vs SaaS development" \
  matthew_context_provider financial_planning_expert_v6 \
  opportunity_validator_v2 decision_simplifier
```

### Time Optimization
```bash
mirador-ez chain \
  "Redesign schedule to add $3k/month income without sacrificing family time" \
  matthew_context_provider enhanced_agent_enforcer \
  decision_simplifier
```

## 🎯 Model Specializations

| Model | Best For | Example Query |
|-------|----------|---------------|
| financial_planning_expert_v6 | Investment, budgets, tax strategy | "Tax-efficient withdrawal strategy" |
| louisville_expert_v3 | Local opportunities, real estate | "Best Louisville neighborhoods for rentals" |
| matthew_context_provider | Personal context integration | "How to monetize my specific skills" |
| opportunity_validator_v2 | ROI analysis, feasibility | "Validate this business idea" |
| decision_simplifier | Clear action steps | "Top 3 actions to take this week" |
| enhanced_agent_enforcer | Comprehensive analysis | "Deep dive on career transition" |
| mirador_system_specialist | System optimization | "Optimize my Mirador workflow" |

## ⚡ Speed Commands

```bash
# Quick morning check
alias morning="cd ~/ai_framework_git && ./daily_opportunity_scan.sh"

# Fast financial query
alias finance="mirador-ez ask financial_planning_expert_v6"

# Quick chain
alias chain="mirador-ez chain"
```

---

*Pro tip: Save your best prompts in a personal library for reuse and refinement*