# Mirador Usage Instructions

## Getting Started

### First-Time Setup

#### 1. System Verification
Before using Mirador, verify your system is properly configured:

```bash
# Check Ollama service
brew services list | grep ollama

# Verify Python environment
source google-env/bin/activate
python --version

# Test system health
./system_validation.sh
```

#### 2. Model Verification
Ensure all required models are installed and functional:

```bash
# List installed models
ollama list

# Test core models
mirador-ez ask decision_simplifier "Test message"
mirador-ez ask mirador_system_specialist "System status check"
```

#### 3. Initial Configuration
Set up your personal context and preferences:

```bash
# Update personal context
mirador-ez ask matthew_context_provider "Update my current situation: [describe your current professional status, goals, and priorities]"

# Test personalized response
mirador-ez chain "What should be my top priority today?" \
  matthew_context_provider decision_simplifier
```

### Basic Usage Patterns

#### Single Model Queries (mirador-ez ask)

**When to Use:**
- Quick questions requiring single domain expertise
- Testing model responses
- Rapid decision-making
- Simple information requests

**Syntax:**
```bash
mirador-ez ask [model_name] "[prompt]"
```

**Examples:**
```bash
# Financial advice
mirador-ez ask financial_planning_expert_v6 "What's the best way to save for retirement?"

# Local opportunities
mirador-ez ask louisville_expert_v3 "What networking events are happening in Louisville this month?"

# Quick decisions
mirador-ez ask decision_simplifier "Should I invest in this opportunity: [describe opportunity]?"

# Content ideas
mirador-ez ask matthews_linkedin_voice "Give me 3 LinkedIn post ideas about AI in healthcare"
```

#### Multi-Model Chains (mirador-ez chain)

**When to Use:**
- Complex analysis requiring multiple perspectives
- Content creation for external use
- Strategic planning and decision-making
- Comprehensive opportunity analysis

**Syntax:**
```bash
mirador-ez chain "[prompt]" \
  model1 model2 model3 model4
```

**Examples:**
```bash
# LinkedIn content creation
mirador-ez chain "Create a LinkedIn post about the future of AI in healthcare compliance" \
  mirador_system_specialist enhanced_agent_enforcer matthews_linkedin_voice decision_simplifier

# Financial planning
mirador-ez chain "Create a plan to increase my income by 50% in 18 months" \
  matthew_context_provider financial_planning_expert_v6 opportunity_validator_v2 decision_simplifier

# Opportunity analysis
mirador-ez chain "Analyze the potential of starting an AI consulting practice in Louisville" \
  matthew_context_provider louisville_expert_v3 opportunity_validator_v2 enhanced_agent_enforcer decision_simplifier
```

## Advanced Usage Patterns

### Strategic Analysis Chains

#### Comprehensive Business Analysis
```bash
mirador-ez chain "Develop a comprehensive business strategy for establishing myself as the leading AI and healthcare compliance expert" \
  matthew_context_provider mirador_system_specialist financial_planning_expert_v6 opportunity_validator_v2 louisville_expert_v3 enhanced_agent_enforcer decision_simplifier
```

#### Market Opportunity Assessment
```bash
mirador-ez chain "Identify and validate the top 3 business opportunities in the AI healthcare space for someone with my background" \
  matthew_context_provider mirador_system_specialist opportunity_validator_v2 enhanced_agent_enforcer decision_simplifier
```

#### Personal Brand Development
```bash
mirador-ez chain "Create a comprehensive personal brand strategy that positions me as a thought leader in AI and healthcare compliance" \
  matthew_context_provider personal_brand_architect content_strategist_pro matthews_linkedin_voice enhanced_agent_enforcer decision_simplifier
```

### Content Creation Workflows

#### High-Quality LinkedIn Posts
```bash
# Industry analysis post
mirador-ez chain "Create a LinkedIn post analyzing recent developments in AI regulation for healthcare, including specific examples and actionable insights for compliance professionals" \
  mirador_system_specialist enhanced_agent_enforcer matthews_linkedin_voice decision_simplifier

# Personal experience post
mirador-ez chain "Create a LinkedIn post sharing a lesson learned from implementing AI in healthcare compliance, including specific challenges and solutions" \
  matthew_context_provider matthews_linkedin_voice personal_brand_architect decision_simplifier

# Thought leadership post
mirador-ez chain "Create a LinkedIn post predicting the next major trend in healthcare AI, with specific timeline and preparation advice" \
  mirador_system_specialist opportunity_validator_v2 matthews_linkedin_voice decision_simplifier
```

#### Technical Article Development
```bash
mirador-ez chain "Develop a comprehensive technical article about implementing AI in Medicare compliance, suitable for publication in a healthcare technology magazine" \
  matthew_context_provider mirador_system_specialist enhanced_agent_enforcer content_strategist_pro decision_simplifier
```

### Financial Planning and Optimization

#### Income Growth Planning
```bash
# Specific income target
mirador-ez chain "Create a detailed plan to reach $150,000 annual income within 18 months, considering my current skills and market opportunities" \
  matthew_context_provider financial_planning_expert_v6 opportunity_validator_v2 enhanced_agent_enforcer decision_simplifier

# Service pricing optimization
mirador-ez chain "Analyze and optimize my consulting rates for AI and healthcare compliance services" \
  matthew_context_provider financial_planning_expert_v6 opportunity_validator_v2 decision_simplifier

# Investment strategy
mirador-ez chain "Develop an investment strategy that aligns with my income goals and supports my business development" \
  matthew_context_provider financial_planning_expert_v6 opportunity_validator_v2 decision_simplifier
```

## Automated Workflows

### Daily Operations

#### Morning Opportunity Scan
```bash
./daily_opportunity_scan.sh
```
**Purpose:** Identify new opportunities and priorities for the day
**Output:** Daily opportunity report with actionable recommendations
**Duration:** 2-3 minutes

#### Quick Content Generation
```bash
./quick_linkedin_post.sh
```
**Purpose:** Generate LinkedIn content ideas and drafts
**Output:** Ready-to-post LinkedIn content
**Duration:** 1-2 minutes

### Weekly Operations

#### Comprehensive Deep Analysis
```bash
./weekly_deep_analysis.sh
```
**Purpose:** Comprehensive strategic analysis and opportunity identification
**Output:** Detailed strategic recommendations and action plans
**Duration:** 5-10 minutes

**What it does:**
- Analyzes current market trends
- Identifies new opportunities
- Provides strategic recommendations
- Creates actionable implementation plans

#### Performance Optimization
```bash
./weekly_mirador_optimization.sh
```
**Purpose:** Optimize system performance and model effectiveness
**Output:** Performance improvements and optimization recommendations
**Duration:** 3-5 minutes

#### Progress Review
```bash
./weekly_review_dashboard.sh
```
**Purpose:** Review progress against goals and objectives
**Output:** Progress report with recommendations for improvement
**Duration:** 2-3 minutes

### Monthly Operations

#### Comprehensive System Optimization
```bash
./monthly_optimization.sh
```
**Purpose:** Complete system health check and optimization
**Output:** System optimization report and recommendations
**Duration:** 10-15 minutes

**Includes:**
- Financial optimization scan
- Professional development analysis
- Health and productivity assessment
- Local opportunity identification

#### Advanced Analytics
```bash
./advanced_opportunity_analytics.sh
```
**Purpose:** Deep analytics on system performance and opportunity generation
**Output:** Comprehensive analytics report with insights
**Duration:** 5-10 minutes

**Metrics Provided:**
- Total analyses completed
- Content generated statistics
- Time saved calculations
- Opportunity identification rates
- System efficiency metrics

## Model Selection Guide

### Choosing the Right Models

#### For Speed (45-60 seconds)
```bash
financial_planning_expert_v6 decision_simplifier
```
**Use Case:** Quick financial decisions, rapid analysis
**Best For:** Daily planning, quick assessments

#### For Quality (60-90 seconds)
```bash
mirador_system_specialist enhanced_agent_enforcer decision_simplifier
```
**Use Case:** Comprehensive analysis, strategic planning
**Best For:** Important decisions, detailed analysis

#### For Balance (45-75 seconds)
```bash
mirador_system_specialist decision_simplifier
```
**Use Case:** Efficient yet thorough analysis
**Best For:** Regular planning, balanced insights

#### For Comprehensive Analysis (90-120 seconds)
```bash
matthew_context_provider [domain_expert] mirador_system_specialist enhanced_agent_enforcer opportunity_validator_v2 decision_simplifier
```
**Use Case:** Complex strategic planning, major decisions
**Best For:** Business planning, major life decisions

### Model Specializations

#### Core Decision Models
- **decision_simplifier**: Final synthesis and actionable recommendations
- **enhanced_agent_enforcer**: Strategic synthesis and implementation frameworks
- **mirador_system_specialist**: Comprehensive analysis and system optimization

#### Domain Experts
- **financial_planning_expert_v6**: Financial analysis, investment planning, income optimization
- **louisville_expert_v3**: Local market knowledge, regional opportunities
- **opportunity_validator_v2**: Opportunity assessment, validation, risk analysis

#### Content Creation
- **matthews_linkedin_voice**: Personal voice and tone matching
- **content_strategist_pro**: Content planning and optimization
- **personal_brand_architect**: Brand positioning and messaging

#### Personal Context
- **matthew_context_provider**: Personal situation integration and customization

## Optimization Techniques

### Prompt Engineering Best Practices

#### Effective Prompt Structure
1. **Context**: Provide relevant background information
2. **Objective**: Clearly state what you want to achieve
3. **Specificity**: Include specific details and requirements
4. **Format**: Specify desired output format
5. **Audience**: Identify target audience if applicable

#### Example of Well-Structured Prompt
```bash
mirador-ez chain "Context: I'm a Medicare compliance expert with 10 years experience looking to transition into AI consulting. Objective: Create a LinkedIn post that positions me as a thought leader in AI applications for healthcare compliance. Specificity: Include specific examples of AI tools, mention recent regulatory changes, and provide actionable insights. Format: Professional LinkedIn post with engaging hook, detailed content, and clear call-to-action. Audience: Healthcare executives and compliance professionals." \
  matthew_context_provider mirador_system_specialist enhanced_agent_enforcer matthews_linkedin_voice decision_simplifier
```

### Chain Optimization

#### Progressive Enhancement Pattern
1. **Context Provider**: Start with personal context
2. **Domain Expert**: Add specialized knowledge
3. **System Specialist**: Provide comprehensive analysis
4. **Strategic Enhancer**: Add implementation framework
5. **Validator**: Verify and validate recommendations
6. **Decision Simplifier**: Create actionable synthesis

#### Performance Monitoring
```bash
# Monitor execution times
time mirador-ez chain "[prompt]" model1 model2 model3

# Check system performance
./performance_analysis.sh

# Validate output quality
./output_quality_analyzer.sh
```

## Troubleshooting

### Common Issues and Solutions

#### Model Not Found
**Symptom:** "Model not found" error
**Solution:**
```bash
# Check available models
ollama list

# Reinstall missing model
ollama pull [model_name]

# Verify model creation
ollama create [model_name] -f [model_file]
```

#### Slow Performance
**Symptom:** Chains taking longer than expected
**Solutions:**
```bash
# Check system resources
top
df -h

# Optimize model selection
# Use shorter chains for routine tasks
# Monitor with performance analysis
./performance_analysis.sh
```

#### Poor Output Quality
**Symptom:** Outputs not meeting expectations
**Solutions:**
- Improve prompt specificity and context
- Use appropriate model combinations
- Include validation models in chains
- Review and refine prompt engineering

#### Chain Interruption
**Symptom:** Chain execution stops unexpectedly
**Solutions:**
```bash
# Check Ollama service
brew services restart ollama

# Verify model availability
ollama list

# Test individual models
mirador-ez ask [model_name] "test"
```

### Performance Optimization

#### System Optimization
```bash
# Regular maintenance
./system_maintenance.sh

# Performance monitoring
./monitor_mirador_performance.sh

# System validation
./system_validation.sh
```

#### Model Optimization
- Use appropriate model combinations for task complexity
- Monitor execution times and adjust chains accordingly
- Regular performance analysis and optimization
- Keep models updated to latest versions

## Best Practices

### Daily Usage
1. Start with morning opportunity scan
2. Use quick queries for routine decisions
3. Save complex analysis for important decisions
4. End with progress review and planning

### Weekly Usage
1. Run comprehensive deep analysis
2. Review and optimize system performance
3. Analyze progress against goals
4. Plan upcoming week's priorities

### Monthly Usage
1. Comprehensive system optimization
2. Strategic goal review and adjustment
3. Performance analytics and insights
4. System maintenance and updates

### Quality Assurance
1. Validate important recommendations
2. Cross-reference with multiple models when needed
3. Monitor output quality and adjust prompts
4. Regular system health checks and optimization

