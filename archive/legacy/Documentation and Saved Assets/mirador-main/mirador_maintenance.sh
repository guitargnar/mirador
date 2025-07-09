

echo "=== Mirador Maintenance and Monitoring ==="
echo "Timestamp: $(date)"
echo ""


mkdir -p maintenance_logs
LOG_FILE="maintenance_logs/maintenance_$(date +%Y%m%d_%H%M%S).log"

exec > >(tee -a "$LOG_FILE")
exec 2>&1

echo "Maintenance log: $LOG_FILE"
echo ""


echo "1. System Health Check:"
echo "   Checking disk space..."
df -h | grep -E "/$|/home"

echo "   Checking Ollama service..."
if pgrep ollama > /dev/null; then
    echo "   ✓ Ollama service running"
else
    echo "   ✗ Ollama service not running"
fi


echo ""
echo "2. Model Performance Check:"
models=("enhanced_agent_fast_v2" "financial_planning_expert_v2" "louisville_expert_v2")

for model in "${models[@]}"; do
    echo "   Testing $model..."
    start_time=$(date +%s)
    timeout 120s mirador-ez ask "$model" "Quick maintenance test" > /dev/null 2>&1
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    
    if [ $? -eq 0 ]; then
        echo "   ✓ $model: ${duration}s"
    else
        echo "   ✗ $model: Failed or timeout"
    fi
done


echo ""
echo "3. Chain Health Check:"
echo "   Testing chain functionality..."
start_time=$(date +%s)
timeout 300s mirador-ez chain "Maintenance chain test" financial_planning_expert_v2 enhanced_agent_fast_v2 > /dev/null 2>&1
end_time=$(date +%s)
duration=$((end_time - start_time))

if [ $? -eq 0 ]; then
    echo "   ✓ Chain test: ${duration}s"
else
    echo "   ✗ Chain test: Failed or timeout"
fi


echo ""
echo "4. Accuracy Spot Check:"
echo "   Testing financial accuracy..."
mirador-ez ask financial_planning_expert_v2 "Budget for exactly $68,000 annual income" > temp_maintenance_accuracy.txt 2>&1

if grep -q "68,000\|$68,000" temp_maintenance_accuracy.txt; then
    echo "   ✓ Financial accuracy: Pass"
else
    echo "   ✗ Financial accuracy: Fail"
fi

rm -f temp_maintenance_accuracy.txt


echo ""
echo "5. Maintenance Summary:"
echo "   Maintenance completed at: $(date)"
echo "   Log saved to: $LOG_FILE"
echo "   Next maintenance recommended: $(date -d '+1 week')"

echo ""
echo "Maintenance complete."
