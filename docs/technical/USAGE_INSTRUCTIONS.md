# 🚀 Mirador v3.0 Usage Instructions

## Quick Start Guide

### 1. **Immediate Usage** (Ready Now)
```bash
# Navigate to project directory
cd /Users/matthewscott/Projects/mirador

# Run a practical test
./mirador_universal_runner.sh life_optimization "How do I balance being a single father, my Company career, music with Annapurna, and AI innovation work?"
```

### 2. **Core Commands** (Copy-Paste Ready)

#### Personal Life Optimization
```bash
./mirador_universal_runner.sh life_optimization "I need to optimize my daily routine for creative output, business growth, and relationship health. Current situation: single father, working at Company, playing music with Annapurna, developing Mirador. How do I create sustainable balance?"
```

#### Financial Planning & Real Estate
```bash
./mirador_universal_runner.sh business_acceleration "I have $91,000 in home equity and take-home pay of $1,650 per paycheck after 401k loan repayments. I want to invest in real estate for wealth building while maintaining financial stability for my family. What's my optimal strategy?"
```

#### Career Transition Strategy
```bash
./mirador_universal_runner.sh business_acceleration "I've built an 89-model AI system and co-authored the Mirador technical paper while working in risk management at Company for 10 years. How do I transition into a formal AI innovation leadership role?"
```

#### Creative-Technical Integration
```bash
./mirador_universal_runner.sh creative_breakthrough "I'm lead guitarist in Annapurna and have built breakthrough AI technology. How do I integrate these passions - using tech skills to enhance music career while maintaining artistic integrity?"
```

#### Mirador Business Development
```bash
./mirador_universal_runner.sh technical_mastery "I've proven Mirador works with my personal 89-model AI system. How do I scale this framework for broader applications while building a sustainable business model?"
```

#### Professional Networking
```bash
./mirador_universal_runner.sh relationship_harmony "As someone transitioning from traditional risk management to AI innovation in Louisville, how do I build the right professional network to support this transition?"
```

### 3. **Available Chain Types**

| Chain Type | Purpose | Best For |
|-----------|---------|----------|
| `life_optimization` | Holistic life improvement | Work-life balance, family integration |
| `business_acceleration` | Growth strategies | Career advancement, financial planning |
| `creative_breakthrough` | Innovation solutions | Music, art, creative blocks |
| `relationship_harmony` | Relationship optimization | Networking, collaboration, personal relationships |
| `technical_mastery` | Technical project success | AI development, automation, scaling |
| `strategic_synthesis` | Comprehensive analysis | Complex multi-domain challenges |

---

## Advanced Usage

### Custom Prompts for Your Situation

#### Template Structure:
```bash
./mirador_universal_runner.sh [CHAIN_TYPE] "[CONTEXT] + [SPECIFIC CHALLENGE] + [DESIRED OUTCOME]"
```

#### Examples:

**Parenting + Innovation Balance:**
```bash
./mirador_universal_runner.sh life_optimization "As a single father, I want to model innovation and entrepreneurship for my child while ensuring they have stability and attention. How do I show what's possible while being present as a father?"
```

**Louisville Professional Positioning:**
```bash
./mirador_universal_runner.sh strategic_synthesis "I live in Louisville and work at Company, but the AI innovation scene here is limited. How do I position myself as an AI leader locally while building connections to broader tech ecosystems?"
```

**Privacy-First Business Model:**
```bash
./mirador_universal_runner.sh technical_mastery "I built my AI system with privacy-first principles - all models run locally, no third-party data sharing. How do I maintain this approach while scaling for business applications and monetization?"
```

---

## Output Management

### Understanding Results
Each chain execution creates:
- **Real-time progress** displayed in terminal
- **Detailed output files** in `outputs/` directory
- **Summary document** with comprehensive analysis

### Output Locations
```bash
# Results are saved to timestamped directories:
outputs/universal_[CHAIN_TYPE]_[TIMESTAMP]/
├── prompt.txt              # Original input
├── models.txt              # Models used
├── step1_prompt.txt        # Context model input
├── step1_output.txt        # Context model response
├── step2_prompt.txt        # Specialist model input
├── step2_output.txt        # Specialist model response
├── step3_prompt.txt        # Implementation model input
├── step3_output.txt        # Implementation model response
└── summary.md              # Complete analysis
```

### Reading Results
```bash
# View latest summary
ls -t outputs/*/summary.md | head -1 | xargs cat

# View specific step output
cat outputs/universal_life_optimization_[TIMESTAMP]/step3_output.txt
```

---

## Testing & Validation

### Run Comprehensive Tests
```bash
# Test practical utility based on your real situation
./tests/test_practical_utility_pdf_context.sh

# View test results
cat test_logs/practical_utility_report_[TIMESTAMP].txt
```

### Validate Model Functionality
```bash
# Check individual model responses
echo "What are my current priorities?" | ollama run matthew_context_provider_v4_accurate

# Verify all models exist
ollama list | grep -E "(matthew_context_provider_v4_accurate|universal_strategy_architect|creative_catalyst|practical_implementer)"
```

---

## File Locations Reference

### Essential Files
- **Main Runner**: `/Users/matthewscott/Projects/mirador/mirador_universal_runner.sh`
- **Model Creation**: `/Users/matthewscott/Projects/mirador/create_optimized_models_fixed.sh`
- **Test Suite**: `/Users/matthewscott/Projects/mirador/tests/test_practical_utility_pdf_context.sh`
- **Documentation**: `/Users/matthewscott/Projects/mirador/MIRADOR_COMPREHENSIVE_REFERENCE.md`

### Generated Content
- **Output Directory**: `/Users/matthewscott/Projects/mirador/outputs/`
- **Test Logs**: `/Users/matthewscott/Projects/mirador/test_logs/`
- **Model Files**: `~/matthew_context_v4_accurate.modelfile` (and others)

**Mirador v3.0 is ready for immediate practical use in your multi-faceted life optimization journey.** 🚀