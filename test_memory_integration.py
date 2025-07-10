#!/usr/bin/env python3
"""Test script for memory system integration with streaming"""

import asyncio
import sys
from pathlib import Path

# Add project to path
sys.path.insert(0, str(Path(__file__).parent))

from src.streaming.enhanced_orchestrator import EnhancedStreamingOrchestrator
from src.streaming.cli import get_color_for_confidence, COLORS

async def stream_with_memory(orchestrator, query):
    """Stream a response with memory context"""
    print(f"\n🤖 Query: {query}")
    print("=" * 60)
    
    response = ""
    async for token in orchestrator.process(query):
        color = get_color_for_confidence(token.confidence)
        print(f"{color}{token.content}{COLORS['RESET']}", end="", flush=True)
        response += token.content
    
    print("\n")
    return response

async def test_memory_context():
    """Test context persistence and retrieval"""
    print("🧪 Testing Memory Context Persistence")
    print("=" * 60)
    
    # Create orchestrator with memory enabled
    orchestrator = EnhancedStreamingOrchestrator(
        use_dynamic_models=True,
        use_memory=True
    )
    
    # First query - establish context
    print("\n📝 Establishing Context...")
    await stream_with_memory(
        orchestrator,
        "My name is Alex and I work at TechCorp as a software engineer. I'm interested in machine learning."
    )
    
    # Provide feedback
    await orchestrator.provide_feedback(5, "Great response, remembered my details")
    
    await asyncio.sleep(2)
    
    # Second query - test context retrieval
    print("\n🔍 Testing Context Retrieval...")
    await stream_with_memory(
        orchestrator,
        "What field do I work in and what am I interested in?"
    )
    
    # Third query - test continuation
    print("\n🔗 Testing Conversation Continuation...")
    await stream_with_memory(
        orchestrator,
        "Can you suggest some resources for someone in my position?"
    )
    
    # Get session summary
    summary = orchestrator.get_session_summary()
    print("\n📊 Session Summary:")
    print(f"- Session ID: {summary['session_id']}")
    print(f"- Conversations: {summary.get('conversation_count', 0)}")
    print(f"- Top Topics: {summary.get('top_topics', [])}")

async def test_learning_from_feedback():
    """Test learning from user feedback"""
    print("\n🧪 Testing Learning from Feedback")
    print("=" * 60)
    
    orchestrator = EnhancedStreamingOrchestrator(
        use_dynamic_models=True,
        use_memory=True
    )
    
    # Test queries with feedback
    test_cases = [
        ("Explain quantum computing in simple terms", 4, "Good explanation"),
        ("Write a Python function for binary search", 5, "Perfect code example"),
        ("What's the weather today?", 2, "Can't provide real-time weather"),
        ("Explain recursion with an example", 5, "Great explanation with code")
    ]
    
    for query, rating, feedback in test_cases:
        print(f"\n📝 Query: {query}")
        await stream_with_memory(orchestrator, query)
        await orchestrator.provide_feedback(rating, feedback)
        print(f"✅ Feedback: {rating}/5 - {feedback}")
        await asyncio.sleep(1)
    
    # Get performance summary
    perf_summary = orchestrator.get_performance_summary()
    print("\n📊 Performance Summary:")
    print(f"- Model Scores: {perf_summary.get('model_scores', {})}")
    print(f"- Best Models by Type: {perf_summary.get('best_models_by_type', {})}")

async def test_memory_disabled():
    """Test with memory disabled for comparison"""
    print("\n🧪 Testing Without Memory (Baseline)")
    print("=" * 60)
    
    orchestrator = EnhancedStreamingOrchestrator(
        use_dynamic_models=True,
        use_memory=False  # Memory disabled
    )
    
    # Same queries as context test
    await stream_with_memory(
        orchestrator,
        "My name is Alex and I work at TechCorp as a software engineer."
    )
    
    await asyncio.sleep(2)
    
    await stream_with_memory(
        orchestrator,
        "What field do I work in?"  # Should not remember
    )
    
    summary = orchestrator.get_session_summary()
    print(f"\n📊 Memory Enabled: {summary.get('memory_enabled', True)}")

async def test_conversation_search():
    """Test searching through conversation history"""
    print("\n🧪 Testing Conversation Search")
    print("=" * 60)
    
    orchestrator = EnhancedStreamingOrchestrator(
        use_dynamic_models=True,
        use_memory=True
    )
    
    # Create some conversations
    queries = [
        "How do I implement a neural network in PyTorch?",
        "What are the best practices for React hooks?",
        "Explain the difference between TCP and UDP",
        "How do I optimize database queries in PostgreSQL?"
    ]
    
    for query in queries:
        print(f"\n📝 Creating conversation: {query[:50]}...")
        await stream_with_memory(orchestrator, query)
        await asyncio.sleep(1)
    
    # Search conversations
    if orchestrator.db:
        print("\n🔍 Searching for 'database' in conversations...")
        results = orchestrator.db.search_conversations("database", limit=5)
        for conv in results:
            print(f"- Found: {conv.query[:60]}...")

async def main():
    """Run all tests"""
    print("🚀 Mirador V3 Memory System Integration Tests")
    print("=" * 60)
    
    # Test 1: Memory context
    await test_memory_context()
    
    # Test 2: Learning from feedback
    await test_learning_from_feedback()
    
    # Test 3: Without memory (baseline)
    await test_memory_disabled()
    
    # Test 4: Conversation search
    await test_conversation_search()
    
    print("\n✅ All tests completed!")
    print("\n📁 Memory database location: data/mirador_memory.db")

if __name__ == "__main__":
    asyncio.run(main())