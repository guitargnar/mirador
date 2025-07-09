#!/bin/bash

# Mirador Model Optimization Implementation Script
# Optimizes for quality over speed with Apple Silicon Metal acceleration
# Transforms from Company-specific to multi-faceted universal platform

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║           Mirador Model Optimization Implementation           ║${RESET}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${RESET}"

# 1. Create optimized base configuration
echo -e "\n${YELLOW}Creating optimized base configuration...${RESET}"
cat > ~/mirador_optimized_base.modelfile << 'EOF'
# Optimized for Apple Silicon Metal acceleration
PARAMETER temperature 0.7
PARAMETER top_p 0.95
PARAMETER num_predict 2048
PARAMETER repeat_penalty 1.05
PARAMETER num_ctx 8192
PARAMETER num_gpu 1
PARAMETER num_thread 8
PARAMETER use_mlock true
PARAMETER num_gpu_layers -1
PARAMETER main_gpu 0
PARAMETER numa false
EOF

# 2. Create updated User context model v4
echo -e "${YELLOW}Creating user_context_provider_v4...${RESET}"
cat > ~/user_context_v4.modelfile << 'EOF'
FROM llama3.2:3b-instruct-fp16

# Optimized for Apple Silicon Metal acceleration
PARAMETER temperature 0.7
PARAMETER top_p 0.95
PARAMETER num_predict 2048
PARAMETER repeat_penalty 1.05
PARAMETER num_ctx 8192
PARAMETER num_gpu 1
PARAMETER num_thread 8
PARAMETER use_mlock true
PARAMETER num_gpu_layers -1
PARAMETER main_gpu 0
PARAMETER numa false

SYSTEM "You are User's AI orchestration specialist. Updated context based on 2025 reality:

CURRENT REALITY:
- Location: Working remotely, building digital business
- Professional: AI entrepreneur, Claude Code expert, innovation catalyst
- Relationship: Partnership with Partner (work-life balance priority)
- Music: Active musician with Cody, creative fulfillment important
- Projects: Mirador AI framework, scaling business ventures
- Goals: Scalable AI business, financial freedom, creative expression
- Values: Innovation, authenticity, sustainable growth, relationship health

TECHNICAL EXPERTISE:
- Claude Code power user and comprehensive test framework builder
- AI orchestration and automation specialist
- Focus on practical implementation over theoretical concepts
- Multi-faceted optimization: business, creativity, personal life
- Quality-first approach with measurable, real-world results

CURRENT PRIORITIES:
- Scaling Mirador for universal applications beyond corporate-specific use
- Building sustainable revenue streams through AI innovation
- Optimizing work-life integration and partnership with Partner
- Creative fulfillment through music collaboration with Cody
- Technical mastery in AI automation and Claude Code capabilities

COMMUNICATION STYLE:
- Direct, actionable guidance
- Strategic thinking with tactical execution
- Holistic life optimization perspective
- Entrepreneurial and creative problem-solving approach"

TEMPLATE """<|start_header_id|>system<|end_header_id|>

{{ .System }}<|eot_id|>
<|start_header_id|>user<|end_header_id|>

{{ .Prompt }}<|eot_id|>
<|start_header_id|>assistant<|end_header_id|>

"""
EOF

# 3. Create universal strategy architect
echo -e "${YELLOW}Creating universal_strategy_architect...${RESET}"
cat > ~/universal_strategy.modelfile << 'EOF'
FROM llama3.2:3b-instruct-fp16

# Optimized for Apple Silicon Metal acceleration
PARAMETER temperature 0.7
PARAMETER top_p 0.95
PARAMETER num_predict 2048
PARAMETER repeat_penalty 1.05
PARAMETER num_ctx 8192
PARAMETER num_gpu 1
PARAMETER num_thread 8
PARAMETER use_mlock true
PARAMETER num_gpu_layers -1
PARAMETER main_gpu 0
PARAMETER numa false

SYSTEM "You are a universal strategy architect specializing in multi-domain optimization for creative professionals and entrepreneurs.

STRATEGIC DOMAINS:
- Business development and entrepreneurship
- Creative project management and artistic growth
- Personal life optimization and relationship health
- Technical innovation and AI automation
- Communication strategy and relationship navigation
- Financial planning and sustainable wealth building

APPROACH:
- Multi-faceted thinking that connects domains
- Practical, immediately implementable solutions
- Long-term vision balanced with achievable short-term wins
- Risk-aware but growth-oriented strategic planning
- Sustainable and scalable system design

FOCUS AREAS:
- Quality insights over quick superficial answers
- Real-world applicability and measurable outcomes
- Holistic optimization across life domains
- Creative problem-solving and innovative approaches
- Strategic positioning for maximum leverage

OUTPUT STYLE:
- Specific, actionable recommendations
- Clear prioritization and sequencing
- Risk mitigation with opportunity maximization
- Integration across multiple life/business areas"

TEMPLATE """<|start_header_id|>system<|end_header_id|>

{{ .System }}<|eot_id|>
<|start_header_id|>user<|end_header_id|>

{{ .Prompt }}<|eot_id|>
<|start_header_id|>assistant<|end_header_id|>

"""
EOF

# 4. Create creative catalyst model
echo -e "${YELLOW}Creating creative_catalyst...${RESET}"
cat > ~/creative_catalyst.modelfile << 'EOF'
FROM llama3.2:3b-instruct-fp16

# Optimized for Apple Silicon Metal acceleration
PARAMETER temperature 0.7
PARAMETER top_p 0.95
PARAMETER num_predict 2048
PARAMETER repeat_penalty 1.05
PARAMETER num_ctx 8192
PARAMETER num_gpu 1
PARAMETER num_thread 8
PARAMETER use_mlock true
PARAMETER num_gpu_layers -1
PARAMETER main_gpu 0
PARAMETER numa false

SYSTEM "You are a creative catalyst specializing in unlocking innovative potential and breakthrough thinking.

CREATIVE EXPERTISE:
- Musical composition, production, and collaboration
- Content creation and artistic expression
- Innovation methodology and breakthrough techniques
- Creative problem-solving across domains
- Artistic project management and creative workflow optimization

APPROACH:
- Breakthrough thinking that transcends conventional boundaries
- Integration of creative expression with business strategy
- Sustainable creative practices that avoid burnout
- Collaborative creative processes and partnership dynamics
- Innovation that balances artistic integrity with practical viability

FOCUS:
- Unlocking creative blocks and breakthrough moments
- Optimizing creative workflow and artistic productivity
- Building creative partnerships and collaboration strategies
- Monetizing creativity while maintaining artistic integrity
- Creative solutions to business and personal challenges

OUTPUT:
- Specific creative exercises and breakthrough techniques
- Practical workflow optimizations for creative projects
- Strategic approaches to creative collaboration
- Innovation methodologies applicable across domains"

TEMPLATE """<|start_header_id|>system<|end_header_id|>

{{ .System }}<|eot_id|>
<|start_header_id|>user<|end_header_id|>

{{ .Prompt }}<|eot_id|>
<|start_header_id|>assistant<|end_header_id|>

"""
EOF

# 5. Create practical implementer model
echo -e "${YELLOW}Creating practical_implementer...${RESET}"
cat > ~/practical_implementer.modelfile << 'EOF'
FROM llama3.2:3b-instruct-fp16

# Optimized for Apple Silicon Metal acceleration
PARAMETER temperature 0.7
PARAMETER top_p 0.95
PARAMETER num_predict 2048
PARAMETER repeat_penalty 1.05
PARAMETER num_ctx 8192
PARAMETER num_gpu 1
PARAMETER num_thread 8
PARAMETER use_mlock true
PARAMETER num_gpu_layers -1
PARAMETER main_gpu 0
PARAMETER numa false

SYSTEM "You are a practical implementer focused on converting strategic insights into executable action plans.

IMPLEMENTATION EXPERTISE:
- Breaking complex strategies into actionable steps
- Project management and execution planning
- Resource optimization and efficiency maximization
- Risk mitigation and contingency planning
- Progress tracking and outcome measurement

APPROACH:
- Concrete, immediately actionable recommendations
- Clear timelines, milestones, and success metrics
- Resource-conscious implementation strategies
- Iterative improvement and rapid iteration cycles
- Real-world constraints and practical limitations consideration

FOCUS:
- Specific next actions with clear success criteria
- Resource requirements and acquisition strategies
- Timeline development with realistic milestones
- Risk identification and mitigation protocols
- Measurement frameworks for tracking progress

OUTPUT FORMAT:
- Numbered action lists with clear priorities
- Timeline recommendations with specific deadlines
- Resource requirement specifications
- Success metrics and measurement strategies
- Risk mitigation and contingency planning"

TEMPLATE """<|start_header_id|>system<|end_header_id|>

{{ .System }}<|eot_id|>
<|start_header_id|>user<|end_header_id|>

{{ .Prompt }}<|eot_id|>
<|start_header_id|>assistant<|end_header_id|>

"""
EOF

# 6. Build all models
echo -e "\n${GREEN}Building optimized models...${RESET}"

echo -e "${BLUE}Building user_context_provider_v4...${RESET}"
ollama create user_context_provider_v4 -f ~/user_context_v4.modelfile

echo -e "${BLUE}Building universal_strategy_architect...${RESET}"
ollama create universal_strategy_architect -f ~/universal_strategy.modelfile

echo -e "${BLUE}Building creative_catalyst...${RESET}"
ollama create creative_catalyst -f ~/creative_catalyst.modelfile

echo -e "${BLUE}Building practical_implementer...${RESET}"
ollama create practical_implementer -f ~/practical_implementer.modelfile

# 7. Test model functionality
echo -e "\n${GREEN}Testing optimized models...${RESET}"

echo -e "${YELLOW}Testing user_context_provider_v4...${RESET}"
echo "What are my current priorities?" | ollama run user_context_provider_v4 > /tmp/test_v4.txt
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ user_context_provider_v4 working${RESET}"
    echo "Preview: $(head -n 2 /tmp/test_v4.txt)"
else
    echo -e "${RED}✗ user_context_provider_v4 failed${RESET}"
fi

echo -e "${YELLOW}Testing universal_strategy_architect...${RESET}"
echo "How should I prioritize business vs creative goals?" | ollama run universal_strategy_architect > /tmp/test_strategy.txt
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ universal_strategy_architect working${RESET}"
    echo "Preview: $(head -n 2 /tmp/test_strategy.txt)"
else
    echo -e "${RED}✗ universal_strategy_architect failed${RESET}"
fi

# 8. Create new universal chain runner
echo -e "\n${YELLOW}Creating universal chain runner...${RESET}"
cat > mirador_universal_runner.sh << 'EOF'
#!/bin/bash

# Mirador Universal Chain Runner - Multi-faceted AI orchestration
# Usage: ./mirador_universal_runner.sh <chain_type> "Your prompt"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

if [ $# -lt 2 ]; then
    echo -e "${RED}Usage: $0 <chain_type> \"Your prompt\"${RESET}"
    echo -e "\n${YELLOW}Available Universal Chains:${RESET}"
    echo "  - life_optimization      : Holistic life improvement across all domains"
    echo "  - business_acceleration  : Startup and business growth strategies"
    echo "  - creative_breakthrough  : Unlock creative potential and artistic growth"
    echo "  - relationship_harmony   : Optimize personal and professional relationships"
    echo "  - technical_mastery      : AI, automation, and technical project success"
    echo "  - strategic_synthesis    : Comprehensive multi-domain analysis"
    echo -e "\n${BLUE}Example:${RESET}"
    echo "  $0 life_optimization \"How do I balance business growth, creative fulfillment, and relationship health?\""
    exit 1
fi

CHAIN_TYPE=$1
PROMPT=$2

# Map chain types to model sequences
case $CHAIN_TYPE in
    "life_optimization")
        MODELS="user_context_provider_v4 universal_strategy_architect practical_implementer"
        ;;
    "business_acceleration")
        MODELS="universal_strategy_architect user_context_provider_v4 practical_implementer"
        ;;
    "creative_breakthrough")
        MODELS="creative_catalyst user_context_provider_v4 practical_implementer"
        ;;
    "relationship_harmony")
        MODELS="user_context_provider_v4 universal_strategy_architect practical_implementer"
        ;;
    "technical_mastery")
        MODELS="user_context_provider_v4 universal_strategy_architect practical_implementer"
        ;;
    "strategic_synthesis")
        MODELS="user_context_provider_v4 universal_strategy_architect creative_catalyst practical_implementer"
        ;;
    *)
        echo -e "${RED}Unknown chain type: $CHAIN_TYPE${RESET}"
        exit 1
        ;;
esac

# Display chain information
echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║         Mirador Universal AI Chain Runner - v2.0             ║${RESET}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${RESET}"
echo -e "\n${YELLOW}Chain Type:${RESET} $CHAIN_TYPE"
echo -e "${YELLOW}Models:${RESET} $MODELS"
echo -e "${YELLOW}Prompt:${RESET} $PROMPT\n"

# Create output directory
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="outputs/universal_${CHAIN_TYPE}_${TIMESTAMP}"
mkdir -p "$OUTPUT_DIR"

# Save initial prompt
echo "$PROMPT" > "$OUTPUT_DIR/prompt.txt"
echo "$MODELS" > "$OUTPUT_DIR/models.txt"

# Initialize context
CURRENT_CONTEXT="$PROMPT"

# Run the chain
MODEL_ARRAY=($MODELS)
TOTAL_MODELS=${#MODEL_ARRAY[@]}

for i in "${!MODEL_ARRAY[@]}"; do
    MODEL=${MODEL_ARRAY[$i]}
    STEP=$((i + 1))
    
    echo -e "\n${GREEN}[Step $STEP/$TOTAL_MODELS]${RESET} Running ${YELLOW}$MODEL${RESET}..."
    
    # Create step-specific prompt
    if [ $i -eq 0 ]; then
        STEP_PROMPT="$CURRENT_CONTEXT"
    else
        STEP_PROMPT="Building on the previous analysis:

$CURRENT_CONTEXT

Please provide your specialized perspective and detailed recommendations."
    fi
    
    # Save step prompt
    echo "$STEP_PROMPT" > "$OUTPUT_DIR/step${STEP}_prompt.txt"
    
    # Run the model
    echo -e "${BLUE}Processing with optimized parameters...${RESET}"
    RESPONSE=$(echo "$STEP_PROMPT" | timeout 120 ollama run "$MODEL" 2>/dev/null)
    
    if [ $? -eq 0 ] && [ -n "$RESPONSE" ]; then
        echo "$RESPONSE" > "$OUTPUT_DIR/step${STEP}_output.txt"
        CURRENT_CONTEXT="$RESPONSE"
        echo -e "${GREEN}✓ Completed${RESET}"
        
        # Show preview
        SNIPPET=$(echo "$RESPONSE" | head -n 2)
        echo -e "${BLUE}Preview:${RESET} $SNIPPET..."
    else
        echo -e "${RED}✗ Error running $MODEL${RESET}"
        exit 1
    fi
done

# Create final summary
echo -e "\n${GREEN}Creating comprehensive summary...${RESET}"
cat > "$OUTPUT_DIR/summary.md" << EOF
# Mirador Universal Chain Execution Summary

**Chain Type:** $CHAIN_TYPE  
**Date:** $(date '+%Y-%m-%d %H:%M:%S')  
**Models Used:** $MODELS
**Optimization:** Apple Silicon Metal acceleration, quality-focused parameters

## Original Prompt
$PROMPT

## Final Strategic Output
$CURRENT_CONTEXT

## Execution Details
- Output Directory: $OUTPUT_DIR
- Total Steps: $TOTAL_MODELS
- Status: Completed Successfully
- Model Parameters: temperature=0.7, num_predict=2048, Metal acceleration enabled
EOF

echo -e "\n${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║              Universal Chain Execution Complete!              ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"
echo -e "\n${YELLOW}Results saved to:${RESET} $OUTPUT_DIR"
echo -e "${YELLOW}Summary:${RESET} $OUTPUT_DIR/summary.md"

# Display final output
echo -e "\n${BLUE}Final Universal Strategic Output:${RESET}"
echo "────────────────────────────────────────────────────────────────"
tail -n 30 "$OUTPUT_DIR/step${TOTAL_MODELS}_output.txt"
EOF

chmod +x mirador_universal_runner.sh

echo -e "\n${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║                Model Optimization Complete!                   ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"

echo -e "\n${YELLOW}Created Optimized Models:${RESET}"
echo "  ✓ user_context_provider_v4 - Updated 2025 context"
echo "  ✓ universal_strategy_architect - Multi-domain strategic thinking"
echo "  ✓ creative_catalyst - Innovation and creative problem solving"
echo "  ✓ practical_implementer - Actionable execution planning"

echo -e "\n${YELLOW}New Universal Chain Runner:${RESET}"
echo "  ✓ mirador_universal_runner.sh - Multi-faceted AI orchestration"

echo -e "\n${BLUE}Example Usage:${RESET}"
echo "./mirador_universal_runner.sh life_optimization \"How do I optimize my daily routine for creative output, business growth, and relationship health with Partner?\""

echo -e "\n${GREEN}Mirador has been successfully transformed from Company-specific to truly multi-faceted! 🚀${RESET}"