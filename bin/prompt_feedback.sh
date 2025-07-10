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
