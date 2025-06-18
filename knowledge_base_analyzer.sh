

echo "====================================="
echo "MIRADOR KNOWLEDGE BASE ANALYZER"
echo "====================================="
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"


echo "📊 KNOWLEDGE DOMAINS COVERED:"
echo "============================"


declare -A categories
categories=(
    ["financial"]="finance|money|investment|wealth"
    ["career"]="career|job|work|professional"
    ["real_estate"]="real estate|property|house|rental"
    ["business"]="business|startup|entrepreneur"
    ["education"]="education|learning|skill|certification"
    ["health"]="health|wellness|medical|fitness"
    ["technology"]="tech|AI|software|digital"
    ["lifestyle"]="lifestyle|life|time|minimalist"
    ["relationships"]="relationship|family|partner|spouse"
    ["risk"]="risk|insurance|protection|emergency"
)

for category in "${!categories[@]}"; do
    pattern="${categories[$category]}"
    count=$(find "$OUTPUT_DIR" -name "summary.md" -exec grep -l -i "$pattern" {} \; 2>/dev/null | wc -l)
    printf "%-15s: %3d chains\n" "$category" "$count"
done

echo ""
echo "📈 OPPORTUNITY METRICS:"
echo "====================="


echo "Income opportunities identified: $(find "$OUTPUT_DIR" -name "summary.md" -exec grep -i "income" {} \; 2>/dev/null | grep -c "opportunit")"
echo "Investment opportunities found: $(find "$OUTPUT_DIR" -name "summary.md" -exec grep -i "invest" {} \; 2>/dev/null | grep -c "opportunit")"
echo "Career advancement strategies: $(find "$OUTPUT_DIR" -name "summary.md" -exec grep -i "career" {} \; 2>/dev/null | grep -c "advancement\|strateg")"
echo "Cost optimization tactics: $(find "$OUTPUT_DIR" -name "summary.md" -exec grep -i "cost\|save\|reduce" {} \; 2>/dev/null | wc -l)"

echo ""
echo "🎯 ACTIONABLE INSIGHTS:"
echo "====================="


echo "Total action items generated:"
find "$OUTPUT_DIR" -name "summary.md" -exec grep -E "^[0-9]+\.|^[-*]" {} \; 2>/dev/null | wc -l

echo ""
echo "====================================="
