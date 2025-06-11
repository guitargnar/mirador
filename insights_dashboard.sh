#!/bin/bash

echo "============================================="
echo "📊 MIRADOR INSIGHTS DASHBOARD"
echo "============================================="
echo "Generated: $(date)"
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"
INSIGHTS_BASE="$HOME/ai_framework_git/actionable_insights"

# Key metrics
echo "📈 KEY METRICS:"
echo "=============="
TOTAL_CHAINS=$(find "$OUTPUT_DIR" -type d -name "chain_*" 2>/dev/null | wc -l)
TOTAL_WORDS=$(find "$OUTPUT_DIR" -name "summary.md" -exec cat {} \; 2>/dev/null | wc -w)
RECENT_CHAINS=$(find "$OUTPUT_DIR" -type d -name "chain_*" -mtime -1 2>/dev/null | wc -l)

echo "Total chains generated: $TOTAL_CHAINS"
echo "Total words analyzed: $TOTAL_WORDS"
echo "Chains in last 24h: $RECENT_CHAINS"
echo ""

# Domain coverage
echo "🎯 DOMAIN COVERAGE:"
echo "=================="
declare -A domains=(
    ["Financial"]="financial\|money\|investment"
    ["Career"]="career\|job\|professional"
    ["Business"]="business\|startup\|entrepreneur"
    ["Real Estate"]="real estate\|property\|rental"
    ["Education"]="education\|learning\|skill"
    ["Health"]="health\|wellness\|medical"
    ["Technology"]="tech\|software\|digital"
    ["Lifestyle"]="lifestyle\|life balance"
)

for domain in "${!domains[@]}"; do
    pattern="${domains[$domain]}"
    count=$(find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "$pattern" {} \; 2>/dev/null | wc -l)
    printf "%-12s: %3d chains\n" "$domain" "$count"
done

echo ""
echo "💰 VALUE IDENTIFICATION:"
echo "======================"
# Count specific value mentions
HIGH_VALUE=$(find "$OUTPUT_DIR" -name "summary.md" -exec grep -l "\$[0-9]\{6,\}" {} \; 2>/dev/null | wc -l)
MED_VALUE=$(find "$OUTPUT_DIR" -name "summary.md" -exec grep -l "\$[0-9]\{5\}" {} \; 2>/dev/null | wc -l)
echo "High-value opportunities (>$100k): $HIGH_VALUE"
echo "Medium-value opportunities ($10-100k): $MED_VALUE"
echo ""

# Recent high-value insights
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
    xargs -0 grep -h "^1\." | head -10 | while read line; do
    echo "  $line"
done

echo ""
echo "============================================="
echo "📁 Full insights: $INSIGHTS_BASE"
echo "============================================="
