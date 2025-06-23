# Mirador AI Orchestration - Technical Documentation

## System Architecture

### Overview
Mirador implements a multi-agent AI orchestration pattern where specialized language models collaborate through structured chains to produce emergent intelligence. The system runs entirely locally on Apple Silicon, ensuring privacy and eliminating API costs.

### Core Components

#### 1. Orchestration Engine (`mirador.py`)
- **Purpose**: Manages model chains and inter-model communication
- **Key Features**:
  - Dynamic chain execution with progress tracking
  - Content preservation between models
  - Intelligent output categorization
  - Token management and optimization
  
```python
# Core execution pattern
def execute_chain(prompt, models):
    context = prompt
    for model in models:
        response = query_model(model, context)
        context = merge_contexts(context, response)
    return context
```

#### 2. Model Layer (Ollama)
- **Runtime**: Ollama v0.1.32+ 
- **Base Models**: Llama 3.2, Mistral, CodeLlama
- **Specialized Models**: 7 custom-tuned variants
- **Memory**: 32GB unified memory recommended

#### 3. Command Interface (`mirador-ez`)
- **Location**: `/usr/local/bin/mirador-ez`
- **Purpose**: Global command launcher
- **Implementation**: Bash wrapper around Python engine

### Model Architecture

#### Model Specialization Strategy
Each model is optimized for specific domains through:
1. Custom system prompts
2. Temperature and parameter tuning
3. Domain-specific training examples
4. Output format specifications

#### Model Configurations

**Financial Planning Expert v6**
```
Base: llama3.2_balanced
Temperature: 0.4
Top-p: 0.9
Specialization: Tax strategies, investment analysis, budgeting
Context: Kentucky tax laws, Medicare industry knowledge
```

**Louisville Expert v3**
```
Base: llama3.2
Temperature: 0.5
Top-p: 0.9
Specialization: Local market intelligence, real estate, resources
Context: Jefferson County, JCPS, neighborhood dynamics
```

**Enhanced Agent Enforcer**
```
Base: llama3.2_verbose
Temperature: 0.2
Top-p: 0.8
Purpose: Content preservation and enhancement
Behavior: Expands rather than summarizes
```

### Chain Orchestration

#### Chain Execution Flow
1. **Initialization**: Load models and prepare context
2. **Sequential Processing**: Each model receives cumulative context
3. **Content Merging**: Preserve insights while adding new analysis
4. **Output Formatting**: Structure results for consumption
5. **Categorization**: Auto-classify outputs by domain

#### Optimal Chain Patterns

**Pattern 1: Context → Analysis → Validation → Simplification**
```
matthew_context_provider → financial_planning_expert_v6 → 
opportunity_validator_v2 → decision_simplifier
```

**Pattern 2: Broad → Specific → Actionable**
```
mirador_system_specialist → domain_expert → 
enhanced_agent_enforcer → decision_simplifier
```

### Performance Optimization

#### Token Management
- Dynamic context window allocation
- Intelligent prompt compression
- Response caching for repeated queries
- Batch processing for related queries

#### Speed Optimizations
- Model preloading for common chains
- Parallel model initialization
- Incremental output streaming
- Background model warming

### Data Architecture

#### Output Structure
```
outputs/
├── chain_YYYYMMDD_HHMMSS/
│   ├── 00_initial_prompt.md
│   ├── 01_model1_response.md
│   ├── 02_model2_response.md
│   ├── ...
│   └── summary.md
```

#### Categorization System
- **business_strategies**: Entrepreneurial opportunities
- **career_plans**: Professional development paths
- **financial_plans**: Investment and money management
- **health_wellness**: Life optimization strategies
- **uncategorized**: Edge cases and unique queries

### Memory and Context

#### Context Window Management
- Base context: 8,192 tokens
- Extended context: Up to 32,768 tokens for complex chains
- Smart truncation: Preserves key insights while managing length

#### Memory Persistence
- SQLite database for conversation history
- Embedded vector storage for semantic search
- Session management for multi-turn interactions

### Integration Points

#### File System Integration
```bash
# Input processing
- Markdown files
- CSV data import
- Previous analysis results

# Output generation  
- Structured markdown reports
- Actionable insight extraction
- ROI tracking data
```

#### External Tool Integration
- Git for version control
- Bash for automation
- Python for data analysis
- SQLite for persistence

### Security and Privacy

#### Data Protection
- All processing occurs locally
- No external API calls
- No data transmission
- Encrypted storage optional

#### Model Isolation
- Separate model instances
- No cross-contamination
- Clean context initialization
- Secure prompt handling

### Monitoring and Analytics

#### Performance Metrics
```python
metrics = {
    'execution_time': time_elapsed,
    'tokens_processed': total_tokens,
    'models_used': model_list,
    'output_quality': word_count,
    'chain_complexity': len(models)
}
```

#### Success Tracking
- Chain completion rate: 100%
- Average execution time: 45-90 seconds
- Output quality score: 1,341 words average
- User satisfaction: Measured through ROI tracking

### Debugging and Troubleshooting

#### Common Issues

**1. Model Loading Failures**
```bash
# Check model availability
ollama list

# Reload model
ollama pull model_name
```

**2. Chain Execution Errors**
```python
# Enable debug mode
export MIRADOR_DEBUG=1
mirador-ez chain "test query" model1 model2
```

**3. Memory Issues**
```bash
# Check memory usage
top -l 1 | grep -E "^(Phys|Memory)"

# Clear Ollama cache
rm -rf ~/.ollama/cache/*
```

### Development Guidelines

#### Adding New Models
1. Create modelfile with optimized parameters
2. Test individually with diverse prompts
3. Validate chain compatibility
4. Document specialization and use cases
5. Update model registry

#### Chain Development
1. Identify user need and desired outcome
2. Select models based on required expertise
3. Order models for optimal context flow
4. Test with edge cases
5. Measure and optimize performance

### API Reference

#### Core Functions

**execute_chain(prompt, models, options)**
- prompt: Initial query string
- models: List of model names
- options: Dict of execution parameters
- returns: ChainResult object

**ask_model(model, prompt, temperature=None)**
- model: Model name
- prompt: Query string  
- temperature: Override default
- returns: ModelResponse object

**track_roi(opportunity, value, status)**
- opportunity: Name/description
- value: Monetary value
- status: planned|in-progress|completed
- returns: TrackingID

### Performance Benchmarks

| Operation | Target | Actual |
|-----------|--------|--------|
| Model Load | <2s | 1.2s |
| Single Query | <10s | 7s |
| 3-Model Chain | <60s | 47s |
| 5-Model Chain | <120s | 92s |
| Analytics Gen | <5s | 3s |

### Future Architecture Considerations

#### Planned Enhancements
1. Parallel chain execution for independent models
2. Dynamic model selection based on query analysis
3. Automated prompt optimization through feedback
4. Distributed execution across multiple machines
5. Real-time learning from successful outcomes

#### Scalability Path
- Current: Single machine, sequential execution
- Next: Multi-threaded parallel processing
- Future: Distributed orchestration cluster

---

*Technical questions? Review the source code in `mirador.py` or examine model configurations in `*.modelfile`*