#!/bin/bash

echo "DECISION TRACKING LOG" >> ~/ai_framework_git/decision_log.md
echo "Date: $(date)" >> ~/ai_framework_git/decision_log.md
echo "Chain: $1" >> ~/ai_framework_git/decision_log.md
echo "Decision: $2" >> ~/ai_framework_git/decision_log.md
echo "Expected Outcome: $3" >> ~/ai_framework_git/decision_log.md
echo "Review Date: $(date -d '+30 days')" >> ~/ai_framework_git/decision_log.md
echo "---" >> ~/ai_framework_git/decision_log.md
