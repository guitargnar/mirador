
echo "⚡ Quick Mirador Optimization"


echo "🔄 Restarting Ollama..."
pkill ollama
sleep 3
ollama serve > /dev/null 2>&1 &
sleep 5


echo "🚀 Preloading core models..."
ollama run matthew_context_provider_v2 "warmup" > /dev/null 2>&1 &
ollama run financial_planning_expert_v6 "warmup" > /dev/null 2>&1 &
ollama run decision_simplifier_v2 "warmup" > /dev/null 2>&1 &
ollama run enhanced_agent_enforcer_v2 "warmup" > /dev/null 2>&1 &


echo "🧹 Cleaning old outputs..."
find outputs/ -name "chain_*" -mtime +20 -exec rm -rf {} \; 2>/dev/null


ln -sf "$(ls -td outputs/chain_* | head -1)" outputs/latest 2>/dev/null

echo "✅ Optimization complete!"
