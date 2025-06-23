# Mirador Model Inventory

## 📊 Complete Model Catalog

### Core Context & Decision Models
| Model Name | File Path | Purpose | Parameters |
|------------|-----------|---------|------------|
| matthew_context_provider_v2 | ~/ai_framework_git/matthew_context_provider_v2.modelfile | Personal context and values alignment | temp: 0.7, top_p: 0.9 |
| matthew_context_provider_optimized | ~/ai_framework_git/matthew_context_provider_optimized.modelfile | Optimized personal context | temp: 0.6, top_p: 0.85 |
| decision_simplifier_v2 | ~/ai_framework_git/decision_simplifier_v2.modelfile | Action-focused synthesis and recommendations | temp: 0.4, top_p: 0.85 |
| enhanced_agent_enforcer_v2 | ~/ai_framework_git/enhanced_agent_enforcer_v2.modelfile | Strategic implementation and analysis | temp: 0.6, top_p: 0.9 |

### Domain Expert Models
| Model Name | File Path | Purpose | Specialization |
|------------|-----------|---------|----------------|
| financial_planning_expert_v6 | ~/ai_framework_git/financial_planning_expert_v6.modelfile | Louisville-specific financial guidance | Healthcare income, local investments |
| financial_planning_expert_optimized | ~/ai_framework_git/financial_planning_expert_optimized.modelfile | Optimized financial planning | Enhanced performance parameters |
| louisville_expert_v3 | ~/ai_framework_git/louisville_expert_v3.modelfile | Local market and community intelligence | Jefferson County resources |
| health_wellness_optimizer | ~/ai_framework_git/health_wellness_optimizer.modelfile | Healthcare and wellness optimization | Medical compliance background |

### Music & Creative Models
| Model Name | File Path | Purpose | Specialization |
|------------|-----------|---------|----------------|
| master_guitar_instructor | ~/ai_framework_git/master_guitar_instructor.modelfile | Guitar technique, theory, tablature | Metal, rock, touring preparation |
| music_industry_networker | ~/ai_framework_git/music_industry_networker.modelfile | Industry connections and opportunities | Touring bands, session work |
| linkedin_voice_architect | ~/ai_framework_git/linkedin_voice_architect.modelfile | Professional content creation | AI/music thought leadership |
| audio_production_strategist | ~/ai_framework_git/audio_production_strategist.modelfile | Logic Pro X and recording workflows | Guitar recording, mixing |
| digital_storyteller | ~/ai_framework_git/digital_storyteller.modelfile | Narrative content creation | Technical to accessible translation |
| touring_readiness_coach | ~/ai_framework_git/touring_readiness_coach.modelfile | Tour preparation and logistics | Professional musician development |

### Professional Development Models
| Model Name | File Path | Purpose | Specialization |
|------------|-----------|---------|----------------|
| resume_crafter | ~/ai_framework_git/resume_crafter.modelfile | Industry-specific resume creation | ATS optimization, multiple industries |
| communication_strategist | ~/ai_framework_git/communication_strategist.modelfile | Outreach and networking messages | Value-first messaging |
| lead_generator | ~/ai_framework_git/lead_generator.modelfile | Contact research and qualification | Music industry contacts |
| resource_gatherer | ~/ai_framework_git/resource_gatherer.modelfile | URL and reference discovery | Verified, current resources |

### System Management Models
| Model Name | File Path | Purpose | Specialization |
|------------|-----------|---------|----------------|
| mirador_self_reflection_guardian | ~/ai_framework_git/mirador_self_reflection_guardian.modelfile | Performance monitoring and optimization | System consciousness |
| macbook_system_organizer | ~/ai_framework_git/macbook_system_organizer.modelfile | System health and optimization | macOS, Logic Pro X optimization |
| opportunity_validator_v2 | ~/ai_framework_git/opportunity_validator_v2.modelfile | Opportunity assessment and scoring | ROI analysis, feasibility |
| feedback_loop_optimizer | ~/ai_framework_git/feedback_loop_optimizer.modelfile | System learning and improvement | Performance enhancement |
| cross_model_synthesizer | ~/ai_framework_git/cross_model_synthesizer.modelfile | Multi-model output integration | Synthesis and coordination |

### Content & Brand Models
| Model Name | File Path | Purpose | Specialization |
|------------|-----------|---------|----------------|
| content_strategist_pro | ~/ai_framework_git/content_strategist_pro.modelfile | Strategic content planning | Multi-platform content |
| personal_brand_architect | ~/ai_framework_git/personal_brand_architect.modelfile | Brand positioning and development | Professional musician branding |
| engagement_optimizer | ~/ai_framework_git/engagement_optimizer.modelfile | Social media optimization | LinkedIn engagement |
| sales_content_creator | ~/ai_framework_git/sales_content_creator.modelfile | Sales and proposal content | Service offerings |

### Enhanced Agent Variants
| Model Name | File Path | Purpose | Version Notes |
|------------|-----------|---------|---------------|
| enhanced_agent_fast_v7 | ~/ai_framework_git/enhanced_agent_fast_v7.modelfile | Speed-optimized analysis | Latest fast variant |
| enhanced_agent_fast_v6 | ~/ai_framework_git/enhanced_agent_fast_v6.modelfile | Balanced speed/quality | Stable version |
| enhanced_agent_builder | ~/ai_framework_git/enhanced_agent_builder.modelfile | System building and architecture | Meta-development |

### Specialized Expert Models
| Model Name | File Path | Purpose | Domain |
|------------|-----------|---------|--------|
| productivity_optimizer | ~/ai_framework_git/productivity_optimizer.modelfile | Workflow and efficiency optimization | Personal productivity |
| parenting_decision_support | ~/ai_framework_git/parenting_decision_support.modelfile | Father-daughter guidance | 8-year-old development |
| real_estate_analyzer | ~/ai_framework_git/real_estate_analyzer.modelfile | Property investment analysis | Louisville market |
| guitar_expert_precise | ~/ai_framework_git/guitar_expert_precise.modelfile | Advanced guitar techniques | Precision instruction |
| mirador_system_specialist | ~/ai_framework_git/mirador_system_specialist.modelfile | System optimization and meta-analysis | Framework enhancement |

## 🔧 Model Creation Commands

### Create All Core Models
```bash
# Core context models
ollama create matthew_context_provider_v2 -f matthew_context_provider_v2.modelfile
ollama create decision_simplifier_v2 -f decision_simplifier_v2.modelfile
ollama create enhanced_agent_enforcer_v2 -f enhanced_agent_enforcer_v2.modelfile

# Music career models
ollama create master_guitar_instructor -f master_guitar_instructor.modelfile
ollama create music_industry_networker -f music_industry_networker.modelfile
ollama create linkedin_voice_architect -f linkedin_voice_architect.modelfile
ollama create touring_readiness_coach -f touring_readiness_coach.modelfile

# Professional models
ollama create resume_crafter -f resume_crafter.modelfile
ollama create communication_strategist -f communication_strategist.modelfile
ollama create lead_generator -f lead_generator.modelfile
ollama create resource_gatherer -f resource_gatherer.modelfile

# System management models
ollama create mirador_self_reflection_guardian -f mirador_self_reflection_guardian.modelfile
ollama create macbook_system_organizer -f macbook_system_organizer.modelfile
```

### Verify Model Installation
```bash
# Check all models
ollama list

# Test core functionality
mirador-ez ask matthew_context_provider_v2 "What are my current priorities?"
mirador-ez ask master_guitar_instructor "Show me a basic metal riff"
mirador-ez ask music_industry_networker "Current touring opportunities"
```

## 📈 Model Performance Characteristics

### Response Time Expectations
- **Fast Models** (enhanced_agent_fast_*): 10-30 seconds
- **Standard Models**: 30-60 seconds
- **Complex Analysis Models**: 60-120 seconds

### Quality Indicators
- **Context Awareness**: Models understand personal situation
- **Actionable Output**: Specific, implementable recommendations
- **Domain Expertise**: Specialized knowledge in focus areas
- **Consistency**: Reliable performance across queries

### Optimization Notes
- Models are tuned for specific temperature/top_p values
- Context window optimized for chain execution
- Progressive enhancement across model sequences
- Fallback handling for model failures

## 🎯 Recommended Model Chains

### Music Career Development
```bash
# Networking strategy
matthew_context_provider_v2 → music_industry_networker → communication_strategist → decision_simplifier_v2

# Skill development
master_guitar_instructor → audio_production_strategist → digital_asset_curator

# Content creation
matthew_context_provider_v2 → linkedin_voice_architect → engagement_optimizer

# Tour preparation
touring_readiness_coach → master_guitar_instructor → macbook_system_organizer
```

### Professional Growth
```bash
# Career advancement
matthew_context_provider_v2 → enhanced_agent_enforcer_v2 → decision_simplifier_v2

# Financial planning
matthew_context_provider_v2 → financial_planning_expert_v6 → opportunity_validator_v2

# System optimization
mirador_self_reflection_guardian → macbook_system_organizer → productivity_optimizer

# Content strategy
matthew_context_provider_v2 → content_strategist_pro → linkedin_voice_architect
```

### Daily Optimization
```bash
# Morning planning
matthew_context_provider_v2 → enhanced_agent_enforcer_v2 → decision_simplifier_v2

# Quick decisions
decision_simplifier_v2 (single model for fast responses)

# Evening reflection
matthew_context_provider_v2 → mirador_self_reflection_guardian → productivity_optimizer
```

## 📊 Model Usage Statistics

### Most Frequently Used Models
1. **matthew_context_provider_v2** - Core personal context
2. **decision_simplifier_v2** - Daily decision support
3. **enhanced_agent_enforcer_v2** - Strategic analysis
4. **master_guitar_instructor** - Music skill development
5. **linkedin_voice_architect** - Content creation

### Specialized Use Cases
- **Financial Planning**: financial_planning_expert_v6 + opportunity_validator_v2
- **Music Industry**: music_industry_networker + communication_strategist
- **System Health**: mirador_self_reflection_guardian + macbook_system_organizer
- **Content Creation**: linkedin_voice_architect + engagement_optimizer
- **Career Development**: enhanced_agent_enforcer_v2 + resume_crafter

## 🔄 Model Maintenance

### Regular Updates
- Monitor model performance via mirador_self_reflection_guardian
- Update model parameters based on usage patterns
- Create new specialized models as needs evolve
- Archive unused models to free resources

### Performance Optimization
- Adjust temperature/top_p based on output quality
- Optimize context windows for chain efficiency
- Monitor response times and adjust timeouts
- Balance model complexity with performance needs

### Backup and Recovery
- Regular backup of .modelfile definitions
- Version control for model configurations
- Test model recreation procedures
- Document model dependencies and relationships

---
*Total Models: 65+ specialized AI agents working toward your touring guitarist goal*

## 📁 File Path Reference

All model files are located in: `~/ai_framework_git/`

### Quick Access Commands
```bash
# Navigate to model directory
cd ~/ai_framework_git

# List all model files
ls -la *.modelfile

# Search for specific model
ls -la *guitar*
ls -la *music*
ls -la *linkedin*

# Check model file contents
cat master_guitar_instructor.modelfile
cat music_industry_networker.modelfile
```

### Model File Naming Convention
- **Core Models**: `[name]_v[version].modelfile`
- **Optimized Variants**: `[name]_optimized.modelfile`
- **Fast Variants**: `[name]_fast_v[version].modelfile`
- **Specialized**: `[domain]_[function].modelfile`

This inventory provides complete visibility into your Mirador model ecosystem, enabling effective management and optimization of your AI orchestration platform.

