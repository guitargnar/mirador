# 🚀 Mirador Comprehensive Reference Documentation

## Table of Contents
1. [Overview](#overview)
2. [Installation & Setup](#installation--setup)
3. [Core Architecture](#core-architecture)
4. [Usage Instructions](#usage-instructions)
5. [Model Reference](#model-reference)
6. [Chain Types](#chain-types)
7. [Real-World Examples](#real-world-examples)
8. [Testing Framework](#testing-framework)
9. [File Organization](#file-organization)
10. [Development Guidelines](#development-guidelines)
11. [Troubleshooting](#troubleshooting)

---

## Overview

**Mirador v3.0** is a multi-faceted universal AI orchestration platform that enables collaborative AI chains for creative professionals, entrepreneurs, and innovators. Built specifically for Matthew Scott's real-world needs, it scales from personal optimization to business applications.

### Key Features
- **Universal Chain Types**: 6 specialized chain orchestrations
- **Apple Silicon Optimized**: Quality-focused parameters for M-series chips
- **Privacy-First**: All models run locally, no data sharing
- **Real Context**: Based on Matthew's actual background and situation
- **Practical Utility**: Tested against real-world scenarios

### Primary Use Cases
1. **Life Optimization**: Work-life balance, family, career integration
2. **Business Acceleration**: Startup strategies, innovation leadership
3. **Creative Breakthrough**: Music, technology, artistic integration
4. **Relationship Harmony**: Professional and personal relationships
5. **Technical Mastery**: AI development, automation, scaling
6. **Strategic Synthesis**: Comprehensive multi-domain analysis

---

## Installation & Setup

### Prerequisites
- **macOS** (Apple Silicon recommended)
- **Ollama** installed and running
- **Bash** 4.0+ (included in macOS)
- **Git** for version control

### Quick Setup
```bash
# 1. Clone repository
git clone <repository-url>
cd mirador

# 2. Create optimized models
./create_optimized_models_fixed.sh

# 3. Test installation
./tests/test_practical_utility_pdf_context.sh
```

### Model Verification
```bash
# Check models are created
ollama list | grep -E "(matthew_context_provider_v4_accurate|universal_strategy_architect|creative_catalyst|practical_implementer)"

# Test basic functionality
echo "What are my current priorities?" | ollama run matthew_context_provider_v4_accurate
```

---

## Core Architecture

### Model Orchestration Flow
```
Input Prompt → Context Model → Specialist Model → Implementation Model → Output
```

### Model Types
1. **Context Provider**: `matthew_context_provider_v4_accurate`
   - Real personal/professional context
   - Louisville, family, Humana background
   - Financial situation and goals

2. **Specialist Models**: 
   - `universal_strategy_architect`: Multi-domain strategic thinking
   - `creative_catalyst`: Innovation and breakthrough solutions
   - `practical_implementer`: Actionable execution planning

3. **Quality Parameters** (Apple Silicon Optimized):
   ```
   temperature: 0.7        # Creativity balance
   top_p: 0.95            # Response diversity  
   num_predict: 2048      # Response length
   num_ctx: 8192          # Context window
   num_thread: 8          # Apple Silicon threads
   ```

---

## Usage Instructions

### Basic Chain Execution
```bash
./mirador_universal_runner.sh <chain_type> "Your prompt here"
```

### Available Chain Types
- `life_optimization` - Holistic life improvement
- `business_acceleration` - Business growth strategies  
- `creative_breakthrough` - Creative potential unlocking
- `relationship_harmony` - Relationship optimization
- `technical_mastery` - Technical project success
- `strategic_synthesis` - Comprehensive analysis

### Example Commands
```bash
# Single father work-life balance
./mirador_universal_runner.sh life_optimization "How do I balance being a single father, working at Humana, playing music with Annapurna, and developing AI innovations?"

# Real estate investment strategy
./mirador_universal_runner.sh business_acceleration "I have $91K home equity and $1,650 take-home pay. What's my optimal real estate investment strategy?"

# AI career transition
./mirador_universal_runner.sh business_acceleration "How do I transition from risk management to AI innovation leadership at Humana?"
```

---

## Model Reference

### matthew_context_provider_v4_accurate
**Purpose**: Provides accurate personal and professional context for Matthew Scott
**Context Includes**:
- Location: Louisville, Kentucky
- Role: Single father, Humana Senior Risk Management Professional II
- Music: Lead guitarist in Annapurna band
- AI Innovation: 89-model system creator, Mirador co-author
- Financial: ~$1,650/paycheck, $91K home equity
- Goals: AI leadership, real estate investment, work-life balance

### universal_strategy_architect
**Purpose**: Multi-domain strategic analysis and planning
**Specializations**:
- Business development and entrepreneurship
- Creative project management
- Personal life optimization
- Technical innovation
- Financial planning

### creative_catalyst  
**Purpose**: Innovation and creative problem-solving
**Specializations**:
- Musical collaboration and production
- Creative-technical integration
- Artistic workflow optimization
- Innovation methodology
- Creative monetization strategies

### practical_implementer
**Purpose**: Convert strategies into executable action plans
**Specializations**:
- Project management and execution
- Resource optimization
- Timeline development
- Risk mitigation
- Progress measurement

---

## Chain Types

### 1. life_optimization
**Models**: context → strategy → implementation
**Use For**: Work-life balance, family integration, personal growth
**Example**: Balancing single fatherhood with career and creative pursuits

### 2. business_acceleration
**Models**: strategy → context → implementation  
**Use For**: Business development, career advancement, financial growth
**Example**: Transitioning to AI innovation leadership role

### 3. creative_breakthrough
**Models**: creative → context → implementation
**Use For**: Artistic projects, creative blocks, innovation challenges
**Example**: Integrating AI technology with music career

### 4. relationship_harmony
**Models**: context → strategy → implementation
**Use For**: Professional networking, personal relationships, collaboration
**Example**: Building Louisville AI innovation network

### 5. technical_mastery
**Models**: context → strategy → implementation
**Use For**: AI development, automation, technical scaling
**Example**: Scaling Mirador framework for business applications

### 6. strategic_synthesis
**Models**: context → strategy → creative → implementation
**Use For**: Complex multi-domain challenges requiring comprehensive analysis
**Example**: Career transition while maintaining family stability

---

## Real-World Examples

### Financial Planning Example
```bash
./mirador_universal_runner.sh business_acceleration "I have two 401k loans reducing my take-home to $1,650 per paycheck, but I have $91,000 in home equity. I want to invest in real estate while maintaining financial stability for my child. What's my strategy?"
```

**Expected Output**: Specific real estate investment strategies accounting for:
- Current debt obligations
- Available equity leverage options
- Cash flow requirements for single parent
- Risk management for family stability

### Career Transition Example  
```bash
./mirador_universal_runner.sh strategic_synthesis "I've spent 10 years in risk management at Humana and just built an 89-model AI system. How do I position myself for AI innovation leadership while leveraging my compliance and risk expertise?"
```

**Expected Output**: Career transition plan including:
- Transferable skills identification
- Internal positioning strategy at Humana
- External opportunity development
- Timeline and milestone planning

---

## Testing Framework

### Comprehensive Test Suite
```bash
# Run all tests
./tests/test_practical_utility_pdf_context.sh

# Individual test categories
./tests/test_productivity_tools.sh
./tests/test_real_world_scenarios.sh
```

### Test Coverage
- **10 Real-World Scenarios** based on Matthew's actual situation
- **Keyword Validation** for response relevance
- **Performance Metrics** for execution time
- **Success Rate Tracking** for reliability assessment

### Quality Metrics
- Response relevance to context
- Actionability of recommendations
- Integration across life domains
- Practical implementation feasibility

---

## File Organization

### Core Structure
```
mirador/
├── mirador_universal_runner.sh          # Main execution script
├── create_optimized_models_fixed.sh     # Model creation
├── matthew_context_accurate.modelfile   # Context model definition
├── tests/                              # Testing framework
│   ├── test_practical_utility_pdf_context.sh
│   └── test_logs/                      # Test results
├── outputs/                            # Chain execution results
├── docs/                              # Documentation
└── README.md                           # Project overview
```

### Documentation Files
- `MIRADOR_COMPREHENSIVE_REFERENCE.md` - This document
- `OPTIMIZATION_IMPLEMENTATION_SUMMARY.md` - v3.0 transformation summary
- `MIRADOR_MODEL_OPTIMIZATION_STRATEGY.md` - Technical optimization details

### Legacy Organization
- `Documentation and Saved Assets/` - Historical versions
- `humana_chain_runner.sh` - Legacy Humana-specific runner
- `robust_chain_runner.sh` - Previous version chain runner

---

## Development Guidelines

### Code Style (Following User Preferences)
1. **Comprehensive Documentation** - Every component thoroughly documented
2. **Standardized Approaches** - Consistent patterns across all scripts
3. **Version Control** - Proper git tagging for major updates
4. **File Path References** - Always specify exact locations
5. **Practical Delivery** - Focus on real-world utility

### Naming Conventions
- **Scripts**: `snake_case.sh`
- **Models**: `descriptive_name_v4_accurate`
- **Functions**: `clear_descriptive_names()`
- **Variables**: `UPPER_CASE` for constants, `lower_case` for locals

### Error Handling
```bash
# Standard error handling pattern
if [ $? -eq 0 ] && [ -n "$OUTPUT" ]; then
    echo "✓ Success"
else
    echo "✗ Failed"
    exit 1
fi
```

### Testing Requirements
- All new features must include practical utility tests
- Tests should validate real-world applicability
- Performance benchmarks for chain execution times
- Success rate tracking over time

---

## Troubleshooting

### Common Issues

#### 1. Model Not Found
```bash
Error: model not found
```
**Solution**: Run model creation script
```bash
./create_optimized_models_fixed.sh
```

#### 2. Chain Execution Timeout
```bash
Chain failed after timeout
```
**Solution**: Models may be initializing. Wait and retry, or check Ollama status:
```bash
ollama list
ps aux | grep ollama
```

#### 3. Empty Response
```bash
✗ Error running model
```
**Solution**: Check model parameters and Ollama availability:
```bash
ollama run matthew_context_provider_v4_accurate "test"
```

### Performance Optimization
- **Apple Silicon**: Ensure `num_thread: 8` for optimal performance
- **Memory**: Models use ~6.4GB each, ensure sufficient RAM
- **Context**: Larger context windows (8192) may slow initial responses

### Debug Mode
```bash
# Enable verbose output
MIRADOR_DEBUG=1 ./mirador_universal_runner.sh life_optimization "test prompt"

# Check individual model responses
echo "test" | ollama run model_name
```

---

## Version History

### v3.0.0 (Current)
- **Universal Platform**: Transformed from Humana-specific to multi-faceted
- **Accurate Context**: Based on real PDF background information
- **Apple Silicon**: Optimized parameters for M-series chips
- **Quality Focus**: Increased creativity and response depth
- **Comprehensive Testing**: Real-world scenario validation

### v2.0.0 (Previous)
- Humana-specific enterprise framework
- Corporate chain types
- Speed-optimized parameters

### v1.0.0 (Original)
- Basic AI chain orchestration
- Limited context awareness
- Single-domain applications

---

## Support & Contributing

### Getting Help
1. **Documentation**: Start with this comprehensive reference
2. **Testing**: Run practical utility tests to validate setup
3. **Logs**: Check `test_logs/` for detailed execution reports
4. **Debug**: Use debug mode for troubleshooting

### File Locations Reference
- **Main Runner**: `/Users/matthewscott/Projects/mirador/mirador_universal_runner.sh`
- **Model Creation**: `/Users/matthewscott/Projects/mirador/create_optimized_models_fixed.sh`
- **Test Suite**: `/Users/matthewscott/Projects/mirador/tests/test_practical_utility_pdf_context.sh`
- **Documentation**: `/Users/matthewscott/Projects/mirador/MIRADOR_COMPREHENSIVE_REFERENCE.md`

---

**Mirador v3.0 delivers practical AI orchestration for real-world multi-faceted success.** 🚀