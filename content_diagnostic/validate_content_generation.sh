#!/bin/bash
# Validate Content Generation After Repairs

echo "🧪 Validating content generation..."

echo "Testing matthew_context_provider..."
if timeout 30 ollama run matthew_context_provider "Provide brief context about Matthew's current situation and goals." | wc -w | awk '{if($1 >= 20) print "✅ matthew_context_provider working (" $1 " words)"; else print "❌ matthew_context_provider failed (" $1 " words)"}'; then
    true
else
    echo "❌ matthew_context_provider failed to respond"
fi

echo "Testing matthew_context_provider_v2..."
if timeout 30 ollama run matthew_context_provider_v2 "Provide brief context about Matthew's current situation and goals." | wc -w | awk '{if($1 >= 20) print "✅ matthew_context_provider_v2 working (" $1 " words)"; else print "❌ matthew_context_provider_v2 failed (" $1 " words)"}'; then
    true
else
    echo "❌ matthew_context_provider_v2 failed to respond"
fi

echo "Testing financial_planning_expert_v6..."
if timeout 30 ollama run financial_planning_expert_v6 "What are the key components of a basic monthly budget?" | wc -w | awk '{if($1 >= 30) print "✅ financial_planning_expert_v6 working (" $1 " words)"; else print "❌ financial_planning_expert_v6 failed (" $1 " words)"}'; then
    true
else
    echo "❌ financial_planning_expert_v6 failed to respond"
fi

echo "Testing enhanced_agent_enforcer..."
if timeout 30 ollama run enhanced_agent_enforcer "Review this statement for accuracy: Louisville is the capital of Kentucky." | wc -w | awk '{if($1 >= 15) print "✅ enhanced_agent_enforcer working (" $1 " words)"; else print "❌ enhanced_agent_enforcer failed (" $1 " words)"}'; then
    true
else
    echo "❌ enhanced_agent_enforcer failed to respond"
fi

echo "Testing enhanced_agent_enforcer_v2..."
if timeout 30 ollama run enhanced_agent_enforcer_v2 "Review this statement for accuracy: Louisville is the capital of Kentucky." | wc -w | awk '{if($1 >= 15) print "✅ enhanced_agent_enforcer_v2 working (" $1 " words)"; else print "❌ enhanced_agent_enforcer_v2 failed (" $1 " words)"}'; then
    true
else
    echo "❌ enhanced_agent_enforcer_v2 failed to respond"
fi

echo "Testing decision_simplifier..."
if timeout 30 ollama run decision_simplifier "Summarize these options: 1) Save money in bank, 2) Invest in stocks, 3) Buy real estate." | wc -w | awk '{if($1 >= 20) print "✅ decision_simplifier working (" $1 " words)"; else print "❌ decision_simplifier failed (" $1 " words)"}'; then
    true
else
    echo "❌ decision_simplifier failed to respond"
fi

echo "Testing decision_simplifier_v2..."
if timeout 30 ollama run decision_simplifier_v2 "Summarize these options: 1) Save money in bank, 2) Invest in stocks, 3) Buy real estate." | wc -w | awk '{if($1 >= 20) print "✅ decision_simplifier_v2 working (" $1 " words)"; else print "❌ decision_simplifier_v2 failed (" $1 " words)"}'; then
    true
else
    echo "❌ decision_simplifier_v2 failed to respond"
fi

echo "Testing louisville_expert_v3..."
if timeout 30 ollama run louisville_expert_v3 "What is one advantage of living in Louisville, Kentucky?" | wc -w | awk '{if($1 >= 15) print "✅ louisville_expert_v3 working (" $1 " words)"; else print "❌ louisville_expert_v3 failed (" $1 " words)"}'; then
    true
else
    echo "❌ louisville_expert_v3 failed to respond"
fi

echo "🎉 Validation complete!"
