#!/bin/bash

echo "=== WEEKLY PERSONALITY-ALIGNED OPTIMIZATION ==="
echo "Date: $(date)"
echo

# Run personality-aligned opportunity scan
echo "Running Creative Opportunity Scan (High Openness)..."
mirador-ez chain "What creative, innovative opportunities exist this week that align with my values and could help others while supporting my family?" \
matthew_context_provider_v2 mirador_system_specialist_v2 louisville_expert_v3 enhanced_agent_enforcer decision_simplifier

# Save results
OUTPUT_DIR="weekly_reports/$(date +%Y%m%d)_personality_optimized"
mkdir -p "$OUTPUT_DIR"
cp outputs/latest/* "$OUTPUT_DIR/"

echo "Results saved to $OUTPUT_DIR"
