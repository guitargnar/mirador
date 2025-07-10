"""
Enhanced Streaming Orchestrator with Memory Integration
Combines streaming responses with context persistence and learning
"""

import asyncio
import logging
import time
from typing import AsyncIterator, Optional, List, Dict, Any
from dataclasses import dataclass
from ollama import AsyncClient

from .orchestrator import StreamingOrchestrator, StreamToken, ModelStage
from ..models.registry import ModelRegistry
from ..memory.database import MemoryDatabase, Conversation
from ..memory.context import ContextManager
from ..memory.learning import FeedbackLearner

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class EnhancedStreamingOrchestrator(StreamingOrchestrator):
    """Enhanced orchestrator with memory and learning capabilities"""
    
    def __init__(
        self, 
        use_dynamic_models: bool = True,
        use_memory: bool = True,
        session_id: Optional[str] = None,
        pre_warm: bool = True
    ):
        super().__init__(pre_warm=pre_warm)
        
        self.use_dynamic_models = use_dynamic_models
        self.use_memory = use_memory
        self.registry = None  # Will be set if use_dynamic_models is True
        self.default_stages = self.stages.copy()  # Save default stages
        if self.use_memory:
            self.db = MemoryDatabase()
            self.context_manager = ContextManager(self.db)
            self.feedback_learner = FeedbackLearner(self.db)
            
            # Set session ID
            if session_id:
                self.context_manager.current_session = session_id
            self.session_id = self.context_manager.current_session
        else:
            self.db = None
            self.context_manager = None
            self.feedback_learner = None
            self.session_id = f"session_{int(time.time())}"
            
        # Track current conversation
        self.current_conversation: Optional[Conversation] = None
        self.conversation_start_time: float = 0
        self.full_response: str = ""
        
    async def process(self, query: str) -> AsyncIterator[StreamToken]:
        """Process query with memory-enhanced context"""
        self.conversation_start_time = time.time()
        self.full_response = ""
        enhanced_query = query
        
        # Get relevant context if memory is enabled
        context_data = {}
        if self.use_memory and self.context_manager:
            # Detect query type
            query_type = self.registry.analyze_query_type(query) if self.registry else None
            
            # Get relevant context
            context_data = self.context_manager.get_relevant_context(
                query, 
                query_type=query_type
            )
            
            # Check if we should use enhanced context
            if self.feedback_learner.should_use_enhanced_context(query):
                enhanced_query = self.context_manager.build_enhanced_prompt(
                    query, 
                    context_data
                )
                logger.info("Using enhanced context for query")
                
        # Build stages (potentially influenced by feedback learner)
        stages = await self._build_enhanced_stages(query, context_data)
        
        # Create conversation record
        if self.use_memory:
            self.current_conversation = Conversation(
                session_id=self.session_id,
                query=query,
                query_type=self.registry.analyze_query_type(query) if self.registry else None,
                models_used=[],
                performance_metrics={},
                context_before=str(context_data.get('query_context', {}))
            )
            
        # Process through stages
        accumulated_response = ""
        stage_outputs = []
        models_used = []
        
        for stage in stages:
            try:
                stage_response = ""
                stage_start = time.time()
                first_token_time = None
                
                logger.info(f"Starting {stage.name} with {stage.model}")
                models_used.append(stage.model)
                
                # Build stage-specific prompt
                if accumulated_response:
                    stage_prompt = f"{stage.system_prompt}\n\nPrevious context:\n{accumulated_response}\n\nUser query: {enhanced_query}"
                else:
                    stage_prompt = f"{stage.system_prompt}\n\n{enhanced_query}"
                
                # Stream from model
                stream = await self.client.chat(
                    model=stage.model,
                    messages=[{"role": "user", "content": stage_prompt}],
                    stream=True
                )
                
                async for chunk in stream:
                    if first_token_time is None:
                        first_token_time = time.time() - stage_start
                        
                    content = chunk['message']['content']
                    stage_response += content
                    self.full_response += content
                    
                    yield StreamToken(
                        content=content,
                        confidence=stage.confidence,
                        stage=stage.name,
                        model=stage.model
                    )
                    
                # Record stage performance
                stage_time = time.time() - stage_start
                logger.info(f"Stage {stage.name} completed in {stage_time:.2f}s")
                
                if self.current_conversation:
                    self.current_conversation.performance_metrics[f"{stage.name}_latency"] = stage_time
                    self.current_conversation.performance_metrics[f"{stage.name}_first_token"] = first_token_time
                    
                accumulated_response = stage_response
                stage_outputs.append({
                    'stage': stage.name,
                    'response': stage_response,
                    'time': stage_time
                })
                
            except asyncio.TimeoutError:
                logger.warning(f"Stage {stage.name} timed out")
                if accumulated_response:
                    break
            except Exception as e:
                logger.error(f"Error in stage {stage.name}: {e}")
                if accumulated_response:
                    break
                    
        # Save conversation to memory
        if self.use_memory and self.current_conversation:
            self.current_conversation.response = self.full_response
            self.current_conversation.models_used = models_used
            self.current_conversation.performance_metrics['total_time'] = time.time() - self.conversation_start_time
            
            # Extract facts from response
            extracted_facts = self.context_manager.extract_facts_from_response(
                query, 
                self.full_response
            )
            
            # Save everything
            self.context_manager.save_conversation_context(
                self.current_conversation,
                extracted_facts
            )
            
    async def _build_enhanced_stages(
        self, 
        query: str, 
        context_data: Dict[str, Any]
    ) -> List[ModelStage]:
        """Build stages with feedback learning influence"""
        
        # Start with dynamic stages if enabled
        if self.use_dynamic_models:
            stages = await self._build_stages(query)
        else:
            stages = self.default_stages.copy()
            
        # If we have feedback learning, adjust model selection
        if self.use_memory and self.feedback_learner and self.registry:
            query_type = self.registry.analyze_query_type(query)
            available_models = [m.id for m in self.registry.models.values() if m.available]
            
            # Get model recommendations
            recommendations = self.feedback_learner.get_model_recommendations(
                query_type,
                available_models
            )
            
            # If we have strong recommendations, update stages
            if recommendations and recommendations[0][1] > 4.0:  # High confidence
                logger.info(f"Using recommended model: {recommendations[0][0]}")
                # Update the synthesis stage with the best model
                for i, stage in enumerate(stages):
                    if stage.name == "synthesis":
                        stages[i] = ModelStage(
                            name=stage.name,
                            model=recommendations[0][0],
                            confidence=stage.confidence,
                            timeout=stage.timeout,
                            system_prompt=stage.system_prompt
                        )
                        
        return stages
        
    async def provide_feedback(self, rating: int, feedback_text: str = ""):
        """Provide feedback for the last conversation"""
        if not self.use_memory or not self.current_conversation:
            logger.warning("No conversation to provide feedback for")
            return
            
        if not self.current_conversation.id:
            logger.warning("Conversation not yet saved")
            return
            
        # Update feedback
        self.feedback_learner.update_from_feedback(
            self.current_conversation.id,
            rating,
            feedback_text
        )
        
        logger.info(f"Feedback recorded: {rating}/5")
        
    def get_session_summary(self) -> Dict[str, Any]:
        """Get a summary of the current session"""
        if not self.use_memory or not self.context_manager:
            return {'session_id': self.session_id, 'memory_enabled': False}
            
        return self.context_manager.get_session_summary(self.session_id)
        
    def get_performance_summary(self) -> Dict[str, Any]:
        """Get performance summary from feedback learner"""
        if not self.use_memory or not self.feedback_learner:
            return {'memory_enabled': False}
            
        return self.feedback_learner.get_performance_summary()