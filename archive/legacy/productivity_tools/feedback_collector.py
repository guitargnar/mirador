#!/usr/bin/env python3
"""
Feedback Collector - Continuous improvement through user input
Captures feedback, suggestions, and bug reports for productivity tools
"""

import json
import datetime
import os
from typing import Dict, List

FEEDBACK_FILE = "productivity_feedback.json"

def load_feedback() -> Dict:
    """Load existing feedback or create new file"""
    if os.path.exists(FEEDBACK_FILE):
        try:
            with open(FEEDBACK_FILE, 'r') as f:
                return json.load(f)
        except:
            pass
    
    return {
        "feedback_items": [],
        "feature_requests": {},
        "bug_reports": [],
        "testimonials": []
    }

def save_feedback(data: Dict):
    """Save feedback data"""
    with open(FEEDBACK_FILE, 'w') as f:
        json.dump(data, f, indent=2)

def collect_feedback():
    """Interactive feedback collection"""
    print("\n📝 Productivity Tools Feedback")
    print("=" * 40)
    print("\nYour feedback helps us improve!")
    print("\n1. General feedback")
    print("2. Feature request")
    print("3. Bug report")
    print("4. Success story")
    print("5. View feedback summary")
    
    choice = input("\nSelect option (1-5): ").strip()
    
    data = load_feedback()
    timestamp = datetime.datetime.now().isoformat()
    user = os.environ.get('USER', 'anonymous')
    
    if choice == "1":
        print("\n💭 General Feedback")
        print("-" * 40)
        tool = input("Which tool? (or 'all' for general): ").strip()
        rating = input("Rating (1-5 stars): ").strip()
        feedback = input("Your feedback: ").strip()
        
        data["feedback_items"].append({
            "timestamp": timestamp,
            "user": user,
            "tool": tool,
            "rating": int(rating) if rating.isdigit() else 0,
            "feedback": feedback
        })
        
        print("\n✅ Thank you for your feedback!")
        
    elif choice == "2":
        print("\n💡 Feature Request")
        print("-" * 40)
        tool = input("Which tool needs this feature? ").strip()
        feature = input("Describe the feature: ").strip()
        use_case = input("How would you use it? ").strip()
        
        if tool not in data["feature_requests"]:
            data["feature_requests"][tool] = []
            
        data["feature_requests"][tool].append({
            "timestamp": timestamp,
            "user": user,
            "feature": feature,
            "use_case": use_case,
            "votes": 1
        })
        
        print("\n✅ Feature request recorded!")
        
    elif choice == "3":
        print("\n🐛 Bug Report")
        print("-" * 40)
        tool = input("Which tool has the bug? ").strip()
        description = input("Describe the bug: ").strip()
        steps = input("Steps to reproduce: ").strip()
        
        data["bug_reports"].append({
            "timestamp": timestamp,
            "user": user,
            "tool": tool,
            "description": description,
            "steps": steps,
            "status": "open"
        })
        
        print("\n✅ Bug report filed! We'll investigate.")
        
    elif choice == "4":
        print("\n🌟 Success Story")
        print("-" * 40)
        tool = input("Which tool helped you? ").strip()
        time_saved = input("Time saved (minutes): ").strip()
        story = input("Tell your story: ").strip()
        
        data["testimonials"].append({
            "timestamp": timestamp,
            "user": user,
            "tool": tool,
            "time_saved": int(time_saved) if time_saved.isdigit() else 0,
            "story": story
        })
        
        print("\n✅ Thank you for sharing your success!")
        
    elif choice == "5":
        generate_feedback_summary(data)
        return  # Don't save, just viewing
        
    else:
        print("Invalid option")
        return
    
    save_feedback(data)

def generate_feedback_summary(data: Dict = None):
    """Generate summary of all feedback"""
    if data is None:
        data = load_feedback()
    
    print("\n📊 FEEDBACK SUMMARY")
    print("=" * 50)
    
    # Overall ratings
    if data["feedback_items"]:
        ratings = [f["rating"] for f in data["feedback_items"] if f["rating"] > 0]
        if ratings:
            avg_rating = sum(ratings) / len(ratings)
            print(f"\nAverage Rating: {'⭐' * int(avg_rating)} ({avg_rating:.1f}/5)")
            print(f"Total Feedback: {len(data['feedback_items'])} items")
    
    # Feature requests by tool
    if data["feature_requests"]:
        print("\n🔧 TOP FEATURE REQUESTS:")
        for tool, requests in data["feature_requests"].items():
            print(f"\n{tool}:")
            for req in requests[:3]:  # Top 3
                print(f"  • {req['feature'][:60]}...")
    
    # Open bugs
    open_bugs = [b for b in data["bug_reports"] if b["status"] == "open"]
    if open_bugs:
        print(f"\n🐛 OPEN BUGS: {len(open_bugs)}")
        for bug in open_bugs[:5]:
            print(f"  • [{bug['tool']}] {bug['description'][:50]}...")
    
    # Success stories
    if data["testimonials"]:
        total_time = sum(t["time_saved"] for t in data["testimonials"])
        print(f"\n✨ SUCCESS STORIES: {len(data['testimonials'])}")
        print(f"Total Time Saved: {total_time} minutes ({total_time/60:.1f} hours)")
        
        # Latest testimonial
        latest = sorted(data["testimonials"], 
                       key=lambda x: x["timestamp"], 
                       reverse=True)[0]
        print(f"\nLatest: \"{latest['story'][:100]}...\"")
        print(f"         - {latest['user']} ({latest['time_saved']} min saved)")
    
    # Recent feedback samples
    if data["feedback_items"]:
        print("\n💬 RECENT FEEDBACK:")
        recent = sorted(data["feedback_items"], 
                       key=lambda x: x["timestamp"], 
                       reverse=True)[:3]
        for item in recent:
            stars = '⭐' * item.get("rating", 0)
            print(f"\n{stars} [{item['tool']}]")
            print(f"\"{item['feedback'][:80]}...\"")

def create_action_items() -> str:
    """Generate action items from feedback"""
    data = load_feedback()
    
    actions = []
    
    # High-priority bugs
    open_bugs = [b for b in data["bug_reports"] if b["status"] == "open"]
    if open_bugs:
        actions.append(f"Fix {len(open_bugs)} reported bugs")
    
    # Popular feature requests
    for tool, requests in data["feature_requests"].items():
        if len(requests) >= 3:
            actions.append(f"Implement top features for {tool}")
    
    # Low ratings
    low_ratings = [f for f in data["feedback_items"] if f.get("rating", 5) <= 2]
    if len(low_ratings) >= 2:
        actions.append("Address user concerns from low ratings")
    
    return "\n".join(f"• {action}" for action in actions)

# Integration module for tools
def quick_feedback(tool_name: str, rating: int = None):
    """Quick feedback method for integration into tools"""
    try:
        data = load_feedback()
        data["feedback_items"].append({
            "timestamp": datetime.datetime.now().isoformat(),
            "user": os.environ.get('USER', 'anonymous'),
            "tool": tool_name,
            "rating": rating,
            "feedback": "Quick rating"
        })
        save_feedback(data)
    except:
        pass  # Fail silently

if __name__ == "__main__":
    collect_feedback()