# 🚀 Mirador Quick Reference Card

## 📍 Essential Commands

```bash
mirador-ez models                                    # List all available models
mirador-ez ask [MODEL] "question"                   # Single model query
mirador-ez chain "scenario" [MODEL1] [MODEL2]...    # Multi-model analysis
mirador-ez --help                                   # Get help
```

## 🤖 Core Models & Their Roles

| Model | Best For | Avg Time | Output |
|-------|----------|----------|--------|
| `matthew_context_provider` | Personal context, current situation | 12-15s | Your specific circumstances |
| `financial_planning_expert_v6` | Money decisions, investments, Louisville finance | 16-22s | Quantified financial advice |
| `louisville_expert_v2` | Local resources, Jefferson County info | 25-30s | Area-specific knowledge |
| `enhanced_agent_enforcer` | Strategic synthesis, implementation | 24-31s | Cross-domain integration |
| `decision_simplifier` | Action items, clear next steps | 10-12s | Prioritized task lists |

## ⚡ Proven Chain Patterns

### Financial Opportunities
```bash
# Quick financial analysis (50s)
mirador-ez chain "Financial planning scenario" financial_planning_expert_v6 enhanced_agent_enforcer

# Personal + financial optimization (57s)  
mirador-ez chain "Optimize monthly expenses for additional savings" matthew_context_provider financial_planning_expert_v6 decision_simplifier

# Complete investment analysis (79s)
mirador-ez chain "Investment opportunities" financial_planning_expert_v6 louisville_expert_v2 enhanced_agent_enforcer
```

### Career Development
```bash
# Career transition strategy (52s)
mirador-ez chain "Career transition analysis" matthew_context_provider enhanced_agent_enforcer

# Professional development plan
mirador-ez chain "3-year career advancement strategy" matthew_context_provider enhanced_agent_enforcer decision_simplifier
```

### Local Opportunities
```bash
# Louisville business opportunities
mirador-ez chain "Local business opportunities" louisville_expert_v2 financial_planning_expert_v6 enhanced_agent_enforcer

# Community engagement strategy
mirador-ez chain "Professional networking in Louisville" matthew_context_provider louisville_expert_v2 decision_simplifier
```

## 🎯 Single Model Quick Queries

### Financial Questions
```bash
mirador-ez ask financial_planning_expert_v6 "401k vs IRA for Louisville resident"
mirador-ez ask financial_planning_expert_v6 "Kentucky tax advantages for homeowners"
mirador-ez ask financial_planning_expert_v6 "Strategy to pay off $30k debt while saving"
```

### Personal Context
```bash
mirador-ez ask matthew_context_provider "Current professional strengths assessment"
mirador-ez ask matthew_context_provider "Personal financial situation summary"
mirador-ez ask matthew_context_provider "Career goals and risk tolerance"
```

### Louisville Resources
```bash
mirador-ez ask louisville_expert_v2 "Small business resources in Jefferson County"
mirador-ez ask louisville_expert_v2 "Professional networking organizations"
mirador-ez ask louisville_expert_v2 "Real estate investment neighborhoods"
```

### Strategic Analysis
```bash
mirador-ez ask enhanced_agent_enforcer "Risk analysis for career change"
mirador-ez ask enhanced_agent_enforcer "Implementation strategy for investment plan"
mirador-ez ask enhanced_agent_enforcer "Integration of multiple financial goals"
```

### Quick Decisions
```bash
mirador-ez ask decision_simplifier "Should I refinance my mortgage now?"
mirador-ez ask decision_simplifier "Prioritize: emergency fund vs 401k vs house down payment"
mirador-ez ask decision_simplifier "Next steps for starting consulting business"
```

## 📁 Output Locations

```bash
# View latest chain result
ls -t ~/ai_framework_git/outputs/ | head -1

# Read latest summary
ls -t ~/ai_framework_git/outputs/ | head -1 | xargs -I {} cat ~/ai_framework_git/outputs/{}/summary.md

# All outputs location
cd ~/ai_framework_git/outputs/
```

## 🎪 Example Scenarios

### Real Estate Investment
```bash
mirador-ez chain "Analyze Louisville duplex investment with $200k budget" financial_planning_expert_v6 louisville_expert_v2 enhanced_agent_enforcer
```

### Career + Financial Planning
```bash
mirador-ez chain "Career change impact on retirement savings" matthew_context_provider financial_planning_expert_v6 decision_simplifier
```

### Business Opportunity
```bash
mirador-ez chain "Start consulting business while keeping full-time job" matthew_context_provider financial_planning_expert_v6 decision_simplifier
```

### Expense Optimization
```bash
mirador-ez chain "Reduce monthly expenses by $500 without lifestyle impact" matthew_context_provider financial_planning_expert_v6 decision_simplifier
```

### Investment Strategy
```bash
mirador-ez chain "Invest $75k windfall for maximum Louisville tax efficiency" financial_planning_expert_v6 enhanced_agent_enforcer
```

## 📊 Performance Expectations

| Chain Type | Models | Time | Output Quality |
|------------|--------|------|----------------|
| 2-model | Any combination | 45-55s | 400-600 words |
| 3-model | Full analysis | 75-85s | 600-900+ words |
| Financial focus | Include financial_planning_expert_v6 | Standard | Quantified recommendations |
| Local focus | Include louisville_expert_v2 | +10-15s | Area-specific insights |
| Action focus | End with decision_simplifier | -5-10s | Clear next steps |

## 🛠️ Quick Troubleshooting

| Issue | Status | Action |
|-------|--------|--------|
| "Conductor not available" | ✅ Normal | Continue - system uses fixed chains |
| Chain takes 60-90 seconds | ✅ Normal | Wait - complex analysis in progress |
| Generic responses | 🔧 Fix | Be more specific in prompts |
| No Louisville context | 🔧 Fix | Include louisville_expert_v2 in chain |
| No personal context | 🔧 Fix | Start with matthew_context_provider |
| Need action items | 🔧 Fix | End chain with decision_simplifier |

## 💡 Pro Tips

**Prompt Writing:**
- Include specific dollar amounts, timeframes, goals
- Mention Louisville/Kentucky when relevant
- Define success metrics in your request

**Model Selection:**
- Start with context (matthew_context_provider)
- Add domain expertise (financial_planning_expert_v6, louisville_expert_v2)
- End with synthesis (enhanced_agent_enforcer) or action (decision_simplifier)

**Chain Optimization:**
- 2 models for focused analysis
- 3 models for comprehensive strategy
- Always end with action-oriented model for implementation

**Output Usage:**
- Read summary.md for final recommendations
- Check individual step outputs for model-specific insights
- Save important outputs for future reference

## 📞 Quick Command Lookup

```bash
# System check
mirador-ez models

# Financial advice
mirador-ez ask financial_planning_expert_v6 "[financial question]"

# Personal context
mirador-ez ask matthew_context_provider "[personal situation]"

# Local resources
mirador-ez ask louisville_expert_v2 "[Louisville question]"

# Strategic analysis
mirador-ez ask enhanced_agent_enforcer "[complex scenario]"

# Action items
mirador-ez ask decision_simplifier "[decision needed]"

# Full analysis
mirador-ez chain "[opportunity scenario]" [MODEL1] [MODEL2] [MODEL3]

# View results
cat ~/ai_framework_git/outputs/chain_*/summary.md
```

---

**🎯 Remember:** Mirador's strength is in combining multiple perspectives for comprehensive opportunity identification. The more specific your prompts, the more actionable your results!