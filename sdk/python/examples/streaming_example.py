#!/usr/bin/env python3
"""
Streaming examples for Mirador Python SDK
"""
import os
import sys
from mirador import MiradorClient, StreamingError


def sse_streaming_example(client):
    """Example of Server-Sent Events streaming"""
    print("=== SSE Streaming Example ===")
    print("Streaming response...\n")
    
    try:
        # Stream a response
        for token in client.stream("Explain the concept of machine learning in simple terms"):
            # Color code based on confidence
            if token.confidence < 0.7:
                # Low confidence - gray
                print(f"\033[90m{token.content}\033[0m", end="", flush=True)
            elif token.confidence < 0.9:
                # Medium confidence - white
                print(f"\033[97m{token.content}\033[0m", end="", flush=True)
            else:
                # High confidence - cyan
                print(f"\033[96m{token.content}\033[0m", end="", flush=True)
        
        print("\n\nStreaming complete!\n")
        
    except StreamingError as e:
        print(f"\nStreaming error: {e.message}")
    except KeyboardInterrupt:
        print("\n\nStreaming interrupted by user")


def websocket_streaming_example(client):
    """Example of WebSocket streaming"""
    print("=== WebSocket Streaming Example ===")
    print("Connecting to WebSocket...\n")
    
    # Define callbacks
    def on_message(token):
        print(f"[{token.stage or 'default'}] {token.content}", end="", flush=True)
    
    def on_error(error):
        print(f"\nWebSocket error: {error}")
    
    def on_close():
        print("\nWebSocket connection closed")
    
    try:
        # Create WebSocket connection with callbacks
        with client.websocket(
            on_message=on_message,
            on_error=on_error,
            on_close=on_close
        ) as ws:
            # Send multiple queries
            queries = [
                "What's the weather like today?",
                "Tell me a short joke",
                "Give me a productivity tip"
            ]
            
            for query in queries:
                print(f"\nSending query: {query}")
                ws.send_query(query)
                
                # Wait a bit between queries
                import time
                time.sleep(3)
            
            # Keep connection open for a bit to receive all responses
            time.sleep(2)
            
    except Exception as e:
        print(f"WebSocket error: {e}")


def streaming_with_session_example(client):
    """Example of streaming with session context"""
    print("=== Streaming with Session Example ===")
    
    # Create a session
    session = client.sessions.create(name="Streaming Session")
    print(f"Created session: {session.id}\n")
    
    # Stream multiple queries in the same session
    queries = [
        "I want to learn a new programming language",
        "Which one would you recommend for AI development?",
        "What resources should I use to get started?"
    ]
    
    for i, query in enumerate(queries):
        print(f"\nQuery {i+1}: {query}")
        print("-" * 50)
        
        try:
            for token in client.stream(query, session_id=session.id):
                print(token.content, end="", flush=True)
            print("\n")
        except StreamingError as e:
            print(f"\nError: {e.message}")
            break


def main():
    # Initialize client
    api_key = os.getenv("MIRADOR_API_KEY", "your-api-key-here")
    base_url = os.getenv("MIRADOR_BASE_URL", "http://localhost:5000")
    
    client = MiradorClient(api_key=api_key, base_url=base_url)
    
    try:
        # Run examples
        sse_streaming_example(client)
        print("\n" + "="*60 + "\n")
        
        websocket_streaming_example(client)
        print("\n" + "="*60 + "\n")
        
        streaming_with_session_example(client)
        
    finally:
        client.close()


if __name__ == "__main__":
    main()