#!/usr/bin/env python3
"""
Mirador Content Generation Diagnostic Tool
Diagnoses and resolves content generation failures in Mirador models
"""

import subprocess
import json
import time
from pathlib import Path
from typing import Dict, List, Tuple, Optional
from dataclasses import dataclass
import logging
import re

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@dataclass
class ModelTest:
    name: str
    test_query: str
    expected_min_words: int
    category: str

@dataclass
class ModelResult:
    name: str
    success: bool
    response_length: int
    response_time: float
    error_message: str = ""
    response_preview: str = ""

class MiradorContentDiagnostic:
    """Diagnoses content generation failures in Mirador models"""
    
    def __init__(self, output_dir: str = "./content_diagnostic"):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        
        # Test cases for each critical model
        self.model_tests = [
            ModelTest(
                name="matthew_context_provider",
                test_query="Provide brief context about Matthew's current situation and goals.",
                expected_min_words=20,
                category="context_provider"
            ),
            ModelTest(
                name="matthew_context_provider_v2", 
                test_query="Provide brief context about Matthew's current situation and goals.",
                expected_min_words=20,
                category="context_provider"
            ),
            ModelTest(
                name="financial_planning_expert_v6",
                test_query="What are the key components of a basic monthly budget?",
                expected_min_words=30,
                category="financial_planning"
            ),
            ModelTest(
                name="enhanced_agent_enforcer",
                test_query="Review this statement for accuracy: Louisville is the capital of Kentucky.",
                expected_min_words=15,
                category="quality_assurance"
            ),
            ModelTest(
                name="enhanced_agent_enforcer_v2",
                test_query="Review this statement for accuracy: Louisville is the capital of Kentucky.",
                expected_min_words=15,
                category="quality_assurance"
            ),
            ModelTest(
                name="decision_simplifier",
                test_query="Summarize these options: 1) Save money in bank, 2) Invest in stocks, 3) Buy real estate.",
                expected_min_words=20,
                category="decision_support"
            ),
            ModelTest(
                name="decision_simplifier_v2",
                test_query="Summarize these options: 1) Save money in bank, 2) Invest in stocks, 3) Buy real estate.",
                expected_min_words=20,
                category="decision_support"
            ),
            ModelTest(
                name="louisville_expert_v3",
                test_query="What is one advantage of living in Louisville, Kentucky?",
                expected_min_words=15,
                category="local_expert"
            )
        ]

    def test_individual_model(self, model_test: ModelTest, timeout: int = 45) -> ModelResult:
        """Test individual model for content generation"""
        logger.info(f"Testing {model_test.name}...")
        
        try:
            start_time = time.time()
            result = subprocess.run(
                ['ollama', 'run', model_test.name, model_test.test_query],
                capture_output=True,
                text=True,
                timeout=timeout
            )
            response_time = time.time() - start_time
            
            if result.returncode != 0:
                return ModelResult(
                    name=model_test.name,
                    success=False,
                    response_length=0,
                    response_time=response_time,
                    error_message=f"Command failed: {result.stderr}",
                    response_preview=""
                )
            
            response = result.stdout.strip()
            word_count = len(response.split()) if response else 0
            
            # Check if response meets minimum requirements
            success = (
                word_count >= model_test.expected_min_words and
                len(response) > 10 and
                not response.lower().startswith("error") and
                not response.lower().startswith("sorry")
            )
            
            preview = response[:200] + "..." if len(response) > 200 else response
            
            return ModelResult(
                name=model_test.name,
                success=success,
                response_length=word_count,
                response_time=response_time,
                error_message="" if success else f"Response too short or invalid: {word_count} words",
                response_preview=preview
            )
            
        except subprocess.TimeoutExpired:
            return ModelResult(
                name=model_test.name,
                success=False,
                response_length=0,
                response_time=timeout,
                error_message="Timeout - model did not respond within time limit",
                response_preview=""
            )
        except Exception as e:
            return ModelResult(
                name=model_test.name,
                success=False,
                response_length=0,
                response_time=0,
                error_message=f"Unexpected error: {e}",
                response_preview=""
            )

    def get_model_configuration(self, model_name: str) -> Dict:
        """Get model configuration details"""
        try:
            result = subprocess.run(
                ['ollama', 'show', model_name],
                capture_output=True,
                text=True,
                timeout=30
            )
            
            if result.returncode != 0:
                return {"error": f"Failed to get config: {result.stderr}"}
            
            config_text = result.stdout
            
            # Parse key configuration elements
            config = {
                "raw_output": config_text,
                "has_modelfile": "Modelfile" in config_text,
                "has_system_prompt": "SYSTEM" in config_text.upper(),
                "has_template": "TEMPLATE" in config_text.upper(),
                "base_model": "unknown"
            }
            
            # Extract base model
            for line in config_text.split('\n'):
                if line.strip().startswith('FROM'):
                    config["base_model"] = line.strip().split()[1] if len(line.strip().split()) > 1 else "unknown"
                    break
            
            return config
            
        except Exception as e:
            return {"error": f"Error getting configuration: {e}"}

    def run_comprehensive_diagnosis(self) -> Tuple[List[ModelResult], Dict]:
        """Run comprehensive content generation diagnosis"""
        print("🔍 Running comprehensive content generation diagnosis...")
        
        results = []
        configurations = {}
        
        # Test each model
        for model_test in self.model_tests:
            result = self.test_individual_model(model_test)
            results.append(result)
            
            # Get configuration for failed models
            if not result.success:
                configurations[model_test.name] = self.get_model_configuration(model_test.name)
        
        return results, configurations

    def analyze_failure_patterns(self, results: List[ModelResult]) -> Dict:
        """Analyze patterns in model failures"""
        analysis = {
            "total_models": len(results),
            "successful_models": len([r for r in results if r.success]),
            "failed_models": len([r for r in results if not r.success]),
            "success_rate": 0,
            "failure_categories": {},
            "working_models": [],
            "failed_models_list": [],
            "average_response_time": 0,
            "timeout_failures": 0,
            "content_failures": 0,
            "error_failures": 0
        }
        
        if results:
            analysis["success_rate"] = analysis["successful_models"] / analysis["total_models"]
            analysis["average_response_time"] = sum(r.response_time for r in results) / len(results)
        
        # Categorize failures
        for result in results:
            if result.success:
                analysis["working_models"].append(result.name)
            else:
                analysis["failed_models_list"].append(result.name)
                
                if "timeout" in result.error_message.lower():
                    analysis["timeout_failures"] += 1
                elif "too short" in result.error_message.lower():
                    analysis["content_failures"] += 1
                else:
                    analysis["error_failures"] += 1
        
        return analysis

    def generate_repair_scripts(self, results: List[ModelResult], configurations: Dict):
        """Generate scripts to repair failed models"""
        
        # Model repair script
        repair_script = self.output_dir / "repair_content_generation.sh"
        with open(repair_script, 'w') as f:
            f.write("#!/bin/bash\n")
            f.write("# Mirador Content Generation Repair Script\n")
            f.write("# Generated based on diagnostic results\n\n")
            f.write("set -e\n\n")
            f.write("echo \"🔧 Repairing Mirador content generation issues...\"\n\n")
            
            failed_models = [r for r in results if not r.success]
            
            if failed_models:
                f.write("# Failed models detected - attempting repair\n")
                for result in failed_models:
                    f.write(f"\necho \"Checking {result.name}...\"\n")
                    
                    # Check if model exists
                    f.write(f"if ollama list | grep -q '{result.name}'; then\n")
                    f.write(f"    echo \"Model {result.name} exists, checking configuration...\"\n")
                    f.write(f"    ollama show {result.name} > /tmp/{result.name}_config.txt\n")
                    
                    # Check for common issues
                    f.write(f"    if ! grep -q 'SYSTEM' /tmp/{result.name}_config.txt; then\n")
                    f.write(f"        echo \"⚠️  {result.name} missing SYSTEM prompt - may need rebuilding\"\n")
                    f.write(f"    fi\n")
                    f.write(f"    if ! grep -q 'FROM' /tmp/{result.name}_config.txt; then\n")
                    f.write(f"        echo \"⚠️  {result.name} missing base model - may be corrupted\"\n")
                    f.write(f"    fi\n")
                    f.write("else\n")
                    f.write(f"    echo \"❌ Model {result.name} not found in Ollama\"\n")
                    f.write("fi\n")
            
            f.write("\necho \"🎉 Diagnostic complete. Check output above for issues.\"\n")
            f.write("echo \"If models need rebuilding, look for corresponding .modelfile files.\"\n")
        
        repair_script.chmod(0o755)
        
        # Model rebuild script template
        rebuild_script = self.output_dir / "rebuild_failed_models.sh"
        with open(rebuild_script, 'w') as f:
            f.write("#!/bin/bash\n")
            f.write("# Rebuild Failed Mirador Models\n")
            f.write("# Edit this script to point to your .modelfile locations\n\n")
            f.write("set -e\n\n")
            f.write("echo \"🔨 Rebuilding failed Mirador models...\"\n\n")
            
            f.write("# Set your modelfile directory\n")
            f.write("MODELFILE_DIR=\".\"\n\n")
            
            failed_models = [r for r in results if not r.success]
            for result in failed_models:
                f.write(f"# Rebuild {result.name}\n")
                f.write(f"if [ -f \"$MODELFILE_DIR/{result.name}.modelfile\" ]; then\n")
                f.write(f"    echo \"Rebuilding {result.name}...\"\n")
                f.write(f"    ollama create {result.name} -f \"$MODELFILE_DIR/{result.name}.modelfile\"\n")
                f.write(f"    echo \"✅ {result.name} rebuilt\"\n")
                f.write("else\n")
                f.write(f"    echo \"⚠️  Modelfile not found: $MODELFILE_DIR/{result.name}.modelfile\"\n")
                f.write("fi\n\n")
            
            f.write("echo \"🎉 Model rebuilding complete!\"\n")
        
        rebuild_script.chmod(0o755)
        
        # Validation script
        validation_script = self.output_dir / "validate_content_generation.sh"
        with open(validation_script, 'w') as f:
            f.write("#!/bin/bash\n")
            f.write("# Validate Content Generation After Repairs\n\n")
            f.write("echo \"🧪 Validating content generation...\"\n\n")
            
            for model_test in self.model_tests:
                f.write(f"echo \"Testing {model_test.name}...\"\n")
                f.write(f"if timeout 30 ollama run {model_test.name} \"{model_test.test_query}\" | wc -w | awk '{{if($1 >= {model_test.expected_min_words}) print \"✅ {model_test.name} working (\" $1 \" words)\"; else print \"❌ {model_test.name} failed (\" $1 \" words)\"}}'; then\n")
                f.write("    true\n")
                f.write("else\n")
                f.write(f"    echo \"❌ {model_test.name} failed to respond\"\n")
                f.write("fi\n\n")
            
            f.write("echo \"🎉 Validation complete!\"\n")
        
        validation_script.chmod(0o755)
        
        logger.info(f"Generated repair scripts: {repair_script}, {rebuild_script}, {validation_script}")

    def generate_diagnostic_report(self, results: List[ModelResult], configurations: Dict, analysis: Dict):
        """Generate comprehensive diagnostic report"""
        report_path = self.output_dir / "content_generation_diagnostic_report.md"
        
        with open(report_path, 'w') as f:
            f.write("# Mirador Content Generation Diagnostic Report\n\n")
            f.write(f"**Generated:** {subprocess.run(['date'], capture_output=True, text=True).stdout.strip()}\n\n")
            
            # Executive Summary
            f.write("## Executive Summary\n\n")
            f.write(f"**Total Models Tested:** {analysis['total_models']}\n")
            f.write(f"**Working Models:** {analysis['successful_models']}\n")
            f.write(f"**Failed Models:** {analysis['failed_models']}\n")
            f.write(f"**Success Rate:** {analysis['success_rate']:.1%}\n")
            f.write(f"**Average Response Time:** {analysis['average_response_time']:.1f} seconds\n\n")
            
            # Severity Assessment
            if analysis['success_rate'] < 0.5:
                f.write("🚨 **CRITICAL**: Less than 50% of models are functional\n\n")
            elif analysis['success_rate'] < 0.8:
                f.write("⚠️ **WARNING**: Significant model functionality issues\n\n")
            else:
                f.write("✅ **GOOD**: Most models are functional\n\n")
            
            # Working Models
            if analysis['working_models']:
                f.write("## ✅ Working Models\n\n")
                for model_name in analysis['working_models']:
                    result = next(r for r in results if r.name == model_name)
                    f.write(f"- **{model_name}**: {result.response_length} words in {result.response_time:.1f}s\n")
                f.write("\n")
            
            # Failed Models
            if analysis['failed_models_list']:
                f.write("## ❌ Failed Models\n\n")
                for model_name in analysis['failed_models_list']:
                    result = next(r for r in results if r.name == model_name)
                    f.write(f"### {model_name}\n")
                    f.write(f"- **Error**: {result.error_message}\n")
                    f.write(f"- **Response Time**: {result.response_time:.1f}s\n")
                    if result.response_preview:
                        f.write(f"- **Response Preview**: {result.response_preview}\n")
                    f.write("\n")
            
            # Failure Analysis
            f.write("## Failure Analysis\n\n")
            f.write(f"- **Timeout Failures**: {analysis['timeout_failures']}\n")
            f.write(f"- **Content Generation Failures**: {analysis['content_failures']}\n")
            f.write(f"- **Error Failures**: {analysis['error_failures']}\n\n")
            
            # Configuration Issues
            if configurations:
                f.write("## Configuration Analysis\n\n")
                for model_name, config in configurations.items():
                    f.write(f"### {model_name}\n")
                    if "error" in config:
                        f.write(f"- **Error**: {config['error']}\n")
                    else:
                        f.write(f"- **Base Model**: {config.get('base_model', 'unknown')}\n")
                        f.write(f"- **Has System Prompt**: {config.get('has_system_prompt', False)}\n")
                        f.write(f"- **Has Template**: {config.get('has_template', False)}\n")
                    f.write("\n")
            
            # Detailed Test Results
            f.write("## Detailed Test Results\n\n")
            f.write("| Model | Status | Words | Time (s) | Error |\n")
            f.write("|-------|--------|-------|----------|-------|\n")
            
            for result in results:
                status = "✅ Pass" if result.success else "❌ Fail"
                error = result.error_message[:50] + "..." if len(result.error_message) > 50 else result.error_message
                f.write(f"| {result.name} | {status} | {result.response_length} | {result.response_time:.1f} | {error} |\n")
            
            f.write("\n")
            
            # Immediate Actions
            f.write("## Immediate Action Plan\n\n")
            
            if analysis['failed_models'] > 0:
                f.write("### Step 1: Run Diagnostic Script\n")
                f.write("```bash\n")
                f.write("./repair_content_generation.sh\n")
                f.write("```\n\n")
                
                f.write("### Step 2: Rebuild Failed Models (if needed)\n")
                f.write("Edit the rebuild script to point to your modelfile directory, then run:\n")
                f.write("```bash\n")
                f.write("./rebuild_failed_models.sh\n")
                f.write("```\n\n")
                
                f.write("### Step 3: Validate Repairs\n")
                f.write("```bash\n")
                f.write("./validate_content_generation.sh\n")
                f.write("```\n\n")
            else:
                f.write("All models are working correctly. No immediate action required.\n\n")
            
            # Next Steps
            f.write("## Next Steps\n\n")
            if analysis['success_rate'] >= 0.8:
                f.write("- ✅ Content generation is functional\n")
                f.write("- ✅ Ready to proceed with chain testing\n")
                f.write("- ✅ Can consider Phase 2 optimization\n")
            else:
                f.write("- ❌ Must resolve content generation issues first\n")
                f.write("- ❌ Cannot proceed with optimization until models work\n")
                f.write("- ❌ May need to rebuild models from scratch\n")
        
        logger.info(f"Diagnostic report generated: {report_path}")

def main():
    """Main execution function"""
    print("🔍 Mirador Content Generation Diagnostic Tool")
    print("=" * 55)
    
    diagnostic = MiradorContentDiagnostic()
    
    print("🧪 Testing individual model content generation...")
    results, configurations = diagnostic.run_comprehensive_diagnosis()
    
    print("📊 Analyzing failure patterns...")
    analysis = diagnostic.analyze_failure_patterns(results)
    
    print("🔧 Generating repair scripts...")
    diagnostic.generate_repair_scripts(results, configurations)
    
    print("📝 Generating diagnostic report...")
    diagnostic.generate_diagnostic_report(results, configurations, analysis)
    
    # Summary
    print(f"\n✅ Diagnostic Complete!")
    print(f"📊 Models tested: {analysis['total_models']}")
    print(f"✅ Working: {analysis['successful_models']}")
    print(f"❌ Failed: {analysis['failed_models']}")
    print(f"📈 Success rate: {analysis['success_rate']:.1%}")
    print(f"📁 Reports and scripts: {diagnostic.output_dir}")
    
    if analysis['success_rate'] < 0.8:
        print(f"\n🚨 CRITICAL ISSUE DETECTED:")
        print(f"Only {analysis['success_rate']:.1%} of models are generating content correctly.")
        print(f"Run the repair scripts to resolve issues before proceeding.")
    else:
        print(f"\n🎉 Content generation is working well!")
        print(f"Ready for chain testing and optimization.")

if __name__ == "__main__":
    main()

