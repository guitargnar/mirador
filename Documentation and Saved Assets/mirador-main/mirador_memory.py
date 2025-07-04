"""
Mirador Memory Layer - Transform stateless analysis into learning system
Preserves existing functionality while adding persistence and learning
"""

import sqlite3
import json
import os
from datetime import datetime
from pathlib import Path
import hashlib

class MiradorMemory:
    def __init__(self, db_path=None):
        """Initialize memory system with SQLite backend"""
        if db_path is None:
            db_path = Path.home() / "ai_framework_git" / "mirador_memory.db"
        
        self.db_path = db_path
        self.conn = sqlite3.connect(str(db_path))
        self.conn.row_factory = sqlite3.Row
        self.init_tables()
    
    def init_tables(self):
        """Create tables for tracking analyses, outcomes, and patterns"""
        cursor = self.conn.cursor()
        
        # User context and preferences
        cursor.execute('''
        CREATE TABLE IF NOT EXISTS user_context (
            id INTEGER PRIMARY KEY,
            key TEXT UNIQUE NOT NULL,
            value TEXT NOT NULL,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )''')
        
        # Analysis history with quality tracking
        cursor.execute('''
        CREATE TABLE IF NOT EXISTS analysis_history (
            id INTEGER PRIMARY KEY,
            query TEXT NOT NULL,
            query_hash TEXT NOT NULL,
            models_used TEXT NOT NULL,
            output_path TEXT,
            execution_time REAL,
            quality_score REAL,
            user_rating INTEGER,
            was_actionable BOOLEAN,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )''')
        
        # Opportunity tracking with outcomes
        cursor.execute('''
        CREATE TABLE IF NOT EXISTS opportunities (
            id INTEGER PRIMARY KEY,
            opportunity_type TEXT NOT NULL,
            description TEXT NOT NULL,
            initial_score REAL,
            viability_assessment TEXT,
            implementation_status TEXT DEFAULT 'evaluated',
            actual_outcome TEXT,
            roi_actual REAL,
            lessons_learned TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )''')
        
        # Model performance tracking
        cursor.execute('''
        CREATE TABLE IF NOT EXISTS model_performance (
            id INTEGER PRIMARY KEY,
            model_name TEXT NOT NULL,
            query_type TEXT,
            response_quality REAL,
            execution_time REAL,
            hallucination_detected BOOLEAN DEFAULT FALSE,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )''')
        
        # Pattern recognition
        cursor.execute('''
        CREATE TABLE IF NOT EXISTS success_patterns (
            id INTEGER PRIMARY KEY,
            pattern_type TEXT NOT NULL,
            pattern_description TEXT,
            success_rate REAL,
            sample_queries TEXT,
            recommended_chain TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )''')
        
        self.conn.commit()
    
    def log_analysis(self, query, models_used, output_path, execution_time, initial_quality=None):
        """Log an analysis for future reference and pattern learning"""
        query_hash = hashlib.md5(query.encode()).hexdigest()
        
        cursor = self.conn.cursor()
        cursor.execute('''
        INSERT INTO analysis_history 
        (query, query_hash, models_used, output_path, execution_time, quality_score)
        VALUES (?, ?, ?, ?, ?, ?)
        ''', (query, query_hash, json.dumps(models_used), output_path, execution_time, initial_quality))
        
        self.conn.commit()
        return cursor.lastrowid
    
    def get_similar_analyses(self, query, threshold=0.7):
        """Find similar past analyses to inform current query"""
        cursor = self.conn.cursor()
        results = cursor.execute('''
        SELECT * FROM analysis_history 
        WHERE user_rating >= 4 OR quality_score >= ?
        ORDER BY created_at DESC
        LIMIT 10
        ''', (threshold,)).fetchall()
        
        return [dict(row) for row in results]
    
    def track_opportunity(self, opportunity_type, description, initial_score, viability):
        """Track opportunities for outcome measurement"""
        cursor = self.conn.cursor()
        cursor.execute('''
        INSERT INTO opportunities 
        (opportunity_type, description, initial_score, viability_assessment)
        VALUES (?, ?, ?, ?)
        ''', (opportunity_type, description, initial_score, json.dumps(viability)))
        
        self.conn.commit()
        return cursor.lastrowid
    
    def update_opportunity_outcome(self, opportunity_id, status, outcome, roi=None, lessons=None):
        """Update opportunity with real-world results"""
        cursor = self.conn.cursor()
        cursor.execute('''
        UPDATE opportunities 
        SET implementation_status = ?, actual_outcome = ?, roi_actual = ?, 
            lessons_learned = ?, updated_at = CURRENT_TIMESTAMP
        WHERE id = ?
        ''', (status, outcome, roi, lessons, opportunity_id))
        
        self.conn.commit()
    
    def log_model_performance(self, model_name, query_type, quality, exec_time, hallucinated=False):
        """Track individual model performance for optimization"""
        cursor = self.conn.cursor()
        cursor.execute('''
        INSERT INTO model_performance 
        (model_name, query_type, response_quality, execution_time, hallucination_detected)
        VALUES (?, ?, ?, ?, ?)
        ''', (model_name, query_type, quality, exec_time, hallucinated))
        
        self.conn.commit()
    
    def get_model_stats(self, model_name):
        """Get performance statistics for a model"""
        cursor = self.conn.cursor()
        stats = cursor.execute('''
        SELECT 
            COUNT(*) as total_uses,
            AVG(response_quality) as avg_quality,
            AVG(execution_time) as avg_time,
            SUM(CASE WHEN hallucination_detected THEN 1 ELSE 0 END) as hallucinations,
            MAX(created_at) as last_used
        FROM model_performance
        WHERE model_name = ?
        ''', (model_name,)).fetchone()
        
        return dict(stats)
    
    def identify_success_patterns(self):
        """Analyze history to identify successful query patterns"""
        cursor = self.conn.cursor()
        
        successful = cursor.execute('''
        SELECT query, models_used, execution_time, quality_score
        FROM analysis_history
        WHERE user_rating >= 4 OR quality_score >= 0.8
        ''').fetchall()
        
        patterns = {}
        for row in successful:
            models = json.loads(row['models_used'])
            chain = ' -> '.join(models)
            if chain not in patterns:
                patterns[chain] = {'count': 0, 'avg_time': 0, 'queries': []}
            patterns[chain]['count'] += 1
            patterns[chain]['avg_time'] += row['execution_time']
            patterns[chain]['queries'].append(row['query'][:50])
        
        for chain, data in patterns.items():
            if data['count'] >= 3:
                cursor.execute('''
                INSERT OR REPLACE INTO success_patterns
                (pattern_type, pattern_description, success_rate, sample_queries, recommended_chain)
                VALUES ('chain', ?, ?, ?, ?)
                ''', ('Successful chain pattern', 
                      data['count'] / len(successful),
                      json.dumps(data['queries'][:3]),
                      chain))
        
        self.conn.commit()
        return patterns
    
    def get_user_context(self, key=None):
        """Retrieve user context/preferences"""
        cursor = self.conn.cursor()
        if key:
            result = cursor.execute('SELECT value FROM user_context WHERE key = ?', (key,)).fetchone()
            return result['value'] if result else None
        else:
            results = cursor.execute('SELECT key, value FROM user_context').fetchall()
            return {row['key']: row['value'] for row in results}
    
    def set_user_context(self, key, value):
        """Store user context/preferences"""
        cursor = self.conn.cursor()
        cursor.execute('''
        INSERT OR REPLACE INTO user_context (key, value) VALUES (?, ?)
        ''', (key, str(value)))
        self.conn.commit()
    
    def generate_insights(self):
        """Generate insights from accumulated data"""
        insights = {
            'total_analyses': 0,
            'avg_execution_time': 0,
            'preferred_models': [],
            'success_patterns': [],
            'improvement_areas': []
        }
        
        cursor = self.conn.cursor()
        
        stats = cursor.execute('''
        SELECT COUNT(*) as total, AVG(execution_time) as avg_time
        FROM analysis_history
        ''').fetchone()
        
        insights['total_analyses'] = stats['total']
        insights['avg_execution_time'] = stats['avg_time']
        
        model_success = cursor.execute('''
        SELECT model_name, AVG(response_quality) as avg_quality, COUNT(*) as uses
        FROM model_performance
        GROUP BY model_name
        HAVING uses >= 5
        ORDER BY avg_quality DESC
        LIMIT 5
        ''').fetchall()
        
        insights['preferred_models'] = [dict(row) for row in model_success]
        
        patterns = cursor.execute('''
        SELECT pattern_description, success_rate, recommended_chain
        FROM success_patterns
        ORDER BY success_rate DESC
        LIMIT 5
        ''').fetchall()
        
        insights['success_patterns'] = [dict(row) for row in patterns]
        
        return insights
    
    def close(self):
        """Close database connection"""
        self.conn.close()

# Test the memory system
if __name__ == "__main__":
    memory = MiradorMemory()
    print("Mirador Memory Layer initialized successfully!")
    print(f"Database location: {memory.db_path}")
    memory.close()
