# Company Integration Guide for Mirador

## Overview

This guide documents the integration of Company-specific AI models and chains into the Mirador framework, optimized based on analysis of 840 chain executions and the Company Advocates Program content.

## New Models Created

### 1. **matthew_context_provider_v3.modelfile**
- **Purpose**: Personal context engine with comprehensive understanding of your situation
- **Temperature**: 0.4 (focused, consistent)
- **Usage**: 250 times in analysis period (29.8% of total)
- **Key Features**: Current role, relationships, objectives, constraints

### 2. **enhanced_agent_enforcer.modelfile**
- **Purpose**: Quality control and strategic alignment
- **Temperature**: 0.3 (precise, structured)
- **Usage**: 248 times (29.5% of total)
- **Output Structure**: Strategic summary, prioritized actions, quick wins, metrics, risks

### 3. **company_innovation_catalyst.modelfile**
- **Purpose**: Identify and scale innovation opportunities within Company
- **Temperature**: 0.6 (creative but grounded)
- **Focus**: Grassroots innovations, constraint workarounds, coalition building

### 4. **ai_leadership_strategist.modelfile**
- **Purpose**: Position you for AI leadership roles
- **Temperature**: 0.5 (balanced)
- **Framework**: Visibility strategies, capability demonstrations, relationship mapping

### 5. **solution_architect.modelfile**
- **Purpose**: Design implementable solutions within corporate constraints
- **Temperature**: 0.4 (structured, practical)
- **Patterns**: ServiceNow automation, Teams-based hubs, AI-assisted tools

## Optimized Chain Templates

### Quick Usage Examples

```bash
# Find innovation opportunities
./company_chain_runner.sh innovation_discovery "How can we improve vendor onboarding?"

# Build AI leadership positioning
./company_chain_runner.sh ai_leadership "Preparing for next week's team meeting"

# Navigate corporate dynamics
./company_chain_runner.sh corporate_nav "Approaching IT security about AI tools"

# Design practical solutions
./company_chain_runner.sh solution_design "Create document search assistant"

# Maximize Advocates impact
./company_chain_runner.sh advocates_strategy "Next Advocates meeting strategy"

# Generate quick wins
./company_chain_runner.sh quick_win "Need a 1-week project to impress"

# Comprehensive analysis
./company_chain_runner.sh strategic_synthesis "AI Center of Excellence opportunity"
```

### Using with Python Interface

```python
# Using mirador.py with Company chains
python mirador.py template innovation "How can we scale the Current Department automation success?"
python mirador.py template ai_leadership "Building visibility for AI expertise"
python mirador.py template strategic "Comprehensive quarterly planning"
```

## Model Performance Expectations

Based on your usage patterns:

| Chain Type | Avg Execution Time | Output Length | Success Rate |
|------------|-------------------|---------------|--------------|
| Context + Enforcer | 50-60s | 600-900 words | 97.5% |
| Innovation Discovery | 70-80s | 800-1200 words | High impact |
| Strategic Synthesis | 90-120s | 1500-2000 words | Comprehensive |

## Integration with Existing Workflows

### Daily Planning (Morning)
```bash
./company_chain_runner.sh ai_leadership "What are today's highest impact actions given my calendar and priorities?"
```

### Opportunity Spotted
```bash
./company_chain_runner.sh innovation_discovery "Teams are manually processing [SPECIFIC TASK]"
```

### Before Key Meetings
```bash
./company_chain_runner.sh corporate_nav "Meeting with [STAKEHOLDER] about [TOPIC]"
```

### Weekly Strategy Session
```bash
./company_chain_runner.sh strategic_synthesis "Weekly strategic review and planning"
```

## Key Differentiators

1. **Context Awareness**: Every chain starts with your personal context
2. **Quality Enforcement**: Enhanced agent enforcer ensures actionable outputs
3. **Corporate Navigation**: Specific models for Company's political landscape
4. **Innovation Focus**: Identifies and scales existing grassroots solutions
5. **Leadership Positioning**: Strategic visibility and credibility building

## Metrics and Tracking

The system automatically saves all outputs to timestamped directories:
- Location: `~/ai_framework_git/outputs/company_[chain]_[timestamp]/`
- Contents: Prompts, step outputs, final summary
- Format: Markdown summaries for easy sharing

## Next Steps

1. **Create Model Files in Ollama**:
   ```bash
   ollama create matthew_context_provider_v3 -f matthew_context_provider_v3.modelfile
   ollama create enhanced_agent_enforcer -f enhanced_agent_enforcer.modelfile
   ollama create company_innovation_catalyst -f company_innovation_catalyst.modelfile
   ollama create ai_leadership_strategist -f ai_leadership_strategist.modelfile
   ollama create solution_architect -f solution_architect.modelfile
   ```

2. **Test Basic Chains**:
   ```bash
   ./company_chain_runner.sh quick_win "Test quick win generation"
   ```

3. **Push to GitHub**:
   ```bash
   git add -A
   git commit -m "Add Company-optimized models and chains based on 840 execution analysis"
   git push origin main
   ```

## Success Patterns

From your 840 executions:
- **Most Effective**: Context → Specialist → Enforcer (3-model chains)
- **Highest Impact**: Innovation discovery leading to implemented solutions
- **Best ROI**: Quick wins that demonstrate capability (1-2 week projects)

## Remember

- Always start with context (matthew_context_provider_v3)
- End with enforcement (enhanced_agent_enforcer) for quality
- Document wins for credibility building
- Focus on scaling what works, not creating from scratch