

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


TEMP_OUTPUT=$(mktemp)
mirador-ez chain "What are my key personality traits?" matthew_context_provider_v2 decision_simplifier > "$TEMP_OUTPUT" 2>&1


LATEST_SUMMARY=$(ls -t outputs/*/summary.md | head -1)
if [ -f "$LATEST_SUMMARY" ]; then
    if grep -q -i -E "openness|creative|agreeableness|conscientiousness|extraversion|neuroticism" "$LATEST_SUMMARY"; then
        echo "✓ Personality profile integrated successfully"
    else
        echo "✗ Personality profile NOT integrated"
    fi
else
    echo "⚠️  Could not find summary file"
fi


rm -f "$TEMP_OUTPUT"


echo -e "\n3. Running Personality-Optimized Chain:"
time mirador-ez chain "Quick opportunity scan" matthew_context_provider_v2 decision_simplifier

echo -e "\n=== Validation Complete ==="
