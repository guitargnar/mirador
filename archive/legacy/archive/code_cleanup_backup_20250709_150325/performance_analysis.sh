

echo "=== MIRADOR PERFORMANCE ANALYSIS ==="
echo "Date: $(date)"
echo ""

echo "1. MODEL PERFORMANCE COMPARISON:"
echo "V3 vs V4 Enhanced Agent Performance:"


echo ""
echo "Recent Chain Content Analysis:"
for chain in $(ls -t ~/ai_framework_git/outputs/chain_* | head -10); do
    if [ -f "$chain/summary.md" ]; then
        words=$(wc -w < "$chain/summary.md")
        echo "$(basename $chain): $words words"
    fi
done

echo ""
echo "2. OUTPUT QUALITY ASSESSMENT:"
echo "Recent Comprehensive Analyses:"


ls -t ~/ai_framework_git/outputs/chain_* | head -5 | while read chain; do
    if [ -f "$chain/summary.md" ]; then
        echo ""
        echo "=== $(basename $chain) ==="
        echo "Category: $(cat $chain/summary.md | head -5 | grep -o '[A-Z][A-Z]*' | head -1 || echo 'Unknown')"
        echo "Content preview:"
        head -10 "$chain/summary.md" | grep -v '^$'
        echo "---"
    fi
done

echo ""
echo "3. OPPORTUNITY TRACKING STATUS:"
python3 ~/ai_framework_git/track_opportunity.py list

echo ""
echo "4. SYSTEM METRICS:"
python3 ~/ai_framework_git/mirador_dashboard.py

