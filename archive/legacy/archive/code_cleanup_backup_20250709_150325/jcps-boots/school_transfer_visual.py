#!/usr/bin/env python3
"""
JCPS School Transfer Tracker - Visual Edition
Enhanced with Rich terminal UI for better user experience
"""

import json
import os
from datetime import datetime, timedelta
from typing import Dict, List, Optional
import time
import random
import webbrowser

# Rich imports for beautiful terminal UI
from rich.console import Console
from rich.table import Table
from rich.panel import Panel
from rich.layout import Layout
from rich.progress import Progress, SpinnerColumn, TextColumn, BarColumn
from rich.live import Live
from rich.prompt import Prompt, Confirm
from rich.text import Text
from rich.align import Align
from rich.columns import Columns
from rich import box
from rich.markdown import Markdown

console = Console()

class VisualSchoolTracker:
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
                        "30% teacher loss over 5 years"
                    ],
                    "transfer_status": "Active - can transfer anytime a seat opens"
                },
                "target_schools": {},
                "contacts": {},
                "activity_log": [],
                "action_items": [],
                "achievements": [],
                "daily_streak": 0,
                "last_check_date": None
            }
    
    def initialize_context(self):
        """Initialize with context from our conversation"""
        if not self.data["target_schools"]:
            self.data["target_schools"] = {
                "Greathouse/Shryock Traditional": {
                    "priority": "high",
                    "contact_info": "(502) 485-8295",
                    "status": "monitoring",
                    "last_contacted": None,
                    "notes": "Parents praise academic rigor"
                },
                "Norton Commons Elementary": {
                    "priority": "high", 
                    "contact_info": "(502) 485-8388",
                    "status": "monitoring",
                    "last_contacted": None,
                    "notes": "4.5/5 GreatSchools rating"
                },
                "Goshen Elementary": {
                    "priority": "high",
                    "contact_info": "(502) 485-8322", 
                    "status": "monitoring",
                    "last_contacted": None,
                    "notes": "Strong individualized learning"
                }
            }
        
        if not self.data["action_items"]:
            self.data["action_items"] = [
                {"task": "Check JCPS portal for openings", "priority": "high", "completed": False, "daily": True},
                {"task": "Join JCPS Parents Facebook group", "priority": "high", "completed": False, "daily": False},
                {"task": "Schedule Shelby principal meeting", "priority": "high", "completed": False, "daily": False},
                {"task": "Research math tutors", "priority": "high", "completed": False, "daily": False}
            ]
        
        self.save_data()
    
    def save_data(self):
        """Save data to file"""
        with open(self.data_file, 'w') as f:
            json.dump(self.data, f, indent=2)
    
    def get_status_emoji(self, status: str) -> str:
        """Get emoji for school status"""
        return {
            "monitoring": "👀",
            "contacted": "📞",
            "waitlisted": "⏳",
            "opening_possible": "🎯",
            "accepted": "✅",
            "declined": "❌"
        }.get(status, "❓")
    
    def get_priority_color(self, priority: str) -> str:
        """Get color for priority level"""
        return {
            "high": "red",
            "medium": "yellow",
            "low": "green"
        }.get(priority, "white")
    
    def create_header(self) -> Panel:
        """Create the header panel"""
        days_until_school = (datetime(2025, 8, 15) - datetime.now()).days
        
        header_text = Text()
        header_text.append("🎯 JCPS TRANSFER MISSION CONTROL", style="bold cyan")
        header_text.append("          ")
        header_text.append(f"📅 {datetime.now().strftime('%B %d, %Y')}", style="white")
        header_text.append("\n")
        header_text.append(f"⏰ {days_until_school} days until school starts", style="yellow")
        header_text.append("          ")
        header_text.append(f"🔥 Streak: {self.data['daily_streak']} days", style="orange1")
        
        return Panel(
            Align.center(header_text),
            box=box.DOUBLE_EDGE,
            style="bold white on rgb(25,25,112)"
        )
    
    def create_schools_table(self) -> Table:
        """Create the schools status table"""
        table = Table(
            title="🏫 TARGET SCHOOLS",
            box=box.ROUNDED,
            title_style="bold cyan",
            show_lines=True
        )
        
        table.add_column("School", style="cyan", width=25)
        table.add_column("Phone", style="white", width=15)
        table.add_column("Status", justify="center", width=18)
        table.add_column("Priority", justify="center", width=8)
        table.add_column("Last Contact", justify="center", width=12)
        table.add_column("Action", width=12)
        
        for school, info in self.data["target_schools"].items():
            status_display = f"{self.get_status_emoji(info['status'])} {info['status'].title()}"
            priority_style = self.get_priority_color(info['priority'])
            
            last_contact = "Never"
            if info['last_contacted']:
                last_date = datetime.fromisoformat(info['last_contacted'])
                days_ago = (datetime.now() - last_date).days
                if days_ago == 0:
                    last_contact = "[green]Today[/green]"
                elif days_ago == 1:
                    last_contact = "[yellow]Yesterday[/yellow]"
                else:
                    last_contact = f"[red]{days_ago} days ago[/red]"
            
            action = "[cyan][Call Now][/cyan]" if info['status'] in ['monitoring', 'contacted'] else "[dim]Wait[/dim]"
            
            table.add_row(
                school,
                info['contact_info'],
                status_display,
                f"[{priority_style}]{info['priority'].upper()}[/{priority_style}]",
                last_contact,
                action
            )
        
        return table
    
    def create_progress_panel(self) -> Panel:
        """Create progress tracking panel"""
        # Calculate overall progress
        total_tasks = len(self.data["action_items"])
        completed_tasks = sum(1 for task in self.data["action_items"] if task["completed"])
        progress_pct = (completed_tasks / total_tasks * 100) if total_tasks > 0 else 0
        
        # Create progress bar
        progress_text = Text()
        progress_text.append("📊 TRANSFER PROGRESS\n\n", style="bold cyan")
        
        # Visual progress bar
        filled = int(progress_pct / 5)
        empty = 20 - filled
        bar = "█" * filled + "░" * empty
        
        if progress_pct < 30:
            bar_color = "red"
        elif progress_pct < 70:
            bar_color = "yellow"
        else:
            bar_color = "green"
            
        progress_text.append(f"[{bar_color}]{bar}[/{bar_color}] {progress_pct:.0f}%\n\n")
        
        # Key metrics
        schools_contacted = sum(1 for s in self.data["target_schools"].values() if s["status"] != "monitoring")
        total_schools = len(self.data["target_schools"])
        
        progress_text.append("📈 Key Metrics:\n", style="bold")
        progress_text.append(f"  • Schools Contacted: {schools_contacted}/{total_schools}\n")
        progress_text.append(f"  • Tasks Completed: {completed_tasks}/{total_tasks}\n")
        progress_text.append(f"  • Days Active: {self.data['daily_streak']}\n")
        
        return Panel(progress_text, title="Progress Tracking", box=box.ROUNDED)
    
    def create_actions_panel(self) -> Panel:
        """Create today's actions panel"""
        actions_text = Text()
        actions_text.append("📋 TODAY'S PRIORITIES\n\n", style="bold cyan")
        
        # Filter incomplete high-priority tasks
        high_priority = [task for task in self.data["action_items"] 
                        if not task["completed"] and task["priority"] == "high"]
        
        if high_priority:
            for i, task in enumerate(high_priority[:5], 1):
                if task.get("daily"):
                    actions_text.append(f"🔄 ", style="blue")
                else:
                    actions_text.append(f"{i}. ", style="white")
                actions_text.append(f"{task['task']}\n")
        else:
            actions_text.append("✨ All high-priority tasks completed!\n", style="green")
        
        # Add time-sensitive alerts
        actions_text.append("\n⚡ TIME SENSITIVE\n", style="bold yellow")
        current_hour = datetime.now().hour
        
        if 7 <= current_hour < 8:
            actions_text.append("🔔 JCPS portal updates at 7am - CHECK NOW!\n", style="red blink")
        elif 8 <= current_hour < 17:
            actions_text.append("📞 Business hours - Good time to call schools\n", style="green")
        else:
            actions_text.append("🌙 After hours - Prep for tomorrow\n", style="dim")
        
        return Panel(actions_text, title="Action Center", box=box.ROUNDED)
    
    def create_dashboard_layout(self) -> Layout:
        """Create the main dashboard layout"""
        layout = Layout()
        
        layout.split_column(
            Layout(self.create_header(), size=4),
            Layout(name="main", ratio=1),
            Layout(name="footer", size=3)
        )
        
        layout["main"].split_row(
            Layout(self.create_schools_table(), ratio=2),
            Layout(name="sidebar", ratio=1)
        )
        
        layout["sidebar"].split_column(
            Layout(self.create_progress_panel()),
            Layout(self.create_actions_panel())
        )
        
        # Footer with commands
        footer_text = "[bold cyan]Commands:[/bold cyan] [yellow](D)[/yellow]ashboard [yellow](S)[/yellow]chools [yellow](C)[/yellow]ontacts [yellow](R)[/yellow]esources [yellow](A)[/yellow]ctions [yellow](Q)[/yellow]uit"
        layout["footer"].update(Panel(Align.center(footer_text), box=box.ROUNDED))
        
        return layout
    
    def show_welcome_animation(self):
        """Show welcome animation"""
        console.clear()
        
        welcome_text = """
        [bold cyan]Welcome to JCPS Transfer Tracker[/bold cyan]
        [yellow]Your mission: Escape Shelby Academy![/yellow]
        
        [dim]Loading your command center...[/dim]
        """
        
        with console.status("[bold green]Initializing...", spinner="dots"):
            console.print(Panel(Align.center(welcome_text), box=box.DOUBLE))
            time.sleep(2)
    
    def update_school_status(self):
        """Interactive school status update"""
        console.clear()
        console.print(Panel("🏫 UPDATE SCHOOL STATUS", style="bold cyan"))
        
        # Show schools in a nice table
        table = Table(show_header=True, header_style="bold magenta")
        table.add_column("#", style="dim", width=3)
        table.add_column("School", style="cyan", width=30)
        table.add_column("Current Status", justify="center")
        
        schools = list(self.data["target_schools"].items())
        for i, (school, info) in enumerate(schools, 1):
            status_display = f"{self.get_status_emoji(info['status'])} {info['status'].title()}"
            table.add_row(str(i), school, status_display)
        
        console.print(table)
        
        choice = Prompt.ask("\nSelect school number", choices=[str(i) for i in range(1, len(schools)+1)])
        school_name, school_info = schools[int(choice)-1]
        
        console.print(f"\n[cyan]Updating: {school_name}[/cyan]")
        
        # Status options with emojis
        status_options = {
            "1": ("monitoring", "👀 Monitoring - Checking for openings"),
            "2": ("contacted", "📞 Contacted - Made initial contact"),
            "3": ("waitlisted", "⏳ Waitlisted - On official waitlist"),
            "4": ("opening_possible", "🎯 Opening Possible - Potential seat!"),
            "5": ("accepted", "✅ Accepted - Transfer approved!"),
            "6": ("declined", "❌ Declined - No seats available")
        }
        
        console.print("\n[bold]New Status:[/bold]")
        for key, (_, desc) in status_options.items():
            console.print(f"  {key}. {desc}")
        
        status_choice = Prompt.ask("\nSelect status", choices=list(status_options.keys()))
        new_status, _ = status_options[status_choice]
        
        # Update the data
        self.data["target_schools"][school_name]["status"] = new_status
        self.data["target_schools"][school_name]["last_contacted"] = datetime.now().isoformat()
        
        # Add notes
        notes = Prompt.ask("\nAny additional notes? (press Enter to skip)", default="")
        if notes:
            self.data["target_schools"][school_name]["notes"] += f"\n[{datetime.now().strftime('%Y-%m-%d')}] {notes}"
        
        self.save_data()
        
        # Show success message
        if new_status == "accepted":
            console.print(Panel(
                f"[bold green]🎉 CONGRATULATIONS! 🎉\n\nYou secured a spot at {school_name}![/bold green]",
                box=box.DOUBLE,
                style="green"
            ))
            time.sleep(3)
        elif new_status == "opening_possible":
            console.print(Panel(
                f"[bold yellow]🎯 EXCITING NEWS!\n\nPotential opening at {school_name}!\nFollow up immediately![/bold yellow]",
                box=box.DOUBLE,
                style="yellow"
            ))
            time.sleep(2)
        else:
            console.print(f"\n[green]✓ Updated {school_name} to {new_status}[/green]")
            time.sleep(1)
    
    def show_quick_actions(self):
        """Show quick actions menu"""
        console.clear()
        
        quick_actions = Panel(
            """[bold cyan]⚡ QUICK ACTIONS[/bold cyan]
            
[yellow]1.[/yellow] 📞 Call a school now
[yellow]2.[/yellow] ✅ Mark task complete  
[yellow]3.[/yellow] 📝 Add quick note
[yellow]4.[/yellow] 🔍 Check JCPS portal
[yellow]5.[/yellow] 📊 View analytics
[yellow]6.[/yellow] 🎯 Set reminder
[yellow]7.[/yellow] ↩️  Back to dashboard""",
            box=box.DOUBLE
        )
        
        console.print(quick_actions)
        
        choice = Prompt.ask("\nSelect action", choices=["1","2","3","4","5","6","7"])
        
        if choice == "1":
            self.quick_call_school()
        elif choice == "2":
            self.quick_complete_task()
        elif choice == "4":
            console.print("\n[cyan]Opening JCPS portal in your browser...[/cyan]")
            console.print("[dim]URL: https://apps.jefferson.kyschools.us/[/dim]")
            webbrowser.open("https://apps.jefferson.kyschools.us/studentassignment/transferonlineapplication/")
            time.sleep(1)
        elif choice == "7":
            return
    
    def quick_call_school(self):
        """Quick call interface"""
        console.print("\n[bold]📞 QUICK CALL[/bold]\n")
        
        # Show schools with phone numbers
        for i, (school, info) in enumerate(self.data["target_schools"].items(), 1):
            console.print(f"{i}. {school} - [cyan]{info['contact_info']}[/cyan]")
        
        console.print("\n[yellow]Tip: Have your transfer status number ready![/yellow]")
        console.print("[dim]Script: 'Hi, I have a 2nd grader with active transfer status...'[/dim]")
        
        input("\n[dim]Press Enter to continue...[/dim]")
    
    def quick_complete_task(self):
        """Quick mark task as complete"""
        console.print("\n[bold]✅ MARK TASK COMPLETE[/bold]\n")
        
        incomplete_tasks = [(i, task) for i, task in enumerate(self.data["action_items"]) 
                           if not task["completed"]]
        
        if not incomplete_tasks:
            console.print("[green]All tasks completed! Great job! 🎉[/green]")
            time.sleep(2)
            return
        
        for idx, (i, task) in enumerate(incomplete_tasks, 1):
            console.print(f"{idx}. {task['task']}")
        
        choice = Prompt.ask("\nSelect task number to complete", 
                           choices=[str(i) for i in range(1, len(incomplete_tasks)+1)])
        
        task_idx = incomplete_tasks[int(choice)-1][0]
        self.data["action_items"][task_idx]["completed"] = True
        self.save_data()
        
        console.print("\n[green]✓ Task marked as complete![/green]")
        time.sleep(1)
    
    def show_resources(self):
        """Show comprehensive resources menu"""
        console.clear()
        
        resources_menu = """[bold cyan]📚 JCPS TRANSFER RESOURCES[/bold cyan]

[yellow]1.[/yellow] 🏫 Official JCPS Transfer Portal
[yellow]2.[/yellow] 📊 School Rating Sites (GreatSchools, Niche)
[yellow]3.[/yellow] 👥 Parent Facebook Groups
[yellow]4.[/yellow] 📞 Quick Phone Directory
[yellow]5.[/yellow] 📚 Free Tutoring Resources
[yellow]6.[/yellow] 🏫 Private School Options
[yellow]7.[/yellow] 🏠 Homeschool Information
[yellow]8.[/yellow] ↩️  Back to dashboard"""
        
        console.print(Panel(resources_menu, box=box.DOUBLE))
        
        choice = Prompt.ask("\nSelect resource", choices=["1","2","3","4","5","6","7","8"])
        
        if choice == "1":
            console.print("\n[cyan]Opening JCPS Transfer Portal...[/cyan]")
            webbrowser.open("https://apps.jefferson.kyschools.us/studentassignment/transferonlineapplication/")
            console.print("\n[yellow]Transfer Window: May 5, 2025 - March 6, 2026[/yellow]")
            console.print("[dim]Office: (502) 485-6250 | Email: jcpsschoolchoice@jefferson.kyschools.us[/dim]")
        elif choice == "2":
            console.print("\n[cyan]School Rating Sites:[/cyan]")
            console.print("1. GreatSchools: https://www.greatschools.org/kentucky/louisville/")
            console.print("2. Niche: https://www.niche.com/k12/search/best-public-elementary-schools/m/louisville-metro-area/")
            if Confirm.ask("\nOpen GreatSchools?"):
                webbrowser.open("https://www.greatschools.org/kentucky/louisville/")
        elif choice == "3":
            console.print("\n[cyan]Parent Support Groups:[/cyan]")
            console.print("• JCPS Parents Facebook: https://www.facebook.com/groups/337907878132865/")
            console.print("• Official JCPS Page: https://www.facebook.com/JCPSKY/")
            if Confirm.ask("\nOpen JCPS Parents Facebook group?"):
                webbrowser.open("https://www.facebook.com/groups/337907878132865/")
        elif choice == "4":
            self.show_phone_directory()
        elif choice == "5":
            console.print("\n[cyan]🆓 FREE Tutoring Resources:[/cyan]")
            console.print("• FEV Tutor: 24/7 online via Clever")
            console.print("• Elev8 Learning Centers: 2500 West Broadway (2:30-7:30 PM)")
            console.print("• JCPS Homework Help: https://www.jefferson.kyschools.us/student-support/homework-help")
        elif choice == "8":
            return
        
        if choice != "8":
            input("\n[dim]Press Enter to continue...[/dim]")
    
    def show_phone_directory(self):
        """Show quick phone directory"""
        phone_dir = Panel("""[bold cyan]📱 QUICK PHONE DIRECTORY[/bold cyan]

[bold]🚨 CRITICAL NUMBERS:[/bold]
• School Choice Office: [cyan](502) 485-6250[/cyan]
• JCPS Main: [cyan](502) 485-3011[/cyan]
• Shelby Academy: [cyan](502) 485-8331[/cyan]

[bold]🎯 TARGET SCHOOLS:[/bold]
• Greathouse/Shryock: [cyan](502) 485-8295[/cyan]
• Norton Commons: [cyan](502) 485-8388[/cyan]
• Goshen Elementary: [cyan](502) 485-8322[/cyan]

[bold]📞 CALL SCRIPT:[/bold]
"Hi, I have a 2nd grader with active transfer status.
Are there any openings for the 2024-25 school year?
Can I be added to your waitlist?"
""", box=box.DOUBLE)
        
        console.print(phone_dir)
        input("\n[dim]Press Enter to continue...[/dim]")
    
    def show_contacts(self):
        """Show contacts management"""
        console.clear()
        console.print(Panel("👥 CONTACTS MANAGEMENT", style="bold cyan"))
        
        if not self.data.get("contacts"):
            self.data["contacts"] = {
                "JCPS School Choice Office": {
                    "phone": "(502) 485-6250",
                    "email": "jcpsschoolchoice@jefferson.kyschools.us",
                    "role": "admin",
                    "notes": "Primary contact for transfers"
                }
            }
        
        # Display contacts
        table = Table(show_header=True, header_style="bold magenta")
        table.add_column("Contact", style="cyan", width=25)
        table.add_column("Phone", width=15)
        table.add_column("Role", width=10)
        table.add_column("Notes", width=30)
        
        for name, info in self.data["contacts"].items():
            table.add_row(
                name,
                info.get("phone", ""),
                info.get("role", ""),
                info.get("notes", "")[:30] + "..." if len(info.get("notes", "")) > 30 else info.get("notes", "")
            )
        
        console.print(table)
        
        console.print("\n[yellow]1.[/yellow] Add new contact")
        console.print("[yellow]2.[/yellow] Log interaction")
        console.print("[yellow]3.[/yellow] Back to dashboard")
        
        choice = Prompt.ask("\nSelect option", choices=["1", "2", "3"])
        
        if choice == "1":
            self.add_contact()
        elif choice == "2":
            console.print("\n[dim]Interaction logging coming soon...[/dim]")
            time.sleep(1)
    
    def add_contact(self):
        """Add a new contact"""
        console.print("\n[bold]Add New Contact[/bold]\n")
        
        name = Prompt.ask("Contact name")
        phone = Prompt.ask("Phone number")
        role = Prompt.ask("Role", choices=["parent", "staff", "admin", "other"], default="parent")
        notes = Prompt.ask("Notes (optional)", default="")
        
        self.data["contacts"][name] = {
            "phone": phone,
            "role": role,
            "notes": notes,
            "interactions": []
        }
        
        self.save_data()
        console.print(f"\n[green]✓ Added {name} to contacts[/green]")
        time.sleep(1)
    
    def run(self):
        """Main application loop"""
        self.show_welcome_animation()
        
        while True:
            console.clear()
            layout = self.create_dashboard_layout()
            console.print(layout)
            
            # Get user input
            command = Prompt.ask(
                "\n[cyan]Enter command[/cyan]",
                choices=["d", "s", "c", "r", "a", "q"],
                default="d"
            ).lower()
            
            if command == "q":
                if Confirm.ask("\n[yellow]Are you sure you want to quit?[/yellow]"):
                    console.print(Panel(
                        "[bold green]Good luck with your transfer! 🍀\n\nRemember: Persistence pays off![/bold green]",
                        box=box.DOUBLE
                    ))
                    break
            elif command == "s":
                self.update_school_status()
            elif command == "c":
                self.show_contacts()
            elif command == "r":
                self.show_resources()
            elif command == "a":
                self.show_quick_actions()
            
            # Small delay for visual feedback
            if command != "d":
                time.sleep(0.5)

if __name__ == "__main__":
    tracker = VisualSchoolTracker()
    tracker.run()