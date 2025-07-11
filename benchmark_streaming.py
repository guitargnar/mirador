#!/usr/bin/env python3
"""Benchmark streaming vs traditional Mirador approach"""

import asyncio
import time
import subprocess
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).parent))
from src.streaming.orchestrator import StreamingOrchestrator

async def benchmark_streaming(query: str):
    """Benchmark the streaming approach"""
    print("\n🚀 Testing V3 Streaming Approach")
    print("=" * 60)
    
    orchestrator = StreamingOrchestrator(pre_warm=True)
    
    start_time = time.time()
    first_token_time = None
    response_text = ""
    
    async for token in orchestrator.process(query):
        if first_token_time is None and token.content.strip() and not token.content.startswith("🤔"):
            first_token_time = time.time() - start_time
        
        # Collect response but don't print (for fair comparison)
        response_text += token.content
    
    total_time = time.time() - start_time
    
    return {
        "approach": "V3 Streaming",
        "first_token": first_token_time,
        "total_time": total_time,
        "response_length": len(response_text),
        "perceived_wait": first_token_time  # User starts seeing results
    }

def benchmark_traditional(query: str):
    """Benchmark the traditional shell script approach"""
    print("\n🐌 Testing V2 Traditional Approach")
    print("=" * 60)
    
    # Use mirador-smart-v2 for comparison
    mirador_v2 = Path(__file__).parent / "bin" / "mirador-smart-v2"
    
    if not mirador_v2.exists():
        # Fallback to simple ollama command
        print("Using direct ollama command (mirador-smart-v2 not found)")
        start_time = time.time()
        
        result = subprocess.run(
            ["ollama", "run", "matthew_context_provider_v5_complete:latest", query],
            capture_output=True,
            text=True
        )
        
        total_time = time.time() - start_time
        response_text = result.stdout
    else:
        start_time = time.time()
        
        result = subprocess.run(
            [str(mirador_v2), query],
            capture_output=True,
            text=True
        )
        
        total_time = time.time() - start_time
        response_text = result.stdout
    
    return {
        "approach": "V2 Traditional",
        "first_token": total_time,  # User waits for entire response
        "total_time": total_time,
        "response_length": len(response_text),
        "perceived_wait": total_time
    }

async def run_benchmark():
    """Run complete benchmark comparison"""
    queries = [
        "What are three things I should focus on today?",
        "How can I improve my productivity?",
        "What's the best approach to learn a new skill?"
    ]
    
    print("🏁 Mirador V3 vs V2 Benchmark")
    print("=" * 60)
    
    all_results = []
    
    for query in queries:
        print(f"\n📝 Query: {query}")
        print("-" * 60)
        
        # Test streaming
        streaming_result = await benchmark_streaming(query)
        all_results.append(streaming_result)
        
        # Test traditional
        traditional_result = benchmark_traditional(query)
        all_results.append(traditional_result)
        
        # Show comparison
        print(f"\n📊 Results:")
        print(f"V3 Streaming - First token: {streaming_result['first_token']:.2f}s, Total: {streaming_result['total_time']:.1f}s")
        print(f"V2 Traditional - Wait time: {traditional_result['perceived_wait']:.1f}s")
        print(f"⚡ Speedup: {traditional_result['perceived_wait'] / streaming_result['first_token']:.1f}x faster perception")
    
    # Summary
    print("\n" + "=" * 60)
    print("📈 BENCHMARK SUMMARY")
    print("=" * 60)
    
    v3_results = [r for r in all_results if r['approach'] == "V3 Streaming"]
    v2_results = [r for r in all_results if r['approach'] == "V2 Traditional"]
    
    avg_v3_first = sum(r['first_token'] for r in v3_results) / len(v3_results)
    avg_v3_total = sum(r['total_time'] for r in v3_results) / len(v3_results)
    avg_v2_wait = sum(r['perceived_wait'] for r in v2_results) / len(v2_results)
    
    print(f"\nV3 Streaming:")
    print(f"  Average first token: {avg_v3_first:.2f}s")
    print(f"  Average total time: {avg_v3_total:.1f}s")
    
    print(f"\nV2 Traditional:")
    print(f"  Average wait time: {avg_v2_wait:.1f}s")
    
    print(f"\n🎯 User Experience Improvement:")
    print(f"  {avg_v2_wait / avg_v3_first:.1f}x faster perceived response")
    print(f"  {avg_v2_wait - avg_v3_first:.1f}s less waiting")
    
    if avg_v3_first < 1.0:
        print(f"\n✅ SUCCESS: Achieved <1s first token latency!")
    else:
        print(f"\n⚠️  First token latency above 1s target")

if __name__ == "__main__":
    asyncio.run(run_benchmark())