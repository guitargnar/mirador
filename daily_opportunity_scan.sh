#!/bin/bash
echo "=== DAILY MIRADOR OPPORTUNITY SCAN ==="
echo "Date: $(date)"
echo ""

# Quick financial opportunity check
echo "💰 Financial Opportunities:"
mirador-ez ask financial_planning_expert_v6 "What's today's best financial opportunity for Louisville healthcare professional?"

echo ""
echo "🎯 Career Advancement:"
mirador-ez ask matthew_context_provider "What's one career action I should take today?"

echo ""
echo "🏠 Local Louisville Opportunities:"
mirador-ez ask louisville_expert_v3 "What local opportunity should I explore this week?"

echo ""
echo "📊 System Recommendation:"
mirador-ez ask mirador_system_specialist "Based on current patterns, what's my highest-priority action today?"
