"""
Model Registry for Dynamic Model Loading
Handles model discovery, selection, and fallback mechanisms
"""

import yaml
import asyncio
import logging
from typing import Dict, List, Optional, Any
from dataclasses import dataclass
from pathlib import Path
import time
from ollama import AsyncClient

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@dataclass
class ModelInfo:
    """Model metadata and capabilities"""
    id: str
    name: str
    type: str
    latency: float
    memory: float
    capabilities: List[str]
    fallback: Optional[str] = None
    available: bool = False
    last_check: float = 0

class ModelRegistry:
    """Dynamic model registry with performance-based selection"""
    
    def __init__(self, manifest_path: str = "src/models/manifest.yaml"):
        self.manifest_path = Path(manifest_path)
        self.models: Dict[str, ModelInfo] = {}
        self.query_mappings: Dict[str, Dict] = {}
        self.performance: Dict[str, Any] = {}
        self.client = AsyncClient()
        self._load_manifest()
        
    def _load_manifest(self):
        """Load model manifest from YAML"""
        try:
            with open(self.manifest_path, 'r') as f:
                manifest = yaml.safe_load(f)
                
            # Load models
            for category, models in manifest['models'].items():
                for model_data in models:
                    model = ModelInfo(**model_data)
                    self.models[model.id] = model
                    
            # Load query mappings
            self.query_mappings = manifest.get('query_mappings', {})
            
            # Load performance thresholds
            self.performance = manifest.get('performance', {})
            
            logger.info(f"Loaded {len(self.models)} models from manifest")
            
        except Exception as e:
            logger.error(f"Failed to load manifest: {e}")
            # Fallback to hardcoded models
            self._load_default_models()
    
    def _load_default_models(self):
        """Load default models if manifest fails"""
        defaults = [
            ModelInfo(
                id="phi3:mini",
                name="Phi-3 Mini",
                type="quick",
                latency=1.2,
                memory=3.8,
                capabilities=["general_knowledge", "quick_answers"]
            ),
            ModelInfo(
                id="gemma2:9b",
                name="Gemma 2 9B",
                type="analysis",
                latency=5.2,
                memory=9.5,
                capabilities=["deep_analysis", "reasoning"]
            ),
            ModelInfo(
                id="matthew_context_provider_v6_complete:latest",
                name="Matthew Context Provider",
                type="synthesis",
                latency=15.0,
                memory=13.0,
                capabilities=["personal_context", "synthesis"]
            )
        ]
        
        for model in defaults:
            self.models[model.id] = model
            
    async def check_availability(self, force: bool = False):
        """Check which models are actually available"""
        current_time = time.time()
        
        # Only check every 5 minutes unless forced
        if not force and any(
            m.last_check > current_time - 300 
            for m in self.models.values()
        ):
            return
            
        try:
            # Get list of available models from Ollama
            response = await self.client.list()
            available_ids = {m.model for m in response.models} if hasattr(response, 'models') else set()
            
            # Update availability status
            for model_id, model in self.models.items():
                model.available = model_id in available_ids
                model.last_check = current_time
                
                if not model.available:
                    logger.warning(f"Model {model_id} not available")
                    
        except Exception as e:
            logger.error(f"Failed to check model availability: {e}")
            
    def get_models_by_type(self, model_type: str) -> List[ModelInfo]:
        """Get all models of a specific type"""
        return [
            m for m in self.models.values() 
            if m.type == model_type and m.available
        ]
        
    def get_models_by_capability(self, capability: str) -> List[ModelInfo]:
        """Get models with a specific capability"""
        return [
            m for m in self.models.values()
            if capability in m.capabilities and m.available
        ]
        
    async def select_model(
        self, 
        query: str, 
        stage: str,
        query_type: Optional[str] = None
    ) -> Optional[ModelInfo]:
        """Select best model for query and stage"""
        
        # Ensure we have current availability
        await self.check_availability()
        
        # Get stage-appropriate models
        candidates = self.get_models_by_type(stage)
        
        if not candidates:
            logger.warning(f"No available models for stage: {stage}")
            return None
            
        # If query type specified, prefer models with matching capabilities
        if query_type and query_type in self.query_mappings:
            mapping = self.query_mappings[query_type]
            required_caps = mapping.get('required_capabilities', [])
            preferred_ids = mapping.get('preferred_models', [])
            
            # Filter by required capabilities
            if required_caps:
                candidates = [
                    m for m in candidates
                    if all(cap in m.capabilities for cap in required_caps)
                ]
                
            # Sort by preference
            if preferred_ids:
                def preference_score(model):
                    try:
                        return preferred_ids.index(model.id)
                    except ValueError:
                        return len(preferred_ids)
                        
                candidates.sort(key=preference_score)
                
        # Sort by latency (faster is better)
        candidates.sort(key=lambda m: m.latency)
        
        # Check performance thresholds
        max_latency = self.performance.get('max_latency', {}).get(stage, 30.0)
        max_memory = self.performance.get('max_memory_gb', 16.0)
        
        for model in candidates:
            if model.latency <= max_latency and model.memory <= max_memory:
                logger.info(f"Selected {model.id} for {stage} stage")
                return model
                
        # If no model meets criteria, return fastest available
        if candidates:
            logger.warning(f"No model meets performance criteria, using fastest")
            return candidates[0]
            
        return None
        
    async def get_fallback_model(self, model: ModelInfo) -> Optional[ModelInfo]:
        """Get fallback model if primary fails"""
        if not model.fallback:
            return None
            
        fallback = self.models.get(model.fallback)
        if fallback and fallback.available:
            logger.info(f"Using fallback model: {fallback.id}")
            return fallback
            
        # If specified fallback not available, find any available model of same type
        alternatives = self.get_models_by_type(model.type)
        if alternatives:
            return alternatives[0]
            
        return None
        
    def get_model_info(self, model_id: str) -> Optional[ModelInfo]:
        """Get model information by ID"""
        return self.models.get(model_id)
        
    async def benchmark_model(self, model_id: str, test_prompt: str) -> Dict[str, float]:
        """Benchmark a model's actual performance"""
        model = self.models.get(model_id)
        if not model or not model.available:
            return {}
            
        try:
            start_time = time.time()
            first_token_time = None
            token_count = 0
            
            async for chunk in await self.client.chat(
                model=model_id,
                messages=[{"role": "user", "content": test_prompt}],
                stream=True
            ):
                if first_token_time is None:
                    first_token_time = time.time() - start_time
                    
                token_count += len(chunk['message']['content'].split())
                
            total_time = time.time() - start_time
            
            return {
                'first_token_latency': first_token_time,
                'total_time': total_time,
                'tokens': token_count,
                'tokens_per_second': token_count / total_time if total_time > 0 else 0
            }
            
        except Exception as e:
            logger.error(f"Benchmark failed for {model_id}: {e}")
            return {}
            
    def analyze_query_type(self, query: str) -> Optional[str]:
        """Simple query type detection"""
        query_lower = query.lower()
        
        # Technical queries
        if any(keyword in query_lower for keyword in [
            'code', 'programming', 'debug', 'error', 'function', 
            'class', 'api', 'algorithm', 'async', 'await'
        ]):
            return 'technical'
            
        # Personal queries  
        if any(keyword in query_lower for keyword in [
            'i am', 'my', 'me', 'today', 'tomorrow', 'schedule',
            'feel', 'think', 'personal', 'life'
        ]):
            return 'personal'
            
        # Creative queries
        if any(keyword in query_lower for keyword in [
            'create', 'write', 'story', 'poem', 'imagine',
            'design', 'art', 'music', 'creative'
        ]):
            return 'creative'
            
        # Business queries
        if any(keyword in query_lower for keyword in [
            'business', 'strategy', 'market', 'profit', 'roi',
            'customer', 'sales', 'revenue', 'investment'
        ]):
            return 'business'
            
        return None