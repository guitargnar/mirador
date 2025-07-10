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
