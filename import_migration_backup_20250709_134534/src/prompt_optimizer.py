#!/usr/bin/env python3
"""
Prompt optimization module for Mirador AI Framework.
Implements dynamic prompting, capability activation, and length optimization.
"""

import re
import json
from typing import Dict, List, Any, Optional
from dataclasses import dataclass
import tiktoken
from functools import lru_cache

@dataclass
class PromptTemplate:
    """Template for dynamic prompt generation."""
    base_template: str
    capability_modules: Dict[str, str]
    context_placeholders: List[str]
    
    
class PromptOptimizer:
    """Optimizes prompts for consolidated models."""
    
    def __init__(self):
        self.encoder = tiktoken.get_encoding("cl100k_base")
        self.templates = self._init_templates()
        self.capability_keywords = self._init_capability_keywords()
        
    def _init_templates(self) -> Dict[str, PromptTemplate]:
        """Initialize prompt templates for different model types."""
        return {
            'universal_life_advisor': PromptTemplate(
                base_template="You are a universal life advisor with expertise in {domains}. {context_info}\n\nConsider the following aspects:\n{considerations}\n\nProvide actionable advice that:\n{objectives}",
                capability_modules={
                    'work_life_balance': "- Balance professional demands with personal well-being\n- Consider time and energy constraints\n- Prioritize what matters most",
                    'scheduling': "- Create realistic timelines\n- Account for buffer time\n- Optimize daily/weekly rhythms",
                    'priority_setting': "- Identify high-impact activities\n- Distinguish urgent from important\n- Align with long-term goals"
                },
                context_placeholders=['user_role', 'family_situation', 'current_challenges']
            ),
            'universal_advisor': PromptTemplate(
                base_template="You are a {advisor_type} specializing in {specialty}. {context}\n\n{capability_instructions}\n\n{output_format}",
                capability_modules={
                    'financial_planning': "Focus on budget optimization, investment strategies, and financial security.",
                    'music_career': "Address music industry dynamics, performance improvement, and career development.",
                    'corporate_strategy': "Consider organizational dynamics, risk management, and strategic positioning."
                },
                context_placeholders=['user_background', 'current_situation', 'goals']
            )
        }
        
    def _init_capability_keywords(self) -> Dict[str, List[str]]:
        """Initialize keywords for capability detection."""
        return {
            'financial_planning': ['budget', 'financial', 'money', 'investment', 'income', 'expenses', 'savings'],
            'music_career': ['music', 'guitar', 'performance', 'practice', 'band', 'touring', 'recording'],
            'work_life_balance': ['balance', 'work', 'life', 'family', 'personal', 'stress', 'wellness'],
            'scheduling': ['schedule', 'time', 'calendar', 'planning', 'organize', 'routine'],
            'priority_setting': ['priority', 'focus', 'important', 'urgent', 'goals', 'objectives']
        }
    
    def generate_dynamic_prompt(self, model: str, context: Dict[str, Any]) -> str:
        """Generate dynamic prompt based on model and context."""
        template = self.templates.get(model, self.templates['universal_advisor'])
        
        # Extract context information
        query = context.get('query', '')
        user_context = context.get('user_context', {})
        required_capabilities = context.get('required_capabilities', [])
        
        # Build prompt components
        domains = self._identify_domains(query, required_capabilities)
        context_info = self._build_context_info(user_context)
        considerations = self._build_considerations(required_capabilities)
        objectives = self._build_objectives(query, required_capabilities)
        
        
        # Fill template based on model type
        if model == 'universal_life_advisor' and hasattr(template, 'base_template'):
            # This model expects specific placeholders
            try:
                prompt = template.base_template.format(
                    domains=', '.join(domains),
                    context_info=context_info,
                    considerations=considerations,
                    objectives=objectives
                )
            except KeyError as e:
                # Fallback
                prompt = self._build_fallback_prompt(model, domains, context_info, considerations)
        elif model in self.templates and hasattr(template, 'base_template'):
            # Other universal models
            try:
                prompt = template.base_template.format(
                    advisor_type=model.replace('_', ' ').title(),
                    specialty=', '.join(domains),
                    context=context_info,
                    capability_instructions=self._get_capability_instructions(required_capabilities, template),
                    output_format="Provide clear, actionable recommendations."
                )
            except KeyError as e:
                # Fallback
                prompt = self._build_fallback_prompt(model, domains, context_info, considerations)
        else:
            # Default fallback
            prompt = self._build_fallback_prompt(model, domains, context_info, considerations)
        
        return prompt
    
    def _build_fallback_prompt(self, model: str, domains: List[str], context_info: str, considerations: str) -> str:
        """Build fallback prompt when template fails."""
        prompt = f"You are a {model.replace('_', ' ')} specializing in {', '.join(domains)}. "
        prompt += f"{context_info}\n\n"
        if considerations:
            prompt += f"Consider the following aspects:\n{considerations}\n\n"
        prompt += "Provide clear, actionable recommendations."
        return prompt
    
    def generate_capability_focused_prompt(self, model: str, capability: str) -> str:
        """Generate prompt focused on specific capability."""
        base_prompt = f"You are a {model.replace('_', ' ')} with specialized expertise."
        
        # Add capability-specific instructions
        if capability in self.capability_keywords:
            keywords = self.capability_keywords[capability]
            capability_prompt = f"\n\nFocus specifically on aspects related to: {', '.join(keywords)}."
            
            # Add domain-specific guidance
            if capability == 'financial_planning':
                capability_prompt += "\n\nConsider budget constraints, financial goals, and long-term security."
            elif capability == 'music_career':
                capability_prompt += "\n\nAddress artistic development, industry networking, and performance excellence."
            elif capability == 'work_life_balance':
                capability_prompt += "\n\nBalance professional obligations with personal well-being and relationships."
                
        else:
            capability_prompt = f"\n\nFocus on {capability.replace('_', ' ')}."
        
        return base_prompt + capability_prompt + "\n\nProvide practical, actionable guidance."
    
    def generate_standard_prompt(self, context: Dict[str, Any]) -> str:
        """Generate standard unoptimized prompt."""
        query = context.get('query', '')
        history = context.get('history', [])
        constraints = context.get('constraints', [])
        
        prompt_parts = [
            f"Query: {query}",
            f"\nConversation History:",
            '\n'.join(f"- {h}" for h in history),
            f"\nConstraints to Consider:",
            '\n'.join(f"- {c}" for c in constraints),
            "\nProvide a comprehensive response addressing all aspects."
        ]
        
        return '\n'.join(prompt_parts)
    
    def generate_optimized_prompt(self, context: Dict[str, Any]) -> str:
        """Generate optimized prompt with length reduction."""
        query = context.get('query', '')
        history = context.get('history', [])
        constraints = context.get('constraints', [])
        
        # Extract key information
        key_terms = self._extract_key_terms(query)
        relevant_history = self._filter_relevant_history(history, key_terms)
        critical_constraints = self._prioritize_constraints(constraints)
        
        # Build concise prompt
        prompt_parts = [
            f"Task: {query}",
            f"Context: {self._summarize_history(relevant_history)}",
            f"Key constraints: {', '.join(critical_constraints[:3])}",
            "Provide focused, actionable response."
        ]
        
        return '\n'.join(prompt_parts)
    
    @lru_cache(maxsize=128)
    def count_tokens(self, text: str) -> int:
        """Count tokens in text."""
        return len(self.encoder.encode(text))
    
    def _identify_domains(self, query: str, capabilities: List[str]) -> List[str]:
        """Identify relevant domains from query and capabilities."""
        domains = set()
        query_lower = query.lower()
        
        # Check query against capability keywords
        for capability, keywords in self.capability_keywords.items():
            if any(keyword in query_lower for keyword in keywords):
                if 'financial' in capability:
                    domains.add('financial planning')
                elif 'music' in capability:
                    domains.add('creative arts')
                elif 'work' in capability or 'life' in capability:
                    domains.add('life optimization')
                    
        # Add domains from explicit capabilities
        for cap in capabilities:
            if 'financial' in cap:
                domains.add('financial planning')
            elif 'creative' in cap:
                domains.add('creative development')
            elif 'balance' in cap:
                domains.add('life optimization')
                
        return list(domains) or ['general advisory']
    
    def _build_context_info(self, user_context: Dict[str, Any]) -> str:
        """Build context information string."""
        parts = []
        
        if 'role' in user_context:
            parts.append(f"The user is a {user_context['role']}")
        if 'family' in user_context:
            parts.append(f"Family situation: {user_context['family']}")
        if 'goals' in user_context:
            parts.append(f"Goals: {user_context['goals']}")
            
        return '. '.join(parts) if parts else "The user seeks guidance."
    
    def _build_considerations(self, capabilities: List[str]) -> str:
        """Build considerations based on required capabilities."""
        considerations = []
        
        for cap in capabilities:
            if cap == 'work_life_balance':
                considerations.append("- Work-life balance and stress management")
            elif cap == 'scheduling':
                considerations.append("- Time optimization and routine development")
            elif cap == 'priority_setting':
                considerations.append("- Goal alignment and focus areas")
            elif cap == 'financial_analysis':
                considerations.append("- Financial health and resource allocation")
                
        return '\n'.join(considerations) if considerations else "- Holistic life optimization"
    
    def _build_objectives(self, query: str, capabilities: List[str]) -> str:
        """Build objectives for the response."""
        objectives = ["- Is immediately actionable", "- Addresses the specific query"]
        
        if 'balance' in ' '.join(capabilities):
            objectives.append("- Promotes sustainable life balance")
        if 'financial' in ' '.join(capabilities):
            objectives.append("- Optimizes financial outcomes")
        if 'scheduling' in ' '.join(capabilities):
            objectives.append("- Creates realistic timelines")
            
        return '\n'.join(objectives)
    
    def _get_capability_instructions(self, capabilities: List[str], template: PromptTemplate) -> str:
        """Get capability-specific instructions."""
        instructions = []
        
        for cap in capabilities:
            if cap in template.capability_modules:
                instructions.append(template.capability_modules[cap])
                
        return '\n\n'.join(instructions) if instructions else "Provide comprehensive guidance."
    
    def _extract_key_terms(self, query: str) -> List[str]:
        """Extract key terms from query."""
        # Remove common words
        stopwords = {'the', 'a', 'an', 'and', 'or', 'but', 'in', 'on', 'at', 'to', 'for'}
        words = query.lower().split()
        return [w for w in words if w not in stopwords and len(w) > 2]
    
    def _filter_relevant_history(self, history: List[str], key_terms: List[str]) -> List[str]:
        """Filter history for relevant items."""
        relevant = []
        for item in history:
            if any(term in item.lower() for term in key_terms):
                relevant.append(item)
        return relevant[-5:]  # Keep only last 5 relevant items
    
    def _prioritize_constraints(self, constraints: List[str]) -> List[str]:
        """Prioritize constraints by importance."""
        # Simple prioritization - could be enhanced with ML
        priority_keywords = ['critical', 'urgent', 'must', 'required', 'essential']
        
        prioritized = []
        regular = []
        
        for constraint in constraints:
            if any(keyword in constraint.lower() for keyword in priority_keywords):
                prioritized.append(constraint)
            else:
                regular.append(constraint)
                
        return prioritized + regular
    
    def _summarize_history(self, history: List[str]) -> str:
        """Summarize conversation history."""
        if not history:
            return "New conversation"
        elif len(history) <= 2:
            return '; '.join(history)
        else:
            return f"Discussed: {', '.join(self._extract_topics(history))}"
    
    def _extract_topics(self, history: List[str]) -> List[str]:
        """Extract main topics from history."""
        topics = set()
        for item in history:
            # Extract nouns and important phrases
            words = item.lower().split()
            for i, word in enumerate(words):
                if word in self.capability_keywords:
                    topics.add(word)
                elif i > 0 and words[i-1] in ['about', 'regarding', 'concerning']:
                    topics.add(word)
        return list(topics)[:3]


# Helper functions for testing
def generate_dynamic_prompt(model: str, context: Dict[str, Any]) -> str:
    """Generate dynamic prompt for testing."""
    optimizer = PromptOptimizer()
    return optimizer.generate_dynamic_prompt(model, context)


def generate_capability_focused_prompt(model: str, capability: str) -> str:
    """Generate capability-focused prompt for testing."""
    optimizer = PromptOptimizer()
    return optimizer.generate_capability_focused_prompt(model, capability)


def generate_standard_prompt(context: Dict[str, Any]) -> str:
    """Generate standard prompt for testing."""
    optimizer = PromptOptimizer()
    return optimizer.generate_standard_prompt(context)


def generate_optimized_prompt(context: Dict[str, Any]) -> str:
    """Generate optimized prompt for testing."""
    optimizer = PromptOptimizer()
    return optimizer.generate_optimized_prompt(context)


if __name__ == "__main__":
    # Example usage
    optimizer = PromptOptimizer()
    
    # Test dynamic prompt generation
    context = {
        'query': 'Balance work and family',
        'user_context': {
            'role': 'Risk Manager',
            'family': 'Single parent'
        },
        'required_capabilities': ['work_life_balance', 'scheduling', 'priority_setting']
    }
    
    prompt = optimizer.generate_dynamic_prompt('universal_life_advisor', context)
    print("Dynamic Prompt:")
    print(prompt)
    print(f"\nTokens: {optimizer.count_tokens(prompt)}")
    
    # Test optimization
    complex_context = {
        'query': 'Plan my entire week considering work deadlines, family time, music practice, and health',
        'history': ['Discussed work priorities', 'Talked about music goals', 'Mentioned family commitments'] * 3,
        'constraints': ['Limited time', 'Energy management needed', 'Financial constraints'] * 2
    }
    
    standard = optimizer.generate_standard_prompt(complex_context)
    optimized = optimizer.generate_optimized_prompt(complex_context)
    
    print(f"\n\nStandard prompt tokens: {optimizer.count_tokens(standard)}")
    print(f"Optimized prompt tokens: {optimizer.count_tokens(optimized)}")
    print(f"Reduction: {(1 - optimizer.count_tokens(optimized) / optimizer.count_tokens(standard)) * 100:.1f}%")