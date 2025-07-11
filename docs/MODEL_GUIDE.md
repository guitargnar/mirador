# Mirador AI Framework - Complete Model Guide

## Table of Contents
- [Overview](#overview)
- [Model Categories](#model-categories)
- [Core Models](#core-models)
- [Domain Specialist Models](#domain-specialist-models)
- [Strategy and Analysis Models](#strategy-and-analysis-models)
- [Implementation Models](#implementation-models)
- [Base LLM Distribution](#base-llm-distribution)
- [Model Creation Guide](#model-creation-guide)
- [Model Naming Conventions](#model-naming-conventions)
- [Performance Characteristics](#performance-characteristics)

## Overview

The Mirador framework includes 80+ specialized models, each optimized for specific tasks and domains. Models are built on diverse base LLMs to reduce vendor dependency and leverage each LLM's unique strengths.

### Key Principles

1. **Specialization**: Each model is fine-tuned with specific prompts and parameters
2. **Diversity**: Multiple base LLMs provide different perspectives and capabilities
3. **Composability**: Models work together in chains to solve complex problems
4. **Personalization**: Matthew's context is embedded in relevant models

## Model Categories

### 1. Context Providers
Provide personal and professional context to ground responses

### 2. Domain Specialists
Expert knowledge in specific fields (finance, health, music, etc.)

### 3. Strategy Models
High-level planning and strategic thinking

### 4. Analysis Models
Deep analysis and critical thinking

### 5. Implementation Models
Convert insights into actionable steps

### 6. Optimization Models
Speed and efficiency optimized responses

## Core Models

### matthew_context_provider_v6_complete

**Base LLM**: llama3.2:latest  
**Purpose**: Provides comprehensive personal and professional context  
**Context Window**: 8192 tokens  
**Key Features**:
- Complete background: Risk Management Professional at Humana
- Personal context: Single father of 3 teens
- Interests: Lead guitarist, AI innovation, productivity
- Constraints: Time, energy, financial limitations

**System Prompt**:
```
You are helping Matthew Scott, a Risk Management Professional II at Humana...
Current priorities: Career advancement to VP level, AI innovation, family balance...
```

**Usage Pattern**:
- Always first in chain for personalized queries
- Provides grounding context for subsequent models

### matthew_context_provider_v5_complete

**Base LLM**: llama3.2:latest  
**Purpose**: Previous version, maintained for compatibility  
**Differences from v6**: Less emphasis on direct responses

### matthew_music_context

**Base LLM**: llama3.2:latest  
**Purpose**: Music-specific context and expertise  
**Context**: 
- Lead guitarist in Annapurna (alt-metal band)
- 20+ years playing experience
- Technical death metal to ambient styles
- Teaching philosophy and practice routines

## Domain Specialist Models

### Financial Domain

#### universal_financial_advisor

**Base LLM**: llama3.2:latest  
**Purpose**: Comprehensive financial planning and advice  
**Specialization**:
- Budget optimization for $1,650/month income
- Single parent financial strategies
- Investment guidance for limited resources
- Debt management approaches

**Key Constraints**:
- Limited disposable income
- Three teenagers' needs
- Emergency fund building
- Long-term financial security

#### budget_optimizer_expert

**Base LLM**: gemma2:27b  
**Purpose**: Detailed budget analysis and optimization  
**Why Gemma**: Superior analytical reasoning for complex calculations

### Health & Wellness Domain

#### universal_health_wellness

**Base LLM**: llama3.2:latest  
**Purpose**: Holistic health and wellness guidance  
**Focus Areas**:
- Stress management for corporate professional
- Energy optimization throughout day
- Sleep quality improvement
- Exercise fitting busy schedule

#### wellness_guide_compassionate

**Base LLM**: phi3:medium  
**Purpose**: Empathetic wellness support  
**Why Phi3**: Fast, compassionate responses

### Technical Domain

#### master_coder

**Base LLM**: llama3.2:latest  
**Purpose**: Advanced coding solutions  
**Languages**: Python, JavaScript, SQL, Bash, PowerShell  
**Specialties**:
- Automation scripts
- Data processing
- API integration
- Performance optimization

#### command_r_code_analyst

**Base LLM**: command-r:35b  
**Purpose**: Code review and analysis  
**Why Command-R**: Optimized for retrieval and analysis tasks  
**Features**:
- Security vulnerability detection
- Performance bottleneck identification
- Best practices enforcement
- Humana compliance checking

#### code_reviewer_expert

**Base LLM**: deepseek-coder:latest  
**Purpose**: Specialized code review  
**Why DeepSeek**: Purpose-built for code understanding

### Music Domain

#### universal_music_mentor

**Base LLM**: llama3.2:latest  
**Purpose**: Comprehensive music instruction  
**Expertise**:
- Guitar technique (fingerstyle to shredding)
- Music theory application
- Practice routine design
- Performance preparation

#### guitar_teacher_patient

**Base LLM**: mistral:7b  
**Purpose**: Patient, structured guitar instruction  
**Why Mistral**: Clear, structured explanations

### Louisville/Location Domain

#### universal_louisville_expert

**Base LLM**: llama3.2:latest  
**Purpose**: Local knowledge and recommendations  
**Coverage**:
- JCPS school system insights
- Local music venues
- Healthcare facilities
- Community resources

### Career Domain

#### universal_career_strategist

**Base LLM**: llama3.2:latest  
**Purpose**: Career advancement planning  
**Focus**:
- Path to VP of AI Innovation
- Corporate navigation strategies
- Skill development priorities
- Network building approaches

#### universal_corporate_navigator

**Base LLM**: qwen2.5:32b  
**Purpose**: Corporate politics and culture navigation  
**Why Qwen**: Excellent cultural understanding and nuance

## Strategy and Analysis Models

### universal_strategy_architect

**Base LLM**: llama3.2:latest  
**Purpose**: High-level strategic planning  
**Capabilities**:
- Multi-dimensional problem analysis
- Long-term vision development
- Risk-benefit assessment
- Strategic priority setting

### analytical_expert_gemma

**Base LLM**: gemma2:27b  
**Purpose**: Deep analytical thinking  
**Why Gemma**: Superior reasoning capabilities  
**Strengths**:
- Complex problem decomposition
- Data-driven insights
- Logical flow analysis
- Evidence-based recommendations

### cross_model_synthesizer

**Base LLM**: llama3.2:latest  
**Purpose**: Synthesize insights from multiple models  
**Function**: Combines outputs from different perspectives into coherent recommendations

### strategic_advisor_thoughtful

**Base LLM**: command-r:35b  
**Purpose**: Thoughtful strategic advice  
**Approach**: Considers multiple stakeholders and long-term implications

## Implementation Models

### practical_implementer

**Base LLM**: llama3.2:latest  
**Purpose**: Convert insights into actionable steps  
**Output Style**:
- Step-by-step instructions
- Time estimates
- Resource requirements
- Success metrics

### action_crystallizer

**Base LLM**: phi3:medium  
**Purpose**: Rapid action item generation  
**Why Phi3**: Fast processing for quick decisions  
**Format**: Bullet points with clear next steps

### solution_architect

**Base LLM**: llama3.2:latest  
**Purpose**: Design complete solutions  
**Includes**:
- Architecture diagrams
- Implementation phases
- Risk mitigation
- Success criteria

## Optimization Models

### speed_optimizer_phi

**Base LLM**: phi3:mini  
**Purpose**: Ultra-fast responses  
**Response Time**: <3 seconds  
**Use Cases**: Quick questions, immediate needs

### quality_maximizer

**Base LLM**: gemma2:27b  
**Purpose**: Highest quality outputs  
**Trade-off**: Slower but more thorough

### creative_catalyst

**Base LLM**: llama3.2:latest  
**Purpose**: Creative and innovative solutions  
**Temperature**: 0.9 (higher creativity)

## Base LLM Distribution

### Current Distribution (80+ models)

| Base LLM | Count | Percentage | Primary Use |
|----------|-------|------------|-------------|
| Llama 3.2 | ~56 | 70% | General purpose, context aware |
| Gemma 2 27B | ~8 | 10% | Analysis, reasoning |
| Qwen 2.5 32B | ~4 | 5% | Multilingual, cultural |
| Phi-3 | ~4 | 5% | Speed optimization |
| Command-R 35B | ~4 | 5% | RAG, retrieval tasks |
| Mistral 7B | ~2 | 2.5% | Structured output |
| DeepSeek-Coder | ~2 | 2.5% | Code-specific tasks |

### Base LLM Characteristics

#### Llama 3.2 (Meta)
- **Strengths**: Well-rounded, good context handling
- **Size**: Varies (3B to 70B)
- **Best For**: General conversation, context understanding

#### Gemma 2 27B (Google)
- **Strengths**: Superior reasoning, analysis
- **Size**: 27B parameters
- **Best For**: Complex problem solving, analytical tasks

#### Qwen 2.5 32B (Alibaba)
- **Strengths**: Multilingual, cultural awareness
- **Size**: 32B parameters
- **Best For**: Cross-cultural understanding, diverse perspectives

#### Phi-3 (Microsoft)
- **Strengths**: Extremely fast, efficient
- **Size**: Mini (3.8B), Medium (14B)
- **Best For**: Quick responses, real-time interaction

#### Command-R 35B (Cohere)
- **Strengths**: RAG-optimized, retrieval tasks
- **Size**: 35B parameters
- **Best For**: Document analysis, code review

#### Mistral 7B
- **Strengths**: Efficient, structured output
- **Size**: 7B parameters
- **Best For**: Clear explanations, teaching

#### DeepSeek-Coder
- **Strengths**: Code understanding, generation
- **Size**: Various
- **Best For**: Programming tasks

## Model Creation Guide

### 1. Define Model Purpose

```yaml
Model Planning:
  Purpose: Specific task or domain
  Base LLM: Choose based on strengths
  Context: Required background knowledge
  Constraints: Time, quality, specificity
```

### 2. Create Modelfile

```dockerfile
# Example: domain_expert_modelfile
FROM llama3.2:latest

PARAMETER temperature 0.7
PARAMETER context_window 8192
PARAMETER max_tokens 2048

SYSTEM """
You are an expert in [DOMAIN] helping Matthew Scott...
[Specific context and constraints]
[Output format requirements]
"""
```

### 3. Build Model

```bash
ollama create model_name -f modelfile_name
```

### 4. Test Model

```bash
echo "Test query" | ollama run model_name
```

### 5. Add to Chains

Update relevant chain scripts to include new model.

## Model Naming Conventions

### Pattern: `[scope]_[function]_[modifier]`

Examples:
- `universal_`: Works across domains
- `matthew_`: Personalized context
- `_expert`: Deep domain knowledge
- `_optimizer`: Performance focused
- `_v[N]`: Version number

### Categories:
- Context: `*_context_provider_*`
- Domain: `*_advisor`, `*_expert`, `*_guide`
- Strategy: `*_strategist`, `*_architect`
- Implementation: `*_implementer`, `*_crystallizer`

## Performance Characteristics

### Response Time by Model Size

| Model Size | Load Time | Response Time | RAM Usage |
|------------|-----------|---------------|-----------|
| 3-7B | 1-2s | 0.5-2s | 4-8GB |
| 14B | 2-3s | 1-3s | 8-12GB |
| 27B | 3-5s | 2-5s | 16-20GB |
| 32-35B | 4-6s | 3-7s | 20-24GB |

### Quality vs Speed Trade-offs

1. **Fastest**: Phi-3 mini models (~0.5s)
2. **Balanced**: Llama 3.2, Mistral 7B (~2s)
3. **Highest Quality**: Gemma 27B, Command-R 35B (~5s)

### Chain Performance

- **Simple Chain** (3 models): 10-15s total
- **Standard Chain** (4 models): 15-25s total
- **Complex Chain** (6 models): 30-45s total

## Model Selection Guidelines

### Choose Based on Task

1. **Quick Answer**: speed_optimizer_phi
2. **Deep Analysis**: analytical_expert_gemma
3. **Code Task**: master_coder + command_r_code_analyst
4. **Creative Work**: creative_catalyst + universal_strategy_architect
5. **Financial Planning**: universal_financial_advisor + practical_implementer

### Chain Composition Rules

1. **Always Start With Context**: matthew_context_provider for personalized queries
2. **Domain Then Strategy**: Domain expert → Strategy model → Implementation
3. **Analysis Before Action**: Analytical model → Practical implementer
4. **Synthesis at End**: Use synthesizer for multi-model outputs

## Model Maintenance

### Updating Models

```bash
# Update base LLM
ollama pull llama3.2:latest

# Recreate model with updated base
ollama create model_name -f modelfile_name
```

### Version Management

- Keep previous versions for compatibility
- Test thoroughly before deprecating
- Document changes in model behavior

### Performance Monitoring

Track in logs:
- Response time per model
- Token usage
- Error rates
- User satisfaction (via feedback)

## Future Model Development

### Planned Enhancements

1. **Dynamic Temperature**: Adjust based on query type
2. **Specialized Embeddings**: Better semantic understanding
3. **Multi-Modal Models**: Image and code understanding
4. **Ensemble Models**: Combine multiple base LLMs

### Model Consolidation

Goal: Reduce from 80+ to ~40 models by:
- Merging similar functions
- Creating more versatile models
- Removing redundant specialists

## Conclusion

The Mirador model ecosystem provides comprehensive coverage across all aspects of Matthew's personal and professional life. By leveraging diverse base LLMs and specialized prompting, each model contributes unique value to the overall system. The modular design allows for continuous improvement while maintaining stability for existing workflows.