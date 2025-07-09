#!/usr/bin/env python3
"""
School Transfer Tracker v2 - Enhanced with JCPS resources and action context
For managing transfer from Shelby Academy Elementary
"""

import json
import os
from datetime import datetime
from typing import Dict, List, Optional
import sys
import webbrowser

class SchoolTransferTracker:
    def __init__(self, data_file="transfer_data.json"):
        self.data_file = data_file
        self.data = self.load_data()
        self.initialize_context()
    
    def load_data(self) -> Dict:
        """Load existing data or create new structure"""
        if os.path.exists(self.data_file):
            with open(self.data_file, 'r') as f:
                return json.load(f)
        else:
            return {
                "current_school": {
                    "name": "Shelby Academy Elementary",
                    "grade": "2nd Grade",
                    "concerns": [
                        "Math proficiency: 6-9% (vs 30% state average)",
                        "Reading proficiency: 15-19% (vs 42% state average)",
                        "28% enrollment decline over 5 years",
                        "30% teacher loss over 5 years",
                        "Ranked #1158 out of 1,230 schools in KY"
                    ],
                    "transfer_status": "Active - can transfer anytime a seat opens"
                },
                "target_schools": {},
                "contacts": {},
                "resources": {},
                "activity_log": [],
                "reminders": [],
                "action_items": []
            }
    
    def initialize_context(self):
        """Initialize with context from our conversation"""
        # Add target schools if not exists
        if not self.data["target_schools"]:
            default_schools = {
                "Greathouse/Shryock Traditional": {
                    "priority": "high",
                    "contact_info": "(502) 485-8295",
                    "notes": "Parents praise academic rigor and caring staff. 'Best experience ever' per parent review.",
                    "last_contacted": None,
                    "status": "monitoring"
                },
                "Norton Commons Elementary": {
                    "priority": "high",
                    "contact_info": "(502) 485-8388",
                    "notes": "4.5/5 GreatSchools rating. 'Couldn't be happier' per parent review.",
                    "last_contacted": None,
                    "status": "monitoring"
                },
                "Goshen Elementary": {
                    "priority": "high",
                    "contact_info": "(502) 485-8322",
                    "notes": "Strong parent satisfaction for individualized learning. 'We love it' - parent of 3-year student.",
                    "last_contacted": None,
                    "status": "monitoring"
                },
                "Anchorage Independent": {
                    "priority": "medium",
                    "contact_info": "(502) 245-1463",
                    "notes": "Top-rated but check district boundaries. A rating on Niche.",
                    "last_contacted": None,
                    "status": "monitoring"
                }
            }
            self.data["target_schools"] = default_schools
        
        # Add initial action items if not exists
        if not self.data["action_items"]:
            self.data["action_items"] = [
                {"task": "Monitor JCPS portal daily at 7am for seat openings", "priority": "high", "completed": False},
                {"task": "Join JCPS Parents Facebook group", "priority": "high", "completed": False},
                {"task": "Schedule meeting with Shelby principal (week of July 15)", "priority": "high", "completed": False},
                {"task": "Hire math tutor immediately", "priority": "high", "completed": False},
                {"task": "Get daughter assessed at Sylvan Learning for documentation", "priority": "medium", "completed": False},
                {"task": "Research and tour 2-3 private schools as backup", "priority": "medium", "completed": False},
                {"task": "Call Office of School Choice weekly", "priority": "high", "completed": False},
                {"task": "Document any anxiety about starting at Shelby", "priority": "medium", "completed": False}
            ]
        
        # Add key contacts if not exists
        if "JCPS School Choice Office" not in self.data["contacts"]:
            self.data["contacts"]["JCPS School Choice Office"] = {
                "phone": "(502) 485-6250",
                "email": "jcpsschoolchoice@jefferson.kyschools.us",
                "affiliation": "JCPS",
                "role": "admin",
                "notes": "Primary contact for all transfer questions. Office at 4309 Bishop Lane.",
                "interactions": []
            }
        
        self.save_data()
    
    def save_data(self):
        """Save data to file"""
        with open(self.data_file, 'w') as f:
            json.dump(self.data, f, indent=2)
    
    def view_dashboard(self):
        """View current status dashboard"""
        print("\n" + "="*70)
        print("🎯 SHELBY ACADEMY TRANSFER MISSION CONTROL")
        print("="*70)
        
        # Current situation
        print("\n⚠️  CURRENT SITUATION:")
        print(f"  School: {self.data['current_school']['name']}")
        print(f"  Grade: {self.data['current_school']['grade']}")
        print(f"  Status: {self.data['current_school']['transfer_status']}")
        print("\n  Key Concerns:")
        for concern in self.data['current_school']['concerns'][:3]:
            print(f"    • {concern}")
        
        # Target Schools Status
        print("\n\n📚 TARGET SCHOOLS:")
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
        
        # Action Items
        print("\n\n📋 TOP ACTION ITEMS:")
        incomplete_actions = [a for a in self.data["action_items"] if not a["completed"]]
        for i, action in enumerate(incomplete_actions[:5], 1):
            priority_emoji = "🔴" if action["priority"] == "high" else "🟡"
            print(f"  {priority_emoji} {i}. {action['task']}")
        
        # Quick Stats
        print("\n\n📊 QUICK STATS:")
        total_schools = len(self.data["target_schools"])
        active_schools = sum(1 for s in self.data["target_schools"].values() 
                           if s["status"] not in ["declined", "accepted"])
        completed_actions = sum(1 for a in self.data["action_items"] if a["completed"])
        total_actions = len(self.data["action_items"])
        
        print(f"  • Monitoring {active_schools} of {total_schools} target schools")
        print(f"  • Completed {completed_actions} of {total_actions} action items")
        print(f"  • Days until school starts: ~40 (early August)")
    
    def show_resources(self):
        """Show comprehensive JCPS resources menu"""
        while True:
            print("\n" + "="*60)
            print("📚 JCPS TRANSFER RESOURCES")
            print("="*60)
            print("\n1. Official JCPS Transfer Resources")
            print("2. School Rating & Review Sites")
            print("3. Parent Support Groups")
            print("4. Educational Advocacy Organizations")
            print("5. Tutoring & Supplemental Education")
            print("6. Private School Options")
            print("7. Homeschool Information")
            print("8. Resources for Low-Performing Schools")
            print("9. Quick Contact Directory")
            print("0. Back to Main Menu")
            
            choice = input("\nSelect resource category: ").strip()
            
            if choice == "1":
                self.show_jcps_transfer_resources()
            elif choice == "2":
                self.show_rating_sites()
            elif choice == "3":
                self.show_parent_groups()
            elif choice == "4":
                self.show_advocacy_orgs()
            elif choice == "5":
                self.show_tutoring_resources()
            elif choice == "6":
                self.show_private_schools()
            elif choice == "7":
                self.show_homeschool_info()
            elif choice == "8":
                self.show_low_performing_resources()
            elif choice == "9":
                self.quick_phone_list()
            elif choice == "0":
                break
    
    def show_jcps_transfer_resources(self):
        """Show official JCPS transfer information"""
        print("\n🏫 OFFICIAL JCPS TRANSFER RESOURCES")
        print("="*50)
        print("\n📋 Online Application Portal:")
        print("   https://apps.jefferson.kyschools.us/studentassignment/transferonlineapplication/")
        print("\n📞 Office of School Choice:")
        print("   Phone: (502) 485-6250")
        print("   Email: jcpsschoolchoice@jefferson.kyschools.us")
        print("   Address: 4309 Bishop Lane, Louisville, KY 40218")
        print("\n⏰ 2025-26 Transfer Window:")
        print("   May 5, 2025 to March 6, 2026")
        print("\n⚠️  Key Points:")
        print("   • Transfers based solely on available seats")
        print("   • No transportation provided")
        print("   • Must renew annually")
        print("   • Cannot use for magnet schools")
        
        if input("\nOpen transfer portal in browser? (y/n): ").lower() == 'y':
            webbrowser.open("https://apps.jefferson.kyschools.us/studentassignment/transferonlineapplication/")
    
    def show_rating_sites(self):
        """Show school rating websites"""
        print("\n📊 SCHOOL RATING & REVIEW SITES")
        print("="*50)
        print("\n1. GreatSchools.org")
        print("   • Louisville Schools: https://www.greatschools.org/kentucky/louisville/")
        print("   • Ratings based on academics and equity")
        print("\n2. Niche.com")
        print("   • Best Elementary: https://www.niche.com/k12/search/best-public-elementary-schools/m/louisville-metro-area/")
        print("   • User reviews and rankings")
        print("\n3. JCPS School Profiles")
        print("   • Official data: https://www.jefferson.kyschools.us/departments/data-management-research/school-profiles")
        print("   • Test scores, demographics, attendance")
        
        site = input("\nWhich site to open? (1-3, or 0 to skip): ").strip()
        urls = {
            "1": "https://www.greatschools.org/kentucky/louisville/",
            "2": "https://www.niche.com/k12/search/best-public-elementary-schools/m/louisville-metro-area/",
            "3": "https://www.jefferson.kyschools.us/departments/data-management-research/school-profiles"
        }
        if site in urls:
            webbrowser.open(urls[site])
    
    def show_parent_groups(self):
        """Show parent support groups"""
        print("\n👥 PARENT SUPPORT GROUPS")
        print("="*50)
        print("\n📱 Facebook Groups:")
        print("   • JCPS Parents: https://www.facebook.com/groups/337907878132865/")
        print("   • Official JCPS Page: https://www.facebook.com/JCPSKY/")
        print("\n🏛️ Organizations:")
        print("   • 15th District PTA - Advocates for Jefferson County children")
        print("   • Family Resource Centers (FRYSCs) - Support services")
        print("\n💡 Tips:")
        print("   • Post about needing transfer spots")
        print("   • Ask about specific teacher recommendations")
        print("   • Network with parents leaving schools")
    
    def show_tutoring_resources(self):
        """Show tutoring and supplemental education"""
        print("\n📚 TUTORING & SUPPLEMENTAL EDUCATION")
        print("="*50)
        print("\n🆓 FREE JCPS Resources:")
        print("   • FEV Tutor: 24/7 online tutoring via Clever")
        print("   • Homework Help: https://www.jefferson.kyschools.us/student-support/homework-help")
        print("   • Covers 200+ courses including test prep")
        print("\n📍 Elev8 Learning Centers:")
        print("   • West End: 2500 West Broadway")
        print("   • Hours: 2:30-7:30 PM school days")
        print("   • Free with transportation!")
        print("\n💰 Paid Options to Research:")
        print("   • Sylvan Learning Center")
        print("   • Kumon Math & Reading")
        print("   • Mathnasium")
        print("   • Private tutors ($25-60/hour)")
    
    def show_private_schools(self):
        """Show private school options"""
        print("\n🏫 PRIVATE SCHOOL OPTIONS")
        print("="*50)
        print("\nTop Schools:")
        print("   • Louisville Collegiate School")
        print("   • Kentucky Country Day School") 
        print("   • Francis Parker School")
        print("   • Highlands Latin School")
        print("\n💰 Financial Info:")
        print("   • Average tuition: $12,966/year")
        print("   • 30-40% of families receive aid")
        print("   • FACTS Financial Aid system")
        print("   • Early decision: December 18")
        print("\n☎️  Action: Call admissions about last-minute openings!")
    
    def show_homeschool_info(self):
        """Show homeschool information"""
        print("\n🏠 HOMESCHOOL INFORMATION")
        print("="*50)
        print("\n📋 Kentucky Requirements:")
        print("   • Notify superintendent within 10 days")
        print("   • 170 instructional days minimum")
        print("   • 1,062 instructional hours annually")
        print("   • Keep attendance records")
        print("   • NO standardized testing required!")
        print("\n📚 Resources:")
        print("   • KY Dept of Ed: https://www.education.ky.gov/federal/fed/Pages/Home-School.aspx")
        print("   • HSLDA Kentucky: https://hslda.org/legal/kentucky")
        print("\n👥 Local Support:")
        print("   • St. Thomas Aquinas Catholic Homeschool Group")
        print("   • Teen Homeschool Co-op Louisville")
    
    def show_low_performing_resources(self):
        """Show resources for parents with children in low-performing schools"""
        print("\n⚡ RESOURCES FOR LOW-PERFORMING SCHOOLS")
        print("="*50)
        print("\n🎯 JCPS Accelerated Improvement Schools:")
        print("   • 25 schools get special support")
        print("   • Enhanced resources and attention")
        print("   • Professional development focus")
        print("\n📊 Get Involved:")
        print("   • Join School-Based Decision Making Council")
        print("   • Participate in CSIP planning")
        print("   • Title I Parent Advisory Council")
        print("\n🎓 Parent Leadership:")
        print("   • Governor's Commonwealth Institute")
        print("   • Training for school improvement")
        print("   • Priority given to struggling schools")
    
    def quick_phone_list(self):
        """Display quick phone reference"""
        print("\n📱 QUICK PHONE REFERENCE")
        print("="*50)
        
        print("\n🚨 CRITICAL NUMBERS:")
        print("  • School Choice Office: (502) 485-6250")
        print("  • JCPS Main: (502) 485-3011")
        print("  • Shelby Academy: (502) 485-8331")
        
        print("\n🎯 TARGET SCHOOLS:")
        for school, info in self.data["target_schools"].items():
            if info["priority"] == "high":
                print(f"  • {school}: {info['contact_info']}")
        
        print("\n📞 CALL SCRIPTS:")
        print("  'Hi, I have a 2nd grader with active transfer status.'")
        print("  'Are there any openings for the 2024-25 school year?'")
        print("  'Can I be added to your waitlist?'")
    
    def manage_action_items(self):
        """Manage action items checklist"""
        print("\n📋 ACTION ITEMS MANAGEMENT")
        print("="*50)
        
        for i, action in enumerate(self.data["action_items"], 1):
            status = "✅" if action["completed"] else "⬜"
            priority = "🔴" if action["priority"] == "high" else "🟡"
            print(f"{i}. {status} {priority} {action['task']}")
        
        print("\nOptions:")
        print("1. Mark item as completed")
        print("2. Add new action item")
        print("3. Return to main menu")
        
        choice = input("\nSelect option: ").strip()
        
        if choice == "1":
            item_num = input("Item number to complete: ").strip()
            try:
                idx = int(item_num) - 1
                if 0 <= idx < len(self.data["action_items"]):
                    self.data["action_items"][idx]["completed"] = True
                    self.save_data()
                    print("✅ Item marked as completed!")
            except:
                print("Invalid item number")
        
        elif choice == "2":
            task = input("New action item: ").strip()
            priority = input("Priority (high/medium): ").strip().lower() or "medium"
            self.data["action_items"].append({
                "task": task,
                "priority": priority,
                "completed": False
            })
            self.save_data()
            print("✅ Action item added!")
    
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
    
    def run(self):
        """Main menu loop"""
        while True:
            print("\n" + "="*60)
            print("🎯 SHELBY TRANSFER TRACKER - MISSION CONTROL")
            print("="*60)
            print("1. 📊 View Dashboard")
            print("2. 📚 JCPS Resources & Information Hub")
            print("3. 📋 Manage Action Items")
            print("4. 🏫 Add/Update Target School")
            print("5. 👥 Add Contact")
            print("6. 📞 Log Interaction")
            print("7. 🔄 Update School Status")
            print("8. 🔍 Search Notes")
            print("9. 📱 Quick Phone List")
            print("10. ❌ Exit")
            
            choice = input("\nSelect option: ").strip()
            
            if choice == "1":
                self.view_dashboard()
            elif choice == "2":
                self.show_resources()
            elif choice == "3":
                self.manage_action_items()
            elif choice == "4":
                self.add_school()
            elif choice == "5":
                self.add_contact()
            elif choice == "6":
                self.log_interaction()
            elif choice == "7":
                self.update_school_status()
            elif choice == "8":
                self.search_notes()
            elif choice == "9":
                self.quick_phone_list()
            elif choice == "10":
                print("\n🍀 Good luck getting out of Shelby! You've got this! 💪")
                break
            else:
                print("Invalid option. Please try again.")

if __name__ == "__main__":
    print("\n🚀 Initializing Shelby Transfer Mission Control...")
    print("📍 Current Date: July 8, 2025")
    print("⏰ ~40 days until school starts")
    print("🎯 Mission: Transfer out of Shelby Academy ASAP")
    
    tracker = SchoolTransferTracker()
    tracker.run()