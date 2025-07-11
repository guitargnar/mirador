# Mirador AI Framework - Chain Reference Guide

## Table of Contents
- [Overview](#overview)
- [Chain Types](#chain-types)
- [Universal Chains](#universal-chains)
- [Specialized Chains](#specialized-chains)
- [Chain Selection Guide](#chain-selection-guide)
- [Chain Composition Patterns](#chain-composition-patterns)
- [Performance Characteristics](#performance-characteristics)
- [Custom Chain Creation](#custom-chain-creation)

## Overview

Chains are sequences of models that work together to solve complex problems. Each model in a chain receives the original query plus enriched context from previous models, building a comprehensive understanding and response.

### Key Principles

1. **Context Accumulation**: Each model adds to the growing context
2. **Specialization Order**: General → Specific → Implementation
3. **Quality Through Collaboration**: Multiple perspectives improve output
4. **Constraint Awareness**: Real-world limitations guide all chains

## Chain Types

### Intent-Based Chains (Smart Router)

The Smart Router (v3) automatically selects chains based on query intent:

| Intent | Chain Name | Models | Use Case |
|--------|------------|--------|----------|
| technical | Technical Chain | matthew_context → master_coder → command_r_code_analyst → practical_implementer | Code, debugging, automation |
| quick | Quick Response | speed_optimizer_phi | Immediate answers |
| financial | Financial Chain | matthew_context → universal_financial_advisor → practical_implementer | Money, budgeting |
| health | Health Chain | matthew_context → universal_health_wellness → practical_implementer | Wellness, fitness |
| location | Location Chain | universal_louisville_expert → practical_implementer | Local knowledge |
| music | Music Chain | matthew_context → universal_music_mentor → creative_catalyst | Guitar, practice |
| career | Career Chain | matthew_context → universal_career_strategist → universal_corporate_navigator | Professional growth |
| creative | Creative Chain | creative_catalyst → universal_strategy_architect → practical_implementer | Innovation, ideas |
| family | Family Chain | matthew_context → universal_relationship_harmony → practical_implementer | Parenting, relationships |
| strategic | Strategic Chain | matthew_context → universal_strategy_architect → analytical_expert_gemma → practical_implementer | Planning, analysis |

## Universal Chains

### 1. Life Optimization

**Purpose**: Holistic life improvement and balance  
**Command**: `./mirador_universal_runner_v2.sh life_optimization "Your query"`

**Model Sequence**:
1. matthew_context_provider_v6_complete
2. universal_life_optimizer
3. practical_implementer

**Best For**:
- Work-life balance questions
- Personal productivity optimization
- Time management strategies
- Energy level optimization

**Example Queries**:
- "How can I balance family time with career advancement?"
- "Optimize my daily routine for maximum productivity"
- "Help me manage energy levels throughout the day"

### 2. Business Acceleration

**Purpose**: Business strategy and growth  
**Command**: `./mirador_universal_runner_v2.sh business_acceleration "Your query"`

**Model Sequence**:
1. matthew_context_provider_v6_complete
2. business_strategist_fast
3. universal_strategy_architect
4. practical_implementer

**Best For**:
- Corporate strategy development
- Career advancement planning
- Business process optimization
- Innovation initiatives

**Example Queries**:
- "Create a roadmap to VP of AI Innovation"
- "Develop strategy for AI adoption at Humana"
- "Build influence in corporate environment"

### 3. Creative Breakthrough

**Purpose**: Innovation and creative problem solving  
**Command**: `./mirador_universal_runner_v2.sh creative_breakthrough "Your query"`

**Model Sequence**:
1. creative_catalyst
2. universal_strategy_architect
3. practical_implementer

**Best For**:
- Innovative solutions
- Creative problem solving
- Breaking mental blocks
- New perspectives

**Example Queries**:
- "Generate innovative AI use cases for healthcare"
- "Creative solutions for team engagement"
- "Break through this technical challenge creatively"

### 4. Relationship Harmony

**Purpose**: Family and relationship guidance  
**Command**: `./mirador_universal_runner_v2.sh relationship_harmony "Your query"`

**Model Sequence**:
1. matthew_context_provider_v6_complete
2. universal_relationship_harmony
3. practical_implementer

**Best For**:
- Parenting teenagers
- Family dynamics
- Work-life boundaries
- Communication strategies

**Example Queries**:
- "How to connect with my teenage daughter"
- "Balance family needs with career ambitions"
- "Navigate difficult family conversations"

### 5. Technical Mastery

**Purpose**: Technical problem solving and automation  
**Command**: `./mirador_universal_runner_v2.sh technical_mastery "Your query"`

**Model Sequence**:
1. matthew_context_provider_v6_complete
2. master_coder
3. solution_architect
4. practical_implementer

**Best For**:
- Coding challenges
- Automation scripts
- Technical architecture
- Performance optimization

**Example Queries**:
- "Write Python script for data processing"
- "Optimize SQL query performance"
- "Design microservices architecture"

### 6. Strategic Synthesis

**Purpose**: High-level strategic planning  
**Command**: `./mirador_universal_runner_v2.sh strategic_synthesis "Your query"`

**Model Sequence**:
1. matthew_context_provider_v6_complete
2. universal_strategy_architect
3. cross_model_synthesizer
4. optimized_decision_simplifier_v3

**Best For**:
- Long-term planning
- Complex decision making
- Multi-stakeholder strategies
- Risk assessment

**Example Queries**:
- "5-year career strategy with contingencies"
- "Analyze risks and opportunities in AI leadership"
- "Strategic approach to work-life integration"

## Specialized Chains

### 7. Deep Analysis (v3 Optimized)

**Purpose**: Thorough analytical investigation  
**Command**: `./mirador_universal_runner_v3_optimized.sh deep_analysis "Your query"`

**Model Sequence**:
1. matthew_context_provider_v5_complete
2. analytical_expert_gemma
3. universal_strategy_architect
4. practical_implementer

**Unique Features**:
- Uses Gemma 27B for superior reasoning
- Deeper analytical depth
- Evidence-based recommendations

### 8. Global Insight (v3 Optimized)

**Purpose**: Multicultural and global perspectives  
**Command**: `./mirador_universal_runner_v3_optimized.sh global_insight "Your query"`

**Model Sequence**:
1. matthew_context_provider_v3
2. multilingual_assistant_qwen
3. engagement_optimizer
4. action_crystallizer

**Unique Features**:
- Uses Qwen 32B for cultural awareness
- Multiple language understanding
- Global perspective integration

### 9. Rapid Decision (v3 Optimized)

**Purpose**: Fast decision making  
**Command**: `./mirador_universal_runner_v3_optimized.sh rapid_decision "Your query"`

**Model Sequence**:
1. speed_optimizer_phi
2. matthew_context_provider_v3
3. action_crystallizer

**Unique Features**:
- Uses Phi-3 for speed
- Sub-10 second responses
- Action-oriented output

## Chain Selection Guide

### Decision Tree

```
Is the query...
├── Asking for quick info? → quick (speed_optimizer_phi)
├── About code/technical? → technical_mastery
├── About money/budget? → financial chain
├── About health/wellness? → health chain
├── About Louisville/local? → location chain
├── About music/guitar? → music chain
├── About career/work? → business_acceleration
├── About family/teens? → relationship_harmony
├── Requiring creativity? → creative_breakthrough
├── Requiring deep analysis? → deep_analysis
├── Requiring strategy? → strategic_synthesis
└── General/complex? → strategic_synthesis (default)
```

### Selection Criteria

1. **Time Sensitivity**
   - Urgent: rapid_decision or quick
   - Standard: Any universal chain
   - Deep dive: deep_analysis or strategic_synthesis

2. **Domain Specificity**
   - Technical: technical_mastery
   - Business: business_acceleration
   - Personal: life_optimization
   - Creative: creative_breakthrough

3. **Output Requirements**
   - Action items: chains ending with practical_implementer
   - Analysis: deep_analysis
   - Ideas: creative_breakthrough
   - Quick facts: quick response

## Chain Composition Patterns

### Pattern 1: Context-First
```
matthew_context_provider → domain_expert → implementer
```
Used when personal context is crucial

### Pattern 2: Speed-First
```
speed_optimizer → context (optional) → crystallizer
```
Used for rapid responses

### Pattern 3: Analysis-First
```
analytical_expert → strategy → synthesis → implementer
```
Used for complex problems

### Pattern 4: Creative-First
```
creative_catalyst → strategy → implementer
```
Used for innovation needs

### Pattern 5: Domain-Only
```
domain_expert → implementer
```
Used for pure expertise queries

## Performance Characteristics

### Response Times by Chain

| Chain Type | Models | Typical Time | Token Usage |
|------------|--------|--------------|-------------|
| Quick | 1 | 2-3s | ~500 |
| Simple (2 models) | 2 | 8-12s | ~2000 |
| Standard (3-4 models) | 3-4 | 15-25s | ~4000 |
| Complex (5+ models) | 5+ | 30-45s | ~6000 |

### Quality vs Speed Trade-offs

1. **Fastest**: quick, rapid_decision
2. **Balanced**: Most universal chains
3. **Highest Quality**: deep_analysis, strategic_synthesis

### Resource Usage

- **Memory**: 4-24GB depending on model sizes
- **CPU**: Single-threaded, sequential processing
- **Storage**: ~1MB per session output

## Custom Chain Creation

### 1. Define Chain Purpose

```yaml
Chain: custom_analysis
Purpose: Specific analytical need
Target: Complex technical decisions
Output: Detailed recommendation with code
```

### 2. Select Models

```bash
# Choose models based on:
# - Context needs (matthew_context_provider)
# - Domain expertise (domain_expert)
# - Analysis depth (analytical_expert)
# - Output format (practical_implementer)
```

### 3. Create Chain Script

```bash
#!/bin/bash
# custom_chain.sh

MODELS=(
    "matthew_context_provider_v6_complete"
    "technical_expert"
    "analytical_expert_gemma"
    "practical_implementer"
)

# Chain execution logic
for MODEL in "${MODELS[@]}"; do
    # ... model execution
done
```

### 4. Test Chain

```bash
./custom_chain.sh "Test query"
```

### 5. Optimize

- Adjust model order
- Add/remove models
- Tune prompts

## Advanced Chain Features

### Output Formats

All chains support format options:
- `quick`: Key points only
- `summary`: Executive summary
- `detailed`: Full analysis (default)
- `export`: Save to file

Example:
```bash
./mirador_universal_runner_v2.sh life_optimization "Query" quick
```

### Chain Debugging

Enable debug mode:
```bash
DEBUG=1 ./mirador_universal_runner_v2.sh strategic_synthesis "Query"
```

### Chain Metrics

Track in output directories:
- Model response times
- Token usage per model
- Total chain duration
- Output quality (via feedback)

## Best Practices

### 1. Query Formulation
- Be specific about desired outcome
- Include context when relevant
- Specify constraints upfront

### 2. Chain Selection
- Use smart router for automatic selection
- Override only when specific need
- Consider time vs quality trade-off

### 3. Output Usage
- Review full chain output in detailed mode
- Use summary for quick decisions
- Export for documentation

### 4. Feedback Loop
- Rate outputs for quality
- Log routing issues
- Suggest chain improvements

## Troubleshooting

### Common Issues

1. **Slow Response**
   - Check model sizes in chain
   - Consider using rapid_decision
   - Ensure models are pre-loaded

2. **Poor Quality**
   - Verify correct chain selection
   - Check if context provider included
   - Review model compatibility

3. **Context Overflow**
   - Break into smaller queries
   - Use summary format
   - Select shorter chains

## Future Enhancements

### Planned Features

1. **Parallel Chains**: Run multiple chains simultaneously
2. **Dynamic Chains**: Adjust based on intermediate results
3. **Chain Learning**: Optimize based on feedback
4. **Chain Templates**: Pre-built for common scenarios

### Experimental Chains

- **Hybrid Analysis**: Combines multiple base LLMs
- **Recursive Refinement**: Iterative improvement
- **Ensemble Voting**: Multiple chains vote on output

## Conclusion

The Mirador chain system provides flexible, powerful orchestration of AI models to solve complex problems. By understanding chain composition patterns and selection criteria, you can leverage the full power of the framework for any use case. The modular design allows for continuous improvement while maintaining stability for existing workflows.