#!/usr/bin/env python3
"""Quick test to verify <1s streaming latency with Ollama"""

import asyncio
import time
from ollama import AsyncClient

async def test_streaming_latency():
    """Test streaming with real Ollama models to verify <1s first token"""
    client = AsyncClient()
    
    query = "What are the three most important things I should focus on today?"
    model = "phi3:mini"  # Fast model for quick response
    
    print(f"🚀 Testing streaming with {model}")
    print(f"📝 Query: {query}")
    print("=" * 60)
    
    start_time = time.time()
    first_token_time = None
    response_text = ""
    
    try:
        # Stream the response
        async for chunk in await client.chat(
            model=model,
            messages=[{"role": "user", "content": query}],
            stream=True
        ):
            content = chunk['message']['content']
            
            # Record first token time
            if first_token_time is None and content.strip():
                first_token_time = time.time() - start_time
                print(f"\n⚡ First token latency: {first_token_time:.3f}s")
                print("\n🤖 Response:")
                print("-" * 40)
            
            # Print the content as it streams
            print(content, end="", flush=True)
            response_text += content
        
        total_time = time.time() - start_time
        
        print("\n" + "-" * 40)
        print(f"\n📊 Performance Metrics:")
        print(f"  - First token: {first_token_time:.3f}s")
        print(f"  - Total time: {total_time:.2f}s")
        print(f"  - Response length: {len(response_text)} chars")
        print(f"  - ✅ Achieved <1s: {'YES' if first_token_time < 1.0 else 'NO'}")
        
    except Exception as e:
        print(f"\n❌ Error: {e}")

if __name__ == "__main__":
    print("🧪 Mirador V3 Streaming Latency Test")
    print("=" * 60)
    asyncio.run(test_streaming_latency())