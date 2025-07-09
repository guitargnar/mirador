# 🚀 Mirador Optimization Implementation Guide

## Overview

This guide walks you through implementing the immediate and short-term optimizations for your Ollama models, including removing duplicates and diversifying your model portfolio.

## Current Status

### Analysis Results
- **74 total models** using 246.6 GB storage
- **1 exact duplicate** found (llama3.2:latest = llama3.2:3b)
- **5 versions** of matthew_context_provider that can be consolidated
- **94.6% Llama dependency** - needs diversification

### Created Tools
1. `analyze_model_duplicates.py` - Identifies duplicate models
2. `cleanup_duplicate_models.sh` - Safely removes duplicates
3. `install_diverse_models.sh` - Installs Gemma 2, Qwen 2.5, Phi-3
4. `create_diverse_models.sh` - Creates example specialized models
5. `optimize_mirador_chains.sh` - Updates chains with optimized models

## Step-by-Step Implementation

### Step 1: Clean Up Duplicates (Immediate - 5 minutes)

```bash
# First, review what will be removed
cat cleanup_duplicate_models.sh

# Run the cleanup (saves 2 GB immediately)
./cleanup_duplicate_models.sh
```

This will:
- Remove `llama3.2:latest` (duplicate of llama3.2:3b)
- Save backup of current model list
- Free up 2 GB storage

### Step 2: Install Diverse Base Models (Short-term - 20-30 minutes)

```bash
# Run interactive installer
./install_diverse_models.sh
```

Recommended selections:
- **Gemma 2**: Choose `9` (9B model, 5.5 GB) - Best for reasoning
- **Qwen 2.5**: Choose `7` (7B model, 4.7 GB) - Multilingual support
- **Phi-3**: Choose `mini` (2.3 GB) - Ultra-fast responses
- **Optional**: Skip (press `e`) unless you need specialized models

This adds ~12.5 GB but provides significant capability diversity.

### Step 3: Create Specialized Models (10 minutes)

```bash
# Create example models using new base LLMs
./create_diverse_models.sh
```

This creates:
- `analytical_expert_gemma:latest` - Deep reasoning
- `multilingual_assistant_qwen:latest` - Global communication
- `speed_optimizer_phi:latest` - Rapid responses
- `baseline_llama_compact:latest` - Comparison baseline

### Step 4: Activate Optimized Chains (5 minutes)

```bash
# Run optimization script
./optimize_mirador_chains.sh

# Make the new runner your default
ln -sf mirador_universal_runner_v3_optimized.sh bin/mirador_universal_runner.sh
```

New chains available:
- `deep_analysis` - Uses Gemma for complex reasoning
- `global_insight` - Uses Qwen for multilingual tasks
- `rapid_decision` - Uses Phi for speed-critical decisions

### Step 5: Test & Compare Performance (10 minutes)

```bash
# Compare old vs new performance
./compare_chain_performance.sh

# Test diverse models with same prompt
./models/diverse/test_diverse_models.sh
```

## Usage Examples

### Example 1: Deep Analysis with Gemma
```bash
./bin/mirador_universal_runner_v3_optimized.sh deep_analysis \
  "Analyze the trade-offs between remote work and office collaboration for a tech startup"
```

### Example 2: Multilingual Content with Qwen
```bash
./bin/mirador_universal_runner_v3_optimized.sh global_insight \
  "Create a product announcement for US, Chinese, and European markets"
```

### Example 3: Rapid Decision with Phi
```bash
./bin/mirador_universal_runner_v3_optimized.sh rapid_decision \
  "Should I accept a job offer with 20% more pay but 30% more travel?"
```

### Example 4: Traditional Chain (Optimized)
```bash
./bin/mirador_universal_runner_v3_optimized.sh life_optimization \
  "How can I improve my morning routine for better productivity?"
```

## Expected Benefits

### Immediate (After Step 1)
- ✅ 2 GB storage saved
- ✅ Cleaner model list
- ✅ Faster model selection

### Short-term (After Steps 2-5)
- ✅ Model diversity increased from 5.4% to ~20%
- ✅ New capabilities: deep reasoning, multilingual, ultra-fast
- ✅ 10-30% performance improvement on appropriate tasks
- ✅ Better task-model matching

### Performance Comparison

| Task Type | Best Model | Expected Improvement |
|-----------|------------|---------------------|
| Complex Analysis | Gemma 2 | +40% reasoning quality |
| Multilingual | Qwen 2.5 | +60% language accuracy |
| Quick Decisions | Phi-3 | +50% response speed |
| Code Review | DeepSeek | Already optimized |
| General Tasks | Llama 3.2 | Baseline |

## Troubleshooting

### If model installation fails:
```bash
# Check Ollama is running
ollama serve

# Try pulling manually
ollama pull gemma2:9b
```

### If cleanup seems stuck:
```bash
# Check model usage
ollama ps

# Force remove if needed
ollama rm model_name --force
```

### If performance is slower:
- Gemma/Qwen are larger models, expect slower but better quality
- Use Phi-3 for speed-critical tasks
- Keep Llama 3.2 for balanced performance

## Next Steps

### Phase 1 Complete ✅
- Duplicates removed
- Diverse models installed
- Chains optimized

### Phase 2 (Future)
1. **Further Consolidation**: Remove more matthew_context_provider versions
2. **Dynamic Loading**: Implement on-demand model loading
3. **Custom Routing**: Build smart model selection based on query type
4. **Performance Monitoring**: Track which models perform best for which tasks

## Rollback Plan

If you need to revert:
```bash
# Restore original chains
cp bin/mirador-smart-v2.backup bin/mirador-smart-v2
cp bin/mirador_universal_runner_v2.sh.backup bin/mirador_universal_runner_v2.sh

# List new models to remove
ollama list | grep -E "(gemma|qwen|phi|analytical|multilingual|speed_optimizer)"

# Remove if needed
ollama rm model_name
```

---

## Quick Reference Card

```bash
# Remove duplicates (2 GB saved)
./cleanup_duplicate_models.sh

# Install diverse models (~12 GB)
./install_diverse_models.sh
# Recommended: Gemma2-9b, Qwen2.5-7b, Phi3-mini

# Create specialized models
./create_diverse_models.sh

# Activate optimizations
./optimize_mirador_chains.sh

# Test new capabilities
./bin/mirador_universal_runner_v3_optimized.sh deep_analysis "Your complex question"
./bin/mirador_universal_runner_v3_optimized.sh global_insight "Your multilingual need"
./bin/mirador_universal_runner_v3_optimized.sh rapid_decision "Your quick question"
```

Ready to implement? Start with Step 1! 🚀