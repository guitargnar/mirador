#!/usr/bin/env python3
"""
Mirador Conductor Agent

This module implements the "conductor" agent that analyzes tasks and dynamically
selects the most relevant specialists for a given prompt.
"""

import os
import json
import time
import logging
import requests
from typing import Dict, List, Optional, Any, Union, Tuple

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler(os.path.join(os.path.dirname(__file__), "..", "logs", f"conductor_{time.strftime('%Y%m%d')}.log"))
    ]
)
logger = logging.getLogger("mirador-conductor")

# ANSI Colors for terminal output
GREEN = '\033[0;32m'
BLUE = '\033[0;34m'
YELLOW = '\033[1;33m'
RED = '\033[0;31m'
MAGENTA = '\033[0;35m'
BOLD = '\033[1m'
RESET = '\033[0m'

class ConductorAgent:
    """
    The Conductor Agent analyzes a prompt or task and determines the optimal
    sequence of specialist agents to use for solving it.
    """
    
    def __init__(self, config_path: Optional[str] = None):
        """
        Initialize the conductor agent.
        
        Args:
            config_path: Path to the configuration file. If None, uses default.
        """
        self.base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        
        # Use default config if not specified
        if config_path is None:
            config_path = os.path.join(self.base_dir, "config", "config.json")
            
        # Load configuration
        with open(config_path, 'r') as f:
            self.config = json.load(f)
            
        # Load specialist information
        self.specialists = self._load_specialists()
        
        # Load domain information for better matching
        self.domains = self._load_domains()
        
        logger.info(f"Conductor agent initialized with {len(self.specialists)} specialists")
        
    def _load_specialists(self) -> Dict[str, Dict]:
        """
        Load information about available specialists.
        
        Returns:
            Dictionary of specialist information.
        """
        # Create pattern matchers for each specialist type
        specialists = {
            "master_coder": {
                "patterns": ["code", "function", "class", "implementation", "programming", "script", "algorithm", "application"],
                "domains": ["software", "development", "programming", "coding", "technology"],
                "description": "Generates high-quality code implementations",
                "input_type": "requirements",
                "output_type": "code"
            },
            "code_reviewer_fix": {
                "patterns": ["review", "bug", "fix", "security", "performance", "improve", "optimize", "maintainability"],
                "domains": ["software", "security", "code quality", "testing"],
                "description": "Reviews and improves code for security and quality",
                "input_type": "code",
                "output_type": "improved code"
            },
            "file_reviewer": {
                "patterns": ["document", "documentation", "explain", "describe", "manual", "readme", "api", "instruction"],
                "domains": ["documentation", "technical writing", "communication"],
                "description": "Creates comprehensive documentation",
                "input_type": "code or concept",
                "output_type": "documentation"
            },
            "creative_entrepreneur": {
                "patterns": ["business", "product", "market", "monetize", "startup", "opportunity", "customer", "strategy"],
                "domains": ["business", "entrepreneurship", "marketing", "product management"],
                "description": "Identifies business applications and opportunities",
                "input_type": "solution or concept",
                "output_type": "business strategy"
            },
            "ux_designer": {
                "patterns": ["user", "interface", "ui", "ux", "design", "experience", "wireframe", "mockup", "usability"],
                "domains": ["design", "user experience", "interaction", "frontend"],
                "description": "Designs user interfaces for implementations",
                "input_type": "application concept",
                "output_type": "UI/UX design"
            },
            "guitar_expert_precise": {
                "patterns": ["guitar", "music", "chord", "scale", "lesson", "song", "riff", "technique", "practice"],
                "domains": ["music", "guitar", "teaching", "performance"],
                "description": "Provides professional-level guitar instruction",
                "input_type": "music question",
                "output_type": "guitar instruction"
            },
            "llama3.2_balanced": {
                "patterns": ["general", "information", "explain", "question", "analysis", "summary", "overview"],
                "domains": ["general knowledge", "explanation", "discussion"],
                "description": "General-purpose balanced analysis",
                "input_type": "general question",
                "output_type": "balanced response"
            },
            "fast_agent_focused": {
                "patterns": ["organize", "plan", "task", "structure", "schedule", "list", "steps", "brief"],
                "domains": ["productivity", "organization", "planning"],
                "description": "Organizes and structures information",
                "input_type": "unstructured content",
                "output_type": "structured plan"
            },
            "enhanced_agent": {
                "patterns": ["comprehensive", "detailed", "research", "in-depth", "thorough", "deep dive"],
                "domains": ["research", "analysis", "synthesis"],
                "description": "Provides comprehensive analysis and insights",
                "input_type": "complex question",
                "output_type": "detailed analysis"
            }
        }
        
        return specialists
    
    def _load_domains(self) -> Dict[str, List[str]]:
        """
        Load domain information for better matching.
        
        Returns:
            Dictionary mapping domains to relevant terms.
        """
        # Define domain-specific keyword mappings
        return {
            "software": ["code", "programming", "developer", "software", "application", "algorithm", "compile", "function"],
            "business": ["business", "startup", "entrepreneur", "market", "customer", "product", "revenue", "strategy"],
            "music": ["music", "guitar", "song", "chord", "scale", "riff", "practice", "play"],
            "design": ["design", "interface", "user experience", "ux", "ui", "wireframe", "mockup", "prototype"],
            "documentation": ["document", "readme", "manual", "instruction", "api", "reference", "guide", "tutorial"],
            "productivity": ["organize", "task", "plan", "schedule", "productivity", "efficiency", "workflow", "time management"]
        }
    
    def analyze_prompt(self, prompt: str) -> Dict[str, float]:
        """
        Analyze a prompt to determine which specialists would be most relevant.
        
        Args:
            prompt: The user's prompt or request
            
        Returns:
            Dictionary mapping specialist names to relevance scores (0-1)
        """
        prompt_lower = prompt.lower()
        
        # Track relevance scores for each specialist
        relevance_scores = {}
        
        # First pass: Check for explicit pattern matches
        for specialist, info in self.specialists.items():
            score = 0.0
            
            # Check for pattern matches
            for pattern in info["patterns"]:
                if pattern.lower() in prompt_lower:
                    score += 0.2
                    
            # Check for domain relevance
            for domain in info["domains"]:
                if domain.lower() in prompt_lower:
                    score += 0.2
                    
                # Check for domain-specific terms
                if domain in self.domains:
                    for term in self.domains[domain]:
                        if term.lower() in prompt_lower:
                            score += 0.1
            
            # Normalize score to 0-1 range
            score = min(1.0, score)
            relevance_scores[specialist] = score
            
        # Ensure we always have a fallback
        if all(score < 0.2 for score in relevance_scores.values()):
            # If no clear matches, use the general-purpose model
            relevance_scores["llama3.2_balanced"] = 0.7
            
        logger.info(f"Prompt analysis results: {relevance_scores}")
        return relevance_scores
    
    def select_specialists(self, prompt: str, max_specialists: int = 3) -> List[str]:
        """
        Select the most appropriate specialists for a given prompt.
        
        Args:
            prompt: The user's prompt or request
            max_specialists: Maximum number of specialists to select
            
        Returns:
            List of specialist names in the recommended execution order
        """
        # Analyze prompt for specialist relevance
        relevance_scores = self.analyze_prompt(prompt)
        
        # Sort specialists by relevance score (descending)
        sorted_specialists = sorted(
            relevance_scores.items(), 
            key=lambda x: x[1], 
            reverse=True
        )
        
        # Build optimal specialist chain based on known good combinations
        selected = []
        
        # Add specialists based on relevance and optimal chain logic
        for specialist, score in sorted_specialists:
            # Skip if below threshold
            if score < 0.2:
                continue
                
            # Add relevant specialists up to max_specialists
            if specialist not in selected and len(selected) < max_specialists:
                selected.append(specialist)
        
        # Apply chain optimization rules
        optimized_chain = self._optimize_chain(selected, prompt)
        
        return optimized_chain
    
    def _optimize_chain(self, specialists: List[str], prompt: str) -> List[str]:
        """
        Optimize the ordering of specialists based on known effective chains.
        
        Args:
            specialists: List of selected specialists
            prompt: The original prompt for context
            
        Returns:
            Reordered list of specialists
        """
        # If no specialists selected, use default chain
        if not specialists:
            return ["llama3.2_balanced", "enhanced_agent"]
            
        # Define common effective chain patterns
        chain_patterns = {
            "code": ["master_coder", "code_reviewer_fix", "file_reviewer"],
            "business": ["master_coder", "creative_entrepreneur"],
            "design": ["master_coder", "ux_designer"],
            "music": ["guitar_expert_precise", "fast_agent_focused"],
            "documentation": ["enhanced_agent", "file_reviewer"],
            "organization": ["enhanced_agent", "fast_agent_focused"]
        }
        
        # Check if we match any common chain patterns
        prompt_lower = prompt.lower()
        for domain, chain in chain_patterns.items():
            # Check if domain is relevant to the prompt
            domain_relevance = any(term in prompt_lower for term in self.domains.get(domain, [domain]))
            
            # Check if we have the first specialist in the chain
            has_first_specialist = chain[0] in specialists
            
            # If domain is relevant and we have the first specialist, use this chain
            if domain_relevance and has_first_specialist:
                # Filter chain to only include selected specialists
                filtered_chain = [s for s in chain if s in specialists]
                
                # Add any other selected specialists not in the pattern
                for s in specialists:
                    if s not in filtered_chain:
                        filtered_chain.append(s)
                        
                return filtered_chain[:min(len(filtered_chain), 3)]
        
        # Default: just return the specialists in original order
        return specialists
    
    def get_chain_explanation(self, specialists: List[str], prompt: str) -> str:
        """
        Generate an explanation of why this specialist chain was selected.
        
        Args:
            specialists: List of selected specialists
            prompt: The original prompt
            
        Returns:
            Human-readable explanation of the chain selection rationale
        """
        if not specialists:
            return "No suitable specialists were found for this prompt."
            
        explanation = [f"Based on your prompt: \"{prompt}\"\n"]
        explanation.append("The following specialist chain was selected:")
        
        for i, specialist in enumerate(specialists):
            info = self.specialists.get(specialist, {})
            description = info.get("description", "Unknown specialist")
            explanation.append(f"{i+1}. {specialist}: {description}")
            
        # Add reasoning if we have more than one specialist
        if len(specialists) > 1:
            explanation.append("\nRationale for this sequence:")
            
            # Code chain
            if "master_coder" in specialists and "code_reviewer_fix" in specialists:
                explanation.append("• Code implementation followed by security and quality review")
                
            # Documentation chain
            if "file_reviewer" in specialists and any(s in specialists for s in ["master_coder", "enhanced_agent"]):
                explanation.append("• Implementation followed by thorough documentation")
                
            # Business application chain
            if "creative_entrepreneur" in specialists and any(s in specialists for s in ["master_coder", "enhanced_agent"]):
                explanation.append("• Technical solution followed by business application analysis")
                
            # UI design chain
            if "ux_designer" in specialists and "master_coder" in specialists:
                explanation.append("• Implementation followed by user interface design")
                
            # Music chain
            if "guitar_expert_precise" in specialists and "fast_agent_focused" in specialists:
                explanation.append("• Guitar expertise followed by structured practice organization")
        
        return "\n".join(explanation)
    
    def ask_conductor(self, prompt: str) -> Dict[str, Any]:
        """
        Use the conductor model to analyze the prompt and recommend specialists.
        
        Args:
            prompt: The user's prompt or request
            
        Returns:
            Dictionary with recommended specialists and explanation
        """
        # Select specialists based on prompt analysis
        specialists = self.select_specialists(prompt)
        
        # Generate explanation for the selection
        explanation = self.get_chain_explanation(specialists, prompt)
        
        return {
            "specialists": specialists,
            "explanation": explanation,
            "prompt": prompt
        }

def main():
    """Main function for testing the conductor agent."""
    import argparse
    
    # Parse command line arguments
    parser = argparse.ArgumentParser(description="Mirador Conductor Agent")
    parser.add_argument("prompt", nargs="?", default=None, help="Prompt to analyze")
    args = parser.parse_args()
    
    # Initialize conductor
    conductor = ConductorAgent()
    
    # If no prompt provided, ask for one
    if not args.prompt:
        print(f"{MAGENTA}{BOLD}Mirador Conductor Agent{RESET}")
        print("This agent analyzes your prompt and selects the optimal specialist chain.")
        print("")
        args.prompt = input(f"{BLUE}Enter your prompt: {RESET}")
    
    # Analyze the prompt
    result = conductor.ask_conductor(args.prompt)
    
    # Print results
    print(f"\n{YELLOW}{BOLD}Conductor Analysis{RESET}")
    print(f"\n{result['explanation']}")
    
    print(f"\n{GREEN}{BOLD}Recommended Command:{RESET}")
    specialists_str = " ".join(result["specialists"])
    print(f"./scripts/run_chain.sh \"{args.prompt}\" {specialists_str}")
    
if __name__ == "__main__":
    main()