#!/usr/bin/env python3
"""
Mirador Model Analysis and Consolidation Toolkit
Analyzes current model library and provides consolidation recommendations
"""

import os
import json
import re
import subprocess
import time
from pathlib import Path
from typing import Dict, List, Tuple, Optional
from dataclasses import dataclass, asdict
from datetime import datetime
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

@dataclass
class ModelInfo:
    """Information about a Mirador model"""
    name: str
    base_model: str
    file_path: str
    size_mb: float
    last_modified: str
    category: str
    version: Optional[str]
    parameters: Dict
    performance_score: float = 0.0
    usage_frequency: int = 0
    consolidation_recommendation: str = ""

class MiradorModelAnalyzer:
    """Analyzes Mirador model library for consolidation opportunities"""
    
    def __init__(self, models_directory: str = ".", output_directory: str = "./analysis_output"):
        self.models_dir = Path(models_directory)
        self.output_dir = Path(output_directory)
        self.output_dir.mkdir(exist_ok=True)
        
        # Model categorization patterns
        self.category_patterns = {
            'financial_planning': r'financial.*planning.*expert',
            'enhanced_agent': r'enhanced.*agent',
            'context_provider': r'matthew.*context.*provider',
            'decision_support': r'decision.*simplifier',
            'local_expert': r'louisville.*expert',
            'system_specialist': r'mirador.*system.*specialist',
            'content_creation': r'(linkedin|content).*expert',
            'domain_specialist': r'(health|real_estate|productivity).*optimizer'
        }
        
        # Recommended consolidated models based on analysis
        self.consolidation_targets = {
            'financial_planning': {
                'keep': ['financial_planning_expert_v6', 'financial_planning_expert_fast'],
                'retire': ['financial_planning_expert_v1', 'financial_planning_expert_v2', 
                          'financial_planning_expert_v3', 'financial_planning_expert_v4',
                          'financial_planning_expert_v5', 'financial_planning_expert_v7',
                          'financial_planning_expert_v8']
            },
            'enhanced_agent': {
                'keep': ['enhanced_agent_enforcer_v2', 'enhanced_agent_fast_v6'],
                'retire': ['enhanced_agent_fast_v1', 'enhanced_agent_fast_v2',
                          'enhanced_agent_fast_v3', 'enhanced_agent_fast_v4',
                          'enhanced_agent_fast_v5', 'enhanced_agent_fast_v7',
                          'enhanced_agent_v1', 'enhanced_agent_v2']
            },
            'context_provider': {
                'keep': ['matthew_context_provider_v2'],
                'retire': ['matthew_context_provider_v1']
            },
            'decision_support': {
                'keep': ['decision_simplifier_v2'],
                'retire': ['decision_simplifier_v1']
            },
            'local_expert': {
                'keep': ['louisville_expert_v3'],
                'retire': ['louisville_expert_v1', 'louisville_expert_v2']
            },
            'system_specialist': {
                'keep': ['mirador_system_specialist_v2'],
                'retire': ['mirador_system_specialist_v1']
            }
        }

    def scan_models(self) -> List[ModelInfo]:
        """Scan directory for Mirador model files"""
        models = []
        
        # Look for .modelfile extensions
        for modelfile in self.models_dir.glob("**/*.modelfile"):
            try:
                model_info = self._parse_modelfile(modelfile)
                if model_info:
                    models.append(model_info)
            except Exception as e:
                logger.warning(f"Error parsing {modelfile}: {e}")
        
        # Also check for models in Ollama
        try:
            ollama_models = self._get_ollama_models()
            models.extend(ollama_models)
        except Exception as e:
            logger.warning(f"Error getting Ollama models: {e}")
        
        return models

    def _parse_modelfile(self, filepath: Path) -> Optional[ModelInfo]:
        """Parse a .modelfile to extract model information"""
        try:
            with open(filepath, 'r') as f:
                content = f.read()
            
            # Extract base model
            base_model_match = re.search(r'FROM\s+(\S+)', content)
            base_model = base_model_match.group(1) if base_model_match else "unknown"
            
            # Extract parameters
            parameters = {}
            for line in content.split('\n'):
                if line.startswith('PARAMETER'):
                    parts = line.split()
                    if len(parts) >= 3:
                        parameters[parts[1]] = parts[2]
            
            # Get file stats
            stat = filepath.stat()
            size_mb = stat.st_size / (1024 * 1024)
            last_modified = datetime.fromtimestamp(stat.st_mtime).isoformat()
            
            # Categorize model
            model_name = filepath.stem
            category = self._categorize_model(model_name)
            version = self._extract_version(model_name)
            
            return ModelInfo(
                name=model_name,
                base_model=base_model,
                file_path=str(filepath),
                size_mb=size_mb,
                last_modified=last_modified,
                category=category,
                version=version,
                parameters=parameters
            )
        except Exception as e:
            logger.error(f"Error parsing modelfile {filepath}: {e}")
            return None

    def _get_ollama_models(self) -> List[ModelInfo]:
        """Get models from Ollama registry"""
        try:
            result = subprocess.run(['ollama', 'list'], capture_output=True, text=True)
            if result.returncode != 0:
                return []
            
            models = []
            lines = result.stdout.strip().split('\n')[1:]  # Skip header
            
            for line in lines:
                parts = line.split()
                if len(parts) >= 3:
                    name = parts[0]
                    if any(keyword in name.lower() for keyword in ['mirador', 'matthew', 'financial', 'louisville']):
                        # This looks like a Mirador model
                        size_str = parts[2] if len(parts) > 2 else "0GB"
                        size_mb = self._parse_size(size_str)
                        
                        models.append(ModelInfo(
                            name=name,
                            base_model="ollama_managed",
                            file_path=f"ollama://{name}",
                            size_mb=size_mb,
                            last_modified=datetime.now().isoformat(),
                            category=self._categorize_model(name),
                            version=self._extract_version(name),
                            parameters={}
                        ))
            
            return models
        except Exception as e:
            logger.error(f"Error getting Ollama models: {e}")
            return []

    def _categorize_model(self, model_name: str) -> str:
        """Categorize model based on name patterns"""
        name_lower = model_name.lower()
        
        for category, pattern in self.category_patterns.items():
            if re.search(pattern, name_lower):
                return category
        
        return 'other'

    def _extract_version(self, model_name: str) -> Optional[str]:
        """Extract version number from model name"""
        version_match = re.search(r'v(\d+)', model_name.lower())
        return version_match.group(1) if version_match else None

    def _parse_size(self, size_str: str) -> float:
        """Parse size string like '4.1GB' to MB"""
        try:
            if 'GB' in size_str:
                return float(size_str.replace('GB', '')) * 1024
            elif 'MB' in size_str:
                return float(size_str.replace('MB', ''))
            else:
                return 0.0
        except:
            return 0.0

    def analyze_consolidation_opportunities(self, models: List[ModelInfo]) -> Dict:
        """Analyze models and provide consolidation recommendations"""
        analysis = {
            'total_models': len(models),
            'categories': {},
            'consolidation_plan': {},
            'estimated_savings': {
                'models_removed': 0,
                'disk_space_mb': 0.0
            }
        }
        
        # Group models by category
        by_category = {}
        for model in models:
            if model.category not in by_category:
                by_category[model.category] = []
            by_category[model.category].append(model)
        
        # Analyze each category
        for category, category_models in by_category.items():
            category_analysis = {
                'current_count': len(category_models),
                'models': [model.name for model in category_models],
                'versions': {},
                'recommendation': 'keep_all'  # default
            }
            
            # Group by version
            for model in category_models:
                if model.version:
                    if model.version not in category_analysis['versions']:
                        category_analysis['versions'][model.version] = []
                    category_analysis['versions'][model.version].append(model.name)
            
            # Apply consolidation recommendations
            if category in self.consolidation_targets:
                targets = self.consolidation_targets[category]
                category_analysis['recommended_keep'] = targets['keep']
                category_analysis['recommended_retire'] = targets['retire']
                category_analysis['recommendation'] = 'consolidate'
                
                # Calculate savings
                for model in category_models:
                    if model.name in targets['retire']:
                        analysis['estimated_savings']['models_removed'] += 1
                        analysis['estimated_savings']['disk_space_mb'] += model.size_mb
            
            analysis['categories'][category] = category_analysis
        
        # Generate consolidation plan
        analysis['consolidation_plan'] = self._generate_consolidation_plan(models, analysis)
        
        return analysis

    def _generate_consolidation_plan(self, models: List[ModelInfo], analysis: Dict) -> Dict:
        """Generate detailed consolidation execution plan"""
        plan = {
            'phase_1_immediate': {
                'description': 'Safe retirement of clearly redundant models',
                'actions': []
            },
            'phase_2_testing': {
                'description': 'Test consolidated models before final retirement',
                'actions': []
            },
            'phase_3_cleanup': {
                'description': 'Final cleanup and documentation update',
                'actions': []
            }
        }
        
        # Phase 1: Immediate safe retirements
        for category, cat_analysis in analysis['categories'].items():
            if 'recommended_retire' in cat_analysis:
                for model_name in cat_analysis['recommended_retire']:
                    plan['phase_1_immediate']['actions'].append({
                        'action': 'backup_and_retire',
                        'model': model_name,
                        'category': category,
                        'reason': 'superseded_by_newer_version'
                    })
        
        # Phase 2: Testing recommendations
        for category, cat_analysis in analysis['categories'].items():
            if 'recommended_keep' in cat_analysis:
                for model_name in cat_analysis['recommended_keep']:
                    plan['phase_2_testing']['actions'].append({
                        'action': 'performance_test',
                        'model': model_name,
                        'category': category,
                        'test_scenarios': ['basic_query', 'complex_chain', 'error_handling']
                    })
        
        # Phase 3: Cleanup
        plan['phase_3_cleanup']['actions'].extend([
            {'action': 'update_documentation', 'target': 'model_inventory'},
            {'action': 'update_configuration', 'target': 'orchestrator_config'},
            {'action': 'create_migration_guide', 'target': 'user_documentation'}
        ])
        
        return plan

    def generate_reports(self, models: List[ModelInfo], analysis: Dict):
        """Generate comprehensive analysis reports"""
        
        # 1. Model inventory report
        self._generate_inventory_report(models)
        
        # 2. Consolidation analysis report
        self._generate_consolidation_report(analysis)
        
        # 3. Implementation scripts
        self._generate_implementation_scripts(analysis)
        
        # 4. Migration guide
        self._generate_migration_guide(analysis)

    def _generate_inventory_report(self, models: List[ModelInfo]):
        """Generate detailed model inventory report"""
        report_path = self.output_dir / "model_inventory_report.md"
        
        with open(report_path, 'w') as f:
            f.write("# Mirador Model Inventory Report\n\n")
            f.write(f"**Generated:** {datetime.now().isoformat()}\n")
            f.write(f"**Total Models:** {len(models)}\n\n")
            
            # Summary by category
            by_category = {}
            for model in models:
                if model.category not in by_category:
                    by_category[model.category] = []
                by_category[model.category].append(model)
            
            f.write("## Models by Category\n\n")
            for category, category_models in sorted(by_category.items()):
                f.write(f"### {category.replace('_', ' ').title()} ({len(category_models)} models)\n\n")
                
                # Create table
                f.write("| Model Name | Version | Base Model | Size (MB) | Last Modified |\n")
                f.write("|------------|---------|------------|-----------|---------------|\n")
                
                for model in sorted(category_models, key=lambda x: x.name):
                    f.write(f"| {model.name} | {model.version or 'N/A'} | {model.base_model} | "
                           f"{model.size_mb:.1f} | {model.last_modified[:10]} |\n")
                f.write("\n")
            
            # Detailed model information
            f.write("## Detailed Model Information\n\n")
            for model in sorted(models, key=lambda x: (x.category, x.name)):
                f.write(f"### {model.name}\n\n")
                f.write(f"- **Category:** {model.category}\n")
                f.write(f"- **Base Model:** {model.base_model}\n")
                f.write(f"- **File Path:** {model.file_path}\n")
                f.write(f"- **Size:** {model.size_mb:.1f} MB\n")
                f.write(f"- **Last Modified:** {model.last_modified}\n")
                
                if model.parameters:
                    f.write("- **Parameters:**\n")
                    for param, value in model.parameters.items():
                        f.write(f"  - {param}: {value}\n")
                f.write("\n")
        
        logger.info(f"Model inventory report generated: {report_path}")

    def _generate_consolidation_report(self, analysis: Dict):
        """Generate consolidation analysis and recommendations report"""
        report_path = self.output_dir / "consolidation_analysis.md"
        
        with open(report_path, 'w') as f:
            f.write("# Mirador Model Consolidation Analysis\n\n")
            f.write(f"**Generated:** {datetime.now().isoformat()}\n\n")
            
            # Executive summary
            f.write("## Executive Summary\n\n")
            f.write(f"- **Current Models:** {analysis['total_models']}\n")
            f.write(f"- **Recommended for Retirement:** {analysis['estimated_savings']['models_removed']}\n")
            f.write(f"- **Estimated Disk Space Savings:** {analysis['estimated_savings']['disk_space_mb']:.1f} MB\n")
            f.write(f"- **Target Model Count:** {analysis['total_models'] - analysis['estimated_savings']['models_removed']}\n\n")
            
            # Category analysis
            f.write("## Category Analysis\n\n")
            for category, cat_analysis in analysis['categories'].items():
                f.write(f"### {category.replace('_', ' ').title()}\n\n")
                f.write(f"- **Current Count:** {cat_analysis['current_count']}\n")
                f.write(f"- **Recommendation:** {cat_analysis['recommendation']}\n")
                
                if 'recommended_keep' in cat_analysis:
                    f.write("- **Models to Keep:**\n")
                    for model in cat_analysis['recommended_keep']:
                        f.write(f"  - {model}\n")
                
                if 'recommended_retire' in cat_analysis:
                    f.write("- **Models to Retire:**\n")
                    for model in cat_analysis['recommended_retire']:
                        f.write(f"  - {model}\n")
                f.write("\n")
            
            # Implementation plan
            f.write("## Implementation Plan\n\n")
            for phase_name, phase_info in analysis['consolidation_plan'].items():
                f.write(f"### {phase_name.replace('_', ' ').title()}\n\n")
                f.write(f"{phase_info['description']}\n\n")
                
                for action in phase_info['actions']:
                    f.write(f"- **{action['action'].replace('_', ' ').title()}**")
                    if 'model' in action:
                        f.write(f": {action['model']}")
                    if 'reason' in action:
                        f.write(f" ({action['reason']})")
                    f.write("\n")
                f.write("\n")
        
        logger.info(f"Consolidation analysis report generated: {report_path}")

    def _generate_implementation_scripts(self, analysis: Dict):
        """Generate implementation scripts for consolidation"""
        
        # Backup script
        backup_script_path = self.output_dir / "backup_models.sh"
        with open(backup_script_path, 'w') as f:
            f.write("#!/bin/bash\n")
            f.write("# Mirador Model Backup Script\n")
            f.write("# Generated automatically - review before execution\n\n")
            f.write("BACKUP_DIR=\"./model_backups_$(date +%Y%m%d_%H%M%S)\"\n")
            f.write("mkdir -p \"$BACKUP_DIR\"\n\n")
            
            # Backup models to be retired
            for category, cat_analysis in analysis['categories'].items():
                if 'recommended_retire' in cat_analysis:
                    f.write(f"# Backup {category} models\n")
                    for model in cat_analysis['recommended_retire']:
                        f.write(f"if [ -f \"{model}.modelfile\" ]; then\n")
                        f.write(f"    cp \"{model}.modelfile\" \"$BACKUP_DIR/\"\n")
                        f.write(f"    echo \"Backed up {model}.modelfile\"\n")
                        f.write("fi\n")
                    f.write("\n")
            
            f.write("echo \"Backup completed in $BACKUP_DIR\"\n")
        
        # Make script executable
        os.chmod(backup_script_path, 0o755)
        
        # Retirement script
        retire_script_path = self.output_dir / "retire_models.sh"
        with open(retire_script_path, 'w') as f:
            f.write("#!/bin/bash\n")
            f.write("# Mirador Model Retirement Script\n")
            f.write("# WARNING: This will remove models - ensure backup is complete\n\n")
            f.write("read -p \"Have you completed the backup? (y/N): \" -n 1 -r\n")
            f.write("echo\n")
            f.write("if [[ ! $REPLY =~ ^[Yy]$ ]]; then\n")
            f.write("    echo \"Please run backup_models.sh first\"\n")
            f.write("    exit 1\n")
            f.write("fi\n\n")
            
            # Remove models
            for category, cat_analysis in analysis['categories'].items():
                if 'recommended_retire' in cat_analysis:
                    f.write(f"# Retire {category} models\n")
                    for model in cat_analysis['recommended_retire']:
                        f.write(f"if [ -f \"{model}.modelfile\" ]; then\n")
                        f.write(f"    rm \"{model}.modelfile\"\n")
                        f.write(f"    echo \"Retired {model}.modelfile\"\n")
                        f.write("fi\n")
                        f.write(f"ollama rm {model} 2>/dev/null || true\n")
                    f.write("\n")
            
            f.write("echo \"Model retirement completed\"\n")
        
        # Make script executable
        os.chmod(retire_script_path, 0o755)
        
        logger.info(f"Implementation scripts generated: {backup_script_path}, {retire_script_path}")

    def _generate_migration_guide(self, analysis: Dict):
        """Generate user migration guide"""
        guide_path = self.output_dir / "migration_guide.md"
        
        with open(guide_path, 'w') as f:
            f.write("# Mirador Model Consolidation Migration Guide\n\n")
            f.write("This guide will help you safely migrate to the consolidated model set.\n\n")
            
            f.write("## Pre-Migration Checklist\n\n")
            f.write("- [ ] Review the consolidation analysis report\n")
            f.write("- [ ] Test critical workflows with current models\n")
            f.write("- [ ] Ensure you have sufficient disk space for backups\n")
            f.write("- [ ] Schedule maintenance window for migration\n\n")
            
            f.write("## Migration Steps\n\n")
            f.write("### Step 1: Backup Current Models\n")
            f.write("```bash\n")
            f.write("./backup_models.sh\n")
            f.write("```\n\n")
            
            f.write("### Step 2: Test Consolidated Models\n")
            f.write("Before retiring old models, test the recommended models:\n\n")
            
            for category, cat_analysis in analysis['categories'].items():
                if 'recommended_keep' in cat_analysis:
                    f.write(f"**{category.replace('_', ' ').title()} Models:**\n")
                    for model in cat_analysis['recommended_keep']:
                        f.write(f"- Test `{model}` with typical queries\n")
                    f.write("\n")
            
            f.write("### Step 3: Update Configuration\n")
            f.write("Update your Mirador configuration to use the consolidated models:\n\n")
            f.write("```python\n")
            f.write("# Update your model references in orchestrator configuration\n")
            f.write("CONSOLIDATED_MODELS = {\n")
            
            for category, cat_analysis in analysis['categories'].items():
                if 'recommended_keep' in cat_analysis:
                    f.write(f"    '{category}': {cat_analysis['recommended_keep']},\n")
            
            f.write("}\n")
            f.write("```\n\n")
            
            f.write("### Step 4: Retire Old Models\n")
            f.write("Once testing is complete and configuration is updated:\n")
            f.write("```bash\n")
            f.write("./retire_models.sh\n")
            f.write("```\n\n")
            
            f.write("### Step 5: Verify Migration\n")
            f.write("- [ ] Run test chains with consolidated models\n")
            f.write("- [ ] Verify all expected functionality works\n")
            f.write("- [ ] Update documentation\n")
            f.write("- [ ] Clean up backup files (after verification period)\n\n")
            
            f.write("## Rollback Plan\n\n")
            f.write("If issues are discovered after migration:\n\n")
            f.write("1. Stop using consolidated models\n")
            f.write("2. Restore from backup directory\n")
            f.write("3. Revert configuration changes\n")
            f.write("4. Investigate issues before re-attempting migration\n\n")
            
            f.write("## Support\n\n")
            f.write("If you encounter issues during migration:\n")
            f.write("- Check the backup directory for original models\n")
            f.write("- Review the consolidation analysis for model mappings\n")
            f.write("- Test individual models in isolation\n")
        
        logger.info(f"Migration guide generated: {guide_path}")

def main():
    """Main execution function"""
    print("🔍 Mirador Model Consolidation Analyzer")
    print("=" * 50)
    
    # Initialize analyzer
    analyzer = MiradorModelAnalyzer()
    
    # Scan for models
    print("📊 Scanning for models...")
    models = analyzer.scan_models()
    print(f"Found {len(models)} models")
    
    # Analyze consolidation opportunities
    print("🔬 Analyzing consolidation opportunities...")
    analysis = analyzer.analyze_consolidation_opportunities(models)
    
    # Generate reports
    print("📝 Generating reports and implementation tools...")
    analyzer.generate_reports(models, analysis)
    
    # Summary
    print("\n✅ Analysis Complete!")
    print(f"📈 Current models: {analysis['total_models']}")
    print(f"🎯 Recommended for retirement: {analysis['estimated_savings']['models_removed']}")
    print(f"💾 Estimated space savings: {analysis['estimated_savings']['disk_space_mb']:.1f} MB")
    print(f"📁 Reports generated in: {analyzer.output_dir}")
    
    print("\n📋 Next Steps:")
    print("1. Review the generated reports in ./analysis_output/")
    print("2. Test the recommended models before retirement")
    print("3. Run ./analysis_output/backup_models.sh")
    print("4. Execute ./analysis_output/retire_models.sh")

if __name__ == "__main__":
    main()

