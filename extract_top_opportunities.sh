#!/bin/bash

echo "============================================="
echo "🏆 TOP MIRADOR OPPORTUNITIES EXTRACTION"
echo "============================================="
echo "Generated: $(date)"
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"
TOP_OPPS="$HOME/ai_framework_git/TOP_OPPORTUNITIES.md"

# Initialize the report
cat > "$TOP_OPPS" << 'HEADER'
# 🏆 TOP MIRADOR OPPORTUNITIES
Generated: DATE_PLACEHOLDER

Based on analysis of 128 chains generating 125,636 words of insights.

## 🎯 IMMEDIATE ACTION OPPORTUNITIES
### (Can start this week with minimal investment)

HEADER

sed -i '' "s/DATE_PLACEHOLDER/$(date)/" "$TOP_OPPS"

# Extract immediate opportunities
echo "🔍 Extracting immediate opportunities..."
find "$OUTPUT_DIR" -name "summary.md" -exec grep -l "immediate\|this week\|today\|now" {} \; 2>/dev/null | \
    head -10 | while read summary; do
    PROMPT=$(grep -A2 "Initial Prompt" "$summary" 2>/dev/null | tail -1)
    echo "#### $PROMPT" >> "$TOP_OPPS"
    grep -E "^[0-9]+\." "$summary" | head -3 >> "$TOP_OPPS" 2>/dev/null
    echo "" >> "$TOP_OPPS"
done

# Add high-value opportunities section
echo "" >> "$TOP_OPPS"
echo "## 💰 HIGH-VALUE OPPORTUNITIES" >> "$TOP_OPPS"
echo "### (Potential value >$10,000)" >> "$TOP_OPPS"
echo "" >> "$TOP_OPPS"

# Extract high-value opportunities
find "$OUTPUT_DIR" -name "summary.md" -exec grep -l "\$[0-9]\{5,\}" {} \; 2>/dev/null | \
    head -10 | while read summary; do
    PROMPT=$(grep -A2 "Initial Prompt" "$summary" 2>/dev/null | tail -1)
    VALUE=$(grep -o "\$[0-9,]\+" "$summary" | head -1)
    echo "#### $PROMPT (Potential: $VALUE)" >> "$TOP_OPPS"
    grep -E "^[0-9]+\." "$summary" | head -3 >> "$TOP_OPPS" 2>/dev/null
    echo "" >> "$TOP_OPPS"
done

# Add Louisville-specific opportunities
echo "" >> "$TOP_OPPS"
echo "## 📍 LOUISVILLE-SPECIFIC OPPORTUNITIES" >> "$TOP_OPPS"
echo "" >> "$TOP_OPPS"

find "$OUTPUT_DIR" -name "summary.md" -exec grep -l "Louisville\|Jefferson County\|502" {} \; 2>/dev/null | \
    head -10 | while read summary; do
    PROMPT=$(grep -A2 "Initial Prompt" "$summary" 2>/dev/null | tail -1)
    echo "#### $PROMPT" >> "$TOP_OPPS"
    grep -E "^[0-9]+\." "$summary" | grep -i "louisville\|local" | head -3 >> "$TOP_OPPS" 2>/dev/null
    echo "" >> "$TOP_OPPS"
done

echo "✅ Top opportunities extracted to: $TOP_OPPS"
echo ""
echo "============================================="
