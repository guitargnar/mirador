# Mirador AI Orchestration - Complete Usage Guide

## 🎯 Daily Workflow

### Morning Opportunity Scan (5-10 minutes)
Start each day by identifying your highest-value focus areas:

```bash
./daily_opportunity_scan.sh
```

This runs specialized queries across financial, career, and local domains to surface immediate opportunities.

### Targeted Single-Model Queries

For quick, focused insights:

```bash
# Financial planning query
mirador-ez ask financial_planning_expert_v6 \
  "Given my $62k salary and Medicare compliance expertise, what's the optimal strategy to build a $50k investment portfolio within 2 years while maintaining emergency funds?"

# Career advancement
mirador-ez ask matthew_context_provider \
  "What specific Medicare compliance consulting services could I offer to Louisville healthcare providers, and what would be the pricing structure?"

# Local opportunities
mirador-ez ask louisville_expert_v3 \
  "Which Louisville neighborhoods offer the best combination of appreciation potential and rental income for a $200k investment property?"
```

### Comprehensive Chain Analysis

For complex, multi-domain decisions requiring integrated insights:

```bash
# Career transition planning
mirador-ez chain \
  "Create a 6-month roadmap to transition from employee to Medicare compliance consultant earning $120k" \
  matthew_context_provider \
  financial_planning_expert_v6 \
  louisville_expert_v3 \
  enhanced_agent_enforcer \
  decision_simplifier

# Investment strategy
mirador-ez chain \
  "Analyze purchasing a rental property in Louisville's Highlands vs maxing retirement accounts vs starting a consulting business" \
  financial_planning_expert_v6 \
  louisville_expert_v3 \
  opportunity_validator_v2 \
  decision_simplifier

# Life optimization
mirador-ez chain \
  "Design a comprehensive plan to increase income by 50% while reducing work hours by 20%" \
  mirador_system_specialist \
  matthew_context_provider \
  financial_planning_expert_v6 \
  enhanced_agent_enforcer \
  opportunity_validator_v2 \
  decision_simplifier
```

## 📊 Weekly Deep Analysis

### Comprehensive Review (30-45 minutes)
Run every Sunday evening for strategic planning:

```bash
./weekly_deep_analysis.sh
```

### Performance Analytics
Review system insights and ROI:

```bash
./advanced_opportunity_analytics.sh
```

## 💰 ROI Tracking

Track implementation results to measure real-world impact:

```bash
# Track a new opportunity
./track_mirador_roi.sh "Medicare Compliance Workshop" 5000 "planned"

# Update status
./track_mirador_roi.sh "Medicare Compliance Workshop" 5000 "in-progress"

# Record completion
./track_mirador_roi.sh "Medicare Compliance Workshop" 5000 "completed"
```

## 🎯 Advanced Prompting Strategies

### High-Value Prompt Patterns

1. **Context-Rich Financial Planning**
   ```
   "As a Medicare compliance expert earning $62k in Louisville with a family of 3, 
   analyze the financial impact of starting a side consulting business charging 
   $150/hour for 10 hours/week. Include tax implications, healthcare considerations, 
   and 5-year wealth building projections."
   ```

2. **Opportunity Stacking**
   ```
   "Identify 3 synergistic opportunities that combine my Medicare expertise, 
   AI orchestration skills, and Louisville location to create multiple income 
   streams totaling $150k+ annually within 18 months."
   ```

3. **Decision Matrix Creation**
   ```
   "Compare these options with specific ROI projections: 
   1) Pursuing CMCP certification 
   2) Launching online Medicare compliance course 
   3) Starting local consulting practice 
   4) Building SaaS compliance tool
   Include time investment, revenue potential, and alignment with family goals."
   ```

### Chain Optimization Tips

1. **Model Order Matters**
   - Start with context providers (matthew_context_provider)
   - Add domain experts (financial, louisville)
   - Include enhancers (enhanced_agent_enforcer)
   - End with synthesizers (decision_simplifier)

2. **Prompt Engineering**
   - Include specific numbers and timeframes
   - Reference your actual expertise and constraints
   - Ask for implementation steps, not just advice
   - Request measurable success metrics

3. **Iteration Strategy**
   - Run initial broad analysis
   - Identify most promising opportunities
   - Deep-dive with targeted chains
   - Validate with opportunity_validator_v2

## 🔧 System Maintenance

### Daily Health Check
```bash
# Quick status verification
./version_info.sh
```

### Weekly Maintenance
```bash
# Full system health check
./system_maintenance.sh
```

### Monthly Optimization
```bash
# Analyze patterns and optimize
./monthly_optimization.sh
```

## 📈 Measuring Success

### Key Metrics to Track
1. **Time Saved**: Hours not spent on research/analysis
2. **Opportunities Identified**: Number and quality
3. **Implementation Rate**: Ideas actually executed
4. **Financial Impact**: Measurable ROI
5. **Life Quality**: Work-life balance improvements

### Success Indicators
- Consistent daily usage (habit formation)
- Increasing ROI from implemented opportunities
- Reduced decision-making time
- Higher confidence in major decisions
- More time for family and personal pursuits

## 🚨 Troubleshooting

### Common Issues

1. **Ollama Not Running**
   ```bash
   brew services restart ollama
   ```

2. **Model Not Found**
   ```bash
   ollama list  # Check available models
   ollama pull [model_name]  # Re-download if needed
   ```

3. **Slow Performance**
   - Close other applications
   - Ensure adequate disk space
   - Run system maintenance script

## 💡 Pro Tips

1. **Batch Similar Queries**: Run related analyses together for better context
2. **Document Insights**: Keep a decision journal alongside outputs
3. **Set Implementation Deadlines**: Convert insights to calendar events
4. **Review Past Analyses**: Learn from what worked
5. **Share Successes**: Build accountability through progress sharing

---

*Remember: Mirador's value compounds over time. Consistent daily use leads to exponential life improvements.*