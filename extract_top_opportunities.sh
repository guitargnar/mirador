

echo "============================================="
echo "🏆 TOP MIRADOR OPPORTUNITIES EXTRACTION"
echo "============================================="
echo "Generated: $(date)"
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"
TOP_OPPS="$HOME/ai_framework_git/TOP_OPPORTUNITIES.md"


cat > "$TOP_OPPS" << 'HEADER'

Generated: DATE_PLACEHOLDER

Based on analysis of 128 chains generating 125,636 words of insights.




HEADER

sed -i '' "s/DATE_PLACEHOLDER/$(date)/" "$TOP_OPPS"


echo "🔍 Extracting immediate opportunities..."
find "$OUTPUT_DIR" -name "summary.md" -exec grep -l "immediate\|this week\|today\|now" {} \; 2>/dev/null | \
    head -10 | while read summary; do
    PROMPT=$(grep -A2 "Initial Prompt" "$summary" 2>/dev/null | tail -1)
    echo "
    grep -E "^[0-9]+\." "$summary" | head -3 >> "$TOP_OPPS" 2>/dev/null
    echo "" >> "$TOP_OPPS"
done


echo "" >> "$TOP_OPPS"
echo "
echo "
echo "" >> "$TOP_OPPS"


find "$OUTPUT_DIR" -name "summary.md" -exec grep -l "\$[0-9]\{5,\}" {} \; 2>/dev/null | \
    head -10 | while read summary; do
    PROMPT=$(grep -A2 "Initial Prompt" "$summary" 2>/dev/null | tail -1)
    VALUE=$(grep -o "\$[0-9,]\+" "$summary" | head -1)
    echo "
    grep -E "^[0-9]+\." "$summary" | head -3 >> "$TOP_OPPS" 2>/dev/null
    echo "" >> "$TOP_OPPS"
done


echo "" >> "$TOP_OPPS"
echo "
echo "" >> "$TOP_OPPS"

find "$OUTPUT_DIR" -name "summary.md" -exec grep -l "Louisville\|Jefferson County\|502" {} \; 2>/dev/null | \
    head -10 | while read summary; do
    PROMPT=$(grep -A2 "Initial Prompt" "$summary" 2>/dev/null | tail -1)
    echo "
    grep -E "^[0-9]+\." "$summary" | grep -i "louisville\|local" | head -3 >> "$TOP_OPPS" 2>/dev/null
    echo "" >> "$TOP_OPPS"
done

echo "✅ Top opportunities extracted to: $TOP_OPPS"
echo ""
echo "============================================="
