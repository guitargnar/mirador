# Mirador Architecture Documentation

## System Overview

Mirador is a sophisticated AI orchestration system that implements multi-model chaining for enhanced intelligence. The system routes queries through specialized models based on intent analysis, accumulating context to provide comprehensive responses.

## Architecture Diagram

```mermaid
graph TB
    subgraph "Entry Layer"
        UI[User Interface]
        CLI[CLI Commands]
        API[API Endpoints]
    end
    
    subgraph "Routing Layer"
        SR[Smart Router]
        IA[Intent Analyzer]
        MC[Model Chain Selector]
    end
    
    subgraph "Model Layer"
        subgraph "Context Models"
            CP[matthew_context_provider_v6]
        end
        
        subgraph "Domain Models"
            UFA[universal_financial_advisor]
            UHW[universal_health_wellness]
            ULE[universal_louisville_expert]
            UMM[universal_music_mentor]
            UCS[universal_career_strategist]
            UCN[universal_corporate_navigator]
            UCC[universal_creative_catalyst]
            URH[universal_relationship_harmony]
        end
        
        subgraph "Strategy Models"
            USA[universal_strategy_architect]
            AEG[analytical_expert_gemma]
        end
        
        subgraph "Implementation Models"
            PI[practical_implementer]
            SOP[speed_optimizer_phi]
        end
    end
    
    subgraph "Execution Layer"
        CE[Chain Executor]
        CA[Context Accumulator]
        SE[Stream Engine]
    end
    
    subgraph "Storage Layer"
        FS[File System]
        MD[Model Database]
        OC[Output Cache]
    end
    
    UI --> SR
    CLI --> SR
    API --> SR
    
    SR --> IA
    IA --> MC
    MC --> CE
    
    CE --> CP
    CE --> UFA
    CE --> UHW
    CE --> ULE
    CE --> UMM
    CE --> UCS
    CE --> UCN
    CE --> UCC
    CE --> URH
    CE --> USA
    CE --> AEG
    CE --> PI
    CE --> SOP
    
    CE --> CA
    CA --> SE
    
    SE --> FS
    CE --> MD
    SE --> OC
```

## Component Details

### 1. Entry Layer

#### User Interface Options
- **CLI Commands**: Primary interface through shell scripts
- **API Endpoints**: REST API for programmatic access (future)
- **Web Dashboard**: Streamlit-based UI (optional)

### 2. Routing Layer

#### Smart Router (`mirador-smart-v2`)
- Analyzes query intent using pattern matching
- Selects appropriate model chain
- Manages execution flow

#### Intent Categories
1. **Quick**: Fast responses using speed optimizer
2. **Financial**: Budget, investment, money management
3. **Health**: Wellness, fitness, energy optimization
4. **Location**: Louisville-specific knowledge
5. **Music**: Practice, performance, creativity
6. **Career**: Professional development, corporate strategy
7. **Creative**: Innovation, breakthrough thinking
8. **Family**: Relationships, parenting
9. **Strategic**: Complex planning and analysis

### 3. Model Layer

#### Model Types

**Context Providers**
- Provide personal and situational context
- First in most chains
- Example: `matthew_context_provider_v6`

**Domain Experts**
- Specialized knowledge in specific areas
- 8 consolidated universal models
- Examples: financial, health, music advisors

**Strategy Models**
- High-level planning and synthesis
- Connect insights across domains
- Examples: strategy architect, analytical expert

**Implementation Models**
- Convert insights to actionable steps
- Practical, specific guidance
- Example: `practical_implementer`

### 4. Execution Layer

#### Chain Executor
```python
# Pseudo-code for chain execution
context = ""
for model in chain:
    if first_model:
        response = model.process(query)
    else:
        response = model.process(query + context)
    context += response
    stream_to_user(response)
```

#### Context Accumulation
- Each model receives original query + accumulated context
- Context grows through the chain
- Enables sophisticated multi-perspective analysis

### 5. Storage Layer

#### File System Structure
```
mirador/
├── bin/                 # Executable scripts
├── config/             # Routing configurations
├── models/             # Model definitions
├── outputs/            # Session outputs
├── logs/               # Execution logs
└── cache/              # Response cache
```

## Data Flow

```mermaid
sequenceDiagram
    participant U as User
    participant SR as Smart Router
    participant IA as Intent Analyzer
    participant CE as Chain Executor
    participant M1 as Model 1
    participant M2 as Model 2
    participant M3 as Model 3
    participant CA as Context Accumulator
    
    U->>SR: Query
    SR->>IA: Analyze Intent
    IA->>SR: Intent Category
    SR->>CE: Execute Chain
    
    CE->>M1: Query
    M1->>CE: Response 1
    CE->>CA: Add to Context
    
    CE->>M2: Query + Context
    M2->>CE: Response 2
    CE->>CA: Add to Context
    
    CE->>M3: Query + Full Context
    M3->>CE: Response 3
    
    CE->>U: Streamed Responses
```

## Performance Characteristics

### Response Times
- **Quick queries**: 0.4-0.9s first token
- **Standard chains**: 1-3s first token
- **Complex chains**: 2-5s first token

### Resource Usage
- **Memory**: 3-5GB active, up to 8GB peak
- **CPU**: Optimized for Apple Silicon
- **Storage**: ~90GB for all models

### Scalability
- Horizontal: Multiple concurrent queries
- Vertical: Larger models for better quality
- Caching: Reduces repeated query time

## Security Model

### Data Privacy
- 100% local processing
- No external API calls
- No telemetry or tracking

### Access Control
- File system permissions
- User-level isolation
- No network exposure by default

## Extension Points

### Adding New Models
1. Create model definition
2. Add to routing configuration
3. Define chain patterns
4. Test integration

### Custom Chains
- Define in routing YAML
- Specify model sequence
- Configure context handling

### API Integration
- REST endpoint design
- Authentication framework
- Rate limiting strategy

## Future Architecture Enhancements

### Planned Features
1. **Dynamic routing** based on response quality
2. **Parallel execution** for independent models
3. **Feedback loop** for continuous improvement
4. **Plugin system** for custom models
5. **Distributed execution** across machines

### Performance Optimizations
1. **Model quantization** for faster inference
2. **Response caching** with semantic similarity
3. **Predictive loading** of likely next models
4. **GPU acceleration** where available

## Conclusion

Mirador's architecture enables sophisticated AI orchestration through:
- Intelligent routing based on query intent
- Multi-model chaining with context accumulation
- Optimized local execution for privacy
- Extensible design for future enhancements

The system demonstrates that orchestrating multiple specialized models can provide superior results compared to single large models, while maintaining complete data privacy.