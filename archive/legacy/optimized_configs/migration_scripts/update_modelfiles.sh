#!/bin/bash
# Mirador Model Configuration Update Script
# Updates all models to use llama3.2_balanced base model

set -e

echo "🔄 Updating Mirador model configurations..."

echo "Updating matthew_context_provider_v2..."
if [ -f "../modelfiles/matthew_context_provider_v2.modelfile" ]; then
    cp "../modelfiles/matthew_context_provider_v2.modelfile" "./matthew_context_provider_v2.modelfile"
    ollama create matthew_context_provider_v2 -f "./matthew_context_provider_v2.modelfile"
    echo "✅ Updated matthew_context_provider_v2"
else
    echo "⚠️  Modelfile not found for matthew_context_provider_v2"
fi

echo "Updating decision_simplifier_v2..."
if [ -f "../modelfiles/decision_simplifier_v2.modelfile" ]; then
    cp "../modelfiles/decision_simplifier_v2.modelfile" "./decision_simplifier_v2.modelfile"
    ollama create decision_simplifier_v2 -f "./decision_simplifier_v2.modelfile"
    echo "✅ Updated decision_simplifier_v2"
else
    echo "⚠️  Modelfile not found for decision_simplifier_v2"
fi

echo "Updating financial_planning_expert_v6..."
if [ -f "../modelfiles/financial_planning_expert_v6.modelfile" ]; then
    cp "../modelfiles/financial_planning_expert_v6.modelfile" "./financial_planning_expert_v6.modelfile"
    ollama create financial_planning_expert_v6 -f "./financial_planning_expert_v6.modelfile"
    echo "✅ Updated financial_planning_expert_v6"
else
    echo "⚠️  Modelfile not found for financial_planning_expert_v6"
fi

echo "Updating financial_planning_expert_fast..."
if [ -f "../modelfiles/financial_planning_expert_fast.modelfile" ]; then
    cp "../modelfiles/financial_planning_expert_fast.modelfile" "./financial_planning_expert_fast.modelfile"
    ollama create financial_planning_expert_fast -f "./financial_planning_expert_fast.modelfile"
    echo "✅ Updated financial_planning_expert_fast"
else
    echo "⚠️  Modelfile not found for financial_planning_expert_fast"
fi

echo "Updating louisville_expert_v3..."
if [ -f "../modelfiles/louisville_expert_v3.modelfile" ]; then
    cp "../modelfiles/louisville_expert_v3.modelfile" "./louisville_expert_v3.modelfile"
    ollama create louisville_expert_v3 -f "./louisville_expert_v3.modelfile"
    echo "✅ Updated louisville_expert_v3"
else
    echo "⚠️  Modelfile not found for louisville_expert_v3"
fi

echo "Updating enhanced_agent_enforcer_v2..."
if [ -f "../modelfiles/enhanced_agent_enforcer_v2.modelfile" ]; then
    cp "../modelfiles/enhanced_agent_enforcer_v2.modelfile" "./enhanced_agent_enforcer_v2.modelfile"
    ollama create enhanced_agent_enforcer_v2 -f "./enhanced_agent_enforcer_v2.modelfile"
    echo "✅ Updated enhanced_agent_enforcer_v2"
else
    echo "⚠️  Modelfile not found for enhanced_agent_enforcer_v2"
fi

echo "Updating enhanced_agent_fast_v6..."
if [ -f "../modelfiles/enhanced_agent_fast_v6.modelfile" ]; then
    cp "../modelfiles/enhanced_agent_fast_v6.modelfile" "./enhanced_agent_fast_v6.modelfile"
    ollama create enhanced_agent_fast_v6 -f "./enhanced_agent_fast_v6.modelfile"
    echo "✅ Updated enhanced_agent_fast_v6"
else
    echo "⚠️  Modelfile not found for enhanced_agent_fast_v6"
fi

echo "Updating mirador_system_specialist_v2..."
if [ -f "../modelfiles/mirador_system_specialist_v2.modelfile" ]; then
    cp "../modelfiles/mirador_system_specialist_v2.modelfile" "./mirador_system_specialist_v2.modelfile"
    ollama create mirador_system_specialist_v2 -f "./mirador_system_specialist_v2.modelfile"
    echo "✅ Updated mirador_system_specialist_v2"
else
    echo "⚠️  Modelfile not found for mirador_system_specialist_v2"
fi

echo "Updating linkedin_content_expert..."
if [ -f "../modelfiles/linkedin_content_expert.modelfile" ]; then
    cp "../modelfiles/linkedin_content_expert.modelfile" "./linkedin_content_expert.modelfile"
    ollama create linkedin_content_expert -f "./linkedin_content_expert.modelfile"
    echo "✅ Updated linkedin_content_expert"
else
    echo "⚠️  Modelfile not found for linkedin_content_expert"
fi

echo "Updating real_estate_analyzer..."
if [ -f "../modelfiles/real_estate_analyzer.modelfile" ]; then
    cp "../modelfiles/real_estate_analyzer.modelfile" "./real_estate_analyzer.modelfile"
    ollama create real_estate_analyzer -f "./real_estate_analyzer.modelfile"
    echo "✅ Updated real_estate_analyzer"
else
    echo "⚠️  Modelfile not found for real_estate_analyzer"
fi

echo "Updating health_wellness_optimizer..."
if [ -f "../modelfiles/health_wellness_optimizer.modelfile" ]; then
    cp "../modelfiles/health_wellness_optimizer.modelfile" "./health_wellness_optimizer.modelfile"
    ollama create health_wellness_optimizer -f "./health_wellness_optimizer.modelfile"
    echo "✅ Updated health_wellness_optimizer"
else
    echo "⚠️  Modelfile not found for health_wellness_optimizer"
fi

echo "Updating productivity_optimizer..."
if [ -f "../modelfiles/productivity_optimizer.modelfile" ]; then
    cp "../modelfiles/productivity_optimizer.modelfile" "./productivity_optimizer.modelfile"
    ollama create productivity_optimizer -f "./productivity_optimizer.modelfile"
    echo "✅ Updated productivity_optimizer"
else
    echo "⚠️  Modelfile not found for productivity_optimizer"
fi

echo "🎉 Model configuration update complete!"
