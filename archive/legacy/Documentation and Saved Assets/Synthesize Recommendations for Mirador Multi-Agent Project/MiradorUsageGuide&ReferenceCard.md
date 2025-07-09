# Mirador Usage Guide & Reference Card

## 🚀 Quick Reference

### Essential Commands
```bash
# System Status
mirador-ez models                    # List all available models
./health_check.sh                    # System health and performance

# Basic Queries
mirador-ez ask [model] "[question]"  # Single model query
mirador-ez auto "[complex query]"    # Intelligent chain selection
mirador-ez chain "[task]" model1 model2 model3  # Custom chain

# Daily Workflows
./morning_intelligence_brief.sh      # Start your day with insights
./evening_optimization_review.sh     # End-of-day reflection and planning
```

### Music Career Commands
```bash
# Guitar and Music
mirador-ez ask master_guitar_instructor "Show me metal riffs for touring bands"
mirador-ez ask music_industry_networker "Find touring opportunities this month"

# Content Creation
./quick_linkedin_post.sh "AI in music production"
mirador-ez ask linkedin_voice_architect "Create post about guitar and technology"

# Networking
mirador-ez chain "Prepare outreach to Jelly Roll's team" music_industry_networker communication_strategist
```

## 📋 Model Categories & Usage

### Core Context Models
- **matthew_context_provider_v2**: Personal context, values, and situation
- **decision_simplifier_v2**: Action-focused recommendations
- **enhanced_agent_enforcer_v2**: Strategic analysis and implementation

### Domain Experts
- **financial_planning_expert_v6**: Louisville-specific financial guidance
- **louisville_expert_v3**: Local market and community intelligence
- **health_wellness_optimizer**: Healthcare and wellness optimization

### Music & Creative
- **master_guitar_instructor**: Guitar technique, theory, tablature
- **music_industry_networker**: Industry connections and opportunities
- **linkedin_voice_architect**: Professional content creation
- **audio_production_strategist**: Logic Pro X and recording workflows

### Professional Development
- **resume_crafter**: Industry-specific resume creation
- **communication_strategist**: Outreach and networking messages
- **lead_generator**: Contact research and qualification

### System Management
- **mirador_self_reflection_guardian**: Performance monitoring and optimization
- **macbook_system_organizer**: System health and optimization

## 🎯 Common Workflows

### Daily Optimization
```bash
# Morning routine
./morning_intelligence_brief.sh

# Quick decisions
mirador-ez ask decision_simplifier_v2 "What should I prioritize today?"

# Evening reflection
./evening_optimization_review.sh
```

### Music Career Development
```bash
# Skill development
mirador-ez ask master_guitar_instructor "Advanced metal techniques for session work"

# Industry networking
mirador-ez chain "Research touring bands needing guitarists" lead_generator music_industry_networker communication_strategist

# Content creation
mirador-ez chain "Create LinkedIn content about music and AI" matthew_context_provider_v2 linkedin_voice_architect
```

### Professional Growth
```bash
# Career planning
mirador-ez chain "Advance my healthcare compliance career" matthew_context_provider_v2 enhanced_agent_enforcer_v2 decision_simplifier_v2

# Resume optimization
mirador-ez ask resume_crafter "Create resume for music industry role"

# LinkedIn strategy
./quick_linkedin_post.sh "Innovation in healthcare AI"
```

## 🔧 Advanced Usage

### Custom Chain Creation
```bash
# Financial planning chain
mirador-ez chain "Investment strategy for musicians" matthew_context_provider_v2 financial_planning_expert_v6 decision_simplifier_v2

# Creative project chain
mirador-ez chain "Plan music production workflow" audio_production_strategist master_guitar_instructor digital_asset_curator
```

### System Optimization
```bash
# Performance monitoring
./system_validation.sh              # Comprehensive system test
./mirador_maintenance.sh             # Optimization and cleanup
./monitor_mirador_performance.sh     # Real-time monitoring
```

### Automation Setup
```bash
# Schedule daily workflows
./setup_maintenance_cron.sh         # Automated scheduling

# Custom automation
./create_action_tracker.sh          # Goal tracking
./opportunity_dashboard.sh          # Opportunity monitoring
```

## 📊 Output Management

### Understanding Outputs
- **Chain Outputs**: Saved to `outputs/chain_YYYYMMDD_HHMMSS/`
- **Individual Files**: Each model's response saved separately
- **Summary**: Comprehensive analysis in `summary.md`

### Finding Results
```bash
# Recent outputs
ls -la outputs/ | head -10

# Specific chain results
cd outputs/chain_20241216_143022/
cat summary.md

# Search outputs
grep -r "touring opportunities" outputs/
```

## 🎸 Music-Specific Workflows

### Guitar Skill Development
```bash
# Technical practice
mirador-ez ask master_guitar_instructor "Progressive metal techniques for touring"

# Song learning
mirador-ez ask master_guitar_instructor "Break down [song name] structure and tabs"

# Gear optimization
mirador-ez ask audio_production_strategist "Touring guitar rig setup"
```

### Industry Networking
```bash
# Research contacts
mirador-ez ask lead_generator "Find tour managers for metal bands"

# Craft outreach
mirador-ez ask communication_strategist "Message template for session work inquiry"

# Leverage connections
mirador-ez chain "Strategy to connect with Cody Ash network" music_industry_networker communication_strategist
```

### Content Strategy
```bash
# LinkedIn presence
mirador-ez chain "Build thought leadership in music tech" linkedin_voice_architect matthew_context_provider_v2

# Portfolio development
mirador-ez ask digital_asset_curator "Organize music recordings for industry showcase"
```

## 🚨 Troubleshooting

### Common Issues
```bash
# Model not responding
ollama list                          # Check if model exists
ollama pull llama3.2                # Reinstall base model

# Chain failures
./health_check.sh                    # System diagnostics
./system_validation.sh               # Comprehensive testing

# Performance issues
./mirador_maintenance.sh             # System optimization
./optimize_model_parameters.sh      # Model tuning
```

### Getting Help
```bash
# System status
mirador-ez models                    # Available models
./health_check.sh                    # Health diagnostics

# Performance analysis
./performance_analysis.sh            # Detailed metrics
./output_quality_analyzer.sh        # Output assessment
```

## 💡 Pro Tips

1. **Start Simple**: Use `mirador-ez auto` for complex queries
2. **Build Gradually**: Add models to chains as needed
3. **Monitor Performance**: Regular health checks prevent issues
4. **Leverage Automation**: Daily scripts compound benefits over time
5. **Focus on Goals**: Every query should serve your touring guitarist objective

## 📅 Recommended Daily Schedule

### Morning (15 minutes)
```bash
./morning_intelligence_brief.sh      # Daily priorities and opportunities
mirador-ez ask master_guitar_instructor "Today's practice focus"
```

### Midday (5 minutes)
```bash
mirador-ez ask decision_simplifier_v2 "Quick decision on [current issue]"
```

### Evening (10 minutes)
```bash
./evening_optimization_review.sh     # Reflection and tomorrow's prep
mirador-ez ask music_industry_networker "Today's networking opportunities"
```

### Weekly (30 minutes)
```bash
./weekly_strategic_deep_dive.sh      # Comprehensive planning
mirador-ez chain "This week's music career progress" master_guitar_instructor music_industry_networker touring_readiness_coach
```

## 🎯 Goal-Oriented Command Patterns

### For Touring Guitarist Goal
```bash
# Skill Assessment
mirador-ez chain "Evaluate my touring readiness" master_guitar_instructor touring_readiness_coach decision_simplifier_v2

# Opportunity Research
mirador-ez chain "Find this month's touring opportunities" lead_generator music_industry_networker communication_strategist

# Network Building
mirador-ez chain "Leverage Cody Ash connection for opportunities" music_industry_networker communication_strategist decision_simplifier_v2

# Content Strategy
mirador-ez chain "Create music industry thought leadership content" matthew_context_provider_v2 linkedin_voice_architect engagement_optimizer
```

### For Professional Excellence
```bash
# Career Development
mirador-ez chain "Advance healthcare compliance career" matthew_context_provider_v2 enhanced_agent_enforcer_v2 decision_simplifier_v2

# AI Innovation
mirador-ez chain "Bring AI value to Company role" matthew_context_provider_v2 enhanced_agent_enforcer_v2 communication_strategist

# Skill Building
mirador-ez ask enhanced_agent_enforcer_v2 "Professional development priorities for healthcare AI"
```

### For Family Priorities
```bash
# Parenting Support
mirador-ez ask parenting_decision_support "Teaching my 8-year-old about [topic]"

# Work-Life Balance
mirador-ez chain "Balance touring goals with family priorities" matthew_context_provider_v2 decision_simplifier_v2

# Financial Planning
mirador-ez chain "Family financial security while pursuing music career" matthew_context_provider_v2 financial_planning_expert_v6 decision_simplifier_v2
```

---
*Master these workflows to accelerate your path to touring success! 🎸*

