#!/usr/bin/env python3
"""
Mirador Model Registry Diagnostic and Repair Tool
Identifies and resolves model availability issues discovered in Phase 1
"""

import subprocess
import json
import re
from pathlib import Path
from typing import Dict, List, Set, Tuple
from dataclasses import dataclass
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@dataclass
class ModelStatus:
    name: str
    has_modelfile: bool
    has_ollama_model: bool
    modelfile_path: str = ""
    ollama_size: str = ""
    base_model: str = ""
    status: str = ""  # 'available', 'needs_build', 'missing', 'error'

class MiradorModelDiagnostic:
    """Diagnoses and repairs Mirador model availability issues"""
    
    def __init__(self, models_directory: str = ".", output_dir: str = "./diagnostic_output"):
        self.models_dir = Path(models_directory)
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        
        # Critical models identified from Phase 1 analysis
        self.critical_models = [
            'matthew_context_provider_v2',
            'financial_planning_expert_v6', 
            'decision_simplifier_v2',
            'louisville_expert_v3',
            'enhanced_agent_enforcer_v2',
            'enhanced_agent_fast_v6'
        ]
        
        # Models that were confirmed working in Phase 1
        self.working_models = [
            'matthew_context_provider_v2',
            'louisville_expert_v3', 
            'enhanced_agent_enforcer_v2'
        ]

    def get_ollama_models(self) -> Dict[str, str]:
        """Get all models currently in Ollama registry"""
        try:
            result = subprocess.run(['ollama', 'list'], capture_output=True, text=True)
            if result.returncode != 0:
                logger.error(f"Failed to get Ollama models: {result.stderr}")
                return {}
            
            models = {}
            lines = result.stdout.strip().split('\n')[1:]  # Skip header
            
            for line in lines:
                if line.strip():
                    parts = line.split()
                    if len(parts) >= 3:
                        name = parts[0]
                        size = parts[2] if len(parts) > 2 else "unknown"
                        models[name] = size
            
            logger.info(f"Found {len(models)} models in Ollama registry")
            return models
            
        except Exception as e:
            logger.error(f"Error getting Ollama models: {e}")
            return {}

    def get_modelfiles(self) -> Dict[str, str]:
        """Get all .modelfile definitions"""
        modelfiles = {}
        
        # Search for .modelfile files
        for modelfile in self.models_dir.glob("**/*.modelfile"):
            name = modelfile.stem
            modelfiles[name] = str(modelfile)
        
        logger.info(f"Found {len(modelfiles)} modelfile definitions")
        return modelfiles

    def diagnose_model_status(self) -> List[ModelStatus]:
        """Diagnose status of all models"""
        ollama_models = self.get_ollama_models()
        modelfiles = self.get_modelfiles()
        
        # Get all unique model names
        all_model_names = set(ollama_models.keys()) | set(modelfiles.keys())
        
        model_statuses = []
        
        for name in sorted(all_model_names):
            has_ollama = name in ollama_models
            has_modelfile = name in modelfiles
            
            # Determine status
            if has_ollama and has_modelfile:
                status = 'available'
            elif has_modelfile and not has_ollama:
                status = 'needs_build'
            elif has_ollama and not has_modelfile:
                status = 'ollama_only'
            else:
                status = 'error'
            
            # Extract base model from modelfile if available
            base_model = ""
            if has_modelfile:
                base_model = self._extract_base_model(modelfiles[name])
            
            model_status = ModelStatus(
                name=name,
                has_modelfile=has_modelfile,
                has_ollama_model=has_ollama,
                modelfile_path=modelfiles.get(name, ""),
                ollama_size=ollama_models.get(name, ""),
                base_model=base_model,
                status=status
            )
            
            model_statuses.append(model_status)
        
        return model_statuses

    def _extract_base_model(self, modelfile_path: str) -> str:
        """Extract base model from modelfile"""
        try:
            with open(modelfile_path, 'r') as f:
                content = f.read()
            
            # Look for FROM directive
            match = re.search(r'FROM\s+(\S+)', content)
            return match.group(1) if match else "unknown"
            
        except Exception as e:
            logger.warning(f"Could not extract base model from {modelfile_path}: {e}")
            return "unknown"

    def analyze_critical_models(self, model_statuses: List[ModelStatus]) -> Dict:
        """Analyze status of critical models specifically"""
        critical_analysis = {
            'available': [],
            'needs_build': [],
            'missing': [],
            'working_confirmed': [],
            'priority_build_order': []
        }
        
        # Create lookup dict
        status_lookup = {ms.name: ms for ms in model_statuses}
        
        for model_name in self.critical_models:
            if model_name in status_lookup:
                status = status_lookup[model_name]
                
                if status.status == 'available':
                    critical_analysis['available'].append(model_name)
                    if model_name in self.working_models:
                        critical_analysis['working_confirmed'].append(model_name)
                elif status.status == 'needs_build':
                    critical_analysis['needs_build'].append(model_name)
                else:
                    critical_analysis['missing'].append(model_name)
            else:
                critical_analysis['missing'].append(model_name)
        
        # Determine build priority order
        priority_order = [
            'financial_planning_expert_v6',  # Core financial capability
            'decision_simplifier_v2',        # Essential synthesis
            'enhanced_agent_fast_v6',        # Performance optimization
            'matthew_context_provider_v1',   # Backup context provider
            'financial_planning_expert_fast', # Quick financial queries
            'mirador_system_specialist_v2'   # System optimization
        ]
        
        for model in priority_order:
            if model in critical_analysis['needs_build']:
                critical_analysis['priority_build_order'].append(model)
        
        return critical_analysis

    def generate_build_scripts(self, model_statuses: List[ModelStatus], critical_analysis: Dict):
        """Generate scripts to build missing models"""
        
        # Build script for critical models
        critical_build_script = self.output_dir / "build_critical_models.sh"
        with open(critical_build_script, 'w') as f:
            f.write("#!/bin/bash\n")
            f.write("# Build Critical Mirador Models\n")
            f.write("# Generated automatically based on diagnostic results\n\n")
            f.write("set -e\n\n")
            f.write("echo \"🔨 Building critical Mirador models...\"\n\n")
            
            status_lookup = {ms.name: ms for ms in model_statuses}
            
            for model_name in critical_analysis['priority_build_order']:
                if model_name in status_lookup:
                    status = status_lookup[model_name]
                    if status.has_modelfile:
                        f.write(f"echo \"Building {model_name}...\"\n")
                        f.write(f"if [ -f \"{status.modelfile_path}\" ]; then\n")
                        f.write(f"    ollama create {model_name} -f \"{status.modelfile_path}\"\n")
                        f.write(f"    if [ $? -eq 0 ]; then\n")
                        f.write(f"        echo \"✅ Successfully built {model_name}\"\n")
                        f.write(f"    else\n")
                        f.write(f"        echo \"❌ Failed to build {model_name}\"\n")
                        f.write(f"        exit 1\n")
                        f.write(f"    fi\n")
                        f.write("else\n")
                        f.write(f"    echo \"⚠️  Modelfile not found: {status.modelfile_path}\"\n")
                        f.write("fi\n\n")
            
            f.write("echo \"🎉 Critical model building complete!\"\n")
            f.write("echo \"Run the validation script to test the models.\"\n")
        
        # Make executable
        critical_build_script.chmod(0o755)
        
        # Validation script
        validation_script = self.output_dir / "validate_critical_models.sh"
        with open(validation_script, 'w') as f:
            f.write("#!/bin/bash\n")
            f.write("# Validate Critical Mirador Models\n")
            f.write("# Tests basic functionality of newly built models\n\n")
            f.write("echo \"🧪 Validating critical models...\"\n\n")
            
            test_queries = {
                'matthew_context_provider_v2': "Provide context about Matthew's current situation and goals.",
                'financial_planning_expert_v6': "Create a basic budget framework for someone earning $75,000 annually.",
                'decision_simplifier_v2': "Help me decide between saving for a house vs investing in retirement.",
                'louisville_expert_v3': "What are good neighborhoods in Louisville for young professionals?",
                'enhanced_agent_enforcer_v2': "Review this statement for accuracy: Louisville is the capital of Kentucky.",
                'enhanced_agent_fast_v6': "Quick check: Is this a reasonable financial goal - save $10,000 in 6 months on $50,000 salary?"
            }
            
            for model_name in self.critical_models:
                query = test_queries.get(model_name, "Hello, please confirm you are working correctly.")
                f.write(f"echo \"Testing {model_name}...\"\n")
                f.write(f"if timeout 30 ollama run {model_name} \"{query}\" > /dev/null 2>&1; then\n")
                f.write(f"    echo \"✅ {model_name} is working\"\n")
                f.write("else\n")
                f.write(f"    echo \"❌ {model_name} failed validation\"\n")
                f.write("fi\n\n")
            
            f.write("echo \"🎉 Validation complete!\"\n")
        
        # Make executable
        validation_script.chmod(0o755)
        
        logger.info(f"Generated build scripts: {critical_build_script}, {validation_script}")

    def generate_diagnostic_report(self, model_statuses: List[ModelStatus], critical_analysis: Dict):
        """Generate comprehensive diagnostic report"""
        report_path = self.output_dir / "model_diagnostic_report.md"
        
        with open(report_path, 'w') as f:
            f.write("# Mirador Model Registry Diagnostic Report\n\n")
            f.write(f"**Generated:** {subprocess.run(['date'], capture_output=True, text=True).stdout.strip()}\n\n")
            
            # Executive Summary
            f.write("## Executive Summary\n\n")
            
            total_models = len(model_statuses)
            available_models = len([ms for ms in model_statuses if ms.status == 'available'])
            needs_build = len([ms for ms in model_statuses if ms.status == 'needs_build'])
            missing = len([ms for ms in model_statuses if ms.status == 'missing'])
            
            f.write(f"- **Total Models Discovered:** {total_models}\n")
            f.write(f"- **Available in Ollama:** {available_models}\n")
            f.write(f"- **Need Building:** {needs_build}\n")
            f.write(f"- **Missing/Error:** {missing}\n\n")
            
            # Critical Models Analysis
            f.write("## Critical Models Status\n\n")
            f.write("### ✅ Available and Working\n")
            for model in critical_analysis['working_confirmed']:
                f.write(f"- {model} (confirmed working in Phase 1)\n")
            f.write("\n")
            
            f.write("### 🔨 Need Building (Priority Order)\n")
            for i, model in enumerate(critical_analysis['priority_build_order'], 1):
                f.write(f"{i}. {model}\n")
            f.write("\n")
            
            f.write("### ❌ Missing/Error\n")
            for model in critical_analysis['missing']:
                f.write(f"- {model}\n")
            f.write("\n")
            
            # Detailed Model Status
            f.write("## Detailed Model Status\n\n")
            f.write("| Model Name | Has Modelfile | In Ollama | Base Model | Status | Action Required |\n")
            f.write("|------------|---------------|-----------|------------|--------|------------------|\n")
            
            for ms in sorted(model_statuses, key=lambda x: (x.status, x.name)):
                has_mf = "✅" if ms.has_modelfile else "❌"
                has_ol = "✅" if ms.has_ollama_model else "❌"
                
                action = ""
                if ms.status == 'needs_build':
                    action = "Build from modelfile"
                elif ms.status == 'available':
                    action = "Ready to use"
                elif ms.status == 'missing':
                    action = "Create modelfile"
                elif ms.status == 'ollama_only':
                    action = "Create modelfile backup"
                
                f.write(f"| {ms.name} | {has_mf} | {has_ol} | {ms.base_model} | {ms.status} | {action} |\n")
            
            f.write("\n")
            
            # Recommendations
            f.write("## Immediate Action Plan\n\n")
            f.write("### Step 1: Build Critical Missing Models\n")
            f.write("Run the generated build script to create missing critical models:\n")
            f.write("```bash\n")
            f.write("./build_critical_models.sh\n")
            f.write("```\n\n")
            
            f.write("### Step 2: Validate Built Models\n")
            f.write("Test the newly built models:\n")
            f.write("```bash\n")
            f.write("./validate_critical_models.sh\n")
            f.write("```\n\n")
            
            f.write("### Step 3: Re-run Performance Testing\n")
            f.write("Once models are built and validated, re-run the performance tester:\n")
            f.write("```bash\n")
            f.write("python3 mirador_performance_tester.py\n")
            f.write("```\n\n")
            
            f.write("### Step 4: Proceed to Phase 2\n")
            f.write("If performance testing shows >80% success rate, proceed with base model migration.\n\n")
            
            # Phase 2 Readiness Checklist
            f.write("## Phase 2 Readiness Checklist\n\n")
            f.write("- [ ] All critical models built and available\n")
            f.write("- [ ] Performance testing shows >80% success rate\n")
            f.write("- [ ] matthew_context_provider_v2 working\n")
            f.write("- [ ] financial_planning_expert_v6 working\n")
            f.write("- [ ] decision_simplifier_v2 working\n")
            f.write("- [ ] louisville_expert_v3 working\n")
            f.write("- [ ] enhanced_agent_enforcer_v2 working\n")
            f.write("- [ ] Backup procedures tested\n")
        
        logger.info(f"Diagnostic report generated: {report_path}")

def main():
    """Main execution function"""
    print("🔍 Mirador Model Registry Diagnostic Tool")
    print("=" * 50)
    
    diagnostic = MiradorModelDiagnostic()
    
    print("📊 Diagnosing model registry status...")
    model_statuses = diagnostic.diagnose_model_status()
    
    print("🎯 Analyzing critical models...")
    critical_analysis = diagnostic.analyze_critical_models(model_statuses)
    
    print("🔨 Generating build and validation scripts...")
    diagnostic.generate_build_scripts(model_statuses, critical_analysis)
    
    print("📝 Generating diagnostic report...")
    diagnostic.generate_diagnostic_report(model_statuses, critical_analysis)
    
    # Summary
    print("\n✅ Diagnostic Complete!")
    print(f"📊 Total models found: {len(model_statuses)}")
    print(f"✅ Critical models available: {len(critical_analysis['available'])}")
    print(f"🔨 Critical models need building: {len(critical_analysis['needs_build'])}")
    print(f"❌ Critical models missing: {len(critical_analysis['missing'])}")
    print(f"📁 Reports and scripts generated in: {diagnostic.output_dir}")
    
    if critical_analysis['needs_build']:
        print("\n🚨 IMMEDIATE ACTION REQUIRED:")
        print("Run ./diagnostic_output/build_critical_models.sh to build missing models")
        print("Then run ./diagnostic_output/validate_critical_models.sh to test them")
    else:
        print("\n🎉 All critical models are available! Ready for Phase 2.")

if __name__ == "__main__":
    main()

