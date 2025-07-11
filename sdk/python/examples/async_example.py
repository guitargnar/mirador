#!/usr/bin/env python3
"""
Async usage examples for Mirador Python SDK
"""
import os
import asyncio
from mirador import AsyncMiradorClient, MiradorError


async def basic_async_example(client):
    """Basic async query example"""
    print("=== Basic Async Query ===")
    
    response = await client.query("What are the benefits of async programming?")
    print(f"Response: {response.content}")
    print(f"Execution time: {response.execution_time:.2f}s\n")


async def concurrent_queries_example(client):
    """Example of running multiple queries concurrently"""
    print("=== Concurrent Queries Example ===")
    
    queries = [
        "Explain quantum computing in one paragraph",
        "What are the latest trends in AI?",
        "How does blockchain technology work?",
        "What is the future of renewable energy?"
    ]
    
    # Create tasks for all queries
    tasks = [
        client.query(query, format="summary")
        for query in queries
    ]
    
    # Run all queries concurrently
    print(f"Running {len(queries)} queries concurrently...")
    start_time = asyncio.get_event_loop().time()
    
    responses = await asyncio.gather(*tasks, return_exceptions=True)
    
    end_time = asyncio.get_event_loop().time()
    total_time = end_time - start_time
    
    # Display results
    for i, (query, response) in enumerate(zip(queries, responses)):
        print(f"\nQuery {i+1}: {query}")
        if isinstance(response, Exception):
            print(f"Error: {response}")
        else:
            print(f"Response: {response.content[:100]}...")
    
    print(f"\nTotal time for {len(queries)} queries: {total_time:.2f}s")
    print(f"Average time per query: {total_time/len(queries):.2f}s\n")


async def async_streaming_example(client):
    """Example of async streaming"""
    print("=== Async Streaming Example ===")
    print("Streaming response...\n")
    
    try:
        async for token in client.stream("Write a short story about AI and humans working together"):
            print(token.content, end="", flush=True)
        
        print("\n\nStreaming complete!\n")
        
    except Exception as e:
        print(f"\nStreaming error: {e}")


async def chain_operations_example(client):
    """Example of chain operations with async"""
    print("=== Async Chain Operations ===")
    
    # List available chains
    chains = await client.chains.list()
    print(f"Available chains: {len(chains)}")
    for chain in chains[:3]:
        print(f"  - {chain.type}: {chain.description}")
    
    # Run multiple chains concurrently
    print("\nRunning multiple chains concurrently...")
    
    chain_tasks = [
        client.chains.run("technical_mastery", "How to optimize Python code?", format="quick"),
        client.chains.run("creative_breakthrough", "Ideas for a sci-fi novel", format="quick"),
        client.chains.run("business_acceleration", "Startup growth strategies", format="quick")
    ]
    
    results = await asyncio.gather(*chain_tasks)
    
    for i, result in enumerate(results):
        print(f"\nChain {i+1} result:")
        print(result.summary or result.results[0].get("output", "")[:100] + "...")


async def model_warming_example(client):
    """Example of pre-warming models"""
    print("=== Model Pre-warming Example ===")
    
    models_to_warm = [
        "matthew_context_provider_v6",
        "universal_strategy_architect",
        "creative_catalyst"
    ]
    
    print(f"Pre-warming {len(models_to_warm)} models...")
    results = await client.models.warm(models_to_warm)
    
    for model, success in results.items():
        status = "✓" if success else "✗"
        print(f"  {status} {model}")
    
    print("\nTesting warmed model performance...")
    start_time = asyncio.get_event_loop().time()
    
    result = await client.models.test(
        models_to_warm[0],
        "Quick test"
    )
    
    end_time = asyncio.get_event_loop().time()
    print(f"First response time: {(end_time - start_time)*1000:.0f}ms")


async def error_handling_example(client):
    """Example of error handling in async context"""
    print("=== Error Handling Example ===")
    
    # Test various error scenarios
    test_cases = [
        ("Invalid model", lambda: client.models.get("non_existent_model")),
        ("Invalid chain", lambda: client.chains.run("invalid_chain", "test")),
        ("Rate limit simulation", lambda: client.query("test" * 1000)),  # Very long query
    ]
    
    for name, test_func in test_cases:
        try:
            print(f"\nTesting: {name}")
            await test_func()
            print("Success (unexpected)")
        except MiradorError as e:
            print(f"Caught error: {type(e).__name__}: {e.message}")


async def main():
    # Initialize async client
    api_key = os.getenv("MIRADOR_API_KEY", "your-api-key-here")
    base_url = os.getenv("MIRADOR_BASE_URL", "http://localhost:5000")
    
    # Use async context manager
    async with AsyncMiradorClient(api_key=api_key, base_url=base_url) as client:
        # Check health first
        try:
            health = await client.health_check()
            print(f"API Health: {health.get('status', 'unknown')}\n")
        except Exception as e:
            print(f"Health check failed: {e}\n")
        
        # Run examples
        await basic_async_example(client)
        print("="*60 + "\n")
        
        await concurrent_queries_example(client)
        print("="*60 + "\n")
        
        await async_streaming_example(client)
        print("="*60 + "\n")
        
        await chain_operations_example(client)
        print("="*60 + "\n")
        
        await model_warming_example(client)
        print("="*60 + "\n")
        
        await error_handling_example(client)


if __name__ == "__main__":
    # Run the async main function
    asyncio.run(main())