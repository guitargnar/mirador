# Opportunity Scoring Report
Date: $(date)
Opportunity: $OPPORTUNITY

## Executive Summary
This report evaluates the opportunity across 5 key dimensions with quantitative scoring.

## Scoring Matrix (1-10 scale)

### 1. Market Potential Score: [Review 01_market_analysis.md]
- Target Market Size: _/10
- Revenue Potential: _/10
- Competition Level: _/10
- Unique Value: _/10

### 2. Local Viability Score: [Review 02_louisville_analysis.md]
- Local Demand: _/10
- Resource Availability: _/10
- Regulatory Ease: _/10
- Local Advantage: _/10

### 3. Financial Feasibility Score: [Review 03_financial_projections.md]
- Startup Cost Reasonableness: _/10
- Time to Break-even: _/10
- Profit Margins: _/10
- ROI Potential: _/10

### 4. Implementation Clarity Score: [Review 04_implementation_roadmap.md]
- Task Specificity: _/10
- Resource Accessibility: _/10
- Timeline Realism: _/10
- Success Metrics: _/10

### 5. Risk Profile Score: [Review 05_risk_analysis.md]
- Risk Severity: _/10
- Mitigation Feasibility: _/10
- Failure Recovery: _/10
- Overall Risk Level: _/10

## Overall Opportunity Score: _/50

## Go/No-Go Recommendation
[ ] GO - Score 35+ with no critical weaknesses
[ ] CONDITIONAL GO - Score 25-34, address weaknesses first
[ ] NO GO - Score below 25 or critical flaws identified

## Key Success Factors
$(grep -i "success\|critical\|key\|important" $OUTPUT_DIR/*.md | grep -v "^Binary" | head -10)

## Next Steps
1. Review each analysis document for detailed insights
2. Score each dimension based on the criteria
3. Make go/no-go decision based on total score
4. If GO, proceed with 90-day implementation plan
