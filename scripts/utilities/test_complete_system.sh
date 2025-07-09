#!/bin/bash

echo "=== Mirador Complete System Test ==="
echo ""

# Test each key model
echo "Testing Key Models:"
echo -n "• User Context v3: "
gtimeout 10s mirador-ez ask user_context_provider_v3 "My personality" > /dev/null 2>&1 && echo "✅" || echo "❌"

echo -n "• Financial Expert v8: "
gtimeout 10s mirador-ez ask financial_planning_expert_v8 "Budget for 75k" > /dev/null 2>&1 && echo "✅" || echo "❌"

echo -n "• city Expert: "
gtimeout 10s mirador-ez ask louisville_expert_v3 "Best areas" > /dev/null 2>&1 && echo "✅" || echo "❌"

echo -n "• Enhanced Agent: "
gtimeout 10s mirador-ez ask enhanced_agent_enforcer "Strategy" > /dev/null 2>&1 && echo "✅" || echo "❌"

echo ""
echo "Testing Smart Chains:"
./mirador-smart "How should I budget my 75000 income?"
