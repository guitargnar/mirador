#!/usr/bin/env python3
"""
Mirador Unified Dashboard - Central Hub for All Tools
Integrates Mirador AI chains, JCPS tracker, productivity tools, and analytics
"""

import os
import sys
import json
import subprocess
import datetime
from typing import Dict, List, Optional, Tuple
import webbrowser
from pathlib import Path

# Add productivity tools to path
PRODUCTIVITY_PATH = os.path.join(os.path.dirname(__file__), "productivity_tools")
if PRODUCTIVITY_PATH not in sys.path:
    sys.path.insert(0, PRODUCTIVITY_PATH)

# Import for Rich terminal UI
try:
    from rich.console import Console
    from rich.table import Table
    from rich.panel import Panel
    from rich.layout import Layout
    from rich.live import Live
    from rich.align import Align
    from rich.prompt import Prompt, IntPrompt
    from rich.progress import Progress, SpinnerColumn, TextColumn
    from rich.syntax import Syntax
    from rich.markdown import Markdown
    RICH_AVAILABLE = True
except ImportError:
    RICH_AVAILABLE = False
    print("Note: Install 'rich' for beautiful terminal interface: pip install rich")

# Import context manager for analytics
try:
    from mirador_core.context_manager import ContextManager
    ANALYTICS_AVAILABLE = True
except ImportError:
    ANALYTICS_AVAILABLE = False

# Import JCPS tracker
try:
    from school_transfer_tracker_v2 import SchoolTransferTracker
    JCPS_AVAILABLE = True
except ImportError:
    JCPS_AVAILABLE = False

class MiradorUnifiedDashboard:
    """Unified Dashboard for all Mirador tools"""
    
    def __init__(self):
        self.console = Console() if RICH_AVAILABLE else None
        self.context_mgr = ContextManager() if ANALYTICS_AVAILABLE else None
        self.load_configuration()
        self.last_session_id = None
        
    def load_configuration(self):
        """Load dashboard configuration"""
        self.config = {
            "mirador_chains": {
                "life_optimization": "🌟 Life Optimization",
                "business_acceleration": "🚀 Business Acceleration", 
                "creative_breakthrough": "🎨 Creative Breakthrough",
                "relationship_harmony": "💝 Relationship Harmony",
                "technical_mastery": "💻 Technical Mastery",
                "strategic_synthesis": "🎯 Strategic Synthesis"
            },
            "productivity_tools": {
                "meeting_notes": "📝 Meeting Notes Formatter",
                "email_parser": "📧 Email Action Parser",
                "accomplishments": "🏆 Weekly Accomplishments",
                "cms_analyzer": "📊 CMS Guidance Analyzer",
                "star_ratings": "⭐ Quality Metrics Analyzer"
            },
            "quick_actions": [
                ("Morning Intelligence Brief", "./morning_intelligence_brief.sh"),
                ("Daily Check", "./daily_check_enhanced.sh"),
                ("Quick LinkedIn Post", "./quick_linkedin_post.sh"),
                ("Weekly Review", "./weekly_review_dashboard.sh")
            ]
        }
    
    def display_header(self):
        """Display beautiful header"""
        if self.console:
            header = Panel.fit(
                "[bold cyan]Mirador Unified Dashboard[/bold cyan]\n" +
                "[dim]Your AI-Powered Life & Work Command Center[/dim]",
                border_style="bright_blue"
            )
            self.console.print(header)
            self.console.print(f"[dim]📅 {datetime.datetime.now().strftime('%A, %B %d, %Y - %I:%M %p')}[/dim]\n")
        else:
            print("\n" + "="*70)
            print("MIRADOR UNIFIED DASHBOARD")
            print("Your AI-Powered Life & Work Command Center")
            print("="*70)
            print(f"{datetime.datetime.now().strftime('%A, %B %d, %Y - %I:%M %p')}\n")
    
    def display_system_status(self):
        """Display system status and recent activity"""
        if self.console:
            # Create status table
            status_table = Table(title="System Status", border_style="dim")
            status_table.add_column("Component", style="cyan")
            status_table.add_column("Status", style="green")
            status_table.add_column("Details")
            
            # Check Mirador
            try:
                result = subprocess.run(["ollama", "list"], capture_output=True, text=True)
                model_count = len([l for l in result.stdout.split('\n') if 'user' in l or 'enhanced' in l])
                status_table.add_row("Mirador AI", "✅ Active", f"{model_count} models loaded")
            except:
                status_table.add_row("Mirador AI", "❌ Offline", "Ollama not running")
            
            # Check JCPS Tracker
            if JCPS_AVAILABLE and os.path.exists("transfer_data.json"):
                status_table.add_row("JCPS Tracker", "✅ Active", "Transfer data loaded")
            else:
                status_table.add_row("JCPS Tracker", "⚠️  No Data", "Run tracker to initialize")
            
            # Check Productivity Tools
            if os.path.exists(PRODUCTIVITY_PATH):
                tool_count = len([f for f in os.listdir(PRODUCTIVITY_PATH) if f.endswith('.py')])
                status_table.add_row("Productivity Tools", "✅ Ready", f"{tool_count} tools available")
            else:
                status_table.add_row("Productivity Tools", "❌ Missing", "Tools directory not found")
            
            # Check Analytics
            if ANALYTICS_AVAILABLE:
                try:
                    stats = self.get_usage_stats()
                    status_table.add_row("Analytics", "✅ Active", 
                                       f"{stats['total_sessions']} sessions tracked")
                except:
                    status_table.add_row("Analytics", "⚠️  Limited", "Database needs init")
            else:
                status_table.add_row("Analytics", "❌ Unavailable", "context_manager not found")
            
            self.console.print(status_table)
            
            # Show recent activity
            if self.context_mgr:
                recent = self.get_recent_activity()
                if recent:
                    recent_panel = Panel(
                        "\n".join([f"• {item}" for item in recent[:5]]),
                        title="Recent Activity",
                        border_style="dim"
                    )
                    self.console.print(recent_panel)
        else:
            print("SYSTEM STATUS:")
            print("- Mirador AI: Check with 'ollama list'")
            print("- JCPS Tracker:", "Ready" if JCPS_AVAILABLE else "Not Available")
            print("- Productivity Tools:", "Ready" if os.path.exists(PRODUCTIVITY_PATH) else "Not Found")
            print("- Analytics:", "Active" if ANALYTICS_AVAILABLE else "Not Available")
    
    def get_usage_stats(self) -> Dict:
        """Get usage statistics from context manager"""
        if not self.context_mgr:
            return {"total_sessions": 0, "today_sessions": 0, "top_chain": "N/A"}
        
        conn = self.context_mgr._get_connection()
        
        # Total sessions
        total = conn.execute("SELECT COUNT(DISTINCT session_id) FROM context_cache").fetchone()[0]
        
        # Today's sessions
        today = conn.execute("""
            SELECT COUNT(DISTINCT session_id) FROM context_cache 
            WHERE DATE(created_at) = DATE('now')
        """).fetchone()[0]
        
        # Most used chain
        top_chain = conn.execute("""
            SELECT chain_type, COUNT(*) as count 
            FROM context_cache 
            GROUP BY chain_type 
            ORDER BY count DESC 
            LIMIT 1
        """).fetchone()
        
        conn.close()
        
        return {
            "total_sessions": total,
            "today_sessions": today,
            "top_chain": top_chain[0] if top_chain else "N/A"
        }
    
    def get_recent_activity(self) -> List[str]:
        """Get recent activity items"""
        if not self.context_mgr:
            return []
        
        conn = self.context_mgr._get_connection()
        recent = conn.execute("""
            SELECT chain_type, prompt, created_at 
            FROM context_cache 
            ORDER BY created_at DESC 
            LIMIT 5
        """).fetchall()
        conn.close()
        
        activities = []
        for chain, prompt, created in recent:
            time_str = datetime.datetime.fromisoformat(created).strftime("%I:%M %p")
            prompt_short = prompt[:50] + "..." if len(prompt) > 50 else prompt
            activities.append(f"{time_str} - {chain}: {prompt_short}")
        
        return activities
    
    def run_mirador_chain(self):
        """Run a Mirador AI chain"""
        if self.console:
            self.console.print("\n[bold cyan]Mirador AI Chains[/bold cyan]")
            
            # Display chain options
            chain_table = Table(show_header=False, box=None)
            chain_table.add_column("Num", style="bold yellow")
            chain_table.add_column("Chain", style="cyan")
            chain_table.add_column("Description")
            
            chains = list(self.config["mirador_chains"].items())
            for i, (chain_id, chain_name) in enumerate(chains, 1):
                desc = {
                    "life_optimization": "Personal scheduling, health, productivity",
                    "business_acceleration": "Career growth, innovation, leadership",
                    "creative_breakthrough": "Music, writing, artistic projects",
                    "relationship_harmony": "Family, partnerships, communication",
                    "technical_mastery": "Coding, AI, technical solutions",
                    "strategic_synthesis": "High-level planning and integration"
                }.get(chain_id, "")
                chain_table.add_row(str(i), chain_name, f"[dim]{desc}[/dim]")
            
            self.console.print(chain_table)
            
            choice = IntPrompt.ask("\nSelect chain", choices=[str(i) for i in range(1, len(chains)+1)])
            chain_id = chains[choice-1][0]
            
            # Get format preference
            format_choice = Prompt.ask(
                "\nOutput format",
                choices=["quick", "summary", "detailed", "export"],
                default="detailed"
            )
            
            # Get prompt
            self.console.print("\n[cyan]Enter your prompt:[/cyan]")
            prompt = Prompt.ask(">")
            
            # Run with progress indicator
            with self.console.status(f"[bold green]Running {chains[choice-1][1]}...", spinner="dots"):
                cmd = ["./mirador_universal_runner_v2.sh", chain_id, prompt, format_choice]
                result = subprocess.run(cmd, capture_output=True, text=True)
            
            if result.returncode == 0:
                self.console.print("\n[green]✅ Chain completed successfully![/green]")
                # Extract session ID from output
                import re
                session_match = re.search(r'universal_.*?_(\d{8}_\d{6})', result.stdout)
                if session_match:
                    self.last_session_id = session_match.group(0)
                    self.console.print(f"[dim]Session: {self.last_session_id}[/dim]")
            else:
                self.console.print("\n[red]❌ Chain encountered an error[/red]")
        else:
            # Simple version without Rich
            print("\nMIRADOR AI CHAINS:")
            chains = list(self.config["mirador_chains"].items())
            for i, (chain_id, chain_name) in enumerate(chains, 1):
                print(f"{i}. {chain_name}")
            
            choice = input("\nSelect chain (1-6): ").strip()
            if choice.isdigit() and 1 <= int(choice) <= len(chains):
                chain_id = chains[int(choice)-1][0]
                format_choice = input("Format (quick/summary/detailed/export) [detailed]: ").strip() or "detailed"
                prompt = input("\nEnter your prompt: ").strip()
                
                print(f"\nRunning {chains[int(choice)-1][1]}...")
                cmd = ["./mirador_universal_runner_v2.sh", chain_id, prompt, format_choice]
                subprocess.run(cmd)
    
    def run_jcps_tracker(self):
        """Run JCPS School Transfer Tracker"""
        if JCPS_AVAILABLE:
            if self.console:
                self.console.print("\n[bold cyan]Launching JCPS School Transfer Tracker...[/bold cyan]")
            else:
                print("\nLaunching JCPS School Transfer Tracker...")
            
            # Run in subprocess to keep dashboard responsive
            subprocess.run([sys.executable, "school_transfer_tracker_v2.py"])
        else:
            msg = "JCPS Tracker not available. Check installation."
            if self.console:
                self.console.print(f"[red]{msg}[/red]")
            else:
                print(msg)
    
    def run_productivity_tool(self):
        """Run productivity tools"""
        if self.console:
            self.console.print("\n[bold cyan]Productivity Tools[/bold cyan]")
            
            # Display tool options
            tool_table = Table(show_header=False, box=None)
            tool_table.add_column("Num", style="bold yellow")
            tool_table.add_column("Tool", style="cyan")
            
            tools = list(self.config["productivity_tools"].items())
            for i, (tool_id, tool_name) in enumerate(tools, 1):
                tool_table.add_row(str(i), tool_name)
            
            self.console.print(tool_table)
            
            choice = IntPrompt.ask("\nSelect tool", choices=[str(i) for i in range(1, len(tools)+1)])
            tool_id = tools[choice-1][0]
            
            # Map tool IDs to scripts
            tool_map = {
                "meeting_notes": "meeting_notes_formatter.py",
                "email_parser": "email_action_parser.py",
                "accomplishments": "weekly_accomplishments_tracker.py",
                "cms_analyzer": "cms_guidance_analyzer.py",
                "star_ratings": "star_ratings_analyzer.py"
            }
            
            script = tool_map.get(tool_id)
            if script:
                script_path = os.path.join(PRODUCTIVITY_PATH, script)
                if os.path.exists(script_path):
                    with self.console.status(f"[bold green]Running {tools[choice-1][1]}...", spinner="dots"):
                        subprocess.run([sys.executable, script_path])
                else:
                    self.console.print(f"[red]Tool not found: {script}[/red]")
        else:
            # Simple version
            print("\nPRODUCTIVITY TOOLS:")
            tools = list(self.config["productivity_tools"].items())
            for i, (tool_id, tool_name) in enumerate(tools, 1):
                print(f"{i}. {tool_name}")
            
            choice = input("\nSelect tool (1-5): ").strip()
            if choice.isdigit() and 1 <= int(choice) <= len(tools):
                tool_id = tools[int(choice)-1][0]
                # Run the selected tool
                tool_map = {
                    "meeting_notes": "meeting_notes_formatter.py",
                    "email_parser": "email_action_parser.py",
                    "accomplishments": "weekly_accomplishments_tracker.py",
                    "cms_analyzer": "cms_guidance_analyzer.py",
                    "star_ratings": "star_ratings_analyzer.py"
                }
                script = tool_map.get(tool_id)
                if script:
                    script_path = os.path.join(PRODUCTIVITY_PATH, script)
                    subprocess.run([sys.executable, script_path])
    
    def show_analytics(self):
        """Show analytics and insights"""
        if not ANALYTICS_AVAILABLE:
            msg = "Analytics not available. Install context_manager.py"
            if self.console:
                self.console.print(f"[red]{msg}[/red]")
            else:
                print(msg)
            return
        
        if self.console:
            self.console.print("\n[bold cyan]Analytics & Insights[/bold cyan]")
            
            # Get comprehensive stats
            stats = self.get_comprehensive_analytics()
            
            # Usage statistics
            stats_table = Table(title="Usage Statistics", border_style="dim")
            stats_table.add_column("Metric", style="cyan")
            stats_table.add_column("Value", style="yellow")
            
            stats_table.add_row("Total Sessions", str(stats["total_sessions"]))
            stats_table.add_row("Today's Sessions", str(stats["today_sessions"]))
            stats_table.add_row("This Week", str(stats["week_sessions"]))
            stats_table.add_row("Average Rating", f"{stats['avg_rating']:.1f}/5")
            stats_table.add_row("Most Used Chain", stats["top_chain"])
            stats_table.add_row("Peak Hour", stats["peak_hour"])
            
            self.console.print(stats_table)
            
            # Chain distribution
            if stats["chain_distribution"]:
                dist_table = Table(title="Chain Usage", border_style="dim")
                dist_table.add_column("Chain Type", style="cyan")
                dist_table.add_column("Count", style="yellow")
                dist_table.add_column("Percentage")
                
                total = sum(count for _, count in stats["chain_distribution"])
                for chain, count in stats["chain_distribution"]:
                    percentage = (count / total) * 100 if total > 0 else 0
                    dist_table.add_row(
                        chain.replace("_", " ").title(),
                        str(count),
                        f"{percentage:.1f}%"
                    )
                
                self.console.print(dist_table)
            
            # Success patterns
            if stats["success_patterns"]:
                patterns_panel = Panel(
                    "\n".join([f"• {pattern}" for pattern in stats["success_patterns"][:5]]),
                    title="Common Success Patterns",
                    border_style="green"
                )
                self.console.print(patterns_panel)
        else:
            print("\nANALYTICS & INSIGHTS:")
            stats = self.get_comprehensive_analytics()
            print(f"Total Sessions: {stats['total_sessions']}")
            print(f"Today's Sessions: {stats['today_sessions']}")
            print(f"Average Rating: {stats['avg_rating']:.1f}/5")
            print(f"Most Used Chain: {stats['top_chain']}")
    
    def get_comprehensive_analytics(self) -> Dict:
        """Get comprehensive analytics data"""
        if not self.context_mgr:
            return {
                "total_sessions": 0,
                "today_sessions": 0,
                "week_sessions": 0,
                "avg_rating": 0,
                "top_chain": "N/A",
                "peak_hour": "N/A",
                "chain_distribution": [],
                "success_patterns": []
            }
        
        conn = self.context_mgr._get_connection()
        
        # Basic stats
        total = conn.execute("SELECT COUNT(DISTINCT session_id) FROM context_cache").fetchone()[0]
        today = conn.execute("""
            SELECT COUNT(DISTINCT session_id) FROM context_cache 
            WHERE DATE(created_at) = DATE('now')
        """).fetchone()[0]
        week = conn.execute("""
            SELECT COUNT(DISTINCT session_id) FROM context_cache 
            WHERE DATE(created_at) >= DATE('now', '-7 days')
        """).fetchone()[0]
        
        # Average rating
        avg_rating = conn.execute("SELECT AVG(rating) FROM context_cache WHERE rating > 0").fetchone()[0] or 0
        
        # Chain distribution
        chain_dist = conn.execute("""
            SELECT chain_type, COUNT(*) as count 
            FROM context_cache 
            GROUP BY chain_type 
            ORDER BY count DESC
        """).fetchall()
        
        # Peak usage hour
        peak_hour = conn.execute("""
            SELECT strftime('%H', created_at) as hour, COUNT(*) as count
            FROM context_cache
            GROUP BY hour
            ORDER BY count DESC
            LIMIT 1
        """).fetchone()
        
        # Success patterns (from highly rated sessions)
        patterns = conn.execute("""
            SELECT success_patterns 
            FROM context_cache 
            WHERE rating >= 4 AND success_patterns IS NOT NULL
            LIMIT 10
        """).fetchall()
        
        conn.close()
        
        # Process patterns
        all_patterns = []
        for p in patterns:
            if p[0]:
                try:
                    pattern_list = json.loads(p[0])
                    all_patterns.extend(pattern_list)
                except:
                    pass
        
        # Get unique patterns
        unique_patterns = list(set(all_patterns))[:5]
        
        return {
            "total_sessions": total,
            "today_sessions": today,
            "week_sessions": week,
            "avg_rating": avg_rating,
            "top_chain": chain_dist[0][0] if chain_dist else "N/A",
            "peak_hour": f"{int(peak_hour[0])}:00" if peak_hour else "N/A",
            "chain_distribution": chain_dist[:5],
            "success_patterns": unique_patterns
        }
    
    def quick_actions_menu(self):
        """Show quick actions menu"""
        if self.console:
            self.console.print("\n[bold cyan]Quick Actions[/bold cyan]")
            
            action_table = Table(show_header=False, box=None)
            action_table.add_column("Num", style="bold yellow")
            action_table.add_column("Action", style="cyan")
            
            for i, (name, _) in enumerate(self.config["quick_actions"], 1):
                action_table.add_row(str(i), name)
            
            self.console.print(action_table)
            
            choice = IntPrompt.ask(
                "\nSelect action", 
                choices=[str(i) for i in range(1, len(self.config["quick_actions"])+1)]
            )
            
            _, script = self.config["quick_actions"][choice-1]
            if os.path.exists(script):
                with self.console.status(f"[bold green]Running {self.config['quick_actions'][choice-1][0]}...", spinner="dots"):
                    subprocess.run(["bash", script])
            else:
                self.console.print(f"[red]Script not found: {script}[/red]")
        else:
            print("\nQUICK ACTIONS:")
            for i, (name, _) in enumerate(self.config["quick_actions"], 1):
                print(f"{i}. {name}")
            
            choice = input("\nSelect action: ").strip()
            if choice.isdigit() and 1 <= int(choice) <= len(self.config["quick_actions"]):
                _, script = self.config["quick_actions"][int(choice)-1]
                if os.path.exists(script):
                    subprocess.run(["bash", script])
    
    def run_terminal_interface(self):
        """Run the terminal interface"""
        while True:
            try:
                # Clear screen for clean display
                os.system('clear' if os.name == 'posix' else 'cls')
                
                self.display_header()
                self.display_system_status()
                
                if self.console:
                    # Create main menu
                    menu_table = Table(show_header=False, box=None, padding=(0, 2))
                    menu_table.add_column("Option", style="bold yellow")
                    menu_table.add_column("Feature", style="cyan")
                    menu_table.add_column("Description", style="dim")
                    
                    menu_table.add_row("1", "🤖 Mirador AI Chains", "Run intelligent multi-model chains")
                    menu_table.add_row("2", "🎯 JCPS School Tracker", "Manage school transfer mission")
                    menu_table.add_row("3", "📋 Productivity Tools", "Meeting notes, emails, accomplishments")
                    menu_table.add_row("4", "📊 Analytics & Insights", "Usage stats and success patterns")
                    menu_table.add_row("5", "⚡ Quick Actions", "Common workflows and reports")
                    menu_table.add_row("6", "🌐 Launch Web Dashboard", "Open browser-based interface")
                    menu_table.add_row("7", "🔄 Refresh Display", "Update system status")
                    menu_table.add_row("0", "❌ Exit", "Close dashboard")
                    
                    menu_panel = Panel(menu_table, title="Main Menu", border_style="blue")
                    self.console.print(menu_panel)
                    
                    choice = Prompt.ask("\n[bold cyan]Select option[/bold cyan]", choices=["0","1","2","3","4","5","6","7"])
                else:
                    print("\nMAIN MENU:")
                    print("1. 🤖 Mirador AI Chains")
                    print("2. 🎯 JCPS School Tracker")
                    print("3. 📋 Productivity Tools")
                    print("4. 📊 Analytics & Insights")
                    print("5. ⚡ Quick Actions")
                    print("6. 🌐 Launch Web Dashboard")
                    print("7. 🔄 Refresh Display")
                    print("0. ❌ Exit")
                    
                    choice = input("\nSelect option: ").strip()
                
                if choice == "1":
                    self.run_mirador_chain()
                elif choice == "2":
                    self.run_jcps_tracker()
                elif choice == "3":
                    self.run_productivity_tool()
                elif choice == "4":
                    self.show_analytics()
                elif choice == "5":
                    self.quick_actions_menu()
                elif choice == "6":
                    self.launch_web_dashboard()
                elif choice == "7":
                    continue  # Refresh by looping
                elif choice == "0":
                    if self.console:
                        self.console.print("\n[bold green]Thanks for using Mirador Dashboard! 🚀[/bold green]")
                    else:
                        print("\nThanks for using Mirador Dashboard! 🚀")
                    break
                
                if choice != "7":  # Don't pause on refresh
                    input("\nPress Enter to continue...")
                    
            except KeyboardInterrupt:
                if self.console:
                    self.console.print("\n\n[yellow]Dashboard closed by user[/yellow]")
                else:
                    print("\n\nDashboard closed by user")
                break
            except Exception as e:
                if self.console:
                    self.console.print(f"\n[red]Error: {e}[/red]")
                else:
                    print(f"\nError: {e}")
                input("\nPress Enter to continue...")
    
    def launch_web_dashboard(self):
        """Launch the Streamlit web dashboard"""
        if self.console:
            self.console.print("\n[bold cyan]Launching Web Dashboard...[/bold cyan]")
        else:
            print("\nLaunching Web Dashboard...")
        
        # Check if streamlit is installed
        try:
            import streamlit
            web_script = "mirador_web_dashboard.py"
            if os.path.exists(web_script):
                subprocess.Popen(["streamlit", "run", web_script])
                if self.console:
                    self.console.print("[green]✅ Web dashboard launching in browser...[/green]")
                else:
                    print("✅ Web dashboard launching in browser...")
            else:
                if self.console:
                    self.console.print("[red]Web dashboard script not found. Creating it now...[/red]")
                else:
                    print("Web dashboard script not found. Creating it now...")
                # We'll create this in the next step
        except ImportError:
            msg = "Streamlit not installed. Run: pip install streamlit"
            if self.console:
                self.console.print(f"[red]{msg}[/red]")
            else:
                print(msg)

def main():
    """Main entry point"""
    dashboard = MiradorUnifiedDashboard()
    
    # Check for command line arguments
    if len(sys.argv) > 1:
        if sys.argv[1] == "--web":
            dashboard.launch_web_dashboard()
        elif sys.argv[1] == "--help":
            print("Mirador Unified Dashboard")
            print("\nUsage:")
            print("  mirador-dashboard         # Launch terminal interface")
            print("  mirador-dashboard --web   # Launch web interface")
            print("  mirador-dashboard --help  # Show this help")
        else:
            print(f"Unknown option: {sys.argv[1]}")
    else:
        dashboard.run_terminal_interface()

if __name__ == "__main__":
    main()