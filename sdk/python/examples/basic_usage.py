#!/usr/bin/env python3
"""
Basic usage examples for Mirador Python SDK
"""
import os
from mirador import MiradorClient, MiradorError


def main():
    # Initialize client with API key
    # You can also use environment variable: MIRADOR_API_KEY
    api_key = os.getenv("MIRADOR_API_KEY", "your-api-key-here")
    base_url = os.getenv("MIRADOR_BASE_URL", "http://localhost:5000")
    
    client = MiradorClient(api_key=api_key, base_url=base_url)
    
    try:
        # Example 1: Simple query
        print("=== Example 1: Simple Query ===")
        response = client.query("What are the three most important things I should focus on today?")
        print(f"Response: {response.content}")
        print(f"Execution time: {response.execution_time:.2f}s\n")
        
        # Example 2: Using a specific chain
        print("=== Example 2: Using Specific Chain ===")
        response = client.chains.run(
            chain_type="life_optimization",
            prompt="How can I improve my work-life balance?",
            format="summary"
        )
        print(f"Summary: {response.summary}\n")
        
        # Example 3: List available models
        print("=== Example 3: Available Models ===")
        models = client.models.list()
        print(f"Found {len(models)} models:")
        for model in models[:5]:  # Show first 5
            print(f"  - {model.name}: {model.type}")
        print("...\n")
        
        # Example 4: Create and use a session
        print("=== Example 4: Session Management ===")
        session = client.sessions.create(name="Planning Session")
        print(f"Created session: {session.id}")
        
        # Continue conversation in same session
        response1 = client.query(
            "I want to start a new project",
            session_id=session.id
        )
        print(f"Response 1: {response1.content[:100]}...")
        
        response2 = client.query(
            "What should be my first three steps?",
            session_id=session.id
        )
        print(f"Response 2: {response2.content[:100]}...")
        
        # Get session history
        history = client.sessions.get_history(session.id)
        print(f"Session has {len(history)} interactions\n")
        
        # Example 5: Test a specific model
        print("=== Example 5: Test Specific Model ===")
        result = client.models.test(
            "matthew_context_provider_v6",
            "Give me a quick tip for productivity"
        )
        print(f"Model output: {result.get('output', '')}\n")
        
    except MiradorError as e:
        print(f"Error: {e.message}")
    
    finally:
        # Close client
        client.close()


if __name__ == "__main__":
    main()