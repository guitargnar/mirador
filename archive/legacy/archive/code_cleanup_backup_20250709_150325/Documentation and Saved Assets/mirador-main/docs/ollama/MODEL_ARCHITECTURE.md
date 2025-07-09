# Mirador Model Architecture

This document explains the architecture and relationships between the specialized models in the Mirador AI Framework, including their optimization parameters, integration points, and chaining capabilities.

## Core Architecture Principles

The Mirador framework is built around these key architectural principles:

1. **Model Specialization**: Each model is optimized for specific tasks with custom system prompts and temperature settings
2. **Sequential Processing**: Models can be chained in sequence, with outputs from one becoming inputs to the next
3. **Bidirectional Communication**: Models can query each other for information to enhance their outputs
4. **Stateless API**: Direct interfaces with no session management for simplicity and reliability
5. **Domain-Specific Workflows**: Pre-configured specialist combinations for common domains

## Model Optimization Parameters

Each specialized model has been carefully tuned with specific parameters:

| Model | Base Model | Temperature | Context Window | Primary Optimization |
|-------|------------|-------------|----------------|----------------------|
| `fast-agent` | llama3 | 0.3 | 2048 | Speed, precision |
| `fast_agent_focused` | fast-agent | 0.3 | 2048 | Structure, organization |
| `guitar_expert_precise` | guitar-expert | 0.4 | 16384 | Tablature generation |
| `llama3.2_balanced` | llama3.2 | 0.6 | 8192 | Balanced creativity/precision |
| `master_coder` | master-coder | 0.4 | 8192 | Clean code, modularity |
| `code_reviewer_fix` | code-reviewer-fix | 0.3 | 8192 | Security, bug detection |
| `enhanced_agent` | enhanced-agent | 0.7 | 8192 | Comprehensive analysis |
| `creative_entrepreneur` | creative-entrepreneur | 0.7 | 8192 | Business innovation |
| `file_reviewer` | file-reviewer | 0.4 | 8192 | Documentation clarity |
| `ux_designer` | ux-designer | 0.7 | 16384 | User interface design |

## Temperature Settings Explained

Temperature controls the randomness in model outputs:

- **Low (0.3-0.4)**: More deterministic, precise responses ideal for factual information, code, and technical documentation
- **Medium (0.5-0.6)**: Balanced between creativity and precision for general knowledge tasks
- **High (0.7+)**: More creative, diverse responses for business ideas, design, and creative tasks

## Context Window Implications

The context window size determines how much information the model can consider:

- **Small (2048 tokens)**: Fast response models with limited memory
- **Medium (8192 tokens)**: Standard for most technical and analytical models
- **Large (16384+ tokens)**: Specialized models that need to process more complex information like music notation or complex visual designs

## Integration Points

### 1. Sequential Chaining

Models can be chained in sequence using the following interfaces:

```bash
# Basic chain using run_chain.sh
./scripts/run_chain.sh "Create a secure login system" master_coder code_reviewer_fix

# Role-based chain for code review
./scripts/run_role_chain.sh "<code snippet>" master_coder code_reviewer_fix

# Domain-specific chain
domain-collab domain dev "Create a user authentication system"
```

### 2. Bidirectional Communication

Models can exchange information in both directions:

```bash
# Specialists collaborating with bidirectional communication
./mirador-collaborate --specialists master_coder security_expert "Design a secure API"
```

This allows models to:
- Request clarification from each other
- Share domain knowledge across specializations
- Progressively enhance solutions through multiple perspectives

### 3. Direct Access

Models can be accessed directly for simple tasks:

```bash
# Direct API access (no session)
./scripts/direct-ollama.sh fast-agent "What is Python?"

# Standard Ollama interface
./scripts/run-ollama.sh master_coder "Create a sorting function"
```

## Architectural Diagrams

### Basic Sequential Processing
```
Input → Model A → Output A → Model B → Output B → Final Result
```

### Bidirectional Specialist Communication
```
                 ┌───────────────┐
                 │               │
                 ▼               │
Input → Model A ⇄ Model B ⇄ Model C → Final Result
                 │       ▲       │
                 ▼       │       ▼
                 └───────┴───────┘
```

### Domain-Specific Workflow
```
              ┌─────────────┐
              │  Workflow   │
              │  Template   │
              └──────┬──────┘
                     │
                     ▼
Input → Specialist Selection → Chain Execution → Output Processing → Result
```

## Integration with Ollama

The Mirador framework integrates with Ollama through:

1. **Direct API calls**: Using curl to access the Ollama API directly
2. **CLI integration**: Using the ollama command-line interface
3. **Modelfile management**: Custom modelfiles for specialized system prompts

## Performance Considerations

- **Speed vs. Quality**: Fast models (temp 0.3) provide quick responses while comprehensive models (temp 0.7) provide deeper analysis
- **Memory Usage**: Higher context window models require more memory but handle complex inputs better
- **Chain Length**: Performance decreases with longer chains; 2-3 models is optimal for most tasks

## Best Practices

1. **Start with focused models**: Begin with fast-agent or domain-specific models for initial exploration
2. **Gradually add complexity**: Add specialists incrementally to refine solutions
3. **Balance temperature settings**: Mix precise and creative models for comprehensive results
4. **Use bidirectional communication**: Enable specialist cooperation for complex problems
5. **Consider context limitations**: Be mindful of context windows when dealing with large inputs

## Future Architectural Directions

1. **Dynamic Specialist Selection**: Automatic selection of specialists based on task analysis
2. **Parallel Processing**: Run compatible specialists simultaneously for faster processing
3. **Knowledge Persistence**: Store specialist outputs for reuse across related projects
4. **Self-improving Chains**: Chains that adjust their composition based on performance metrics
5. **Custom Model Integration**: Framework for integrating new specialized models