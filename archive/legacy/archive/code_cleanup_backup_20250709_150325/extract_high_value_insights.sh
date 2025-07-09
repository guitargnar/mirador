

OUTPUT_DIR="$HOME/ai_framework_git/outputs"
INSIGHTS_DIR="$HOME/ai_framework_git/high_value_insights"

echo "============================================="
echo "HIGH-VALUE INSIGHTS EXTRACTOR"
echo "============================================="
echo ""


mkdir -p "$INSIGHTS_DIR"


extract_insights() {
    local summary="$1"
    local category="$2"
    
    if [ -f "$summary" ]; then
        
        PROMPT=$(grep -A2 "Initial Prompt" "$summary" 2>/dev/null | tail -1)
        
        
        echo "📌 PROMPT: $PROMPT" > "$INSIGHTS_DIR/temp_insight.txt"
        echo "" >> "$INSIGHTS_DIR/temp_insight.txt"
        
        
        sed -n '/Strategic.*:/,/^$/p' "$summary" >> "$INSIGHTS_DIR/temp_insight.txt" 2>/dev/null
        sed -n '/Implementation.*:/,/^$/p' "$summary" >> "$INSIGHTS_DIR/temp_insight.txt" 2>/dev/null
        sed -n '/Next Steps.*:/,/^$/p' "$summary" >> "$INSIGHTS_DIR/temp_insight.txt" 2>/dev/null
        sed -n '/Action Items.*:/,/^$/p' "$summary" >> "$INSIGHTS_DIR/temp_insight.txt" 2>/dev/null
        
        
        grep -E "^[0-9]+\." "$summary" >> "$INSIGHTS_DIR/temp_insight.txt" 2>/dev/null
        
        
        if [ -s "$INSIGHTS_DIR/temp_insight.txt" ]; then
            cat "$INSIGHTS_DIR/temp_insight.txt" >> "$INSIGHTS_DIR/${category}_insights.md"
            echo "---" >> "$INSIGHTS_DIR/${category}_insights.md"
            echo "" >> "$INSIGHTS_DIR/${category}_insights.md"
        fi
        
        rm -f "$INSIGHTS_DIR/temp_insight.txt"
    fi
}


echo "🔍 Extracting insights by category..."
echo ""


echo "💰 Processing financial insights..."
find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "financial\|income\|investment\|wealth" {} \; 2>/dev/null | while read file; do
    extract_insights "$file" "financial"
done


echo "💼 Processing career insights..."
find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "career\|job\|professional" {} \; 2>/dev/null | while read file; do
    extract_insights "$file" "career"
done


echo "🚀 Processing business insights..."
find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "business\|startup\|entrepreneur" {} \; 2>/dev/null | while read file; do
    extract_insights "$file" "business"
done


echo "🏠 Processing real estate insights..."
find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "real estate\|property\|rental" {} \; 2>/dev/null | while read file; do
    extract_insights "$file" "real_estate"
done

echo ""
echo "✅ High-value insights extracted to: $INSIGHTS_DIR"
echo ""


echo "📊 INSIGHTS SUMMARY:"
echo "==================="
for file in "$INSIGHTS_DIR"/*_insights.md; do
    if [ -f "$file" ]; then
        COUNT=$(grep -c "📌 PROMPT:" "$file" 2>/dev/null || echo "0")
        echo "$(basename $file): $COUNT insights"
    fi
done

echo ""
echo "============================================="
