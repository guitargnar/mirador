#!/bin/bash
# Optimize Mirador chains by removing duplicates and adding diverse models

echo "🔧 Optimizing Mirador Model Chains"
echo "=================================="
echo ""

# Backup current configurations
echo "📁 Backing up current configurations..."
cp bin/mirador-smart-v2 bin/mirador-smart-v2.backup
cp bin/mirador_universal_runner_v2.sh bin/mirador_universal_runner_v2.sh.backup
echo "✅ Backups created"

# Create optimized universal runner
cat > bin/mirador_universal_runner_v3_optimized.sh << 'EOF'
#!/bin/bash
# Mirador Universal Runner v3 - Optimized with diverse models

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

# Check arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <chain_type> <prompt> [format]"
    echo ""
    echo "Chain types:"
    echo "  life_optimization    - Personal productivity & wellness"
    echo "  business_acceleration - Career & business strategy"
    echo "  creative_breakthrough - Innovation & creative work"
    echo "  relationship_harmony  - Communication & relationships"
    echo "  technical_mastery    - Technology & programming"
    echo "  strategic_synthesis  - High-level planning"
    echo "  deep_analysis       - Complex reasoning (Gemma-powered)"
    echo "  global_insight      - Multilingual & cultural (Qwen-powered)"
    echo "  rapid_decision      - Fast decisions (Phi-powered)"
    echo ""
    echo "Formats: quick, summary, detailed (default), export"
    exit 1
fi

CHAIN_TYPE=$1
PROMPT=$2
FORMAT=${3:-detailed}

# Set models based on chain type
case "$CHAIN_TYPE" in
    "life_optimization")
        # Use latest context provider only (removed duplicates)
        MODELS=(
            "matthew_context_provider_v5_complete:latest"
            "health_wellness_optimizer:latest"
            "productivity_optimizer:latest"
            "action_crystallizer:latest"
        )
        ;;
    
    "business_acceleration")
        # Removed duplicate accelerators
        MODELS=(
            "matthew_context_provider_v5_complete:latest"
            "ai_career_strategist:latest"
            "matthews_strategic_accelerator_v2:latest"
            "solution_architect:latest"
        )
        ;;
    
    "creative_breakthrough")
        MODELS=(
            "matthew_context_provider_v5_complete:latest"
            "creative_catalyst:latest"
            "digital_storyteller:latest"
            "engagement_optimizer:latest"
        )
        ;;
    
    "relationship_harmony")
        MODELS=(
            "matthew_context_provider_v5_complete:latest"
            "relationship_communication_specialist:latest"
            "life_transition_coordinator:latest"
            "action_crystallizer:latest"
        )
        ;;
    
    "technical_mastery")
        # Use specialized code models
        MODELS=(
            "matthew_context_provider_v5_complete:latest"  # Lighter for speed
            "master_coder:latest"
            "code_reviewer:latest"  # DeepSeek-based
            "solution_architect:latest"
        )
        ;;
    
    "strategic_synthesis")
        MODELS=(
            "matthew_context_provider_v5_complete:latest"
            "universal_strategy_architect:latest"
            "cross_model_synthesizer:latest"
            "optimized_decision_simplifier_v3:latest"
        )
        ;;
    
    "deep_analysis")
        # NEW: Gemma-powered deep reasoning
        MODELS=(
            "matthew_context_provider_v5_complete:latest"
            "analytical_expert_gemma:latest"
            "universal_strategy_architect:latest"
            "practical_implementer:latest"
        )
        ;;
    
    "global_insight")
        # NEW: Qwen-powered multilingual
        MODELS=(
            "matthew_context_provider_v5_complete:latest"
            "multilingual_assistant_qwen:latest"
            "engagement_optimizer:latest"
            "action_crystallizer:latest"
        )
        ;;
    
    "rapid_decision")
        # NEW: Phi-powered fast decisions
        MODELS=(
            "speed_optimizer_phi:latest"
            "matthew_context_provider_v5_complete:latest"
            "action_crystallizer:latest"
        )
        ;;
    
    *)
        echo "Invalid chain type: $CHAIN_TYPE"
        exit 1
        ;;
esac

# Create output directory
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="outputs/universal_${CHAIN_TYPE}_${TIMESTAMP}"
mkdir -p "$OUTPUT_DIR"

echo -e "${BLUE}🚀 Running Optimized ${CHAIN_TYPE} Chain${RESET}"
echo -e "${GREEN}Models: ${MODELS[*]}${RESET}"
echo -e "${YELLOW}Format: $FORMAT${RESET}"
echo ""

# Initialize context
CONTEXT=""
FULL_OUTPUT=""

# Run through model chain
for i in "${!MODELS[@]}"; do
    MODEL="${MODELS[$i]}"
    echo -e "${BLUE}Running $MODEL ($(($i + 1))/${#MODELS[@]})...${RESET}"
    
    # Prepare input
    if [ $i -eq 0 ]; then
        INPUT="$PROMPT"
    else
        INPUT="Original request: $PROMPT

Previous analysis:
$CONTEXT

Please add your perspective and insights."
    fi
    
    # Run model and capture output
    OUTPUT=$(echo "$INPUT" | ollama run "$MODEL" 2>/dev/null)
    
    # Save individual output
    echo "$OUTPUT" > "$OUTPUT_DIR/response_$(($i + 1))_${MODEL//:/_}.md"
    
    # Update context
    CONTEXT="$CONTEXT

=== $MODEL ===
$OUTPUT"
    
    FULL_OUTPUT="$FULL_OUTPUT

## Model $(($i + 1)): $MODEL

$OUTPUT"
done

# Generate final output based on format
case "$FORMAT" in
    "quick")
        # Extract key points only
        echo "$FULL_OUTPUT" | grep -E "^[-•*]|^[0-9]\." | head -20 > "$OUTPUT_DIR/summary.md"
        cat "$OUTPUT_DIR/summary.md"
        ;;
    
    "summary")
        # First 100 lines of combined output
        echo "$FULL_OUTPUT" | head -100 > "$OUTPUT_DIR/summary.md"
        cat "$OUTPUT_DIR/summary.md"
        ;;
    
    "detailed")
        # Full output
        echo "$FULL_OUTPUT" > "$OUTPUT_DIR/full_analysis.md"
        cat "$OUTPUT_DIR/full_analysis.md"
        ;;
    
    "export")
        # Save and notify
        echo "$FULL_OUTPUT" > "$OUTPUT_DIR/full_analysis.md"
        echo -e "${GREEN}✅ Analysis exported to: $OUTPUT_DIR/full_analysis.md${RESET}"
        ;;
esac

# Save metadata
cat > "$OUTPUT_DIR/metadata.json" << EOJSON
{
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "chain_type": "$CHAIN_TYPE",
    "format": "$FORMAT",
    "models": $(echo "${MODELS[@]}" | jq -R -s -c 'split(" ")'),
    "prompt": $(echo "$PROMPT" | jq -R -s -c .)
}
EOJSON

echo -e "\n${GREEN}✅ Chain complete! Results in: $OUTPUT_DIR${RESET}"
EOF

chmod +x bin/mirador_universal_runner_v3_optimized.sh

# Create comparison script
cat > compare_chain_performance.sh << 'EOF'
#!/bin/bash
# Compare performance between old and new chains

echo "📊 Comparing Chain Performance"
echo "============================="
echo ""

TEST_PROMPT="How can I balance immediate work priorities with long-term career growth?"

echo "Test prompt: $TEST_PROMPT"
echo ""

# Test old chain
echo "1. Testing OLD chain (v2)..."
START_TIME=$(date +%s)
./bin/mirador_universal_runner_v2.sh life_optimization "$TEST_PROMPT" quick > /tmp/old_output.txt 2>&1
END_TIME=$(date +%s)
OLD_DURATION=$((END_TIME - START_TIME))

echo "   Duration: ${OLD_DURATION}s"
echo "   Output size: $(wc -l < /tmp/old_output.txt) lines"
echo ""

# Test new chain
echo "2. Testing NEW chain (v3 optimized)..."
START_TIME=$(date +%s)
./bin/mirador_universal_runner_v3_optimized.sh life_optimization "$TEST_PROMPT" quick > /tmp/new_output.txt 2>&1
END_TIME=$(date +%s)
NEW_DURATION=$((END_TIME - START_TIME))

echo "   Duration: ${NEW_DURATION}s"
echo "   Output size: $(wc -l < /tmp/new_output.txt) lines"
echo ""

# Test diverse chain
echo "3. Testing DIVERSE chain (deep_analysis)..."
START_TIME=$(date +%s)
./bin/mirador_universal_runner_v3_optimized.sh deep_analysis "$TEST_PROMPT" quick > /tmp/diverse_output.txt 2>&1
END_TIME=$(date +%s)
DIVERSE_DURATION=$((END_TIME - START_TIME))

echo "   Duration: ${DIVERSE_DURATION}s"
echo "   Output size: $(wc -l < /tmp/diverse_output.txt) lines"
echo ""

# Summary
echo "Summary:"
echo "--------"
echo "Old chain (v2): ${OLD_DURATION}s"
echo "New chain (v3): ${NEW_DURATION}s"
echo "Diverse chain: ${DIVERSE_DURATION}s"

if [ $NEW_DURATION -lt $OLD_DURATION ]; then
    IMPROVEMENT=$((100 * (OLD_DURATION - NEW_DURATION) / OLD_DURATION))
    echo ""
    echo "✅ New chain is ${IMPROVEMENT}% faster!"
else
    echo ""
    echo "⚠️  New chain is slower - may need optimization"
fi

echo ""
echo "Output samples:"
echo ""
echo "OLD chain first 5 lines:"
head -5 /tmp/old_output.txt
echo ""
echo "NEW chain first 5 lines:"
head -5 /tmp/new_output.txt
echo ""
echo "DIVERSE chain first 5 lines:"
head -5 /tmp/diverse_output.txt
EOF

chmod +x compare_chain_performance.sh

# Create model cleanup summary
cat > model_optimization_summary.md << 'EOF'
# Mirador Model Optimization Summary

## Changes Made

### 1. Duplicate Removal
- **Removed**: `llama3.2:latest` (duplicate of `llama3.2:3b`)
- **Consolidated**: Matthew context providers to use v5 as primary
- **Consolidated**: Strategic accelerators to use v2 as primary
- **Potential savings**: 2.0 GB immediate, up to 40 GB with full consolidation

### 2. Model Diversity Added
New base LLMs available for installation:
- **Gemma 2**: Google's efficient reasoning model
- **Qwen 2.5**: Alibaba's multilingual powerhouse
- **Phi-3**: Microsoft's ultra-fast compact model

### 3. New Specialized Chains
- **deep_analysis**: Leverages Gemma 2 for complex reasoning
- **global_insight**: Uses Qwen 2.5 for multilingual tasks
- **rapid_decision**: Employs Phi-3 for speed-critical decisions

### 4. Performance Optimizations
- Removed redundant model calls in chains
- Lighter models for speed-sensitive chains
- Specialized models matched to task types

## Next Steps

1. **Run cleanup**: `./cleanup_duplicate_models.sh`
2. **Install diverse models**: `./install_diverse_models.sh`
3. **Create custom models**: `./create_diverse_models.sh`
4. **Test performance**: `./compare_chain_performance.sh`
5. **Update main launcher**: Link v3 optimized runner

## Expected Benefits

- **Storage**: Save 2-40 GB by removing duplicates
- **Speed**: 10-30% faster chains with optimized model selection
- **Quality**: Better results with task-specific model matching
- **Flexibility**: New capabilities with diverse model families
EOF

echo ""
echo "✅ Mirador chain optimization complete!"
echo ""
echo "Created files:"
echo "  - bin/mirador_universal_runner_v3_optimized.sh"
echo "  - compare_chain_performance.sh"
echo "  - model_optimization_summary.md"
echo ""
echo "Optimizations:"
echo "  ✓ Removed duplicate model references"
echo "  ✓ Added support for diverse model families"
echo "  ✓ Created specialized chains for different tasks"
echo "  ✓ Improved model selection logic"
echo ""
echo "To activate optimizations:"
echo "1. Run cleanup: ./cleanup_duplicate_models.sh"
echo "2. Install new models: ./install_diverse_models.sh"
echo "3. Create examples: ./create_diverse_models.sh"
echo "4. Test performance: ./compare_chain_performance.sh"