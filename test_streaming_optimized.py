#!/usr/bin/env python3
"""Optimized streaming test with multiple models and techniques"""

import asyncio
import time
from ollama import AsyncClient
import sys

async def test_model_streaming(model: str, query: str, client: AsyncClient):
    """Test a specific model's streaming performance"""
    
    start_time = time.time()
    first_token_time = None
    response_text = ""
    
    try:
        # Use simpler prompt for faster response
        messages = [
            {"role": "system", "content": "You are a helpful assistant. Be concise."},
            {"role": "user", "content": query}
        ]
        
        async for chunk in await client.chat(
            model=model,
            messages=messages,
            stream=True,
            options={
                "temperature": 0.1,  # Lower temperature for faster, more deterministic responses
                "top_p": 0.9,
                "num_predict": 100,  # Limit response length for testing
            }
        ):
            content = chunk['message']['content']
            
            if first_token_time is None and content.strip():
                first_token_time = time.time() - start_time
            
            response_text += content
            print(content, end="", flush=True)
        
        total_time = time.time() - start_time
        
        return {
            "model": model,
            "first_token": first_token_time,
            "total_time": total_time,
            "response_length": len(response_text),
            "success": first_token_time < 1.0 if first_token_time else False
        }
        
    except Exception as e:
        return {
            "model": model,
            "error": str(e),
            "success": False
        }

async def run_streaming_tests():
    """Test multiple models and configurations"""
    client = AsyncClient()
    
    # Test different models and queries
    test_cases = [
        ("phi3:mini", "List three things"),  # Simplest query
        ("llama3.2:3b", "List three things"),  # Small, fast model
        ("phi3:mini", "What should I focus on today?"),  # More complex
        ("speed_optimizer_phi:latest", "Three priorities"),  # Custom optimized model
    ]
    
    print("🧪 Mirador V3 Streaming Optimization Tests")
    print("=" * 60)
    
    results = []
    
    for model, query in test_cases:
        print(f"\n📋 Test: {model} | Query: '{query}'")
        print("-" * 40)
        
        result = await test_model_streaming(model, query, client)
        results.append(result)
        
        if "error" not in result:
            print(f"\n⏱️  First token: {result['first_token']:.3f}s | "
                  f"Total: {result['total_time']:.2f}s | "
                  f"{'✅ <1s' if result['success'] else '❌ >1s'}")
    
    # Summary
    print("\n" + "=" * 60)
    print("📊 Summary:")
    successful = [r for r in results if r.get('success', False)]
    print(f"✅ Successful (<1s): {len(successful)}/{len(results)}")
    
    if successful:
        best = min(successful, key=lambda x: x['first_token'])
        print(f"🏆 Best: {best['model']} - {best['first_token']:.3f}s")

async def test_pre_warmed_model():
    """Test with pre-warmed model"""
    print("\n🔥 Testing Pre-warmed Model")
    print("=" * 60)
    
    client = AsyncClient()
    model = "phi3:mini"
    
    # Warm up the model
    print("Warming up model...")
    await client.generate(model=model, prompt="Hi", stream=False)
    
    # Now test streaming
    print("Testing streaming with warmed model...")
    result = await test_model_streaming(model, "List three priorities", client)
    
    print(f"\n⏱️  Pre-warmed first token: {result.get('first_token', 'N/A'):.3f}s")

if __name__ == "__main__":
    asyncio.run(run_streaming_tests())
    asyncio.run(test_pre_warmed_model())