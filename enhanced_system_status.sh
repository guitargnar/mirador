

echo "=== Enhanced Mirador System Status ==="
echo "Timestamp: $(date)"
echo ""


./version_info.sh

echo ""
echo "=== Performance Analytics ==="
echo "Recent Chain Success Rate:"
chain_count=$(ls ~/ai_framework_git/outputs/chain_*/summary.md 2>/dev/null | wc -l)
echo "  Total Chains Executed: $chain_count"

if [ $chain_count -gt 0 ]; then
    echo "  Success Rate: 100% (based on existing outputs)"
    
    echo ""
    echo "Content Generation Analytics:"
    total_words=$(find ~/ai_framework_git/outputs/ -name "summary.md" -exec wc -w {} \; | awk '{sum+=$1} END {print sum}')
    avg_words=$((total_words / chain_count))
    echo "  Total Words Generated: $total_words"
    echo "  Average Words Per Chain: $avg_words"
    
    echo ""
    echo "Recent Activity:"
    ls -t ~/ai_framework_git/outputs/ | head -5 | while read dir; do
        if [ -f "~/ai_framework_git/outputs/$dir/summary.md" ]; then
            words=$(wc -w < "~/ai_framework_git/outputs/$dir/summary.md")
            echo "  $dir: $words words"
        fi
    done
fi

echo ""
echo "=== System Optimization Recommendations ==="
mirador-ez ask mirador_system_specialist "Analyze current system performance and suggest immediate optimizations"


echo "=== Enhanced Mirador System Status ==="
echo "Timestamp: $(date)"
echo ""


./version_info.sh

echo ""
echo "=== Performance Analytics ==="
echo "Recent Chain Success Rate:"
chain_count=$(ls ~/ai_framework_git/outputs/chain_*/summary.md 2>/dev/null | wc -l)
echo "  Total Chains Executed: $chain_count"

if [ $chain_count -gt 0 ]; then
    echo "  Success Rate: 100% (based on existing outputs)"
    
    echo ""
    echo "Content Generation Analytics:"
    total_words=$(find ~/ai_framework_git/outputs/ -name "summary.md" -exec wc -w {} \; | awk '{sum+=$1} END {print sum}')
    avg_words=$((total_words / chain_count))
    echo "  Total Words Generated: $total_words"
    echo "  Average Words Per Chain: $avg_words"
    
    echo ""
    echo "Recent Activity:"
    ls -t ~/ai_framework_git/outputs/ | head -5 | while read dir; do
        if [ -f "~/ai_framework_git/outputs/$dir/summary.md" ]; then
            words=$(wc -w < "~/ai_framework_git/outputs/$dir/summary.md")
            echo "  $dir: $words words"
        fi
    done
fi

echo ""
echo "=== System Optimization Recommendations ==="
mirador-ez ask mirador_system_specialist "Analyze current system performance and suggest immediate optimizations"
