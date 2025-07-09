#!/bin/bash

echo "=== Mirador Rollback Script ==="
echo "This script will remove the new model versions and restore previous state"
echo ""

read -p "Are you sure you want to rollback? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
    echo "Rollback cancelled."
    exit 1
fi

echo "Removing new model versions..."
ollama rm enhanced_agent_fast_v2 2>/dev/null || echo "enhanced_agent_fast_v2 not found"
ollama rm financial_planning_expert_v2 2>/dev/null || echo "financial_planning_expert_v2 not found"
ollama rm louisville_expert_v2 2>/dev/null || echo "louisville_expert_v2 not found"

echo "Rollback complete. Original models preserved."
echo "You may need to recreate any models that were working before the upgrade."
