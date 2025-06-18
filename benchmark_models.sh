


echo "🏃 MIRADOR MODEL PERFORMANCE BENCHMARK"
echo "======================================"

TEST_PROMPT="What are the top 3 investment opportunities for someone with Medicare compliance expertise?"


for model in enhanced_agent_fast_v7 financial_planning_expert_fast decision_enhancer financial_planning_expert_v6; do
    echo ""
    echo "Testing: $model"
    START=$(date +%s)
    
    OUTPUT=$(mirador-ez ask $model "$TEST_PROMPT" 2>&1)
    
    END=$(date +%s)
    DURATION=$((END - START))
    WORDS=$(echo "$OUTPUT" | wc -w)
    
    echo "⏱️  Time: ${DURATION}s"
    echo "📝 Words: $WORDS"
    echo "⚡ Words/sec: $((WORDS / DURATION))"
done

echo ""
echo "✅ Benchmark complete!"
