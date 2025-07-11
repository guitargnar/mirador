#!/usr/bin/env python3
"""
Real-time streaming performance dashboard for Mirador V3
Shows live metrics and performance indicators
"""

import asyncio
import curses
import time
from datetime import datetime
from collections import deque
import statistics
from typing import Deque, Optional
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent.parent.parent))
from src.streaming.orchestrator import StreamingOrchestrator

class StreamingDashboard:
    """Real-time performance dashboard"""
    
    def __init__(self):
        self.orchestrator = StreamingOrchestrator(pre_warm=True)
        self.metrics_window = 100  # Keep last 100 queries
        
        # Metrics storage
        self.first_token_times: Deque[float] = deque(maxlen=self.metrics_window)
        self.total_times: Deque[float] = deque(maxlen=self.metrics_window)
        self.token_counts: Deque[int] = deque(maxlen=self.metrics_window)
        self.queries: Deque[str] = deque(maxlen=self.metrics_window)
        self.success_count = 0
        self.failure_count = 0
        
        # Current query tracking
        self.current_query = None
        self.current_start = None
        self.current_first_token = None
        self.current_tokens = 0
        self.current_stage = None
        
    async def process_query(self, query: str):
        """Process a query and update metrics"""
        self.current_query = query
        self.current_start = time.time()
        self.current_first_token = None
        self.current_tokens = 0
        self.current_stage = None
        
        try:
            async for token in self.orchestrator.process(query):
                self.current_tokens += 1
                
                if self.current_first_token is None and token.content.strip() and not token.content.startswith("🤔"):
                    self.current_first_token = time.time() - self.current_start
                
                if token.stage:
                    self.current_stage = token.stage
            
            # Update metrics
            total_time = time.time() - self.current_start
            self.first_token_times.append(self.current_first_token or 0)
            self.total_times.append(total_time)
            self.token_counts.append(self.current_tokens)
            self.queries.append(query)
            self.success_count += 1
            
        except Exception as e:
            self.failure_count += 1
            
        finally:
            self.current_query = None
            self.current_start = None
    
    def draw_dashboard(self, stdscr):
        """Draw the dashboard interface"""
        curses.curs_set(0)  # Hide cursor
        stdscr.nodelay(1)   # Non-blocking input
        
        # Color pairs
        curses.init_pair(1, curses.COLOR_GREEN, curses.COLOR_BLACK)
        curses.init_pair(2, curses.COLOR_RED, curses.COLOR_BLACK)
        curses.init_pair(3, curses.COLOR_CYAN, curses.COLOR_BLACK)
        curses.init_pair(4, curses.COLOR_YELLOW, curses.COLOR_BLACK)
        
        while True:
            stdscr.clear()
            height, width = stdscr.getmaxyx()
            
            # Header
            header = "🚀 Mirador V3 Streaming Dashboard"
            stdscr.addstr(0, (width - len(header)) // 2, header, curses.A_BOLD)
            stdscr.addstr(1, 0, "=" * width)
            
            # Current status
            y = 3
            if self.current_query:
                elapsed = time.time() - self.current_start
                status = f"Processing: {self.current_query[:50]}..."
                stdscr.addstr(y, 0, status, curses.color_pair(4))
                y += 1
                
                stdscr.addstr(y, 0, f"Elapsed: {elapsed:.2f}s | Tokens: {self.current_tokens}")
                if self.current_stage:
                    stdscr.addstr(f" | Stage: {self.current_stage}")
                y += 1
                
                if self.current_first_token:
                    latency_color = 1 if self.current_first_token < 1.0 else 2
                    stdscr.addstr(y, 0, f"First Token: {self.current_first_token:.3f}s", 
                                curses.color_pair(latency_color))
                y += 2
            else:
                stdscr.addstr(y, 0, "Status: Idle", curses.color_pair(3))
                y += 2
            
            # Overall metrics
            stdscr.addstr(y, 0, "📊 Performance Metrics", curses.A_BOLD)
            y += 1
            stdscr.addstr(y, 0, "-" * 40)
            y += 1
            
            total_queries = len(self.first_token_times)
            if total_queries > 0:
                # First token latency
                avg_first = statistics.mean(self.first_token_times)
                p95_first = sorted(self.first_token_times)[int(len(self.first_token_times) * 0.95)]
                under_1s = sum(1 for t in self.first_token_times if t < 1.0)
                success_rate = (under_1s / total_queries) * 100
                
                color = 1 if avg_first < 1.0 else 2
                stdscr.addstr(y, 0, f"Avg First Token: {avg_first:.3f}s", curses.color_pair(color))
                stdscr.addstr(y, 25, f"P95: {p95_first:.3f}s")
                y += 1
                
                stdscr.addstr(y, 0, f"<1s Success Rate: {success_rate:.1f}%", 
                            curses.color_pair(1 if success_rate > 90 else 2))
                y += 2
                
                # Total time
                avg_total = statistics.mean(self.total_times)
                stdscr.addstr(y, 0, f"Avg Total Time: {avg_total:.1f}s")
                y += 1
                
                # Token stats
                avg_tokens = statistics.mean(self.token_counts)
                stdscr.addstr(y, 0, f"Avg Tokens/Query: {avg_tokens:.0f}")
                y += 2
            else:
                stdscr.addstr(y, 0, "No data yet...")
                y += 2
            
            # Success/Failure
            stdscr.addstr(y, 0, f"Success: {self.success_count}", curses.color_pair(1))
            stdscr.addstr(y, 15, f"Failures: {self.failure_count}", curses.color_pair(2))
            y += 2
            
            # Recent queries
            if self.queries:
                stdscr.addstr(y, 0, "📝 Recent Queries", curses.A_BOLD)
                y += 1
                stdscr.addstr(y, 0, "-" * 40)
                y += 1
                
                for i, (query, first_token, total) in enumerate(
                    list(zip(self.queries, self.first_token_times, self.total_times))[-5:]
                ):
                    color = 1 if first_token < 1.0 else 2
                    stdscr.addstr(y, 0, f"{query[:30]}...", curses.color_pair(color))
                    stdscr.addstr(y, 35, f"{first_token:.3f}s / {total:.1f}s")
                    y += 1
            
            # Instructions
            stdscr.addstr(height - 2, 0, "Press 'q' to quit | 't' to run test query", 
                        curses.A_DIM)
            
            # Refresh
            stdscr.refresh()
            
            # Check for input
            key = stdscr.getch()
            if key == ord('q'):
                break
            elif key == ord('t'):
                # Run a test query
                asyncio.create_task(self.process_query("What are three things I should focus on?"))
            
            # Small delay
            time.sleep(0.1)
    
    async def run(self):
        """Run the dashboard"""
        # Start with a test query
        await self.process_query("System startup test")
        
        # Run the curses interface
        curses.wrapper(self.draw_dashboard)

async def main():
    """Run the streaming dashboard"""
    dashboard = StreamingDashboard()
    await dashboard.run()

if __name__ == "__main__":
    print("Starting Mirador V3 Streaming Dashboard...")
    print("This will open a full-screen terminal interface.")
    print("Press Enter to continue...")
    input()
    
    asyncio.run(main())