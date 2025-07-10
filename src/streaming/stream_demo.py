#!/usr/bin/env python3
"""
Mirador Streaming Demo - Proof of Concept
Shows how streaming transforms the user experience
"""

import asyncio
import time
from typing import AsyncGenerator, Dict, Any
import random

class StreamToken:
    """Represents a token in the streaming response"""
    def __init__(self, content: str, confidence: float = 1.0, metadata: Dict[str, Any] = None):
        self.content = content
        self.confidence = confidence
        self.metadata = metadata or {}
        self.timestamp = time.time()

class StreamingOrchestrator:
    """Orchestrates multiple models with progressive enhancement"""
    
    def __init__(self):
        self.stages = [
            {
                "name": "quick_response",
                "model": "phi-3-mini",
                "max_tokens": 50,
                "confidence": 0.6,
                "emoji": "🚀"
            },
            {
                "name": "deep_analysis", 
                "model": "gemma2:9b",
                "max_tokens": 200,
                "confidence": 0.8,
                "emoji": "🧠"
            },
            {
                "name": "final_synthesis",
                "model": "command-r",
                "max_tokens": 300,
                "confidence": 0.95,
                "emoji": "✨"
            }
        ]
    
    async def process(self, query: str) -> AsyncGenerator[StreamToken, None]:
        """Process query through progressive stages"""
        
        # Immediate acknowledgment
        yield StreamToken("🤔 Processing your query...\n", 0.1)
        await asyncio.sleep(0.1)
        
        # Show what we understood
        yield StreamToken(f"📝 Query: '{query}'\n", 0.2)
        await asyncio.sleep(0.2)
        
        # Stage-by-stage processing
        accumulated_response = ""
        
        for stage in self.stages:
            # Stage announcement
            yield StreamToken(
                f"\n{stage['emoji']} {stage['name'].replace('_', ' ').title()}:\n",
                stage['confidence'] - 0.1
            )
            await asyncio.sleep(0.3)
            
            # Simulate model processing with realistic streaming
            response = await self._simulate_model_response(
                query, 
                stage['model'],
                stage['max_tokens']
            )
            
            async for token in response:
                yield StreamToken(
                    token,
                    stage['confidence'],
                    {"stage": stage['name'], "model": stage['model']}
                )
                accumulated_response += token
            
            yield StreamToken("\n", stage['confidence'])
        
        # Final summary
        yield StreamToken(
            "\n✅ Analysis complete!\n",
            1.0,
            {"final": True, "total_tokens": len(accumulated_response.split())}
        )
    
    async def _simulate_model_response(self, query: str, model: str, max_tokens: int):
        """Simulate realistic model streaming"""
        
        # Sample responses based on query type
        if "optimize" in query.lower() or "budget" in query.lower():
            responses = {
                "phi-3-mini": "Based on your query, I'll help you optimize your budget. Quick analysis shows potential savings in subscriptions.",
                "gemma2:9b": "Analyzing your financial patterns: 1) Recurring subscriptions total $247/month, 2) Dining out averages $430/month, 3) Unused gym membership costs $45/month. I recommend canceling 3 unused subscriptions for immediate $67/month savings.",
                "command-r": "Here's your personalized optimization plan: Cancel Spotify family (use individual), pause Netflix (summer activities), negotiate internet bill (competitor offers $20 less), meal prep Sundays (save $200/month), use gym or cancel membership. Total potential savings: $312/month."
            }
        else:
            responses = {
                "phi-3-mini": f"I understand you're asking about {query}. Let me analyze this for you.",
                "gemma2:9b": f"Looking deeper into your question about {query}, I can see several important aspects to consider. This involves multiple factors that we should examine carefully.",
                "command-r": f"Based on comprehensive analysis of {query}, here are my recommendations: First, consider the immediate implications. Second, evaluate long-term impact. Third, implement changes gradually. This approach ensures sustainable results."
            }
        
        response = responses.get(model, f"Processing {query} with {model}")
        words = response.split()
        
        # Stream words with realistic delays
        for i, word in enumerate(words):
            # Add natural pauses
            if word.endswith('.'):
                delay = random.uniform(0.1, 0.2)
            elif word.endswith(','):
                delay = random.uniform(0.05, 0.1)
            else:
                delay = random.uniform(0.02, 0.05)
            
            yield word + " "
            await asyncio.sleep(delay)
            
            # Occasional thinking pauses
            if i % 10 == 0 and i > 0:
                await asyncio.sleep(0.1)

async def main():
    """Demo the streaming experience"""
    
    print("🔮 Mirador Streaming Demo\n")
    print("=" * 50)
    
    orchestrator = StreamingOrchestrator()
    
    # Example queries
    queries = [
        "How can I optimize my monthly budget?",
        "What should I focus on today?",
        "Analyze my career trajectory"
    ]
    
    for query in queries[:1]:  # Demo with first query
        print(f"\n🎯 Processing: {query}\n")
        print("-" * 50)
        
        start_time = time.time()
        total_tokens = 0
        
        async for token in orchestrator.process(query):
            # Display token with confidence indicator
            if token.confidence < 0.7:
                confidence_indicator = "○○○"
            elif token.confidence < 0.9:
                confidence_indicator = "●●○"
            else:
                confidence_indicator = "●●●"
            
            # Print without newline for streaming effect
            print(token.content, end="", flush=True)
            
            # Track metrics
            if token.content.strip():
                total_tokens += len(token.content.split())
        
        elapsed = time.time() - start_time
        print(f"\n📊 Metrics: {elapsed:.1f}s total, {total_tokens} tokens")
        print(f"📈 First token: <0.2s (vs 45s batch)")
        print("-" * 50)

def run_demo():
    """Run the streaming demo"""
    asyncio.run(main())

if __name__ == "__main__":
    run_demo()