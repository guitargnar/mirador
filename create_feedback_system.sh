#!/bin/bash
# Create unified feedback loop system

echo "🔄 Creating Mirador Feedback System"
echo "=================================="
echo ""

# Create feedback script if not exists
cat > mirador_feedback.sh << 'EOF'
#!/bin/bash
# Mirador Feedback Collection System

SESSION_ID=$1
RATING=$2
COMMENT=$3

if [ -z "$SESSION_ID" ] || [ -z "$RATING" ]; then
    echo "Usage: ./mirador_feedback.sh SESSION_ID RATING [COMMENT]"
    echo "Rating: 1-5 (1=poor, 5=excellent)"
    exit 1
fi

# Feedback database
FEEDBACK_DB="feedback/feedback_log.jsonl"
mkdir -p feedback

# Record feedback
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
FEEDBACK_ENTRY=$(cat <<JSON
{
  "session_id": "$SESSION_ID",
  "timestamp": "$TIMESTAMP",
  "rating": $RATING,
  "comment": "$COMMENT"
}
JSON
)

echo "$FEEDBACK_ENTRY" >> "$FEEDBACK_DB"

echo "✅ Feedback recorded!"
echo "Session: $SESSION_ID"
echo "Rating: $RATING/5"
[ -n "$COMMENT" ] && echo "Comment: $COMMENT"

# Calculate average rating
AVG_RATING=$(jq -s 'map(.rating) | add/length' "$FEEDBACK_DB" 2>/dev/null || echo "N/A")
echo ""
echo "📊 Overall average rating: $AVG_RATING"
EOF

chmod +x mirador_feedback.sh

# Create feedback analyzer
cat > analyze_feedback.py << 'EOF'
#!/usr/bin/env python3
import json
import sys
from datetime import datetime
from collections import defaultdict

def analyze_feedback():
    feedback_file = "feedback/feedback_log.jsonl"
    
    ratings = []
    chain_ratings = defaultdict(list)
    comments = []
    
    try:
        with open(feedback_file, 'r') as f:
            for line in f:
                entry = json.loads(line)
                rating = entry['rating']
                ratings.append(rating)
                
                # Extract chain type from session_id
                if 'universal_' in entry['session_id']:
                    chain_type = entry['session_id'].split('universal_')[1].split('_')[0]
                    chain_ratings[chain_type].append(rating)
                
                if entry.get('comment'):
                    comments.append(entry['comment'])
    except FileNotFoundError:
        print("No feedback data found yet.")
        return
    
    # Overall statistics
    print("📊 Mirador Feedback Analysis")
    print("===========================")
    print(f"Total feedback entries: {len(ratings)}")
    print(f"Average rating: {sum(ratings)/len(ratings):.2f}/5")
    print(f"Rating distribution:")
    for i in range(1, 6):
        count = ratings.count(i)
        bar = "█" * int(count/len(ratings) * 20)
        print(f"  {i}: {bar} ({count})")
    
    # Chain-specific analysis
    print("\n📈 Performance by Chain Type:")
    for chain, chain_ratings_list in sorted(chain_ratings.items()):
        avg = sum(chain_ratings_list)/len(chain_ratings_list)
        print(f"  {chain}: {avg:.2f}/5 ({len(chain_ratings_list)} uses)")
    
    # Recent comments
    print("\n💬 Recent Comments:")
    for comment in comments[-5:]:
        print(f"  - {comment}")

if __name__ == "__main__":
    analyze_feedback()
EOF

chmod +x analyze_feedback.py

# Create automated feedback prompter
cat > bin/prompt_feedback.sh << 'EOF'
#!/bin/bash
# Automatically prompt for feedback after chain completion

SESSION_DIR=$1

if [ -z "$SESSION_DIR" ]; then
    echo "Error: No session directory provided"
    exit 1
fi

SESSION_ID=$(basename "$SESSION_DIR")

echo ""
echo "🎯 How was this analysis?"
echo "Rate 1-5 (or 's' to skip):"
read -r RATING

if [ "$RATING" != "s" ] && [ "$RATING" -ge 1 ] && [ "$RATING" -le 5 ] 2>/dev/null; then
    echo "Any comments? (press Enter to skip):"
    read -r COMMENT
    
    ./mirador_feedback.sh "$SESSION_ID" "$RATING" "$COMMENT"
fi
EOF

chmod +x bin/prompt_feedback.sh

echo "✅ Feedback system created!"
echo ""
echo "Components:"
echo "  - mirador_feedback.sh: Record feedback"
echo "  - analyze_feedback.py: Analyze trends"
echo "  - bin/prompt_feedback.sh: Auto-prompt after chains"
echo ""
echo "Usage:"
echo "  ./mirador_feedback.sh SESSION_ID 5 'Great insights!'"
echo "  ./analyze_feedback.py"