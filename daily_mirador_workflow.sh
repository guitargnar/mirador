#!/bin/bash

echo "=== Mirador Daily Workflow ==="
echo "Starting at: $(date)"
echo ""

# 1. System Health Check
echo "1️⃣ SYSTEM HEALTH CHECK"
./daily_check_enhanced.sh
echo ""

# 2. Morning Opportunity Scan
echo "2️⃣ MORNING OPPORTUNITY SCAN"
./quick_opportunity.sh
echo ""

# 3. Financial Check (if Monday)
if [ $(date +%u) -eq 1 ]; then
    echo "3️⃣ WEEKLY FINANCIAL REVIEW (Monday)"
    mirador-ez chain "Review my financial position and identify optimization opportunities for the week" \
        matthew_context_provider_v3 \
        financial_planning_expert_v8 \
        decision_simplifier
    echo ""
fi

# 4. Music Career Check (if Wednesday)
if [ $(date +%u) -eq 3 ]; then
    echo "3️⃣ MUSIC CAREER PROGRESS (Wednesday)"
    mirador-ez chain "Evaluate my progress toward touring guitarist goals and next steps" \
        matthew_context_provider_v3 \
        music_industry_networker \
        touring_readiness_coach
    echo ""
fi

# 5. Save daily summary
SUMMARY_DIR="outputs/daily_summaries"
mkdir -p "$SUMMARY_DIR"
SUMMARY_FILE="$SUMMARY_DIR/summary_$(date +%Y%m%d).md"

cat > "$SUMMARY_FILE" << SUMMARY
# Daily Mirador Summary
Date: $(date)

## Outputs Generated Today
$(ls -la outputs/chain_$(date +%Y%m%d)* 2>/dev/null | wc -l) chains run

## Key Insights
See individual chain outputs for details.

## Tomorrow's Focus
Run: ./daily_mirador_workflow.sh
SUMMARY

echo "✅ Daily workflow complete!"
echo "📄 Summary saved to: $SUMMARY_FILE"
