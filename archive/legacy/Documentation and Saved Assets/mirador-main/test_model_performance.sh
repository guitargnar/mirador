

if [ $
    echo "Usage: $0 <model_name> [test_query]"
    echo "Available models:"
    ollama list | grep -E "(enhanced_agent|financial_planning|louisville_expert)"
    exit 1
fi

MODEL_NAME="$1"
TEST_QUERY="${2:-Quick test of model capabilities and response quality}"

echo "=== Testing Model Performance ==="
echo "Model: $MODEL_NAME"
echo "Query: $TEST_QUERY"
echo "Timestamp: $(date)"
echo ""


echo "Testing individual model response..."
start_time=$(date +%s)
mirador-ez ask "$MODEL_NAME" "$TEST_QUERY" > "test_${MODEL_NAME}_$(date +%Y%m%d_%H%M%S).txt"
end_time=$(date +%s)
duration=$((end_time - start_time))

echo "Response time: ${duration} seconds"
echo "Output saved to: test_${MODEL_NAME}_$(date +%Y%m%d_%H%M%S).txt"

if [ $duration -lt 30 ]; then
    echo "✓ Performance: GOOD (under 30s)"
elif [ $duration -lt 60 ]; then
    echo "⚠ Performance: ACCEPTABLE (30-60s)"
else
    echo "✗ Performance: SLOW (over 60s)"
fi
