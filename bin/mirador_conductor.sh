


echo "🎭 Mirador Conductor - Dynamic Chain Selection"

QUERY="$1"
shift
AVAILABLE_MODELS="$@"


if [[ "$QUERY" =~ (financial|money|investment|budget) ]]; then
    CHAIN="matthew_context_provider_v6_complete financial_planning_expert_v6 decision_simplifier_v2"
elif [[ "$QUERY" =~ (Louisville|local|Kentucky) ]]; then
    CHAIN="matthew_context_provider_v6_complete louisville_expert_v3 decision_simplifier_v2"
elif [[ "$QUERY" =~ (opportunity|business|strategy) ]]; then
    CHAIN="matthew_context_provider_v6_complete enhanced_agent_enforcer_v2 decision_simplifier_v2"
elif [[ "$QUERY" =~ (analyze|complex|comprehensive) ]]; then
    CHAIN="matthew_context_provider_v6_complete mirador_system_specialist_v2 enhanced_agent_enforcer_v2 decision_simplifier_v2"
else
    
    CHAIN="matthew_context_provider_v6_complete enhanced_agent_enforcer_v2 decision_simplifier_v2"
fi

echo "🔗 Selected chain: $CHAIN"
mirador-ez chain "$QUERY" $CHAIN
