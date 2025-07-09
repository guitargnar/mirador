#!/usr/bin/env python3
"""
Mirador Daily Action Prioritization and Tracking System
Scores opportunities, manages daily workflows, and tracks outcomes
"""

import sqlite3
import json
import time
from datetime import datetime, timedelta
from pathlib import Path
import argparse
import subprocess
import re

class MiradorActionPrioritizer:
    def __init__(self):
        self.base_dir = Path.home() / "ai_framework_git"
        self.tracking_db = self.base_dir / "action_tracking.db"
        self.actions_dir = self.base_dir / "daily_actions"
        
        # Create directories
        self.actions_dir.mkdir(parents=True, exist_ok=True)
        
        # Initialize tracking database
        self.init_tracking_db()
        
        # Scoring weights for prioritization
        self.scoring_weights = {
            'financial_impact': 0.3,
            'time_efficiency': 0.2,
            'strategic_value': 0.2,
            'feasibility': 0.15,
            'urgency': 0.1,
            'learning_value': 0.05
        }
        
    def init_tracking_db(self):
        """Initialize comprehensive tracking database"""
        conn = sqlite3.connect(self.tracking_db)
        cursor = conn.cursor()
        
        # Action opportunities table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS action_opportunities (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                date_identified TEXT NOT NULL,
                opportunity_title TEXT NOT NULL,
                opportunity_description TEXT,
                financial_impact_score REAL DEFAULT 0,
                time_efficiency_score REAL DEFAULT 0,
                strategic_value_score REAL DEFAULT 0,
                feasibility_score REAL DEFAULT 0,
                urgency_score REAL DEFAULT 0,
                learning_value_score REAL DEFAULT 0,
                total_priority_score REAL DEFAULT 0,
                estimated_time_minutes INTEGER,
                estimated_cost REAL DEFAULT 0,
                potential_savings REAL DEFAULT 0,
                potential_income REAL DEFAULT 0,
                deadline_date TEXT,
                status TEXT DEFAULT 'identified',
                selected_for_action BOOLEAN DEFAULT 0,
                action_date TEXT,
                completion_status TEXT,
                actual_time_minutes INTEGER,
                actual_cost REAL,
                actual_savings REAL,
                actual_income REAL,
                satisfaction_rating INTEGER,
                outcome_notes TEXT,
                lessons_learned TEXT,
                would_repeat BOOLEAN,
                created_timestamp TEXT,
                updated_timestamp TEXT
            )
        ''')
        
        # Daily action log
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS daily_action_log (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                action_date TEXT NOT NULL,
                opportunity_id INTEGER,
                action_title TEXT NOT NULL,
                action_description TEXT,
                planned_start_time TEXT,
                actual_start_time TEXT,
                planned_duration INTEGER,
                actual_duration INTEGER,
                completion_percentage INTEGER DEFAULT 0,
                obstacles_encountered TEXT,
                resources_used TEXT,
                immediate_outcome TEXT,
                follow_up_required TEXT,
                energy_level_before INTEGER,
                energy_level_after INTEGER,
                mood_before TEXT,
                mood_after TEXT,
                created_timestamp TEXT,
                updated_timestamp TEXT,
                FOREIGN KEY (opportunity_id) REFERENCES action_opportunities (id)
            )
        ''')
        
        # Performance metrics
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS performance_metrics (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                metric_date TEXT NOT NULL,
                total_actions_planned INTEGER DEFAULT 0,
                total_actions_completed INTEGER DEFAULT 0,
                completion_rate REAL DEFAULT 0,
                average_satisfaction REAL DEFAULT 0,
                total_time_invested INTEGER DEFAULT 0,
                total_financial_impact REAL DEFAULT 0,
                total_savings_realized REAL DEFAULT 0,
                total_income_generated REAL DEFAULT 0,
                high_value_actions_count INTEGER DEFAULT 0,
                learning_opportunities_count INTEGER DEFAULT 0,
                strategic_progress_score REAL DEFAULT 0,
                efficiency_improvement_score REAL DEFAULT 0,
                created_timestamp TEXT
            )
        ''')
        
        # User preferences and context
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS user_context (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                context_date TEXT NOT NULL,
                available_time_minutes INTEGER,
                energy_level INTEGER,
                current_priorities TEXT,
                financial_goals TEXT,
                learning_interests TEXT,
                preferred_action_types TEXT,
                time_constraints TEXT,
                resource_constraints TEXT,
                mood_state TEXT,
                focus_areas TEXT,
                created_timestamp TEXT
            )
        ''')
        
        conn.commit()
        conn.close()
    
    def score_opportunity(self, opportunity_data):
        """Score an opportunity across multiple dimensions"""
        scores = {}
        
        # Financial Impact Score (0-10)
        financial_impact = self._calculate_financial_impact_score(opportunity_data)
        scores['financial_impact'] = financial_impact
        
        # Time Efficiency Score (0-10)
        time_efficiency = self._calculate_time_efficiency_score(opportunity_data)
        scores['time_efficiency'] = time_efficiency
        
        # Strategic Value Score (0-10)
        strategic_value = self._calculate_strategic_value_score(opportunity_data)
        scores['strategic_value'] = strategic_value
        
        # Feasibility Score (0-10)
        feasibility = self._calculate_feasibility_score(opportunity_data)
        scores['feasibility'] = feasibility
        
        # Urgency Score (0-10)
        urgency = self._calculate_urgency_score(opportunity_data)
        scores['urgency'] = urgency
        
        # Learning Value Score (0-10)
        learning_value = self._calculate_learning_value_score(opportunity_data)
        scores['learning_value'] = learning_value
        
        # Calculate weighted total score
        total_score = sum(
            scores[dimension] * self.scoring_weights[dimension]
            for dimension in scores
        )
        
        scores['total_priority_score'] = total_score
        
        return scores
    
    def _calculate_financial_impact_score(self, opportunity):
        """Calculate financial impact score based on potential savings/income"""
        potential_savings = opportunity.get('potential_savings', 0)
        potential_income = opportunity.get('potential_income', 0)
        estimated_cost = opportunity.get('estimated_cost', 0)
        
        net_financial_impact = potential_savings + potential_income - estimated_cost
        
        # Score based on net impact relative to monthly income (~$6200)
        monthly_income = 6200
        impact_ratio = net_financial_impact / monthly_income
        
        if impact_ratio >= 0.1:  # 10%+ of monthly income
            return 10
        elif impact_ratio >= 0.05:  # 5-10%
            return 8
        elif impact_ratio >= 0.02:  # 2-5%
            return 6
        elif impact_ratio >= 0.01:  # 1-2%
            return 4
        elif impact_ratio > 0:  # Positive impact
            return 2
        else:  # No financial impact
            return 0
    
    def _calculate_time_efficiency_score(self, opportunity):
        """Calculate time efficiency score based on value per time invested"""
        estimated_time = opportunity.get('estimated_time_minutes', 60)
        potential_savings = opportunity.get('potential_savings', 0)
        potential_income = opportunity.get('potential_income', 0)
        
        total_value = potential_savings + potential_income
        
        if estimated_time == 0:
            return 0
        
        value_per_hour = (total_value / estimated_time) * 60
        
        # Score based on effective hourly value
        if value_per_hour >= 200:  # $200+/hour
            return 10
        elif value_per_hour >= 100:  # $100-200/hour
            return 8
        elif value_per_hour >= 50:  # $50-100/hour
            return 6
        elif value_per_hour >= 25:  # $25-50/hour
            return 4
        elif value_per_hour > 0:  # Positive value
            return 2
        else:
            return 0
    
    def _calculate_strategic_value_score(self, opportunity):
        """Calculate strategic value based on long-term benefits"""
        description = opportunity.get('opportunity_description', '').lower()
        
        strategic_keywords = {
            'investment': 3,
            'education': 2,
            'network': 2,
            'skill': 2,
            'relationship': 2,
            'automation': 3,
            'system': 2,
            'process': 2,
            'optimization': 2,
            'efficiency': 2,
            'career': 3,
            'professional': 2,
            'long-term': 3,
            'future': 2,
            'growth': 2,
            'development': 2
        }
        
        score = 0
        for keyword, value in strategic_keywords.items():
            if keyword in description:
                score += value
        
        return min(score, 10)  # Cap at 10
    
    def _calculate_feasibility_score(self, opportunity):
        """Calculate feasibility based on resource requirements and constraints"""
        estimated_time = opportunity.get('estimated_time_minutes', 60)
        estimated_cost = opportunity.get('estimated_cost', 0)
        
        # Time feasibility (assuming 2-3 hours available daily)
        if estimated_time <= 30:  # 30 minutes or less
            time_score = 10
        elif estimated_time <= 60:  # 1 hour
            time_score = 8
        elif estimated_time <= 120:  # 2 hours
            time_score = 6
        elif estimated_time <= 180:  # 3 hours
            time_score = 4
        else:  # More than 3 hours
            time_score = 2
        
        # Cost feasibility (assuming $500 monthly discretionary budget)
        if estimated_cost == 0:  # Free
            cost_score = 10
        elif estimated_cost <= 50:  # Under $50
            cost_score = 8
        elif estimated_cost <= 100:  # $50-100
            cost_score = 6
        elif estimated_cost <= 200:  # $100-200
            cost_score = 4
        elif estimated_cost <= 500:  # $200-500
            cost_score = 2
        else:  # Over $500
            cost_score = 0
        
        return (time_score + cost_score) / 2
    
    def _calculate_urgency_score(self, opportunity):
        """Calculate urgency based on deadlines and time sensitivity"""
        deadline_date = opportunity.get('deadline_date')
        description = opportunity.get('opportunity_description', '').lower()
        
        urgency_keywords = {
            'deadline': 3,
            'expires': 3,
            'limited time': 3,
            'ends': 2,
            'soon': 2,
            'today': 4,
            'tomorrow': 3,
            'this week': 2,
            'urgent': 3,
            'immediate': 4
        }
        
        keyword_score = 0
        for keyword, value in urgency_keywords.items():
            if keyword in description:
                keyword_score += value
        
        # Deadline-based scoring
        deadline_score = 0
        if deadline_date:
            try:
                deadline = datetime.fromisoformat(deadline_date)
                days_until = (deadline - datetime.now()).days
                
                if days_until <= 1:  # Today or tomorrow
                    deadline_score = 10
                elif days_until <= 3:  # Within 3 days
                    deadline_score = 8
                elif days_until <= 7:  # Within a week
                    deadline_score = 6
                elif days_until <= 30:  # Within a month
                    deadline_score = 4
                else:  # More than a month
                    deadline_score = 2
            except:
                deadline_score = 0
        
        return min(max(keyword_score, deadline_score), 10)
    
    def _calculate_learning_value_score(self, opportunity):
        """Calculate learning value based on skill development potential"""
        description = opportunity.get('opportunity_description', '').lower()
        
        learning_keywords = {
            'learn': 2,
            'skill': 2,
            'knowledge': 2,
            'experience': 2,
            'training': 3,
            'course': 3,
            'workshop': 3,
            'certification': 3,
            'new': 1,
            'practice': 2,
            'develop': 2,
            'improve': 2,
            'master': 3,
            'expertise': 3
        }
        
        score = 0
        for keyword, value in learning_keywords.items():
            if keyword in description:
                score += value
        
        return min(score, 10)
    
    def add_opportunity(self, opportunity_data):
        """Add a new opportunity and calculate its priority score"""
        scores = self.score_opportunity(opportunity_data)
        
        conn = sqlite3.connect(self.tracking_db)
        cursor = conn.cursor()
        
        cursor.execute('''
            INSERT INTO action_opportunities 
            (date_identified, opportunity_title, opportunity_description,
             financial_impact_score, time_efficiency_score, strategic_value_score,
             feasibility_score, urgency_score, learning_value_score, total_priority_score,
             estimated_time_minutes, estimated_cost, potential_savings, potential_income,
             deadline_date, created_timestamp)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            datetime.now().strftime('%Y-%m-%d'),
            opportunity_data.get('title', 'Untitled Opportunity'),
            opportunity_data.get('description', ''),
            scores['financial_impact'],
            scores['time_efficiency'],
            scores['strategic_value'],
            scores['feasibility'],
            scores['urgency'],
            scores['learning_value'],
            scores['total_priority_score'],
            opportunity_data.get('estimated_time_minutes', 60),
            opportunity_data.get('estimated_cost', 0),
            opportunity_data.get('potential_savings', 0),
            opportunity_data.get('potential_income', 0),
            opportunity_data.get('deadline_date'),
            datetime.now().isoformat()
        ))
        
        opportunity_id = cursor.lastrowid
        conn.commit()
        conn.close()
        
        return opportunity_id, scores
    
    def get_top_opportunities(self, limit=5, min_score=3.0):
        """Get top-scoring opportunities that haven't been acted upon"""
        conn = sqlite3.connect(self.tracking_db)
        cursor = conn.cursor()
        
        cursor.execute('''
            SELECT id, opportunity_title, opportunity_description, total_priority_score,
                   estimated_time_minutes, estimated_cost, potential_savings, potential_income,
                   deadline_date, financial_impact_score, time_efficiency_score, strategic_value_score,
                   feasibility_score, urgency_score, learning_value_score
            FROM action_opportunities 
            WHERE status = 'identified' AND total_priority_score >= ?
            ORDER BY total_priority_score DESC, urgency_score DESC
            LIMIT ?
        ''', (min_score, limit))
        
        opportunities = cursor.fetchall()
        conn.close()
        
        return opportunities
    
    def select_daily_action(self, opportunity_id):
        """Select an opportunity as today's action"""
        today = datetime.now().strftime('%Y-%m-%d')
        
        conn = sqlite3.connect(self.tracking_db)
        cursor = conn.cursor()
        
        # Mark opportunity as selected
        cursor.execute('''
            UPDATE action_opportunities 
            SET selected_for_action = 1, action_date = ?, status = 'selected'
            WHERE id = ?
        ''', (today, opportunity_id))
        
        # Get opportunity details
        cursor.execute('''
            SELECT opportunity_title, opportunity_description, estimated_time_minutes
            FROM action_opportunities WHERE id = ?
        ''', (opportunity_id,))
        
        opportunity = cursor.fetchone()
        
        if opportunity:
            # Create daily action log entry
            cursor.execute('''
                INSERT INTO daily_action_log 
                (action_date, opportunity_id, action_title, action_description, 
                 planned_duration, created_timestamp)
                VALUES (?, ?, ?, ?, ?, ?)
            ''', (
                today,
                opportunity_id,
                opportunity[0],
                opportunity[1],
                opportunity[2],
                datetime.now().isoformat()
            ))
        
        conn.commit()
        conn.close()
        
        return opportunity
    
    def start_action_execution(self, opportunity_id, energy_level=5, mood="neutral"):
        """Log the start of action execution"""
        conn = sqlite3.connect(self.tracking_db)
        cursor = conn.cursor()
        
        cursor.execute('''
            UPDATE daily_action_log 
            SET actual_start_time = ?, energy_level_before = ?, mood_before = ?
            WHERE opportunity_id = ? AND action_date = ?
        ''', (
            datetime.now().isoformat(),
            energy_level,
            mood,
            opportunity_id,
            datetime.now().strftime('%Y-%m-%d')
        ))
        
        conn.commit()
        conn.close()
    
    def complete_action(self, opportunity_id, completion_percentage=100, 
                       actual_duration=None, obstacles="", resources_used="",
                       immediate_outcome="", follow_up="", energy_after=5, 
                       mood_after="neutral", satisfaction=5, outcome_notes="",
                       actual_savings=0, actual_income=0, actual_cost=0):
        """Log action completion with detailed outcomes"""
        today = datetime.now().strftime('%Y-%m-%d')
        
        conn = sqlite3.connect(self.tracking_db)
        cursor = conn.cursor()
        
        # Update daily action log
        cursor.execute('''
            UPDATE daily_action_log 
            SET completion_percentage = ?, actual_duration = ?, obstacles_encountered = ?,
                resources_used = ?, immediate_outcome = ?, follow_up_required = ?,
                energy_level_after = ?, mood_after = ?, updated_timestamp = ?
            WHERE opportunity_id = ? AND action_date = ?
        ''', (
            completion_percentage, actual_duration, obstacles, resources_used,
            immediate_outcome, follow_up, energy_after, mood_after,
            datetime.now().isoformat(), opportunity_id, today
        ))
        
        # Update opportunity record
        status = 'completed' if completion_percentage >= 100 else 'partially_completed'
        cursor.execute('''
            UPDATE action_opportunities 
            SET completion_status = ?, actual_time_minutes = ?, actual_cost = ?,
                actual_savings = ?, actual_income = ?, satisfaction_rating = ?,
                outcome_notes = ?, status = ?, updated_timestamp = ?
            WHERE id = ?
        ''', (
            status, actual_duration, actual_cost, actual_savings, actual_income,
            satisfaction, outcome_notes, status, datetime.now().isoformat(),
            opportunity_id
        ))
        
        conn.commit()
        conn.close()
    
    def generate_daily_priority_report(self):
        """Generate a report of today's top opportunities"""
        opportunities = self.get_top_opportunities(limit=10)
        
        report = f"""# Daily Priority Report - {datetime.now().strftime('%Y-%m-%d')}

## Top Opportunities (Ranked by Priority Score)

"""
        
        for i, opp in enumerate(opportunities, 1):
            (opp_id, title, description, total_score, est_time, est_cost, 
             pot_savings, pot_income, deadline, fin_score, time_score, 
             strat_score, feas_score, urg_score, learn_score) = opp
            
            net_value = pot_savings + pot_income - est_cost
            
            report += f"""### {i}. {title} (Score: {total_score:.1f}/10)

**Description:** {description[:200]}{'...' if len(description) > 200 else ''}

**Key Metrics:**
- 💰 Net Financial Value: ${net_value:,.2f}
- ⏱️ Estimated Time: {est_time} minutes
- 💸 Estimated Cost: ${est_cost:,.2f}
- 📅 Deadline: {deadline or 'None specified'}

**Scoring Breakdown:**
- Financial Impact: {fin_score:.1f}/10
- Time Efficiency: {time_score:.1f}/10
- Strategic Value: {strat_score:.1f}/10
- Feasibility: {feas_score:.1f}/10
- Urgency: {urg_score:.1f}/10
- Learning Value: {learn_score:.1f}/10

**Action Command:** `mirador-priority select {opp_id}`

---

"""
        
        return report
    
    def get_performance_summary(self, days=30):
        """Generate performance summary for the last N days"""
        end_date = datetime.now()
        start_date = end_date - timedelta(days=days)
        
        conn = sqlite3.connect(self.tracking_db)
        cursor = conn.cursor()
        
        # Get completed actions
        cursor.execute('''
            SELECT COUNT(*), AVG(satisfaction_rating), SUM(actual_time_minutes),
                   SUM(actual_savings), SUM(actual_income), SUM(actual_cost)
            FROM action_opportunities 
            WHERE action_date BETWEEN ? AND ? AND status = 'completed'
        ''', (start_date.strftime('%Y-%m-%d'), end_date.strftime('%Y-%m-%d')))
        
        stats = cursor.fetchone()
        conn.close()
        
        if stats[0]:  # If there are completed actions
            total_actions = stats[0]
            avg_satisfaction = stats[1] or 0
            total_time = stats[2] or 0
            total_savings = stats[3] or 0
            total_income = stats[4] or 0
            total_cost = stats[5] or 0
            net_financial_impact = total_savings + total_income - total_cost
            
            return {
                'period_days': days,
                'total_actions_completed': total_actions,
                'average_satisfaction': avg_satisfaction,
                'total_time_invested_hours': total_time / 60,
                'net_financial_impact': net_financial_impact,
                'total_savings': total_savings,
                'total_income': total_income,
                'total_cost': total_cost,
                'actions_per_week': (total_actions / days) * 7,
                'value_per_hour': net_financial_impact / (total_time / 60) if total_time > 0 else 0
            }
        else:
            return None

def main():
    parser = argparse.ArgumentParser(description="Mirador Action Prioritization System")
    subparsers = parser.add_subparsers(dest='command', help='Available commands')
    
    # Add opportunity
    add_parser = subparsers.add_parser('add', help='Add new opportunity')
    add_parser.add_argument('title', help='Opportunity title')
    add_parser.add_argument('--description', help='Opportunity description')
    add_parser.add_argument('--time', type=int, default=60, help='Estimated time in minutes')
    add_parser.add_argument('--cost', type=float, default=0, help='Estimated cost')
    add_parser.add_argument('--savings', type=float, default=0, help='Potential savings')
    add_parser.add_argument('--income', type=float, default=0, help='Potential income')
    add_parser.add_argument('--deadline', help='Deadline date (YYYY-MM-DD)')
    
    # Show top opportunities
    top_parser = subparsers.add_parser('top', help='Show top opportunities')
    top_parser.add_argument('--limit', type=int, default=5, help='Number of opportunities to show')
    
    # Select daily action
    select_parser = subparsers.add_parser('select', help='Select opportunity as daily action')
    select_parser.add_argument('opportunity_id', type=int, help='Opportunity ID')
    
    # Start action
    start_parser = subparsers.add_parser('start', help='Start action execution')
    start_parser.add_argument('opportunity_id', type=int, help='Opportunity ID')
    start_parser.add_argument('--energy', type=int, default=5, help='Energy level (1-10)')
    start_parser.add_argument('--mood', default='neutral', help='Current mood')
    
    # Complete action
    complete_parser = subparsers.add_parser('complete', help='Complete action')
    complete_parser.add_argument('opportunity_id', type=int, help='Opportunity ID')
    complete_parser.add_argument('--completion', type=int, default=100, help='Completion percentage')
    complete_parser.add_argument('--duration', type=int, help='Actual duration in minutes')
    complete_parser.add_argument('--satisfaction', type=int, default=5, help='Satisfaction rating (1-10)')
    complete_parser.add_argument('--savings', type=float, default=0, help='Actual savings realized')
    complete_parser.add_argument('--income', type=float, default=0, help='Actual income generated')
    complete_parser.add_argument('--cost', type=float, default=0, help='Actual cost incurred')
    complete_parser.add_argument('--notes', help='Outcome notes')
    
    # Generate report
    report_parser = subparsers.add_parser('report', help='Generate priority report')
    
    # Performance summary
    perf_parser = subparsers.add_parser('performance', help='Show performance summary')
    perf_parser.add_argument('--days', type=int, default=30, help='Number of days to analyze')
    
    args = parser.parse_args()
    
    prioritizer = MiradorActionPrioritizer()
    
    if args.command == 'add':
        opportunity_data = {
            'title': args.title,
            'description': args.description or '',
            'estimated_time_minutes': args.time,
            'estimated_cost': args.cost,
            'potential_savings': args.savings,
            'potential_income': args.income,
            'deadline_date': args.deadline
        }
        
        opp_id, scores = prioritizer.add_opportunity(opportunity_data)
        print(f"✅ Added opportunity #{opp_id}: {args.title}")
        print(f"🎯 Priority Score: {scores['total_priority_score']:.1f}/10")
        
    elif args.command == 'top':
        opportunities = prioritizer.get_top_opportunities(limit=args.limit)
        print(f"🏆 Top {len(opportunities)} Opportunities:")
        print("=" * 60)
        
        for i, opp in enumerate(opportunities, 1):
            title, score, est_time = opp[1], opp[3], opp[4]
            print(f"{i}. {title} (Score: {score:.1f}, Time: {est_time}min)")
        
    elif args.command == 'select':
        opportunity = prioritizer.select_daily_action(args.opportunity_id)
        if opportunity:
            print(f"🎯 Selected daily action: {opportunity[0]}")
            print(f"📋 Description: {opportunity[1]}")
            print(f"⏱️ Estimated time: {opportunity[2]} minutes")
        else:
            print("❌ Opportunity not found")
    
    elif args.command == 'start':
        prioritizer.start_action_execution(args.opportunity_id, args.energy, args.mood)
        print(f"🚀 Started action execution for opportunity #{args.opportunity_id}")
    
    elif args.command == 'complete':
        prioritizer.complete_action(
            args.opportunity_id, args.completion, args.duration,
            satisfaction=args.satisfaction, actual_savings=args.savings,
            actual_income=args.income, actual_cost=args.cost,
            outcome_notes=args.notes or ""
        )
        print(f"✅ Completed action for opportunity #{args.opportunity_id}")
        print(f"📊 Completion: {args.completion}%")
        if args.savings or args.income:
            net_value = args.savings + args.income - args.cost
            print(f"💰 Net Value Realized: ${net_value:,.2f}")
    
    elif args.command == 'report':
        report = prioritizer.generate_daily_priority_report()
        print(report)
    
    elif args.command == 'performance':
        summary = prioritizer.get_performance_summary(args.days)
        if summary:
            print(f"📊 Performance Summary (Last {args.days} days)")
            print("=" * 50)
            print(f"Actions Completed: {summary['total_actions_completed']}")
            print(f"Average Satisfaction: {summary['average_satisfaction']:.1f}/10")
            print(f"Time Invested: {summary['total_time_invested_hours']:.1f} hours")
            print(f"Net Financial Impact: ${summary['net_financial_impact']:,.2f}")
            print(f"Value per Hour: ${summary['value_per_hour']:,.2f}")
            print(f"Actions per Week: {summary['actions_per_week']:.1f}")
        else:
            print("📊 No completed actions found in the specified period")
    
    else:
        parser.print_help()

if __name__ == "__main__":
    main()

