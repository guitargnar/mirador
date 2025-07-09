#!/bin/bash
echo "=== Mirador Daily Validation ==="
echo "Date: $(date)"
echo ""

# Quick health checks
echo "✓ Checking Ollama..." 
ollama ps > /dev/null 2>&1 && echo "  Ollama running" || echo "  ERROR: Ollama not running"

echo "✓ Testing basic ask..."
timeout 10s mirador-ez ask llama3.2 "Say OK" > /dev/null 2>&1 && echo "  Basic ask working" || echo "  ERROR: Basic ask failed"

echo "✓ Testing chain..."
timeout 60s mirador-ez chain "Quick test" financial_planning_expert_v6 enhanced_agent_enforcer > /dev/null 2>&1 && echo "  Chain working" || echo "  ERROR: Chain failed"

echo "✓ Checking outputs..."
echo "  Total outputs: $(ls outputs/ 2>/dev/null | wc -l | tr -d ' ')"
echo "  Latest: $(ls -t outputs/ 2>/dev/null | head -1)"

echo ""
echo "Validation complete!"
