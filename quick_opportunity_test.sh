#!/bin/bash
# Quick Mirador Opportunity Test
# Fast evaluation for initial screening

echo "=== QUICK OPPORTUNITY TEST ==="
echo "Opportunity: $1"
echo ""

# Quick 3-model chain for fast evaluation
mirador-ez chain "Evaluate opportunity: $1 - Is this viable in Louisville? What's the revenue potential? What are the main challenges?" creative_entrepreneur louisville_expert_v2 enhanced_agent_fast_v4

echo ""
echo "For detailed analysis, run:"
echo "~/ai_framework_git/opportunity_scorer.sh '$1'"
