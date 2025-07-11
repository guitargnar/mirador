#!/usr/bin/env python3
"""
Performance monitoring for Mirador V3 streaming
Tracks latency metrics and provides insights
"""

import asyncio
import json
import time
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional
import statistics
from dataclasses import dataclass, asdict
import sqlite3

from orchestrator import StreamingOrchestrator, StreamToken

@dataclass
class PerformanceMetric:
    """Single performance measurement"""
    timestamp: float
    query: str
    first_token_latency: float
    total_time: float
    stages_used: List[str]
    token_count: int
    model_latencies: Dict[str, float]
    success: bool
    error: Optional[str] = None

class PerformanceMonitor:
    """Monitor and analyze V3 streaming performance"""
    
    def __init__(self, db_path: str = "performance_metrics.db"):
        self.db_path = db_path
        self.orchestrator = StreamingOrchestrator(pre_warm=True)
        self._init_db()
    
    def _init_db(self):
        """Initialize SQLite database for metrics"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS metrics (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                timestamp REAL,
                query TEXT,
                first_token_latency REAL,
                total_time REAL,
                stages_used TEXT,
                token_count INTEGER,
                model_latencies TEXT,
                success BOOLEAN,
                error TEXT
            )
        """)
        
        conn.commit()
        conn.close()
    
    async def measure_query(self, query: str, stages: Optional[List[str]] = None) -> PerformanceMetric:
        """Measure performance for a single query"""
        start_time = time.time()
        first_token_time = None
        token_count = 0
        model_latencies = {}
        stages_used = []
        current_stage = None
        stage_start = None
        
        try:
            async for token in self.orchestrator.process(query, stages):
                token_count += 1
                
                # Track first token
                if first_token_time is None and token.content.strip() and not token.content.startswith("🤔"):
                    first_token_time = time.time() - start_time
                
                # Track stage changes
                if token.stage and token.stage != current_stage:
                    if current_stage and stage_start:
                        model_latencies[current_stage] = time.time() - stage_start
                    current_stage = token.stage
                    stage_start = time.time()
                    stages_used.append(token.stage)
            
            # Record last stage
            if current_stage and stage_start:
                model_latencies[current_stage] = time.time() - stage_start
            
            total_time = time.time() - start_time
            
            metric = PerformanceMetric(
                timestamp=start_time,
                query=query,
                first_token_latency=first_token_time or 0,
                total_time=total_time,
                stages_used=stages_used,
                token_count=token_count,
                model_latencies=model_latencies,
                success=True
            )
            
        except Exception as e:
            metric = PerformanceMetric(
                timestamp=start_time,
                query=query,
                first_token_latency=first_token_time or 0,
                total_time=time.time() - start_time,
                stages_used=stages_used,
                token_count=token_count,
                model_latencies=model_latencies,
                success=False,
                error=str(e)
            )
        
        # Save to database
        self._save_metric(metric)
        
        return metric
    
    def _save_metric(self, metric: PerformanceMetric):
        """Save metric to database"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute("""
            INSERT INTO metrics 
            (timestamp, query, first_token_latency, total_time, stages_used, 
             token_count, model_latencies, success, error)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (
            metric.timestamp,
            metric.query,
            metric.first_token_latency,
            metric.total_time,
            json.dumps(metric.stages_used),
            metric.token_count,
            json.dumps(metric.model_latencies),
            metric.success,
            metric.error
        ))
        
        conn.commit()
        conn.close()
    
    def get_analytics(self, hours: int = 24) -> Dict:
        """Get performance analytics for the last N hours"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        since = time.time() - (hours * 3600)
        
        cursor.execute("""
            SELECT * FROM metrics 
            WHERE timestamp > ? AND success = 1
            ORDER BY timestamp DESC
        """, (since,))
        
        rows = cursor.fetchall()
        conn.close()
        
        if not rows:
            return {"error": "No data available"}
        
        # Extract metrics
        first_tokens = [row[3] for row in rows]
        total_times = [row[4] for row in rows]
        token_counts = [row[6] for row in rows]
        
        # Calculate statistics
        analytics = {
            "period_hours": hours,
            "total_queries": len(rows),
            "first_token_latency": {
                "average": statistics.mean(first_tokens),
                "median": statistics.median(first_tokens),
                "min": min(first_tokens),
                "max": max(first_tokens),
                "p95": sorted(first_tokens)[int(len(first_tokens) * 0.95)] if len(first_tokens) > 1 else first_tokens[0],
                "under_1s_percent": (sum(1 for t in first_tokens if t < 1.0) / len(first_tokens)) * 100
            },
            "total_time": {
                "average": statistics.mean(total_times),
                "median": statistics.median(total_times),
                "min": min(total_times),
                "max": max(total_times)
            },
            "tokens": {
                "average_per_query": statistics.mean(token_counts),
                "total": sum(token_counts)
            },
            "success_rate": (len(rows) / len(rows)) * 100  # Only successful queries in this set
        }
        
        # Model performance
        all_latencies = {}
        for row in rows:
            model_lats = json.loads(row[7])
            for model, latency in model_lats.items():
                if model not in all_latencies:
                    all_latencies[model] = []
                all_latencies[model].append(latency)
        
        analytics["model_performance"] = {}
        for model, latencies in all_latencies.items():
            analytics["model_performance"][model] = {
                "average": statistics.mean(latencies),
                "calls": len(latencies)
            }
        
        return analytics
    
    async def run_benchmark_suite(self):
        """Run a comprehensive benchmark suite"""
        test_queries = [
            # Simple queries (should use quick response only)
            "List three things",
            "What are my top priorities?",
            "Give me three tips",
            
            # Medium queries (quick + synthesis)
            "What should I focus on today?",
            "How can I be more productive?",
            "What's the best approach to learning?",
            
            # Complex queries (all stages)
            "Analyze my career trajectory and provide recommendations",
            "Create a comprehensive plan for improving my skills",
            "Explain the implications of AI on my industry"
        ]
        
        print("🧪 Running V3 Performance Benchmark Suite")
        print("=" * 60)
        
        results = []
        for query in test_queries:
            print(f"\n📝 Testing: {query}")
            metric = await self.measure_query(query)
            results.append(metric)
            
            print(f"   First token: {metric.first_token_latency:.3f}s")
            print(f"   Total time: {metric.total_time:.1f}s")
            print(f"   Success: {'✅' if metric.success else '❌'}")
        
        # Summary
        print("\n" + "=" * 60)
        print("📊 BENCHMARK SUMMARY")
        analytics = self.get_analytics(hours=1)  # Last hour
        
        print(f"\nFirst Token Latency:")
        print(f"  Average: {analytics['first_token_latency']['average']:.3f}s")
        print(f"  Median: {analytics['first_token_latency']['median']:.3f}s")
        print(f"  P95: {analytics['first_token_latency']['p95']:.3f}s")
        print(f"  <1s Success Rate: {analytics['first_token_latency']['under_1s_percent']:.1f}%")
        
        return results

async def main():
    """Run performance monitoring"""
    monitor = PerformanceMonitor()
    
    # Run benchmark suite
    await monitor.run_benchmark_suite()
    
    # Show analytics
    print("\n📈 Last 24 Hour Analytics:")
    analytics = monitor.get_analytics(hours=24)
    print(json.dumps(analytics, indent=2))

if __name__ == "__main__":
    asyncio.run(main())