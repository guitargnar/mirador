#!/usr/bin/env python3
"""
Demonstration of Mirador API caching functionality
"""
import time
import requests
import json
from datetime import datetime


API_BASE = "http://localhost:5000/api/v5"
API_KEY = "demo-api-key"  # Replace with your API key

headers = {
    "X-API-Key": API_KEY,
    "Content-Type": "application/json"
}


def demo_query_caching():
    """Demonstrate query caching"""
    print("=== Query Caching Demo ===\n")
    
    query = "What are the top 3 productivity tips for today?"
    
    # First request - cache miss
    print(f"1. First request (cache miss):")
    start = time.time()
    response = requests.post(
        f"{API_BASE}/query",
        headers=headers,
        json={"query": query, "format": "quick"}
    )
    duration1 = time.time() - start
    
    print(f"   Status: {response.status_code}")
    print(f"   Cache: {response.headers.get('X-Cache', 'N/A')}")
    print(f"   Duration: {duration1:.2f}s")
    print(f"   Response: {response.json().get('content', '')[:100]}...\n")
    
    # Second request - cache hit
    print(f"2. Second request (cache hit):")
    start = time.time()
    response = requests.post(
        f"{API_BASE}/query",
        headers=headers,
        json={"query": query, "format": "quick"}
    )
    duration2 = time.time() - start
    
    print(f"   Status: {response.status_code}")
    print(f"   Cache: {response.headers.get('X-Cache', 'N/A')}")
    print(f"   Duration: {duration2:.2f}s")
    print(f"   Speedup: {duration1/duration2:.1f}x faster\n")
    
    # Request with cache disabled
    print(f"3. Request with cache disabled:")
    start = time.time()
    response = requests.post(
        f"{API_BASE}/query",
        headers=headers,
        json={"query": query, "format": "quick", "use_cache": False}
    )
    duration3 = time.time() - start
    
    print(f"   Status: {response.status_code}")
    print(f"   Cache: {response.headers.get('X-Cache', 'N/A')}")
    print(f"   Duration: {duration3:.2f}s\n")


def demo_chain_caching():
    """Demonstrate chain caching"""
    print("=== Chain Caching Demo ===\n")
    
    prompt = "Help me create a morning routine"
    chain_type = "life_optimization"
    
    # Run chain - first time
    print(f"1. Running {chain_type} chain (first time):")
    start = time.time()
    response = requests.post(
        f"{API_BASE}/chains/{chain_type}/run",
        headers=headers,
        json={"prompt": prompt, "format": "summary"}
    )
    duration1 = time.time() - start
    
    print(f"   Status: {response.status_code}")
    print(f"   Cache: {response.headers.get('X-Cache', 'N/A')}")
    print(f"   Duration: {duration1:.2f}s\n")
    
    # Run same chain - cached
    print(f"2. Running same chain (cached):")
    start = time.time()
    response = requests.post(
        f"{API_BASE}/chains/{chain_type}/run",
        headers=headers,
        json={"prompt": prompt, "format": "summary"}
    )
    duration2 = time.time() - start
    
    print(f"   Status: {response.status_code}")
    print(f"   Cache: {response.headers.get('X-Cache', 'N/A')}")
    print(f"   Duration: {duration2:.2f}s")
    print(f"   Speedup: {duration1/duration2:.1f}x faster\n")


def demo_cache_stats():
    """Get and display cache statistics"""
    print("=== Cache Statistics ===\n")
    
    response = requests.get(
        f"{API_BASE}/cache/stats",
        headers=headers
    )
    
    if response.status_code == 200:
        stats = response.json()
        cache_stats = stats.get('cache', {})
        
        print(f"Cache Status:")
        print(f"  Enabled: {cache_stats.get('enabled')}")
        print(f"  Connected: {cache_stats.get('connected')}")
        print(f"  Memory Used: {cache_stats.get('memory_used', 'N/A')}")
        print(f"  Total Keys: {cache_stats.get('total_keys', 0)}")
        print(f"  Overall Hit Rate: {cache_stats.get('hit_rate', 0):.1f}%\n")
        
        # Namespace stats
        namespaces = cache_stats.get('namespaces', {})
        if namespaces:
            print("Namespace Statistics:")
            for ns, ns_stats in namespaces.items():
                print(f"  {ns}:")
                print(f"    Hits: {ns_stats.get('hits', 0)}")
                print(f"    Misses: {ns_stats.get('misses', 0)}")
                print(f"    Hit Rate: {ns_stats.get('hit_rate', 0):.1f}%")
            print()


def demo_cache_warmup():
    """Demonstrate cache warmup"""
    print("=== Cache Warmup Demo ===\n")
    
    print("Triggering cache warmup...")
    response = requests.post(
        f"{API_BASE}/cache/warmup",
        headers=headers
    )
    
    if response.status_code == 200:
        results = response.json().get('results', {})
        print(f"Warmup completed:")
        print(f"  Queries warmed: {results.get('queries_warmed', 0)}")
        print(f"  Models warmed: {results.get('models_warmed', 0)}")
        print(f"  Errors: {results.get('errors', 0)}")
        print(f"  Duration: {results.get('duration', 0):.2f}s\n")


def demo_cache_invalidation():
    """Demonstrate cache invalidation"""
    print("=== Cache Invalidation Demo ===\n")
    
    # Create a cached query
    query = f"Test query at {datetime.now()}"
    print(f"1. Creating cached query: '{query}'")
    response = requests.post(
        f"{API_BASE}/query",
        headers=headers,
        json={"query": query}
    )
    print(f"   Cache: {response.headers.get('X-Cache', 'N/A')}")
    
    # Verify it's cached
    print(f"\n2. Verifying it's cached:")
    response = requests.post(
        f"{API_BASE}/query",
        headers=headers,
        json={"query": query}
    )
    print(f"   Cache: {response.headers.get('X-Cache', 'N/A')}")
    
    # Clear user cache
    print(f"\n3. Clearing user cache...")
    response = requests.delete(
        f"{API_BASE}/query/cache",
        headers=headers
    )
    if response.status_code == 200:
        data = response.json()
        print(f"   Cleared: {data.get('cleared', 0)} entries")
    
    # Verify cache is cleared
    print(f"\n4. Verifying cache is cleared:")
    response = requests.post(
        f"{API_BASE}/query",
        headers=headers,
        json={"query": query}
    )
    print(f"   Cache: {response.headers.get('X-Cache', 'N/A')}\n")


def main():
    """Run all cache demos"""
    print("Mirador API Cache Demonstration")
    print("=" * 50)
    print()
    
    try:
        # Check API health first
        response = requests.get(f"{API_BASE}/health")
        if response.status_code != 200:
            print("Error: API is not available")
            return
        
        # Run demos
        demo_query_caching()
        print("\n" + "=" * 50 + "\n")
        
        demo_chain_caching()
        print("\n" + "=" * 50 + "\n")
        
        demo_cache_stats()
        print("\n" + "=" * 50 + "\n")
        
        # demo_cache_warmup()  # Commented out as it requires admin access
        # print("\n" + "=" * 50 + "\n")
        
        demo_cache_invalidation()
        
        # Final stats
        print("\n" + "=" * 50 + "\n")
        print("Final Cache Statistics:\n")
        demo_cache_stats()
        
    except requests.exceptions.ConnectionError:
        print("Error: Could not connect to API at", API_BASE)
        print("Make sure the Mirador API is running")
    except Exception as e:
        print(f"Error: {e}")


if __name__ == "__main__":
    main()