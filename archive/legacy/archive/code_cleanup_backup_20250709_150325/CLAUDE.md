# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build/Run Commands

### Core Mirador Commands
```bash
# Basic chain execution with smart routing
./mirador-smart-v2 "Your query here"

# Universal runner with format options
./mirador_universal_runner_v2.sh <chain_type> "Your prompt" [format]
# Chain types: life_optimization, business_acceleration, creative_breakthrough, 
#              relationship_harmony, technical_mastery, strategic_synthesis
# Formats: quick, summary, detailed (default), export

# Simple interface
./mirador-ez chain "Your query" model1 model2 model3

# Run specific Company-focused chains
./company_chain_runner.sh <chain_type> "Your prompt"
```

### Model Management
```bash
# Create/update optimized models
./create_optimized_models_fixed.sh

# List installed models
ollama list | grep -E "(matthew_context|universal_strategy|creative_catalyst|practical_implementer)"

# Test model directly
echo "Test prompt" | ollama run matthew_context_provider_v5_complete
```

### Testing & Validation
```bash
# Run comprehensive test suite
./tests/test_practical_utility_pdf_context.sh

# Test specific chains
./tests/test_chains.sh

# Validate constraints on output
python3 constraint_validator.py validate outputs/session_folder/summary.md

# Check system health
./daily_check_enhanced.sh
```

### Feedback & Analytics
```bash
# Rate an output (1-5 scale)
./mirador_feedback.sh SESSION_ID 5 "Excellent - saved 2 hours"

# View usage statistics
python3 context_manager.py stats

# Generate insights from memory
python3 ai_memory/init_db.py  # Initialize memory database
```

## Architecture Overview

Mirador is a multi-layered AI orchestration system built on Ollama, implementing sophisticated chain-of-thought reasoning through specialized models.

### Core Flow
```
User Query → Smart Router → Chain Selection → Model Pipeline → Constraint Validation → Output
                                                    ↓
                                            Context Accumulation
                                                    ↓
                                            Feedback Collection → Memory System
```

### Key Components

1. **Entry Points** (`mirador-smart-v2`, `mirador_universal_runner_v2.sh`)
   - Smart routing based on query analysis
   - Format selection (quick/summary/detailed/export)

2. **Model Layer** (80+ specialized models in `.ollama/models/manifests/`)
   - Context providers: Personal/professional background
   - Domain experts: Financial, music, health, Louisville-specific
   - Strategy models: Planning and synthesis
   - Implementation models: Actionable steps

3. **Chain Orchestration**
   - 6 universal chain types for different life domains
   - Dynamic model selection (3-6 models per chain)
   - Context flows and accumulates through model sequence

4. **Support Systems**
   - `context_manager.py`: Context caching and usage tracking
   - `constraint_validator.py`: Real-world feasibility checking
   - `mirador_feedback.sh`: User rating collection
   - `ai_memory/`: SQLite-based conversation history

5. **Output Management**
   - Structured outputs in `outputs/universal_<chain>_<timestamp>/`
   - Multiple format options for different use cases
   - Session tracking and persistence

### Model Chaining Pattern
```
matthew_context_provider → domain_expert → strategy_architect → decision_simplifier
```

Each model receives the original prompt plus enriched context from previous models, building comprehensive analysis.

## Company Strategic Commands

The system includes specialized commands for corporate innovation strategy at Company. Key chain runners:

- `strategic_synthesis`: High-level strategic planning
- `corporate_nav`: Political navigation and stakeholder management  
- `ai_leadership`: Career positioning and thought leadership
- `advocates_strategy`: Building internal support networks
- `innovation_discovery`: Identifying new use cases
- `solution_design`: Creating formal proposals

See the strategic prompt library below for specific use cases.

## Development Notes

### Adding New Models
1. Create modelfile in root directory
2. Run `ollama create model_name -f modelfile`
3. Add to appropriate chain in `mirador-smart-v2` or universal runner
4. Test with sample queries

### Modifying Chains
- Edit model sequences in shell scripts
- Ensure context provider is first for proper grounding
- Test full chain execution before committing

### Performance Optimization
- Models use Apple Silicon optimized parameters
- Context window: 8192 tokens
- Response length: 2048 tokens
- Temperature: 0.7 for balanced creativity

---

## Strategic Command Library

### Daily Operations
```bash
# Morning alignment
./company_chain_runner.sh strategic_synthesis "Today is [DATE]. My calendar shows: [PASTE YOUR CALENDAR]. My top 3 priorities this week are: 1) Maintain Risk Management excellence, 2) Build Mirador coalition, 3) Position for AI leadership. Given these constraints and opportunities, what are the 3 highest-leverage actions I should take today?"

# Pre-meeting intelligence
./company_chain_runner.sh corporate_nav "I have a meeting with [PERSON/TEAM] in 30 minutes about [TOPIC]. Their priorities are [THEIR GOALS]. How should I navigate this conversation to build support for innovation?"

# End-of-day reflection
./company_chain_runner.sh ai_leadership "Today I accomplished: [LIST WINS]. I faced challenges with: [LIST CHALLENGES]. Tomorrow's key meetings are: [LIST MEETINGS]. How can I build on today's momentum?"
```

### Innovation Strategy
```bash
# Department ROI calculation
./company_chain_runner.sh solution_design "[DEPARTMENT NAME] currently spends [X HOURS] per week on [SPECIFIC TASK]. Calculate the specific ROI if Mirador automated their process."

# Pilot proposals
./company_chain_runner.sh solution_design "Create a formal pilot proposal for implementing Mirador in [DEPARTMENT]. Include executive summary, current state analysis, proposed future state, implementation timeline, success metrics."

# Scaling strategy
./company_chain_runner.sh strategic_synthesis "Assuming approval to scale Mirador, create a 180-day roadmap that maintains quality while scaling, builds organizational capability, and positions me as indispensable architect."
```

### Career Acceleration
```bash
# AI leadership positioning
./company_chain_runner.sh ai_leadership "I want to be Company's first VP of AI Innovation. Current title: Risk Management Professional II. What specific actions over the next 90 days position me for this role?"

# LinkedIn thought leadership
./company_chain_runner.sh ai_leadership "Create a LinkedIn post about [AI TOPIC] that demonstrates thought leadership without revealing Mirador specifically, attracts Company executive attention."
```