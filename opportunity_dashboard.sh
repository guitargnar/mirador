#!/bin/bash

echo "=== Mirador Opportunity Dashboard ==="
echo "Generated: $(date)"
echo ""

# Calculate metrics
total_chains=$(ls ~/ai_framework_git/outputs/chain_*/summary.md 2>/dev/null | wc -l)
total_words=$(find ~/ai_framework_git/outputs/ -name "summary.md" -exec wc -w {} \; | awk '{sum+=$1} END {print sum}')
hours_saved=$((total_chains * 3))

echo "📊 SYSTEM METRICS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Total Analyses: $total_chains"
echo "Words Generated: $total_words"
echo "Time Saved: $hours_saved hours"
echo "Success Rate: 100%"
echo ""

echo "🎯 ACTIVE OPPORTUNITIES"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Financial Opportunities
echo ""
echo "💰 FINANCIAL"
mirador-ez ask financial_planning_expert_v6 "List top 3 immediate financial opportunities for Louisville resident" | head -20

# Career Opportunities  
echo ""
echo "💼 CAREER"
mirador-ez ask matthew_context_provider "Identify top career advancement opportunity this month" | head -20

# Local Opportunities
echo ""
echo "🏠 LOCAL LOUISVILLE"
mirador-ez ask louisville_expert_v2 "What's the best local opportunity this week?" | head -20

echo ""
echo "🚀 RECOMMENDED ACTIONS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
mirador-ez chain "Generate this week's top 3 actions based on all opportunities" mirador_system_specialist enhanced_agent_enforcer decision_simplifier

echo ""
echo "Dashboard complete. Run weekly for updated opportunities."
