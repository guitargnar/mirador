#!/bin/bash

echo "=== Quick Daily Opportunity Scan ==="
echo "Generated: $(date)"
echo ""

# Run the personality-aware opportunity chain
mirador-ez chain "Based on my personality profile (High Openness, Musical goals, Louisville location), identify my TOP 3 opportunities for today with specific actions" \
    matthew_context_provider_v3 \
    louisville_expert_v3 \
    enhanced_agent_enforcer \
    decision_simplifier

# Save to daily log
OUTPUT_DIR="outputs/daily_opportunities"
mkdir -p "$OUTPUT_DIR"
FILENAME="$OUTPUT_DIR/opportunities_$(date +%Y%m%d).md"
echo "Saved to: $FILENAME"
