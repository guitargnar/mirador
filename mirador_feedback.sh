#!/bin/bash

# Mirador Feedback Collection System
# Usage: ./mirador_feedback.sh <session_id> <rating> [notes]

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
RESET='\033[0m'

if [ $# -lt 2 ]; then
    echo -e "${RED}Usage: $0 <session_id> <rating> [notes]${RESET}"
    echo -e "\n${YELLOW}Rating Scale:${RESET}"
    echo "  5 - Excellent: Saved significant time, provided valuable insights"
    echo "  4 - Very Good: Helpful with minor adjustments needed"
    echo "  3 - Good: Useful but required some refinement"
    echo "  2 - Fair: Some value but missed key aspects"
    echo "  1 - Poor: Not helpful, needs major improvement"
    echo -e "\n${BLUE}Examples:${RESET}"
    echo "  $0 20250707_093617 5 \"Perfect timing recommendations\""
    echo "  $0 20250707_093617 3 \"Good insights but too generic\""
    exit 1
fi

SESSION_ID=$1
RATING=$2
NOTES="${3:-No notes provided}"

# Validate rating
if [[ ! "$RATING" =~ ^[1-5]$ ]]; then
    echo -e "${RED}Error: Rating must be between 1 and 5${RESET}"
    exit 1
fi

# Initialize feedback database
FEEDBACK_DIR="${HOME}/.mirador"
FEEDBACK_DB="$FEEDBACK_DIR/feedback.db"
FEEDBACK_LOG="$FEEDBACK_DIR/feedback.log"

mkdir -p "$FEEDBACK_DIR"

# Create feedback database if it doesn't exist
if [ ! -f "$FEEDBACK_DB" ]; then
    echo -e "${BLUE}Initializing feedback database...${RESET}"
    python3 << EOF
import sqlite3
import os

db_path = '$FEEDBACK_DB'
conn = sqlite3.connect(db_path)

conn.execute('''
    CREATE TABLE IF NOT EXISTS feedback (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_id TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
        notes TEXT,
        chain_type TEXT,
        format_used TEXT,
        time_saved_estimate REAL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
''')

conn.execute('''
    CREATE INDEX IF NOT EXISTS idx_session_id ON feedback(session_id);
''')

conn.execute('''
    CREATE INDEX IF NOT EXISTS idx_rating ON feedback(rating);
''')

conn.execute('''
    CREATE INDEX IF NOT EXISTS idx_timestamp ON feedback(timestamp);
''')

conn.commit()
conn.close()
print("Feedback database initialized")
EOF
fi

# Find the output directory for this session
OUTPUT_DIR=""
for dir in outputs/universal_*_${SESSION_ID}; do
    if [ -d "$dir" ]; then
        OUTPUT_DIR="$dir"
        break
    fi
done

if [ -z "$OUTPUT_DIR" ]; then
    echo -e "${YELLOW}Warning: Could not find output directory for session $SESSION_ID${RESET}"
    CHAIN_TYPE="unknown"
    FORMAT_USED="unknown"
else
    # Extract chain type and format from output directory
    CHAIN_TYPE=$(echo "$OUTPUT_DIR" | sed 's/.*universal_\([^_]*\)_.*/\1/')
    if [ -f "$OUTPUT_DIR/format.txt" ]; then
        FORMAT_USED=$(cat "$OUTPUT_DIR/format.txt")
    else
        FORMAT_USED="detailed"
    fi
fi

# Collect additional feedback for high ratings
TIME_SAVED=""
if [ "$RATING" -ge 4 ]; then
    echo -e "${GREEN}Great feedback! How much time did this save you? (hours)${RESET}"
    echo -e "${BLUE}Examples: 0.5 (30 minutes), 2 (2 hours), 0.25 (15 minutes)${RESET}"
    read -p "Time saved (hours): " TIME_SAVED
    
    if [[ ! "$TIME_SAVED" =~ ^[0-9]*\.?[0-9]+$ ]]; then
        TIME_SAVED="0"
    fi
fi

# Store feedback in database
echo -e "${BLUE}Recording feedback...${RESET}"
python3 << EOF
import sqlite3
from datetime import datetime

conn = sqlite3.connect('$FEEDBACK_DB')

conn.execute('''
    INSERT INTO feedback (session_id, timestamp, rating, notes, chain_type, format_used, time_saved_estimate)
    VALUES (?, ?, ?, ?, ?, ?, ?)
''', ('$SESSION_ID', '$(date -u +%Y-%m-%dT%H:%M:%SZ)', $RATING, '''$NOTES''', '$CHAIN_TYPE', '$FORMAT_USED', ${TIME_SAVED:-'NULL'}))

conn.commit()
conn.close()
print("Feedback recorded successfully")
EOF

# Log feedback
echo "$(date '+%Y-%m-%d %H:%M:%S') | $SESSION_ID | $RATING | $CHAIN_TYPE | $FORMAT_USED | $NOTES" >> "$FEEDBACK_LOG"

# Provide feedback acknowledgment
case $RATING in
    5)
        echo -e "\n${GREEN}✓ Excellent! Thanks for the positive feedback.${RESET}"
        echo -e "${BLUE}This helps us understand what works best for you.${RESET}"
        ;;
    4)
        echo -e "\n${GREEN}✓ Very good feedback recorded.${RESET}"
        echo -e "${BLUE}We'll use this to fine-tune future recommendations.${RESET}"
        ;;
    3)
        echo -e "\n${YELLOW}✓ Good feedback noted.${RESET}"
        echo -e "${BLUE}Your input helps us improve the balance of detail and actionability.${RESET}"
        ;;
    2)
        echo -e "\n${YELLOW}✓ Fair rating recorded.${RESET}"
        echo -e "${BLUE}We'll analyze what aspects need improvement.${RESET}"
        ;;
    1)
        echo -e "\n${RED}✓ Thanks for the honest feedback.${RESET}"
        echo -e "${BLUE}This helps us identify areas that need significant improvement.${RESET}"
        ;;
esac

# Show some basic analytics if we have enough data
TOTAL_FEEDBACK=$(python3 -c "
import sqlite3
conn = sqlite3.connect('$FEEDBACK_DB')
cursor = conn.execute('SELECT COUNT(*) FROM feedback')
count = cursor.fetchone()[0]
conn.close()
print(count)
")

if [ "$TOTAL_FEEDBACK" -ge 5 ]; then
    echo -e "\n${PURPLE}Quick Analytics (last 10 sessions):${RESET}"
    python3 << EOF
import sqlite3
from datetime import datetime, timedelta

conn = sqlite3.connect('$FEEDBACK_DB')

# Average rating
cursor = conn.execute('SELECT AVG(rating), COUNT(*) FROM feedback ORDER BY id DESC LIMIT 10')
avg_rating, count = cursor.fetchone()

# Most successful chain type
cursor = conn.execute('''
    SELECT chain_type, AVG(rating), COUNT(*) 
    FROM feedback 
    WHERE chain_type != 'unknown'
    GROUP BY chain_type 
    ORDER BY AVG(rating) DESC, COUNT(*) DESC 
    LIMIT 3
''')
top_chains = cursor.fetchall()

# Time saved estimate
cursor = conn.execute('SELECT SUM(time_saved_estimate) FROM feedback WHERE time_saved_estimate IS NOT NULL')
total_time_saved = cursor.fetchone()[0] or 0

print(f"  Average Rating: {avg_rating:.1f}/5.0 ({count} recent sessions)")
if total_time_saved > 0:
    print(f"  Estimated Time Saved: {total_time_saved:.1f} hours")

if top_chains:
    print("  Top Performing Chains:")
    for chain, rating, uses in top_chains[:2]:
        print(f"    {chain}: {rating:.1f}/5.0 ({uses} uses)")

conn.close()
EOF
fi

# Suggest improvements based on rating patterns
if [ "$RATING" -le 2 ]; then
    echo -e "\n${BLUE}Suggestions to improve your experience:${RESET}"
    echo "  • Try the 'quick' format for faster, actionable insights"
    echo "  • Use more specific prompts with clear desired outcomes"
    echo "  • Consider the 'summary' format for overview without details"
    echo -e "\n${BLUE}Example improved prompt:${RESET}"
    echo "  Instead of: 'How do I manage my time?'"
    echo "  Try: 'How do I allocate 3 hours tomorrow between Sage, Katie, and coursework?'"
fi

echo -e "\n${GREEN}Feedback saved! This helps Mirador learn your preferences.${RESET}"