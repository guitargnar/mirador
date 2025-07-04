#!/usr/bin/env python3
"""
Humana Advocates Program Integration for Mirador
Tracks pain points, collects evidence, and drives internal change
"""

import os
import json
import sqlite3
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Tuple
import hashlib
from collections import defaultdict
import re

class AdvocatesProgram:
    """
    Core module for Humana Advocates Program functionality
    Transforms Mirador from a productivity tool into a change catalyst
    """
    
    def __init__(self, db_path: str = None):
        if db_path is None:
            db_path = os.path.expanduser("~/.mirador/advocates.db")
            
        os.makedirs(os.path.dirname(db_path), exist_ok=True)
        self.db_path = db_path
        self.conn = sqlite3.connect(db_path)
        self.conn.row_factory = sqlite3.Row
        self._init_database()
        
        # Load pain point categories from documentation
        self.pain_categories = self._load_pain_categories()
        
    def _init_database(self):
        """Initialize database for tracking advocacy data"""
        self.conn.executescript("""
            -- Pain points reported by associates
            CREATE TABLE IF NOT EXISTS pain_points (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                category TEXT NOT NULL,
                description TEXT NOT NULL,
                impact_level TEXT CHECK (impact_level IN ('low', 'medium', 'high', 'critical')),
                frequency TEXT CHECK (frequency IN ('rare', 'occasional', 'frequent', 'constant')),
                department TEXT,
                reported_by TEXT,
                anonymous BOOLEAN DEFAULT 1,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                status TEXT DEFAULT 'reported',
                upvotes INTEGER DEFAULT 0
            );
            
            -- Evidence of pain points (metrics, examples, etc)
            CREATE TABLE IF NOT EXISTS evidence (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                pain_point_id INTEGER NOT NULL,
                evidence_type TEXT NOT NULL,
                description TEXT NOT NULL,
                data TEXT,
                file_path TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY(pain_point_id) REFERENCES pain_points(id)
            );
            
            -- Solutions built by associates
            CREATE TABLE IF NOT EXISTS solutions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                pain_point_id INTEGER,
                title TEXT NOT NULL,
                description TEXT NOT NULL,
                implementation TEXT,
                time_saved_hours REAL,
                cost_saved REAL,
                adoption_count INTEGER DEFAULT 0,
                creator TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                status TEXT DEFAULT 'proposed',
                FOREIGN KEY(pain_point_id) REFERENCES pain_points(id)
            );
            
            -- Success stories for leadership
            CREATE TABLE IF NOT EXISTS success_stories (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                solution_id INTEGER NOT NULL,
                title TEXT NOT NULL,
                narrative TEXT NOT NULL,
                metrics TEXT,
                stakeholders TEXT,
                lessons_learned TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                presented_to_leadership BOOLEAN DEFAULT 0,
                FOREIGN KEY(solution_id) REFERENCES solutions(id)
            );
            
            -- Change initiatives tracking
            CREATE TABLE IF NOT EXISTS change_initiatives (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT NOT NULL,
                description TEXT NOT NULL,
                pain_points_addressed TEXT,
                target_date DATE,
                status TEXT DEFAULT 'proposed',
                owner TEXT,
                executive_sponsor TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
            
            -- Anonymous feedback
            CREATE TABLE IF NOT EXISTS feedback (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                category TEXT NOT NULL,
                sentiment TEXT CHECK (sentiment IN ('positive', 'neutral', 'negative')),
                message TEXT NOT NULL,
                department TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                addressed BOOLEAN DEFAULT 0
            );
            
            -- Advocate activities
            CREATE TABLE IF NOT EXISTS advocate_activities (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                advocate_id TEXT NOT NULL,
                activity_type TEXT NOT NULL,
                description TEXT,
                impact_score INTEGER,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
            
            CREATE INDEX IF NOT EXISTS idx_pain_category ON pain_points(category);
            CREATE INDEX IF NOT EXISTS idx_pain_status ON pain_points(status);
            CREATE INDEX IF NOT EXISTS idx_solution_status ON solutions(status);
        """)
        self.conn.commit()
        
    def _load_pain_categories(self) -> Dict[str, List[str]]:
        """Load pain point categories from documentation"""
        return {
            "technology_access": [
                "Tool restrictions",
                "Mobile device limitations", 
                "Personal device requirements",
                "Software access issues"
            ],
            "communication": [
                "Diluted leadership messages",
                "Inconsistent manager communication",
                "Role clarity",
                "Information overload"
            ],
            "operational": [
                "Bureaucratic processes",
                "Agile theater",
                "Slow approvals",
                "Inefficient workflows"
            ],
            "culture": [
                "RIF anxiety",
                "Recognition gaps",
                "Survey authenticity concerns",
                "Top-down initiatives"
            ],
            "innovation": [
                "Restricted innovation",
                "Shadow IT necessity",
                "Lack of trust",
                "No innovation pathways"
            ]
        }
        
    def report_pain_point(self, description: str, category: str = None, 
                         impact: str = "medium", frequency: str = "frequent",
                         department: str = None, anonymous: bool = True) -> int:
        """Report a new pain point"""
        # Auto-categorize if not provided
        if not category:
            category = self._categorize_pain_point(description)
            
        cursor = self.conn.execute("""
            INSERT INTO pain_points 
            (category, description, impact_level, frequency, department, 
             reported_by, anonymous)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """, [
            category, description, impact, frequency, department,
            os.getenv('USER', 'anonymous') if not anonymous else 'anonymous',
            anonymous
        ])
        
        pain_point_id = cursor.lastrowid
        self.conn.commit()
        
        return pain_point_id
        
    def _categorize_pain_point(self, description: str) -> str:
        """Auto-categorize pain point based on keywords"""
        description_lower = description.lower()
        
        category_keywords = {
            "technology_access": ["tool", "software", "access", "mobile", "device", "restriction"],
            "communication": ["message", "communication", "clarity", "understand", "diluted"],
            "operational": ["process", "approval", "workflow", "bureaucratic", "slow"],
            "culture": ["rif", "anxiety", "recognition", "survey", "trust"],
            "innovation": ["innovate", "shadow it", "workaround", "restriction"]
        }
        
        scores = defaultdict(int)
        for category, keywords in category_keywords.items():
            for keyword in keywords:
                if keyword in description_lower:
                    scores[category] += 1
                    
        return max(scores, key=scores.get) if scores else "operational"
        
    def add_evidence(self, pain_point_id: int, evidence_type: str,
                    description: str, data: Dict = None, file_path: str = None) -> int:
        """Add evidence for a pain point"""
        cursor = self.conn.execute("""
            INSERT INTO evidence 
            (pain_point_id, evidence_type, description, data, file_path)
            VALUES (?, ?, ?, ?, ?)
        """, [
            pain_point_id, evidence_type, description,
            json.dumps(data) if data else None, file_path
        ])
        
        evidence_id = cursor.lastrowid
        self.conn.commit()
        
        return evidence_id
        
    def create_solution(self, title: str, description: str, 
                       pain_point_id: int = None, implementation: str = None,
                       time_saved: float = None, cost_saved: float = None) -> int:
        """Document a solution created by an associate"""
        cursor = self.conn.execute("""
            INSERT INTO solutions 
            (pain_point_id, title, description, implementation, 
             time_saved_hours, cost_saved, creator)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """, [
            pain_point_id, title, description, implementation,
            time_saved, cost_saved, os.getenv('USER', 'anonymous')
        ])
        
        solution_id = cursor.lastrowid
        self.conn.commit()
        
        # Mirador itself is a solution - add it as evidence
        if "mirador" in title.lower():
            self.add_evidence(
                pain_point_id or 0,
                "working_solution",
                f"Associate-built solution: {title}",
                data={
                    "time_saved_hours": time_saved,
                    "cost_saved": cost_saved,
                    "adoption_potential": "high"
                }
            )
            
        return solution_id
        
    def document_success_story(self, solution_id: int, title: str,
                             narrative: str, metrics: Dict = None,
                             stakeholders: List[str] = None,
                             lessons: str = None) -> int:
        """Create a success story for leadership presentation"""
        cursor = self.conn.execute("""
            INSERT INTO success_stories 
            (solution_id, title, narrative, metrics, stakeholders, lessons_learned)
            VALUES (?, ?, ?, ?, ?, ?)
        """, [
            solution_id, title, narrative,
            json.dumps(metrics) if metrics else None,
            json.dumps(stakeholders) if stakeholders else None,
            lessons
        ])
        
        story_id = cursor.lastrowid
        self.conn.commit()
        
        return story_id
        
    def track_advocate_activity(self, activity_type: str, description: str,
                              impact_score: int = None) -> int:
        """Track advocate program activities"""
        advocate_id = os.getenv('USER', 'anonymous')
        
        cursor = self.conn.execute("""
            INSERT INTO advocate_activities 
            (advocate_id, activity_type, description, impact_score)
            VALUES (?, ?, ?, ?)
        """, [advocate_id, activity_type, description, impact_score])
        
        self.conn.commit()
        return cursor.lastrowid
        
    def collect_anonymous_feedback(self, message: str, category: str = "general",
                                 sentiment: str = "neutral", 
                                 department: str = None) -> int:
        """Collect anonymous feedback safely"""
        cursor = self.conn.execute("""
            INSERT INTO feedback 
            (category, sentiment, message, department)
            VALUES (?, ?, ?, ?)
        """, [category, sentiment, message, department])
        
        self.conn.commit()
        return cursor.lastrowid
        
    def get_pain_point_summary(self, days: int = 30) -> Dict:
        """Get summary of pain points for reporting"""
        threshold = datetime.now() - timedelta(days=days)
        
        # Top pain points by category
        category_query = """
            SELECT category, COUNT(*) as count,
                   SUM(CASE WHEN impact_level IN ('high', 'critical') THEN 1 ELSE 0 END) as high_impact
            FROM pain_points
            WHERE created_at > ?
            GROUP BY category
            ORDER BY count DESC
        """
        
        categories = self.conn.execute(category_query, [threshold]).fetchall()
        
        # Pain points with solutions
        solutions_query = """
            SELECT COUNT(DISTINCT p.id) as addressed
            FROM pain_points p
            JOIN solutions s ON p.id = s.pain_point_id
            WHERE p.created_at > ?
        """
        
        addressed = self.conn.execute(solutions_query, [threshold]).fetchone()
        
        # Evidence collected
        evidence_query = """
            SELECT COUNT(*) as evidence_count
            FROM evidence e
            JOIN pain_points p ON e.pain_point_id = p.id
            WHERE p.created_at > ?
        """
        
        evidence = self.conn.execute(evidence_query, [threshold]).fetchone()
        
        return {
            "period_days": days,
            "total_pain_points": sum(c['count'] for c in categories),
            "categories": [dict(c) for c in categories],
            "pain_points_addressed": addressed['addressed'] if addressed else 0,
            "evidence_collected": evidence['evidence_count'] if evidence else 0,
            "top_category": categories[0]['category'] if categories else None
        }
        
    def get_solution_metrics(self) -> Dict:
        """Get metrics on associate-built solutions"""
        query = """
            SELECT 
                COUNT(*) as total_solutions,
                SUM(time_saved_hours) as total_hours_saved,
                SUM(cost_saved) as total_cost_saved,
                SUM(adoption_count) as total_adoptions,
                AVG(time_saved_hours) as avg_hours_per_solution
            FROM solutions
            WHERE status != 'rejected'
        """
        
        result = self.conn.execute(query).fetchone()
        
        return dict(result) if result else {}
        
    def generate_advocate_report(self, advocate_id: str = None) -> Dict:
        """Generate report on advocate activities"""
        if not advocate_id:
            advocate_id = os.getenv('USER', 'anonymous')
            
        # Get advocate's activities
        activities = self.conn.execute("""
            SELECT activity_type, COUNT(*) as count, SUM(impact_score) as total_impact
            FROM advocate_activities
            WHERE advocate_id = ?
            GROUP BY activity_type
        """, [advocate_id]).fetchall()
        
        # Get pain points reported
        pain_points = self.conn.execute("""
            SELECT COUNT(*) as reported
            FROM pain_points
            WHERE reported_by = ?
        """, [advocate_id]).fetchone()
        
        # Get solutions created
        solutions = self.conn.execute("""
            SELECT COUNT(*) as created, SUM(time_saved_hours) as hours_saved
            FROM solutions
            WHERE creator = ?
        """, [advocate_id]).fetchone()
        
        return {
            "advocate_id": advocate_id,
            "activities": [dict(a) for a in activities],
            "pain_points_reported": pain_points['reported'] if pain_points else 0,
            "solutions_created": solutions['created'] if solutions else 0,
            "total_hours_saved": solutions['hours_saved'] if solutions else 0,
            "impact_score": sum(a['total_impact'] or 0 for a in activities)
        }
        
    def search_similar_pain_points(self, description: str, limit: int = 5) -> List[Dict]:
        """Find similar pain points already reported"""
        keywords = set(description.lower().split())
        
        all_pain_points = self.conn.execute("""
            SELECT id, description, category, impact_level, upvotes
            FROM pain_points
            ORDER BY created_at DESC
            LIMIT 100
        """).fetchall()
        
        # Simple keyword matching
        scored_points = []
        for point in all_pain_points:
            point_keywords = set(point['description'].lower().split())
            overlap = len(keywords & point_keywords)
            if overlap > 0:
                scored_points.append((overlap, dict(point)))
                
        # Sort by relevance
        scored_points.sort(key=lambda x: x[0], reverse=True)
        
        return [point for _, point in scored_points[:limit]]
        
    def upvote_pain_point(self, pain_point_id: int):
        """Upvote a pain point to show it affects multiple people"""
        self.conn.execute("""
            UPDATE pain_points 
            SET upvotes = upvotes + 1
            WHERE id = ?
        """, [pain_point_id])
        self.conn.commit()
        
        # Track the activity
        self.track_advocate_activity(
            "upvote", 
            f"Upvoted pain point {pain_point_id}",
            impact_score=1
        )
        
    def create_change_initiative(self, title: str, description: str,
                               pain_point_ids: List[int], target_date: str = None,
                               owner: str = None, sponsor: str = None) -> int:
        """Create a formal change initiative"""
        cursor = self.conn.execute("""
            INSERT INTO change_initiatives
            (title, description, pain_points_addressed, target_date, 
             owner, executive_sponsor)
            VALUES (?, ?, ?, ?, ?, ?)
        """, [
            title, description, json.dumps(pain_point_ids),
            target_date, owner, sponsor
        ])
        
        initiative_id = cursor.lastrowid
        self.conn.commit()
        
        # Update pain points status
        for pain_id in pain_point_ids:
            self.conn.execute("""
                UPDATE pain_points 
                SET status = 'in_progress'
                WHERE id = ?
            """, [pain_id])
            
        self.conn.commit()
        return initiative_id
        
    def export_for_leadership(self, format: str = "markdown") -> str:
        """Export data in leadership-friendly format"""
        summary = self.get_pain_point_summary()
        solutions = self.get_solution_metrics()
        
        if format == "markdown":
            report = f"""# Humana Advocates Program Report
Generated: {datetime.now().strftime('%Y-%m-%d')}

## Executive Summary

- **Pain Points Identified**: {summary['total_pain_points']}
- **Solutions Created**: {solutions.get('total_solutions', 0)}
- **Hours Saved**: {solutions.get('total_hours_saved', 0):.1f}
- **Cost Saved**: ${solutions.get('total_cost_saved', 0):,.2f}

## Top Pain Point Categories

"""
            for cat in summary['categories']:
                report += f"- **{cat['category'].replace('_', ' ').title()}**: {cat['count']} reports"
                if cat['high_impact'] > 0:
                    report += f" ({cat['high_impact']} high impact)"
                report += "\n"
                
            # Add evidence section
            report += f"\n## Evidence Base\n\n"
            report += f"- Data points collected: {summary['evidence_collected']}\n"
            report += f"- Pain points with solutions: {summary['pain_points_addressed']}\n"
            
            # Add Mirador as example
            report += f"\n## Innovation Example: Mirador\n\n"
            report += "One associate built Mirador to address productivity restrictions:\n"
            report += "- Built with $0 budget on personal time\n"
            report += "- Saves 30+ hours/week\n" 
            report += "- Zero security incidents\n"
            report += "- Proves associates can innovate with trust\n"
            
            return report
            
        elif format == "json":
            return json.dumps({
                "summary": summary,
                "solutions": solutions,
                "generated_at": datetime.now().isoformat()
            }, indent=2)
            
        else:
            raise ValueError(f"Unsupported format: {format}")


# CLI interface for advocates
if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Humana Advocates Program Tool")
    subparsers = parser.add_subparsers(dest='command', help='Commands')
    
    # Report pain point
    report_parser = subparsers.add_parser('report', help='Report a pain point')
    report_parser.add_argument('description', help='Describe the pain point')
    report_parser.add_argument('--category', choices=[
        'technology_access', 'communication', 'operational', 'culture', 'innovation'
    ])
    report_parser.add_argument('--impact', choices=['low', 'medium', 'high', 'critical'],
                              default='medium')
    report_parser.add_argument('--frequency', choices=['rare', 'occasional', 'frequent', 'constant'],
                              default='frequent')
    
    # Add evidence
    evidence_parser = subparsers.add_parser('evidence', help='Add evidence')
    evidence_parser.add_argument('pain_id', type=int, help='Pain point ID')
    evidence_parser.add_argument('type', help='Evidence type')
    evidence_parser.add_argument('description', help='Evidence description')
    
    # Create solution
    solution_parser = subparsers.add_parser('solution', help='Document a solution')
    solution_parser.add_argument('title', help='Solution title')
    solution_parser.add_argument('description', help='Solution description')
    solution_parser.add_argument('--pain-id', type=int, help='Related pain point')
    solution_parser.add_argument('--hours-saved', type=float, help='Hours saved')
    
    # View summary
    summary_parser = subparsers.add_parser('summary', help='View summary')
    summary_parser.add_argument('--days', type=int, default=30)
    
    # Export report
    export_parser = subparsers.add_parser('export', help='Export report')
    export_parser.add_argument('--format', choices=['markdown', 'json'], default='markdown')
    
    args = parser.parse_args()
    
    advocates = AdvocatesProgram()
    
    if args.command == 'report':
        pain_id = advocates.report_pain_point(
            args.description,
            category=args.category,
            impact=args.impact,
            frequency=args.frequency
        )
        print(f"✅ Pain point reported with ID: {pain_id}")
        
        # Check for similar
        similar = advocates.search_similar_pain_points(args.description, limit=3)
        if similar:
            print("\n📋 Similar pain points already reported:")
            for point in similar:
                print(f"  - [{point['id']}] {point['description'][:60]}...")
                print(f"    Category: {point['category']}, Upvotes: {point['upvotes']}")
                
    elif args.command == 'evidence':
        evidence_id = advocates.add_evidence(
            args.pain_id,
            args.type,
            args.description
        )
        print(f"✅ Evidence added with ID: {evidence_id}")
        
    elif args.command == 'solution':
        solution_id = advocates.create_solution(
            args.title,
            args.description,
            pain_point_id=args.pain_id,
            time_saved=args.hours_saved
        )
        print(f"✅ Solution documented with ID: {solution_id}")
        
    elif args.command == 'summary':
        summary = advocates.get_pain_point_summary(days=args.days)
        print(f"\n📊 Advocates Program Summary (Last {args.days} Days)\n")
        print(f"Total Pain Points: {summary['total_pain_points']}")
        print(f"Points Addressed: {summary['pain_points_addressed']}")
        print(f"Evidence Collected: {summary['evidence_collected']}")
        
        if summary['categories']:
            print("\nTop Categories:")
            for cat in summary['categories'][:5]:
                print(f"  - {cat['category']}: {cat['count']} reports")
                
    elif args.command == 'export':
        report = advocates.export_for_leadership(format=args.format)
        
        filename = f"advocates_report_{datetime.now().strftime('%Y%m%d')}.{args.format}"
        with open(filename, 'w') as f:
            f.write(report)
            
        print(f"✅ Report exported to {filename}")