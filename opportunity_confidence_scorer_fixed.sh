#!/bin/bash

echo "============================================="
echo "🎯 OPPORTUNITY CONFIDENCE SCORING SYSTEM"
echo "============================================="
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"
SCORE_REPORT="$HOME/ai_framework_git/OPPORTUNITY_SCORES_$(date +%Y%m%d).md"

# Initialize report
cat > "$SCORE_REPORT" << HEADER
# 🎯 OPPORTUNITY CONFIDENCE SCORES
Generated: $(date)

## Scoring Methodology
- Financial Metrics (0-25): ROI, dollar values, savings potential
- Implementation Feasibility (0-25): Clear steps, timeline, resources
- Local Resources (0-25): Louisville-specific advantages
- Risk Assessment (0-25): Mitigation strategies, success probability

Total Score: 0-100 (80+ = High Confidence, 60-79 = Medium, <60 = Low)

## Scored Opportunities

HEADER

# Function to score opportunities
score_opportunity() {
    local file="$1"
    local score=0
    
    # Financial metrics (check for dollar amounts, percentages, ROI)
    if grep -qE '\$[0-9]{4,}|[0-9]+%|ROI' "$file" 2>/dev/null; then
        score=$((score + 20))
    fi
    
    # Implementation details (check for steps, timeline, action items)
    if grep -qE '^[0-9]+\.|timeline|steps|action|implement' "$file" 2>/dev/null; then
        score=$((score + 20))
    fi
    
    # Local resources (Louisville-specific content)
    if grep -qiE 'louisville|jefferson|502|kentucky|local' "$file" 2>/dev/null; then
        score=$((score + 20))
    fi
    
    # Risk mitigation (check for risk discussion, mitigation)
    if grep -qiE 'risk|mitigation|challenge|consider|caveat' "$file" 2>/dev/null; then
        score=$((score + 15))
    fi
    
    # Comprehensive content (word count bonus)
    word_count=$(wc -w < "$file" 2>/dev/null || echo "0")
    if [ "$word_count" -gt 500 ]; then
        score=$((score + 15))
    fi
    
    # Actionable content (numbered lists, clear recommendations)
    if grep -qE '• |recommendation|suggest|should|could' "$file" 2>/dev/null; then
        score=$((score + 10))
    fi
    
    echo "$score"
}

# Score recent validation outputs
echo "Scoring recent opportunities..."

ls -t "$OUTPUT_DIR" | head -20 | while read dir; do
    SUMMARY="$OUTPUT_DIR/$dir/summary.md"
    if [ -f "$SUMMARY" ]; then
        SCORE=$(score_opportunity "$SUMMARY")
        PROMPT=$(grep -A2 "Initial Prompt" "$SUMMARY" 2>/dev/null | tail -1 | cut -c1-80)
        
        # Determine confidence level
        if [ "$SCORE" -ge 80 ]; then
            CONFIDENCE="✅ HIGH"
        elif [ "$SCORE" -ge 60 ]; then
            CONFIDENCE="🟡 MEDIUM"
        else
            CONFIDENCE="🔴 LOW"
        fi
        
        echo "### $PROMPT..." >> "$SCORE_REPORT"
        echo "**Score:** $SCORE/100 | **Confidence:** $CONFIDENCE" >> "$SCORE_REPORT"
        echo "**Details:** Financial($((SCORE/5))pts) Implementation($((SCORE/5))pts) Local($((SCORE/5))pts)" >> "$SCORE_REPORT"
        echo "" >> "$SCORE_REPORT"
    fi
done

echo "" >> "$SCORE_REPORT"
echo "## IMPLEMENTATION PRIORITY" >> "$SCORE_REPORT"
echo "Based on confidence scores, implement opportunities in this order:" >> "$SCORE_REPORT"
echo "1. All HIGH confidence opportunities (80+ score)" >> "$SCORE_REPORT"
echo "2. MEDIUM confidence with quick win potential" >> "$SCORE_REPORT"
echo "3. MEDIUM confidence requiring more planning" >> "$SCORE_REPORT"
echo "4. Research and refine LOW confidence opportunities" >> "$SCORE_REPORT"

echo "✅ Scoring complete. Report saved to: $SCORE_REPORT"
echo ""
echo "============================================="
