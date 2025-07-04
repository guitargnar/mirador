# Mirador Model Capabilities Analysis

Based on the documentation review, I've identified the key specialist models and their optimal usage patterns for creating effective chain prompts:

## Core Specialist Models

### Context and Personalization
- **matthew_context_provider_v2**: Primary personalization model, should start most chains
- **louisville_expert_v3**: Local context and opportunities

### Music Career Development
- **master_guitar_instructor**: Guitar technique, theory, and skill development
- **music_industry_networker**: Industry connections and networking strategies
- **touring_readiness_coach**: Performance preparation and touring logistics
- **performance_anxiety_coach**: Mental preparation and confidence building
- **guitar_tone_architect**: Sound design and audio engineering
- **music_career_timeline_strategist**: Long-term career planning

### Professional Development
- **financial_planning_expert_v6**: Financial strategy and planning
- **mirador_system_specialist**: System optimization and quality analysis
- **enhanced_agent_enforcer**: Quality assurance and enhancement

### Decision Making
- **decision_simplifier**: Should end most chains, provides clear actionable outcomes

## Optimal Chain Patterns

### Speed Optimized (2 models)
- financial_planning_expert_v6 → decision_simplifier

### Quality Optimized (3 models)
- mirador_system_specialist → enhanced_agent_enforcer → decision_simplifier

### Balanced Approach (2 models)
- mirador_system_specialist → decision_simplifier

### Personalized Analysis (3-4 models)
- matthew_context_provider_v2 → [specialist] → [specialist] → decision_simplifier

## Chain Length Guidelines
- **Quick decisions**: 2-3 models
- **Strategic planning**: 4-6 models
- **Complex analysis**: 4-6 models with multiple specialists
- **Daily operations**: 2-3 models for efficiency

