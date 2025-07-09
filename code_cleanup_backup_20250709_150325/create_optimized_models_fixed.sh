#!/bin/bash

# Fixed Mirador Model Optimization - Using compatible parameters
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║         Mirador Model Optimization - Fixed Implementation     ║${RESET}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${RESET}"

# 1. Create updated Matthew context model v4
echo -e "\n${YELLOW}Creating matthew_context_provider_v4 (fixed)...${RESET}"
cat > ~/matthew_context_v4_fixed.modelfile << 'EOF'
FROM llama3.2:3b-instruct-fp16

# Apple Silicon optimized parameters
PARAMETER temperature 0.7
PARAMETER top_p 0.95
PARAMETER num_predict 2048
PARAMETER repeat_penalty 1.05
PARAMETER num_ctx 8192
PARAMETER num_thread 8

SYSTEM "You are Matthew Scott's AI orchestration specialist. Updated context based on 2025 reality:

CURRENT REALITY:
- Location: Working remotely, building digital business
- Professional: AI entrepreneur, Claude Code expert, innovation catalyst
- Relationship: Partnership with Katie (work-life balance priority)
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
- Optimizing work-life integration and partnership with Katie
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

# 2. Create universal strategy architect
echo -e "${YELLOW}Creating universal_strategy_architect (fixed)...${RESET}"
cat > ~/universal_strategy_fixed.modelfile << 'EOF'
FROM llama3.2:3b-instruct-fp16

# Apple Silicon optimized parameters
PARAMETER temperature 0.7
PARAMETER top_p 0.95
PARAMETER num_predict 2048
PARAMETER repeat_penalty 1.05
PARAMETER num_ctx 8192
PARAMETER num_thread 8

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

# 3. Create creative catalyst model
echo -e "${YELLOW}Creating creative_catalyst (fixed)...${RESET}"
cat > ~/creative_catalyst_fixed.modelfile << 'EOF'
FROM llama3.2:3b-instruct-fp16

# Apple Silicon optimized parameters
PARAMETER temperature 0.7
PARAMETER top_p 0.95
PARAMETER num_predict 2048
PARAMETER repeat_penalty 1.05
PARAMETER num_ctx 8192
PARAMETER num_thread 8

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

# 4. Create practical implementer model
echo -e "${YELLOW}Creating practical_implementer (fixed)...${RESET}"
cat > ~/practical_implementer_fixed.modelfile << 'EOF'
FROM llama3.2:3b-instruct-fp16

# Apple Silicon optimized parameters
PARAMETER temperature 0.7
PARAMETER top_p 0.95
PARAMETER num_predict 2048
PARAMETER repeat_penalty 1.05
PARAMETER num_ctx 8192
PARAMETER num_thread 8

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

# 5. Build all models
echo -e "\n${GREEN}Building optimized models with fixed parameters...${RESET}"

echo -e "${BLUE}Building matthew_context_provider_v4...${RESET}"
ollama create matthew_context_provider_v4 -f ~/matthew_context_v4_fixed.modelfile

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ matthew_context_provider_v4 created successfully${RESET}"
else
    echo -e "${RED}✗ Failed to create matthew_context_provider_v4${RESET}"
fi

echo -e "${BLUE}Building universal_strategy_architect...${RESET}"
ollama create universal_strategy_architect -f ~/universal_strategy_fixed.modelfile

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ universal_strategy_architect created successfully${RESET}"
else
    echo -e "${RED}✗ Failed to create universal_strategy_architect${RESET}"
fi

echo -e "${BLUE}Building creative_catalyst...${RESET}"
ollama create creative_catalyst -f ~/creative_catalyst_fixed.modelfile

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ creative_catalyst created successfully${RESET}"
else
    echo -e "${RED}✗ Failed to create creative_catalyst${RESET}"
fi

echo -e "${BLUE}Building practical_implementer...${RESET}"
ollama create practical_implementer -f ~/practical_implementer_fixed.modelfile

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ practical_implementer created successfully${RESET}"
else
    echo -e "${RED}✗ Failed to create practical_implementer${RESET}"
fi

# 6. Test new models
echo -e "\n${GREEN}Testing optimized models...${RESET}"

echo -e "${YELLOW}Testing matthew_context_provider_v4...${RESET}"
TEST_RESPONSE=$(echo "What are my current priorities?" | timeout 30 ollama run matthew_context_provider_v4 2>/dev/null)
if [ $? -eq 0 ] && [ -n "$TEST_RESPONSE" ]; then
    echo -e "${GREEN}✓ matthew_context_provider_v4 working${RESET}"
    echo "Preview: $(echo "$TEST_RESPONSE" | head -n 1)"
else
    echo -e "${RED}✗ matthew_context_provider_v4 test failed${RESET}"
fi

echo -e "${YELLOW}Testing universal_strategy_architect...${RESET}"
TEST_RESPONSE=$(echo "How should I prioritize business vs creative goals?" | timeout 30 ollama run universal_strategy_architect 2>/dev/null)
if [ $? -eq 0 ] && [ -n "$TEST_RESPONSE" ]; then
    echo -e "${GREEN}✓ universal_strategy_architect working${RESET}"
    echo "Preview: $(echo "$TEST_RESPONSE" | head -n 1)"
else
    echo -e "${RED}✗ universal_strategy_architect test failed${RESET}"
fi

echo -e "\n${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║            Fixed Model Optimization Complete!                 ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"

echo -e "\n${YELLOW}Created Fixed Optimized Models:${RESET}"
echo "  ✓ matthew_context_provider_v4 - Updated 2025 context, quality parameters"
echo "  ✓ universal_strategy_architect - Multi-domain strategic thinking"
echo "  ✓ creative_catalyst - Innovation and creative problem solving"
echo "  ✓ practical_implementer - Actionable execution planning"

echo -e "\n${BLUE}All models now use Apple Silicon optimized parameters:${RESET}"
echo "  - temperature: 0.7 (increased creativity)"
echo "  - num_predict: 2048 (longer responses)"
echo "  - num_ctx: 8192 (larger context window)"
echo "  - num_thread: 8 (Apple Silicon optimization)"

echo -e "\n${GREEN}Ready to use universal chain runner with new models! 🚀${RESET}"