#!/bin/bash
REPORT_FILE="mirador_health_report_$(date +%Y%m%d_%H%M%S).md"

cat > "$REPORT_FILE" << 'REPORT'
# Mirador System Health Report

**Generated:** $(date)
**System:** $(uname -a)

## Model Status
$(ollama list | grep -E "(financial|enhanced|louisville|matthew|mirador)")

## Recent Activity
- Total Outputs: $(ls outputs/ 2>/dev/null | wc -l | tr -d ' ')
- Latest Chain: $(ls -t outputs/ 2>/dev/null | head -1)
- Git Status: $(git status --porcelain | wc -l | tr -d ' ') uncommitted changes

## Performance Metrics
$(./test_mirador_performance.sh 2>&1)

## Known Issues
1. Enhanced agent timeout issues
2. Model base optimization needed (llama3.2 → llama3.2_balanced)
3. Output directory management

## Recommendations
1. Implement timeout wrapper for all model calls
2. Migrate to llama3.2_balanced base
3. Add automated output archival
4. Implement proper error recovery
REPORT

echo "Health report generated: $REPORT_FILE"
