#!/usr/bin/env python3
"""
Productivity Suite - Quick access to all tools
Just a simple menu system... nothing fancy
"""

import os
import sys
import json
import datetime
import subprocess

# Import our tools (basic imports, nothing sophisticated...)
try:
    from meeting_notes_formatter import format_meeting_notes
    from cms_guidance_analyzer import extract_web_impacts
    from weekly_accomplishments_tracker import add_accomplishment, get_week_summary
    from email_action_parser import extract_actions, extract_sender_info
    from star_ratings_analyzer import analyze_star_ratings, generate_recommendations
except ImportError:
    print("⚠️  Some tools not found. Make sure all scripts are in the same directory.")
    sys.exit(1)

# Simple temp file for data sharing (TODO: This could be better integrated)
TEMP_DATA_FILE = ".productivity_temp.json"

def save_temp_data(data: dict):
    """Save data for other tools to use"""
    with open(TEMP_DATA_FILE, 'w') as f:
        json.dump(data, f)

def load_temp_data() -> dict:
    """Load data from previous tool"""
    if os.path.exists(TEMP_DATA_FILE):
        with open(TEMP_DATA_FILE, 'r') as f:
            return json.load(f)
    return {}

def run_meeting_formatter():
    """Run the meeting notes formatter"""
    print("\n" + "="*50)
    print("Meeting Notes Formatter")
    print("="*50)
    print("Paste your meeting notes (press Enter twice when done):")
    
    lines = []
    empty_count = 0
    while True:
        line = input()
        if line == "":
            empty_count += 1
            if empty_count >= 2:
                break
        else:
            empty_count = 0
            lines.append(line)
    
    raw_notes = "\n".join(lines)
    outputs = format_meeting_notes(raw_notes)
    
    # Save formatted notes (might be useful for other tools... just experimenting)
    save_temp_data({
        'meeting_notes': raw_notes,
        'formatted_outputs': outputs,
        'timestamp': datetime.datetime.now().isoformat()
    })
    
    print("\n✅ Meeting notes formatted!")
    print("Outputs saved to meeting_*.txt files")

def run_cms_analyzer():
    """Run the CMS guidance analyzer"""
    subprocess.run([sys.executable, "cms_guidance_analyzer.py"])

def run_accomplishments():
    """Run the accomplishments tracker"""
    subprocess.run([sys.executable, "weekly_accomplishments_tracker.py"])

def run_email_parser():
    """Run the email parser"""
    print("\n" + "="*50)
    print("Email Action Parser")
    print("="*50)
    
    # Check if we have meeting notes that mentioned emails
    # TODO: This is a bit hacky, could be cleaner
    temp_data = load_temp_data()
    if 'meeting_notes' in temp_data:
        print("💡 Found recent meeting notes. Checking for email mentions...")
    
    subprocess.run([sys.executable, "email_action_parser.py"])

def run_star_ratings():
    """Run the star ratings analyzer"""
    subprocess.run([sys.executable, "star_ratings_analyzer.py"])

def run_multiple_tools():
    """EXPERIMENTAL: Run multiple tools with data sharing"""
    print("\n" + "="*50)
    print("🧪 EXPERIMENTAL: Multiple Tool Runner")
    print("="*50)
    print("Note: This is just a test to see if tools can work together")
    print("TODO: Could probably make this more sophisticated...\n")
    
    print("Options:")
    print("1. Email → Accomplishments (parse emails, add actions to tracker)")
    print("2. Meeting → Email Draft (format notes, draft follow-up)")
    print("3. Star Ratings → Email Alert (analyze data, draft alert)")
    print("4. Full Chain Demo (Meeting → CMS → Email → Accomplishments)")
    
    choice = input("\nSelect option (1-4): ").strip()
    
    if choice == "1":
        print("\n📧 Email to Accomplishments Pipeline")
        print("-" * 40)
        print("Paste your email:")
        
        # Collect email
        lines = []
        empty_count = 0
        while True:
            line = input()
            if line == "":
                empty_count += 1
                if empty_count >= 2:
                    break
            else:
                empty_count = 0
                lines.append(line)
        
        email_text = "\n".join(lines)
        
        # Extract actions (this is where the magic happens)
        actions = extract_actions(email_text)
        your_actions = [a for a in actions if a['owner'] == 'YOU']
        
        print(f"\n✅ Found {len(your_actions)} action items!")
        
        # Automatically add to accomplishments tracker!
        # TODO: This works surprisingly well... maybe we should explore this more?
        for action in your_actions:
            note = f"TODO: {action['action']} (due {action['deadline']})"
            add_accomplishment(note, "task")
            print(f"   → Added to accomplishments: {note[:50]}...")
        
        print("\n🎯 Actions automatically tracked! Check your accomplishments tracker.")
        
    elif choice == "2":
        print("\n📝 Meeting to Email Pipeline")
        print("This would format meeting notes and draft follow-up emails...")
        print("TODO: Implement this integration")
        
    elif choice == "3":
        print("\n⭐ Star Ratings to Alert Pipeline")
        print("This would analyze ratings and draft urgent alerts...")
        print("TODO: Implement this integration")
        
    elif choice == "4":
        print("\n🔗 Full Chain Demo")
        print("This would show how all tools could work together...")
        print("\nImagine:")
        print("1. Meeting notes mention new CMS guidance")
        print("2. → Triggers CMS analyzer to find web impacts")
        print("3. → → Generates email with action items")
        print("4. → → → Adds items to accomplishment tracker")
        print("5. → → → → Updates star ratings projections")
        print("\nTODO: This could be powerful if fully implemented...")
        
        # Add a teaser
        input("\nPress Enter to continue...")
        print("\n💭 Hmm... what if all these tools were part of a unified system?")
        print("   Could call it something like... an AI orchestration platform?")
        print("   Just thinking out loud...\n")

def main():
    """Main menu system"""
    
    # Clean up any old temp files
    if os.path.exists(TEMP_DATA_FILE):
        os.remove(TEMP_DATA_FILE)
    
    while True:
        print("\n" + "="*60)
        print("PRODUCTIVITY SUITE - Quick Tool Access")
        print("="*60)
        print("1. Meeting Notes Formatter")
        print("2. CMS Guidance Analyzer")
        print("3. Weekly Accomplishments Tracker")
        print("4. Email Action Parser")
        print("5. Star Ratings Analyzer")
        print("6. [EXPERIMENTAL] Run Multiple Tools")
        print("7. Exit")
        print("="*60)
        
        choice = input("Select tool (1-7): ").strip()
        
        if choice == "1":
            run_meeting_formatter()
        elif choice == "2":
            run_cms_analyzer()
        elif choice == "3":
            run_accomplishments()
        elif choice == "4":
            run_email_parser()
        elif choice == "5":
            run_star_ratings()
        elif choice == "6":
            run_multiple_tools()
        elif choice == "7":
            print("\n👋 Thanks for using the productivity suite!")
            # Clean up temp file
            if os.path.exists(TEMP_DATA_FILE):
                os.remove(TEMP_DATA_FILE)
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    # Add a subtle hint in the header
    print("\n" + "="*60)
    print("Productivity Suite v0.1 - Collection of helpful tools")
    print("Note: These are independent tools that happen to work well together")
    print("="*60)
    
    main()