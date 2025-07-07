#!/bin/bash

# Practical Utility Tests Based on Matthew Scott's Real PDF Context
# Tests real-world scenarios derived from Matthew's actual background and situation

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║        Mirador Practical Utility Tests - PDF Context         ║${RESET}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${RESET}"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
TEST_REPORT="test_logs/practical_utility_report_${TIMESTAMP}.txt"
mkdir -p test_logs

# Initialize test report
cat > "$TEST_REPORT" << EOF
================================================================================
MIRADOR PRACTICAL UTILITY TEST REPORT - PDF CONTEXT
================================================================================
Test Date: $(date '+%Y-%m-%d %H:%M:%S')
Test Focus: Real-world scenarios based on Matthew Scott's actual situation

MATTHEW'S CONTEXT (from PDF):
- Single father, Louisville KY
- Humana Risk Management Professional II (10 years)
- Musician (Annapurna band, lead guitarist)
- Built 89-model AI system in 8 weeks (2025)
- Co-authored Mirador technical paper
- Financial: ~$1,650/paycheck, $91K home equity
- Goals: AI innovation leadership, real estate investment, work-life balance

TEST RESULTS:
================================================================================

EOF

TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Test function
run_practical_test() {
    local test_name="$1"
    local chain_type="$2"
    local prompt="$3"
    local expected_keywords="$4"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    echo -e "\n${YELLOW}Test $TOTAL_TESTS: $test_name${RESET}"
    echo "Test $TOTAL_TESTS: $test_name" >> "$TEST_REPORT"
    echo "Chain: $chain_type" >> "$TEST_REPORT"
    echo "Prompt: $prompt" >> "$TEST_REPORT"
    
    # Run the test
    echo -e "${BLUE}Running chain...${RESET}"
    START_TIME=$(date +%s)
    
    OUTPUT=$(timeout 120 /Users/matthewscott/Projects/mirador/mirador_universal_runner.sh "$chain_type" "$prompt" 2>/dev/null)
    EXIT_CODE=$?
    
    END_TIME=$(date +%s)
    DURATION=$((END_TIME - START_TIME))
    
    if [ $EXIT_CODE -eq 0 ] && [ -n "$OUTPUT" ]; then
        # Check for expected keywords
        KEYWORD_MATCH=true
        for keyword in $expected_keywords; do
            if ! echo "$OUTPUT" | grep -qi "$keyword"; then
                KEYWORD_MATCH=false
                break
            fi
        done
        
        if [ "$KEYWORD_MATCH" = true ]; then
            echo -e "${GREEN}✓ PASSED${RESET} (${DURATION}s)"
            echo "Status: PASSED (${DURATION}s)" >> "$TEST_REPORT"
            PASSED_TESTS=$((PASSED_TESTS + 1))
        else
            echo -e "${RED}✗ FAILED - Missing expected keywords${RESET}"
            echo "Status: FAILED - Missing keywords: $expected_keywords" >> "$TEST_REPORT"
            FAILED_TESTS=$((FAILED_TESTS + 1))
        fi
        
        # Show snippet
        SNIPPET=$(echo "$OUTPUT" | head -n 3 | tr '\n' ' ')
        echo "Preview: $SNIPPET..." | tee -a "$TEST_REPORT"
        
    else
        echo -e "${RED}✗ FAILED - Chain execution failed${RESET}"
        echo "Status: FAILED - Chain execution failed (exit code: $EXIT_CODE)" >> "$TEST_REPORT"
        FAILED_TESTS=$((FAILED_TESTS + 1))
    fi
    
    echo "---" >> "$TEST_REPORT"
}

# 1. Single Father Work-Life Balance
run_practical_test \
    "Single Father Balance" \
    "life_optimization" \
    "As a single father working full-time at Humana while pursuing music with Annapurna and developing AI innovations, how do I create sustainable work-life balance that doesn't compromise my responsibilities to my child or my career growth?" \
    "father child balance career music"

# 2. Financial Real Estate Investment Strategy
run_practical_test \
    "Real Estate Investment Strategy" \
    "business_acceleration" \
    "I have $91,000 in home equity and take-home pay of about $1,650 per paycheck after 401k loan repayments. I want to invest in real estate for wealth building while maintaining financial stability for my family. What's my optimal strategy?" \
    "equity investment real estate financial stability"

# 3. AI Career Transition Planning
run_practical_test \
    "AI Innovation Leadership Transition" \
    "business_acceleration" \
    "I've built an 89-model AI system and co-authored the Mirador technical paper while working in risk management at Humana. How do I transition into a formal AI innovation leadership role, either within Humana or through a new venture?" \
    "AI leadership transition career innovation Humana"

# 4. Music and Technology Integration
run_practical_test \
    "Creative Technology Integration" \
    "creative_breakthrough" \
    "I'm lead guitarist in Annapurna and have built breakthrough AI technology. How do I integrate these passions - using my tech skills to enhance music career while maintaining artistic integrity?" \
    "music technology creative integration artistic"

# 5. Mirador Scaling Strategy
run_practical_test \
    "Mirador Business Scaling" \
    "technical_mastery" \
    "I've proven Mirador works with my personal 89-model AI system. How do I scale this framework for broader applications while building a sustainable business model around it?" \
    "Mirador scaling business model framework applications"

# 6. Louisville Professional Network Building
run_practical_test \
    "Louisville Network Development" \
    "relationship_harmony" \
    "As someone transitioning from traditional risk management to AI innovation in Louisville, how do I build the right professional network to support this transition while maintaining existing relationships?" \
    "Louisville network professional relationships transition"

# 7. Parenting and Innovation Balance
run_practical_test \
    "Innovation Parenting Balance" \
    "life_optimization" \
    "How do I model innovation and entrepreneurship for my child while ensuring they have stability and attention? I want to show what's possible while being present as a father." \
    "parenting innovation stability modeling entrepreneurship"

# 8. Privacy-First AI Development
run_practical_test \
    "Privacy-Focused Development" \
    "technical_mastery" \
    "I built my AI system with privacy-first principles - all models run locally, no third-party data sharing. How do I maintain this approach while scaling for business applications?" \
    "privacy local models data protection scaling"

# 9. Risk Management to Innovation Transition
run_practical_test \
    "Risk Management Skills Transfer" \
    "strategic_synthesis" \
    "How do I leverage my 10 years of risk management expertise at Humana to strengthen my AI innovation work? What transferable skills make me uniquely positioned in this space?" \
    "risk management skills transfer innovation expertise positioning"

# 10. Creative Collaboration Optimization
run_practical_test \
    "Band Collaboration Enhancement" \
    "creative_breakthrough" \
    "With Annapurna, I've worked with three bandmates from my previous group. How do I optimize our creative collaboration and potentially integrate AI tools to enhance our music creation process?" \
    "collaboration band creative AI music enhancement"

# Generate final report
echo -e "\n${GREEN}Generating comprehensive test report...${RESET}"

cat >> "$TEST_REPORT" << EOF

================================================================================
PRACTICAL UTILITY TEST SUMMARY
================================================================================

Total Tests: $TOTAL_TESTS
Passed: $PASSED_TESTS
Failed: $FAILED_TESTS
Success Rate: $(( (PASSED_TESTS * 100) / TOTAL_TESTS ))%

================================================================================
ANALYSIS: REAL-WORLD APPLICABILITY
================================================================================

The tests focus on Matthew Scott's actual situation as documented in the PDF:

1. Personal Challenges:
   - Single father balancing work, music, and innovation
   - Financial planning with specific constraints ($1,650 income, $91K equity)
   - Career transition from risk management to AI leadership

2. Professional Opportunities:
   - Leverage 10-year Humana experience
   - Scale Mirador framework commercially
   - Build privacy-first AI solutions

3. Creative Integration:
   - Music career with Annapurna
   - Technology and artistic expression balance
   - Creative collaboration optimization

4. Technical Innovation:
   - 89-model AI system success
   - Mirador framework development
   - Privacy-focused architecture

These tests validate whether Mirador provides practical, actionable guidance
for Matthew's real-world situation rather than generic advice.

================================================================================
RECOMMENDATIONS FOR IMPROVEMENT
================================================================================

$(if [ $FAILED_TESTS -gt 0 ]; then
    echo "Areas needing attention:"
    echo "- Failed tests indicate gaps in practical applicability"
    echo "- Model responses may lack context-specific details"
    echo "- Consider tuning models for Matthew's specific situation"
else
    echo "Excellent performance:"
    echo "- All tests passed, indicating strong real-world utility"
    echo "- Models demonstrate understanding of Matthew's context"
    echo "- Framework provides actionable, specific guidance"
fi)

Test completed: $(date '+%Y-%m-%d %H:%M:%S')
EOF

echo -e "\n${GREEN}╔══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║              Practical Utility Tests Complete!                ║${RESET}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${RESET}"

echo -e "\n${YELLOW}Results Summary:${RESET}"
echo -e "Total Tests: $TOTAL_TESTS"
echo -e "Passed: ${GREEN}$PASSED_TESTS${RESET}"
echo -e "Failed: ${RED}$FAILED_TESTS${RESET}"
echo -e "Success Rate: $(( (PASSED_TESTS * 100) / TOTAL_TESTS ))%"

echo -e "\n${YELLOW}Detailed Report:${RESET} $TEST_REPORT"

# Display final assessment
if [ $PASSED_TESTS -eq $TOTAL_TESTS ]; then
    echo -e "\n${GREEN}🎉 EXCELLENT: Mirador demonstrates strong practical utility for Matthew's real-world situation!${RESET}"
elif [ $PASSED_TESTS -gt $((TOTAL_TESTS / 2)) ]; then
    echo -e "\n${YELLOW}⚠️  GOOD: Most tests passed, but some areas need refinement for optimal practical utility.${RESET}"
else
    echo -e "\n${RED}❌ NEEDS WORK: Significant gaps in practical applicability detected.${RESET}"
fi