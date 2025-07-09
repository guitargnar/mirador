#!/usr/bin/env python3
"""
Analytics Tracker - Measure actual time saved by productivity tools
Tracks usage and calculates ROI automatically
"""

import json
import datetime
import os
from typing import Dict, List

# Analytics file location
ANALYTICS_FILE = "productivity_analytics.json"

# Time estimates (in minutes) - conservative estimates
TIME_SAVINGS = {
    "meeting_notes": 20,
    "cms_analyzer": 180,
    "email_parser": 30,
    "weekly_tracker": 5,
    "star_ratings": 120
}

def load_analytics() -> Dict:
    """Load existing analytics or create new file"""
    if os.path.exists(ANALYTICS_FILE):
        try:
            with open(ANALYTICS_FILE, 'r') as f:
                return json.load(f)
        except:
            pass
    
    # Default structure
    return {
        "users": {},
        "sessions": [],
        "total_time_saved": 0,
        "tool_usage": {
            "meeting_notes": 0,
            "cms_analyzer": 0,
            "email_parser": 0,
            "weekly_tracker": 0,
            "star_ratings": 0
        }
    }

def save_analytics(data: Dict):
    """Save analytics data"""
    with open(ANALYTICS_FILE, 'w') as f:
        json.dump(data, f, indent=2)

def track_usage(tool_name: str, user_id: str = "anonymous", duration_override: int = None):
    """Track tool usage"""
    data = load_analytics()
    timestamp = datetime.datetime.now().isoformat()
    
    # Calculate time saved
    time_saved = duration_override if duration_override else TIME_SAVINGS.get(tool_name, 10)
    
    # Update user stats
    if user_id not in data["users"]:
        data["users"][user_id] = {
            "first_use": timestamp,
            "total_time_saved": 0,
            "tool_usage": {}
        }
    
    data["users"][user_id]["total_time_saved"] += time_saved
    data["users"][user_id]["tool_usage"][tool_name] = data["users"][user_id]["tool_usage"].get(tool_name, 0) + 1
    
    # Update global stats
    data["total_time_saved"] += time_saved
    data["tool_usage"][tool_name] = data["tool_usage"].get(tool_name, 0) + 1
    
    # Add session record
    data["sessions"].append({
        "timestamp": timestamp,
        "user": user_id,
        "tool": tool_name,
        "time_saved": time_saved
    })
    
    save_analytics(data)
    return time_saved

def generate_report() -> str:
    """Generate analytics report"""
    data = load_analytics()
    
    if not data["sessions"]:
        return "No usage data yet. Start using the tools to see analytics!"
    
    # Calculate metrics
    total_hours = data["total_time_saved"] / 60
    num_users = len(data["users"])
    num_sessions = len(data["sessions"])
    
    # Calculate daily average (last 30 days)
    thirty_days_ago = datetime.datetime.now() - datetime.timedelta(days=30)
    recent_sessions = [s for s in data["sessions"] 
                      if datetime.datetime.fromisoformat(s["timestamp"]) > thirty_days_ago]
    recent_time = sum(s["time_saved"] for s in recent_sessions)
    daily_average = recent_time / 30 if recent_sessions else 0
    
    # ROI calculation (assuming $75/hour)
    hourly_rate = 75
    total_value = total_hours * hourly_rate
    monthly_value = (daily_average / 60) * 22 * hourly_rate  # 22 working days
    
    report = f"""
📊 PRODUCTIVITY TOOLS ANALYTICS REPORT
=====================================
Generated: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M')}

OVERALL IMPACT:
--------------
Total Time Saved: {total_hours:.1f} hours ({data['total_time_saved']} minutes)
Total Value Created: ${total_value:,.2f}
Active Users: {num_users}
Total Sessions: {num_sessions}

USAGE BY TOOL:
-------------"""
    
    for tool, count in sorted(data["tool_usage"].items(), key=lambda x: x[1], reverse=True):
        if count > 0:
            tool_time = count * TIME_SAVINGS.get(tool, 10)
            report += f"\n{tool.replace('_', ' ').title()}: {count} uses ({tool_time} min saved)"
    
    report += f"""

30-DAY METRICS:
--------------
Recent Sessions: {len(recent_sessions)}
Daily Average: {daily_average:.1f} minutes saved
Monthly Projection: ${monthly_value:,.2f} value

TOP USERS:
---------"""
    
    # Top 5 users by time saved
    top_users = sorted(data["users"].items(), 
                      key=lambda x: x[1]["total_time_saved"], 
                      reverse=True)[:5]
    
    for user, stats in top_users:
        hours = stats["total_time_saved"] / 60
        report += f"\n{user}: {hours:.1f} hours saved"
    
    # Recent activity
    report += "\n\nRECENT ACTIVITY:\n---------------"
    for session in data["sessions"][-10:]:
        timestamp = datetime.datetime.fromisoformat(session["timestamp"])
        report += f"\n{timestamp.strftime('%m/%d %H:%M')} - {session['user']} used {session['tool']} (saved {session['time_saved']} min)"
    
    # Recommendations
    report += "\n\nRECOMMENDATIONS:\n----------------"
    
    if data["tool_usage"]["email_parser"] < num_sessions * 0.3:
        report += "\n• Email Parser is underutilized - promote for email-heavy roles"
    
    if daily_average < 60:
        report += "\n• Increase adoption - average user saves less than 1 hour/day"
    
    if num_users < 10:
        report += "\n• Expand user base - current adoption is limited"
    
    if monthly_value > 10000:
        report += "\n• 🎉 Excellent ROI! Consider enterprise-wide deployment"
    
    return report

def get_user_stats(user_id: str) -> str:
    """Get stats for specific user"""
    data = load_analytics()
    
    if user_id not in data["users"]:
        return f"No data found for user: {user_id}"
    
    user_data = data["users"][user_id]
    hours_saved = user_data["total_time_saved"] / 60
    value_created = hours_saved * 75
    
    stats = f"""
📊 Personal Productivity Stats for {user_id}
=========================================

Time Saved: {hours_saved:.1f} hours
Value Created: ${value_created:,.2f}
Member Since: {user_data['first_use'][:10]}

Your Tool Usage:
"""
    
    for tool, count in sorted(user_data["tool_usage"].items(), 
                             key=lambda x: x[1], reverse=True):
        stats += f"\n  • {tool.replace('_', ' ').title()}: {count} times"
    
    return stats

def main():
    """Interactive analytics interface"""
    print("📊 Productivity Tools Analytics")
    print("=" * 40)
    print("\nOptions:")
    print("1. View overall report")
    print("2. View personal stats")
    print("3. Export data (JSON)")
    print("4. Track manual entry")
    
    choice = input("\nSelect option (1-4): ").strip()
    
    if choice == "1":
        print(generate_report())
        
    elif choice == "2":
        user_id = input("Enter user ID (or press Enter for 'anonymous'): ").strip()
        if not user_id:
            user_id = "anonymous"
        print(get_user_stats(user_id))
        
    elif choice == "3":
        data = load_analytics()
        filename = f"analytics_export_{datetime.datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        with open(filename, 'w') as f:
            json.dump(data, f, indent=2)
        print(f"\n✅ Analytics exported to: {filename}")
        
    elif choice == "4":
        print("\nManual Time Tracking")
        print("-" * 20)
        print("Tools: meeting_notes, cms_analyzer, email_parser, weekly_tracker, star_ratings")
        tool = input("Which tool did you use? ").strip().lower()
        user = input("User ID (or press Enter for anonymous): ").strip() or "anonymous"
        
        custom_time = input("Time saved in minutes (or press Enter for default): ").strip()
        if custom_time.isdigit():
            time_saved = track_usage(tool, user, int(custom_time))
        else:
            time_saved = track_usage(tool, user)
            
        print(f"\n✅ Tracked {time_saved} minutes saved for {user} using {tool}")
        
    else:
        print("Invalid option")

if __name__ == "__main__":
    main()