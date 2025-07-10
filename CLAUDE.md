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

# Optimized runner with diverse models
./bin/mirador_universal_runner_v3_optimized.sh <chain_type> "Your prompt" [format]
# Additional chains: deep_analysis, global_insight, rapid_decision

# Simple interface
./mirador-ez chain "Your query" model1 model2 model3

# Run specific Humana-focused chains
./humana_chain_runner.sh <chain_type> "Your prompt"
```

### Model Management
```bash
# Create/update optimized models
./create_optimized_models_fixed.sh

# List installed models
ollama list | grep -E "(matthew_context|universal_strategy|creative_catalyst|practical_implementer)"

# Test model directly
echo "Test prompt" | ollama run matthew_context_provider_v5_complete

# Analyze model base LLMs
python3 trace_ollama_models.py

# Install diverse base LLMs
./install_diverse_models.sh

# Create models with diverse base LLMs
./create_diverse_models.sh

# Clean up duplicate models
./cleanup_duplicate_models.sh
```

### Testing & Validation
```bash
# Run comprehensive test suite
./tests/run_tests.sh

# Test specific chains
python3 tests/test_chains.py

# Test model availability
python3 tests/test_models.py

# Performance testing
python3 tests/test_performance.py

# Test diverse models
./models/diverse/test_diverse_models.sh

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

### Dependencies
```bash
# Install Python dependencies
pip3 install -r requirements.txt

# Note: orjson==3.9.15 (3.10+ has compatibility issues)
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

1. **Entry Points** 
   - `mirador-smart-v2`: Smart routing based on query analysis
   - `mirador_universal_runner_v2.sh`: Universal chain runner
   - `mirador_universal_runner_v3_optimized.sh`: Optimized with diverse models

2. **Model Layer** (80+ specialized models)
   - Context providers: Personal/professional background
   - Domain experts: Financial, music, health, Louisville-specific
   - Strategy models: Planning and synthesis
   - Implementation models: Actionable steps
   - **Base LLMs**: 
     - Llama 3.2 (primary - ~70% of models)
     - Gemma 2 27B (Google's efficient reasoning)
     - Qwen 2.5 32B (Alibaba's multilingual)
     - Phi-3 Medium (Microsoft's ultra-fast)
     - Command-R 35B (Cohere's RAG-optimized)
     - Mistral 7B (French efficient model)
     - DeepSeek-Coder (specialized for code)

3. **Chain Orchestration**
   - 9 universal chain types (6 original + 3 optimized)
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

## Testing Guidelines

- Run `./tests/run_tests.sh` for interactive test menu
- Quick tests (5 min): Basic validation
- Standard tests (15 min): System + chains + basic performance
- Comprehensive tests (30+ min): Full suite including all models
- Test results saved to `/test_logs/`

Key test files:
- `tests/mirador_test_suite.py`: System validation
- `tests/test_chains.py`: Chain functionality
- `tests/test_models.py`: Ollama model checks
- `tests/test_performance.py`: Performance benchmarks
- `tests/TEST_EXECUTION_GUIDE.md`: Comprehensive testing documentation

## Development Notes

### Adding New Models
1. Create modelfile in root directory
2. Run `ollama create model_name -f modelfile`
3. Add to appropriate chain in runners
4. Test with sample queries

### Model Diversity Strategy
The system now incorporates diverse base LLMs to reduce over-reliance on Llama:
- **Gemma 2**: Best for analytical and reasoning tasks
- **Qwen 2.5**: Excellent for multilingual and cultural contexts
- **Phi-3**: Ultra-fast for quick decisions and summaries
- **Command-R**: Optimized for RAG (retrieval-augmented generation)

### Modifying Chains
- Edit model sequences in shell scripts
- Ensure context provider is first for proper grounding
- Test full chain execution before committing

### Performance Optimization
- Models use Apple Silicon optimized parameters
- Context window: 8192 tokens
- Response length: 2048 tokens
- Temperature: 0.7 for balanced creativity
- Larger models (27B-35B) provide better quality at cost of speed

### Code Style
- Shell scripts: Use bash, follow existing patterns
- Python: PEP 8, type hints encouraged
- Maintain existing file structure
- Test changes thoroughly

## Common Patterns

### Query Routing (mirador-smart-v2)
```bash
if [[ "$QUERY" =~ (financial|money|investment) ]]; then
    # Use financial chain
elif [[ "$QUERY" =~ (Louisville|local|Kentucky) ]]; then
    # Use Louisville chain
```

### Model Chaining
```bash
for MODEL in "${MODELS[@]}"; do
    OUTPUT=$(echo "$INPUT" | ollama run "$MODEL")
    CONTEXT="$CONTEXT\n\n=== $MODEL ===\n$OUTPUT"
done
```

### Output Formats
- quick: Key points only (grep bullet points)
- summary: First 100 lines
- detailed: Full analysis
- export: Save to file

## Humana-Specific Commands

The system includes specialized commands for corporate innovation strategy. Key chains:
- `strategic_synthesis`: High-level strategic planning
- `corporate_nav`: Political navigation
- `ai_leadership`: Career positioning
- `solution_design`: Formal proposals

See shell scripts in root for implementation details.

## Important Notes

- All models run locally via Ollama
- No external API dependencies
- Privacy-first architecture
- Session data stored locally in SQLite
- Optimized for Apple Silicon (M-series chips)
- Model diversity reduces single-vendor dependency
- Larger models (27B+) require significant RAM (16GB+ recommended)