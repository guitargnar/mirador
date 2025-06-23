#!/bin/bash
# Mirador Model Retirement Script
# WARNING: This will remove models - ensure backup is complete

read -p "Have you completed the backup? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Please run backup_models.sh first"
    exit 1
fi

# Retire enhanced_agent models
if [ -f "enhanced_agent_fast_v1.modelfile" ]; then
    rm "enhanced_agent_fast_v1.modelfile"
    echo "Retired enhanced_agent_fast_v1.modelfile"
fi
ollama rm enhanced_agent_fast_v1 2>/dev/null || true
if [ -f "enhanced_agent_fast_v2.modelfile" ]; then
    rm "enhanced_agent_fast_v2.modelfile"
    echo "Retired enhanced_agent_fast_v2.modelfile"
fi
ollama rm enhanced_agent_fast_v2 2>/dev/null || true
if [ -f "enhanced_agent_fast_v3.modelfile" ]; then
    rm "enhanced_agent_fast_v3.modelfile"
    echo "Retired enhanced_agent_fast_v3.modelfile"
fi
ollama rm enhanced_agent_fast_v3 2>/dev/null || true
if [ -f "enhanced_agent_fast_v4.modelfile" ]; then
    rm "enhanced_agent_fast_v4.modelfile"
    echo "Retired enhanced_agent_fast_v4.modelfile"
fi
ollama rm enhanced_agent_fast_v4 2>/dev/null || true
if [ -f "enhanced_agent_fast_v5.modelfile" ]; then
    rm "enhanced_agent_fast_v5.modelfile"
    echo "Retired enhanced_agent_fast_v5.modelfile"
fi
ollama rm enhanced_agent_fast_v5 2>/dev/null || true
if [ -f "enhanced_agent_fast_v7.modelfile" ]; then
    rm "enhanced_agent_fast_v7.modelfile"
    echo "Retired enhanced_agent_fast_v7.modelfile"
fi
ollama rm enhanced_agent_fast_v7 2>/dev/null || true
if [ -f "enhanced_agent_v1.modelfile" ]; then
    rm "enhanced_agent_v1.modelfile"
    echo "Retired enhanced_agent_v1.modelfile"
fi
ollama rm enhanced_agent_v1 2>/dev/null || true
if [ -f "enhanced_agent_v2.modelfile" ]; then
    rm "enhanced_agent_v2.modelfile"
    echo "Retired enhanced_agent_v2.modelfile"
fi
ollama rm enhanced_agent_v2 2>/dev/null || true

# Retire local_expert models
if [ -f "louisville_expert_v1.modelfile" ]; then
    rm "louisville_expert_v1.modelfile"
    echo "Retired louisville_expert_v1.modelfile"
fi
ollama rm louisville_expert_v1 2>/dev/null || true
if [ -f "louisville_expert_v2.modelfile" ]; then
    rm "louisville_expert_v2.modelfile"
    echo "Retired louisville_expert_v2.modelfile"
fi
ollama rm louisville_expert_v2 2>/dev/null || true

# Retire financial_planning models
if [ -f "financial_planning_expert_v1.modelfile" ]; then
    rm "financial_planning_expert_v1.modelfile"
    echo "Retired financial_planning_expert_v1.modelfile"
fi
ollama rm financial_planning_expert_v1 2>/dev/null || true
if [ -f "financial_planning_expert_v2.modelfile" ]; then
    rm "financial_planning_expert_v2.modelfile"
    echo "Retired financial_planning_expert_v2.modelfile"
fi
ollama rm financial_planning_expert_v2 2>/dev/null || true
if [ -f "financial_planning_expert_v3.modelfile" ]; then
    rm "financial_planning_expert_v3.modelfile"
    echo "Retired financial_planning_expert_v3.modelfile"
fi
ollama rm financial_planning_expert_v3 2>/dev/null || true
if [ -f "financial_planning_expert_v4.modelfile" ]; then
    rm "financial_planning_expert_v4.modelfile"
    echo "Retired financial_planning_expert_v4.modelfile"
fi
ollama rm financial_planning_expert_v4 2>/dev/null || true
if [ -f "financial_planning_expert_v5.modelfile" ]; then
    rm "financial_planning_expert_v5.modelfile"
    echo "Retired financial_planning_expert_v5.modelfile"
fi
ollama rm financial_planning_expert_v5 2>/dev/null || true
if [ -f "financial_planning_expert_v7.modelfile" ]; then
    rm "financial_planning_expert_v7.modelfile"
    echo "Retired financial_planning_expert_v7.modelfile"
fi
ollama rm financial_planning_expert_v7 2>/dev/null || true
if [ -f "financial_planning_expert_v8.modelfile" ]; then
    rm "financial_planning_expert_v8.modelfile"
    echo "Retired financial_planning_expert_v8.modelfile"
fi
ollama rm financial_planning_expert_v8 2>/dev/null || true

# Retire system_specialist models
if [ -f "mirador_system_specialist_v1.modelfile" ]; then
    rm "mirador_system_specialist_v1.modelfile"
    echo "Retired mirador_system_specialist_v1.modelfile"
fi
ollama rm mirador_system_specialist_v1 2>/dev/null || true

# Retire context_provider models
if [ -f "matthew_context_provider_v1.modelfile" ]; then
    rm "matthew_context_provider_v1.modelfile"
    echo "Retired matthew_context_provider_v1.modelfile"
fi
ollama rm matthew_context_provider_v1 2>/dev/null || true

# Retire decision_support models
if [ -f "decision_simplifier_v1.modelfile" ]; then
    rm "decision_simplifier_v1.modelfile"
    echo "Retired decision_simplifier_v1.modelfile"
fi
ollama rm decision_simplifier_v1 2>/dev/null || true

echo "Model retirement completed"
