#!/bin/bash
echo "🌆 MIRADOR EVENING OPTIMIZATION REVIEW"
echo "===================================="
echo "$(date '+%A, %B %d, %Y at %I:%M %p')"
echo ""

echo "📊 TODAY'S ANALYSIS:"
mirador-ez chain "Review today's decisions and suggest optimizations for tomorrow" matthew_context_provider_v2 enhanced_agent_enforcer_v2 decision_simplifier_v2

echo ""
echo "🎯 TOMORROW'S PREP:"
mirador-ez ask decision_simplifier_v2 "What are the top 3 priorities for tomorrow based on this week's goals?"

echo ""
echo "✅ Evening review complete! Rest well!"
