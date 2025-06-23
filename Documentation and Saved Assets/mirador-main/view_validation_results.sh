

echo "============================================="
echo "📊 VALIDATION RESULTS SUMMARY"
echo "============================================="
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"


LATEST_REPORT=$(ls -t ~/ai_framework_git/VALIDATION_REPORT_*.md 2>/dev/null | head -1)

if [ -f "$LATEST_REPORT" ]; then
    echo "📄 Viewing: $(basename $LATEST_REPORT)"
    echo ""
    
    
    echo "💰 FINANCIAL METRICS IDENTIFIED:"
    echo "==============================="
    grep -E "\$[0-9,]+" "$LATEST_REPORT" | sort -u | head -10
    echo ""
    
    echo "📈 ROI/PERCENTAGE METRICS:"
    echo "========================="
    grep -E "[0-9]+%|ROI" "$LATEST_REPORT" | sort -u | head -10
    echo ""
    
    echo "🎯 TOP RECOMMENDATIONS SUMMARY:"
    echo "=============================="
    grep -E "^[0-9]+\." "$LATEST_REPORT" | head -15
    echo ""
    
else
    echo "No validation report found. Run the validation suite first."
fi


echo ""
echo "📊 RECENT VALIDATION CHAINS:"
echo "==========================="
ls -t "$OUTPUT_DIR" | head -8 | while read dir; do
    if [ -f "$OUTPUT_DIR/$dir/summary.md" ]; then
        PROMPT=$(grep -A2 "Initial Prompt" "$OUTPUT_DIR/$dir/summary.md" 2>/dev/null | tail -1 | cut -c1-80)
        WORDS=$(wc -w < "$OUTPUT_DIR/$dir/summary.md" 2>/dev/null)
        echo "- $dir: $WORDS words"
        echo "  Query: $PROMPT..."
        echo ""
    fi
done

echo "============================================="
