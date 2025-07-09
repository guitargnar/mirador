

echo "=== MONTHLY PERSONALITY-ALIGNED REVIEW ==="
echo "Date: $(date)"
echo

echo "1. Reviewing implemented opportunities..."
cat opportunity_implementation_tracker.md

echo -e "\n2. Analyzing alignment with personality profile..."
mirador-ez chain "Review my progress this month and suggest adjustments based on my personality profile" \
matthew_context_provider_v2 mirador_system_specialist_v2 enhanced_agent_enforcer decision_simplifier

echo -e "\n3. Setting next month's focus..."
mirador-ez chain "What should be my top 3 priorities next month given my strengths and current situation?" \
matthew_context_provider_v2 financial_planning_expert_v6 louisville_expert_v3 decision_simplifier


REVIEW_DIR="monthly_reviews/$(date +%Y%m)"
mkdir -p "$REVIEW_DIR"
cp outputs/latest/* "$REVIEW_DIR/"

echo -e "\nReview complete. Results saved to $REVIEW_DIR"
