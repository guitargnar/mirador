#!/usr/bin/env python3
"""
Mirador Chain Debug Tool
Analyzes chain execution and content flow issues
"""

import subprocess
import json
import time
from pathlib import Path
from typing import Dict, List, Tuple, Optional
from dataclasses import dataclass
import logging
import tempfile
import os

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@dataclass
class ChainStep:
    model_name: str
    input_content: str
    output_content: str
    execution_time: float
    success: bool
    error_message: str = ""

class MiradorChainDebugger:
    """Debug chain execution and content flow issues"""
    
    def __init__(self, output_dir: str = "./chain_debug"):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        
        # Test chain configurations
        self.test_chains = [
            {
                "name": "simple_financial_chain",
                "models": ["financial_planning_expert_v6", "enhanced_agent_enforcer"],
                "query": "Create a basic budget for someone earning $75,000 annually"
            },
            {
                "name": "context_financial_chain", 
                "models": ["user_context_provider", "financial_planning_expert_v6"],
                "query": "Develop financial strategy for healthcare professional"
            },
            {
                "name": "full_decision_chain",
                "models": ["user_context_provider", "enhanced_agent_enforcer", "decision_simplifier"],
                "query": "Should I save for house or invest in retirement first?"
            }
        ]

    def test_individual_model_with_input(self, model_name: str, input_text: str, timeout: int = 45) -> ChainStep:
        """Test individual model with specific input"""
        logger.info(f"Testing {model_name} with input: {input_text[:50]}...")
        
        try:
            start_time = time.time()
            result = subprocess.run(
                ['ollama', 'run', model_name, input_text],
                capture_output=True,
                text=True,
                timeout=timeout
            )
            execution_time = time.time() - start_time
            
            if result.returncode != 0:
                return ChainStep(
                    model_name=model_name,
                    input_content=input_text,
                    output_content="",
                    execution_time=execution_time,
                    success=False,
                    error_message=f"Command failed: {result.stderr}"
                )
            
            output = result.stdout.strip()
            success = len(output) > 10 and not output.lower().startswith("error")
            
            return ChainStep(
                model_name=model_name,
                input_content=input_text,
                output_content=output,
                execution_time=execution_time,
                success=success,
                error_message="" if success else "Empty or invalid response"
            )
            
        except subprocess.TimeoutExpired:
            return ChainStep(
                model_name=model_name,
                input_content=input_text,
                output_content="",
                execution_time=timeout,
                success=False,
                error_message="Timeout"
            )
        except Exception as e:
            return ChainStep(
                model_name=model_name,
                input_content=input_text,
                output_content="",
                execution_time=0,
                success=False,
                error_message=f"Error: {e}"
            )

    def simulate_chain_execution(self, chain_config: Dict) -> List[ChainStep]:
        """Simulate chain execution step by step"""
        logger.info(f"Simulating chain: {chain_config['name']}")
        
        steps = []
        current_content = chain_config['query']
        
        for i, model_name in enumerate(chain_config['models']):
            # For first model, use original query
            # For subsequent models, use accumulated content
            if i == 0:
                input_content = current_content
            else:
                # Combine original query with previous outputs
                previous_outputs = " ".join([step.output_content for step in steps if step.success])
                input_content = f"Original request: {chain_config['query']}\n\nPrevious analysis: {previous_outputs}\n\nPlease continue the analysis:"
            
            step = self.test_individual_model_with_input(model_name, input_content)
            steps.append(step)
            
            # Update current content for next model
            if step.success and step.output_content:
                current_content = step.output_content
            
            # Log step result
            logger.info(f"Step {i+1}: {model_name} - {'✅' if step.success else '❌'} ({len(step.output_content)} chars)")
        
        return steps

    def analyze_chain_issues(self, chain_name: str, steps: List[ChainStep]) -> Dict:
        """Analyze issues in chain execution"""
        analysis = {
            "chain_name": chain_name,
            "total_steps": len(steps),
            "successful_steps": len([s for s in steps if s.success]),
            "failed_steps": len([s for s in steps if not s.success]),
            "total_execution_time": sum(s.execution_time for s in steps),
            "content_flow_broken": False,
            "empty_outputs": [],
            "timeout_models": [],
            "error_models": [],
            "working_models": [],
            "final_output_length": 0,
            "issues": []
        }
        
        # Analyze each step
        for i, step in enumerate(steps):
            if step.success:
                analysis["working_models"].append(step.model_name)
                if i == len(steps) - 1:  # Last step
                    analysis["final_output_length"] = len(step.output_content)
            else:
                if "timeout" in step.error_message.lower():
                    analysis["timeout_models"].append(step.model_name)
                elif "empty" in step.error_message.lower():
                    analysis["empty_outputs"].append(step.model_name)
                else:
                    analysis["error_models"].append(step.model_name)
        
        # Check for content flow issues
        if analysis["successful_steps"] > 0 and analysis["final_output_length"] == 0:
            analysis["content_flow_broken"] = True
            analysis["issues"].append("Content generated but lost in final step")
        
        if analysis["successful_steps"] == 0:
            analysis["issues"].append("No models produced any content")
        
        if len(analysis["empty_outputs"]) > 0:
            analysis["issues"].append(f"Models producing empty output: {', '.join(analysis['empty_outputs'])}")
        
        return analysis

    def run_comprehensive_chain_debug(self) -> Tuple[List[Dict], Dict]:
        """Run comprehensive chain debugging"""
        print("🔍 Running comprehensive chain debugging...")
        
        all_results = []
        overall_analysis = {
            "total_chains_tested": len(self.test_chains),
            "successful_chains": 0,
            "failed_chains": 0,
            "common_issues": [],
            "working_models": set(),
            "problematic_models": set()
        }
        
        for chain_config in self.test_chains:
            steps = self.simulate_chain_execution(chain_config)
            analysis = self.analyze_chain_issues(chain_config['name'], steps)
            
            result = {
                "config": chain_config,
                "steps": steps,
                "analysis": analysis
            }
            all_results.append(result)
            
            # Update overall analysis
            if analysis["final_output_length"] > 0:
                overall_analysis["successful_chains"] += 1
            else:
                overall_analysis["failed_chains"] += 1
            
            # Track working and problematic models
            overall_analysis["working_models"].update(analysis["working_models"])
            overall_analysis["problematic_models"].update(analysis["empty_outputs"] + analysis["timeout_models"] + analysis["error_models"])
        
        # Convert sets to lists for JSON serialization
        overall_analysis["working_models"] = list(overall_analysis["working_models"])
        overall_analysis["problematic_models"] = list(overall_analysis["problematic_models"])
        
        return all_results, overall_analysis

    def generate_chain_debug_report(self, results: List[Dict], overall_analysis: Dict):
        """Generate comprehensive chain debugging report"""
        report_path = self.output_dir / "chain_debug_report.md"
        
        with open(report_path, 'w') as f:
            f.write("# Mirador Chain Execution Debug Report\n\n")
            f.write(f"**Generated:** {subprocess.run(['date'], capture_output=True, text=True).stdout.strip()}\n\n")
            
            # Executive Summary
            f.write("## Executive Summary\n\n")
            f.write(f"**Chains Tested:** {overall_analysis['total_chains_tested']}\n")
            f.write(f"**Successful Chains:** {overall_analysis['successful_chains']}\n")
            f.write(f"**Failed Chains:** {overall_analysis['failed_chains']}\n")
            f.write(f"**Success Rate:** {overall_analysis['successful_chains']/overall_analysis['total_chains_tested']:.1%}\n\n")
            
            # Overall Model Performance
            f.write("## Model Performance Summary\n\n")
            f.write(f"**Working Models:** {', '.join(overall_analysis['working_models']) if overall_analysis['working_models'] else 'None'}\n")
            f.write(f"**Problematic Models:** {', '.join(overall_analysis['problematic_models']) if overall_analysis['problematic_models'] else 'None'}\n\n")
            
            # Detailed Chain Results
            f.write("## Detailed Chain Analysis\n\n")
            
            for result in results:
                config = result["config"]
                analysis = result["analysis"]
                steps = result["steps"]
                
                f.write(f"### {config['name']}\n\n")
                f.write(f"**Query:** {config['query']}\n")
                f.write(f"**Models:** {' → '.join(config['models'])}\n")
                f.write(f"**Success:** {'✅' if analysis['final_output_length'] > 0 else '❌'}\n")
                f.write(f"**Total Time:** {analysis['total_execution_time']:.1f}s\n")
                f.write(f"**Final Output Length:** {analysis['final_output_length']} characters\n\n")
                
                if analysis["issues"]:
                    f.write("**Issues Detected:**\n")
                    for issue in analysis["issues"]:
                        f.write(f"- {issue}\n")
                    f.write("\n")
                
                # Step-by-step breakdown
                f.write("**Step-by-Step Execution:**\n\n")
                f.write("| Step | Model | Status | Output Length | Time (s) | Error |\n")
                f.write("|------|-------|--------|---------------|----------|-------|\n")
                
                for i, step in enumerate(steps, 1):
                    status = "✅" if step.success else "❌"
                    error = step.error_message[:30] + "..." if len(step.error_message) > 30 else step.error_message
                    f.write(f"| {i} | {step.model_name} | {status} | {len(step.output_content)} | {step.execution_time:.1f} | {error} |\n")
                
                f.write("\n")
                
                # Show actual outputs for successful steps
                if any(step.success for step in steps):
                    f.write("**Sample Outputs:**\n\n")
                    for step in steps:
                        if step.success and step.output_content:
                            preview = step.output_content[:200] + "..." if len(step.output_content) > 200 else step.output_content
                            f.write(f"**{step.model_name}:** {preview}\n\n")
                
                f.write("---\n\n")
            
            # Recommendations
            f.write("## Recommendations\n\n")
            
            if overall_analysis["failed_chains"] == 0:
                f.write("✅ All chains are working correctly. Chain execution is functional.\n\n")
            elif overall_analysis["successful_chains"] == 0:
                f.write("🚨 **CRITICAL**: No chains are producing output. This indicates a fundamental issue.\n\n")
                f.write("**Immediate Actions:**\n")
                f.write("1. Run individual model content diagnostic\n")
                f.write("2. Check model configurations and prompts\n")
                f.write("3. Verify base models are functional\n\n")
            else:
                f.write("⚠️ **PARTIAL FUNCTIONALITY**: Some chains work, others don't.\n\n")
                f.write("**Recommended Actions:**\n")
                f.write("1. Focus on fixing problematic models\n")
                f.write("2. Use working models for immediate needs\n")
                f.write("3. Investigate chain-specific issues\n\n")
            
            # Next Steps
            f.write("## Next Steps\n\n")
            
            if overall_analysis["problematic_models"]:
                f.write("### Fix Problematic Models\n")
                for model in overall_analysis["problematic_models"]:
                    f.write(f"- **{model}**: Run individual diagnostic and repair\n")
                f.write("\n")
            
            if overall_analysis["working_models"]:
                f.write("### Leverage Working Models\n")
                f.write("Consider creating simplified chains using only working models:\n")
                for model in overall_analysis["working_models"]:
                    f.write(f"- **{model}**: Confirmed functional\n")
                f.write("\n")
            
            f.write("### Validation Commands\n")
            f.write("```bash\n")
            f.write("# Test individual models\n")
            f.write("python3 mirador_content_diagnostic.py\n\n")
            f.write("# Re-run chain debugging after fixes\n")
            f.write("python3 mirador_chain_debugger.py\n")
            f.write("```\n")
        
        logger.info(f"Chain debug report generated: {report_path}")

    def generate_simplified_chain_configs(self, overall_analysis: Dict):
        """Generate simplified chain configurations using only working models"""
        if not overall_analysis["working_models"]:
            return
        
        config_path = self.output_dir / "simplified_chains.json"
        
        working_models = overall_analysis["working_models"]
        
        simplified_chains = []
        
        # Create chains using only working models
        if "enhanced_agent_enforcer" in working_models:
            simplified_chains.append({
                "name": "single_enforcer_chain",
                "models": ["enhanced_agent_enforcer"],
                "description": "Single model chain using only the working enforcer model"
            })
        
        if "user_context_provider" in working_models and "enhanced_agent_enforcer" in working_models:
            simplified_chains.append({
                "name": "context_enforcer_chain",
                "models": ["user_context_provider", "enhanced_agent_enforcer"],
                "description": "Two-model chain using working context and enforcer models"
            })
        
        # Add other combinations based on working models
        if len(working_models) >= 2:
            simplified_chains.append({
                "name": "working_models_chain",
                "models": working_models[:3],  # Use up to 3 working models
                "description": "Chain using all confirmed working models"
            })
        
        with open(config_path, 'w') as f:
            json.dump({
                "simplified_chains": simplified_chains,
                "working_models": working_models,
                "generated_at": subprocess.run(['date'], capture_output=True, text=True).stdout.strip()
            }, f, indent=2)
        
        logger.info(f"Simplified chain configurations generated: {config_path}")

def main():
    """Main execution function"""
    print("🔍 Mirador Chain Execution Debugger")
    print("=" * 45)
    
    debugger = MiradorChainDebugger()
    
    print("🧪 Testing chain execution patterns...")
    results, overall_analysis = debugger.run_comprehensive_chain_debug()
    
    print("📝 Generating debug report...")
    debugger.generate_chain_debug_report(results, overall_analysis)
    
    print("⚙️ Generating simplified chain configs...")
    debugger.generate_simplified_chain_configs(overall_analysis)
    
    # Summary
    print(f"\n✅ Chain Debug Complete!")
    print(f"📊 Chains tested: {overall_analysis['total_chains_tested']}")
    print(f"✅ Successful: {overall_analysis['successful_chains']}")
    print(f"❌ Failed: {overall_analysis['failed_chains']}")
    print(f"📈 Success rate: {overall_analysis['successful_chains']/overall_analysis['total_chains_tested']:.1%}")
    print(f"📁 Reports: {debugger.output_dir}")
    
    if overall_analysis["working_models"]:
        print(f"\n✅ Working models found: {', '.join(overall_analysis['working_models'])}")
    
    if overall_analysis["problematic_models"]:
        print(f"\n❌ Problematic models: {', '.join(overall_analysis['problematic_models'])}")
        print("Run individual model diagnostic to fix these models.")

if __name__ == "__main__":
    main()

