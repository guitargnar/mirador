

echo "============================================="
echo "MIRADOR ADVANCED TEST SCENARIOS"
echo "============================================="
echo ""


run_scenario() {
    local category="$1"
    local description="$2"
    local command="$3"
    
    echo "🔍 $category: $description"
    echo "Executing..."
    eval "$command"
    echo "✅ Complete"
    echo "---"
    sleep 3
}


echo "🌐 COMPLEX MULTI-DOMAIN SCENARIOS"
echo "================================="

run_scenario "INTEGRATED" "Career + Real Estate + Finance Integration" \
"mirador-ez chain 'I make 75k and want to buy rental property while changing careers to tech. Create integrated plan covering career transition timeline, financing strategy, and property selection in Louisville' financial_planning_expert_v5 louisville_expert_v2 enhanced_agent_fast_v6"

run_scenario "INTEGRATED" "Family + Business + Education Planning" \
"mirador-ez chain 'Planning to start a family business while homeschooling 2 children. Need integrated strategy for business setup, education planning, and family financial optimization' financial_planning_expert_v5 louisville_expert_v2 enhanced_agent_fast_v6"


echo ""
echo "🚨 CRISIS & OPPORTUNITY SCENARIOS"
echo "================================="

run_scenario "CRISIS" "Job Loss Recovery Strategy" \
"mirador-ez chain 'Just lost my 90k job in Louisville. Create 90-day action plan covering unemployment benefits, expense reduction, job search strategy, and potential pivot opportunities' financial_planning_expert_v5 louisville_expert_v2 enhanced_agent_fast_v6"

run_scenario "OPPORTUNITY" "Inheritance Investment Strategy" \
"mirador-ez chain 'Inherited 250k unexpectedly. Create comprehensive investment and life optimization strategy considering taxes, lifestyle changes, and long-term wealth building' financial_planning_expert_v5 enhanced_agent_fast_v6"


echo ""
echo "📍 LOCATION-SPECIFIC DEEP DIVES"
echo "================================"

run_scenario "LOUISVILLE" "Louisville Neighborhood Arbitrage" \
"mirador-ez chain 'Analyze opportunities for neighborhood arbitrage in Louisville - buying in emerging areas before gentrification. Include specific neighborhoods, timing, and ROI projections' louisville_expert_v2 financial_planning_expert_v5 enhanced_agent_fast_v6"

run_scenario "LOUISVILLE" "Local Business Ecosystem Analysis" \
"mirador-ez chain 'Map the Louisville business ecosystem for tech startups including funding sources, accelerators, networking groups, and growth opportunities' louisville_expert_v2 enhanced_agent_fast_v6"


echo ""
echo "💎 UNCONVENTIONAL WEALTH STRATEGIES"
echo "==================================="

run_scenario "ALTERNATIVE" "Alternative Income Streams Stack" \
"mirador-ez chain 'Design a stack of 7 alternative income streams that could replace a traditional 75k salary within 2 years' financial_planning_expert_v5 enhanced_agent_fast_v6"

run_scenario "ALTERNATIVE" "Micro-Business Portfolio Strategy" \
"mirador-ez chain 'Create strategy for building portfolio of 5 micro-businesses each generating 2-3k monthly with minimal time investment' financial_planning_expert_v5 enhanced_agent_fast_v6"


echo ""
echo "🔄 LIFE TRANSITION SCENARIOS"
echo "============================"

run_scenario "TRANSITION" "Single to Family Financial Pivot" \
"mirador-ez chain 'Getting married next year, partner makes 65k, we want kids in 2 years. Create comprehensive financial and life planning strategy' financial_planning_expert_v5 enhanced_agent_fast_v6"

run_scenario "TRANSITION" "Corporate to Entrepreneur Transition" \
"mirador-ez chain 'Want to leave corporate job in 18 months to start consulting business. Create detailed transition plan including financial runway, client acquisition, and risk mitigation' financial_planning_expert_v5 enhanced_agent_fast_v6"

echo ""
echo "============================================="
echo "ADVANCED SCENARIOS COMPLETE"
echo "============================================="
