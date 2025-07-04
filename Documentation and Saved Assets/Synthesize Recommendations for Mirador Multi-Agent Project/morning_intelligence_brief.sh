#!/bin/bash

# Morning Intelligence Brief
# Automated daily intelligence and opportunity analysis

echo "🌅 MIRADOR MORNING INTELLIGENCE BRIEF"
echo "====================================="
echo "$(date '+%A, %B %d, %Y at %I:%M %p')"
echo ""

# Check if Mirador is available
if ! command -v mirador-ez &> /dev/null; then
    echo "❌ Mirador not found. Please install first."
    exit 1
fi

echo "📊 TODAY'S PRIORITY ANALYSIS:"
echo "----------------------------"
mirador-ez chain "Analyze today's highest-priority opportunities and actions for a healthcare compliance professional in Louisville. Consider current market conditions, professional development opportunities, and family priorities. Provide specific, actionable recommendations for today."

echo ""
echo "💰 FINANCIAL OPPORTUNITIES:"
echo "---------------------------"
mirador-ez chain "Identify specific financial opportunities available today or this week for someone in Louisville earning in the $75K-$95K range. Include investment opportunities, local market conditions, and actionable financial moves."

echo ""
echo "🎯 QUICK WINS:"
echo "--------------"
mirador-ez ask decision_simplifier_v2 "Based on current opportunities and priorities, what are the top 3 quick wins I can achieve today that will have the highest impact on my goals?"

echo ""
echo "🌟 DAILY FOCUS:"
echo "---------------"
mirador-ez ask matthew_context_provider_v2 "Given my values of family, creativity, and servant leadership, what should be my primary focus today to align with my long-term goals?"

echo ""
echo "✅ Morning brief complete! Have a productive day!"
echo "💾 Full analysis saved to outputs/latest/"

