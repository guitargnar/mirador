#!/usr/bin/env python3
"""
School Transfer Tracker - A CLI tool to manage JCPS school transfer efforts
"""

import json
import os
from datetime import datetime
from typing import Dict, List, Optional
import sys

class SchoolTransferTracker:
    def __init__(self, data_file="transfer_data.json"):
        self.data_file = data_file
        self.data = self.load_data()
    
    def load_data(self) -> Dict:
        """Load existing data or create new structure"""
        if os.path.exists(self.data_file):
            with open(self.data_file, 'r') as f:
                return json.load(f)
        else:
            return {
                "target_schools": {},
                "contacts": {},
                "resources": {},
                "activity_log": [],
                "reminders": []
            }
    
    def save_data(self):
        """Save data to file"""
        with open(self.data_file, 'w') as f:
            json.dump(self.data, f, indent=2)
    
    def add_school(self):
        """Add a target school"""
        print("\n=== Add Target School ===")
        name = input("School name: ").strip()
        if not name:
            print("School name cannot be empty")
            return
        
        self.data["target_schools"][name] = {
            "priority": input("Priority (high/medium/low): ").strip().lower() or "medium",
            "contact_info": input("Main phone number: ").strip(),
            "notes": input("Initial notes: ").strip(),
            "last_contacted": None,
            "status": "monitoring"
        }
        self.save_data()
        print(f"✓ Added {name} to target schools")
    
    def add_contact(self):
        """Add a contact person"""
        print("\n=== Add Contact ===")
        name = input("Contact name: ").strip()
        if not name:
            print("Contact name cannot be empty")
            return
        
        self.data["contacts"][name] = {
            "phone": input("Phone number: ").strip(),
            "email": input("Email (optional): ").strip(),
            "affiliation": input("School/Organization: ").strip(),
            "role": input("Role (parent/staff/admin): ").strip(),
            "notes": input("Initial notes: ").strip(),
            "interactions": []
        }
        self.save_data()
        print(f"✓ Added {name} to contacts")
    
    def log_interaction(self):
        """Log an interaction with a contact"""
        print("\n=== Log Interaction ===")
        
        # Show existing contacts
        if not self.data["contacts"]:
            print("No contacts found. Add a contact first.")
            return
        
        print("\nSelect contact:")
        contacts = list(self.data["contacts"].keys())
        for i, contact in enumerate(contacts, 1):
            print(f"{i}. {contact}")
        
        try:
            choice = int(input("\nContact number: ")) - 1
            if 0 <= choice < len(contacts):
                contact_name = contacts[choice]
            else:
                print("Invalid selection")
                return
        except ValueError:
            print("Invalid input")
            return
        
        # Log the interaction
        interaction = {
            "date": datetime.now().isoformat(),
            "type": input("Type (call/email/text/meeting): ").strip(),
            "summary": input("Summary: ").strip(),
            "learned": input("What did you learn? ").strip(),
            "follow_up": input("Follow-up needed? ").strip()
        }
        
        self.data["contacts"][contact_name]["interactions"].append(interaction)
        
        # Also add to activity log
        self.data["activity_log"].append({
            "date": interaction["date"],
            "type": "contact_interaction",
            "contact": contact_name,
            "details": interaction["summary"]
        })
        
        self.save_data()
        print(f"✓ Logged interaction with {contact_name}")
    
    def add_resource(self):
        """Add a resource"""
        print("\n=== Add Resource ===")
        name = input("Resource name: ").strip()
        if not name:
            print("Resource name cannot be empty")
            return
        
        self.data["resources"][name] = {
            "type": input("Type (website/document/service/group): ").strip(),
            "description": input("Description: ").strip(),
            "url_or_location": input("URL or location: ").strip(),
            "notes": input("Notes: ").strip(),
            "added_date": datetime.now().isoformat()
        }
        self.save_data()
        print(f"✓ Added {name} to resources")
    
    def update_school_status(self):
        """Update status of a target school"""
        print("\n=== Update School Status ===")
        
        if not self.data["target_schools"]:
            print("No target schools found.")
            return
        
        print("\nSelect school:")
        schools = list(self.data["target_schools"].keys())
        for i, school in enumerate(schools, 1):
            status = self.data["target_schools"][school]["status"]
            print(f"{i}. {school} (current: {status})")
        
        try:
            choice = int(input("\nSchool number: ")) - 1
            if 0 <= choice < len(schools):
                school_name = schools[choice]
            else:
                print("Invalid selection")
                return
        except ValueError:
            print("Invalid input")
            return
        
        print("\nNew status options:")
        print("1. monitoring - Checking for openings")
        print("2. contacted - Made initial contact")
        print("3. waitlisted - On official waitlist")
        print("4. opening_possible - Potential seat available")
        print("5. accepted - Transfer approved!")
        print("6. declined - No seats available")
        
        status_map = {
            "1": "monitoring",
            "2": "contacted", 
            "3": "waitlisted",
            "4": "opening_possible",
            "5": "accepted",
            "6": "declined"
        }
        
        status_choice = input("\nStatus number: ").strip()
        if status_choice in status_map:
            self.data["target_schools"][school_name]["status"] = status_map[status_choice]
            self.data["target_schools"][school_name]["last_contacted"] = datetime.now().isoformat()
            
            notes = input("Additional notes: ").strip()
            if notes:
                self.data["target_schools"][school_name]["notes"] += f"\n[{datetime.now().strftime('%Y-%m-%d')}] {notes}"
            
            # Log activity
            self.data["activity_log"].append({
                "date": datetime.now().isoformat(),
                "type": "status_update",
                "school": school_name,
                "new_status": status_map[status_choice]
            })
            
            self.save_data()
            print(f"✓ Updated {school_name} status to {status_map[status_choice]}")
        else:
            print("Invalid status selection")
    
    def view_dashboard(self):
        """View current status dashboard"""
        print("\n" + "="*60)
        print("SCHOOL TRANSFER DASHBOARD")
        print("="*60)
        
        # Target Schools Status
        print("\n📚 TARGET SCHOOLS:")
        if self.data["target_schools"]:
            for school, info in self.data["target_schools"].items():
                status_emoji = {
                    "monitoring": "👀",
                    "contacted": "📞",
                    "waitlisted": "⏳",
                    "opening_possible": "🎯",
                    "accepted": "✅",
                    "declined": "❌"
                }.get(info["status"], "❓")
                
                print(f"\n  {status_emoji} {school}")
                print(f"     Priority: {info['priority']} | Status: {info['status']}")
                print(f"     Phone: {info['contact_info']}")
                if info["last_contacted"]:
                    last_contact = datetime.fromisoformat(info["last_contacted"]).strftime("%m/%d/%Y")
                    print(f"     Last contact: {last_contact}")
        else:
            print("  No target schools added yet")
        
        # Key Contacts
        print("\n\n👥 KEY CONTACTS:")
        if self.data["contacts"]:
            for contact, info in self.data["contacts"].items():
                interaction_count = len(info["interactions"])
                print(f"  • {contact} ({info['affiliation']}) - {info['role']}")
                print(f"    Phone: {info['phone']} | Interactions: {interaction_count}")
        else:
            print("  No contacts added yet")
        
        # Recent Activity
        print("\n\n📅 RECENT ACTIVITY:")
        recent_activities = sorted(self.data["activity_log"], 
                                 key=lambda x: x["date"], 
                                 reverse=True)[:5]
        if recent_activities:
            for activity in recent_activities:
                date = datetime.fromisoformat(activity["date"]).strftime("%m/%d %I:%M%p")
                if activity["type"] == "contact_interaction":
                    print(f"  • {date}: Contacted {activity['contact']}")
                elif activity["type"] == "status_update":
                    print(f"  • {date}: {activity['school']} → {activity['new_status']}")
        else:
            print("  No recent activity")
        
        # Quick Stats
        print("\n\n📊 QUICK STATS:")
        total_schools = len(self.data["target_schools"])
        active_schools = sum(1 for s in self.data["target_schools"].values() 
                           if s["status"] not in ["declined", "accepted"])
        total_contacts = len(self.data["contacts"])
        total_interactions = sum(len(c["interactions"]) for c in self.data["contacts"].values())
        
        print(f"  • Monitoring {active_schools} of {total_schools} target schools")
        print(f"  • {total_contacts} contacts with {total_interactions} total interactions")
        print(f"  • {len(self.data['resources'])} resources saved")
    
    def search_notes(self):
        """Search through all notes and interactions"""
        print("\n=== Search Notes ===")
        query = input("Search term: ").strip().lower()
        
        if not query:
            print("Search term cannot be empty")
            return
        
        results = []
        
        # Search school notes
        for school, info in self.data["target_schools"].items():
            if query in info["notes"].lower():
                results.append(f"School: {school}\n  {info['notes']}")
        
        # Search contact interactions
        for contact, info in self.data["contacts"].items():
            for interaction in info["interactions"]:
                if (query in interaction["summary"].lower() or 
                    query in interaction["learned"].lower()):
                    date = datetime.fromisoformat(interaction["date"]).strftime("%m/%d/%Y")
                    results.append(f"Contact: {contact} ({date})\n  {interaction['summary']}\n  Learned: {interaction['learned']}")
        
        # Display results
        if results:
            print(f"\n🔍 Found {len(results)} results for '{query}':\n")
            for i, result in enumerate(results, 1):
                print(f"{i}. {result}\n")
        else:
            print(f"No results found for '{query}'")
    
    def quick_phone_list(self):
        """Display quick phone reference"""
        print("\n📱 QUICK PHONE REFERENCE")
        print("="*40)
        
        # JCPS numbers
        print("\nJCPS OFFICES:")
        print("  • School Choice Office: (502) 485-6250")
        print("  • Main Line: (502) 485-3011")
        
        # Target schools
        if self.data["target_schools"]:
            print("\nTARGET SCHOOLS:")
            for school, info in sorted(self.data["target_schools"].items(), 
                                      key=lambda x: x[1]["priority"]):
                if info["contact_info"]:
                    print(f"  • {school}: {info['contact_info']}")
        
        # Key contacts
        if self.data["contacts"]:
            print("\nKEY CONTACTS:")
            for contact, info in self.data["contacts"].items():
                if info["phone"]:
                    print(f"  • {contact} ({info['affiliation']}): {info['phone']}")
    
    def run(self):
        """Main menu loop"""
        while True:
            print("\n" + "="*40)
            print("SCHOOL TRANSFER TRACKER")
            print("="*40)
            print("1. View Dashboard")
            print("2. Add Target School")
            print("3. Add Contact")
            print("4. Log Interaction")
            print("5. Update School Status")
            print("6. Add Resource")
            print("7. Search Notes")
            print("8. Quick Phone List")
            print("9. Exit")
            
            choice = input("\nSelect option: ").strip()
            
            if choice == "1":
                self.view_dashboard()
            elif choice == "2":
                self.add_school()
            elif choice == "3":
                self.add_contact()
            elif choice == "4":
                self.log_interaction()
            elif choice == "5":
                self.update_school_status()
            elif choice == "6":
                self.add_resource()
            elif choice == "7":
                self.search_notes()
            elif choice == "8":
                self.quick_phone_list()
            elif choice == "9":
                print("\nGood luck with your transfer search! 🍀")
                break
            else:
                print("Invalid option. Please try again.")

if __name__ == "__main__":
    tracker = SchoolTransferTracker()
    tracker.run()