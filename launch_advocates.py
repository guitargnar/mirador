#!/usr/bin/env python3
"""
Humana Advocates Program Launcher
Complete solution for driving internal change through associate innovation
"""

import os
import sys
import argparse
import subprocess
from datetime import datetime
import time

# Import all components
from advocates_program import AdvocatesProgram
from pain_point_analyzer import PainPointAnalyzer
from advocates_dashboard import AdvocatesDashboard
from presentation_generator import PresentationGenerator
from enhanced_mirador import run_enhanced_chain
from metrics_tracker import MetricsTracker


class AdvocatesLauncher:
    """Main launcher for all Advocates Program functionality"""
    
    def __init__(self):
        self.advocates = AdvocatesProgram()
        self.analyzer = PainPointAnalyzer()
        self.metrics = MetricsTracker()
        
    def interactive_mode(self):
        """Run interactive mode for advocates"""
        print("""
╔══════════════════════════════════════════════════════════════╗
║             HUMANA ADVOCATES PROGRAM - MIRADOR               ║
║                                                              ║
║  Transforming Pain Points into Innovation Opportunities      ║
║                                                              ║
║  Remember: Every pain point reported, every solution         ║
║  created, every piece of evidence collected strengthens      ║
║  our case for positive change.                               ║
╚══════════════════════════════════════════════════════════════╝
        """)
        
        while True:
            print("\n" + "="*60)
            print("MAIN MENU")
            print("="*60)
            print("1. Report a Pain Point")
            print("2. Document a Solution")
            print("3. Add Evidence")
            print("4. View Dashboard (Web)")
            print("5. Generate Leadership Report")
            print("6. Run Mirador Analysis")
            print("7. View My Impact")
            print("8. Anonymous Feedback")
            print("9. Exit")
            print("="*60)
            
            choice = input("\nSelect an option (1-9): ").strip()
            
            if choice == '1':
                self.report_pain_point()
            elif choice == '2':
                self.document_solution()
            elif choice == '3':
                self.add_evidence()
            elif choice == '4':
                self.launch_dashboard()
            elif choice == '5':
                self.generate_report()
            elif choice == '6':
                self.run_mirador_analysis()
            elif choice == '7':
                self.view_my_impact()
            elif choice == '8':
                self.anonymous_feedback()
            elif choice == '9':
                print("\nThank you for being a Humana Advocate!")
                print("Together, we're driving positive change.")
                break
            else:
                print("\n❌ Invalid option. Please try again.")
                
    def report_pain_point(self):
        """Interactive pain point reporting"""
        print("\n📝 REPORT A PAIN POINT")
        print("-" * 40)
        
        # Get description
        print("\nDescribe the pain point in detail:")
        description = input("> ").strip()
        
        if not description:
            print("❌ Description required")
            return
            
        # Check for similar
        similar = self.advocates.search_similar_pain_points(description, limit=3)
        if similar:
            print("\n🔍 Similar pain points already reported:")
            for i, point in enumerate(similar, 1):
                print(f"\n{i}. {point['description'][:80]}...")
                print(f"   Category: {point['category']} | Upvotes: {point['upvotes']}")
                
            choice = input("\nIs your pain point different? (y/n): ").lower()
            if choice == 'n':
                # Upvote existing
                pain_id = input("Enter number to upvote (1-3): ").strip()
                try:
                    selected = similar[int(pain_id) - 1]
                    self.advocates.upvote_pain_point(selected['id'])
                    print(f"✅ Upvoted pain point #{selected['id']}")
                    return
                except:
                    pass
                    
        # Category selection
        print("\nSelect category:")
        categories = list(self.advocates.pain_categories.keys())
        for i, cat in enumerate(categories, 1):
            print(f"{i}. {cat.replace('_', ' ').title()}")
            
        cat_choice = input("Category (1-5): ").strip()
        try:
            category = categories[int(cat_choice) - 1]
        except:
            category = None
            
        # Impact level
        print("\nImpact level:")
        print("1. Low - Minor inconvenience")
        print("2. Medium - Affects daily work")
        print("3. High - Significant productivity loss")
        print("4. Critical - Blocks essential functions")
        
        impact_map = {'1': 'low', '2': 'medium', '3': 'high', '4': 'critical'}
        impact = impact_map.get(input("Impact (1-4): ").strip(), 'medium')
        
        # Frequency
        print("\nHow often does this occur?")
        print("1. Rare - Once a month or less")
        print("2. Occasional - Weekly")
        print("3. Frequent - Daily")
        print("4. Constant - Multiple times daily")
        
        freq_map = {'1': 'rare', '2': 'occasional', '3': 'frequent', '4': 'constant'}
        frequency = freq_map.get(input("Frequency (1-4): ").strip(), 'frequent')
        
        # Department
        department = input("\nDepartment (optional, press Enter to skip): ").strip() or None
        
        # Anonymous?
        anonymous = input("\nSubmit anonymously? (y/n): ").lower() == 'y'
        
        # Create pain point
        pain_id = self.advocates.report_pain_point(
            description, category, impact, frequency, department, anonymous
        )
        
        print(f"\n✅ Pain point reported successfully! (ID: {pain_id})")
        
        # Ask for evidence
        if input("\nDo you have evidence to add? (y/n): ").lower() == 'y':
            self.add_evidence_for_pain_point(pain_id)
            
        # Track activity
        self.advocates.track_advocate_activity(
            "pain_point_reported",
            f"Reported pain point #{pain_id}",
            impact_score=5
        )
        
    def document_solution(self):
        """Document an associate-created solution"""
        print("\n💡 DOCUMENT A SOLUTION")
        print("-" * 40)
        
        # Title
        title = input("\nSolution title: ").strip()
        if not title:
            print("❌ Title required")
            return
            
        # Description
        print("\nDescribe your solution:")
        description = input("> ").strip()
        
        # Related pain point
        pain_id = input("\nRelated pain point ID (optional): ").strip()
        pain_point_id = int(pain_id) if pain_id.isdigit() else None
        
        # Time saved
        hours = input("\nEstimated hours saved per week: ").strip()
        time_saved = float(hours) if hours else None
        
        # Implementation details
        print("\nImplementation details (optional):")
        implementation = input("> ").strip() or None
        
        # Create solution
        solution_id = self.advocates.create_solution(
            title, description, pain_point_id, implementation, time_saved
        )
        
        print(f"\n✅ Solution documented! (ID: {solution_id})")
        
        # Is this Mirador?
        if 'mirador' in title.lower():
            print("\n🚀 Mirador detected! Adding automatic evidence...")
            self.collect_mirador_evidence()
            
        # Track activity
        self.advocates.track_advocate_activity(
            "solution_created",
            f"Created solution #{solution_id}: {title}",
            impact_score=10
        )
        
    def add_evidence(self):
        """Add evidence for a pain point"""
        pain_id = input("\nPain point ID to add evidence for: ").strip()
        
        if not pain_id.isdigit():
            print("❌ Invalid ID")
            return
            
        self.add_evidence_for_pain_point(int(pain_id))
        
    def add_evidence_for_pain_point(self, pain_point_id: int):
        """Add evidence with guided input"""
        print("\nEVIDENCE TYPES:")
        print("1. Metric - Quantitative data")
        print("2. Example - Specific instance")
        print("3. Testimony - Personal experience")
        print("4. Document - Reference material")
        
        type_map = {'1': 'metric', '2': 'example', '3': 'testimony', '4': 'document'}
        evidence_type = type_map.get(input("Type (1-4): ").strip(), 'example')
        
        print(f"\nDescribe the {evidence_type}:")
        description = input("> ").strip()
        
        data = {'description': description}
        
        # Type-specific data
        if evidence_type == 'metric':
            value = input("Metric value: ").strip()
            unit = input("Unit (hours/dollars/percent/count): ").strip()
            data['value'] = value
            data['unit'] = unit
        elif evidence_type == 'example':
            when = input("When did this occur? ").strip()
            data['when'] = when
            
        # Add evidence
        result = self.analyzer.track_evidence(pain_point_id, evidence_type, data)
        
        print(f"\n✅ Evidence added! (ID: {result['evidence_id']})")
        
        if result.get('impact_analysis'):
            print(f"Evidence strength: {result['impact_analysis']['credibility']}")
            
    def launch_dashboard(self):
        """Launch the web dashboard"""
        print("\n🌐 Launching Advocates Dashboard...")
        print("Access at: http://localhost:5000")
        print("Press Ctrl+C to return to menu")
        
        try:
            dashboard = AdvocatesDashboard()
            dashboard.run()
        except KeyboardInterrupt:
            print("\n\nDashboard closed.")
            
    def generate_report(self):
        """Generate leadership report"""
        print("\n📊 GENERATE LEADERSHIP REPORT")
        print("-" * 40)
        
        print("1. Full presentation (PowerPoint)")
        print("2. Quick summary (3 slides)")
        print("3. Evidence report (Markdown)")
        print("4. Pain point analysis (Markdown)")
        
        choice = input("\nSelect report type (1-4): ").strip()
        
        generator = PresentationGenerator()
        
        if choice == '1':
            output = generator.generate_executive_presentation()
            print(f"\n✅ Generated full presentation: {output}")
        elif choice == '2':
            output = generator.generate_quick_summary()
            print(f"\n✅ Generated summary presentation: {output}")
        elif choice == '3':
            report = self.analyzer.generate_evidence_report()
            filename = f"evidence_report_{datetime.now().strftime('%Y%m%d')}.md"
            with open(filename, 'w') as f:
                f.write(report)
            print(f"\n✅ Generated evidence report: {filename}")
        elif choice == '4':
            report = self.advocates.export_for_leadership()
            filename = f"pain_point_report_{datetime.now().strftime('%Y%m%d')}.md"
            with open(filename, 'w') as f:
                f.write(report)
            print(f"\n✅ Generated pain point report: {filename}")
            
    def run_mirador_analysis(self):
        """Run Mirador on advocate-related prompts"""
        print("\n🤖 MIRADOR ANALYSIS")
        print("-" * 40)
        
        print("1. Analyze pain point patterns")
        print("2. Generate solution ideas")
        print("3. Create presentation talking points")
        print("4. Draft communication strategy")
        print("5. Custom prompt")
        
        choice = input("\nSelect analysis type (1-5): ").strip()
        
        prompts = {
            '1': "Analyze the pain points reported by Humana associates and identify the systemic root causes. Focus on actionable insights for leadership.",
            '2': "Based on the tool restriction and communication pain points at Humana, generate innovative solutions that associates could implement with current resources.",
            '3': "Create executive talking points that position the Advocates Program and Mirador as transformative initiatives. Include specific metrics and success stories.",
            '4': "Design a communication strategy to present associate innovations to leadership without threatening middle management. Focus on win-win positioning.",
            '5': None
        }
        
        prompt = prompts.get(choice)
        
        if choice == '5':
            prompt = input("\nEnter your prompt: ").strip()
        elif not prompt:
            print("❌ Invalid choice")
            return
            
        print("\n🔄 Running Mirador analysis...")
        
        result = run_enhanced_chain(prompt, chain_type="strategic_synthesis")
        
        print("\n" + "="*60)
        print("MIRADOR ANALYSIS RESULTS")
        print("="*60)
        print(result['result']['final_output'])
        print("="*60)
        
        # Save option
        if input("\nSave analysis? (y/n): ").lower() == 'y':
            filename = f"mirador_analysis_{datetime.now().strftime('%Y%m%d_%H%M%S')}.md"
            with open(filename, 'w') as f:
                f.write(result['result']['final_output'])
            print(f"✅ Saved to {filename}")
            
    def view_my_impact(self):
        """View personal advocate impact"""
        report = self.advocates.generate_advocate_report()
        
        print("\n" + "="*60)
        print("YOUR ADVOCATE IMPACT")
        print("="*60)
        print(f"Pain Points Reported: {report['pain_points_reported']}")
        print(f"Solutions Created: {report['solutions_created']}")
        print(f"Hours Saved: {report['total_hours_saved']:.1f}")
        print(f"Impact Score: {report['impact_score']}")
        
        print("\nActivity Breakdown:")
        for activity in report['activities']:
            print(f"  • {activity['activity_type']}: {activity['count']} times")
            
        print("\n💪 Thank you for driving change!")
        
    def anonymous_feedback(self):
        """Submit anonymous feedback"""
        print("\n🔒 ANONYMOUS FEEDBACK")
        print("-" * 40)
        print("Your identity will not be recorded.")
        
        print("\nFeedback category:")
        print("1. Leadership")
        print("2. Tools & Technology")
        print("3. Culture")
        print("4. Process")
        print("5. Other")
        
        cat_map = {'1': 'leadership', '2': 'technology', '3': 'culture', 
                   '4': 'process', '5': 'other'}
        category = cat_map.get(input("Category (1-5): ").strip(), 'other')
        
        print("\nYour feedback:")
        message = input("> ").strip()
        
        if not message:
            print("❌ Feedback required")
            return
            
        print("\nSentiment:")
        print("1. Positive")
        print("2. Neutral")
        print("3. Negative")
        
        sent_map = {'1': 'positive', '2': 'neutral', '3': 'negative'}
        sentiment = sent_map.get(input("Sentiment (1-3): ").strip(), 'neutral')
        
        # Submit
        feedback_id = self.advocates.collect_anonymous_feedback(
            message, category, sentiment
        )
        
        print(f"\n✅ Feedback submitted anonymously (ID: {feedback_id})")
        print("Your voice matters. Thank you for sharing.")
        
    def collect_mirador_evidence(self):
        """Automatically collect Mirador evidence"""
        from pain_point_analyzer import collect_mirador_evidence
        collect_mirador_evidence(self.analyzer)


def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(
        description="Humana Advocates Program - Driving Internal Change"
    )
    
    parser.add_argument(
        'mode',
        nargs='?',
        default='interactive',
        choices=['interactive', 'dashboard', 'report', 'analyze'],
        help='Execution mode'
    )
    
    parser.add_argument('--days', type=int, default=30, help='Days for analysis')
    
    args = parser.parse_args()
    
    launcher = AdvocatesLauncher()
    
    if args.mode == 'interactive':
        launcher.interactive_mode()
    elif args.mode == 'dashboard':
        launcher.launch_dashboard()
    elif args.mode == 'report':
        launcher.generate_report()
    elif args.mode == 'analyze':
        analyzer = PainPointAnalyzer()
        analysis = analyzer.analyze_pain_points(timeframe_days=args.days)
        print(f"\nPain Point Analysis (Last {args.days} Days)")
        print(f"Total Reports: {analysis['total_reports']}")
        print(f"Patterns Detected: {len(analysis['patterns_detected'])}")
        print(f"Recommendations: {len(analysis['recommendations'])}")


if __name__ == "__main__":
    main()