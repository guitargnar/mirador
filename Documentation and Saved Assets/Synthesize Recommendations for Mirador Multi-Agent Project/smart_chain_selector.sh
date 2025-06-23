#!/bin/bash

# Intelligent Chain Selector for Mirador
analyze_query() {
    local query="$1"
    local selected_chain=""
    
    # Financial queries
    if echo "$query" | grep -iE "(money|investment|budget|financial|retire|401k|save|spend)" >/dev/null; then
        selected_chain="matthew_context_provider_v2 financial_planning_expert_v6 decision_simplifier_v2"
        echo "💰 Financial Analysis Chain"
    
    # Louisville/Local queries  
    elif echo "$query" | grep -iE "(louisville|kentucky|local|community|neighborhood)" >/dev/null; then
        selected_chain="matthew_context_provider_v2 louisville_expert_v3 decision_simplifier_v2"
        echo "🏠 Louisville Expert Chain"
    
    # Career/Business queries
    elif echo "$query" | grep -iE "(career|job|business|opportunity|strategy|growth)" >/dev/null; then
        selected_chain="matthew_context_provider_v2 enhanced_agent_enforcer_v2 decision_simplifier_v2"
        echo "📈 Career/Business Chain"
    
    # Complex analysis queries
    elif echo "$query" | grep -iE "(analyze|comprehensive|strategy|plan|complex)" >/dev/null; then
        selected_chain="matthew_context_provider_v2 mirador_system_specialist_v2 enhanced_agent_enforcer_v2 decision_simplifier_v2"
        echo "🧠 Comprehensive Analysis Chain"
    
    # Default chain
    else
        selected_chain="matthew_context_provider_v2 enhanced_agent_enforcer_v2 decision_simplifier_v2"
        echo "⚡ Standard Analysis Chain"
    fi
    
    echo "$selected_chain"
}

# Test the selector
echo "🔗 Testing intelligent chain selection:"
echo ""
echo "Query: 'Investment opportunities this week'"
analyze_query "Investment opportunities this week"
echo ""
echo "Query: 'Louisville business opportunities'"  
analyze_query "Louisville business opportunities"
echo ""
echo "Query: 'Career advancement strategies'"
analyze_query "Career advancement strategies"
