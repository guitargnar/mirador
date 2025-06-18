

echo "=== Mirador System Version Information ==="
echo "Timestamp: $(date)"
echo ""

echo "Git Repository Status:"
git status --porcelain
echo ""

echo "Current Branch:"
git branch --show-current
echo ""

echo "Latest Commits:"
git log --oneline -5
echo ""

echo "Version Tags:"
git tag -l
echo ""

echo "Production Models:"
ls -la *.modelfile 2>/dev/null || echo "No model files found"
echo ""

echo "Ollama Models:"
ollama list | grep -E "(enhanced_agent|financial_planning|louisville_expert)" || echo "No Mirador models found in Ollama"
echo ""

echo "System Health Check:"
if command -v mirador-ez &> /dev/null; then
    echo "✓ mirador-ez command available"
else
    echo "✗ mirador-ez command not found"
fi

if command -v ollama &> /dev/null; then
    echo "✓ ollama command available"
else
    echo "✗ ollama command not found"
fi
