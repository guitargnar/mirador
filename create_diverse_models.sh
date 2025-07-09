#!/bin/bash
# Create diverse custom models using different base LLMs

echo "🎨 Creating Diverse Custom Models for Mirador"
echo "==========================================="
echo ""
echo "This script creates example models using different base LLMs"
echo "to demonstrate the capabilities of each model family."
echo ""

# Create models directory if it doesn't exist
mkdir -p models/diverse

# Function to create a model
create_model() {
    local name=$1
    local modelfile=$2
    local description=$3
    
    echo "Creating $name - $description..."
    
    # Save modelfile
    echo "$modelfile" > "models/diverse/${name}.modelfile"
    
    # Create the model
    if ollama create "$name" -f "models/diverse/${name}.modelfile"; then
        echo "✅ Successfully created $name"
    else
        echo "❌ Failed to create $name"
    fi
    echo ""
}

# 1. Gemma-based Analytical Model
cat > models/diverse/analytical_expert_gemma.modelfile << 'EOF'
FROM gemma2:9b

PARAMETER temperature 0.5
PARAMETER top_p 0.9
PARAMETER num_ctx 8192

SYSTEM """You are an Analytical Expert powered by Gemma 2, specializing in deep analysis and reasoning.

Core Strengths:
- Complex problem decomposition
- Multi-step reasoning chains
- Data analysis and interpretation
- Pattern recognition
- Logical inference

Approach:
1. Break down complex problems systematically
2. Consider multiple perspectives
3. Use structured thinking frameworks
4. Provide evidence-based conclusions
5. Highlight assumptions and limitations

Your responses should be thorough, well-reasoned, and clearly structured."""
EOF

create_model "analytical_expert_gemma:latest" "$(cat models/diverse/analytical_expert_gemma.modelfile)" "Gemma 2-based analytical reasoning"

# 2. Qwen-based Multilingual Assistant
cat > models/diverse/multilingual_assistant_qwen.modelfile << 'EOF'
FROM qwen2.5:7b

PARAMETER temperature 0.7
PARAMETER top_p 0.95
PARAMETER num_ctx 8192

SYSTEM """You are a Multilingual Assistant powered by Qwen 2.5, capable of understanding and responding in multiple languages.

Core Capabilities:
- Fluent in English, Chinese, Spanish, French, German, Japanese, and more
- Cultural context awareness
- Translation and localization
- Cross-cultural communication
- International business etiquette

Special Features:
- Code-switching between languages naturally
- Explain concepts using culturally relevant examples
- Maintain consistent quality across languages
- Respect linguistic nuances and idioms

Always respond in the language used by the user unless asked to translate."""
EOF

create_model "multilingual_assistant_qwen:latest" "$(cat models/diverse/multilingual_assistant_qwen.modelfile)" "Qwen 2.5-based multilingual assistant"

# 3. Phi-based Speed Optimizer
cat > models/diverse/speed_optimizer_phi.modelfile << 'EOF'
FROM phi3:mini

PARAMETER temperature 0.6
PARAMETER top_p 0.9
PARAMETER num_ctx 4096
PARAMETER num_predict 512

SYSTEM """You are a Speed Optimizer powered by Phi-3, designed for ultra-fast, concise responses.

Optimization Principles:
- Maximum information density
- Minimal response time
- Clear, actionable outputs
- No unnecessary elaboration
- Direct problem-solving

Response Format:
- Start with the answer/solution
- Use bullet points for clarity
- Include only essential details
- Provide next steps if applicable

Perfect for: Quick decisions, rapid prototyping, time-sensitive queries."""
EOF

create_model "speed_optimizer_phi:latest" "$(cat models/diverse/speed_optimizer_phi.modelfile)" "Phi-3-based fast response model"

# 4. Create a comparison model using Llama for baseline
cat > models/diverse/baseline_llama_compact.modelfile << 'EOF'
FROM llama3.2:3b

PARAMETER temperature 0.7
PARAMETER top_p 0.9
PARAMETER num_ctx 4096

SYSTEM """You are a baseline assistant for comparison purposes, using Llama 3.2.

Provide balanced, helpful responses for general queries. This model serves as a comparison point for evaluating other specialized models.

Focus on being helpful, harmless, and honest."""
EOF

create_model "baseline_llama_compact:latest" "$(cat models/diverse/baseline_llama_compact.modelfile)" "Baseline Llama 3.2 for comparison"

# 5. Create hybrid chain example configurations
echo "Creating example chain configurations..."

cat > models/diverse/hybrid_chain_examples.json << 'EOF'
{
  "hybrid_chains": {
    "deep_analysis_chain": {
      "description": "Combines Gemma's reasoning with Llama's implementation",
      "models": [
        "matthew_context_provider_v5_complete:latest",
        "analytical_expert_gemma:latest",
        "practical_implementer:latest"
      ],
      "use_cases": [
        "Complex problem solving",
        "Strategic planning",
        "Technical architecture decisions"
      ]
    },
    "global_communication_chain": {
      "description": "Leverages Qwen's multilingual capabilities",
      "models": [
        "matthew_context_provider_v5_complete:latest",
        "multilingual_assistant_qwen:latest",
        "engagement_optimizer:latest"
      ],
      "use_cases": [
        "International business communication",
        "Cross-cultural content creation",
        "Global market analysis"
      ]
    },
    "rapid_decision_chain": {
      "description": "Uses Phi-3 for speed with Llama for depth",
      "models": [
        "speed_optimizer_phi:latest",
        "matthew_context_provider_v3:latest",
        "action_crystallizer:latest"
      ],
      "use_cases": [
        "Time-sensitive decisions",
        "Quick feasibility checks",
        "Rapid prototyping"
      ]
    },
    "comprehensive_analysis_chain": {
      "description": "Combines all model families for maximum insight",
      "models": [
        "matthew_context_provider_v5_complete:latest",
        "analytical_expert_gemma:latest",
        "multilingual_assistant_qwen:latest",
        "speed_optimizer_phi:latest",
        "universal_strategy_architect:latest"
      ],
      "use_cases": [
        "Major strategic decisions",
        "Comprehensive market research",
        "Multi-faceted problem analysis"
      ]
    }
  }
}
EOF

# Create example test script
cat > models/diverse/test_diverse_models.sh << 'EOF'
#!/bin/bash
# Test diverse models with the same prompt

PROMPT="How can I improve my productivity while maintaining work-life balance?"

echo "🧪 Testing Diverse Models"
echo "========================"
echo "Prompt: $PROMPT"
echo ""

# Test each model
for model in analytical_expert_gemma:latest multilingual_assistant_qwen:latest speed_optimizer_phi:latest baseline_llama_compact:latest; do
    echo "Testing $model..."
    echo "---"
    response=$(echo "$PROMPT" | ollama run "$model" --verbose 2>&1)
    
    # Extract timing info
    timing=$(echo "$response" | grep -E "eval count|duration" | tail -2)
    
    echo "$response" | head -20
    echo "..."
    echo "Timing: $timing"
    echo ""
done
EOF

chmod +x models/diverse/test_diverse_models.sh

# Summary
echo ""
echo "✅ Diverse model creation complete!"
echo ""
echo "Created models:"
echo "  - analytical_expert_gemma:latest (Gemma 2-based)"
echo "  - multilingual_assistant_qwen:latest (Qwen 2.5-based)"
echo "  - speed_optimizer_phi:latest (Phi-3-based)"
echo "  - baseline_llama_compact:latest (Llama 3.2-based)"
echo ""
echo "Configuration files:"
echo "  - models/diverse/hybrid_chain_examples.json"
echo "  - models/diverse/test_diverse_models.sh"
echo ""
echo "Next steps:"
echo "1. Test the models: ./models/diverse/test_diverse_models.sh"
echo "2. Update Mirador chains to use diverse models"
echo "3. Benchmark performance differences"