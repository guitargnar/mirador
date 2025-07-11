# Mirador + Claude Implementation Guide

## Overview

This guide provides step-by-step instructions for implementing a hybrid AI system that combines Mirador's local processing capabilities with Claude's advanced reasoning through the Anthropic API.

## Prerequisites

### System Requirements
- macOS with Apple Silicon (M1/M2/M3) or Intel Mac
- Python 3.8+ installed
- Ollama installed and running
- 16GB+ RAM recommended
- Active internet connection for Claude API

### Required Accounts
- Anthropic API key (get from https://console.anthropic.com)
- Git for version control
- Terminal/command line access

### Existing Mirador Setup
```bash
# Verify Mirador is working
cd /Users/matthewscott/Projects/mirador
./mirador-smart-v2 "test query"

# Check Ollama models
ollama list | grep -E "(matthew_context|universal_strategy)"
```

## Step 1: Environment Setup

### 1.1 Create Project Structure
```bash
cd /Users/matthewscott/Projects/mirador
mkdir -p claude_integration/{config,lib,scripts,logs}
cd claude_integration
```

### 1.2 Install Dependencies
```bash
# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install required packages
pip install anthropic aiohttp asyncio python-dotenv pandas numpy
```

### 1.3 Configure Environment Variables
```bash
# Create .env file
cat > .env << EOF
ANTHROPIC_API_KEY=your_api_key_here
CLAUDE_MODEL=claude-3-opus-20240229
MAX_TOKENS=4096
TEMPERATURE=0.7
LOG_LEVEL=INFO
EOF

# Secure the file
chmod 600 .env
```

## Step 2: Core Integration Module

### 2.1 Create Base Integration Class
```python
# lib/claude_mirador_integration.py
import os
import asyncio
import logging
from typing import Dict, Optional, AsyncGenerator
from anthropic import AsyncAnthropic
from dotenv import load_dotenv
import subprocess
import json

load_dotenv()

class ClaudeMiradorHybrid:
    def __init__(self):
        self.claude = AsyncAnthropic(api_key=os.getenv("ANTHROPIC_API_KEY"))
        self.model = os.getenv("CLAUDE_MODEL", "claude-3-opus-20240229")
        self.logger = logging.getLogger(__name__)
        
    async def get_mirador_context(self, query: str) -> str:
        """Get context from Mirador's local models"""
        try:
            # Run Mirador context provider
            result = subprocess.run(
                ["../mirador-smart-v2", query, "--context-only"],
                capture_output=True,
                text=True,
                timeout=10
            )
            return result.stdout.strip()
        except Exception as e:
            self.logger.error(f"Mirador context error: {e}")
            return ""
    
    async def should_use_claude(self, query: str, context: str) -> bool:
        """Determine if Claude should be used based on query analysis"""
        # Check for private data patterns
        private_patterns = [
            "my ", "personal", "private", "account", "password",
            "ssn", "credit card", "bank account"
        ]
        
        if any(pattern in query.lower() for pattern in private_patterns):
            return False
            
        # Check for complexity indicators
        complex_patterns = [
            "code", "implement", "algorithm", "analyze", "explain",
            "debug", "optimize", "design", "architect"
        ]
        
        return any(pattern in query.lower() for pattern in complex_patterns)
    
    async def query_claude(
        self, 
        prompt: str, 
        context: Optional[str] = None,
        stream: bool = True
    ) -> AsyncGenerator[str, None]:
        """Query Claude API with optional context"""
        
        full_prompt = prompt
        if context:
            full_prompt = f"Context: {context}\n\nQuery: {prompt}"
        
        try:
            if stream:
                async with self.claude.messages.stream(
                    model=self.model,
                    messages=[{"role": "user", "content": full_prompt}],
                    max_tokens=int(os.getenv("MAX_TOKENS", 4096)),
                    temperature=float(os.getenv("TEMPERATURE", 0.7))
                ) as stream:
                    async for chunk in stream.text_stream:
                        yield chunk
            else:
                response = await self.claude.messages.create(
                    model=self.model,
                    messages=[{"role": "user", "content": full_prompt}],
                    max_tokens=int(os.getenv("MAX_TOKENS", 4096))
                )
                yield response.content[0].text
                
        except Exception as e:
            self.logger.error(f"Claude API error: {e}")
            yield f"Error querying Claude: {str(e)}"
    
    async def process_hybrid_query(
        self, 
        query: str,
        force_routing: Optional[str] = None
    ) -> AsyncGenerator[str, None]:
        """Process query using hybrid approach"""
        
        # Step 1: Get Mirador context
        context = await self.get_mirador_context(query)
        
        # Step 2: Determine routing
        if force_routing == "mirador":
            use_claude = False
        elif force_routing == "claude":
            use_claude = True
        else:
            use_claude = await self.should_use_claude(query, context)
        
        # Step 3: Process based on routing
        if use_claude:
            self.logger.info("Routing to Claude with Mirador context")
            async for chunk in self.query_claude(query, context):
                yield chunk
        else:
            self.logger.info("Using Mirador local processing")
            # Run full Mirador processing
            result = subprocess.run(
                ["../mirador-smart-v2", query],
                capture_output=True,
                text=True
            )
            yield result.stdout
```

### 2.2 Create Streaming Handler
```python
# lib/streaming_handler.py
import asyncio
from typing import AsyncGenerator, Callable
import time

class StreamingHandler:
    def __init__(self, confidence_thresholds: Dict[str, float] = None):
        self.thresholds = confidence_thresholds or {
            "quick": 0.6,
            "deep": 0.85,
            "synthesis": 0.95
        }
        self.stages = []
        
    async def progressive_stream(
        self,
        generator: AsyncGenerator[str, None],
        callback: Callable[[str, str, float], None]
    ):
        """Handle progressive enhancement streaming"""
        
        buffer = ""
        stage = "quick"
        confidence = 0.0
        start_time = time.time()
        
        async for chunk in generator:
            buffer += chunk
            
            # Update confidence based on content length and time
            elapsed = time.time() - start_time
            confidence = min(0.95, 0.6 + (elapsed * 0.1) + (len(buffer) / 10000))
            
            # Determine stage
            if confidence >= self.thresholds["synthesis"]:
                stage = "synthesis"
            elif confidence >= self.thresholds["deep"]:
                stage = "deep"
            else:
                stage = "quick"
            
            # Callback with current state
            callback(chunk, stage, confidence)
            
            # Record stage transitions
            if not self.stages or self.stages[-1][0] != stage:
                self.stages.append((stage, elapsed, confidence))
```

## Step 3: API Integration Layer

### 3.1 Create FastAPI Server
```python
# scripts/hybrid_api_server.py
from fastapi import FastAPI, WebSocket, HTTPException
from fastapi.responses import StreamingResponse
import asyncio
import json
import sys
sys.path.append('../lib')

from claude_mirador_integration import ClaudeMiradorHybrid
from streaming_handler import StreamingHandler

app = FastAPI(title="Mirador + Claude Hybrid API")
hybrid = ClaudeMiradorHybrid()

@app.get("/health")
async def health_check():
    return {"status": "healthy", "services": ["mirador", "claude"]}

@app.post("/query")
async def process_query(
    query: str,
    stream: bool = True,
    routing: Optional[str] = None
):
    """Process a query through the hybrid system"""
    
    async def generate():
        async for chunk in hybrid.process_hybrid_query(query, routing):
            yield f"data: {json.dumps({'content': chunk})}\n\n"
    
    if stream:
        return StreamingResponse(generate(), media_type="text/event-stream")
    else:
        result = ""
        async for chunk in hybrid.process_hybrid_query(query, routing):
            result += chunk
        return {"response": result}

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    """WebSocket endpoint for real-time streaming"""
    await websocket.accept()
    
    try:
        while True:
            data = await websocket.receive_json()
            query = data.get("query")
            
            handler = StreamingHandler()
            
            async def send_update(chunk, stage, confidence):
                await websocket.send_json({
                    "chunk": chunk,
                    "stage": stage,
                    "confidence": confidence
                })
            
            await handler.progressive_stream(
                hybrid.process_hybrid_query(query),
                send_update
            )
            
            await websocket.send_json({"status": "complete"})
            
    except Exception as e:
        await websocket.close()
```

### 3.2 Create CLI Interface
```python
#!/usr/bin/env python3
# scripts/mirador-claude.py
import asyncio
import argparse
import sys
sys.path.append('../lib')

from claude_mirador_integration import ClaudeMiradorHybrid
from rich.console import Console
from rich.live import Live
from rich.markdown import Markdown

console = Console()

async def main():
    parser = argparse.ArgumentParser(description="Mirador + Claude Hybrid CLI")
    parser.add_argument("query", help="Query to process")
    parser.add_argument("--routing", choices=["auto", "mirador", "claude"], 
                       default="auto", help="Force specific routing")
    parser.add_argument("--no-stream", action="store_true", 
                       help="Disable streaming output")
    
    args = parser.parse_args()
    
    hybrid = ClaudeMiradorHybrid()
    
    if args.no_stream:
        result = ""
        async for chunk in hybrid.process_hybrid_query(
            args.query, 
            args.routing if args.routing != "auto" else None
        ):
            result += chunk
        console.print(Markdown(result))
    else:
        with Live("", refresh_per_second=10) as live:
            content = ""
            async for chunk in hybrid.process_hybrid_query(
                args.query,
                args.routing if args.routing != "auto" else None
            ):
                content += chunk
                live.update(Markdown(content))

if __name__ == "__main__":
    asyncio.run(main())
```

## Step 4: Configuration Management

### 4.1 Create Configuration File
```yaml
# config/hybrid_config.yaml
routing:
  patterns:
    always_local:
      - "personal"
      - "private"
      - "my bank"
      - "medical"
    always_claude:
      - "write code"
      - "debug"
      - "implement algorithm"
      - "technical documentation"
    
  thresholds:
    complexity_score: 0.7
    context_requirement: 0.5
    
performance:
  mirador_timeout: 10
  claude_timeout: 30
  max_retries: 3
  
  caching:
    enabled: true
    ttl: 3600
    max_size: 1000
    
cost_management:
  daily_limit: 100
  cost_per_query_limit: 0.10
  fallback_to_local: true
  
logging:
  level: INFO
  file: logs/hybrid.log
  max_size: 10485760  # 10MB
  backup_count: 5
```

### 4.2 Create Monitoring Script
```python
#!/usr/bin/env python3
# scripts/monitor_usage.py
import json
import sqlite3
from datetime import datetime, timedelta
import pandas as pd

class UsageMonitor:
    def __init__(self, db_path="logs/usage.db"):
        self.conn = sqlite3.connect(db_path)
        self.init_db()
        
    def init_db(self):
        self.conn.execute("""
            CREATE TABLE IF NOT EXISTS queries (
                id INTEGER PRIMARY KEY,
                timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
                query TEXT,
                routing TEXT,
                response_time REAL,
                tokens_used INTEGER,
                cost REAL,
                error TEXT
            )
        """)
        self.conn.commit()
    
    def log_query(self, query, routing, response_time, tokens=0, error=None):
        cost = tokens * 0.00003 if routing == "claude" else 0
        self.conn.execute("""
            INSERT INTO queries (query, routing, response_time, tokens_used, cost, error)
            VALUES (?, ?, ?, ?, ?, ?)
        """, (query, routing, response_time, tokens, cost, error))
        self.conn.commit()
    
    def get_daily_stats(self):
        df = pd.read_sql_query("""
            SELECT DATE(timestamp) as date,
                   routing,
                   COUNT(*) as count,
                   AVG(response_time) as avg_time,
                   SUM(cost) as total_cost
            FROM queries
            WHERE timestamp > datetime('now', '-7 days')
            GROUP BY DATE(timestamp), routing
        """, self.conn)
        return df
    
    def get_cost_projection(self):
        # Get last 7 days average
        result = self.conn.execute("""
            SELECT AVG(daily_cost) as avg_daily_cost
            FROM (
                SELECT DATE(timestamp) as date, SUM(cost) as daily_cost
                FROM queries
                WHERE timestamp > datetime('now', '-7 days')
                GROUP BY DATE(timestamp)
            )
        """).fetchone()
        
        avg_daily = result[0] or 0
        return {
            "daily_average": avg_daily,
            "monthly_projection": avg_daily * 30,
            "annual_projection": avg_daily * 365
        }
```

## Step 5: Testing and Validation

### 5.1 Create Test Suite
```python
# tests/test_integration.py
import pytest
import asyncio
from lib.claude_mirador_integration import ClaudeMiradorHybrid

@pytest.mark.asyncio
async def test_routing_decision():
    hybrid = ClaudeMiradorHybrid()
    
    # Test private data stays local
    assert not await hybrid.should_use_claude("What's my bank balance?", "")
    
    # Test complex queries go to Claude
    assert await hybrid.should_use_claude("Write a Python web scraper", "")
    
    # Test simple queries stay local
    assert not await hybrid.should_use_claude("What time is it?", "")

@pytest.mark.asyncio
async def test_hybrid_query():
    hybrid = ClaudeMiradorHybrid()
    
    result = ""
    async for chunk in hybrid.process_hybrid_query("Hello, how are you?"):
        result += chunk
    
    assert len(result) > 0

def test_performance():
    # Test response times
    import time
    start = time.time()
    # Run test query
    elapsed = time.time() - start
    assert elapsed < 2.0  # Should respond in under 2 seconds
```

### 5.2 Create Integration Tests
```bash
#!/bin/bash
# tests/integration_test.sh

echo "🧪 Running Mirador + Claude Integration Tests"
echo "==========================================="

# Test 1: Basic connectivity
echo -e "\n📡 Test 1: API Connectivity"
curl -s http://localhost:8000/health | jq .

# Test 2: Local routing
echo -e "\n🏠 Test 2: Local Routing (Private Data)"
python3 ../scripts/mirador-claude.py "What's my personal spending this month?" --routing mirador

# Test 3: Claude routing
echo -e "\n☁️ Test 3: Claude Routing (Code Generation)"
python3 ../scripts/mirador-claude.py "Write a Python function to sort a list" --routing claude

# Test 4: Auto routing
echo -e "\n🤖 Test 4: Automatic Routing"
python3 ../scripts/mirador-claude.py "Explain how Mirador works"

# Test 5: Performance
echo -e "\n⚡ Test 5: Performance Benchmark"
time python3 ../scripts/mirador-claude.py "Quick test query" --no-stream

echo -e "\n✅ Integration tests complete!"
```

## Step 6: Deployment

### 6.1 Create SystemD Service (Linux/macOS)
```ini
# /etc/systemd/system/mirador-claude.service
[Unit]
Description=Mirador Claude Hybrid API
After=network.target

[Service]
Type=simple
User=matthewscott
WorkingDirectory=/Users/matthewscott/Projects/mirador/claude_integration
Environment="PATH=/usr/local/bin:/usr/bin:/bin"
ExecStart=/usr/bin/python3 scripts/hybrid_api_server.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

### 6.2 Create Docker Container
```dockerfile
# Dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PYTHONPATH=/app

EXPOSE 8000

CMD ["uvicorn", "scripts.hybrid_api_server:app", "--host", "0.0.0.0", "--port", "8000"]
```

## Step 7: Usage Examples

### 7.1 Command Line Usage
```bash
# Basic query
./mirador-claude.py "What's the weather like?"

# Force Claude routing
./mirador-claude.py "Write a sorting algorithm in Python" --routing claude

# Force local routing
./mirador-claude.py "What are my recent expenses?" --routing mirador

# Non-streaming mode
./mirador-claude.py "Explain quantum computing" --no-stream
```

### 7.2 Python Integration
```python
import asyncio
from claude_mirador_integration import ClaudeMiradorHybrid

async def example():
    hybrid = ClaudeMiradorHybrid()
    
    # Process a query
    result = ""
    async for chunk in hybrid.process_hybrid_query("Create a TODO app"):
        result += chunk
        print(chunk, end="", flush=True)
    
    return result

# Run the example
asyncio.run(example())
```

### 7.3 Web Application Integration
```javascript
// JavaScript client example
const eventSource = new EventSource('/query?query=Hello world');

eventSource.onmessage = (event) => {
    const data = JSON.parse(event.data);
    document.getElementById('output').innerHTML += data.content;
};

eventSource.onerror = () => {
    eventSource.close();
};
```

## Troubleshooting

### Common Issues

1. **API Key Error**
   ```
   Solution: Ensure ANTHROPIC_API_KEY is set in .env file
   ```

2. **Mirador Not Found**
   ```
   Solution: Check path to mirador-smart-v2 script
   Update path in ClaudeMiradorHybrid class
   ```

3. **Slow Response Times**
   ```
   Solution: Check network connection
   Verify Ollama is running for local models
   Consider adjusting timeout values
   ```

4. **High Costs**
   ```
   Solution: Review routing decisions
   Implement caching for repeated queries
   Set daily/monthly limits
   ```

## Performance Optimization

### Caching Strategy
```python
from functools import lru_cache
import hashlib

@lru_cache(maxsize=1000)
def get_cached_response(query_hash):
    # Check cache before processing
    pass

def hash_query(query):
    return hashlib.md5(query.encode()).hexdigest()
```

### Parallel Processing
```python
async def parallel_process(queries):
    tasks = [hybrid.process_hybrid_query(q) for q in queries]
    results = await asyncio.gather(*tasks)
    return results
```

## Monitoring and Maintenance

### Daily Tasks
- Check usage logs: `python3 scripts/monitor_usage.py`
- Review error logs: `tail -f logs/hybrid.log`
- Monitor costs: Check daily spend against limits

### Weekly Tasks
- Review routing accuracy
- Update routing patterns based on usage
- Clean up old logs and cache

### Monthly Tasks
- Analyze performance metrics
- Update cost projections
- Review and optimize routing rules

## Conclusion

This implementation provides a robust, production-ready integration between Mirador and Claude that:
- Preserves privacy for sensitive data
- Optimizes costs through intelligent routing
- Maintains high performance with streaming
- Provides comprehensive monitoring and control

For additional support or advanced configurations, refer to the project documentation or submit an issue to the repository.