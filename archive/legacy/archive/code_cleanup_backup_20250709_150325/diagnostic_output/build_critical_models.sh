#!/bin/bash
# Build Critical Mirador Models
# Generated automatically based on diagnostic results

set -e

echo "🔨 Building critical Mirador models..."

echo "Building financial_planning_expert_v6..."
if [ -f "optimized_configs/modelfiles/financial_planning_expert_v6.modelfile" ]; then
    ollama create financial_planning_expert_v6 -f "optimized_configs/modelfiles/financial_planning_expert_v6.modelfile"
    if [ $? -eq 0 ]; then
        echo "✅ Successfully built financial_planning_expert_v6"
    else
        echo "❌ Failed to build financial_planning_expert_v6"
        exit 1
    fi
else
    echo "⚠️  Modelfile not found: optimized_configs/modelfiles/financial_planning_expert_v6.modelfile"
fi

echo "Building decision_simplifier_v2..."
if [ -f "optimized_configs/modelfiles/decision_simplifier_v2.modelfile" ]; then
    ollama create decision_simplifier_v2 -f "optimized_configs/modelfiles/decision_simplifier_v2.modelfile"
    if [ $? -eq 0 ]; then
        echo "✅ Successfully built decision_simplifier_v2"
    else
        echo "❌ Failed to build decision_simplifier_v2"
        exit 1
    fi
else
    echo "⚠️  Modelfile not found: optimized_configs/modelfiles/decision_simplifier_v2.modelfile"
fi

echo "Building enhanced_agent_fast_v6..."
if [ -f "optimized_configs/modelfiles/enhanced_agent_fast_v6.modelfile" ]; then
    ollama create enhanced_agent_fast_v6 -f "optimized_configs/modelfiles/enhanced_agent_fast_v6.modelfile"
    if [ $? -eq 0 ]; then
        echo "✅ Successfully built enhanced_agent_fast_v6"
    else
        echo "❌ Failed to build enhanced_agent_fast_v6"
        exit 1
    fi
else
    echo "⚠️  Modelfile not found: optimized_configs/modelfiles/enhanced_agent_fast_v6.modelfile"
fi

echo "🎉 Critical model building complete!"
echo "Run the validation script to test the models."
