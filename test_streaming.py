#!/usr/bin/env python3
"""Test the streaming implementation"""

import asyncio
import time
from src.streaming.orchestrator import StreamingOrchestrator

async def test_streaming():
    """Test basic streaming functionality"""
    queries = [
        "What should I focus on today?",
        "Explain the benefits of morning routines",
        "How can I improve my productivity?"
    ]
    
    for query in queries:
        print(f"\n{'='*60}")
        print(f"Query: {query}")
        print(f"{'='*60}\n")
        
        orchestrator = StreamingOrchestrator()
        start_time = time.time()
        first_token_time = None
        token_count = 0
        
        try:
            async for token in orchestrator.process(query):
                print(token.content, end="", flush=True)
                
                if first_token_time is None and token.content.strip():
                    first_token_time = time.time() - start_time
                
                if token.content.strip():
                    token_count += len(token.content.split())
        
        except Exception as e:
            print(f"\nError: {e}")
        
        total_time = time.time() - start_time
        
        print(f"\n\n📊 Metrics:")
        if first_token_time:
            print(f"  - First token: {first_token_time:.2f}s")
        else:
            print(f"  - First token: N/A")
        print(f"  - Total time: {total_time:.1f}s")
        print(f"  - Token count: {token_count}")
        if total_time > 0:
            print(f"  - Tokens/second: {token_count/total_time:.1f}")

if __name__ == "__main__":
    print("🔥 Mirador Streaming Test\n")
    asyncio.run(test_streaming())