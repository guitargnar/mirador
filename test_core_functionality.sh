#!/bin/bash
# Quick core functionality tests

echo "🧪 Mirador Core Functionality Tests"
echo "=================================="
echo ""

# Test 1: Model count
echo "✓ Models installed: $(ollama list | wc -l)"

# Test 2: Model diversity
TOTAL=$(ollama list | wc -l)
LLAMA=$(ollama list | grep -c "llama" || true)
echo "✓ Model diversity: $((($TOTAL - $LLAMA) * 100 / $TOTAL))% non-Llama"

# Test 3: Key scripts exist
echo ""
echo "📁 Core Scripts:"
for script in "mirador-smart-v2" "bin/mirador_auto_router.sh" "bin/mirador_rag_chain.sh" "bin/mirador_hybrid_chains.sh"; do
    if [ -f "$script" ]; then
        echo "  ✓ $script exists"
    else
        echo "  ✗ $script missing"
    fi
done

# Test 4: Output structure
echo ""
echo "📊 Recent outputs:"
ls -la outputs/ 2>/dev/null | tail -5

echo ""
echo "✅ Tests complete!"