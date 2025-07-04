#!/bin/bash
# Comprehensive system health check

echo "=== Mirador System Health Check ==="
echo "Timestamp: $(date)"
echo ""

# Check Ollama service
echo "1. Ollama Status:"
if curl -s http://localhost:11434/api/tags >/dev/null; then
    echo "   ✅ Ollama is running"
    model_count=$(curl -s http://localhost:11434/api/tags | jq '.models | length')
    echo "   📊 Models loaded: $model_count"
else
    echo "   ❌ Ollama is not responding"
fi
echo ""

# Check disk space
echo "2. Disk Usage:"
echo "   Project directory:"
du -sh . 2>/dev/null || echo "   Unable to check"
echo "   Outputs directory:"
du -sh outputs/ 2>/dev/null || echo "   No outputs directory"
echo ""

# Check memory usage
echo "3. Memory Usage:"
ps aux | grep ollama | grep -v grep | awk '{print "   Ollama PID " $2 ": " $4 "% memory"}'
echo ""

# Check for recent errors
echo "4. Recent Errors:"
if [ -d "$HOME/.mirador/logs" ]; then
    recent_errors=$(find "$HOME/.mirador/logs" -name "*.log" -mtime -1 -exec grep -l "ERROR" {} \; 2>/dev/null | wc -l)
    echo "   Error logs in last 24h: $recent_errors"
else
    echo "   No log directory found"
fi
echo ""

# Check outputs directory
echo "5. Output Status:"
if [ -d "outputs" ]; then
    output_count=$(find outputs -name "*.txt" -o -name "*.md" | wc -l)
    echo "   Output files: $output_count"
    latest_output=$(find outputs -type f -printf '%T@ %p\n' 2>/dev/null | sort -n | tail -1 | cut -d' ' -f2-)
    echo "   Latest output: $latest_output"
else
    echo "   No outputs directory"
fi

echo ""
echo "=== Health Check Complete ==="
