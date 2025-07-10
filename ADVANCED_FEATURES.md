# Mirador Advanced Features Guide

## 🚀 New Capabilities

### 1. Command-R RAG Chain
Specialized document analysis using Cohere's Command-R 35B model optimized for retrieval-augmented generation.

```bash
# Basic document analysis
./bin/mirador_rag_chain.sh document "What are the key findings?" /path/to/document.pdf

# Code analysis
./bin/mirador_rag_chain.sh code "Explain the architecture" /path/to/codebase

# Research paper analysis
./bin/mirador_rag_chain.sh research "What methodology was used?" /path/to/paper.pdf

# Business report analysis
./bin/mirador_rag_chain.sh report "Summarize recommendations" /path/to/report.pdf

# Document comparison
./bin/mirador_rag_chain.sh comparison "Compare these approaches" /path/to/docs
```

### 2. Model Consolidation
Streamlined model management removing redundant versions.

```bash
# Update chains to use consolidated models
./update_chains_consolidated.sh

# Remove redundant models (saves 20-30GB)
./consolidate_models_phase2.sh
```

**Consolidated Model Strategy:**
- Keep only latest versions (e.g., v5_complete for context providers)
- Remove test and experimental models
- Maintain one version per function

### 3. Performance Optimization

#### Optimized Models
Fast versions of large models with tuned parameters:
- `gemma2_fast:latest` - Optimized Gemma 2 27B
- `qwen2_fast:latest` - Optimized Qwen 2.5 32B  
- `command_r_fast:latest` - Optimized Command-R 35B

```bash
# Create optimized models
./optimize_model_performance.sh

# Benchmark performance
./benchmark_models.sh

# Dynamic model selection based on query
python3 select_optimal_model.py "your query here"

# Dynamic context sizing
python3 dynamic_context.py model1 model2 model3
```

### 4. Hybrid Chains
Advanced chains combining multiple base LLMs for comprehensive analysis.

```bash
# Multi-LLM synthesis
./bin/mirador_hybrid_chains.sh synthesis "Complex query" --quality

# Research chain (Command-R + Gemma + Mistral)
./bin/mirador_hybrid_chains.sh research "Research question"

# Creative chain (Llama + Phi + Mistral)
./bin/mirador_hybrid_chains.sh creative "Creative prompt" --fast

# Technical chain (DeepSeek + Command-R + Gemma)
./bin/mirador_hybrid_chains.sh technical "Code architecture question"

# Decision chain (Phi + Gemma + Llama)
./bin/mirador_hybrid_chains.sh decision "Should I do X or Y?"

# Cultural chain (Qwen + Gemma + Command-R)
./bin/mirador_hybrid_chains.sh cultural "Cross-cultural question"
```

#### Hybrid Chain Options:
- `--fast` - Use speed-optimized models
- `--quality` - Prioritize quality over speed
- `--parallel` - Run models in parallel (experimental)

### 5. Auto Router
Intelligent query routing that automatically selects the best chain and models.

```bash
# Let Mirador decide the best approach
./bin/mirador_auto_router.sh "your query" --verbose

# Options
./bin/mirador_auto_router.sh "analyze this document" --fast
./bin/mirador_auto_router.sh "complex research question" --quality --verbose
```

The auto router analyzes your query for:
- Query type (quick, analytical, multilingual, document, complex)
- Required context size
- Speed vs quality requirements
- Domain-specific patterns

## 🎯 Usage Recommendations

### For Document Analysis
Use the RAG chain with Command-R for best results:
```bash
./bin/mirador_rag_chain.sh document "query" /path/to/doc
```

### For Quick Decisions
Use the auto router with fast mode:
```bash
./bin/mirador_auto_router.sh "quick decision needed" --fast
```

### For Complex Analysis
Use hybrid chains with quality mode:
```bash
./bin/mirador_hybrid_chains.sh synthesis "complex question" --quality
```

### For Code Review
Use the technical hybrid chain:
```bash
./bin/mirador_hybrid_chains.sh technical "review this architecture"
```

## 📊 Performance Comparison

| Model | Size | Speed | Quality | Best For |
|-------|------|-------|---------|----------|
| llama3.2:3b | 2GB | ⚡⚡⚡⚡⚡ | ⭐⭐⭐ | Quick responses |
| phi3:medium | 7.9GB | ⚡⚡⚡⚡ | ⭐⭐⭐⭐ | Rapid decisions |
| mistral:latest | 4.1GB | ⚡⚡⚡⚡ | ⭐⭐⭐⭐ | Balanced tasks |
| gemma2:27b | 15GB | ⚡⚡ | ⭐⭐⭐⭐⭐ | Deep analysis |
| qwen2.5:32b | 19GB | ⚡⚡ | ⭐⭐⭐⭐⭐ | Multilingual |
| command-r:35b | 18GB | ⚡⚡ | ⭐⭐⭐⭐⭐ | RAG/Documents |

## 🔧 Advanced Configuration

### Custom Model Combinations
Create your own chains by combining models:
```bash
./mirador-ez chain "query" model1 model2 model3 model4
```

### Performance Tuning
Adjust model parameters in modelfiles:
```
PARAMETER num_ctx 4096      # Context window
PARAMETER num_batch 512     # Batch size
PARAMETER num_gpu 999       # GPU layers
PARAMETER temperature 0.7   # Creativity
```

### Memory Management
For systems with limited RAM:
1. Use optimized models (*_fast variants)
2. Reduce context size
3. Run chains sequentially (not parallel)
4. Use smaller base models when possible

## 🚦 Troubleshooting

### Out of Memory
- Use `dynamic_context.py` to calculate optimal settings
- Switch to smaller models or optimized variants
- Reduce context window size

### Slow Performance
- Use `benchmark_models.sh` to identify bottlenecks
- Enable fast mode in chains
- Consider parallel execution for hybrid chains

### Model Not Found
- Run `ollama list` to see installed models
- Create missing models with their modelfiles
- Use `install_diverse_models.sh` for base models

## 📈 Future Enhancements

1. **Streaming Responses** - Real-time output as models generate
2. **Model Caching** - Intelligent caching of common queries
3. **Web Interface** - Browser-based chain execution
4. **API Endpoints** - REST API for integration
5. **Custom Training** - Fine-tune models on personal data

---

*Mirador continues to evolve. Check for updates and contribute at https://github.com/[your-username]/mirador*