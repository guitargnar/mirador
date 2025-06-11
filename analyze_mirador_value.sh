#!/bin/bash

echo "=== Mirador Value Analysis ==="

# Your existing output analysis enhanced
output_dir="$HOME/ai_framework_git/outputs"

if [ -d "$output_dir" ]; then
    echo "Output Analysis:"
    echo "Total Chains: $(ls $output_dir/chain_*/summary.md 2>/dev/null | wc -l)"
    echo "Total Words Generated: $(find $output_dir -name "summary.md" -exec wc -w {} \; | awk '{sum+=$1} END {print sum}')"
    
    echo ""
    echo "Category Breakdown:"
    echo "Business Strategies: $(find $output_dir -path "*business_strategies*" -name "summary.md" 2>/dev/null | wc -l)"
    echo "Career Plans: $(find $output_dir -path "*career_plans*" -name "summary.md" 2>/dev/null | wc -l)"
    echo "Investment Analysis: $(find $output_dir -path "*investment*" -name "summary.md" 2>/dev/null | wc -l)"
    
    echo ""
    echo "Value Metrics:"
    # Calculate time savings (assuming manual research = 3 hours per comprehensive analysis)
    chain_count=$(ls $output_dir/chain_*/summary.md 2>/dev/null | wc -l)
    if [ $chain_count -gt 0 ]; then
        time_saved=$((chain_count * 3))
        echo "Estimated Time Saved: $time_saved hours (vs manual research)"
        echo "Average Chain Value: $((time_saved / chain_count)) hours per analysis"
    fi
    
    echo ""
    echo "Recent High-Value Outputs:"
    find $output_dir -name "summary.md" -mtime -30 -exec wc -w {} \; | sort -nr | head -5 | while read words file; do
        chain_dir=$(dirname "$file")
        chain_name=$(basename "$chain_dir")
        echo "  $chain_name: $words words"
    done
else
    echo "No output directory found at $output_dir"
fi

echo ""
echo "System Optimization Recommendations:"
mirador-ez ask mirador_system_specialist "Analyze usage patterns and recommend optimizations for maximum value extraction"
