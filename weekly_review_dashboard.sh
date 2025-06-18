

echo "============================================="
echo "📊 MIRADOR WEEKLY REVIEW DASHBOARD"
echo "============================================="
echo "Week of: $(date)"
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"
REVIEW="$HOME/ai_framework_git/WEEKLY_REVIEW_$(date +%Y%m%d).md"


cat > "$REVIEW" << 'HEADER'

Week Ending: DATE_PLACEHOLDER



HEADER

sed -i '' "s/DATE_PLACEHOLDER/$(date)/" "$REVIEW"


CHAINS_THIS_WEEK=$(find "$OUTPUT_DIR" -type d -name "chain_*" -mtime -7 2>/dev/null | wc -l | tr -d ' ')
WORDS_THIS_WEEK=$(find "$OUTPUT_DIR" -name "summary.md" -mtime -7 -exec cat {} \; 2>/dev/null | wc -w | tr -d ' ')

cat >> "$REVIEW" << METRICS

- Chains Generated: $CHAINS_THIS_WEEK
- Words Analyzed: $WORDS_THIS_WEEK
- Average Words/Chain: $((WORDS_THIS_WEEK / CHAINS_THIS_WEEK))



METRICS


find "$OUTPUT_DIR" -name "summary.md" -mtime -7 2>/dev/null | head -5 | while read summary; do
    PROMPT=$(grep -A2 "Initial Prompt" "$summary" 2>/dev/null | tail -1)
    echo "
    grep -E "^1\." "$summary" | head -1 >> "$REVIEW" 2>/dev/null
    echo "" >> "$REVIEW"
done


cat >> "$REVIEW" << 'ACTIONS'




1. 
2. 
3. 


1. 
2. 
3. 


1. 
2. 







ACTIONS

echo "✅ Weekly review created at: $REVIEW"
echo ""


echo "📊 QUICK SUMMARY:"
echo "================"
echo "Chains this week: $CHAINS_THIS_WEEK"
echo "Total insights generated: $(find "$OUTPUT_DIR" -name "summary.md" -mtime -7 -exec grep -c "^[0-9]+\." {} \; 2>/dev/null | awk '{sum+=$1} END {print sum}')"
echo "High-value opportunities: $(find "$OUTPUT_DIR" -name "summary.md" -mtime -7 -exec grep -l "\$[0-9]\{5,\}" {} \; 2>/dev/null | wc -l | tr -d ' ')"
echo ""
echo "============================================="
