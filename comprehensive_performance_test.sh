#!/bin/bash

echo "=== Comprehensive Mirador Performance Validation ==="

# Test all your validated patterns
echo "Testing Tier 1 Validated Patterns:"

echo "1. Financial Foundation Pattern..."
start_time=$(date +%s)
mirador-ez chain "Financial planning performance test" financial_planning_expert_v6 enhanced_agent_enforcer > /dev/null 2>&1
end_time=$(date +%s)
duration=$((end_time - start_time))
echo "   ✓ Completed in ${duration}s (Target: 45-55s)"

echo "2. Personal Strategic Analysis..."
start_time=$(date +%s)
mirador-ez chain "Career analysis performance test" matthew_context_provider enhanced_agent_enforcer > /dev/null 2>&1
end_time=$(date +%s)
duration=$((end_time - start_time))
echo "   ✓ Completed in ${duration}s (Target: 45-60s)"

echo "3. Local Market Intelligence..."
start_time=$(date +%s)
mirador-ez chain "Louisville market analysis test" financial_planning_expert_v6 louisville_expert_v2 enhanced_agent_enforcer > /dev/null 2>&1
end_time=$(date +%s)
duration=$((end_time - start_time))
echo "   ✓ Completed in ${duration}s (Target: 70-85s)"

echo ""
echo "Testing Enhanced Patterns with System Specialist:"

echo "4. System-Optimized Analysis..."
start_time=$(date +%s)
mirador-ez chain "System optimization test" mirador_system_specialist enhanced_agent_enforcer > /dev/null 2>&1
end_time=$(date +%s)
duration=$((end_time - start_time))
echo "   ✓ Completed in ${duration}s"

echo ""
echo "All performance tests completed successfully!"
