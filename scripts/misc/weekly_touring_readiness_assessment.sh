#!/bin/bash

echo "=== Weekly Touring Readiness Assessment ==="
echo "Week of: $(date '+%B %d, %Y')"
echo ""

cd ~/ai_framework_git

# Comprehensive readiness check
mirador-ez chain "Assess my current touring readiness and next steps" \
  matthew_context_provider_v2 \
  master_guitar_instructor \
  guitar_tone_architect \
  touring_readiness_coach \
  performance_anxiety_coach \
  music_career_timeline_strategist \
  feedback_loop_optimizer_fixed \
  decision_simplifier_v2

echo ""
echo "Assessment complete. Your touring dream is getting closer! 🚌🎸"
