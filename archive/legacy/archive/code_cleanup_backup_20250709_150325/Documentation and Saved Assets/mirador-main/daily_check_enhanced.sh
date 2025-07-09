#!/bin/bash

echo "=== Mirador Daily System Check ==="
echo "Date: $(date)"
echo "Version: v1.1-personality-integrated"
echo ""

# System Status
echo "SYSTEM STATUS:"
echo -n "• Ollama: "
pgrep -f "ollama serve" > /dev/null && echo "✓ Running" || echo "✗ Not running"

echo -n "• Conductor: "
[ -x mirador_conductor.sh ] && echo "✓ Available" || echo "✗ Missing"

echo -n "• Memory DB: "
[ -f mirador_memory.db ] && echo "✓ Active ($(sqlite3 mirador_memory.db "SELECT COUNT(*) FROM analysis_history" 2>/dev/null || echo 0) analyses)" || echo "✗ Not found"

# Quick Model Test
echo ""
echo "MODEL HEALTH:"
models=("financial_planning_expert_v7" "enhanced_agent_enforcer" "louisville_expert_v3" "matthew_context_provider_v3")
for model in "${models[@]}"; do
    echo -n "• $model: "
    if gtimeout 5s ollama run "$model" "health check" > /dev/null 2>&1; then
        echo "✓"
    else
        echo "✗"
    fi
done

# Statistics
echo ""
echo "STATISTICS:"
echo "• Total outputs: $(ls outputs/ 2>/dev/null | wc -l | tr -d ' ')"
echo "• Disk usage: $(du -sh outputs/ 2>/dev/null | awk '{print $1}')"
echo "• Uncommitted files: $(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')"
echo "• Latest chain: $(ls -t outputs/ 2>/dev/null | head -1)"

# Today's Opportunity
echo ""
echo "TODAY'S FOCUS:"
echo "Run: mirador-ez chain \"What's my highest-value opportunity today?\" matthew_context_provider_v3 enhanced_agent_enforcer decision_simplifier"
