#!/usr/bin/env python3
"""
Metrics Tracking System for Mirador
Provides real measurement of efficiency gains, time saved, and error rates
"""

import time
import json
import sqlite3
from datetime import datetime, timedelta
from typing import Dict, Any, List, Optional
import os
import hashlib

class MetricsTracker:
    """Track and measure actual performance metrics for Mirador executions"""
    
    def __init__(self, db_path: str = None):
        if db_path is None:
            db_path = os.path.expanduser("~/.mirador/metrics.db")
        
        # Ensure directory exists
        os.makedirs(os.path.dirname(db_path), exist_ok=True)
        
        self.db_path = db_path
        self.conn = sqlite3.connect(db_path)
        self.conn.row_factory = sqlite3.Row
        self._create_tables()
        
    def _create_tables(self):
        """Create database tables for metrics storage"""
        self.conn.executescript("""
            CREATE TABLE IF NOT EXISTS executions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                session_id TEXT UNIQUE NOT NULL,
                start_time TIMESTAMP NOT NULL,
                end_time TIMESTAMP,
                duration_seconds REAL,
                prompt TEXT NOT NULL,
                prompt_hash TEXT NOT NULL,
                models_used TEXT NOT NULL,
                tokens_input INTEGER DEFAULT 0,
                tokens_output INTEGER DEFAULT 0,
                error_count INTEGER DEFAULT 0,
                success BOOLEAN DEFAULT 1,
                user_id TEXT,
                task_type TEXT,
                manual_time_estimate_hours REAL,
                actual_time_saved_hours REAL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
            
            CREATE INDEX IF NOT EXISTS idx_session_id ON executions(session_id);
            CREATE INDEX IF NOT EXISTS idx_prompt_hash ON executions(prompt_hash);
            CREATE INDEX IF NOT EXISTS idx_start_time ON executions(start_time);
            
            CREATE TABLE IF NOT EXISTS quality_metrics (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                execution_id INTEGER NOT NULL,
                accuracy_score REAL,
                completeness_score REAL,
                relevance_score REAL,
                grammar_score REAL,
                overall_quality REAL,
                error_details TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY(execution_id) REFERENCES executions(id)
            );
            
            CREATE TABLE IF NOT EXISTS user_feedback (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                execution_id INTEGER NOT NULL,
                rating INTEGER CHECK (rating >= 1 AND rating <= 5),
                feedback_text TEXT,
                time_saved_hours REAL,
                would_recommend BOOLEAN,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY(execution_id) REFERENCES executions(id)
            );
            
            CREATE TABLE IF NOT EXISTS error_logs (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                execution_id INTEGER NOT NULL,
                error_type TEXT NOT NULL,
                error_message TEXT NOT NULL,
                stack_trace TEXT,
                occurred_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY(execution_id) REFERENCES executions(id)
            );
        """)
        self.conn.commit()
        
    def start_execution(self, session_id: str, prompt: str, models: List[str], 
                       task_type: str = None, manual_estimate_hours: float = None) -> 'ExecutionTracker':
        """Start tracking a new execution"""
        return ExecutionTracker(self, session_id, prompt, models, task_type, manual_estimate_hours)
        
    def get_aggregate_metrics(self, days: int = 7, user_id: str = None) -> Dict[str, Any]:
        """Get aggregated metrics for reporting"""
        threshold = datetime.now() - timedelta(days=days)
        
        query = """
            SELECT 
                COUNT(*) as total_executions,
                SUM(CASE WHEN success THEN 1 ELSE 0 END) as successful_executions,
                AVG(duration_seconds) as avg_duration_seconds,
                SUM(duration_seconds) as total_duration_seconds,
                SUM(actual_time_saved_hours) as total_hours_saved,
                AVG(CASE WHEN manual_time_estimate_hours > 0 
                    THEN (manual_time_estimate_hours - duration_seconds/3600.0) / manual_time_estimate_hours * 100 
                    ELSE NULL END) as avg_efficiency_gain_percent,
                SUM(tokens_input + tokens_output) as total_tokens,
                COUNT(DISTINCT prompt_hash) as unique_prompts,
                COUNT(DISTINCT DATE(start_time)) as active_days
            FROM executions
            WHERE start_time > ?
        """
        
        params = [threshold]
        if user_id:
            query += " AND user_id = ?"
            params.append(user_id)
            
        cursor = self.conn.execute(query, params)
        result = dict(cursor.fetchone())
        
        # Calculate success rate
        if result['total_executions'] > 0:
            result['success_rate'] = (result['successful_executions'] / result['total_executions']) * 100
        else:
            result['success_rate'] = 0
            
        # Get quality metrics
        quality_query = """
            SELECT AVG(overall_quality) as avg_quality
            FROM quality_metrics qm
            JOIN executions e ON qm.execution_id = e.id
            WHERE e.start_time > ?
        """
        
        quality_result = self.conn.execute(quality_query, [threshold]).fetchone()
        result['avg_quality_score'] = quality_result['avg_quality'] or 0
        
        # Get feedback metrics
        feedback_query = """
            SELECT 
                AVG(rating) as avg_rating,
                AVG(time_saved_hours) as avg_reported_time_saved
            FROM user_feedback uf
            JOIN executions e ON uf.execution_id = e.id
            WHERE e.start_time > ?
        """
        
        feedback_result = self.conn.execute(feedback_query, [threshold]).fetchone()
        result['avg_user_rating'] = feedback_result['avg_rating'] or 0
        result['avg_reported_time_saved'] = feedback_result['avg_reported_time_saved'] or 0
        
        # Calculate ROI
        if result['total_hours_saved']:
            # Assuming $50/hour average cost
            result['estimated_cost_savings'] = result['total_hours_saved'] * 50
            result['roi_multiplier'] = result['estimated_cost_savings'] / 100  # Assuming $100 monthly cost
        else:
            result['estimated_cost_savings'] = 0
            result['roi_multiplier'] = 0
            
        return result
        
    def get_execution_history(self, limit: int = 10, offset: int = 0) -> List[Dict]:
        """Get recent execution history"""
        query = """
            SELECT 
                e.*,
                qm.overall_quality,
                uf.rating as user_rating
            FROM executions e
            LEFT JOIN quality_metrics qm ON e.id = qm.execution_id
            LEFT JOIN user_feedback uf ON e.id = uf.execution_id
            ORDER BY e.start_time DESC
            LIMIT ? OFFSET ?
        """
        
        cursor = self.conn.execute(query, [limit, offset])
        return [dict(row) for row in cursor.fetchall()]
        
    def find_similar_executions(self, prompt: str, limit: int = 5) -> List[Dict]:
        """Find similar past executions based on prompt"""
        prompt_hash = hashlib.md5(prompt.encode()).hexdigest()
        
        # First try exact match
        exact_query = """
            SELECT * FROM executions 
            WHERE prompt_hash = ? AND success = 1
            ORDER BY start_time DESC
            LIMIT ?
        """
        
        cursor = self.conn.execute(exact_query, [prompt_hash, limit])
        results = [dict(row) for row in cursor.fetchall()]
        
        if len(results) < limit:
            # Try fuzzy match on prompt text
            fuzzy_query = """
                SELECT * FROM executions
                WHERE success = 1 AND prompt LIKE ?
                ORDER BY start_time DESC
                LIMIT ?
            """
            
            # Extract key terms from prompt
            key_terms = prompt.lower().split()[:3]
            pattern = '%' + '%'.join(key_terms) + '%'
            
            cursor = self.conn.execute(fuzzy_query, [pattern, limit - len(results)])
            results.extend([dict(row) for row in cursor.fetchall()])
            
        return results
        
    def record_feedback(self, session_id: str, rating: int, feedback_text: str = None,
                       time_saved_hours: float = None, would_recommend: bool = None):
        """Record user feedback for an execution"""
        execution = self.conn.execute(
            "SELECT id FROM executions WHERE session_id = ?", 
            [session_id]
        ).fetchone()
        
        if not execution:
            raise ValueError(f"No execution found with session_id: {session_id}")
            
        self.conn.execute("""
            INSERT INTO user_feedback 
            (execution_id, rating, feedback_text, time_saved_hours, would_recommend)
            VALUES (?, ?, ?, ?, ?)
        """, [execution['id'], rating, feedback_text, time_saved_hours, would_recommend])
        
        self.conn.commit()
        
    def export_metrics(self, format: str = 'json', days: int = 30) -> str:
        """Export metrics in various formats"""
        metrics = self.get_aggregate_metrics(days)
        history = self.get_execution_history(limit=1000)
        
        data = {
            "summary": metrics,
            "executions": history,
            "generated_at": datetime.now().isoformat()
        }
        
        if format == 'json':
            return json.dumps(data, indent=2, default=str)
        elif format == 'csv':
            import csv
            import io
            
            output = io.StringIO()
            writer = csv.DictWriter(output, fieldnames=history[0].keys() if history else [])
            writer.writeheader()
            writer.writerows(history)
            
            return output.getvalue()
        else:
            raise ValueError(f"Unsupported format: {format}")


class ExecutionTracker:
    """Context manager for tracking individual executions"""
    
    def __init__(self, metrics: MetricsTracker, session_id: str, prompt: str, 
                 models: List[str], task_type: str = None, manual_estimate_hours: float = None):
        self.metrics = metrics
        self.session_id = session_id
        self.prompt = prompt
        self.prompt_hash = hashlib.md5(prompt.encode()).hexdigest()
        self.models = models
        self.task_type = task_type
        self.manual_estimate_hours = manual_estimate_hours
        self.start_time = None
        self.tokens_input = 0
        self.tokens_output = 0
        self.errors = []
        self.execution_id = None
        
    def __enter__(self):
        """Start tracking"""
        self.start_time = datetime.now()
        
        # Insert initial record
        cursor = self.metrics.conn.execute("""
            INSERT INTO executions 
            (session_id, start_time, prompt, prompt_hash, models_used, 
             task_type, manual_time_estimate_hours, user_id)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """, [
            self.session_id,
            self.start_time,
            self.prompt,
            self.prompt_hash,
            json.dumps(self.models),
            self.task_type,
            self.manual_estimate_hours,
            os.getenv('USER', 'unknown')
        ])
        
        self.execution_id = cursor.lastrowid
        self.metrics.conn.commit()
        
        return self
        
    def __exit__(self, exc_type, exc_val, exc_tb):
        """Complete tracking"""
        end_time = datetime.now()
        duration = (end_time - self.start_time).total_seconds()
        
        # Calculate time saved
        time_saved = None
        if self.manual_estimate_hours:
            time_saved = self.manual_estimate_hours - (duration / 3600.0)
            
        # Update execution record
        self.metrics.conn.execute("""
            UPDATE executions
            SET end_time = ?, 
                duration_seconds = ?, 
                tokens_input = ?,
                tokens_output = ?,
                error_count = ?,
                success = ?,
                actual_time_saved_hours = ?
            WHERE id = ?
        """, [
            end_time,
            duration,
            self.tokens_input,
            self.tokens_output,
            len(self.errors),
            exc_type is None,
            time_saved,
            self.execution_id
        ])
        
        # Log any errors
        for error in self.errors:
            self.metrics.conn.execute("""
                INSERT INTO error_logs (execution_id, error_type, error_message, stack_trace)
                VALUES (?, ?, ?, ?)
            """, [self.execution_id, error['type'], error['message'], error.get('stack_trace')])
            
        self.metrics.conn.commit()
        
        # Don't suppress exceptions
        return False
        
    def log_tokens(self, input_tokens: int = 0, output_tokens: int = 0):
        """Log token usage"""
        self.tokens_input += input_tokens
        self.tokens_output += output_tokens
        
    def log_error(self, error_type: str, message: str, stack_trace: str = None):
        """Log an error"""
        self.errors.append({
            'type': error_type,
            'message': message,
            'stack_trace': stack_trace
        })
        
    def log_quality_metrics(self, quality_scores: Dict[str, float]):
        """Log quality metrics for this execution"""
        self.metrics.conn.execute("""
            INSERT INTO quality_metrics
            (execution_id, accuracy_score, completeness_score, relevance_score, 
             grammar_score, overall_quality)
            VALUES (?, ?, ?, ?, ?, ?)
        """, [
            self.execution_id,
            quality_scores.get('accuracy_score'),
            quality_scores.get('completeness_score'),
            quality_scores.get('relevance_score'),
            quality_scores.get('grammar_score'),
            quality_scores.get('overall_quality')
        ])
        self.metrics.conn.commit()


# CLI interface for metrics
if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Mirador Metrics CLI")
    parser.add_argument('command', choices=['summary', 'history', 'export'],
                       help='Command to execute')
    parser.add_argument('--days', type=int, default=7,
                       help='Number of days to analyze')
    parser.add_argument('--format', choices=['json', 'csv'], default='json',
                       help='Export format')
    
    args = parser.parse_args()
    
    tracker = MetricsTracker()
    
    if args.command == 'summary':
        metrics = tracker.get_aggregate_metrics(days=args.days)
        print(f"\n=== Mirador Metrics Summary (Last {args.days} Days) ===\n")
        print(f"Total Executions: {metrics['total_executions']}")
        print(f"Success Rate: {metrics['success_rate']:.1f}%")
        print(f"Average Duration: {metrics['avg_duration_seconds']:.1f} seconds")
        print(f"Total Hours Saved: {metrics['total_hours_saved']:.1f}")
        print(f"Efficiency Gain: {metrics['avg_efficiency_gain_percent']:.1f}%")
        print(f"Average Quality Score: {metrics['avg_quality_score']:.1f}/100")
        print(f"User Rating: {metrics['avg_user_rating']:.1f}/5.0")
        print(f"Estimated Cost Savings: ${metrics['estimated_cost_savings']:,.2f}")
        print(f"ROI Multiplier: {metrics['roi_multiplier']:.1f}x")
        
    elif args.command == 'history':
        history = tracker.get_execution_history(limit=10)
        print("\n=== Recent Execution History ===\n")
        for exec in history:
            print(f"Session: {exec['session_id']}")
            print(f"  Time: {exec['start_time']}")
            print(f"  Duration: {exec['duration_seconds']:.1f}s")
            print(f"  Success: {'Yes' if exec['success'] else 'No'}")
            print(f"  Quality: {exec['overall_quality'] or 'N/A'}")
            print(f"  Rating: {exec['user_rating'] or 'N/A'}")
            print()
            
    elif args.command == 'export':
        data = tracker.export_metrics(format=args.format, days=args.days)
        print(data)