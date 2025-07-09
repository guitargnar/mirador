#!/usr/bin/env python3
"""
Emergency Mirador Recovery Tool
Implements immediate recovery procedures for critical content generation failure
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
class EmergencyConfig:
    working_model: str
    backup_models: List[str]
    emergency_chains: List[Dict]

class MiradorEmergencyRecovery:
    """Emergency recovery tool for critical Mirador failures"""
    
    def __init__(self, output_dir: str = "./emergency_recovery"):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        
        # Based on analysis, enhanced_agent_enforcer is the only working model
        self.emergency_config = EmergencyConfig(
            working_model="enhanced_agent_enforcer",
            backup_models=["enhanced_agent_enforcer_v2", "mirador_system_specialist"],
            emergency_chains=[
                {
                    "name": "emergency_single_model",
                    "models": ["enhanced_agent_enforcer"],
                    "description": "Single working model for immediate needs"
                },
                {
                    "name": "emergency_financial_analysis",
                    "models": ["enhanced_agent_enforcer"],
                    "description": "Financial analysis using only working model"
                }
            ]
        )

    def test_working_model(self, model_name: str, timeout: int = 30) -> Tuple[bool, str, int]:
        """Test if a model can generate content"""
        test_query = "Provide a brief analysis of the importance of financial planning."
        
        try:
            start_time = time.time()
            result = subprocess.run(
                ['ollama', 'run', model_name, test_query],
                capture_output=True,
                text=True,
                timeout=timeout
            )
            execution_time = time.time() - start_time
            
            if result.returncode != 0:
                return False, f"Command failed: {result.stderr}", 0
            
            response = result.stdout.strip()
            word_count = len(response.split()) if response else 0
            
            # Consider successful if generates at least 20 words
            success = word_count >= 20 and len(response) > 50
            
            return success, response[:200] + "..." if len(response) > 200 else response, word_count
            
        except subprocess.TimeoutExpired:
            return False, "Timeout", 0
        except Exception as e:
            return False, f"Error: {e}", 0

    def identify_working_models(self) -> List[str]:
        """Identify which models are actually functional"""
        print("🔍 Testing models to identify working components...")
        
        test_models = [
            "enhanced_agent_enforcer",
            "enhanced_agent_enforcer_v2", 
            "mirador_system_specialist",
            "financial_planning_expert_v6",
            "matthew_context_provider",
            "matthew_context_provider_v2",
            "decision_simplifier",
            "decision_simplifier_v2",
            "louisville_expert_v3"
        ]
        
        working_models = []
        
        for model in test_models:
            print(f"Testing {model}...")
            success, response, word_count = self.test_working_model(model)
            
            if success:
                print(f"✅ {model}: Working ({word_count} words)")
                working_models.append(model)
            else:
                print(f"❌ {model}: Failed - {response[:50]}...")
        
        return working_models

    def create_emergency_mirador_script(self, working_models: List[str]):
        """Create emergency mirador script using only working models"""
        script_path = self.output_dir / "emergency_mirador.sh"
        
        with open(script_path, 'w') as f:
            f.write("#!/bin/bash\n")
            f.write("# Emergency Mirador Script - Uses Only Working Models\n")
            f.write("# Generated based on crisis analysis\n\n")
            f.write("set -e\n\n")
            
            if not working_models:
                f.write("echo \"❌ No working models found. System requires complete rebuild.\"\n")
                f.write("exit 1\n")
                return
            
            primary_model = working_models[0]
            
            f.write(f"# Primary working model: {primary_model}\n")
            f.write(f"PRIMARY_MODEL=\"{primary_model}\"\n\n")
            
            f.write("# Emergency query function\n")
            f.write("emergency_query() {\n")
            f.write("    local query=\"$1\"\n")
            f.write("    echo \"🚨 Emergency Mode: Using $PRIMARY_MODEL\"\n")
            f.write("    echo \"Query: $query\"\n")
            f.write("    echo \"Response:\"\n")
            f.write("    ollama run \"$PRIMARY_MODEL\" \"$query\"\n")
            f.write("}\n\n")
            
            f.write("# Emergency chain function (single model)\n")
            f.write("emergency_chain() {\n")
            f.write("    local query=\"$1\"\n")
            f.write("    echo \"🚨 Emergency Chain Mode\"\n")
            f.write("    echo \"Using single working model: $PRIMARY_MODEL\"\n")
            f.write("    echo \"Query: $query\"\n")
            f.write("    echo \"Analysis:\"\n")
            f.write("    ollama run \"$PRIMARY_MODEL\" \"Provide comprehensive analysis for: $query\"\n")
            f.write("}\n\n")
            
            f.write("# Check if arguments provided\n")
            f.write("if [ $# -eq 0 ]; then\n")
            f.write("    echo \"Emergency Mirador Usage:\"\n")
            f.write("    echo \"  $0 query 'Your question here'\"\n")
            f.write("    echo \"  $0 chain 'Your complex request here'\"\n")
            f.write("    echo \"\"\n")
            f.write(f"    echo \"Working models: {', '.join(working_models)}\"\n")
            f.write("    exit 1\n")
            f.write("fi\n\n")
            
            f.write("# Execute based on command\n")
            f.write("case \"$1\" in\n")
            f.write("    \"query\")\n")
            f.write("        emergency_query \"$2\"\n")
            f.write("        ;;\n")
            f.write("    \"chain\")\n")
            f.write("        emergency_chain \"$2\"\n")
            f.write("        ;;\n")
            f.write("    *)\n")
            f.write("        echo \"Unknown command: $1\"\n")
            f.write("        echo \"Use 'query' or 'chain'\"\n")
            f.write("        exit 1\n")
            f.write("        ;;\n")
            f.write("esac\n")
        
        script_path.chmod(0o755)
        logger.info(f"Emergency script created: {script_path}")

    def create_model_rebuild_guide(self):
        """Create comprehensive model rebuild guide"""
        guide_path = self.output_dir / "model_rebuild_guide.md"
        
        with open(guide_path, 'w') as f:
            f.write("# Mirador Model Rebuild Guide\n\n")
            f.write("## Critical Models Requiring Rebuild\n\n")
            
            failed_models = [
                "matthew_context_provider",
                "financial_planning_expert_v6", 
                "decision_simplifier"
            ]
            
            for model in failed_models:
                f.write(f"### {model}\n")
                f.write(f"**Status**: FAILED - Produces zero output\n")
                f.write(f"**Priority**: HIGH - Core functionality\n")
                f.write(f"**Rebuild Command**:\n")
                f.write(f"```bash\n")
                f.write(f"# Find the modelfile\n")
                f.write(f"find . -name \"{model}.modelfile\" -type f\n\n")
                f.write(f"# Rebuild the model\n")
                f.write(f"ollama create {model} -f path/to/{model}.modelfile\n\n")
                f.write(f"# Test the rebuilt model\n")
                f.write(f"ollama run {model} \"Test query for {model}\"\n")
                f.write(f"```\n\n")
            
            f.write("## Model Rebuild Priority Order\n\n")
            f.write("1. **enhanced_agent_enforcer** - Already working, use as reference\n")
            f.write("2. **matthew_context_provider** - Critical for personalization\n")
            f.write("3. **financial_planning_expert_v6** - Core financial functionality\n")
            f.write("4. **decision_simplifier** - Essential for actionable output\n\n")
            
            f.write("## Validation After Rebuild\n\n")
            f.write("```bash\n")
            f.write("# Test each rebuilt model\n")
            f.write("ollama run matthew_context_provider \"Provide context about Matthew\"\n")
            f.write("ollama run financial_planning_expert_v6 \"Create a basic budget\"\n")
            f.write("ollama run decision_simplifier \"Summarize: save vs invest\"\n")
            f.write("```\n\n")
            
            f.write("## Success Criteria\n\n")
            f.write("- Each model produces at least 50 words of relevant content\n")
            f.write("- No models remove existing content\n")
            f.write("- Chain execution produces final output\n")
            f.write("- All models respond within 30 seconds\n")
        
        logger.info(f"Rebuild guide created: {guide_path}")

    def create_emergency_test_suite(self, working_models: List[str]):
        """Create emergency test suite for validation"""
        test_script = self.output_dir / "emergency_test_suite.sh"
        
        with open(test_script, 'w') as f:
            f.write("#!/bin/bash\n")
            f.write("# Emergency Test Suite for Mirador Recovery\n\n")
            f.write("echo \"🧪 Emergency Mirador Test Suite\"\n")
            f.write("echo \"==============================\"\n\n")
            
            if working_models:
                f.write("echo \"✅ Working Models:\"\n")
                for model in working_models:
                    f.write(f"echo \"  - {model}\"\n")
                f.write("echo \"\"\n\n")
                
                f.write("echo \"🔧 Testing Emergency Functionality...\"\n")
                primary_model = working_models[0]
                
                test_queries = [
                    "What are the key components of financial planning?",
                    "How should someone prioritize saving vs investing?",
                    "What factors should guide career advancement decisions?"
                ]
                
                for i, query in enumerate(test_queries, 1):
                    f.write(f"echo \"Test {i}: {query[:50]}...\"\n")
                    f.write(f"if timeout 30 ollama run {primary_model} \"{query}\" | wc -w | awk '{{if($1 >= 20) print \"✅ Pass (\" $1 \" words)\"; else print \"❌ Fail (\" $1 \" words)\"}}'; then\n")
                    f.write("    true\n")
                    f.write("else\n")
                    f.write("    echo \"❌ Model failed to respond\"\n")
                    f.write("fi\n")
                    f.write("echo \"\"\n\n")
            else:
                f.write("echo \"❌ No working models found!\"\n")
                f.write("echo \"System requires complete rebuild from modelfiles.\"\n")
                f.write("echo \"Check for .modelfile files in your project directory.\"\n")
            
            f.write("echo \"🎉 Emergency test complete!\"\n")
        
        test_script.chmod(0o755)
        logger.info(f"Emergency test suite created: {test_script}")

    def generate_recovery_report(self, working_models: List[str]):
        """Generate comprehensive recovery status report"""
        report_path = self.output_dir / "emergency_recovery_report.md"
        
        with open(report_path, 'w') as f:
            f.write("# Mirador Emergency Recovery Report\n\n")
            f.write(f"**Generated:** {subprocess.run(['date'], capture_output=True, text=True).stdout.strip()}\n\n")
            
            # Crisis Status
            f.write("## Crisis Status Assessment\n\n")
            if working_models:
                f.write(f"**Status**: PARTIAL FUNCTIONALITY\n")
                f.write(f"**Working Models**: {len(working_models)}\n")
                f.write(f"**Failed Models**: Estimated 6-8 models\n")
                f.write(f"**System Usability**: LIMITED - Emergency mode only\n\n")
            else:
                f.write(f"**Status**: COMPLETE SYSTEM FAILURE\n")
                f.write(f"**Working Models**: 0\n")
                f.write(f"**System Usability**: NONE - Requires complete rebuild\n\n")
            
            # Working Models
            if working_models:
                f.write("## ✅ Functional Models\n\n")
                for model in working_models:
                    f.write(f"- **{model}**: Confirmed working\n")
                f.write("\n")
            
            # Emergency Procedures
            f.write("## 🚨 Emergency Procedures Implemented\n\n")
            f.write("### 1. Emergency Mirador Script\n")
            f.write("- **File**: `emergency_mirador.sh`\n")
            f.write("- **Purpose**: Provides basic functionality using only working models\n")
            f.write("- **Usage**: `./emergency_mirador.sh query \"Your question\"`\n\n")
            
            f.write("### 2. Model Rebuild Guide\n")
            f.write("- **File**: `model_rebuild_guide.md`\n")
            f.write("- **Purpose**: Step-by-step instructions for rebuilding failed models\n")
            f.write("- **Priority**: Rebuild critical models first\n\n")
            
            f.write("### 3. Emergency Test Suite\n")
            f.write("- **File**: `emergency_test_suite.sh`\n")
            f.write("- **Purpose**: Validate system functionality after repairs\n")
            f.write("- **Usage**: `./emergency_test_suite.sh`\n\n")
            
            # Immediate Actions
            f.write("## 🎯 Immediate Action Plan\n\n")
            
            if working_models:
                f.write("### Phase 1: Emergency Operations (Today)\n")
                f.write("1. Use emergency script for immediate needs\n")
                f.write("2. Locate .modelfile files for failed models\n")
                f.write("3. Begin systematic model rebuilding\n\n")
                
                f.write("### Phase 2: Model Restoration (1-2 days)\n")
                f.write("1. Rebuild matthew_context_provider\n")
                f.write("2. Rebuild financial_planning_expert_v6\n")
                f.write("3. Rebuild decision_simplifier\n")
                f.write("4. Test each model individually\n\n")
                
                f.write("### Phase 3: System Validation (Day 3)\n")
                f.write("1. Run emergency test suite\n")
                f.write("2. Test multi-model chains\n")
                f.write("3. Validate full system functionality\n")
                f.write("4. Resume normal operations\n\n")
            else:
                f.write("### Critical Action Required\n")
                f.write("1. **IMMEDIATE**: Locate all .modelfile files\n")
                f.write("2. **URGENT**: Rebuild all models from scratch\n")
                f.write("3. **PRIORITY**: Start with enhanced_agent_enforcer as reference\n")
                f.write("4. **VALIDATE**: Test each model after rebuild\n\n")
            
            # Recovery Timeline
            f.write("## ⏰ Recovery Timeline\n\n")
            f.write("- **Day 1**: Emergency operations, model rebuilding begins\n")
            f.write("- **Day 2**: Complete model restoration, individual testing\n")
            f.write("- **Day 3**: Chain testing, system validation\n")
            f.write("- **Day 4+**: Resume optimization work if successful\n\n")
            
            # Success Criteria
            f.write("## ✅ Recovery Success Criteria\n\n")
            f.write("- All critical models producing content (>50 words)\n")
            f.write("- Multi-model chains generating final output\n")
            f.write("- No models removing existing content\n")
            f.write("- System ready for Phase 2 optimization\n")
        
        logger.info(f"Recovery report generated: {report_path}")

def main():
    """Main emergency recovery execution"""
    print("🚨 MIRADOR EMERGENCY RECOVERY TOOL")
    print("=" * 50)
    print("Implementing immediate recovery procedures...")
    print()
    
    recovery = MiradorEmergencyRecovery()
    
    print("🔍 Step 1: Identifying working models...")
    working_models = recovery.identify_working_models()
    
    print(f"\n📊 Results: {len(working_models)} working models found")
    if working_models:
        print("✅ Working models:", ", ".join(working_models))
    else:
        print("❌ No working models found - complete system failure")
    
    print("\n🛠️ Step 2: Creating emergency tools...")
    recovery.create_emergency_mirador_script(working_models)
    recovery.create_model_rebuild_guide()
    recovery.create_emergency_test_suite(working_models)
    
    print("\n📝 Step 3: Generating recovery report...")
    recovery.generate_recovery_report(working_models)
    
    print(f"\n✅ Emergency Recovery Complete!")
    print(f"📁 Recovery tools: {recovery.output_dir}")
    
    if working_models:
        print(f"\n🚀 IMMEDIATE NEXT STEPS:")
        print(f"1. Use emergency script: ./emergency_recovery/emergency_mirador.sh")
        print(f"2. Follow rebuild guide: ./emergency_recovery/model_rebuild_guide.md")
        print(f"3. Test with: ./emergency_recovery/emergency_test_suite.sh")
    else:
        print(f"\n🚨 CRITICAL: Complete system rebuild required!")
        print(f"Find .modelfile files and rebuild all models from scratch.")

if __name__ == "__main__":
    main()

