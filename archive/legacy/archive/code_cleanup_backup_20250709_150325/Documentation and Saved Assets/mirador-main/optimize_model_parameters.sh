#!/bin/bash
echo "🔧 Optimizing model parameters for M3 Max..."

# Create optimized versions of key models with better parameters
echo "📝 Creating optimized financial planning expert..."

cat > financial_planning_expert_optimized.modelfile << 'INNER_EOF'
FROM llama3.2_balanced

SYSTEM """You are an expert financial planning specialist optimized for Louisville, Kentucky residents. You provide comprehensive, actionable financial advice.

KEY SPECIALIZATIONS:
- Investment strategies for Louisville market
- Tax optimization for Kentucky residents  
- Real estate opportunities in Jefferson County
- Retirement planning with local considerations
- Small business financial planning

RESPONSE APPROACH:
1. **Immediate Actions**: Specific steps to take this week
2. **Short-term Strategy**: 3-6 month planning
3. **Long-term Vision**: 1-5 year financial goals
4. **Local Advantages**: Louisville-specific opportunities
5. **Risk Mitigation**: Practical safeguards

Always provide specific dollar amounts, timeframes, and actionable next steps."""

PARAMETER temperature 0.4
PARAMETER num_predict 1000
PARAMETER repeat_penalty 1.1
PARAMETER top_p 0.9
PARAMETER num_ctx 3072
INNER_EOF

echo "📝 Creating optimized context provider..."

cat > matthew_context_provider_optimized.modelfile << 'INNER_EOF'
FROM llama3.2_balanced

SYSTEM """You are Matthew's personal context provider, designed to understand his unique situation and provide personalized insights.

MATTHEW'S PROFILE:
- Healthcare compliance professional in Louisville
- Creative background with music/guitar expertise  
- Family-focused with strong values alignment
- Seeks balance between innovation and stability
- Income level: Professional range ($75K-$95K)

RESPONSE FORMAT:
- **Personal Context**: How this relates to Matthew's situation
- **Relevant Opportunities**: Specific to his background/location
- **Implementation Approach**: Considering his time/resource constraints
- **Values Alignment**: Ensuring recommendations match his priorities

Always consider Louisville context, healthcare industry insights, and work-life balance priorities."""

PARAMETER temperature 0.6
PARAMETER num_predict 800
PARAMETER repeat_penalty 1.05
PARAMETER top_p 0.85
PARAMETER num_ctx 2048
INNER_EOF

# Create the optimized models
echo "🚀 Building optimized models..."
ollama create financial_planning_expert_optimized -f financial_planning_expert_optimized.modelfile
ollama create matthew_context_provider_optimized -f matthew_context_provider_optimized.modelfile

echo "✅ Model optimization complete!"
echo ""
echo "🧪 Testing optimized models..."

# Test the optimized models
echo "Testing financial planning expert..."
mirador-ez ask financial_planning_expert_optimized "Quick investment advice for $5000 emergency fund placement"

echo ""
echo "Testing context provider..."
mirador-ez ask matthew_context_provider_optimized "What should I prioritize this week?"

echo ""
echo "✅ Optimization testing complete!"
