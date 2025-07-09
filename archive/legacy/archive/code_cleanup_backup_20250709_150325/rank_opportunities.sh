

echo "============================================="
echo "MIRADOR OPPORTUNITY RANKER"
echo "============================================="
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"
RANKED_FILE="$HOME/ai_framework_git/ranked_opportunities.md"


cat > "$RANKED_FILE" << 'HEADER'

Generated: DATE_PLACEHOLDER


- Specific dollar amounts mentioned
- Clear action items provided
- Timeline/milestone included
- Local (Louisville) relevance
- Multiple domain integration

---

HEADER

sed -i '' "s/DATE_PLACEHOLDER/$(date)/" "$RANKED_FILE"


score_opportunity() {
    local summary="$1"
    local score=0
    
    if [ -f "$summary" ]; then
        
        [ $(grep -c "\$[0-9,]\+" "$summary" 2>/dev/null) -gt 0 ] && ((score+=10))
        [ $(grep -c "^[0-9]\+\." "$summary" 2>/dev/null) -gt 3 ] && ((score+=10))
        [ $(grep -ci "timeline\|month\|year\|week" "$summary" 2>/dev/null) -gt 0 ] && ((score+=5))
        [ $(grep -ci "louisville\|kentucky\|502" "$summary" 2>/dev/null) -gt 0 ] && ((score+=5))
        [ $(grep -c "models used" "$summary" 2>/dev/null) -gt 2 ] && ((score+=5))
        [ $(wc -w < "$summary" 2>/dev/null) -gt 1000 ] && ((score+=10))
        
        echo "$score|$summary"
    fi
}


echo "🔍 Scoring opportunities..."
TEMP_SCORES="/tmp/mirador_scores.txt"
> "$TEMP_SCORES"

find "$OUTPUT_DIR" -name "summary.md" -print0 2>/dev/null | while IFS= read -r -d '' summary; do
    score_opportunity "$summary" >> "$TEMP_SCORES"
done


echo ""
echo "🏆 TOP 20 OPPORTUNITIES:"
echo "======================="

sort -t'|' -k1 -nr "$TEMP_SCORES" | head -20 | while IFS='|' read score summary; do
    if [ -f "$summary" ]; then
        PROMPT=$(grep -A2 "Initial Prompt" "$summary" 2>/dev/null | tail -1)
        DIR=$(dirname "$summary")
        
        echo "
        echo "**Prompt:** $PROMPT" >> "$RANKED_FILE"
        echo "**Location:** $DIR" >> "$RANKED_FILE"
        echo "" >> "$RANKED_FILE"
        
        
        echo "
        grep -E "^[0-9]+\." "$summary" | head -5 >> "$RANKED_FILE" 2>/dev/null
        echo "" >> "$RANKED_FILE"
        echo "---" >> "$RANKED_FILE"
        echo "" >> "$RANKED_FILE"
        
        echo "✅ Score $score: $PROMPT"
    fi
done

rm -f "$TEMP_SCORES"

echo ""
echo "📄 Full ranked list saved to: $RANKED_FILE"
echo ""
echo "============================================="
