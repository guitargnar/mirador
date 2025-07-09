

echo "============================================="
echo "🚀 MIRADOR TEST CHAIN EXECUTION SUITE"
echo "============================================="
echo "Started: $(date)"
echo ""

LOG_FILE="$HOME/ai_framework_git/test_chains_$(date +%Y%m%d_%H%M%S).log"


run_test_chain() {
    local description="$1"
    local chain_command="$2"
    
    echo "🔄 Running: $description" | tee -a "$LOG_FILE"
    echo "Command: $chain_command" | tee -a "$LOG_FILE"
    echo "---" | tee -a "$LOG_FILE"
    
    
    eval "$chain_command" 2>&1 | tee -a "$LOG_FILE"
    
    echo -e "\n✅ Completed: $description\n" | tee -a "$LOG_FILE"
    sleep 5  
}


echo "📊 DEEP-DIVE IMPLEMENTATION CHAINS" | tee -a "$LOG_FILE"
echo "=================================" | tee -a "$LOG_FILE"

run_test_chain "Tech Consulting Niche Analysis" \
    'mirador-ez chain "Identify most profitable tech consulting niche in Louisville: AI/ML, cloud, or cybersecurity" financial_planning_expert_v5 louisville_expert_v2 enhanced_agent_fast_v6'



echo ""
echo "============================================="
echo "✅ TEST CHAIN EXECUTION COMPLETE"
echo "Log saved to: $LOG_FILE"
echo "============================================="
