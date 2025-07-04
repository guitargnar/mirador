#!/bin/bash
echo "🚀 MIRADOR ULTIMATE PERFORMANCE DASHBOARD"
echo "========================================="
echo ""

# System Performance
echo "⚡ SYSTEM PERFORMANCE"
echo "-------------------"
if pgrep ollama > /dev/null; then
    echo "✅ Ollama service: RUNNING"
else
    echo "❌ Ollama service: STOPPED"
fi

MEMORY_USAGE=$(ps aux | grep ollama | grep -v grep | awk '{sum += $6} END {print sum/1024 " MB"}')
echo "💾 Memory usage: $MEMORY_USAGE"

MODEL_COUNT=$(ollama list | grep -c ":")
echo "🤖 Active models: $MODEL_COUNT"

OUTPUTS_SIZE=$(du -sh outputs/ 2>/dev/null | cut -f1)
echo "📁 Outputs size: $OUTPUTS_SIZE"

echo ""

# Model Performance Test
echo "🧪 QUICK MODEL TEST"
echo "------------------"
CORE_MODELS="matthew_context_provider_v2 financial_planning_expert_v6 decision_simplifier_v2 enhanced_agent_enforcer_v2"

for model in $CORE_MODELS; do
    if ollama list | grep -q "$model"; then
        echo "✅ $model: Available"
    else
        echo "❌ $model: Missing"
    fi
done

echo ""

# Performance Metrics
echo "📊 RECENT PERFORMANCE"
echo "-------------------"
if [ -f performance_log.txt ]; then
    echo "Last 5 chain executions:"
    tail -5 performance_log.txt | while read line; do
        echo "  $line"
    done
else
    echo "No performance log found"
fi

echo ""

# Quick Chain Test
echo "⚡ QUICK CHAIN TEST"
echo "-----------------"
START_TIME=$(date +%s)
echo "Testing basic chain performance..."

# Run a quick test chain
timeout 45s mirador-ez chain "Quick system test" matthew_context_provider_v2 decision_simplifier_v2 > /tmp/test_output 2>&1

if [ $? -eq 0 ]; then
    END_TIME=$(date +%s)
    DURATION=$((END_TIME - START_TIME))
    WORD_COUNT=$(wc -w < /tmp/test_output)
    echo "✅ Test chain completed in ${DURATION}s"
    echo "📝 Generated $WORD_COUNT words"
else
    echo "❌ Test chain failed or timed out"
fi

echo ""
echo "🎯 OPTIMIZATION RECOMMENDATIONS"
echo "------------------------------"

# Provide optimization recommendations based on performance
if [ "$MODEL_COUNT" -gt 50 ]; then
    echo "💡 Consider removing unused models (current: $MODEL_COUNT)"
fi

if [[ "$MEMORY_USAGE" =~ ([0-9]+) ]] && [ "${BASH_REMATCH[1]}" -gt 4000 ]; then
    echo "💡 High memory usage detected - consider restarting Ollama"
fi

if [ ! -f "health_check.sh" ]; then
    echo "💡 Run health check for detailed system analysis"
fi

echo ""
echo "✅ Dashboard complete!"
echo "Run './ultimate_performance_dashboard.sh' anytime for updates"
