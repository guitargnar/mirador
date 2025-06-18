

echo "============================================="
echo "📋 MIRADOR ACTION TRACKER GENERATOR"
echo "============================================="
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"
TRACKER="$HOME/ai_framework_git/ACTION_TRACKER.md"


cat > "$TRACKER" << 'HEADER'

Generated: DATE_PLACEHOLDER



| Action | Source | Status | Notes |
|--------|--------|--------|-------|
HEADER

sed -i '' "s/DATE_PLACEHOLDER/$(date)/" "$TRACKER"


find "$OUTPUT_DIR" -name "summary.md" -mtime -7 -exec grep -h "^1\." {} \; 2>/dev/null | \
    head -20 | while read action; do
    echo "| $action | Chain | ⬜ | |" >> "$TRACKER"
done


cat >> "$TRACKER" << 'SECTIONS'



| Action | Source | Target Date | Status |
|--------|--------|-------------|--------|



| Goal | Steps | Progress | Notes |
|------|-------|----------|-------|



| Objective | Milestones | Status | Value |
|-----------|------------|--------|-------|



- Total Actions Identified: 
- Actions Completed: 
- Success Rate: 
- Value Generated: 

SECTIONS

echo "✅ Action tracker created at: $TRACKER"
echo ""
echo "============================================="
