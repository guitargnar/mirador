# Quality Assessment Commands for Mirador Chain Output

## Based on your screenshots, here are the commands to analyze the quality:

## 1. View the Final Summary (Most Important)
```bash
cat ~/ai_framework_git/outputs/chain_20250605_124444/summary.md
```

## 2. Examine Individual Model Contributions
```bash
# View the financial planning expert's output (552 words)
cat ~/ai_framework_git/outputs/chain_20250605_124444/step1_output.txt

# View the enhanced_agent_fast's contribution
cat ~/ai_framework_git/outputs/chain_20250605_124444/step2_output.txt
```

## 3. Check the Chain Transition Quality
```bash
# See how well the handoff worked between models
cat ~/ai_framework_git/outputs/chain_20250605_124444/step1_prompt.txt
cat ~/ai_framework_git/outputs/chain_20250605_124444/step2_prompt.txt
```

## 4. Analyze Content Quality Metrics
```bash
# Count words and lines in each output
echo "=== FINANCIAL PLANNING EXPERT OUTPUT ==="
wc -w ~/ai_framework_git/outputs/chain_20250605_124444/step1_output.txt
echo ""
echo "=== ENHANCED AGENT FAST OUTPUT ==="
wc -w ~/ai_framework_git/outputs/chain_20250605_124444/step2_output.txt
echo ""
echo "=== FINAL SUMMARY ==="
wc -w ~/ai_framework_git/outputs/chain_20250605_124444/summary.md
```

## 5. Test Louisville-Specific Knowledge Quality
```bash
# Test the financial expert's Louisville knowledge
mirador-ez ask financial_planning_expert "What are the specific tax advantages for Louisville homeowners in Jefferson County?"

# Test the Louisville expert (if it's working now)
mirador-ez ask louisville_expert "What are the best neighborhoods in Louisville for families with school-age children?"
```

## 6. Test Chain Performance vs. Previous Issues
```bash
# Run a quick chain to test timeout improvements
mirador-ez chain "Create emergency fund strategy for Louisville teacher" financial_planning_expert enhanced_agent_fast
```

## 7. Compare Output Quality - Before vs. After
```bash
# Check if enhanced_agent_fast is actually faster
time mirador-ez ask enhanced_agent_fast "Analyze the pros and cons of 15-year vs 30-year mortgages for Louisville buyers"

# Compare with original enhanced_agent
time mirador-ez ask enhanced_agent "Analyze the pros and cons of 15-year vs 30-year mortgages for Louisville buyers"
```

## 8. Verify All New Models Are Working
```bash
# Quick test of all three new models
echo "Testing financial_planning_expert..."
mirador-ez ask financial_planning_expert "Quick budget tip for Louisville families"

echo "Testing enhanced_agent_fast..."
mirador-ez ask enhanced_agent_fast "Quick analysis of remote work trends"

echo "Testing louisville_expert..."
mirador-ez ask louisville_expert "Best local resource for new residents"
```

## 9. Advanced Chain Testing
```bash
# Test a 3-model chain for comprehensive output
mirador-ez chain "Complete financial and local integration plan for new Louisville resident" financial_planning_expert louisville_expert enhanced_agent_fast
```

## 10. Output Organization Check
```bash
# See how outputs are being categorized
ls -la ~/ai_framework_git/outputs/
echo ""
echo "Latest chain contents:"
ls -la ~/ai_framework_git/outputs/chain_20250605_124444/
```

## Key Success Indicators to Look For:

1. **No Timeouts**: enhanced_agent_fast should complete without 120-second timeouts
2. **Louisville-Specific Content**: Financial advice should mention Kentucky taxes, local resources
3. **Substantial Content**: Each model should contribute meaningful content (200+ words)
4. **Good Handoffs**: Step 2 should build on Step 1's output effectively
5. **Practical Advice**: Output should be actionable, not just theoretical

## Most Important Command First:
Start with this one to see the overall quality:
```bash
cat ~/ai_framework_git/outputs/chain_20250605_124444/summary.md
```

This will show you the synthesized result of both models working together!

