#!/bin/bash
echo "🌅 MIRADOR MORNING INTELLIGENCE BRIEF"
echo "==================================="
echo "$(date '+%A, %B %d, %Y at %I:%M %p')"
echo ""

# Quick financial check
echo "💰 FINANCIAL FOCUS:"
mirador-ez ask financial_planning_expert_v6 "What's my highest-priority financial action today?" | head -10

echo ""
echo "🎯 OPPORTUNITIES TODAY:"
mirador-ez ask enhanced_agent_enforcer_v2 "Based on current market conditions, what's the best opportunity to pursue today?" | head -8

echo ""
echo "📍 LOUISVILLE INSIGHTS:"
mirador-ez ask louisville_expert_v3 "Any local Louisville opportunities or events I should know about this week?" | head -6

echo ""
echo "✅ Brief complete! Have a productive day!"
