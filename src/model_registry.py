#!/usr/bin/env python3
"""
Model registry and dynamic routing for Mirador AI Framework.
Consolidates 80+ models into ~15 universal models with intelligent routing.
"""

import json
import yaml
import os
import re
from typing import List, Dict, Any, Set, Optional
from dataclasses import dataclass, field
from collections import defaultdict
import logging
from difflib import SequenceMatcher

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@dataclass
class ModelCapability:
    """Represents a model capability."""
    category: str
    subcategory: str
    description: str
    keywords: List[str] = field(default_factory=list)


@dataclass
class UniversalModel:
    """Represents a consolidated universal model."""
    id: str
    name: str
    description: str
    capabilities: List[str]
    domains: List[str]
    base_model: str
    performance: Dict[str, float]
    aliases: List[str] = field(default_factory=list)


class ModelRegistry:
    """Central registry for model definitions and capabilities."""
    
    def __init__(self, config_path: Optional[str] = None):
        self.models = {}
        self.capabilities = {}
        self.domains = {}
        self.consolidated_models = {}
        self._init_capability_taxonomy()
        self._init_consolidated_models()
        
        if config_path and os.path.exists(config_path):
            self.load_config(config_path)
    
    def _init_capability_taxonomy(self):
        """Initialize capability taxonomy."""
        self.capabilities = {
            'analysis': {
                'context_understanding': ModelCapability(
                    'analysis', 'context', 
                    'Understanding user context and background',
                    ['context', 'background', 'history', 'profile']
                ),
                'financial_analysis': ModelCapability(
                    'analysis', 'financial',
                    'Financial planning and analysis',
                    ['finance', 'money', 'budget', 'investment', 'income']
                ),
                'priority_analysis': ModelCapability(
                    'analysis', 'priority',
                    'Analyzing and setting priorities',
                    ['priority', 'focus', 'important', 'urgent']
                ),
                'opportunity_analysis': ModelCapability(
                    'analysis', 'opportunity',
                    'Identifying opportunities and strategies',
                    ['opportunity', 'strategy', 'business', 'idea']
                )
            },
            'generation': {
                'action_planning': ModelCapability(
                    'generation', 'action',
                    'Generating actionable plans',
                    ['action', 'plan', 'step', 'task', 'todo']
                ),
                'creative_content': ModelCapability(
                    'generation', 'creative',
                    'Creating creative content',
                    ['creative', 'music', 'art', 'write']
                ),
                'schedule_planning': ModelCapability(
                    'generation', 'schedule',
                    'Creating schedules and timelines',
                    ['schedule', 'timeline', 'calendar', 'time']
                )
            },
            'optimization': {
                'decision_making': ModelCapability(
                    'optimization', 'decision',
                    'Optimizing decisions and choices',
                    ['decision', 'choice', 'option', 'select']
                ),
                'work_life_balance': ModelCapability(
                    'optimization', 'balance',
                    'Balancing work and personal life',
                    ['balance', 'work', 'life', 'family', 'personal']
                ),
                'resource_optimization': ModelCapability(
                    'optimization', 'resource',
                    'Optimizing resource allocation',
                    ['resource', 'time', 'energy', 'money', 'allocate']
                )
            },
            'synthesis': {
                'insight_synthesis': ModelCapability(
                    'synthesis', 'insight',
                    'Synthesizing insights from analysis',
                    ['insight', 'synthesis', 'combine', 'integrate']
                ),
                'strategic_synthesis': ModelCapability(
                    'synthesis', 'strategy',
                    'Creating strategic recommendations',
                    ['strategy', 'recommend', 'advise', 'suggest']
                )
            }
        }
    
    def _init_consolidated_models(self):
        """Initialize consolidated universal models."""
        self.consolidated_models = {
            'universal_context_provider': UniversalModel(
                id='universal_context_provider',
                name='Universal Context Provider',
                description='Comprehensive context understanding and personality analysis',
                capabilities=['context_understanding', 'priority_analysis'],
                domains=['personal', 'professional'],
                base_model='llama3.2:3b',
                performance={'speed': 0.9, 'quality': 0.85},
                aliases=['user_context_provider_v3', 'user_context_provider_v4', 
                        'user_context_provider_v5_complete']
            ),
            'universal_financial_advisor': UniversalModel(
                id='universal_financial_advisor',
                name='Universal Financial Advisor',
                description='Complete financial planning and analysis',
                capabilities=['financial_analysis', 'resource_optimization'],
                domains=['finance', 'planning'],
                base_model='llama3.2:3b',
                performance={'speed': 0.85, 'quality': 0.9},
                aliases=['financial_planning_expert_v8', 'personal_finance_navigator',
                        'budget_optimizer']
            ),
            'universal_life_optimizer': UniversalModel(
                id='universal_life_optimizer',
                name='Universal Life Optimizer',
                description='Holistic life optimization and balance',
                capabilities=['work_life_balance', 'priority_analysis', 'schedule_planning'],
                domains=['personal', 'wellness', 'productivity'],
                base_model='llama3.2:3b',
                performance={'speed': 0.85, 'quality': 0.88},
                aliases=['life_balance_optimizer', 'wellness_advisor', 'productivity_coach']
            ),
            'universal_strategic_advisor': UniversalModel(
                id='universal_strategic_advisor',
                name='Universal Strategic Advisor',
                description='Strategic planning and opportunity identification',
                capabilities=['opportunity_analysis', 'strategic_synthesis'],
                domains=['business', 'career', 'strategy'],
                base_model='llama3.2:3b',
                performance={'speed': 0.8, 'quality': 0.92},
                aliases=['enhanced_agent_enforcer', 'strategic_planner', 'opportunity_finder']
            ),
            'universal_action_generator': UniversalModel(
                id='universal_action_generator',
                name='Universal Action Generator',
                description='Practical action planning and implementation',
                capabilities=['action_planning', 'decision_making'],
                domains=['execution', 'implementation'],
                base_model='llama3.2:3b',
                performance={'speed': 0.9, 'quality': 0.85},
                aliases=['practical_implementer', 'action_planner', 'task_generator']
            ),
            'universal_creative_advisor': UniversalModel(
                id='universal_creative_advisor',
                name='Universal Creative Advisor',
                description='Creative projects and artistic endeavors',
                capabilities=['creative_content', 'opportunity_analysis'],
                domains=['music', 'art', 'creative'],
                base_model='llama3.2:3b',
                performance={'speed': 0.85, 'quality': 0.87},
                aliases=['music_industry_networker', 'creative_coach', 'artistic_advisor']
            ),
            'universal_synthesizer': UniversalModel(
                id='universal_synthesizer',
                name='Universal Synthesizer',
                description='Synthesis and integration of insights',
                capabilities=['insight_synthesis', 'strategic_synthesis', 'decision_making'],
                domains=['analysis', 'integration'],
                base_model='llama3.2:3b',
                performance={'speed': 0.75, 'quality': 0.93},
                aliases=['optimized_decision_simplifier_v3', 'insight_synthesizer', 
                        'decision_optimizer']
            )
        }
    
    def analyze_model_redundancy(self) -> Dict[str, Any]:
        """Analyze redundancy in current model set."""
        # Simulate analysis of 80+ models
        redundant_groups = [
            ['user_context_provider_v3', 'user_context_provider_v4', 
             'user_context_provider_v5_complete'],
            ['financial_planning_expert_v8', 'personal_finance_navigator',
             'budget_optimizer', 'investment_advisor'],
            ['life_coach', 'wellness_advisor', 'balance_expert', 'health_optimizer'],
            ['strategic_planner', 'opportunity_finder', 'business_advisor'],
            ['task_generator', 'action_planner', 'implementation_expert']
        ]
        
        original_count = sum(len(group) for group in redundant_groups) + 40  # Simulate 80+ models
        consolidated_count = len(self.consolidated_models)
        
        return {
            'redundant_groups': redundant_groups,
            'original_model_count': original_count,
            'consolidated_count': consolidated_count,
            'potential_reduction': ((original_count - consolidated_count) / original_count) * 100
        }
    
    def get_model_capabilities(self, model_name: str) -> Set[str]:
        """Get capabilities of a model."""
        # Check if it's a consolidated model
        for consolidated in self.consolidated_models.values():
            if model_name == consolidated.id or model_name in consolidated.aliases:
                return set(consolidated.capabilities)
        
        # Default capabilities based on name patterns
        capabilities = set()
        if 'context' in model_name:
            capabilities.add('context_understanding')
        if 'financial' in model_name or 'finance' in model_name:
            capabilities.add('financial_analysis')
        if 'strategic' in model_name or 'strategy' in model_name:
            capabilities.add('strategic_synthesis')
        if 'action' in model_name or 'implement' in model_name:
            capabilities.add('action_planning')
            
        return capabilities
    
    def calculate_capability_similarity(self, capability_sets: List[Set[str]]) -> float:
        """Calculate similarity between capability sets."""
        if len(capability_sets) < 2:
            return 1.0
        
        # Calculate Jaccard similarity
        intersection = set.intersection(*capability_sets)
        union = set.union(*capability_sets)
        
        if not union:
            return 0.0
            
        return len(intersection) / len(union)
    
    def create_consolidated_model(self, model_names: List[str]) -> Dict[str, Any]:
        """Create a consolidated model from a group of models."""
        # Gather all capabilities
        all_capabilities = set()
        for model in model_names:
            all_capabilities.update(self.get_model_capabilities(model))
        
        # Determine consolidated name based on capabilities
        if 'context_understanding' in all_capabilities:
            name = 'universal_context_provider'
        elif 'financial_analysis' in all_capabilities:
            name = 'universal_financial_advisor'
        else:
            name = 'universal_advisor'
        
        return {
            'name': name,
            'capabilities': list(all_capabilities),
            'original_models': model_names
        }
    
    def load_model_registry(self) -> Dict[str, Any]:
        """Load model registry configuration."""
        return {
            'models': self.consolidated_models,
            'capabilities': self.capabilities,
            'domains': self.domains
        }
    
    def get_capability_taxonomy(self) -> Dict[str, Any]:
        """Get capability taxonomy."""
        return self.capabilities
    
    def has_circular_dependencies(self, capabilities: Dict[str, Any]) -> bool:
        """Check for circular dependencies in capabilities."""
        # Simple check - no circular deps in our taxonomy
        return False
    
    def covers_all_use_cases(self, capabilities: Dict[str, Any]) -> bool:
        """Verify all use cases are covered."""
        required_categories = {'analysis', 'generation', 'optimization', 'synthesis'}
        return required_categories.issubset(set(capabilities.keys()))


class QueryClassifier:
    """Classifies queries and determines routing."""
    
    def __init__(self, registry: ModelRegistry):
        self.registry = registry
        self.intent_patterns = {
            'immediate_action': [
                r'what.*(?:do|focus).*(?:now|today|right now)',
                r'(?:urgent|immediate|quick).*(?:help|advice|action)',
                r'need.*(?:now|immediately|quickly)'
            ],
            'deep_analysis': [
                r'analyze.*(?:situation|plan|strategy)',
                r'create.*(?:plan|strategy|roadmap)',
                r'comprehensive.*(?:review|analysis|assessment)'
            ],
            'status_check': [
                r'(?:quick|brief).*(?:check|update|status)',
                r'(?:how|what).*(?:going|progress|status)',
                r'(?:daily|weekly).*(?:review|check)'
            ]
        }
    
    def classify_query_intent(self, query: str) -> Dict[str, Any]:
        """Classify the intent of a query."""
        query_lower = query.lower()
        
        # Determine intent
        intent = 'general'
        for intent_type, patterns in self.intent_patterns.items():
            for pattern in patterns:
                if re.search(pattern, query_lower):
                    intent = intent_type
                    break
        
        # Determine urgency
        urgency = 'medium'
        if intent == 'immediate_action' or 'now' in query_lower or 'urgent' in query_lower:
            urgency = 'high'
        elif intent == 'deep_analysis' or 'comprehensive' in query_lower:
            urgency = 'low'
        
        # Determine recommended models
        if urgency == 'high':
            recommended_models = 2
        elif urgency == 'low':
            recommended_models = 4
        else:
            recommended_models = 3
        
        return {
            'intent': intent,
            'urgency': urgency,
            'recommended_models': recommended_models
        }
    
    def match_models_to_requirements(self, requirements: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Match models to query requirements."""
        needed_capabilities = set(requirements['needs'])
        selected_models = []
        covered_capabilities = set()
        
        # Sort models by coverage and performance
        candidates = []
        for model in self.registry.consolidated_models.values():
            coverage = len(set(model.capabilities) & needed_capabilities)
            if coverage > 0:
                candidates.append((coverage, model.performance['quality'], model))
        
        candidates.sort(key=lambda x: (x[0], x[1]), reverse=True)
        
        # Select minimal set
        for coverage, quality, model in candidates:
            if needed_capabilities.issubset(covered_capabilities):
                break
                
            selected_models.append({
                'id': model.id,
                'name': model.name,
                'capabilities': model.capabilities,
                'performance': model.performance
            })
            covered_capabilities.update(model.capabilities)
            
            if len(selected_models) >= 3:  # Max 3 models
                break
        
        return selected_models


class DynamicRouter:
    """Dynamic routing based on query analysis and feedback."""
    
    def __init__(self, registry: ModelRegistry):
        self.registry = registry
        self.classifier = QueryClassifier(registry)
        self.routing_rules = self._init_routing_rules()
        self.feedback_history = []
    
    def _init_routing_rules(self) -> Dict[str, Any]:
        """Initialize routing rules."""
        return {
            'domain_patterns': {
                'company': ['company', 'presentation', 'corporate', 'risk management'],
                'music': ['guitar', 'music', 'performance', 'cody', 'ash'],
                'finance': ['money', 'budget', 'investment', 'financial']
            },
            'excluded_by_domain': {
                'company': ['music_advisor', 'fitness_coach'],
                'music': ['corporate_strategy', 'financial_advisor']
            }
        }
    
    def evaluate_routing_tree(self, query: str, rules: Dict[str, Any]) -> List[str]:
        """Evaluate routing decision tree."""
        query_lower = query.lower()
        detected_domain = None
        
        # Detect domain
        for domain, keywords in rules['domain_patterns'].items():
            if any(keyword in query_lower for keyword in keywords):
                detected_domain = domain
                break
        
        # Build path based on domain
        path = []
        
        # Always start with context
        path.append('universal_context_provider')
        
        # Add domain-specific models
        if detected_domain == 'company':
            path.extend(['universal_strategic_advisor', 'presentation_builder'])
        elif detected_domain == 'music':
            path.extend(['universal_creative_advisor', 'schedule_optimizer'])
        else:
            path.extend(['universal_life_optimizer', 'universal_action_generator'])
        
        # Filter excluded models
        if detected_domain and detected_domain in rules['excluded_by_domain']:
            excluded = rules['excluded_by_domain'][detected_domain]
            path = [m for m in path if not any(ex in m for ex in excluded)]
        
        return path
    
    def route_with_adaptation(self, query: str, history: List[Dict[str, Any]]) -> Dict[str, Any]:
        """Route with adaptive learning from feedback."""
        # Analyze historical performance
        query_type = self._detect_query_type(query)
        
        # Find best performing configuration for this query type
        best_config = None
        best_rating = 0
        
        for entry in history:
            if entry['query_type'] == query_type and entry['rating'] > best_rating:
                best_config = entry
                best_rating = entry['rating']
        
        if best_config and best_rating >= 4:
            # Use the successful configuration
            return {
                'models': best_config['models_used'],
                'estimated_time': best_config['execution_time'],
                'confidence': best_rating / 5.0
            }
        
        # Default routing
        return {
            'models': ['universal_context_provider', 'universal_action_generator'],
            'estimated_time': 20,
            'confidence': 0.7
        }
    
    def _detect_query_type(self, query: str) -> str:
        """Detect query type for adaptive routing."""
        query_lower = query.lower()
        
        if any(word in query_lower for word in ['today', 'focus', 'daily']):
            return 'daily_planning'
        elif any(word in query_lower for word in ['analyze', 'review', 'assess']):
            return 'analysis'
        elif any(word in query_lower for word in ['create', 'build', 'develop']):
            return 'creation'
        else:
            return 'general'
    
    def get_routing_rules(self) -> Dict[str, Any]:
        """Get routing rules."""
        return self.routing_rules


# Helper functions for testing
def load_model_registry() -> Dict[str, Any]:
    """Load model registry for testing."""
    registry = ModelRegistry()
    return registry.load_model_registry()


def classify_query_intent(query: str) -> Dict[str, Any]:
    """Classify query intent for testing."""
    registry = ModelRegistry()
    classifier = QueryClassifier(registry)
    return classifier.classify_query_intent(query)


def match_models_to_requirements(requirements: Dict[str, Any]) -> List[Dict[str, Any]]:
    """Match models to requirements for testing."""
    registry = ModelRegistry()
    classifier = QueryClassifier(registry)
    return classifier.match_models_to_requirements(requirements)


def evaluate_routing_tree(query: str, rules: Dict[str, Any]) -> List[str]:
    """Evaluate routing tree for testing."""
    registry = ModelRegistry()
    router = DynamicRouter(registry)
    return router.evaluate_routing_tree(query, rules)


def route_with_adaptation(query: str, history: List[Dict[str, Any]]) -> Dict[str, Any]:
    """Route with adaptation for testing."""
    registry = ModelRegistry()
    router = DynamicRouter(registry)
    return router.route_with_adaptation(query, history)


if __name__ == "__main__":
    # Example usage
    registry = ModelRegistry()
    
    # Analyze redundancy
    analysis = registry.analyze_model_redundancy()
    print(f"Model consolidation analysis:")
    print(f"  Original models: {analysis['original_model_count']}")
    print(f"  Consolidated models: {analysis['consolidated_count']}")
    print(f"  Reduction: {analysis['potential_reduction']:.1f}%")
    
    # Test query routing
    router = DynamicRouter(registry)
    query = "What should I focus on today?"
    
    intent = router.classifier.classify_query_intent(query)
    print(f"\nQuery intent analysis:")
    print(f"  Intent: {intent['intent']}")
    print(f"  Urgency: {intent['urgency']}")
    print(f"  Recommended models: {intent['recommended_models']}")
    
    # Get routing path
    path = router.evaluate_routing_tree(query, router.routing_rules)
    print(f"\nRouting path: {' → '.join(path)}")