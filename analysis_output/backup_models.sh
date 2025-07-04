#!/bin/bash
# Mirador Model Backup Script
# Generated automatically - review before execution

BACKUP_DIR="./model_backups_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup enhanced_agent models
if [ -f "enhanced_agent_fast_v1.modelfile" ]; then
    cp "enhanced_agent_fast_v1.modelfile" "$BACKUP_DIR/"
    echo "Backed up enhanced_agent_fast_v1.modelfile"
fi
if [ -f "enhanced_agent_fast_v2.modelfile" ]; then
    cp "enhanced_agent_fast_v2.modelfile" "$BACKUP_DIR/"
    echo "Backed up enhanced_agent_fast_v2.modelfile"
fi
if [ -f "enhanced_agent_fast_v3.modelfile" ]; then
    cp "enhanced_agent_fast_v3.modelfile" "$BACKUP_DIR/"
    echo "Backed up enhanced_agent_fast_v3.modelfile"
fi
if [ -f "enhanced_agent_fast_v4.modelfile" ]; then
    cp "enhanced_agent_fast_v4.modelfile" "$BACKUP_DIR/"
    echo "Backed up enhanced_agent_fast_v4.modelfile"
fi
if [ -f "enhanced_agent_fast_v5.modelfile" ]; then
    cp "enhanced_agent_fast_v5.modelfile" "$BACKUP_DIR/"
    echo "Backed up enhanced_agent_fast_v5.modelfile"
fi
if [ -f "enhanced_agent_fast_v7.modelfile" ]; then
    cp "enhanced_agent_fast_v7.modelfile" "$BACKUP_DIR/"
    echo "Backed up enhanced_agent_fast_v7.modelfile"
fi
if [ -f "enhanced_agent_v1.modelfile" ]; then
    cp "enhanced_agent_v1.modelfile" "$BACKUP_DIR/"
    echo "Backed up enhanced_agent_v1.modelfile"
fi
if [ -f "enhanced_agent_v2.modelfile" ]; then
    cp "enhanced_agent_v2.modelfile" "$BACKUP_DIR/"
    echo "Backed up enhanced_agent_v2.modelfile"
fi

# Backup local_expert models
if [ -f "louisville_expert_v1.modelfile" ]; then
    cp "louisville_expert_v1.modelfile" "$BACKUP_DIR/"
    echo "Backed up louisville_expert_v1.modelfile"
fi
if [ -f "louisville_expert_v2.modelfile" ]; then
    cp "louisville_expert_v2.modelfile" "$BACKUP_DIR/"
    echo "Backed up louisville_expert_v2.modelfile"
fi

# Backup financial_planning models
if [ -f "financial_planning_expert_v1.modelfile" ]; then
    cp "financial_planning_expert_v1.modelfile" "$BACKUP_DIR/"
    echo "Backed up financial_planning_expert_v1.modelfile"
fi
if [ -f "financial_planning_expert_v2.modelfile" ]; then
    cp "financial_planning_expert_v2.modelfile" "$BACKUP_DIR/"
    echo "Backed up financial_planning_expert_v2.modelfile"
fi
if [ -f "financial_planning_expert_v3.modelfile" ]; then
    cp "financial_planning_expert_v3.modelfile" "$BACKUP_DIR/"
    echo "Backed up financial_planning_expert_v3.modelfile"
fi
if [ -f "financial_planning_expert_v4.modelfile" ]; then
    cp "financial_planning_expert_v4.modelfile" "$BACKUP_DIR/"
    echo "Backed up financial_planning_expert_v4.modelfile"
fi
if [ -f "financial_planning_expert_v5.modelfile" ]; then
    cp "financial_planning_expert_v5.modelfile" "$BACKUP_DIR/"
    echo "Backed up financial_planning_expert_v5.modelfile"
fi
if [ -f "financial_planning_expert_v7.modelfile" ]; then
    cp "financial_planning_expert_v7.modelfile" "$BACKUP_DIR/"
    echo "Backed up financial_planning_expert_v7.modelfile"
fi
if [ -f "financial_planning_expert_v8.modelfile" ]; then
    cp "financial_planning_expert_v8.modelfile" "$BACKUP_DIR/"
    echo "Backed up financial_planning_expert_v8.modelfile"
fi

# Backup system_specialist models
if [ -f "mirador_system_specialist_v1.modelfile" ]; then
    cp "mirador_system_specialist_v1.modelfile" "$BACKUP_DIR/"
    echo "Backed up mirador_system_specialist_v1.modelfile"
fi

# Backup context_provider models
if [ -f "matthew_context_provider_v1.modelfile" ]; then
    cp "matthew_context_provider_v1.modelfile" "$BACKUP_DIR/"
    echo "Backed up matthew_context_provider_v1.modelfile"
fi

# Backup decision_support models
if [ -f "decision_simplifier_v1.modelfile" ]; then
    cp "decision_simplifier_v1.modelfile" "$BACKUP_DIR/"
    echo "Backed up decision_simplifier_v1.modelfile"
fi

echo "Backup completed in $BACKUP_DIR"
