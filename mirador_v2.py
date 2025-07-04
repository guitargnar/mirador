#!/usr/bin/env python3
"""
Mirador V2 - The Real Implementation
AI Orchestration Framework with actual metrics, automation, and learning
"""

import os
import sys
import json
import argparse
import asyncio
from datetime import datetime
from typing import Dict, List, Optional
import logging

# Import our enhanced components
from enhanced_mirador import EnhancedMirador, run_enhanced_chain
from metrics_tracker import MetricsTracker
from automation_engine import AutomationEngine
from quality_assurance import QualityAssurance
from memory_system import MemorySystem

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Version info
VERSION = "2.0.0"
BANNER = f"""
╔══════════════════════════════════════════════════════════════╗
║                    MIRADOR v{VERSION}                         ║
║         AI Orchestration That Actually Works™                 ║
║                                                              ║
║  • Real metrics tracking (not just claims)                   ║
║  • Actual task automation (not just prompts)                 ║
║  • Quality assurance built-in                                ║
║  • Learning from every interaction                           ║
╚══════════════════════════════════════════════════════════════╝
"""


class MiradorCLI:
    """Command-line interface for Mirador V2"""
    
    def __init__(self):
        self.mirador = EnhancedMirador()
        self.metrics = MetricsTracker()
        self.automation = AutomationEngine()
        self.qa = QualityAssurance()
        self.memory = MemorySystem()
        
    def run_interactive(self):
        """Run interactive mode with full capabilities"""
        print(BANNER)
        print("Type 'help' for available commands or 'exit' to quit.\n")
        
        while True:
            try:
                prompt = input("mirador> ").strip()
                
                if not prompt:
                    continue
                    
                if prompt.lower() in ['exit', 'quit', 'q']:
                    break
                    
                if prompt.lower() == 'help':
                    self.show_help()
                    continue
                    
                # Handle special commands
                if prompt.startswith('/'):
                    self.handle_command(prompt)
                    continue
                    
                # Run the enhanced chain
                print("\n🔄 Processing your request...\n")
                
                result = run_enhanced_chain(prompt)
                
                # Display results
                self.display_results(result)
                
                # Ask for feedback
                self.collect_feedback(result['session_id'])
                
            except KeyboardInterrupt:
                print("\n\nUse 'exit' to quit properly.")
            except Exception as e:
                logger.error(f"Error: {e}")
                print(f"\n❌ Error: {e}\n")
                
        print("\nThank you for using Mirador. Your sessions have been saved for learning.")
        
    def show_help(self):
        """Display help information"""
        help_text = """
Available Commands:
  
Regular Usage:
  Just type your request naturally. Mirador will:
  - Automatically select the best models
  - Track metrics and time saved
  - Ensure quality output
  - Learn from your feedback

Special Commands:
  /metrics [days]      - Show performance metrics
  /status             - Show system status
  /tasks              - List automation tasks
  /history [n]        - Show last n executions
  /search <query>     - Search memory for similar requests
  /export             - Export metrics and memory
  /automate           - Set up automation rules
  /quality <session>  - Check quality of a session
  
Examples:
  "Analyze our risk management process and suggest improvements"
  "Create a financial report for Q4 with key insights"
  "Help me prepare for tomorrow's executive presentation"
  
Pro Tips:
  - Be specific about what you want
  - Mention time constraints if any
  - Rate outputs to improve future responses
  - Use /metrics to see your time savings
"""
        print(help_text)
        
    def handle_command(self, command: str):
        """Handle special slash commands"""
        parts = command.split()
        cmd = parts[0].lower()
        
        if cmd == '/metrics':
            days = int(parts[1]) if len(parts) > 1 else 7
            self.show_metrics(days)
            
        elif cmd == '/status':
            self.show_status()
            
        elif cmd == '/tasks':
            self.show_automation_tasks()
            
        elif cmd == '/history':
            limit = int(parts[1]) if len(parts) > 1 else 10
            self.show_history(limit)
            
        elif cmd == '/search':
            if len(parts) > 1:
                query = ' '.join(parts[1:])
                self.search_memory(query)
            else:
                print("Usage: /search <query>")
                
        elif cmd == '/export':
            self.export_data()
            
        elif cmd == '/automate':
            self.setup_automation()
            
        elif cmd == '/quality':
            if len(parts) > 1:
                self.check_quality(parts[1])
            else:
                print("Usage: /quality <session_id>")
                
        else:
            print(f"Unknown command: {cmd}")
            
    def display_results(self, result: Dict):
        """Display results with metrics"""
        print("="*60)
        print(f"📋 Session ID: {result['session_id']}")
        print(f"⏱️  Duration: {result['metrics']['duration']:.1f} seconds")
        print(f"🎯 Quality Score: {result['quality']['scores']['overall_quality']:.1f}/100")
        
        if result.get('suggestions_used'):
            print(f"💡 Used {len(result['suggestions_used'])} suggestions from memory")
            
        print("\n📄 Output:\n")
        print(result['result']['final_output'])
        
        print("\n" + "="*60)
        
        # Show any quality warnings
        if result['quality']['warnings']:
            print("\n⚠️  Quality Warnings:")
            for warning in result['quality']['warnings']:
                print(f"  - {warning['message']}")
                
    def collect_feedback(self, session_id: str):
        """Collect user feedback"""
        print("\n📊 How would you rate this response?")
        print("1 - Poor | 2 - Fair | 3 - Good | 4 - Very Good | 5 - Excellent")
        print("(Press Enter to skip)")
        
        try:
            rating_input = input("Rating: ").strip()
            if rating_input:
                rating = int(rating_input)
                if 1 <= rating <= 5:
                    # Ask for time saved estimate
                    time_input = input("How many hours did this save you? (press Enter to skip): ").strip()
                    time_saved = float(time_input) if time_input else None
                    
                    # Optional feedback text
                    if rating <= 2:
                        feedback = input("What could be improved? ").strip()
                    else:
                        feedback = input("Any additional feedback? (press Enter to skip): ").strip()
                        
                    # Record feedback
                    self.mirador.record_feedback(
                        session_id, rating, 
                        feedback if feedback else None,
                        time_saved
                    )
                    
                    print("✅ Thank you! Your feedback helps Mirador improve.")
                else:
                    print("Invalid rating. Skipping feedback.")
        except ValueError:
            print("Invalid input. Skipping feedback.")
            
    def show_metrics(self, days: int):
        """Display performance metrics"""
        metrics = self.metrics.get_aggregate_metrics(days)
        
        print(f"\n📊 Mirador Metrics (Last {days} Days)\n")
        print(f"Total Executions:     {metrics['total_executions']}")
        print(f"Success Rate:         {metrics['success_rate']:.1f}%")
        print(f"Average Duration:     {metrics['avg_duration_seconds']:.1f} seconds")
        print(f"Total Hours Saved:    {metrics['total_hours_saved']:.1f} hours")
        print(f"Efficiency Gain:      {metrics['avg_efficiency_gain_percent']:.1f}%")
        print(f"Average Quality:      {metrics['avg_quality_score']:.1f}/100")
        print(f"User Rating:          {metrics['avg_user_rating']:.1f}/5.0")
        print(f"Estimated Savings:    ${metrics['estimated_cost_savings']:,.2f}")
        print(f"ROI Multiplier:       {metrics['roi_multiplier']:.1f}x")
        
        # Show improvement trend
        if days > 7:
            metrics_7d = self.metrics.get_aggregate_metrics(7)
            quality_trend = metrics_7d['avg_quality_score'] - metrics['avg_quality_score']
            if quality_trend > 0:
                print(f"\n📈 Quality improving: +{quality_trend:.1f} points in last 7 days")
                
    def show_status(self):
        """Show system status"""
        data = self.mirador.get_dashboard_data()
        
        print("\n🔧 System Status\n")
        print(f"Active Sessions:      {data['active_sessions']}")
        print(f"Total Memories:       {data['memory_stats']['total_memories']}")
        print(f"Unique Sessions:      {data['memory_stats']['unique_sessions']}")
        print(f"Quality Threshold:    {data['quality_threshold']}/100")
        print(f"Automation Tasks:     {len(data['automation_tasks'])}")
        
        # Check component health
        print("\n🏥 Component Health:")
        components = [
            ("Metrics Tracker", self.metrics.conn is not None),
            ("Quality Assurance", True),  # Always available
            ("Memory System", self.memory.vector_store is not None),
            ("Automation Engine", self.automation.running)
        ]
        
        for name, healthy in components:
            status = "✅ Healthy" if healthy else "⚠️  Degraded"
            print(f"  {name}: {status}")
            
    def show_automation_tasks(self):
        """Show automation task status"""
        tasks = self.automation.get_task_status()
        
        print("\n🤖 Automation Tasks\n")
        
        if not tasks:
            print("No automation tasks configured.")
            print("Use /automate to set up automated workflows.")
            return
            
        for task in tasks:
            print(f"Task: {task['name']}")
            print(f"  Description: {task['description']}")
            print(f"  Triggers: {', '.join(task['triggers'])}")
            print(f"  Last Run: {task['last_run'] or 'Never'}")
            print(f"  Status: {task['last_status'] or 'Not run'}")
            print()
            
    def show_history(self, limit: int):
        """Show execution history"""
        history = self.metrics.get_execution_history(limit)
        
        print(f"\n📜 Recent Executions (Last {limit})\n")
        
        for i, exec in enumerate(history, 1):
            print(f"{i}. Session: {exec['session_id']}")
            print(f"   Time: {exec['start_time']}")
            print(f"   Duration: {exec['duration_seconds']:.1f}s")
            print(f"   Success: {'✅' if exec['success'] else '❌'}")
            print(f"   Quality: {exec.get('overall_quality', 'N/A')}")
            print(f"   Prompt: {exec['prompt'][:60]}...")
            print()
            
    def search_memory(self, query: str):
        """Search memory for similar requests"""
        results = self.memory.recall(query, limit=5)
        
        print(f"\n🔍 Memory Search Results for '{query}'\n")
        
        if not results:
            print("No similar memories found.")
            return
            
        for i, result in enumerate(results, 1):
            print(f"{i}. Similarity: {result['similarity']:.2f}")
            print(f"   Content: {result['content'][:150]}...")
            print(f"   Session: {result['metadata'].get('session_id', 'unknown')}")
            print(f"   Date: {result['metadata'].get('timestamp', 'unknown')}")
            print()
            
    def export_data(self):
        """Export metrics and memory data"""
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        
        # Export metrics
        metrics_file = f"mirador_metrics_{timestamp}.json"
        metrics_data = self.metrics.export_metrics(format='json')
        with open(metrics_file, 'w') as f:
            f.write(metrics_data)
            
        # Export memory
        memory_file = f"mirador_memory_{timestamp}.json"
        memory_data = self.memory.export_memory(format='json')
        with open(memory_file, 'w') as f:
            f.write(memory_data)
            
        print(f"\n✅ Data exported successfully:")
        print(f"  Metrics: {metrics_file}")
        print(f"  Memory: {memory_file}")
        
    def setup_automation(self):
        """Interactive automation setup"""
        print("\n🤖 Automation Setup Wizard\n")
        print("Available automation types:")
        print("1. Daily Summary (runs every morning)")
        print("2. Report Processor (monitors folder for new files)")
        print("3. Quality Monitor (checks output quality hourly)")
        print("4. Custom Schedule (define your own)")
        
        choice = input("\nSelect type (1-4): ").strip()
        
        if choice == '1':
            time = input("What time? (HH:MM, default 09:00): ").strip() or "09:00"
            self.automation.register_task(
                'daily_summary',
                self._daily_summary_task,
                {'schedule': {'type': 'daily', 'time': time}},
                description="Generate daily activity summary"
            )
            print("✅ Daily summary scheduled!")
            
        elif choice == '2':
            path = input("Folder to monitor: ").strip()
            if os.path.exists(path):
                self.automation.register_task(
                    'report_processor',
                    self._report_processor_task,
                    {'file_watch': {'path': path, 'patterns': ['*.pdf', '*.docx']}},
                    description="Process incoming reports"
                )
                print("✅ Report processor configured!")
            else:
                print("❌ Invalid path")
                
        # Add more automation types as needed
        
    def check_quality(self, session_id: str):
        """Check quality of a specific session"""
        # Load session output
        output_file = os.path.expanduser(
            f"~/.mirador/outputs/{session_id}/final_output.md"
        )
        
        if not os.path.exists(output_file):
            print(f"Session {session_id} not found")
            return
            
        with open(output_file, 'r') as f:
            content = f.read()
            
        # Run quality analysis
        result = self.qa.analyze_output(content)
        
        print(f"\n📋 Quality Analysis for Session {session_id}\n")
        print(f"Overall Score: {result['scores']['overall_quality']:.1f}/100")
        print(f"Passed: {'✅ Yes' if result['passed'] else '❌ No'}")
        
        print("\nDetailed Scores:")
        for metric, score in result['scores'].items():
            if metric != 'overall_quality':
                print(f"  {metric}: {score:.1f}")
                
        if result['errors']:
            print("\nErrors:")
            for error in result['errors']:
                print(f"  [{error['severity']}] {error['message']}")
                
        if result['recommendations']:
            print("\nRecommendations:")
            for rec in result['recommendations']:
                print(f"  - {rec}")
                
    # Task implementations for automation
    def _daily_summary_task(self, **kwargs):
        """Generate daily summary"""
        result = run_enhanced_chain(
            "Generate a summary of today's Mirador activities with key insights and metrics",
            chain_type="summary"
        )
        
        # Save to file
        summary_file = f"daily_summary_{datetime.now().strftime('%Y%m%d')}.md"
        with open(summary_file, 'w') as f:
            f.write(result['result']['final_output'])
            
        return {'file': summary_file}
        
    def _report_processor_task(self, trigger_file: str = None, **kwargs):
        """Process incoming reports"""
        if trigger_file:
            # Process the specific file
            result = run_enhanced_chain(
                f"Process and analyze the report: {trigger_file}",
                chain_type="analysis"
            )
            
            output_file = f"processed_{os.path.basename(trigger_file)}.md"
            with open(output_file, 'w') as f:
                f.write(result['result']['final_output'])
                
            return {'processed': trigger_file, 'output': output_file}
            
        return {'error': 'No file to process'}


def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(
        description="Mirador V2 - AI Orchestration That Actually Works"
    )
    
    parser.add_argument(
        'mode', 
        nargs='?',
        default='interactive',
        choices=['interactive', 'run', 'metrics', 'dashboard', 'automate'],
        help='Execution mode'
    )
    
    parser.add_argument('--prompt', '-p', help='Prompt for run mode')
    parser.add_argument('--chain', '-c', help='Chain type')
    parser.add_argument('--days', '-d', type=int, default=7, help='Days for metrics')
    parser.add_argument('--version', '-v', action='version', version=f'Mirador v{VERSION}')
    
    args = parser.parse_args()
    
    cli = MiradorCLI()
    
    if args.mode == 'interactive':
        cli.run_interactive()
        
    elif args.mode == 'run':
        if not args.prompt:
            print("Error: --prompt required for run mode")
            sys.exit(1)
            
        result = run_enhanced_chain(args.prompt, chain_type=args.chain)
        cli.display_results(result)
        
    elif args.mode == 'metrics':
        cli.show_metrics(args.days)
        
    elif args.mode == 'dashboard':
        cli.show_status()
        cli.show_metrics(7)
        cli.show_automation_tasks()
        
    elif args.mode == 'automate':
        # Start automation engine
        print("Starting Mirador Automation Engine...")
        cli.automation.start()
        print("Automation engine running. Press Ctrl+C to stop.")
        
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            cli.automation.stop()
            print("\nAutomation engine stopped.")


if __name__ == "__main__":
    main()