#!/bin/bash

echo "============================================="
echo "📂 DOMAIN-SPECIFIC ACTION PLAN GENERATOR"
echo "============================================="
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"
PLANS_DIR="$HOME/ai_framework_git/domain_action_plans"

# Create plans directory
mkdir -p "$PLANS_DIR"

# Function to create domain plan
create_domain_plan() {
    local domain="$1"
    local pattern="$2"
    local filename="$3"
    
    echo "📝 Creating $domain plan..."
    
    cat > "$PLANS_DIR/${filename}_action_plan.md" << PLAN_HEADER
# $domain Action Plan
Generated: $(date)

## Overview
Based on analysis of Mirador insights for $domain domain.

## Key Opportunities Identified

PLAN_HEADER

    # Extract top opportunities for this domain
    find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "$pattern" {} \; 2>/dev/null | \
        head -5 | while read summary; do
        PROMPT=$(grep -A2 "Initial Prompt" "$summary" 2>/dev/null | tail -1)
        echo "### $PROMPT" >> "$PLANS_DIR/${filename}_action_plan.md"
        echo "" >> "$PLANS_DIR/${filename}_action_plan.md"
        
        # Extract key points
        grep -E "^[0-9]+\." "$summary" | head -5 >> "$PLANS_DIR/${filename}_action_plan.md" 2>/dev/null
        echo "" >> "$PLANS_DIR/${filename}_action_plan.md"
    done
    
    # Add implementation section
    cat >> "$PLANS_DIR/${filename}_action_plan.md" << 'IMPL'

## Implementation Timeline

### Week 1-2: Research & Planning
- [ ] Review all opportunities
- [ ] Prioritize based on ROI
- [ ] Gather required resources
- [ ] Create detailed timeline

### Week 3-4: Initial Implementation
- [ ] Start with quick wins
- [ ] Set up tracking systems
- [ ] Begin skill development
- [ ] Make initial contacts

### Month 2-3: Full Execution
- [ ] Implement major initiatives
- [ ] Monitor progress
- [ ] Adjust strategies
- [ ] Scale successful efforts

## Success Metrics
- Financial Impact: $
- Time Saved: Hours/Week
- Quality of Life: Rating
- Progress: %

IMPL
}

# Generate plans for each domain
create_domain_plan "Financial" "financial\|money\|investment\|wealth" "financial"
create_domain_plan "Career" "career\|job\|professional\|work" "career"
create_domain_plan "Business" "business\|startup\|entrepreneur" "business"
create_domain_plan "Real Estate" "real estate\|property\|rental\|housing" "real_estate"
create_domain_plan "Health & Wellness" "health\|wellness\|fitness\|medical" "health"

echo ""
echo "✅ Domain action plans created in: $PLANS_DIR"
echo ""
echo "============================================="
