# Mirador Quick Reference Guide

## 🚀 Essential Commands

### Daily Use
```bash
# Smart routing (auto-selects best chain)
./mirador-smart-v2 "Your question here"

# Quick opportunity scan
./quick_opportunity.sh

# System health check
./daily_check_enhanced.sh
```

### Specific Domains
```bash
# Financial planning
./mirador-smart-v2 "Create budget optimization plan"

# Music career
./mirador-smart-v2 "90-day guitar improvement roadmap"

# AI career transition
./mirador-smart-v2 "Build AI portfolio from Mirador project"

# Life optimization
./mirador-smart-v2 "Design optimal weekly schedule"
```

### Advanced Usage
```bash
# Custom chain (specify exact models)
./mirador-ez chain "Query" model1 model2 model3

# Test new model
echo "Query" | ollama run model_name

# View available models
ollama list | grep -E "(matthew|financial|enhanced|decision)"
```

## 🎯 Top 10 Power Prompts

1. **Weekly Planning**
   ```
   "Design this week's schedule optimizing for: music practice, family time, AI portfolio work, and energy management"
   ```

2. **Financial Optimization**
   ```
   "Find $500/month in budget without impacting family or music goals"
   ```

3. **Career Decision**
   ```
   "Should I pursue [specific opportunity]? Consider 3-year timeline, family impact, and financial requirements"
   ```

4. **Music Progress**
   ```
   "Create 30-day intensive practice plan for [specific skill/song/technique]"
   ```

5. **Opportunity Analysis**
   ```
   "Analyze [opportunity] for alignment with goals, ROI, and implementation feasibility"
   ```

6. **Daily Priorities**
   ```
   "What are my top 3 highest-impact actions for today?"
   ```

7. **Network Building**
   ```
   "How can I connect with [specific person/organization] within 30 days?"
   ```

8. **Skill Development**
   ```
   "Create learning path for [skill] that fits 1 hour/day schedule"
   ```

9. **Risk Assessment**
   ```
   "Evaluate risks and mitigation strategies for [major decision]"
   ```

10. **Meta-Optimization**
    ```
    "Review my last 10 queries and suggest better ways to use Mirador"
    ```

## 📊 Model Quick Reference

### Context Providers (Use First)
- `matthew_context_provider_v3` - Your complete profile
- `personality_context_provider` - Big Five traits
- `louisville_context_v3` - Local knowledge

### Domain Experts (Use Second)
- `financial_planning_expert_v6` - Money matters
- `music_industry_networker` - Music connections
- `enhanced_agent_enforcer` - Strategic thinking
- `ai_career_strategist` - Tech transition

### Decision Makers (Use Last)
- `decision_simplifier_v3` - Clear actions
- `action_prioritizer` - Ranked next steps
- `timeline_optimizer` - Scheduling

## ⚡ Performance Tips

1. **Optimal Chain Length**: 3-4 models (45-60 seconds)
2. **Fast Decisions**: Use 2-model chains (25-30 seconds)
3. **Deep Analysis**: Use 4-5 model chains (60-90 seconds)

## 🔧 Troubleshooting

| Issue | Solution |
|-------|----------|
| Model not found | Run `./deploy_production_mirador.sh` |
| Slow response | Restart Ollama: `ollama serve` |
| Out of memory | Close other apps, use shorter chains |
| Wrong output | Check model spelling, verify chain order |

## 📈 Success Patterns

### Morning Routine (6:00 AM)
1. Run daily check: `./daily_check_enhanced.sh`
2. Plan day: "What are today's top 3 priorities?"
3. Scan opportunities: `./quick_opportunity.sh`

### Evening Review (8:00 PM)
1. Assess progress: "What worked well today?"
2. Plan tomorrow: "Top 3 for tomorrow based on today?"
3. Adjust strategy: "Any pivots needed this week?"

### Weekly Planning (Sunday 5:00 PM)
1. Review week: "Key wins and lessons from this week?"
2. Set priorities: "Next week's big 3 objectives?"
3. Resource check: "Time/energy/money allocation optimal?"

## 🎯 Remember

- **Specific queries** get better results than general ones
- **Include constraints** (time, money, energy) for realistic advice
- **Stack prompts** - use output from one as input to another
- **Trust the process** - the models know your full context

---

**Need full documentation?**
- Technical: `MIRADOR_TECHNICAL_PAPER.md`
- Overview: `MIRADOR_ACADEMIC_PAPER.md`
- Prompts: `ENHANCED_PROMPT_LIBRARY.md`

**Observe. Adapt. Remain.**