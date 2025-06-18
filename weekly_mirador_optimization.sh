

echo "=== Weekly Mirador Optimization Routine ==="
echo "Date: $(date)"
echo ""


echo "1. Checking System Performance..."
./comprehensive_performance_test.sh
echo ""


echo "2. Analyzing Value Generated..."
./analyze_mirador_value.sh
echo ""


echo "3. System Optimization Analysis..."
mirador-ez ask mirador_system_specialist "Analyze the past week's usage patterns and provide three specific optimizations"
echo ""


echo "4. Opportunity Identification..."
mirador-ez chain "Identify top 3 opportunities for next week based on system patterns" mirador_system_specialist matthew_context_provider enhanced_agent_enforcer decision_simplifier
echo ""


echo "5. Creating Weekly Summary..."
output_dir="$HOME/ai_framework_git/weekly_reports/$(date +%Y%m%d)"
mkdir -p "$output_dir"


{
    echo "
    echo ""
    echo "
    ./enhanced_system_analysis.sh
    echo ""
    echo "
    echo "Generated on $(date)"
} > "$output_dir/weekly_report.md"

echo "Weekly optimization complete. Report saved to: $output_dir/weekly_report.md"
