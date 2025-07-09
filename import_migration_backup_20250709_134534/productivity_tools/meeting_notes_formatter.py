#!/usr/bin/env python3
"""
Meeting Notes Formatter - Turn messy notes into professional updates
Works on restricted corporate machines with just Python
"""

import sys
import datetime
from typing import List, Dict

def format_meeting_notes(raw_notes: str) -> Dict[str, str]:
    """
    Transform raw meeting notes into multiple professional formats
    """
    # Clean up the input
    lines = [line.strip() for line in raw_notes.split('\n') if line.strip()]
    
    # Extract key elements
    date = datetime.datetime.now().strftime("%B %d, %Y")
    
    # Identify action items (lines with -, *, TODO, ACTION, etc.)
    action_items = []
    decisions = []
    discussion_points = []
    questions = []
    
    for line in lines:
        line_upper = line.upper()
        if any(marker in line for marker in ['TODO', 'ACTION', 'FOLLOW UP', 'NEXT STEP']):
            action_items.append(line)
        elif any(marker in line for marker in ['DECIDED', 'DECISION:', 'AGREED']):
            decisions.append(line)
        elif '?' in line:
            questions.append(line)
        else:
            discussion_points.append(line)
    
    # Generate different formats
    outputs = {}
    
    # 1. Executive Summary (for managers)
    outputs['executive_summary'] = f"""Meeting Summary - {date}

Key Outcomes:
{chr(10).join(f'• {d}' for d in decisions[:3]) if decisions else '• Meeting objectives discussed and aligned'}

Action Items:
{chr(10).join(f'• {a}' for a in action_items[:5]) if action_items else '• No immediate actions required'}

Next Steps:
• Follow-up meeting scheduled for next week
• Documentation to be shared via Teams
"""

    # 2. Teams/Email Update (for broad distribution)
    outputs['teams_update'] = f"""Hi team,

Following up on today's meeting, here's a quick summary:

**What we discussed:**
{chr(10).join(f'- {p}' for p in discussion_points[:3]) if discussion_points else '- Project status and timeline'}

**Key decisions:**
{chr(10).join(f'- {d}' for d in decisions) if decisions else '- Continuing with current approach'}

**Action items:**
{chr(10).join(f'- {a}' for a in action_items) if action_items else '- No new actions at this time'}

Let me know if I missed anything or if you have questions.

Thanks,
Matthew
"""

    # 3. Personal Performance Tracker (for your records)
    outputs['performance_tracker'] = f"""Performance Log Entry - {date}

Meeting Participation:
- Actively contributed to discussion
- Identified key risks/opportunities
- Proposed solutions for {len(action_items)} action items

My Commitments:
{chr(10).join(f'- {a}' for a in action_items if any(word in a.upper() for word in ['I', 'MY', 'MATTHEW']))}

Value Added:
- Facilitated clear decision-making
- Ensured alignment on next steps
- Documented outcomes for team reference

Skills Demonstrated:
- Strategic thinking
- Clear communication
- Stakeholder management
"""

    # 4. CMS Compliance Format (for regulatory items)
    outputs['cms_format'] = f"""CMS Guidance Review - {date}

Potential Web Impacts Identified:
{chr(10).join(f'• {q}' for q in questions[:3]) if questions else '• No immediate web impacts identified'}

Compliance Considerations:
• Review required for Medicare website updates
• Stakeholder communication plan needed
• Timeline aligns with CMS requirements

Recommended Actions:
{chr(10).join(f'1. {a}' for i, a in enumerate(action_items[:3]))}

Risk Assessment: Low/Medium/High based on discussion
"""

    return outputs

def main():
    print("Meeting Notes Formatter")
    print("=" * 50)
    print("Paste your meeting notes below (press Enter twice when done):")
    
    # Collect multi-line input
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
    
    # Generate all formats
    outputs = format_meeting_notes(raw_notes)
    
    # Save to files
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    
    print("\n" + "=" * 50)
    print("Generated Outputs:")
    print("=" * 50)
    
    for format_name, content in outputs.items():
        filename = f"meeting_{format_name}_{timestamp}.txt"
        with open(filename, 'w') as f:
            f.write(content)
        
        print(f"\n--- {format_name.replace('_', ' ').title()} ---")
        print(content)
        print(f"\nSaved to: {filename}")
        print("-" * 50)
    
    print("\n✅ All formats generated successfully!")
    print("\nQuick Actions:")
    print("1. Copy executive summary to email")
    print("2. Paste Teams update to chat")
    print("3. Add performance tracker to your records")
    print("4. File CMS format if regulatory items discussed")

if __name__ == "__main__":
    main()