
echo "🏥 Mirador System Health Check"


if pgrep ollama > /dev/null; then
    echo "✅ Ollama service running"
else
    echo "❌ Ollama service not running"
    ollama serve > /dev/null 2>&1 &
    sleep 5
fi


CORE_MODELS="matthew_context_provider_v2 financial_planning_expert_v6 decision_simplifier_v2 enhanced_agent_enforcer_v2"
for model in $CORE_MODELS; do
    if ollama list | grep -q "$model"; then
        echo "✅ $model available"
    else
        echo "❌ $model missing"
    fi
done


OUTPUTS_SIZE=$(du -sh outputs/ 2>/dev/null | cut -f1)
echo "📁 Outputs directory size: $OUTPUTS_SIZE"


echo "💾 Ollama memory usage:"
ps aux | grep ollama | grep -v grep | awk '{print $6/1024 " MB"}'


echo "🔗 Testing quick chain..."
time mirador-ez chain "System health test" matthew_context_provider_v2 decision_simplifier_v2 > /dev/null

echo "🎯 Health check complete!"
