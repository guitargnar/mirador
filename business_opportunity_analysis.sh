


OPPORTUNITY="$1"
if [ -z "$OPPORTUNITY" ]; then
    echo "Usage: ./business_opportunity_analysis.sh \"[opportunity description]\""
    exit 1
fi

echo "💼 BUSINESS OPPORTUNITY ANALYSIS"
echo "================================"
echo "Analyzing: $OPPORTUNITY"
echo ""


mirador-ez chain \
    "Analyze this business opportunity: $OPPORTUNITY. Include market size, competition, required investment, projected ROI, implementation timeline, and risk factors." \
    matthew_context_provider \
    financial_planning_expert_v6 \
    louisville_expert_v3 \
    opportunity_validator_v2 \
    decision_enhancer


read -p "Add to ROI tracking? (y/n): " track
if [ "$track" = "y" ]; then
    read -p "Opportunity name: " name
    read -p "Potential value: $" value
    ./track_mirador_roi.sh "$name" "$value" "planned"
fi
