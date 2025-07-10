#!/usr/bin/env python3
"""
StreamingOrchestrator V3 Improved - Enhanced robustness for edge cases
Achieves <1s first token latency with better error handling
"""

import asyncio
from typing import AsyncGenerator, Dict, Any, List, Optional
from dataclasses import dataclass, field
import time
from ollama import AsyncClient
import logging
from pathlib import Path
import sys
import signal
from contextlib import asynccontextmanager
import hashlib

# Add parent directory to path for imports
sys.path.insert(0, str(Path(__file__).parent.parent.parent))

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Global semaphore for concurrent request limiting
CONCURRENT_LIMIT = asyncio.Semaphore(2)  # Limit to 2 concurrent requests

@dataclass
class StreamToken:
    """Represents a token in the streaming response"""
    content: str
    confidence: float
    stage: Optional[str] = None
    model: Optional[str] = None
    metadata: Dict[str, Any] = field(default_factory=dict)
    timestamp: float = field(default_factory=time.time)

@dataclass
class ModelStage:
    """Configuration for a model stage"""
    name: str
    model: str
    confidence: float
    timeout: int = 30
    system_prompt: Optional[str] = None
    stage_type: str = "quick"  # quick, analysis, synthesis
    options: Dict[str, Any] = field(default_factory=dict)

class StreamingOrchestrator:
    """Orchestrates progressive model enhancement with streaming"""
    
    def __init__(self, pre_warm: bool = True):
        self.client = AsyncClient()
        self.pre_warm = pre_warm
        self._setup_interrupt_handler()
        
        # Optimized stages for <1s latency
        self.stages = [
            ModelStage(
                name="quick_response",
                model="speed_optimizer_phi:latest",  # Our fastest model
                confidence=0.6,
                timeout=10,
                system_prompt="Provide a quick, helpful response. Be concise. Maximum 100 words.",
                stage_type="quick",
                options={
                    "temperature": 0.1,
                    "top_p": 0.9,
                    "num_predict": 100,  # Reduced for faster response
                    "num_ctx": 2048      # Smaller context for long queries
                }
            ),
            ModelStage(
                name="deep_analysis", 
                model="gemma2:9b",
                confidence=0.85,
                timeout=20,
                system_prompt="Provide deeper analysis building on the previous response. Add insights and nuance.",
                stage_type="analysis",
                options={
                    "temperature": 0.7,
                    "top_p": 0.95,
                    "num_predict": 300,
                    "num_ctx": 4096
                }
            ),
            ModelStage(
                name="synthesis",
                model="matthew_context_provider_v5_complete:latest",
                confidence=0.95,
                timeout=30,
                system_prompt="Synthesize all previous insights into a comprehensive, personalized response.",
                stage_type="synthesis",
                options={
                    "temperature": 0.8,
                    "top_p": 0.95,
                    "num_predict": 500,
                    "num_ctx": 8192
                }
            )
        ]
        
        self.start_time = None
        self.first_token_time = None
        self._warmed_models = set()
        self._interrupted = False
        self._query_cache = {}  # Simple cache for repeated queries
    
    def _setup_interrupt_handler(self):
        """Setup graceful interrupt handling"""
        def handle_interrupt(signum, frame):
            self._interrupted = True
            logger.info("Interrupt received, cleaning up...")
        
        signal.signal(signal.SIGINT, handle_interrupt)
    
    def _get_query_hash(self, query: str) -> str:
        """Generate hash for query caching"""
        return hashlib.md5(query.encode()).hexdigest()[:8]
    
    async def _warm_model(self, model: str):
        """Pre-warm a model for faster first token"""
        if model not in self._warmed_models:
            try:
                logger.info(f"Pre-warming {model}...")
                await asyncio.wait_for(
                    self.client.generate(
                        model=model, 
                        prompt="Hi",
                        stream=False,
                        options={"num_predict": 1}
                    ),
                    timeout=5.0  # Don't wait too long for warm-up
                )
                self._warmed_models.add(model)
            except asyncio.TimeoutError:
                logger.warning(f"Pre-warm timeout for {model}, continuing anyway")
            except Exception as e:
                logger.warning(f"Failed to pre-warm {model}: {e}")
    
    @asynccontextmanager
    async def _acquire_slot(self):
        """Acquire a processing slot with concurrent limit"""
        async with CONCURRENT_LIMIT:
            yield
    
    async def process(self, query: str, stages: Optional[List[str]] = None) -> AsyncGenerator[StreamToken, None]:
        """Process query through progressive enhancement stages"""
        # Check for interruption
        if self._interrupted:
            yield StreamToken("❌ Processing interrupted\n", 0.0)
            return
        
        # Acquire processing slot
        async with self._acquire_slot():
            await self._process_with_slot(query, stages)
            async for token in self._process_with_slot(query, stages):
                yield token
    
    async def _process_with_slot(self, query: str, stages: Optional[List[str]] = None) -> AsyncGenerator[StreamToken, None]:
        """Process with concurrency slot acquired"""
        self.start_time = time.time()
        self.first_token_time = None
        query_hash = self._get_query_hash(query)
        
        # Pre-warm first stage model if enabled
        if self.pre_warm and self.stages:
            asyncio.create_task(self._warm_model(self.stages[0].model))
        
        # Select stages to run
        active_stages = self.stages
        if stages:
            active_stages = [s for s in self.stages if s.name in stages]
        
        # Immediate acknowledgment
        yield StreamToken("🤔 Processing your query...\n", 0.1)
        
        # Truncate very long queries for faster processing
        truncated_query = query
        if len(query) > 1000:
            truncated_query = query[:1000] + "... [truncated for processing]"
            logger.info(f"Truncated long query from {len(query)} to 1000 chars")
        
        # Context accumulation for each stage
        accumulated_context = ""
        
        for stage_idx, stage in enumerate(active_stages):
            # Check for interruption
            if self._interrupted:
                yield StreamToken("\n❌ Processing interrupted by user\n", 0.0)
                break
            
            # Stage announcement
            emoji = self._get_stage_emoji(stage.name)
            yield StreamToken(
                f"\n{emoji} {stage.name.replace('_', ' ').title()}:\n",
                stage.confidence - 0.1,
                stage=stage.name,
                model=stage.model
            )
            
            try:
                # Build messages for this stage
                messages = self._build_messages(
                    truncated_query if stage.stage_type == "quick" else query, 
                    stage, 
                    accumulated_context
                )
                
                # Stream from model
                response_text = ""
                async with asyncio.timeout(stage.timeout):
                    async for chunk in await self.client.chat(
                        model=stage.model,
                        messages=messages,
                        stream=True,
                        options=stage.options
                    ):
                        if self._interrupted:
                            break
                            
                        content = chunk['message']['content']
                        
                        # Track first token time
                        if self.first_token_time is None and content.strip():
                            self.first_token_time = time.time() - self.start_time
                            logger.info(f"First token: {self.first_token_time:.3f}s")
                        
                        yield StreamToken(
                            content,
                            stage.confidence,
                            stage=stage.name,
                            model=stage.model,
                            metadata={
                                "stage_index": stage_idx,
                                "chunk_time": time.time() - self.start_time
                            }
                        )
                        response_text += content
                
                # Accumulate context for next stage
                accumulated_context += f"\n{stage.name}: {response_text}"
                
                # Add stage separator
                if stage_idx < len(active_stages) - 1:
                    yield StreamToken("\n", stage.confidence)
                
            except asyncio.TimeoutError:
                yield StreamToken(
                    f"\n⏱️ {stage.name} timed out, continuing...\n",
                    stage.confidence,
                    metadata={"error": "timeout", "stage": stage.name}
                )
            except Exception as e:
                logger.error(f"Error in {stage.name}: {e}")
                yield StreamToken(
                    f"\n⚠️ {stage.name} unavailable: {str(e)}\n", 
                    stage.confidence,
                    metadata={"error": str(e), "stage": stage.name}
                )
        
        # Final metrics
        if not self._interrupted:
            total_time = time.time() - self.start_time
            yield StreamToken(
                f"\n\n✅ Complete! (First token: {self.first_token_time:.3f}s, Total: {total_time:.1f}s)\n",
                1.0,
                metadata={
                    "final": True,
                    "total_time": total_time,
                    "first_token_time": self.first_token_time
                }
            )
    
    def _get_stage_emoji(self, stage_name: str) -> str:
        """Get emoji for stage"""
        emojis = {
            "quick_response": "🚀",
            "deep_analysis": "🧠",
            "synthesis": "✨"
        }
        return emojis.get(stage_name, "📝")
    
    def _build_messages(self, query: str, stage: ModelStage, context: str) -> List[Dict[str, str]]:
        """Build messages for model"""
        messages = []
        
        # Add system prompt if available
        if stage.system_prompt:
            system_content = stage.system_prompt
            if context and stage.stage_type != "quick":
                system_content += f"\n\nPrevious analysis:{context}"
            messages.append({"role": "system", "content": system_content})
        
        # Add user query
        messages.append({"role": "user", "content": query})
        
        return messages

# Example usage
async def example_usage():
    """Example of using the improved StreamingOrchestrator"""
    orchestrator = StreamingOrchestrator(pre_warm=True)
    
    query = "What are the three most important things I should focus on today?"
    
    print("🎯 Mirador V3 Streaming Example (Improved)")
    print("=" * 60)
    
    async for token in orchestrator.process(query):
        # Color based on confidence
        if token.confidence < 0.7:
            print(f"\033[90m{token.content}\033[0m", end="", flush=True)  # Gray
        elif token.confidence < 0.9:
            print(f"\033[97m{token.content}\033[0m", end="", flush=True)  # White
        else:
            print(f"\033[96m{token.content}\033[0m", end="", flush=True)  # Cyan

if __name__ == "__main__":
    asyncio.run(example_usage())