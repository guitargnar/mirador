# Mirador AI Orchestration Framework - Technical Documentation

## Overview

Mirador is a sophisticated personal AI orchestration framework designed for life augmentation through intelligent multi-model collaboration. Built on the Ollama platform with custom specialist models, Mirador enables complex analysis, strategic planning, and content creation through coordinated AI model chains.

## Architecture

### Core Components

#### 1. Model Ecosystem
- **Base Model**: llama3.2_balanced (2GB optimized for speed and reliability)
- **Specialist Models**: 50+ domain-specific models with versioned evolution
- **Meta-Models**: System optimization and performance monitoring models
- **Custom Configurations**: Temperature, token limits, and response parameters optimized per model

#### 2. Execution Framework
- **mirador-ez ask**: Single model queries for rapid responses
- **mirador-ez chain**: Multi-model collaborative analysis
- **Automated Scripts**: Performance monitoring, optimization, and maintenance
- **Analytics Engine**: ROI tracking, performance metrics, and quality assessment

#### 3. Data Management
- **Output Storage**: Structured directory system with categorization
- **Memory System**: Persistent context and learning capabilities
- **Version Control**: Git-based model and configuration management
- **Backup Systems**: Automated model and data backup procedures

### Model Specialization Matrix

| Category | Models | Primary Function | Performance Metrics |
|----------|--------|------------------|-------------------|
| **Core Decision** | decision_simplifier, enhanced_agent_enforcer | Strategic synthesis and actionable recommendations | 100% success rate, 10-21s execution |
| **Domain Expertise** | financial_planning_expert_v6, louisville_expert_v3 | Specialized knowledge and analysis | 78.8% usage rate (financial) |
| **Content Creation** | matthews_linkedin_voice, content_strategist_pro | Brand-aligned content generation | Professional voice matching |
| **System Meta** | mirador_system_specialist, opportunity_validator_v2 | Framework optimization and validation | Comprehensive analysis capability |
| **Personal Context** | matthew_context_provider | Personalized recommendations | 16-word average context additions |

### Chain Architecture Patterns

#### Speed-Optimized Chains (45-60 seconds)
```
financial_planning_expert_v6 → decision_simplifier
```
- Use Case: Quick financial analysis and decision-making
- Performance: Rapid turnaround with focused expertise
- Output Quality: Concise, actionable recommendations

#### Quality-Optimized Chains (60-90 seconds)
```
mirador_system_specialist → enhanced_agent_enforcer → decision_simplifier
```
- Use Case: Comprehensive strategic analysis
- Performance: 3,000+ word detailed analyses
- Output Quality: Deep insights with implementation frameworks

#### Balanced Chains (45-75 seconds)
```
mirador_system_specialist → decision_simplifier
```
- Use Case: Efficient yet thorough analysis
- Performance: Optimal speed-quality ratio
- Output Quality: Structured recommendations with strategic depth

#### Comprehensive Analysis Chains (60-120 seconds)
```
matthew_context_provider → [domain_expert] → mirador_system_specialist → enhanced_agent_enforcer → opportunity_validator_v2 → decision_simplifier
```
- Use Case: Complex strategic planning and opportunity analysis
- Performance: Maximum analytical depth
- Output Quality: Personalized, validated, actionable strategic plans

## Installation and Setup

### Prerequisites
- macOS with Homebrew
- Python 3.11+ with virtual environment
- Ollama 0.7.1+
- Git for version control
- Sufficient storage (50GB+ recommended for full model suite)

### Installation Steps

1. **Install Ollama**
```bash
brew install ollama
brew services start ollama
```

2. **Clone Mirador Framework**
```bash
git clone [repository_url] ai_framework_git
cd ai_framework_git
```

3. **Set up Python Environment**
```bash
python3 -m venv google-env
source google-env/bin/activate
pip install -r requirements.txt
```

4. **Install Base Models**
```bash
ollama pull llama3.2_balanced
```

5. **Create Specialist Models**
```bash
./create_new_model.sh [model_name] [model_file]
```

6. **Verify Installation**
```bash
./system_validation.sh
```

### Configuration

#### Model Configuration Files
Each specialist model is defined by a `.modelfile` with:
- Base model specification
- Temperature and parameter settings
- System prompt and role definition
- Token limits and response constraints

#### Example Model Configuration
```dockerfile
FROM llama3.2_balanced

PARAMETER temperature 0.4
PARAMETER top_p 0.85
PARAMETER num_predict 1300
PARAMETER repeat_penalty 1.05

SYSTEM """You are a specialist in [domain] with expertise in [specific_areas].
Your role is to provide [specific_function] while maintaining [quality_standards].
Focus on [key_objectives] and ensure [output_requirements]."""
```

## Usage Instructions

### Basic Commands

#### Single Model Query
```bash
mirador-ez ask [model_name] "[prompt]"
```
- Use for: Quick questions, testing, single-domain expertise
- Response time: 10-30 seconds
- Output: Direct model response

#### Multi-Model Chain
```bash
mirador-ez chain "[prompt]" \
  model1 model2 model3 model4
```
- Use for: Complex analysis, content creation, strategic planning
- Response time: 45-120 seconds
- Output: Collaborative synthesis with progress tracking

### Advanced Usage Patterns

#### Context-Aware Analysis
```bash
mirador-ez chain "[prompt]" \
  matthew_context_provider [domain_expert] decision_simplifier
```

#### Opportunity Validation
```bash
mirador-ez chain "[opportunity_analysis_prompt]" \
  [domain_expert] opportunity_validator_v2 decision_simplifier
```

#### Content Creation
```bash
mirador-ez chain "[content_prompt]" \
  matthews_linkedin_voice content_strategist_pro decision_simplifier
```

### Automation Scripts

#### Daily Operations
- `./daily_opportunity_scan.sh`: Automated opportunity identification
- `./quick_linkedin_post.sh`: Rapid content generation
- `./system_maintenance.sh`: Health checks and optimization

#### Weekly Operations
- `./weekly_deep_analysis.sh`: Comprehensive strategic analysis
- `./weekly_mirador_optimization.sh`: Performance optimization
- `./weekly_review_dashboard.sh`: Progress and metrics review

#### Monthly Operations
- `./monthly_optimization.sh`: Comprehensive system optimization
- `./advanced_opportunity_analytics.sh`: Deep opportunity analysis
- `./track_mirador_roi.sh`: ROI tracking and reporting

## Performance Optimization

### Model Performance Tuning

#### Temperature Settings
- **0.3-0.4**: Focused, deterministic responses
- **0.5-0.7**: Balanced creativity and accuracy
- **0.8-1.0**: Creative, exploratory responses

#### Token Optimization
- **num_predict**: Optimized per model for speed vs. completeness
- **context_length**: Balanced for memory efficiency
- **repeat_penalty**: Tuned to prevent repetitive outputs

#### Chain Optimization
- **Model Sequencing**: Strategic ordering for progressive enhancement
- **Parallel Processing**: Where applicable for speed improvements
- **Caching**: Intelligent caching of frequent queries

### System Performance Metrics

#### Current Performance (as of analysis)
- **Total Analyses**: 306 completed
- **Content Generated**: 404,972 words
- **Time Saved**: 918 hours estimated
- **Success Rate**: 100% validated
- **Average Quality**: 1,323 words per analysis
- **Opportunity Identification**: 70% rate

#### Performance Benchmarks
- **Speed Chains**: 45-60 seconds
- **Quality Chains**: 60-90 seconds
- **Comprehensive Chains**: 90-120 seconds
- **Model Reliability**: 100% success rate
- **Storage Efficiency**: 2GB models vs. 19GB alternatives

## Monitoring and Analytics

### Built-in Analytics

#### System Health Monitoring
```bash
./system_validation.sh
./monitor_mirador_performance.sh
./version_info.sh
```

#### Performance Analytics
```bash
./advanced_opportunity_analytics.sh
./performance_analysis.sh
./opportunity_dashboard.sh
```

#### ROI Tracking
```bash
./track_mirador_roi.sh
./analyze_mirador_value.sh
```

### Key Performance Indicators

#### Quantitative Metrics
- Analysis completion rate
- Average execution time
- Content word count and quality
- Opportunity identification rate
- System uptime and reliability

#### Qualitative Metrics
- Output actionability
- Strategic insight depth
- Personal relevance
- Implementation success rate
- User satisfaction and value perception

## Maintenance and Updates

### Regular Maintenance Tasks

#### Daily
- System health checks
- Performance monitoring
- Output quality assessment

#### Weekly
- Model performance optimization
- Chain efficiency analysis
- Opportunity pipeline review

#### Monthly
- Comprehensive system optimization
- Model version updates
- Performance benchmark review
- Strategic goal alignment assessment

### Update Procedures

#### Model Updates
1. Test new model versions in isolated environment
2. Compare performance against current versions
3. Gradual rollout with performance monitoring
4. Rollback procedures if performance degrades

#### System Updates
1. Backup current configuration and models
2. Update base system components
3. Validate all functionality
4. Performance regression testing

#### Configuration Optimization
1. Analyze usage patterns and performance data
2. Identify optimization opportunities
3. Test configuration changes
4. Implement and monitor improvements

## Troubleshooting

### Common Issues and Solutions

#### Model Loading Failures
- **Symptom**: Model not found or loading errors
- **Solution**: Verify model installation, check Ollama service status
- **Prevention**: Regular model validation scripts

#### Performance Degradation
- **Symptom**: Slower response times or lower quality outputs
- **Solution**: Performance analysis, model optimization, system cleanup
- **Prevention**: Regular performance monitoring and optimization

#### Chain Execution Failures
- **Symptom**: Chain interruption or incomplete outputs
- **Solution**: Check model availability, validate chain configuration
- **Prevention**: Robust error handling and fallback mechanisms

### Diagnostic Tools

#### System Diagnostics
```bash
./system_validation.sh
./validate_production_readiness.sh
./comprehensive_performance_test.sh
```

#### Performance Diagnostics
```bash
./performance_analysis.sh
./test_model_performance.sh
./analyze_test_results.sh
```

## Security and Privacy

### Data Protection
- **Local Processing**: All analysis performed locally, no external data sharing
- **Privacy Level**: 100% private, no cloud dependencies
- **Data Encryption**: Local storage encryption recommended
- **Access Control**: User-level access control and authentication

### Model Security
- **Model Integrity**: Version control and checksums for model validation
- **Configuration Security**: Secure storage of model configurations
- **Update Security**: Verified updates and rollback capabilities

## Best Practices

### Prompt Engineering
- Use specific, contextual prompts for better results
- Include desired output format and structure
- Provide relevant background information
- Specify target audience and use case

### Chain Design
- Start with context providers for personalized results
- Use domain experts for specialized knowledge
- Include validation models for accuracy
- End with decision simplifiers for actionability

### Performance Optimization
- Choose appropriate chain length for task complexity
- Monitor execution times and optimize as needed
- Regular model performance evaluation
- Continuous improvement based on usage patterns

### Quality Assurance
- Regular output quality assessment
- Validation of recommendations and insights
- Feedback loop for continuous improvement
- Performance benchmarking and optimization

