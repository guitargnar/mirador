#!/bin/bash

echo "=== MIRADOR SYSTEM VALIDATION ==="
echo "Date: $(date)"
echo ""

echo "1. Testing Model Availability:"
mirador-ez models | grep -E "(financial_planning|louisville_expert|enhanced_agent_fast)"

echo ""
echo "2. Testing Memory System:"
python3 ~/ai_framework_git/mirador_memory.py

echo ""
echo "3. Running Sample Chain:"
mirador-ez chain "Quick test: financial planning for Louisville family" financial_planning_expert_v5 enhanced_agent_fast_v3

echo ""
echo "4. Current Opportunities:"
python3 ~/ai_framework_git/track_opportunity.py list

echo ""
echo "5. Performance Dashboard:"
python3 ~/ai_framework_git/mirador_dashboard.py

echo ""
echo "=== VALIDATION COMPLETE ==="
