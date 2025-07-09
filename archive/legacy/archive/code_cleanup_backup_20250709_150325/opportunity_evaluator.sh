



OPPORTUNITY="$1"
OUTPUT_DIR="$HOME/ai_framework_git/opportunities/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTPUT_DIR"

echo "=== MIRADOR OPPORTUNITY EVALUATOR ==="
echo "Evaluating: $OPPORTUNITY"
echo ""


echo "Step 1: Generating opportunity ideas..."
mirador-ez ask creative_entrepreneur "$OPPORTUNITY - identify specific business/financial opportunities" > "$OUTPUT_DIR/01_opportunities.md"


echo "Step 2: Analyzing Louisville market context..."
mirador-ez ask louisville_expert_v2 "Analyze local Louisville market for: $(cat $OUTPUT_DIR/01_opportunities.md | head -20)" > "$OUTPUT_DIR/02_local_analysis.md"


echo "Step 3: Assessing financial viability..."
mirador-ez ask financial_planning_expert_v5 "Evaluate financial viability and requirements for: $(cat $OUTPUT_DIR/01_opportunities.md | head -20)" > "$OUTPUT_DIR/03_financial_analysis.md"


echo "Step 4: Creating strategic action plan..."
mirador-ez chain "Create actionable implementation plan based on these analyses" enhanced_agent_fast_v3 master_coder > "$OUTPUT_DIR/04_action_plan.md"


cat > "$OUTPUT_DIR/OPPORTUNITY_SUMMARY.md" << SUMMARY

Date: $(date)
Opportunity: $OPPORTUNITY


$(grep -A 5 "Key\|Important\|Critical" $OUTPUT_DIR/*.md 2>/dev/null | head -20)


- Market Viability: [Review 02_local_analysis.md]
- Financial Feasibility: [Review 03_financial_analysis.md]
- Implementation Clarity: [Review 04_action_plan.md]


Review individual analyses in this directory for detailed insights.
SUMMARY

echo ""
echo "=== EVALUATION COMPLETE ==="
echo "Results saved to: $OUTPUT_DIR"
echo "Summary: $OUTPUT_DIR/OPPORTUNITY_SUMMARY.md"
