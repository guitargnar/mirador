#!/usr/bin/env python3
"""
Weekly Accomplishments Tracker - Never forget what you did
Transforms quick notes into performance review gold
"""

import os
import datetime
import json
from typing import List, Dict

# File to store accomplishments (local, no database needed)
ACCOMPLISHMENTS_FILE = "my_accomplishments_2025.json"

def load_accomplishments() -> Dict:
    """Load existing accomplishments or create new file"""
    if os.path.exists(ACCOMPLISHMENTS_FILE):
        with open(ACCOMPLISHMENTS_FILE, 'r') as f:
            return json.load(f)
    return {"entries": []}

def save_accomplishments(data: Dict):
    """Save accomplishments to file"""
    with open(ACCOMPLISHMENTS_FILE, 'w') as f:
        json.dump(data, f, indent=2)

def add_accomplishment(note: str, category: str = "general"):
    """Add a quick accomplishment note"""
    data = load_accomplishments()
    entry = {
        "date": datetime.datetime.now().isoformat(),
        "week": datetime.datetime.now().strftime("%Y-W%V"),
        "note": note,
        "category": category
    }
    data["entries"].append(entry)
    save_accomplishments(data)
    return entry

def get_week_summary(weeks_back: int = 0) -> str:
    """Get formatted summary for a specific week"""
    data = load_accomplishments()
    
    # Calculate target week
    target_date = datetime.datetime.now() - datetime.timedelta(weeks=weeks_back)
    target_week = target_date.strftime("%Y-W%V")
    
    # Filter entries for that week
    week_entries = [e for e in data["entries"] if e["week"] == target_week]
    
    if not week_entries:
        return f"No accomplishments recorded for week {target_week}"
    
    # Group by category
    by_category = {}
    for entry in week_entries:
        cat = entry["category"]
        if cat not in by_category:
            by_category[cat] = []
        by_category[cat].append(entry)
    
    # Format output
    output = f"Week of {target_date.strftime('%B %d, %Y')}\n"
    output += "=" * 50 + "\n\n"
    
    # Category mapping for professional presentation
    category_names = {
        "technical": "Technical Leadership",
        "compliance": "Compliance & Risk Management",
        "team": "Team Collaboration",
        "innovation": "Innovation & Process Improvement",
        "general": "Business Impact"
    }
    
    for category, entries in by_category.items():
        output += f"{category_names.get(category, category.title())}:\n"
        for entry in entries:
            output += f"• {entry['note']}\n"
        output += "\n"
    
    return output

def generate_formats(weeks_to_include: int = 1) -> Dict[str, str]:
    """Generate multiple professional formats"""
    outputs = {}
    
    # Collect entries for specified weeks
    all_entries = []
    data = load_accomplishments()
    
    for week in range(weeks_to_include):
        target_date = datetime.datetime.now() - datetime.timedelta(weeks=week)
        target_week = target_date.strftime("%Y-W%V")
        week_entries = [e for e in data["entries"] if e["week"] == target_week]
        all_entries.extend(week_entries)
    
    if not all_entries:
        return {"error": "No accomplishments found for the specified period"}
    
    # Count by category for metrics
    category_counts = {}
    for entry in all_entries:
        cat = entry["category"]
        category_counts[cat] = category_counts.get(cat, 0) + 1
    
    # 1. One-on-One Format
    outputs["one_on_one"] = f"""Weekly Accomplishments Update

This Week's Key Contributions:
{chr(10).join(f'• {e["note"]}' for e in all_entries[:5])}

Impact Summary:
• Delivered {len(all_entries)} key initiatives
• Focused on {max(category_counts, key=category_counts.get)} ({max(category_counts.values())} items)
• Continued progress on strategic objectives

Next Week's Focus:
• Build on this week's momentum
• Address any pending items
• Align with team priorities
"""

    # 2. Performance Review Format
    outputs["performance_review"] = f"""Performance Period Accomplishments

Technical Excellence:
{chr(10).join(f'• {e["note"]}' for e in all_entries if e["category"] == "technical")}

Business Impact:
{chr(10).join(f'• {e["note"]}' for e in all_entries if e["category"] in ["general", "innovation"])}

Leadership & Collaboration:
{chr(10).join(f'• {e["note"]}' for e in all_entries if e["category"] == "team")}

Risk & Compliance Management:
{chr(10).join(f'• {e["note"]}' for e in all_entries if e["category"] == "compliance")}

Quantified Impact:
• {len(all_entries)} documented contributions
• Consistent delivery across {len(category_counts)} key areas
• Proactive approach to continuous improvement
"""

    # 3. LinkedIn/Resume Bullets
    outputs["resume_bullets"] = f"""Professional Accomplishments:

{chr(10).join(f'• {e["note"]}' for e in sorted(all_entries, key=lambda x: len(x["note"]), reverse=True)[:8])}

Key Strengths Demonstrated:
• Strategic thinking and execution
• Cross-functional collaboration
• Technical innovation
• Results-driven approach
"""

    return outputs

def interactive_mode():
    """Interactive menu for the tool"""
    while True:
        print("\n" + "=" * 50)
        print("Weekly Accomplishments Tracker")
        print("=" * 50)
        print("1. Add new accomplishment")
        print("2. View this week's summary")
        print("3. View last week's summary")
        print("4. Generate 1:1 format")
        print("5. Generate performance review format")
        print("6. Quick add (no category)")
        print("7. Exit")
        
        choice = input("\nSelect option (1-7): ").strip()
        
        if choice == "1":
            note = input("What did you accomplish? ")
            print("\nCategories: technical, compliance, team, innovation, general")
            category = input("Category (or press Enter for general): ").strip() or "general"
            add_accomplishment(note, category)
            print("✅ Added successfully!")
            
        elif choice == "2":
            print("\n" + get_week_summary(0))
            
        elif choice == "3":
            print("\n" + get_week_summary(1))
            
        elif choice == "4":
            formats = generate_formats(1)
            print("\n--- One-on-One Format ---")
            print(formats.get("one_on_one", "No data"))
            
        elif choice == "5":
            formats = generate_formats(4)  # Last 4 weeks
            print("\n--- Performance Review Format ---")
            print(formats.get("performance_review", "No data"))
            
        elif choice == "6":
            note = input("Quick note: ")
            add_accomplishment(note)
            print("✅ Added!")
            
        elif choice == "7":
            break

def main():
    import sys
    
    if len(sys.argv) > 1:
        # Quick add mode
        note = " ".join(sys.argv[1:])
        add_accomplishment(note)
        print(f"✅ Added: {note}")
    else:
        # Interactive mode
        interactive_mode()

if __name__ == "__main__":
    main()