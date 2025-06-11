#!/bin/bash

echo "============================================="
echo "🎯 OPPORTUNITY CONFIDENCE SCORING SYSTEM"
echo "============================================="
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"
SCORE_REPORT="$HOME/ai_framework_git/OPPORTUNITY_SCORES.md"

# Initialize scoring report
cat > "$SCORE_REPORT" << 'HEADER'
# 🎯 OPPORTUNITY CONFIDENCE SCORES
Generated: DATE_PLACEHOLDER

## Scoring Methodology
Each opportunity is scored on 5 factors (0-20 points each):
- **Financial Clarity**: Specific numbers, ROI, projections
- **Implementation Detail**: Clear steps and timeline
- **Local Advantage**: Louisville-specific benefits
- **Risk Assessment**: Identified risks and mitigation
- **Quick Win Potential**: Time to first revenue/benefit

Total Score Interpretation:
- 80-100: HIGH CONFIDENCE ✅ (Ready to implement)
- 60-79: MEDIUM CONFIDENCE 🟡 (Needs refinement)
- Below 60: LOW CONFIDENCE 🔴 (Requires more research)

---

## OPPORTUNITY SCORES

HEADER

sed -i '' "s/DATE_PLACEHOLDER/$(date)/" "$SCORE_REPORT"

# Function to score opportunity based on content
score_opportunity() {
    local summary_file="$1"
    local score=0
    
    if [ -f "$summary_file" ]; then
        # Financial Clarity (0-20)
        FINANCIAL_MENTIONS=$(grep -c "\$[0-9,]\+\|ROI\|return" "$summary_file" 2>/dev/null || echo "0")
        [ $FINANCIAL_MENTIONS -gt 10 ] && score=$((score + 20))
        [ $FINANCIAL_MENTIONS -gt 5 ] && [ $FINANCIAL_MENTIONS -le 10 ] && score=$((score + 15))
        [ $FINANCIAL_MENTIONS -gt 2 ] && [ $FINANCIAL_MENTIONS -le 5 ] && score=$((score + 10))
        [ $FINANCIAL_MENTIONS -gt 0 ] && [ $FINANCIAL_MENTIONS -le 2 ] && score=$((score + 5))
        
        # Implementation Detail (0-20)
        STEPS=$(grep -c "^[0-9]\+\." "$summary_file" 2>/dev/null || echo "0")
        [ $STEPS -gt 10 ] && score=$((score + 20))
        [ $STEPS -gt 5 ] && [ $STEPS -le 10 ] && score=$((score + 15))
        [ $STEPS -gt 2 ] && [ $STEPS -le 5 ] && score=$((score + 10))
        [ $STEPS -gt 0 ] && [ $STEPS -le 2 ] && score=$((score + 5))
        
        # Local Advantage (0-20)
        LOCAL=$(grep -c "Louisville\|Kentucky\|local" "$summary_file" 2>/dev/null || echo "0")
        [ $LOCAL -gt 8 ] && score=$((score + 20))
        [ $LOCAL -gt 4 ] && [ $LOCAL -le 8 ] && score=$((score + 15))
        [ $LOCAL -gt 2 ] && [ $LOCAL -le 4 ] && score=$((score + 10))
        [ $LOCAL -gt 0 ] && [ $LOCAL -le 2 ] && score=$((score + 5))
        
        # Risk Assessment (0-20)
        RISK=$(grep -c "risk\|mitigation\|consider\|challenge" "$summary_file" 2>/dev/null || echo "0")
        [ $RISK -gt 5 ] && score=$((score + 20))
        [ $RISK -gt 2 ] && [ $RISK -le 5 ] && score=$((score + 15))
        [ $RISK -gt 0 ] && [ $RISK -le 2 ] && score=$((score + 10))
        
        # Quick Win Potential (0-20)
        QUICK=$(grep -c "immediate\|quick\|month\|weeks" "$summary_file" 2>/dev/null || echo "0")
        [ $QUICK -gt 5 ] && score=$((score + 20))
        [ $QUICK -gt 2 ] && [ $QUICK -le 5 ] && score=$((score + 15))
        [ $QUICK -gt 0 ] && [ $QUICK -le 2 ] && score=$((score + 10))
        
        echo $score
    else
        echo 0
    fi
}

# Score recent validation outputs
echo "Scoring recent opportunities..."

ls -t "$OUTPUT_DIR" | head -20 | while read dir; do
    SUMMARY="$OUTPUT_DIR/$dir/summary.md"
    if [ -f "$SUMMARY" ]; then
        SCORE=$(score_opportunity "$SUMMARY")
        PROMPT=$(grep -A2 "Initial Prompt" "$SUMMARY" 2>/dev/null | tail -1 | cut -c1-80)
        
        # Determine confidence level
        if [ $SCORE -ge 80 ]; then
            CONFIDENCE="✅ HIGH"
        elif [ $SCORE -ge 60 ]; then
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
