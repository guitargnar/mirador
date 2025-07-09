#!/usr/bin/env python3
"""
Memory and Learning System for Mirador
Provides context persistence and pattern learning across sessions
"""

import os
import json
import sqlite3
from datetime import datetime, timedelta
from typing import List, Dict, Any, Optional, Tuple
import numpy as np
from collections import defaultdict
import pickle
import hashlib
import re

# Try to import optional dependencies
try:
    import chromadb
    from chromadb.config import Settings
    HAS_CHROMADB = True
except ImportError:
    HAS_CHROMADB = False
    
try:
    from sentence_transformers import SentenceTransformer
    HAS_SENTENCE_TRANSFORMERS = True
except ImportError:
    HAS_SENTENCE_TRANSFORMERS = False


class MemorySystem:
    """Advanced memory system with learning capabilities"""
    
    def __init__(self, persist_directory: str = None):
        if persist_directory is None:
            persist_directory = os.path.expanduser("~/.mirador/memory")
            
        self.persist_directory = persist_directory
        os.makedirs(persist_directory, exist_ok=True)
        
        # Initialize SQLite for structured data
        self.db_path = os.path.join(persist_directory, "memory.db")
        self.conn = sqlite3.connect(self.db_path)
        self.conn.row_factory = sqlite3.Row
        self._init_database()
        
        # Initialize vector store if available
        self.vector_store = None
        self.encoder = None
        if HAS_CHROMADB and HAS_SENTENCE_TRANSFORMERS:
            self._init_vector_store()
        else:
            print("Warning: ChromaDB or sentence-transformers not installed. Using fallback memory.")
            
        # Pattern learning cache
        self.pattern_cache = self._load_patterns()
        
    def _init_database(self):
        """Initialize SQLite database schema"""
        self.conn.executescript("""
            CREATE TABLE IF NOT EXISTS memories (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                session_id TEXT NOT NULL,
                timestamp TIMESTAMP NOT NULL,
                memory_type TEXT NOT NULL,
                content TEXT NOT NULL,
                content_hash TEXT NOT NULL,
                metadata TEXT,
                embedding_id TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
            
            CREATE INDEX IF NOT EXISTS idx_session ON memories(session_id);
            CREATE INDEX IF NOT EXISTS idx_type ON memories(memory_type);
            CREATE INDEX IF NOT EXISTS idx_hash ON memories(content_hash);
            
            CREATE TABLE IF NOT EXISTS patterns (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                pattern_type TEXT NOT NULL,
                pattern_data TEXT NOT NULL,
                confidence REAL DEFAULT 0.5,
                occurrence_count INTEGER DEFAULT 1,
                last_seen TIMESTAMP,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
            
            CREATE TABLE IF NOT EXISTS feedback (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                memory_id INTEGER NOT NULL,
                rating INTEGER,
                feedback_text TEXT,
                improvement_applied BOOLEAN DEFAULT 0,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY(memory_id) REFERENCES memories(id)
            );
            
            CREATE TABLE IF NOT EXISTS user_preferences (
                user_id TEXT PRIMARY KEY,
                preferences TEXT NOT NULL,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            );
        """)
        self.conn.commit()
        
    def _init_vector_store(self):
        """Initialize ChromaDB vector store"""
        try:
            self.client = chromadb.PersistentClient(
                path=os.path.join(self.persist_directory, "chroma"),
                settings=Settings(anonymized_telemetry=False)
            )
            
            # Create collections
            self.executions = self.client.get_or_create_collection("executions")
            self.knowledge = self.client.get_or_create_collection("knowledge")
            self.decisions = self.client.get_or_create_collection("decisions")
            
            # Initialize encoder
            self.encoder = SentenceTransformer('all-MiniLM-L6-v2')
            self.vector_store = True
            
        except Exception as e:
            print(f"Failed to initialize vector store: {e}")
            self.vector_store = None
            
    def remember(self, session_id: str, content: str, memory_type: str = "execution",
                metadata: Dict = None) -> str:
        """Store a memory with optional vector embedding"""
        content_hash = hashlib.md5(content.encode()).hexdigest()
        memory_id = f"{memory_type}_{session_id}_{datetime.now().timestamp()}"
        
        # Store in SQLite
        cursor = self.conn.execute("""
            INSERT INTO memories 
            (session_id, timestamp, memory_type, content, content_hash, metadata, embedding_id)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """, [
            session_id,
            datetime.now(),
            memory_type,
            content,
            content_hash,
            json.dumps(metadata) if metadata else None,
            memory_id if self.vector_store else None
        ])
        
        sqlite_id = cursor.lastrowid
        self.conn.commit()
        
        # Store in vector database if available
        if self.vector_store and self.encoder:
            try:
                embedding = self.encoder.encode(content).tolist()
                
                collection_map = {
                    'execution': self.executions,
                    'knowledge': self.knowledge,
                    'decision': self.decisions
                }
                
                collection = collection_map.get(memory_type, self.executions)
                
                collection.add(
                    embeddings=[embedding],
                    documents=[content],
                    metadatas=[{
                        'session_id': session_id,
                        'timestamp': datetime.now().isoformat(),
                        'sqlite_id': str(sqlite_id),
                        **(metadata or {})
                    }],
                    ids=[memory_id]
                )
            except Exception as e:
                print(f"Failed to store vector embedding: {e}")
                
        # Update patterns
        self._learn_patterns(content, memory_type, metadata)
        
        return memory_id
        
    def recall(self, query: str, memory_types: List[str] = None, 
              limit: int = 5, time_range_days: int = None) -> List[Dict]:
        """Recall relevant memories based on query"""
        results = []
        
        # Vector search if available
        if self.vector_store and self.encoder:
            try:
                query_embedding = self.encoder.encode(query).tolist()
                
                collections = []
                if not memory_types:
                    collections = [self.executions, self.knowledge, self.decisions]
                else:
                    collection_map = {
                        'execution': self.executions,
                        'knowledge': self.knowledge,
                        'decision': self.decisions
                    }
                    collections = [collection_map[t] for t in memory_types if t in collection_map]
                    
                for collection in collections:
                    search_results = collection.query(
                        query_embeddings=[query_embedding],
                        n_results=limit
                    )
                    
                    for i in range(len(search_results['ids'][0])):
                        results.append({
                            'id': search_results['ids'][0][i],
                            'content': search_results['documents'][0][i],
                            'metadata': search_results['metadatas'][0][i],
                            'similarity': 1 - search_results['distances'][0][i],
                            'source': 'vector'
                        })
                        
            except Exception as e:
                print(f"Vector search failed: {e}")
                
        # Fallback to SQL search
        if not results:
            sql_query = """
                SELECT * FROM memories 
                WHERE content LIKE ? 
            """
            params = [f'%{query}%']
            
            if memory_types:
                placeholders = ','.join(['?' for _ in memory_types])
                sql_query += f" AND memory_type IN ({placeholders})"
                params.extend(memory_types)
                
            if time_range_days:
                sql_query += " AND timestamp > datetime('now', ?)"
                params.append(f'-{time_range_days} days')
                
            sql_query += " ORDER BY timestamp DESC LIMIT ?"
            params.append(limit)
            
            cursor = self.conn.execute(sql_query, params)
            
            for row in cursor:
                results.append({
                    'id': row['id'],
                    'content': row['content'],
                    'metadata': json.loads(row['metadata']) if row['metadata'] else {},
                    'similarity': 0.5,  # Fixed similarity for SQL results
                    'source': 'sql'
                })
                
        # Sort by similarity
        results.sort(key=lambda x: x['similarity'], reverse=True)
        
        return results[:limit]
        
    def get_context_for_session(self, session_id: str) -> Dict[str, Any]:
        """Get full context for a session including related memories"""
        # Get direct session memories
        cursor = self.conn.execute("""
            SELECT * FROM memories 
            WHERE session_id = ? 
            ORDER BY timestamp DESC
        """, [session_id])
        
        session_memories = [dict(row) for row in cursor]
        
        # Find related sessions
        if session_memories and self.vector_store:
            # Use first memory to find similar sessions
            similar = self.recall(
                session_memories[0]['content'], 
                limit=10
            )
            
            related_sessions = set()
            for memory in similar:
                if memory['metadata'].get('session_id') != session_id:
                    related_sessions.add(memory['metadata']['session_id'])
                    
        else:
            related_sessions = set()
            
        # Get user preferences
        user_id = os.getenv('USER', 'default')
        preferences = self._get_user_preferences(user_id)
        
        # Get learned patterns
        patterns = self._get_relevant_patterns(session_memories[0]['content'] if session_memories else "")
        
        return {
            'session_id': session_id,
            'memories': session_memories,
            'related_sessions': list(related_sessions),
            'user_preferences': preferences,
            'patterns': patterns,
            'timestamp': datetime.now().isoformat()
        }
        
    def learn_from_feedback(self, memory_id: str, rating: int, 
                           feedback_text: str = None) -> bool:
        """Learn from user feedback to improve future responses"""
        try:
            # Store feedback
            self.conn.execute("""
                INSERT INTO feedback (memory_id, rating, feedback_text)
                VALUES (?, ?, ?)
            """, [memory_id, rating, feedback_text])
            
            self.conn.commit()
            
            # Update patterns based on feedback
            if rating >= 4:
                # Positive feedback - reinforce patterns
                memory = self.conn.execute(
                    "SELECT content, memory_type FROM memories WHERE id = ?",
                    [memory_id]
                ).fetchone()
                
                if memory:
                    self._reinforce_patterns(memory['content'], memory['memory_type'])
                    
            elif rating <= 2:
                # Negative feedback - adjust patterns
                self._adjust_patterns_from_negative_feedback(memory_id, feedback_text)
                
            return True
            
        except Exception as e:
            print(f"Failed to process feedback: {e}")
            return False
            
    def _learn_patterns(self, content: str, memory_type: str, metadata: Dict = None):
        """Extract and learn patterns from content"""
        patterns = []
        
        # Extract command patterns
        command_pattern = r'(./[\w-]+(?:\s+[\w-]+)*)'
        commands = re.findall(command_pattern, content)
        for cmd in commands:
            patterns.append(('command', cmd))
            
        # Extract question patterns
        question_words = ['what', 'how', 'why', 'when', 'where', 'who']
        for word in question_words:
            if word in content.lower():
                # Extract the question structure
                pattern = re.search(rf'{word}\s+.*?\?', content, re.IGNORECASE)
                if pattern:
                    patterns.append(('question', pattern.group()))
                    
        # Extract task patterns
        task_indicators = ['create', 'analyze', 'review', 'update', 'fix', 'implement']
        for indicator in task_indicators:
            if indicator in content.lower():
                patterns.append(('task', indicator))
                
        # Store patterns
        for pattern_type, pattern_data in patterns:
            existing = self.conn.execute("""
                SELECT id, occurrence_count FROM patterns 
                WHERE pattern_type = ? AND pattern_data = ?
            """, [pattern_type, pattern_data]).fetchone()
            
            if existing:
                # Update existing pattern
                self.conn.execute("""
                    UPDATE patterns 
                    SET occurrence_count = occurrence_count + 1,
                        last_seen = ?,
                        confidence = MIN(0.95, confidence + 0.05)
                    WHERE id = ?
                """, [datetime.now(), existing['id']])
            else:
                # Create new pattern
                self.conn.execute("""
                    INSERT INTO patterns (pattern_type, pattern_data, last_seen)
                    VALUES (?, ?, ?)
                """, [pattern_type, pattern_data, datetime.now()])
                
        self.conn.commit()
        
    def _reinforce_patterns(self, content: str, memory_type: str):
        """Reinforce patterns from successful interactions"""
        # Increase confidence for patterns found in this content
        patterns = self._extract_patterns(content)
        
        for pattern_type, pattern_data in patterns:
            self.conn.execute("""
                UPDATE patterns 
                SET confidence = MIN(1.0, confidence + 0.1),
                    occurrence_count = occurrence_count + 1
                WHERE pattern_type = ? AND pattern_data = ?
            """, [pattern_type, pattern_data])
            
        self.conn.commit()
        
    def _adjust_patterns_from_negative_feedback(self, memory_id: str, feedback_text: str):
        """Adjust patterns based on negative feedback"""
        # Decrease confidence for patterns in poorly rated content
        memory = self.conn.execute(
            "SELECT content FROM memories WHERE id = ?",
            [memory_id]
        ).fetchone()
        
        if memory:
            patterns = self._extract_patterns(memory['content'])
            
            for pattern_type, pattern_data in patterns:
                self.conn.execute("""
                    UPDATE patterns 
                    SET confidence = MAX(0.1, confidence - 0.1)
                    WHERE pattern_type = ? AND pattern_data = ?
                """, [pattern_type, pattern_data])
                
        self.conn.commit()
        
    def _extract_patterns(self, content: str) -> List[Tuple[str, str]]:
        """Extract patterns from content"""
        patterns = []
        
        # Similar to _learn_patterns but returns the patterns
        command_pattern = r'(./[\w-]+(?:\s+[\w-]+)*)'
        commands = re.findall(command_pattern, content)
        patterns.extend([('command', cmd) for cmd in commands])
        
        return patterns
        
    def _get_relevant_patterns(self, query: str) -> List[Dict]:
        """Get patterns relevant to a query"""
        cursor = self.conn.execute("""
            SELECT * FROM patterns 
            WHERE confidence > 0.6
            ORDER BY confidence DESC, occurrence_count DESC
            LIMIT 10
        """)
        
        return [dict(row) for row in cursor]
        
    def _get_user_preferences(self, user_id: str) -> Dict:
        """Get user preferences"""
        result = self.conn.execute(
            "SELECT preferences FROM user_preferences WHERE user_id = ?",
            [user_id]
        ).fetchone()
        
        if result:
            return json.loads(result['preferences'])
        else:
            # Default preferences
            return {
                'output_style': 'concise',
                'detail_level': 'medium',
                'preferred_models': [],
                'task_history': []
            }
            
    def update_user_preferences(self, user_id: str, preferences: Dict):
        """Update user preferences"""
        self.conn.execute("""
            INSERT OR REPLACE INTO user_preferences (user_id, preferences, updated_at)
            VALUES (?, ?, ?)
        """, [user_id, json.dumps(preferences), datetime.now()])
        
        self.conn.commit()
        
    def _load_patterns(self) -> Dict:
        """Load pattern cache from database"""
        cache = defaultdict(list)
        
        cursor = self.conn.execute("""
            SELECT pattern_type, pattern_data, confidence 
            FROM patterns 
            WHERE confidence > 0.5
        """)
        
        for row in cursor:
            cache[row['pattern_type']].append({
                'data': row['pattern_data'],
                'confidence': row['confidence']
            })
            
        return dict(cache)
        
    def get_suggestions(self, prompt: str, context: Dict = None) -> List[Dict]:
        """Get AI-powered suggestions based on memory"""
        suggestions = []
        
        # Find similar past interactions
        similar_memories = self.recall(prompt, limit=5)
        
        for memory in similar_memories:
            if memory['similarity'] > 0.7:
                # Check if this memory has positive feedback
                feedback = self.conn.execute("""
                    SELECT AVG(rating) as avg_rating 
                    FROM feedback 
                    WHERE memory_id = ?
                """, [memory.get('id', 0)]).fetchone()
                
                if feedback and feedback['avg_rating'] and feedback['avg_rating'] >= 4:
                    suggestions.append({
                        'type': 'similar_success',
                        'content': memory['content'][:200] + "...",
                        'confidence': memory['similarity'],
                        'suggestion': "Similar successful interaction found"
                    })
                    
        # Pattern-based suggestions
        patterns = self._get_relevant_patterns(prompt)
        for pattern in patterns[:3]:
            if pattern['confidence'] > 0.7:
                suggestions.append({
                    'type': 'pattern',
                    'content': pattern['pattern_data'],
                    'confidence': pattern['confidence'],
                    'suggestion': f"Common {pattern['pattern_type']} pattern detected"
                })
                
        return suggestions
        
    def export_memory(self, format: str = 'json', 
                     start_date: datetime = None,
                     end_date: datetime = None) -> str:
        """Export memory data for backup or analysis"""
        query = "SELECT * FROM memories WHERE 1=1"
        params = []
        
        if start_date:
            query += " AND timestamp >= ?"
            params.append(start_date)
            
        if end_date:
            query += " AND timestamp <= ?"
            params.append(end_date)
            
        cursor = self.conn.execute(query, params)
        memories = [dict(row) for row in cursor]
        
        if format == 'json':
            return json.dumps({
                'memories': memories,
                'patterns': self.pattern_cache,
                'export_date': datetime.now().isoformat()
            }, indent=2, default=str)
        else:
            raise ValueError(f"Unsupported export format: {format}")
            
    def cleanup_old_memories(self, days: int = 90):
        """Clean up old memories to save space"""
        threshold = datetime.now() - timedelta(days=days)
        
        # Delete old memories with low relevance
        self.conn.execute("""
            DELETE FROM memories 
            WHERE timestamp < ? 
            AND id NOT IN (
                SELECT memory_id FROM feedback WHERE rating >= 4
            )
        """, [threshold])
        
        self.conn.commit()
        
        return self.conn.total_changes


# CLI interface
if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Mirador Memory System")
    parser.add_argument('command', choices=['search', 'stats', 'export', 'cleanup'],
                       help='Command to execute')
    parser.add_argument('--query', help='Search query')
    parser.add_argument('--days', type=int, default=30, help='Days to include')
    
    args = parser.parse_args()
    
    memory = MemorySystem()
    
    if args.command == 'search':
        if not args.query:
            print("Please provide a query with --query")
        else:
            results = memory.recall(args.query, limit=10)
            print(f"\n=== Memory Search Results for '{args.query}' ===\n")
            
            for i, result in enumerate(results, 1):
                print(f"{i}. Similarity: {result['similarity']:.2f}")
                print(f"   Content: {result['content'][:200]}...")
                print(f"   Type: {result['metadata'].get('memory_type', 'unknown')}")
                print(f"   Session: {result['metadata'].get('session_id', 'unknown')}")
                print()
                
    elif args.command == 'stats':
        cursor = memory.conn.execute("""
            SELECT 
                COUNT(*) as total_memories,
                COUNT(DISTINCT session_id) as unique_sessions,
                COUNT(DISTINCT memory_type) as memory_types
            FROM memories
            WHERE timestamp > datetime('now', ?)
        """, [f'-{args.days} days'])
        
        stats = cursor.fetchone()
        
        pattern_count = memory.conn.execute("SELECT COUNT(*) FROM patterns").fetchone()[0]
        
        print(f"\n=== Memory System Statistics (Last {args.days} Days) ===\n")
        print(f"Total Memories: {stats['total_memories']}")
        print(f"Unique Sessions: {stats['unique_sessions']}")
        print(f"Memory Types: {stats['memory_types']}")
        print(f"Learned Patterns: {pattern_count}")
        
    elif args.command == 'export':
        data = memory.export_memory()
        filename = f"memory_export_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        
        with open(filename, 'w') as f:
            f.write(data)
            
        print(f"Memory exported to {filename}")
        
    elif args.command == 'cleanup':
        deleted = memory.cleanup_old_memories(days=args.days)
        print(f"Cleaned up {deleted} old memories")