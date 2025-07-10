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
