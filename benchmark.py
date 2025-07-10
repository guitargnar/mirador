#!/usr/bin/env python3
import asyncio
import time
import statistics

async def benchmark_streaming():
    from src.streaming.orchestrator import StreamingOrchestrator
    
    orchestrator = StreamingOrchestrator()
    first_tokens = []
    total_times = []
    
    queries = [
        "What's the meaning of life?",
        "How can I be more productive?",
        "Explain quantum computing simply"
    ]
    
    print("🚀 Mirador V3 Streaming Benchmark\n")
    print("=" * 60)
    
    for query in queries:
        print(f"\nQuery: {query}")
        print("-" * 40)
        
        start = time.time()
        first_token = None
        token_count = 0
        
        async for token in orchestrator.process(query):
            if first_token is None and token.content.strip() and not token.content.startswith("🤔"):
                first_token = time.time() - start
                first_tokens.append(first_token)
                print(f"⚡ First token: {first_token:.2f}s")
            
            # Count tokens
            if token.metadata.get("stage") in ["quick_response", "deep_analysis", "synthesis"]:
                token_count += len(token.content.split())
        
        total_time = time.time() - start
        total_times.append(total_time)
        print(f"✅ Total time: {total_time:.1f}s ({token_count} tokens)")
    
    print(f"\n{'='*60}")
    print(f"📊 STREAMING PERFORMANCE SUMMARY:")
    print(f"{'='*60}")
    print(f"  First token (avg): {statistics.mean(first_tokens):.2f}s")
    print(f"  First token (best): {min(first_tokens):.2f}s")
    print(f"  Total time (avg): {statistics.mean(total_times):.1f}s")
    print(f"  vs Batch (45s): {45/statistics.mean(total_times):.1f}x faster perception")
    print(f"{'='*60}")

if __name__ == "__main__":
    asyncio.run(benchmark_streaming())