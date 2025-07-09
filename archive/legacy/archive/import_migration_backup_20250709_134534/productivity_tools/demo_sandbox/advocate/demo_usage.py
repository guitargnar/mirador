#!/usr/bin/env python3
"""
Demo script showing how to use the productivity tools
"""

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from meeting_notes_formatter import format_meeting_notes
from email_action_parser import extract_actions
from cms_guidance_analyzer import extract_web_impacts
from weekly_accomplishments_tracker import add_accomplishment, get_current_week_accomplishments
from analytics_tracker import track_usage, generate_report

print("🎯 PRODUCTIVITY TOOLS DEMO")
print("=" * 60)

# Demo 1: Meeting Notes Formatter
print("\n📝 DEMO 1: Meeting Notes Formatter")
print("-" * 40)

meeting_notes = """discussed q4 targets with sarah and mike
budget concerns raised by finance team  
john will review proposal by friday
decision: postpone product launch to january
action: sarah to draft communication plan
action: mike to revise budget projections"""

print("Raw notes:")
print(meeting_notes)
print("\nFormatting...")

formatted = format_meeting_notes(meeting_notes)
print("\n✅ Executive Summary:")
print(formatted['executive_summary'])

# Demo 2: Email Action Parser
print("\n\n📧 DEMO 2: Email Action Parser")
print("-" * 40)

email_text = """From: Sarah Johnson
To: Team
Subject: Q4 Planning Follow-up

Hi everyone,

Following our meeting, here are the next steps:

John will review the compliance proposal by Friday EOD.
Mike needs to update the budget projections by next Tuesday.
I'll draft the stakeholder communication plan and share it by Thursday.

Please let me know if you have any questions.

Best,
Sarah"""

print("Email content:")
print(email_text[:100] + "...")

actions = extract_actions(email_text)
print("\n✅ Extracted Actions:")
for i, action in enumerate(actions, 1):
    print(f"{i}. {action['assignee']}: {action['task']} (by {action['deadline']})")

# Demo 3: Weekly Accomplishments Tracker
print("\n\n🏆 DEMO 3: Weekly Accomplishments Tracker")
print("-" * 40)

# Simulate adding accomplishments
accomplishments = [
    "Completed risk assessment for Q4 compliance requirements",
    "Reduced email processing time by 2 hours using productivity tools",
    "Led successful Q4 planning meeting with stakeholders"
]

print("Adding accomplishments:")
for acc in accomplishments:
    add_accomplishment(acc, category="demo")
    print(f"  ✓ {acc}")

# Demo 4: CMS Analyzer (abbreviated)
print("\n\n🏥 DEMO 4: CMS Guidance Analyzer")
print("-" * 40)

cms_text = """Federal Register Final Rule
The website must prominently display the plan's star ratings on the homepage.
Provider directories shall be updated within 30 days of changes.
All member portals must include accessibility features compliant with WCAG 2.1.
Plans must provide downloadable formulary information in machine-readable format."""

print("Sample CMS text analyzed...")
impacts = extract_web_impacts(cms_text)
print(f"\n✅ Found {len(impacts)} web compliance requirements")
if impacts:
    print(f"   Top priority: {impacts[0][0][:80]}...")

# Demo 5: Analytics
print("\n\n📊 DEMO 5: Time Savings Analytics")
print("-" * 40)

# Track simulated usage
track_usage("meeting_notes", "demo_user", 20)
track_usage("email_parser", "demo_user", 30)
track_usage("cms_analyzer", "demo_user", 180)

print("Time saved in this demo:")
print("  • Meeting notes: 20 minutes")
print("  • Email parsing: 30 minutes")
print("  • CMS analysis: 180 minutes")
print("  • Total: 3.8 hours saved!")

# Hidden Feature Demo
print("\n\n🎁 HIDDEN FEATURE: Tool Integration")
print("-" * 40)
print("The tools can share data!")
print("Meeting notes → Email draft → Accomplishments tracking")
print("This creates an integrated productivity workflow!")

print("\n" + "=" * 60)
print("✨ That's the power of the Productivity Tools!")
print("Simple to use, powerful results, zero setup required.")
print("=" * 60)