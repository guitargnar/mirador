

echo "============================================="
echo "MIRADOR MASTER INSIGHTS ORGANIZER"
echo "============================================="
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"
INSIGHTS_BASE="$HOME/ai_framework_git/actionable_insights"


mkdir -p "$INSIGHTS_BASE"/{immediate,short_term,long_term}
mkdir -p "$INSIGHTS_BASE"/{financial,career,business,real_estate,education,health,lifestyle}
mkdir -p "$INSIGHTS_BASE"/by_value/{under_10k,10k_50k,50k_100k,over_100k}


categorize_insight() {
    local summary="$1"
    local base_name=$(basename $(dirname "$summary"))
    
    
    PROMPT=$(grep -A2 "Initial Prompt" "$summary" 2>/dev/null | tail -1)
    
    
    INSIGHT_FILE="$INSIGHTS_BASE/all_insights/${base_name}.md"
    mkdir -p "$INSIGHTS_BASE/all_insights"
    
    cat > "$INSIGHT_FILE" << INSIGHT_HEADER

Generated: $(date)


$PROMPT


INSIGHT_HEADER

    
    grep -E "^[0-9]+\." "$summary" >> "$INSIGHT_FILE" 2>/dev/null
    
    
    echo "" >> "$INSIGHT_FILE"
    echo "
    sed -n '/Action Items.*:/,/^$/p' "$summary" | grep -v "Action Items" >> "$INSIGHT_FILE" 2>/dev/null
    
    
    if grep -qi "immediate\|today\|now\|asap" "$summary"; then
        ln -sf "$INSIGHT_FILE" "$INSIGHTS_BASE/immediate/"
    elif grep -qi "month\|weeks\|30 days\|90 days" "$summary"; then
        ln -sf "$INSIGHT_FILE" "$INSIGHTS_BASE/short_term/"
    elif grep -qi "year\|long.term\|future" "$summary"; then
        ln -sf "$INSIGHT_FILE" "$INSIGHTS_BASE/long_term/"
    fi
    
    
    if grep -qi "financial\|money\|investment\|wealth" "$summary"; then
        ln -sf "$INSIGHT_FILE" "$INSIGHTS_BASE/financial/"
    fi
    if grep -qi "career\|job\|professional" "$summary"; then
        ln -sf "$INSIGHT_FILE" "$INSIGHTS_BASE/career/"
    fi
    if grep -qi "business\|startup\|entrepreneur" "$summary"; then
        ln -sf "$INSIGHT_FILE" "$INSIGHTS_BASE/business/"
    fi
    if grep -qi "real estate\|property\|house" "$summary"; then
        ln -sf "$INSIGHT_FILE" "$INSIGHTS_BASE/real_estate/"
    fi
}


echo "🔍 Processing all insights..."
find "$OUTPUT_DIR" -name "summary.md" -print0 2>/dev/null | while IFS= read -r -d '' summary; do
    categorize_insight "$summary"
done


echo ""
echo "📚 Generating master index..."

cat > "$INSIGHTS_BASE/MASTER_INDEX.md" << 'INDEX_HEADER'

Generated: DATE_PLACEHOLDER


This index organizes all insights extracted from Mirador chains for easy reference and action.

---

INDEX_HEADER

sed -i '' "s/DATE_PLACEHOLDER/$(date)/" "$INSIGHTS_BASE/MASTER_INDEX.md"


for category in immediate short_term long_term financial career business real_estate; do
    COUNT=$(ls "$INSIGHTS_BASE/$category" 2>/dev/null | wc -l | tr -d ' ')
    
    
    case $category in
        immediate) CAP_CAT="Immediate" ;;
        short_term) CAP_CAT="Short Term" ;;
        long_term) CAP_CAT="Long Term" ;;
        financial) CAP_CAT="Financial" ;;
        career) CAP_CAT="Career" ;;
        business) CAP_CAT="Business" ;;
        real_estate) CAP_CAT="Real Estate" ;;
    esac
    
    echo "
    echo "" >> "$INSIGHTS_BASE/MASTER_INDEX.md"
    
    ls "$INSIGHTS_BASE/$category" 2>/dev/null | head -5 | while read file; do
        echo "- $file" >> "$INSIGHTS_BASE/MASTER_INDEX.md"
    done
    echo "" >> "$INSIGHTS_BASE/MASTER_INDEX.md"
done

echo ""
echo "✅ Master insights organized at: $INSIGHTS_BASE"
echo "📄 View master index: $INSIGHTS_BASE/MASTER_INDEX.md"
echo ""
echo "============================================="
