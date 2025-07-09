#!/bin/bash

echo "=== Mirador Daily Check ==="
echo "Date: $(date)"
echo ""

# Check Ollama
echo -n "Ollama service: "
pgrep -f "ollama serve" > /dev/null && echo "✓ Running" || echo "✗ Not running"

echo -n "Loaded models: "
count=$(ollama ps | grep -v "NAME" | wc -l | tr -d ' ')
echo "$count active"

# Quick test
echo -n "Basic functionality: "
if perl -e 'alarm 10; exec @ARGV' 10 mirador-ez ask llama3.2 "Say OK" > /dev/null 2>&1; then
    echo "✓ Working"
else
    echo "✗ Failed"
fi

# Output stats
echo ""
echo "Statistics:"
echo "- Total outputs: $(ls outputs/ 2>/dev/null | wc -l | tr -d ' ')"
echo "- Git changes: $(git status --porcelain | wc -l | tr -d ' ') files"
echo "- Latest output: $(ls -t outputs/ 2>/dev/null | head -1)"
