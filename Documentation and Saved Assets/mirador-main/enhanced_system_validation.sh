

echo "=== ENHANCED MIRADOR SYSTEM VALIDATION ==="
echo "Date: $(date)"
echo


echo "1. Checking Enhanced Models:"
for model in matthew_context_provider_v2 mirador_system_specialist_v2; do
    if ollama list | grep -q "$model"; then
        echo "✓ $model available"
    else
        echo "✗ $model NOT FOUND"
    fi
done


echo -e "\n2. Testing Personality Integration:"
echo "Running context analysis..."
OUTPUT=$(mirador-ez chain "What are my key personality traits?" matthew_context_provider_v2 decision_simplifier 2>&1)
if echo "$OUTPUT" | grep -q -i "openness\|creative\|agreeableness"; then
    echo "✓ Personality profile integrated successfully"
else
    echo "✗ Personality profile NOT integrated"
fi


echo -e "\n3. Running Personality-Optimized Chain:"
time mirador-ez chain "Quick opportunity scan" matthew_context_provider_v2 decision_simplifier

echo -e "\n=== Validation Complete ==="
