#!/usr/bin/env python3
"""
Context Management System for Mirador
Handles intelligent caching and retrieval of successful patterns
"""

import json
import os
import sqlite3
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Any
import hashlib
import re

class ContextManager:
    """Manages context caching and pattern extraction for Mirador"""
    
    def __init__(self, cache_dir: str = None):
        if cache_dir is None:
            cache_dir = os.path.expanduser("~/.mirador/context_cache")
        
        self.cache_dir = cache_dir
        self.db_path = os.path.join(os.path.dirname(cache_dir), "context.db")
        os.makedirs(cache_dir, exist_ok=True)
        os.makedirs(os.path.dirname(self.db_path), exist_ok=True)
        
        self._init_database()
    
    def _init_database(self):
        """Initialize context database"""
        conn = sqlite3.connect(self.db_path)
        conn.execute('''
            CREATE TABLE IF NOT EXISTS context_cache (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                session_id TEXT NOT NULL,
                chain_type TEXT NOT NULL,
                prompt_hash TEXT NOT NULL,
                prompt TEXT NOT NULL,
                response TEXT NOT NULL,
                rating INTEGER DEFAULT 0,
                success_patterns TEXT,
                time_allocations TEXT,
                constraint_data TEXT,
                format_used TEXT DEFAULT 'detailed',
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                last_accessed TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')
        
        conn.execute('''
            CREATE INDEX IF NOT EXISTS idx_chain_type ON context_cache(chain_type);
        ''')
        conn.execute('''
            CREATE INDEX IF NOT EXISTS idx_prompt_hash ON context_cache(prompt_hash);
        ''')
        conn.execute('''
            CREATE INDEX IF NOT EXISTS idx_rating ON context_cache(rating);
        ''')
        
        conn.commit()
        conn.close()
    
    def _extract_patterns(self, response: str) -> List[str]:
        """Extract successful patterns from response text"""
        patterns = []
        
        # Time allocation patterns
        time_patterns = re.findall(r'(\d+(?:\.\d+)?)\s*hours?\s+(?:for|on|to)\s+([^,\n.]+)', response, re.IGNORECASE)
        for time, activity in time_patterns:
            patterns.append(f"time_allocation:{activity.strip()}:{time}")
        
        # Sequential step patterns
        step_patterns = re.findall(r'(?:step\s+\d+|first|then|next|finally)[:\s]+([^.\n]+)', response, re.IGNORECASE)
        for step in step_patterns[:5]:  # Limit to first 5 steps
            clean_step = re.sub(r'[^\w\s]', ' ', step.strip())
            if len(clean_step) > 10:
                patterns.append(f"step_pattern:{clean_step[:50]}")
        
        # Constraint mentions
        constraints = re.findall(r'(?:given|considering|account for|constraint)[^.]*\$?(\d+(?:,\d+)?)[^.]*', response, re.IGNORECASE)
        for constraint in constraints:
            patterns.append(f"financial_constraint:{constraint}")
        
        # Relationship mentions
        relationships = re.findall(r'(sage|katie|relationship|family|work)[^.]{0,30}', response, re.IGNORECASE)
        for rel in relationships[:3]:
            patterns.append(f"relationship_context:{rel.strip()[:30]}")
        
        return patterns[:10]  # Limit total patterns
    
    def _extract_time_allocations(self, response: str) -> Dict[str, float]:
        """Extract time allocations from response"""
        allocations = {}
        
        # Look for time patterns like "2 hours for X" or "allocate 1.5 hours to Y"
        patterns = [
            r'(\d+(?:\.\d+)?)\s*hours?\s+(?:for|on|to)\s+([^,\n.]+)',
            r'allocate\s+(\d+(?:\.\d+)?)\s*hours?\s+(?:for|to)\s+([^,\n.]+)',
            r'spend\s+(\d+(?:\.\d+)?)\s*hours?\s+(?:on|with)\s+([^,\n.]+)'
        ]
        
        for pattern in patterns:
            matches = re.findall(pattern, response, re.IGNORECASE)
            for time_str, activity in matches:
                try:
                    time_val = float(time_str)
                    activity_clean = re.sub(r'[^\w\s]', ' ', activity.strip())[:30]
                    allocations[activity_clean] = time_val
                except ValueError:
                    continue
        
        return allocations
    
    def _extract_constraints(self, response: str) -> Dict[str, Any]:
        """Extract constraint information from response"""
        constraints = {
            "financial": [],
            "time_limits": [],
            "energy_factors": [],
            "relationship_factors": []
        }
        
        # Financial constraints
        financial_matches = re.findall(r'\$?(\d+(?:,\d+)?(?:\.\d+)?)', response)
        for match in financial_matches[:3]:
            try:
                amount = float(match.replace(',', ''))
                if 1000 <= amount <= 100000:  # Reasonable range
                    constraints["financial"].append(amount)
            except ValueError:
                continue
        
        # Time constraints
        if "24 hours" in response or "finite" in response:
            constraints["time_limits"].append("daily_limit_acknowledged")
        
        # Energy factors
        energy_words = ["energy", "tired", "overwhelm", "capacity", "bandwidth"]
        for word in energy_words:
            if word in response.lower():
                constraints["energy_factors"].append(word)
        
        # Relationship factors
        relationships = ["sage", "katie", "family", "work"]
        for rel in relationships:
            if rel in response.lower():
                constraints["relationship_factors"].append(rel)
        
        return constraints
    
    def cache_session(self, session_id: str, chain_type: str, prompt: str, 
                     response: str, rating: int = 0, format_used: str = "detailed"):
        """Cache a session with extracted patterns"""
        prompt_hash = hashlib.md5(prompt.encode()).hexdigest()
        patterns = self._extract_patterns(response)
        time_allocations = self._extract_time_allocations(response)
        constraints = self._extract_constraints(response)
        
        conn = sqlite3.connect(self.db_path)
        conn.execute('''
            INSERT OR REPLACE INTO context_cache 
            (session_id, chain_type, prompt_hash, prompt, response, rating, 
             success_patterns, time_allocations, constraint_data, format_used)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            session_id, chain_type, prompt_hash, prompt, response, rating,
            json.dumps(patterns), json.dumps(time_allocations), 
            json.dumps(constraints), format_used
        ))
        conn.commit()
        conn.close()
        
        # Also save to file for quick access
        cache_file = os.path.join(self.cache_dir, f"{chain_type}_recent.json")
        cache_data = {
            "session_id": session_id,
            "timestamp": datetime.now().isoformat(),
            "rating": rating,
            "patterns": patterns,
            "time_allocations": time_allocations,
            "constraints": constraints,
            "format_used": format_used
        }
        
        with open(cache_file, 'w') as f:
            json.dump(cache_data, f, indent=2)
    
    def get_relevant_context(self, chain_type: str, prompt: str, 
                            rating_threshold: int = 3) -> Dict[str, Any]:
        """Get relevant context for a new prompt"""
        prompt_hash = hashlib.md5(prompt.encode()).hexdigest()
        
        conn = sqlite3.connect(self.db_path)
        conn.row_factory = sqlite3.Row
        
        # First, check for exact prompt matches
        cursor = conn.execute('''
            SELECT * FROM context_cache 
            WHERE prompt_hash = ? AND rating >= ?
            ORDER BY created_at DESC LIMIT 1
        ''', (prompt_hash, rating_threshold))
        
        exact_match = cursor.fetchone()
        if exact_match:
            return self._format_context_result(exact_match)
        
        # Then look for similar patterns in the same chain type
        cursor = conn.execute('''
            SELECT * FROM context_cache 
            WHERE chain_type = ? AND rating >= ?
            ORDER BY rating DESC, created_at DESC LIMIT 5
        ''', (chain_type, rating_threshold))
        
        similar_sessions = cursor.fetchall()
        conn.close()
        
        if not similar_sessions:
            return {"has_context": False}
        
        # Aggregate patterns from similar high-rated sessions
        all_patterns = []
        all_time_allocations = {}
        common_constraints = {"financial": [], "time_limits": [], "energy_factors": [], "relationship_factors": []}
        
        for session in similar_sessions:
            if session['success_patterns']:
                patterns = json.loads(session['success_patterns'])
                all_patterns.extend(patterns)
            
            if session['time_allocations']:
                allocations = json.loads(session['time_allocations'])
                all_time_allocations.update(allocations)
            
            if session['constraint_data']:
                constraints = json.loads(session['constraint_data'])
                for key in common_constraints:
                    if key in constraints:
                        common_constraints[key].extend(constraints[key])
        
        return {
            "has_context": True,
            "similar_sessions": len(similar_sessions),
            "common_patterns": list(set(all_patterns))[:10],
            "typical_time_allocations": all_time_allocations,
            "common_constraints": common_constraints,
            "avg_rating": sum(s['rating'] for s in similar_sessions) / len(similar_sessions)
        }
    
    def _format_context_result(self, session_row) -> Dict[str, Any]:
        """Format a database row into context result"""
        return {
            "has_context": True,
            "exact_match": True,
            "session_id": session_row['session_id'],
            "rating": session_row['rating'],
            "patterns": json.loads(session_row['success_patterns'] or '[]'),
            "time_allocations": json.loads(session_row['time_allocations'] or '{}'),
            "constraints": json.loads(session_row['constraint_data'] or '{}'),
            "created_at": session_row['created_at']
        }
    
    def update_rating(self, session_id: str, rating: int):
        """Update the rating for a cached session"""
        conn = sqlite3.connect(self.db_path)
        conn.execute('''
            UPDATE context_cache SET rating = ?, last_accessed = CURRENT_TIMESTAMP
            WHERE session_id = ?
        ''', (rating, session_id))
        conn.commit()
        conn.close()
    
    def get_statistics(self) -> Dict[str, Any]:
        """Get cache statistics"""
        conn = sqlite3.connect(self.db_path)
        conn.row_factory = sqlite3.Row
        
        # Overall stats
        cursor = conn.execute('SELECT COUNT(*), AVG(rating) FROM context_cache WHERE rating > 0')
        total_sessions, avg_rating = cursor.fetchone()
        
        # Chain type performance
        cursor = conn.execute('''
            SELECT chain_type, COUNT(*), AVG(rating), MAX(created_at)
            FROM context_cache 
            WHERE rating > 0
            GROUP BY chain_type 
            ORDER BY AVG(rating) DESC
        ''')
        chain_stats = cursor.fetchall()
        
        conn.close()
        
        return {
            "total_cached_sessions": total_sessions or 0,
            "average_rating": round(avg_rating or 0, 2),
            "chain_performance": [
                {
                    "chain_type": row[0],
                    "sessions": row[1],
                    "avg_rating": round(row[2], 2),
                    "last_used": row[3]
                }
                for row in chain_stats
            ]
        }
    
    def cleanup_old_cache(self, days_old: int = 30):
        """Remove cache entries older than specified days"""
        cutoff_date = datetime.now() - timedelta(days=days_old)
        
        conn = sqlite3.connect(self.db_path)
        cursor = conn.execute('''
            DELETE FROM context_cache 
            WHERE created_at < ? AND rating < 3
        ''', (cutoff_date.isoformat(),))
        
        deleted_count = cursor.rowcount
        conn.commit()
        conn.close()
        
        return deleted_count

def main():
    """CLI interface for context manager"""
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python3 context_manager.py <command> [args]")
        print("Commands:")
        print("  stats              - Show cache statistics")
        print("  cleanup [days]     - Remove old low-rated entries")
        print("  context <chain> <prompt> - Get context for prompt")
        return
    
    manager = ContextManager()
    command = sys.argv[1]
    
    if command == "stats":
        stats = manager.get_statistics()
        print(f"Total cached sessions: {stats['total_cached_sessions']}")
        print(f"Average rating: {stats['average_rating']}/5.0")
        print("\nChain Performance:")
        for chain in stats['chain_performance']:
            print(f"  {chain['chain_type']}: {chain['avg_rating']}/5.0 ({chain['sessions']} sessions)")
    
    elif command == "cleanup":
        days = int(sys.argv[2]) if len(sys.argv) > 2 else 30
        deleted = manager.cleanup_old_cache(days)
        print(f"Removed {deleted} old cache entries")
    
    elif command == "context" and len(sys.argv) >= 4:
        chain_type = sys.argv[2]
        prompt = " ".join(sys.argv[3:])
        context = manager.get_relevant_context(chain_type, prompt)
        print(json.dumps(context, indent=2))

if __name__ == "__main__":
    main()