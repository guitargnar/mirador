#!/usr/bin/env python3
"""
Email Action Parser - Find what matters in email novels
Turns 5-paragraph emails into clear action items
"""

import re
import datetime
from typing import List, Dict, Tuple

# Action words that indicate tasks
ACTION_INDICATORS = [
    'please', 'need', 'must', 'should', 'will you', 'can you', 'could you',
    'required', 'by', 'before', 'deadline', 'due', 'urgent', 'asap',
    'action', 'review', 'approve', 'submit', 'complete', 'finish',
    'send', 'provide', 'update', 'confirm', 'let me know', 'follow up',
    'check', 'verify', 'ensure', 'prepare', 'draft', 'create', 'schedule'
]

# Time indicators
TIME_PATTERNS = [
    r'by (\w+day)',  # by Monday, by Friday
    r'by (\d{1,2}/\d{1,2})',  # by 12/15
    r'before (\w+day)',  # before Tuesday
    r'(today|tomorrow|tonight)',
    r'by (EOD|COB|EOP)',  # end of day/business/period
    r'(ASAP|urgent|immediately)',
    r'(next week|this week|next month)',
    r'by (\w+ \d{1,2})'  # by December 15
]

# FYI indicators
FYI_INDICATORS = [
    'fyi', 'for your information', 'heads up', 'just so you know',
    'update:', 'reminder:', 'note:', 'please note',
    'has been', 'was moved', 'is scheduled', 'will be'
]

def extract_sender_info(email_text: str) -> Dict[str, str]:
    """Extract sender and recipient info from email headers"""
    info = {
        'sender': 'Unknown',
        'your_name': 'You',
        'subject': 'No subject'
    }
    
    # Look for From: line
    from_match = re.search(r'From:\s*([^\n<]+)', email_text, re.IGNORECASE)
    if from_match:
        info['sender'] = from_match.group(1).strip().split()[0]  # First name only
    
    # Look for Subject: line
    subject_match = re.search(r'Subject:\s*([^\n]+)', email_text, re.IGNORECASE)
    if subject_match:
        info['subject'] = subject_match.group(1).strip()
    
    return info

def identify_people_mentioned(text: str) -> List[str]:
    """Find people mentioned in the email"""
    people = []
    
    # Look for common name patterns
    # "John will...", "Sarah needs to...", "Ask Michael to..."
    name_patterns = [
        r'([A-Z][a-z]+)\s+will',
        r'([A-Z][a-z]+)\s+needs?\s+to',
        r'([A-Z][a-z]+)\s+should',
        r'([A-Z][a-z]+)\s+must',
        r'([A-Z][a-z]+)\s+to\s+\w+',
        r'([A-Z][a-z]+)\s+can\s+you',
        r'([A-Z][a-z]+)\s+has\s+to',
        r'([A-Z][a-z]+)\'s\s+team',
    ]
    
    for pattern in name_patterns:
        matches = re.findall(pattern, text)
        people.extend(matches)
    
    # Also look for @mentions or "cc: Name"
    at_mentions = re.findall(r'@([A-Z][a-z]+)', text)
    people.extend(at_mentions)
    
    return list(set(people))  # Remove duplicates

def extract_actions(email_text: str) -> List[Dict[str, str]]:
    """Extract action items from email"""
    actions = []
    sentences = re.split(r'[.!?\n]+', email_text)
    
    info = extract_sender_info(email_text)
    people = identify_people_mentioned(email_text)
    
    for sentence in sentences:
        sentence = sentence.strip()
        if len(sentence) < 10:
            continue
            
        sentence_lower = sentence.lower()
        
        # Check if it's an action item
        is_action = any(indicator in sentence_lower for indicator in ACTION_INDICATORS)
        
        if is_action:
            # Determine WHO
            owner = "YOU"  # Default assumption
            
            # Check if it's assigned to someone else
            for person in people:
                if person in sentence and person.lower() != info['your_name'].lower():
                    owner = person
                    break
            
            # If it has "I will" or "I'll", it's from sender
            if re.search(r'\b(I will|I\'ll|I am|I\'m)\b', sentence):
                owner = info['sender']
            
            # Extract WHEN
            deadline = "Not specified"
            for pattern in TIME_PATTERNS:
                match = re.search(pattern, sentence_lower)
                if match:
                    deadline = match.group(1).upper()
                    break
            
            # Clean up the action
            action = sentence
            # Remove email artifacts
            action = re.sub(r'^(RE:|FW:|>)+', '', action).strip()
            
            actions.append({
                'owner': owner,
                'action': action,
                'deadline': deadline,
                'priority': 'High' if any(word in sentence_lower for word in ['urgent', 'asap', 'critical']) else 'Normal'
            })
    
    return actions

def extract_fyi_items(email_text: str) -> List[str]:
    """Extract FYI/informational items"""
    fyi_items = []
    sentences = re.split(r'[.!?\n]+', email_text)
    
    for sentence in sentences:
        sentence = sentence.strip()
        sentence_lower = sentence.lower()
        
        # Check if it's FYI
        is_fyi = any(indicator in sentence_lower for indicator in FYI_INDICATORS)
        
        # Also check for past tense informational updates
        if not is_fyi:
            is_fyi = re.search(r'\b(was|were|has been|have been|is now|are now)\b', sentence_lower) is not None
        
        if is_fyi and len(sentence) > 20:
            # Clean up
            sentence = re.sub(r'^(RE:|FW:|>)+', '', sentence).strip()
            fyi_items.append(sentence)
    
    return fyi_items[:5]  # Limit to top 5

def generate_response(actions: List[Dict[str, str]], sender: str) -> str:
    """Generate a professional response"""
    your_actions = [a for a in actions if a['owner'] == 'YOU']
    
    if not your_actions:
        return f"Thanks {sender}. I've reviewed this and noted the information."
    
    response = f"Thanks {sender}. "
    
    if len(your_actions) == 1:
        action = your_actions[0]
        response += f"I'll {action['action'].lower()} "
        if action['deadline'] != 'Not specified':
            response += f"by {action['deadline']}."
        else:
            response += "and keep you updated."
    else:
        response += "I'll handle the following:\n"
        for action in your_actions:
            response += f"• {action['action']}"
            if action['deadline'] != 'Not specified':
                response += f" (by {action['deadline']})"
            response += "\n"
    
    return response

def main():
    print("Email Action Parser - Extract What Matters")
    print("=" * 60)
    print("Paste your email below (including From/Subject if visible)")
    print("Press Enter twice when done:")
    print("=" * 60)
    
    # Collect email input
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
    
    if len(email_text) < 50:
        print("\n❌ Email too short. Please paste the full email.")
        return
    
    # Process the email
    print("\n🔍 Analyzing email...")
    
    info = extract_sender_info(email_text)
    actions = extract_actions(email_text)
    fyi_items = extract_fyi_items(email_text)
    
    # Generate output
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    output_file = f"email_actions_{timestamp}.md"
    
    with open(output_file, 'w') as f:
        f.write(f"# Email Action Summary\n")
        f.write(f"**From:** {info['sender']}  \n")
        f.write(f"**Subject:** {info['subject']}  \n")
        f.write(f"**Analyzed:** {datetime.datetime.now().strftime('%Y-%m-%d %H:%M')}  \n\n")
        
        # Your actions
        your_actions = [a for a in actions if a['owner'] == 'YOU']
        if your_actions:
            f.write("## 🎯 YOUR ACTION ITEMS\n\n")
            for action in your_actions:
                f.write(f"- [ ] {action['action']}\n")
                f.write(f"  - **Due:** {action['deadline']}\n")
                f.write(f"  - **Priority:** {action['priority']}\n\n")
        
        # Others' actions
        other_actions = [a for a in actions if a['owner'] != 'YOU']
        if other_actions:
            f.write("## 👥 OTHERS' ACTION ITEMS\n\n")
            for action in other_actions:
                f.write(f"- **{action['owner']}:** {action['action']}\n")
                f.write(f"  - Due: {action['deadline']}\n\n")
        
        # FYI items
        if fyi_items:
            f.write("## 📋 FYI / UPDATES\n\n")
            for item in fyi_items:
                f.write(f"- {item}\n")
        
        # Draft response
        if your_actions:
            f.write("\n## 📧 SUGGESTED RESPONSE\n\n")
            f.write("```\n")
            f.write(generate_response(actions, info['sender']))
            f.write("\n```\n")
        
        # One-line summary
        f.write("\n## 📌 ONE-LINE SUMMARY\n\n")
        if your_actions:
            f.write(f"{len(your_actions)} action(s) for you")
            if your_actions[0]['deadline'] != 'Not specified':
                f.write(f", first due {your_actions[0]['deadline']}")
        else:
            f.write("No actions required - informational only")
    
    # Console output
    print("\n" + "=" * 60)
    print("✅ EMAIL PARSED SUCCESSFULLY")
    print("=" * 60)
    
    if your_actions:
        print(f"\n🎯 YOUR ACTIONS ({len(your_actions)}):")
        for action in your_actions:
            print(f"\n• {action['action']}")
            print(f"  Due: {action['deadline']}")
    else:
        print("\n✅ No actions required from you")
    
    if other_actions:
        print(f"\n👥 OTHERS' ACTIONS ({len(other_actions)}):")
        for action in other_actions[:3]:  # Show first 3
            print(f"• {action['owner']}: {action['action'][:60]}...")
    
    if fyi_items:
        print(f"\n📋 FYI ITEMS ({len(fyi_items)}):")
        print(f"• {fyi_items[0][:80]}...")
    
    print(f"\n📄 Full analysis saved to: {output_file}")
    
    if your_actions:
        print("\n📧 SUGGESTED RESPONSE:")
        print("-" * 40)
        print(generate_response(actions, info['sender']))
        print("-" * 40)
    
    print("\n💡 Pro tip: Add action items to your task tracker!")

if __name__ == "__main__":
    main()