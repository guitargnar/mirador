#!/usr/bin/env python3
"""
Test suite for model consolidation and intelligent routing.
Following TDD principles - tests first, implementation second.
"""

import unittest
import json
import os
from typing import List, Dict, Any
import yaml

class TestModelRegistry(unittest.TestCase):
    """Test the new model registry system for consolidation."""
    
    def test_model_registry_structure(self):
        """Test that model registry has proper structure."""
        # GIVEN: A model registry configuration
        # WHEN: Registry is loaded
        # THEN: Should have required fields and structure
        
        registry = self.load_model_registry()
        
        self.assertIn('models', registry)
        self.assertIn('capabilities', registry)
        self.assertIn('domains', registry)
        
        # Each model should have required fields
        for model_id, model_info in registry['models'].items():
            self.assertIn('name', model_info)
            self.assertIn('capabilities', model_info)
            self.assertIn('domains', model_info)
            self.assertIn('performance', model_info)
            self.assertIn('base_model', model_info)
            
    def test_capability_taxonomy(self):
        """Test capability taxonomy is well-defined."""
        # GIVEN: Capability definitions
        # WHEN: Capabilities are analyzed
        # THEN: Should have clear hierarchy and no overlaps
        
        capabilities = self.get_capability_taxonomy()
        
        # Test main categories exist
        main_categories = ['analysis', 'generation', 'optimization', 'synthesis']
        for category in main_categories:
            self.assertIn(category, capabilities)
            
        # Test no circular dependencies
        self.assertFalse(self.has_circular_dependencies(capabilities))
        
        # Test capability coverage
        self.assertTrue(self.covers_all_use_cases(capabilities))
        
    def test_model_deduplication(self):
        """Test identification of redundant models."""
        # GIVEN: Current 80+ models
        # WHEN: Deduplication analysis runs
        # THEN: Should identify models that can be merged
        
        analysis = self.analyze_model_redundancy()
        
        self.assertGreater(len(analysis['redundant_groups']), 0)
        self.assertGreater(analysis['potential_reduction'], 50)  # Should reduce by >50%
        
        # Each group should have similar capabilities
        for group in analysis['redundant_groups']:
            capabilities = [self.get_model_capabilities(m) for m in group]
            similarity = self.calculate_capability_similarity(capabilities)
            self.assertGreater(similarity, 0.8)  # 80% similar
            
    def test_consolidated_model_definition(self):
        """Test creation of consolidated universal models."""
        # GIVEN: Groups of similar models
        # WHEN: Consolidated model is created
        # THEN: Should maintain all critical capabilities
        
        test_groups = [
            {
                'models': ['matthew_context_provider_v3', 'matthew_context_provider_v4', 
                          'matthew_context_provider_v6_complete'],
                'consolidated_name': 'universal_context_provider'
            },
            {
                'models': ['financial_planning_expert_v8', 'personal_finance_navigator',
                          'budget_optimizer'],
                'consolidated_name': 'universal_financial_advisor'
            }
        ]
        
        for group in test_groups:
            consolidated = self.create_consolidated_model(group['models'])
            
            # Verify all capabilities preserved
            original_caps = set()
            for model in group['models']:
                original_caps.update(self.get_model_capabilities(model))
                
            self.assertTrue(original_caps.issubset(consolidated['capabilities']))
            self.assertEqual(consolidated['name'], group['consolidated_name'])
            
    # Helper methods
    def load_model_registry(self):
        """Load model registry configuration."""
        pass
        
    def get_capability_taxonomy(self):
        """Get capability taxonomy."""
        pass
        
    def has_circular_dependencies(self, capabilities):
        """Check for circular dependencies."""
        pass
        
    def covers_all_use_cases(self, capabilities):
        """Verify all use cases are covered."""
        pass
        
    def analyze_model_redundancy(self):
        """Analyze model redundancy."""
        pass
        
    def get_model_capabilities(self, model):
        """Get model capabilities."""
        pass
        
    def calculate_capability_similarity(self, capabilities):
        """Calculate similarity between capability sets."""
        pass
        
    def create_consolidated_model(self, models):
        """Create consolidated model from group."""
        pass


class TestDynamicRouting(unittest.TestCase):
    """Test dynamic routing system for optimal model selection."""
    
    def test_query_intent_classification(self):
        """Test classification of query intent."""
        # GIVEN: Various query types
        # WHEN: Intent classifier processes them
        # THEN: Should correctly identify intent and requirements
        
        test_queries = [
            {
                "query": "What should I do right now?",
                "expected_intent": "immediate_action",
                "expected_urgency": "high",
                "max_models": 2
            },
            {
                "query": "Analyze my financial situation and create a 6-month plan",
                "expected_intent": "deep_analysis",
                "expected_urgency": "low",
                "max_models": 4
            },
            {
                "query": "Quick check on today's priorities",
                "expected_intent": "status_check",
                "expected_urgency": "high",
                "max_models": 2
            }
        ]
        
        for test in test_queries:
            result = self.classify_query_intent(test["query"])
            
            self.assertEqual(result['intent'], test['expected_intent'])
            self.assertEqual(result['urgency'], test['expected_urgency'])
            self.assertLessEqual(result['recommended_models'], test['max_models'])
            
    def test_capability_matching(self):
        """Test matching query requirements to model capabilities."""
        # GIVEN: Query with specific requirements
        # WHEN: Capability matcher runs
        # THEN: Should select minimal optimal model set
        
        query_requirements = {
            "needs": ["financial_analysis", "action_planning", "context_awareness"],
            "constraints": {"max_time": 30, "quality_threshold": 0.85}
        }
        
        selected_models = self.match_models_to_requirements(query_requirements)
        
        # Verify all needs are covered
        covered_capabilities = set()
        for model in selected_models:
            covered_capabilities.update(model['capabilities'])
            
        for need in query_requirements['needs']:
            self.assertIn(need, covered_capabilities)
            
        # Verify minimal set
        self.assertLessEqual(len(selected_models), 3)
        
    def test_routing_decision_tree(self):
        """Test routing decision tree logic."""
        # GIVEN: Routing rules and query
        # WHEN: Decision tree is evaluated
        # THEN: Should follow optimal path
        
        routing_rules = self.get_routing_rules()
        
        test_cases = [
            {
                "query": "I need help with my Company presentation",
                "expected_path": ["context", "corporate_strategy", "presentation_builder"],
                "excluded_models": ["music_advisor", "fitness_coach"]
            },
            {
                "query": "Plan my guitar practice for the week",
                "expected_path": ["context", "music_advisor", "schedule_optimizer"],
                "excluded_models": ["corporate_strategy", "financial_advisor"]
            }
        ]
        
        for case in test_cases:
            path = self.evaluate_routing_tree(case["query"], routing_rules)
            
            # Verify expected models in path
            for expected in case["expected_path"]:
                self.assertTrue(any(expected in model for model in path))
                
            # Verify excluded models not in path
            for excluded in case["excluded_models"]:
                self.assertFalse(any(excluded in model for model in path))
                
    def test_adaptive_routing(self):
        """Test adaptive routing based on feedback."""
        # GIVEN: Historical feedback data
        # WHEN: Similar query is routed
        # THEN: Should adapt based on what worked before
        
        # Simulate feedback history
        feedback_history = [
            {
                "query_type": "daily_planning",
                "models_used": ["context", "analyzer", "planner", "optimizer"],
                "rating": 3,
                "execution_time": 45
            },
            {
                "query_type": "daily_planning", 
                "models_used": ["context", "quick_planner"],
                "rating": 5,
                "execution_time": 15
            }
        ]
        
        # Route new similar query
        new_query = "What should I focus on today?"
        routing = self.route_with_adaptation(new_query, feedback_history)
        
        # Should prefer the higher-rated, faster approach
        self.assertEqual(len(routing['models']), 2)
        self.assertIn("quick_planner", routing['models'])
        self.assertLess(routing['estimated_time'], 20)
        
    # Helper methods
    def classify_query_intent(self, query):
        """Classify query intent."""
        pass
        
    def match_models_to_requirements(self, requirements):
        """Match models to requirements."""
        pass
        
    def get_routing_rules(self):
        """Get routing rules."""
        pass
        
    def evaluate_routing_tree(self, query, rules):
        """Evaluate routing decision tree."""
        pass
        
    def route_with_adaptation(self, query, history):
        """Route with adaptive learning."""
        pass


class TestPromptConsolidation(unittest.TestCase):
    """Test consolidated prompting strategies."""
    
    def test_dynamic_prompt_generation(self):
        """Test dynamic prompt generation for consolidated models."""
        # GIVEN: A consolidated model and query context
        # WHEN: Prompt is generated
        # THEN: Should include all necessary context and instructions
        
        model = "universal_life_advisor"
        context = {
            "query": "Balance work and family",
            "user_context": {"role": "Risk Manager", "family": "Single parent"},
            "required_capabilities": ["work_life_balance", "scheduling", "priority_setting"]
        }
        
        prompt = self.generate_dynamic_prompt(model, context)
        
        # Verify prompt includes all required elements
        self.assertIn("Risk Manager", prompt)
        self.assertIn("Single parent", prompt)
        self.assertIn("work_life_balance", prompt)
        
        # Verify prompt structure
        self.assertTrue(prompt.startswith("You are a universal life advisor"))
        self.assertIn("Consider the following", prompt)
        self.assertIn("Provide actionable", prompt)
        
    def test_capability_activation(self):
        """Test selective capability activation in prompts."""
        # GIVEN: Model with multiple capabilities
        # WHEN: Specific capability is needed
        # THEN: Prompt should activate only relevant capabilities
        
        test_cases = [
            {
                "capability": "financial_planning",
                "prompt_should_include": ["budget", "financial", "money"],
                "prompt_should_exclude": ["music", "guitar", "performance"]
            },
            {
                "capability": "music_career",
                "prompt_should_include": ["music", "performance", "practice"],
                "prompt_should_exclude": ["budget", "corporate", "risk management"]
            }
        ]
        
        for case in test_cases:
            prompt = self.generate_capability_focused_prompt(
                "universal_advisor",
                case["capability"]
            )
            
            for term in case["prompt_should_include"]:
                self.assertIn(term.lower(), prompt.lower())
                
            for term in case["prompt_should_exclude"]:
                self.assertNotIn(term.lower(), prompt.lower())
                
    def test_prompt_length_optimization(self):
        """Test prompt length optimization for efficiency."""
        # GIVEN: Complex query requiring multiple capabilities
        # WHEN: Prompt is optimized
        # THEN: Should be concise while maintaining effectiveness
        
        complex_context = {
            "query": "Plan my entire week considering work deadlines, family time, music practice, and health",
            "history": ["previous", "conversation", "context"] * 10,
            "constraints": ["time", "energy", "financial"] * 5
        }
        
        unoptimized = self.generate_standard_prompt(complex_context)
        optimized = self.generate_optimized_prompt(complex_context)
        
        # Optimized should be significantly shorter
        self.assertLess(len(optimized), len(unoptimized) * 0.6)
        
        # But should maintain key information
        key_terms = ["week", "work", "family", "music", "health"]
        for term in key_terms:
            self.assertIn(term, optimized)
            
    # Helper methods
    def generate_dynamic_prompt(self, model, context):
        """Generate dynamic prompt."""
        pass
        
    def generate_capability_focused_prompt(self, model, capability):
        """Generate capability-focused prompt."""
        pass
        
    def generate_standard_prompt(self, context):
        """Generate standard prompt."""
        pass
        
    def generate_optimized_prompt(self, context):
        """Generate optimized prompt."""
        pass


if __name__ == '__main__':
    unittest.main(verbosity=2)