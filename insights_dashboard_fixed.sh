

echo "============================================="
echo "📊 MIRADOR INSIGHTS DASHBOARD"
echo "============================================="
echo "Generated: $(date)"
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"
INSIGHTS_BASE="$HOME/ai_framework_git/actionable_insights"


echo "📈 KEY METRICS:"
echo "=============="
TOTAL_CHAINS=$(find "$OUTPUT_DIR" -type d -name "chain_*" 2>/dev/null | wc -l | tr -d ' ')
TOTAL_WORDS=$(find "$OUTPUT_DIR" -name "summary.md" -exec cat {} \; 2>/dev/null | wc -w | tr -d ' ')
RECENT_CHAINS=$(find "$OUTPUT_DIR" -type d -name "chain_*" -mtime -1 2>/dev/null | wc -l | tr -d ' ')

echo "Total chains generated: $TOTAL_CHAINS"
echo "Total words analyzed: $TOTAL_WORDS"
echo "Chains in last 24h: $RECENT_CHAINS"
echo ""


echo "🎯 DOMAIN COVERAGE:"
echo "=================="


FINANCIAL_COUNT=$(find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "financial\|money\|investment" {} \; 2>/dev/null | wc -l | tr -d ' ')
CAREER_COUNT=$(find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "career\|job\|professional" {} \; 2>/dev/null | wc -l | tr -d ' ')
BUSINESS_COUNT=$(find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "business\|startup\|entrepreneur" {} \; 2>/dev/null | wc -l | tr -d ' ')
REALESTATE_COUNT=$(find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "real estate\|property\|rental" {} \; 2>/dev/null | wc -l | tr -d ' ')
EDUCATION_COUNT=$(find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "education\|learning\|skill" {} \; 2>/dev/null | wc -l | tr -d ' ')
HEALTH_COUNT=$(find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "health\|wellness\|medical" {} \; 2>/dev/null | wc -l | tr -d ' ')
TECH_COUNT=$(find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "tech\|software\|digital" {} \; 2>/dev/null | wc -l | tr -d ' ')
LIFESTYLE_COUNT=$(find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "lifestyle\|life balance" {} \; 2>/dev/null | wc -l | tr -d ' ')

printf "%-12s: %3d chains\n" "Financial" "$FINANCIAL_COUNT"
printf "%-12s: %3d chains\n" "Career" "$CAREER_COUNT"
printf "%-12s: %3d chains\n" "Business" "$BUSINESS_COUNT"
printf "%-12s: %3d chains\n" "Real Estate" "$REALESTATE_COUNT"
printf "%-12s: %3d chains\n" "Education" "$EDUCATION_COUNT"
printf "%-12s: %3d chains\n" "Health" "$HEALTH_COUNT"
printf "%-12s: %3d chains\n" "Technology" "$TECH_COUNT"
printf "%-12s: %3d chains\n" "Lifestyle" "$LIFESTYLE_COUNT"

echo ""
echo "💰 VALUE IDENTIFICATION:"
echo "======================"

HIGH_VALUE=$(find "$OUTPUT_DIR" -name "summary.md" -exec grep -l "\$[0-9]\{6,\}" {} \; 2>/dev/null | wc -l | tr -d ' ')
MED_VALUE=$(find "$OUTPUT_DIR" -name "summary.md" -exec grep -l "\$[0-9]\{5\}" {} \; 2>/dev/null | wc -l | tr -d ' ')
echo "High-value opportunities (>$100k): $HIGH_VALUE"
echo "Medium-value opportunities ($10-100k): $MED_VALUE"
echo ""


echo "🌟 RECENT HIGH-VALUE INSIGHTS:"
echo "============================="
find "$OUTPUT_DIR" -name "summary.md" -mtime -7 -exec grep -l "\$[0-9]\{5,\}" {} \; 2>/dev/null | \
    head -5 | while read summary; do
    PROMPT=$(grep -A2 "Initial Prompt" "$summary" 2>/dev/null | tail -1 | cut -c1-80)
    echo "- $PROMPT..."
done

echo ""
echo "🎯 TOP ACTION ITEMS THIS WEEK:"
echo "============================"
find "$OUTPUT_DIR" -name "summary.md" -mtime -7 -print0 2>/dev/null | \
    xargs -0 grep -h "^1\." 2>/dev/null | head -10 | while read line; do
    echo "  $line"
done

echo ""
echo "============================================="
echo "📁 Full insights: $INSIGHTS_BASE"
echo "============================================="
