#!/usr/bin/env python3
"""
Mirador AI Orchestration Engine
Core system for managing multi-agent AI chains and intelligent routing
"""

import os
import sys
import json
import time
import subprocess
import argparse
import re
from datetime import datetime
from pathlib import Path
from typing import List, Dict, Optional, Tuple

class MiradorOrchestrator:
    """Core orchestration engine for Mirador AI system"""
    
    def __init__(self, base_dir: str = None):
        self.base_dir = Path(base_dir) if base_dir else Path.home() / "ai_framework_git"
        self.outputs_dir = self.base_dir / "outputs"
        self.outputs_dir.mkdir(parents=True, exist_ok=True)
        
        # Core model configurations
        self.core_models = {
            'matthew_context_provider_v2': 'Personal context and values alignment',
            'enhanced_agent_enforcer_v2': 'Strategic implementation and analysis',
            'decision_simplifier_v2': 'Action-focused synthesis and recommendations',
            'financial_planning_expert_v6': 'Financial planning and investment guidance',
            'louisville_expert_v3': 'Local market and community intelligence',
            'mirador_system_specialist_v2': 'System optimization and meta-analysis'
        }
        
        # Predefined chain configurations
        self.chain_configs = {
            'financial': ['matthew_context_provider_v2', 'financial_planning_expert_v6', 'decision_simplifier_v2'],
            'career': ['matthew_context_provider_v2', 'enhanced_agent_enforcer_v2', 'decision_simplifier_v2'],
            'louisville': ['matthew_context_provider_v2', 'louisville_expert_v3', 'decision_simplifier_v2'],
            'comprehensive': ['matthew_context_provider_v2', 'mirador_system_specialist_v2', 'enhanced_agent_enforcer_v2', 'decision_simplifier_v2'],
            'standard': ['matthew_context_provider_v2', 'enhanced_agent_enforcer_v2', 'decision_simplifier_v2']
        }
    
    def check_ollama_status(self) -> bool:
        """Check if Ollama service is running"""
        try:
            result = subprocess.run(['ollama', 'list'], capture_output=True, text=True, timeout=10)
            return result.returncode == 0
        except (subprocess.TimeoutExpired, FileNotFoundError):
            return False
    
    def get_available_models(self) -> List[str]:
        """Get list of available models from Ollama"""
        try:
            result = subprocess.run(['ollama', 'list'], capture_output=True, text=True, timeout=10)
            if result.returncode == 0:
                lines = result.stdout.strip().split('\n')[1:]  # Skip header
                models = []
                for line in lines:
                    if line.strip():
                        model_name = line.split()[0]
                        if ':' in model_name:
                            model_name = model_name.split(':')[0]
                        models.append(model_name)
                return models
            return []
        except (subprocess.TimeoutExpired, FileNotFoundError):
            return []
    
    def intelligent_chain_selection(self, query: str) -> List[str]:
        """Automatically select optimal chain based on query analysis"""
        query_lower = query.lower()
        
        # Financial queries
        if re.search(r'\b(money|investment|budget|financial|retire|401k|save|spend|income|wealth)\b', query_lower):
            return self.chain_configs['financial']
        
        # Louisville/Local queries
        elif re.search(r'\b(louisville|kentucky|local|community|neighborhood|market)\b', query_lower):
            return self.chain_configs['louisville']
        
        # Career/Business queries
        elif re.search(r'\b(career|job|business|opportunity|strategy|growth|professional)\b', query_lower):
            return self.chain_configs['career']
        
        # Complex analysis queries
        elif re.search(r'\b(analyze|comprehensive|strategy|plan|complex|detailed)\b', query_lower):
            return self.chain_configs['comprehensive']
        
        # Default to standard chain
        else:
            return self.chain_configs['standard']
    
    def execute_model_query(self, model: str, prompt: str, timeout: int = 60) -> Tuple[str, bool]:
        """Execute a single model query with timeout handling"""
        try:
            print(f"Querying {model}...")
            
            # Construct the ollama command
            cmd = ['ollama', 'run', model, prompt]
            
            # Execute with timeout
            result = subprocess.run(
                cmd, 
                capture_output=True, 
                text=True, 
                timeout=timeout
            )
            
            if result.returncode == 0:
                return result.stdout.strip(), True
            else:
                error_msg = f"Model {model} returned error: {result.stderr}"
                print(f"Error: {error_msg}")
                return error_msg, False
                
        except subprocess.TimeoutExpired:
            error_msg = f"Model {model} timed out after {timeout} seconds"
            print(f"Timeout: {error_msg}")
            return error_msg, False
        except Exception as e:
            error_msg = f"Error executing {model}: {str(e)}"
            print(f"Exception: {error_msg}")
            return error_msg, False
    
    def execute_chain(self, models: List[str], initial_prompt: str, timeout_per_model: int = 60) -> Dict:
        """Execute a chain of models with progressive prompt enhancement"""
        
        # Create output directory
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        output_dir = self.outputs_dir / f"chain_{timestamp}"
        output_dir.mkdir(exist_ok=True)
        
        print(f"Running chain with {len(models)} models")
        print(f"Models: {', '.join(models)}")
        print(f"Output directory: {output_dir}")
        print()
        
        # Initialize chain execution data
        chain_data = {
            'timestamp': timestamp,
            'initial_prompt': initial_prompt,
            'models': models,
            'outputs': {},
            'execution_times': {},
            'success_status': {},
            'total_time': 0
        }
        
        current_prompt = initial_prompt
        start_time = time.time()
        
        # Progress tracking
        total_models = len(models)
        
        for i, model in enumerate(models, 1):
            model_start_time = time.time()
            
            # Progress visualization
            progress = int((i-1) / total_models * 30)
            progress_bar = "[" + "=" * progress + " " * (30 - progress) + "]"
            print(f"Progress: {progress_bar} {int((i-1)/total_models*100)}%")
            print(f"Step {i}/{total_models}: Running {model}")
            
            # Execute model
            output, success = self.execute_model_query(model, current_prompt, timeout_per_model)
            
            model_time = time.time() - model_start_time
            
            # Store results
            chain_data['outputs'][model] = output
            chain_data['execution_times'][model] = model_time
            chain_data['success_status'][model] = success
            
            # Save individual model output
            model_output_file = output_dir / f"{i:02d}_{model}.md"
            with open(model_output_file, 'w') as f:
                f.write(f"# {model} Output\n\n")
                f.write(f"**Execution Time:** {model_time:.2f} seconds\n")
                f.write(f"**Success:** {success}\n\n")
                f.write(f"## Input Prompt\n\n{current_prompt}\n\n")
                f.write(f"## Output\n\n{output}\n")
            
            if success:
                # For chain execution, each model builds on the previous output
                if i < total_models:
                    current_prompt = f"Previous analysis: {output}\n\nBuilding on this analysis, {initial_prompt}"
                print(f"✅ {model} completed in {model_time:.2f}s")
            else:
                print(f"❌ {model} failed after {model_time:.2f}s")
                # Continue with original prompt if model fails
            
            print()
        
        # Calculate total execution time
        total_time = time.time() - start_time
        chain_data['total_time'] = total_time
        
        # Generate summary
        self.generate_chain_summary(chain_data, output_dir)
        
        print(f"✅ Chain execution complete in {total_time:.2f} seconds")
        print(f"📁 Results saved to: {output_dir}")
        
        return chain_data
    
    def generate_chain_summary(self, chain_data: Dict, output_dir: Path):
        """Generate a comprehensive summary of the chain execution"""
        
        summary_file = output_dir / "summary.md"
        
        with open(summary_file, 'w') as f:
            f.write("# Chain Execution Results\n\n")
            f.write(f"## Initial Prompt\n\n{chain_data['initial_prompt']}\n\n")
            f.write(f"## Models Used\n\n")
            
            for i, model in enumerate(chain_data['models'], 1):
                success = chain_data['success_status'][model]
                exec_time = chain_data['execution_times'][model]
                status_icon = "✅" if success else "❌"
                f.write(f"{i}. {model} {status_icon} (execution time: {exec_time:.2f}s)\n")
            
            f.write(f"\n## Execution Summary\n\n")
            f.write(f"- **Total execution time:** {chain_data['total_time']:.2f} seconds\n")
            f.write(f"- **Models executed:** {len(chain_data['models'])}\n")
            f.write(f"- **Successful models:** {sum(chain_data['success_status'].values())}\n")
            f.write(f"- **Output directory:** {output_dir}\n\n")
            
            # Include final output if available
            if chain_data['models']:
                final_model = chain_data['models'][-1]
                if chain_data['success_status'][final_model]:
                    f.write(f"## Final Recommendations\n\n")
                    f.write(f"*From {final_model}:*\n\n")
                    f.write(f"{chain_data['outputs'][final_model]}\n\n")
            
            f.write(f"## Chain Transformation Visualization\n\n")
            f.write(f"This section visualizes how each specialist transformed the solution:\n\n")
            f.write(f"### Progress Path\n\n")
            f.write(f"```\n")
            f.write(f"Initial Prompt → {' → '.join(chain_data['models'])}\n")
            f.write(f"```\n\n")
            
            f.write(f"### Contribution Analysis\n\n")
            f.write(f"| Step | Specialist | Processing Time | Success | Key Contribution |\n")
            f.write(f"|------|------------|-----------------|---------|------------------|\n")
            f.write(f"| 0 | Initial Prompt | - | ✅ | Starting point |\n")
            
            for i, model in enumerate(chain_data['models'], 1):
                success = "✅" if chain_data['success_status'][model] else "❌"
                exec_time = f"{chain_data['execution_times'][model]:.2f}s"
                contribution = "Analysis and refinement" if i < len(chain_data['models']) else "Final synthesis"
                f.write(f"| {i} | {model} | {exec_time} | {success} | {contribution} |\n")
    
    def ask_single_model(self, model: str, prompt: str) -> str:
        """Execute a single model query"""
        if not self.check_ollama_status():
            return "Error: Ollama service is not running. Please start Ollama first."
        
        available_models = self.get_available_models()
        if model not in available_models:
            return f"Error: Model '{model}' not found. Available models: {', '.join(available_models)}"
        
        print(f"Querying {model}...")
        output, success = self.execute_model_query(model, prompt)
        
        if success:
            return output
        else:
            return f"Error executing {model}: {output}"
    
    def run_chain(self, prompt: str, models: List[str] = None) -> str:
        """Execute a model chain"""
        if not self.check_ollama_status():
            return "Error: Ollama service is not running. Please start Ollama first."
        
        # Use intelligent chain selection if no models specified
        if not models:
            models = self.intelligent_chain_selection(prompt)
            print(f"🧠 Intelligent routing selected: {' → '.join(models)}")
        
        # Validate models exist
        available_models = self.get_available_models()
        missing_models = [m for m in models if m not in available_models]
        
        if missing_models:
            return f"Error: Missing models: {', '.join(missing_models)}. Available: {', '.join(available_models)}"
        
        # Execute chain
        try:
            chain_data = self.execute_chain(models, prompt)
            
            # Return final output
            if models and chain_data['success_status'].get(models[-1], False):
                return chain_data['outputs'][models[-1]]
            else:
                return "Chain execution completed with errors. Check output directory for details."
                
        except Exception as e:
            return f"Error executing chain: {str(e)}"

def main():
    """Main CLI interface"""
    parser = argparse.ArgumentParser(description='Mirador AI Orchestration System')
    subparsers = parser.add_subparsers(dest='command', help='Available commands')
    
    # Ask command
    ask_parser = subparsers.add_parser('ask', help='Query a single model')
    ask_parser.add_argument('model', help='Model name to query')
    ask_parser.add_argument('prompt', help='Prompt to send to the model')
    
    # Chain command
    chain_parser = subparsers.add_parser('chain', help='Execute a model chain')
    chain_parser.add_argument('prompt', help='Initial prompt for the chain')
    chain_parser.add_argument('models', nargs='*', help='Models to use in chain (optional - will auto-select if not provided)')
    
    # Status command
    status_parser = subparsers.add_parser('status', help='Check system status')
    
    args = parser.parse_args()
    
    if not args.command:
        parser.print_help()
        return
    
    orchestrator = MiradorOrchestrator()
    
    if args.command == 'ask':
        result = orchestrator.ask_single_model(args.model, args.prompt)
        print(f"\nResponse:\n{result}")
        
    elif args.command == 'chain':
        models = args.models if args.models else None
        result = orchestrator.run_chain(args.prompt, models)
        print(f"\nFinal Result:\n{result}")
        
    elif args.command == 'status':
        print("🔍 Mirador System Status")
        print("=" * 30)
        
        if orchestrator.check_ollama_status():
            print("✅ Ollama service: RUNNING")
            models = orchestrator.get_available_models()
            print(f"🤖 Available models: {len(models)}")
            
            # Check for core models
            missing_core = [m for m in orchestrator.core_models.keys() if m not in models]
            if missing_core:
                print(f"⚠️  Missing core models: {', '.join(missing_core)}")
            else:
                print("✅ All core models available")
                
        else:
            print("❌ Ollama service: NOT RUNNING")
            print("Please start Ollama with: ollama serve")

if __name__ == "__main__":
    main()

