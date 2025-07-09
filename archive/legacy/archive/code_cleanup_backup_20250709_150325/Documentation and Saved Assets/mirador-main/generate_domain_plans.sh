

echo "============================================="
echo "📂 DOMAIN-SPECIFIC ACTION PLAN GENERATOR"
echo "============================================="
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"
PLANS_DIR="$HOME/ai_framework_git/domain_action_plans"


mkdir -p "$PLANS_DIR"


create_domain_plan() {
    local domain="$1"
    local pattern="$2"
    local filename="$3"
    
    echo "📝 Creating $domain plan..."
    
    cat > "$PLANS_DIR/${filename}_action_plan.md" << PLAN_HEADER

Generated: $(date)


Based on analysis of Mirador insights for $domain domain.



PLAN_HEADER

    
    find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "$pattern" {} \; 2>/dev/null | \
        head -5 | while read summary; do
        PROMPT=$(grep -A2 "Initial Prompt" "$summary" 2>/dev/null | tail -1)
        echo "
        echo "" >> "$PLANS_DIR/${filename}_action_plan.md"
        
        
        grep -E "^[0-9]+\." "$summary" | head -5 >> "$PLANS_DIR/${filename}_action_plan.md" 2>/dev/null
        echo "" >> "$PLANS_DIR/${filename}_action_plan.md"
    done
    
    
    cat >> "$PLANS_DIR/${filename}_action_plan.md" << 'IMPL'




- [ ] Review all opportunities
- [ ] Prioritize based on ROI
- [ ] Gather required resources
- [ ] Create detailed timeline


- [ ] Start with quick wins
- [ ] Set up tracking systems
- [ ] Begin skill development
- [ ] Make initial contacts


- [ ] Implement major initiatives
- [ ] Monitor progress
- [ ] Adjust strategies
- [ ] Scale successful efforts


- Financial Impact: $
- Time Saved: Hours/Week
- Quality of Life: Rating
- Progress: %

IMPL
}


create_domain_plan "Financial" "financial\|money\|investment\|wealth" "financial"
create_domain_plan "Career" "career\|job\|professional\|work" "career"
create_domain_plan "Business" "business\|startup\|entrepreneur" "business"
create_domain_plan "Real Estate" "real estate\|property\|rental\|housing" "real_estate"
create_domain_plan "Health & Wellness" "health\|wellness\|fitness\|medical" "health"

echo ""
echo "✅ Domain action plans created in: $PLANS_DIR"
echo ""
echo "============================================="
