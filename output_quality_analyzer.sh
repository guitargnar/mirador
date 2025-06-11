#!/bin/bash

echo "============================================="
echo "MIRADOR OUTPUT QUALITY ANALYZER"
echo "============================================="
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"

# Function to analyze a single output
analyze_output() {
    local dir="$1"
    local summary="$dir/summary.md"
    
    if [ -f "$summary" ]; then
        # Extract metrics
        WORD_COUNT=$(wc -w < "$summary" 2>/dev/null || echo "0")
        LINE_COUNT=$(wc -l < "$summary" 2>/dev/null || echo "0")
        
        # Count specific value indicators
        ACTION_ITEMS=$(grep -cE "^[0-9]+\.|^[-*]" "$summary" 2>/dev/null || echo "0")
        DOLLAR_AMOUNTS=$(grep -cE "\$[0-9,]+" "$summary" 2>/dev/null || echo "0")
        PERCENTAGES=$(grep -cE "[0-9]+%" "$summary" 2>/dev/null || echo "0")
        
        # Extract prompt
        PROMPT=$(grep -A2 "Initial Prompt" "$summary" 2>/dev/null | tail -1 | cut -c1-60)
        
        echo "$dir|$WORD_COUNT|$ACTION_ITEMS|$DOLLAR_AMOUNTS|$PERCENTAGES|$PROMPT"
    fi
}

# Analyze recent outputs
echo "🔍 ANALYZING RECENT OUTPUTS (Last 50):"
echo "====================================="
echo ""
echo "Directory|Words|Actions|$Amounts|%s|Prompt"
echo "---------|-----|-------|--------|---|------"

find "$OUTPUT_DIR" -type d -name "chain_*" -print0 2>/dev/null | \
    xargs -0 ls -dt | head -50 | while read dir; do
    analyze_output "$dir"
done | column -t -s '|'

echo ""
echo "📊 AGGREGATE METRICS:"
echo "===================="

# Calculate totals
TOTAL_WORDS=$(find "$OUTPUT_DIR" -name "summary.md" -exec cat {} \; 2>/dev/null | wc -w)
TOTAL_CHAINS=$(find "$OUTPUT_DIR" -type d -name "chain_*" 2>/dev/null | wc -l)
AVG_WORDS=$((TOTAL_WORDS / TOTAL_CHAINS))

echo "Total chains analyzed: $TOTAL_CHAINS"
echo "Total words generated: $TOTAL_WORDS"
echo "Average words per chain: $AVG_WORDS"

echo ""
echo "🏆 HIGH-VALUE OUTPUTS (1000+ words):"
echo "==================================="
find "$OUTPUT_DIR" -name "summary.md" -exec sh -c 'wc -w "$1" | awk "\$1 > 1000 {print \$1 \" words: \" \"$1\"}"' _ {} \; 2>/dev/null | sort -rn | head -10

echo ""
echo "============================================="
