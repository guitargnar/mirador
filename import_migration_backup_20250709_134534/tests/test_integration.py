#!/usr/bin/env python3
"""
Integration tests for Mirador enhancements.
Tests the full system with error handling, model consolidation, and optimization.
"""

import unittest
import sys
import os
from pathlib import Path

# Add src to path
sys.path.insert(0, str(Path(__file__).parent.parent / 'src'))

from error_handler import ChainExecutor, CircuitBreaker
from model_registry import ModelRegistry, DynamicRouter
from prompt_optimizer import PromptOptimizer


class TestIntegratedSystem(unittest.TestCase):
    """Test the integrated system with all enhancements."""
    
    def setUp(self):
        self.chain_executor = ChainExecutor()
        self.registry = ModelRegistry()
        self.router = DynamicRouter(self.registry)
        self.prompt_optimizer = PromptOptimizer()
        
    def test_consolidated_chain_with_error_handling(self):
        """Test running consolidated models with error handling."""
        # Get consolidated models for a query
        query = "What should I focus on today?"
        
        # Route to appropriate models
        intent = self.router.classifier.classify_query_intent(query)
        requirements = {
            'needs': ['context_understanding', 'priority_analysis', 'action_planning'],
            'constraints': {'max_time': 30, 'quality_threshold': 0.85}
        }
        
        selected_models = self.router.classifier.match_models_to_requirements(requirements)
        model_ids = [m['id'] for m in selected_models]
        
        # Execute chain with error handling
        result = self.chain_executor.execute_chain(model_ids, query)
        
        # Verify results
        self.assertIsNotNone(result)
        self.assertIn('completed_models', result)
        self.assertIn('final_output', result)
        
        # Should handle missing consolidated models gracefully
        if len(result['warnings']) > 0:
            self.assertIn('not found', result['warnings'][0])
            
    def test_optimized_prompting_with_routing(self):
        """Test optimized prompting with dynamic routing."""
        query = "Balance work commitments with family time this week"
        
        # Route query
        path = self.router.evaluate_routing_tree(
            query, 
            self.router.routing_rules
        )
        
        # Generate optimized prompts for each model
        context = {
            'query': query,
            'user_context': {
                'role': 'Risk Manager',
                'family': 'Married with children'
            },
            'required_capabilities': ['work_life_balance', 'scheduling']
        }
        
        prompts = {}
        for model in path:
            if 'universal' in model:
                prompt = self.prompt_optimizer.generate_dynamic_prompt(model, context)
                prompts[model] = prompt
                
                # Verify prompt optimization
                tokens = self.prompt_optimizer.count_tokens(prompt)
                self.assertLess(tokens, 500)  # Should be concise
                self.assertIn('balance', prompt.lower())
                
    def test_adaptive_quality_speed_tradeoff(self):
        """Test system adapts based on urgency."""
        # High urgency query
        urgent_query = "What should I do right now?"
        intent = self.router.classifier.classify_query_intent(urgent_query)
        
        self.assertEqual(intent['urgency'], 'high')
        self.assertEqual(intent['recommended_models'], 2)
        
        # Low urgency query  
        analysis_query = "Create a comprehensive 6-month financial plan"
        intent = self.router.classifier.classify_query_intent(analysis_query)
        
        self.assertEqual(intent['urgency'], 'low')
        self.assertEqual(intent['recommended_models'], 4)
        
    def test_fallback_chain_execution(self):
        """Test fallback mechanisms work correctly."""
        # Simulate chain with failures
        models = ['nonexistent_model', 'universal_context_provider', 'another_missing_model']
        query = "Test fallback mechanisms"
        
        result = self.chain_executor.execute_chain(models, query)
        
        # Should attempt fallbacks
        self.assertTrue(result['partial_success'] or result['fallback_used'])
        self.assertGreater(len(result['logs']), 0)
        
        # Check if fallback models were attempted
        fallback_attempted = any('fallback' in log.lower() for log in result['logs'])
        self.assertTrue(fallback_attempted or len(result['warnings']) > 0)
        
    def test_model_consolidation_effectiveness(self):
        """Test that model consolidation reduces complexity."""
        # Analyze current model set
        analysis = self.registry.analyze_model_redundancy()
        
        # Verify significant reduction
        self.assertGreater(analysis['potential_reduction'], 50)
        self.assertLess(analysis['consolidated_count'], 20)
        
        # Verify consolidated models cover all capabilities
        all_capabilities = set()
        for model in self.registry.consolidated_models.values():
            all_capabilities.update(model.capabilities)
            
        required_capabilities = {
            'context_understanding', 'financial_analysis', 'action_planning',
            'work_life_balance', 'creative_content', 'strategic_synthesis'
        }
        
        self.assertTrue(required_capabilities.issubset(all_capabilities))
        
    def test_end_to_end_query_processing(self):
        """Test complete query processing with all enhancements."""
        query = "Help me plan my week balancing work, music practice, and family"
        
        # 1. Classify intent
        intent = self.router.classifier.classify_query_intent(query)
        
        # 2. Match models to requirements
        requirements = {
            'needs': ['work_life_balance', 'scheduling', 'priority_analysis'],
            'constraints': {'max_time': 30}
        }
        selected_models = self.router.classifier.match_models_to_requirements(requirements)
        
        # 3. Generate optimized prompts
        context = {
            'query': query,
            'user_context': {'role': 'Professional with music aspirations'},
            'required_capabilities': requirements['needs']
        }
        
        # 4. Execute chain (would run actual models in production)
        model_ids = [m['id'] for m in selected_models[:2]]  # Limit to 2 for speed
        
        # Verify the pipeline works
        self.assertGreater(len(selected_models), 0)
        self.assertLessEqual(len(selected_models), 3)
        self.assertIn('urgency', intent)
        
        # Verify prompt generation
        for model in selected_models:
            if model['id'] in self.registry.consolidated_models:
                prompt = self.prompt_optimizer.generate_dynamic_prompt(
                    model['id'], 
                    context
                )
                self.assertIsInstance(prompt, str)
                self.assertGreater(len(prompt), 50)


class TestPerformanceImprovements(unittest.TestCase):
    """Test performance improvements from optimizations."""
    
    def setUp(self):
        self.registry = ModelRegistry()
        self.optimizer = PromptOptimizer()
        
    def test_prompt_token_reduction(self):
        """Test that prompts are significantly reduced."""
        # Complex context that would create large prompt
        context = {
            'query': 'Analyze my situation and create a plan',
            'history': ['Previous conversation'] * 20,
            'constraints': ['Time', 'Energy', 'Money'] * 10
        }
        
        standard = self.optimizer.generate_standard_prompt(context)
        optimized = self.optimizer.generate_optimized_prompt(context)
        
        standard_tokens = self.optimizer.count_tokens(standard)
        optimized_tokens = self.optimizer.count_tokens(optimized)
        
        # Should achieve at least 40% reduction
        reduction = (standard_tokens - optimized_tokens) / standard_tokens
        self.assertGreater(reduction, 0.4)
        
        # But should maintain key information
        key_terms = ['analyze', 'situation', 'plan']
        for term in key_terms:
            self.assertIn(term.lower(), optimized.lower())
            
    def test_model_count_reduction(self):
        """Test reduction in number of models needed."""
        # Original chain might use 5-6 models
        original_chain = [
            'matthew_context_provider_v3',
            'personality_analyzer',  
            'priority_setter',
            'schedule_optimizer',
            'action_planner',
            'decision_simplifier'
        ]
        
        # Consolidated chain should use fewer
        consolidated_chain = [
            'universal_context_provider',
            'universal_life_optimizer',
            'universal_action_generator'
        ]
        
        self.assertLess(len(consolidated_chain), len(original_chain))
        self.assertLessEqual(len(consolidated_chain), 3)
        
        # But should cover same capabilities
        original_capabilities = set()
        for model in original_chain:
            original_capabilities.update(self.registry.get_model_capabilities(model))
            
        consolidated_capabilities = set()
        for model in consolidated_chain:
            consolidated_capabilities.update(self.registry.get_model_capabilities(model))
            
        # Most capabilities should be preserved
        coverage = len(consolidated_capabilities & original_capabilities) / len(original_capabilities)
        self.assertGreater(coverage, 0.8)


if __name__ == '__main__':
    unittest.main(verbosity=2)