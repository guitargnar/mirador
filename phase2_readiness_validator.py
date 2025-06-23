#!/usr/bin/env python3
"""
Mirador Phase 2 Readiness Validator
Validates system readiness for base model migration after Phase 1 fixes
"""

import subprocess
import json
import time
from pathlib import Path
from typing import Dict, List, Tuple
from dataclasses import dataclass
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@dataclass
class ReadinessCheck:
    name: str
    description: str
    status: str  # 'pass', 'fail', 'warning'
    details: str
    required: bool = True

class Phase2ReadinessValidator:
    """Validates readiness for Phase 2 base model migration"""
    
    def __init__(self, output_dir: str = "./readiness_validation"):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        
        # Critical requirements for Phase 2
        self.critical_models = [
            'matthew_context_provider_v2',
            'financial_planning_expert_v6',
            'decision_simplifier_v2',
            'louisville_expert_v3',
            'enhanced_agent_enforcer_v2'
        ]
        
        # Performance thresholds
        self.performance_thresholds = {
            'min_success_rate': 0.8,  # 80% minimum
            'max_avg_response_time': 30.0,  # 30 seconds max
            'min_quality_score': 0.6  # 0.6/1.0 minimum
        }

    def check_model_availability(self) -> ReadinessCheck:
        """Check if all critical models are available in Ollama"""
        try:
            result = subprocess.run(['ollama', 'list'], capture_output=True, text=True)
            if result.returncode != 0:
                return ReadinessCheck(
                    name="Model Availability",
                    description="Check if critical models are available in Ollama",
                    status="fail",
                    details=f"Failed to query Ollama: {result.stderr}",
                    required=True
                )
            
            available_models = set()
            lines = result.stdout.strip().split('\n')[1:]  # Skip header
            for line in lines:
                if line.strip():
                    parts = line.split()
                    if parts:
                        available_models.add(parts[0])
            
            missing_models = []
            for model in self.critical_models:
                if model not in available_models:
                    missing_models.append(model)
            
            if not missing_models:
                return ReadinessCheck(
                    name="Model Availability",
                    description="Check if critical models are available in Ollama",
                    status="pass",
                    details=f"All {len(self.critical_models)} critical models are available",
                    required=True
                )
            else:
                return ReadinessCheck(
                    name="Model Availability",
                    description="Check if critical models are available in Ollama",
                    status="fail",
                    details=f"Missing models: {', '.join(missing_models)}",
                    required=True
                )
                
        except Exception as e:
            return ReadinessCheck(
                name="Model Availability",
                description="Check if critical models are available in Ollama",
                status="fail",
                details=f"Error checking models: {e}",
                required=True
            )

    def check_model_functionality(self) -> ReadinessCheck:
        """Test basic functionality of critical models"""
        test_queries = {
            'matthew_context_provider_v2': "Provide brief context about Matthew's situation.",
            'financial_planning_expert_v6': "What are key components of a budget?",
            'decision_simplifier_v2': "List 3 factors to consider when making financial decisions.",
            'louisville_expert_v3': "Name one advantage of living in Louisville.",
            'enhanced_agent_enforcer_v2': "Is this accurate: Louisville is in Kentucky?"
        }
        
        working_models = []
        failed_models = []
        
        for model_name, query in test_queries.items():
            try:
                logger.info(f"Testing {model_name}...")
                result = subprocess.run(
                    ['ollama', 'run', model_name, query],
                    capture_output=True,
                    text=True,
                    timeout=45
                )
                
                if result.returncode == 0 and len(result.stdout.strip()) > 20:
                    working_models.append(model_name)
                else:
                    failed_models.append(f"{model_name} (no response)")
                    
            except subprocess.TimeoutExpired:
                failed_models.append(f"{model_name} (timeout)")
            except Exception as e:
                failed_models.append(f"{model_name} (error: {e})")
        
        if not failed_models:
            return ReadinessCheck(
                name="Model Functionality",
                description="Test basic functionality of critical models",
                status="pass",
                details=f"All {len(working_models)} models responded correctly",
                required=True
            )
        else:
            return ReadinessCheck(
                name="Model Functionality",
                description="Test basic functionality of critical models",
                status="fail",
                details=f"Failed models: {', '.join(failed_models)}",
                required=True
            )

    def check_performance_results(self) -> ReadinessCheck:
        """Check if recent performance testing meets thresholds"""
        performance_file = Path("./performance_results/performance_data.json")
        
        if not performance_file.exists():
            return ReadinessCheck(
                name="Performance Testing",
                description="Validate performance testing results meet thresholds",
                status="fail",
                details="No performance testing results found. Run mirador_performance_tester.py first.",
                required=True
            )
        
        try:
            with open(performance_file, 'r') as f:
                data = json.load(f)
            
            analysis = data.get('analysis', {})
            summary = analysis.get('summary', {})
            
            success_rate = summary.get('overall_success_rate', 0)
            avg_response_time = summary.get('avg_response_time', 999)
            avg_quality = summary.get('avg_quality_score', 0)
            
            issues = []
            if success_rate < self.performance_thresholds['min_success_rate']:
                issues.append(f"Success rate {success_rate:.1%} < {self.performance_thresholds['min_success_rate']:.1%}")
            
            if avg_response_time > self.performance_thresholds['max_avg_response_time']:
                issues.append(f"Response time {avg_response_time:.1f}s > {self.performance_thresholds['max_avg_response_time']}s")
            
            if avg_quality < self.performance_thresholds['min_quality_score']:
                issues.append(f"Quality score {avg_quality:.2f} < {self.performance_thresholds['min_quality_score']}")
            
            if not issues:
                return ReadinessCheck(
                    name="Performance Testing",
                    description="Validate performance testing results meet thresholds",
                    status="pass",
                    details=f"Success: {success_rate:.1%}, Time: {avg_response_time:.1f}s, Quality: {avg_quality:.2f}",
                    required=True
                )
            else:
                return ReadinessCheck(
                    name="Performance Testing",
                    description="Validate performance testing results meet thresholds",
                    status="fail",
                    details=f"Issues: {'; '.join(issues)}",
                    required=True
                )
                
        except Exception as e:
            return ReadinessCheck(
                name="Performance Testing",
                description="Validate performance testing results meet thresholds",
                status="fail",
                details=f"Error reading performance data: {e}",
                required=True
            )

    def check_backup_capability(self) -> ReadinessCheck:
        """Check if backup scripts are available and functional"""
        backup_script = Path("./analysis_output/backup_models.sh")
        
        if not backup_script.exists():
            return ReadinessCheck(
                name="Backup Capability",
                description="Verify backup scripts are available",
                status="fail",
                details="Backup script not found. Re-run mirador_model_analyzer.py",
                required=True
            )
        
        # Check if script is executable
        if not backup_script.stat().st_mode & 0o111:
            return ReadinessCheck(
                name="Backup Capability",
                description="Verify backup scripts are available",
                status="warning",
                details="Backup script exists but is not executable. Run: chmod +x analysis_output/backup_models.sh",
                required=True
            )
        
        return ReadinessCheck(
            name="Backup Capability",
            description="Verify backup scripts are available",
            status="pass",
            details="Backup script is available and executable",
            required=True
        )

    def check_disk_space(self) -> ReadinessCheck:
        """Check available disk space for migration"""
        try:
            result = subprocess.run(['df', '-h', '.'], capture_output=True, text=True)
            if result.returncode != 0:
                return ReadinessCheck(
                    name="Disk Space",
                    description="Check available disk space for migration",
                    status="warning",
                    details="Could not check disk space",
                    required=False
                )
            
            lines = result.stdout.strip().split('\n')
            if len(lines) >= 2:
                parts = lines[1].split()
                if len(parts) >= 4:
                    available = parts[3]
                    used_percent = parts[4]
                    
                    # Extract numeric value from percentage
                    used_num = int(used_percent.rstrip('%'))
                    
                    if used_num > 90:
                        status = "warning"
                        details = f"Disk usage high: {used_percent} used, {available} available"
                    else:
                        status = "pass"
                        details = f"Sufficient space: {available} available ({used_percent} used)"
                    
                    return ReadinessCheck(
                        name="Disk Space",
                        description="Check available disk space for migration",
                        status=status,
                        details=details,
                        required=False
                    )
            
            return ReadinessCheck(
                name="Disk Space",
                description="Check available disk space for migration",
                status="warning",
                details="Could not parse disk space information",
                required=False
            )
            
        except Exception as e:
            return ReadinessCheck(
                name="Disk Space",
                description="Check available disk space for migration",
                status="warning",
                details=f"Error checking disk space: {e}",
                required=False
            )

    def check_ollama_service(self) -> ReadinessCheck:
        """Check if Ollama service is running properly"""
        try:
            # Test basic Ollama functionality
            result = subprocess.run(['ollama', 'version'], capture_output=True, text=True, timeout=10)
            if result.returncode != 0:
                return ReadinessCheck(
                    name="Ollama Service",
                    description="Verify Ollama service is running",
                    status="fail",
                    details="Ollama service not responding",
                    required=True
                )
            
            version = result.stdout.strip()
            return ReadinessCheck(
                name="Ollama Service",
                description="Verify Ollama service is running",
                status="pass",
                details=f"Ollama is running: {version}",
                required=True
            )
            
        except subprocess.TimeoutExpired:
            return ReadinessCheck(
                name="Ollama Service",
                description="Verify Ollama service is running",
                status="fail",
                details="Ollama service timeout",
                required=True
            )
        except Exception as e:
            return ReadinessCheck(
                name="Ollama Service",
                description="Verify Ollama service is running",
                status="fail",
                details=f"Error checking Ollama: {e}",
                required=True
            )

    def check_configuration_files(self) -> ReadinessCheck:
        """Check if optimized configuration files are available"""
        config_file = Path("./optimized_configs/mirador_config.yaml")
        
        if not config_file.exists():
            return ReadinessCheck(
                name="Configuration Files",
                description="Verify optimized configuration files are available",
                status="fail",
                details="Optimized config not found. Run mirador_config_generator.py",
                required=True
            )
        
        # Check if modelfiles directory exists
        modelfiles_dir = Path("./optimized_configs/modelfiles")
        if not modelfiles_dir.exists():
            return ReadinessCheck(
                name="Configuration Files",
                description="Verify optimized configuration files are available",
                status="fail",
                details="Optimized modelfiles directory not found",
                required=True
            )
        
        # Count modelfiles
        modelfiles = list(modelfiles_dir.glob("*.modelfile"))
        
        return ReadinessCheck(
            name="Configuration Files",
            description="Verify optimized configuration files are available",
            status="pass",
            details=f"Configuration ready: {len(modelfiles)} optimized modelfiles available",
            required=True
        )

    def run_comprehensive_validation(self) -> Tuple[List[ReadinessCheck], bool]:
        """Run all readiness checks"""
        checks = []
        
        print("🔍 Running Phase 2 readiness validation...")
        
        # Run all checks
        checks.append(self.check_ollama_service())
        checks.append(self.check_model_availability())
        checks.append(self.check_model_functionality())
        checks.append(self.check_performance_results())
        checks.append(self.check_backup_capability())
        checks.append(self.check_configuration_files())
        checks.append(self.check_disk_space())
        
        # Determine overall readiness
        required_checks = [c for c in checks if c.required]
        failed_required = [c for c in required_checks if c.status == 'fail']
        
        ready_for_phase2 = len(failed_required) == 0
        
        return checks, ready_for_phase2

    def generate_readiness_report(self, checks: List[ReadinessCheck], ready: bool):
        """Generate comprehensive readiness report"""
        report_path = self.output_dir / "phase2_readiness_report.md"
        
        with open(report_path, 'w') as f:
            f.write("# Phase 2 Readiness Validation Report\n\n")
            f.write(f"**Generated:** {subprocess.run(['date'], capture_output=True, text=True).stdout.strip()}\n\n")
            
            # Overall Status
            if ready:
                f.write("## ✅ READY FOR PHASE 2\n\n")
                f.write("All critical requirements have been met. You can proceed with base model migration.\n\n")
            else:
                f.write("## ❌ NOT READY FOR PHASE 2\n\n")
                f.write("Critical issues must be resolved before proceeding with base model migration.\n\n")
            
            # Summary
            passed = len([c for c in checks if c.status == 'pass'])
            failed = len([c for c in checks if c.status == 'fail'])
            warnings = len([c for c in checks if c.status == 'warning'])
            
            f.write("## Validation Summary\n\n")
            f.write(f"- ✅ **Passed:** {passed}\n")
            f.write(f"- ❌ **Failed:** {failed}\n")
            f.write(f"- ⚠️  **Warnings:** {warnings}\n\n")
            
            # Detailed Results
            f.write("## Detailed Results\n\n")
            
            for check in checks:
                if check.status == 'pass':
                    icon = "✅"
                elif check.status == 'fail':
                    icon = "❌"
                else:
                    icon = "⚠️"
                
                required_text = " (Required)" if check.required else " (Optional)"
                f.write(f"### {icon} {check.name}{required_text}\n\n")
                f.write(f"**Description:** {check.description}\n\n")
                f.write(f"**Status:** {check.status.upper()}\n\n")
                f.write(f"**Details:** {check.details}\n\n")
            
            # Action Items
            failed_checks = [c for c in checks if c.status == 'fail' and c.required]
            if failed_checks:
                f.write("## Required Actions Before Phase 2\n\n")
                for i, check in enumerate(failed_checks, 1):
                    f.write(f"{i}. **{check.name}:** {check.details}\n")
                f.write("\n")
            
            warning_checks = [c for c in checks if c.status == 'warning']
            if warning_checks:
                f.write("## Recommended Actions\n\n")
                for check in warning_checks:
                    f.write(f"- **{check.name}:** {check.details}\n")
                f.write("\n")
            
            # Next Steps
            if ready:
                f.write("## Next Steps\n\n")
                f.write("1. Create a backup of current system state\n")
                f.write("2. Run the Phase 2 base model migration script\n")
                f.write("3. Test the migrated system thoroughly\n")
                f.write("4. Monitor performance after migration\n\n")
            else:
                f.write("## Next Steps\n\n")
                f.write("1. Address all failed required checks listed above\n")
                f.write("2. Re-run this validation script\n")
                f.write("3. Proceed to Phase 2 only when all checks pass\n\n")
        
        logger.info(f"Readiness report generated: {report_path}")

def main():
    """Main execution function"""
    print("🚦 Phase 2 Readiness Validator")
    print("=" * 40)
    
    validator = Phase2ReadinessValidator()
    
    # Run validation
    checks, ready = validator.run_comprehensive_validation()
    
    # Generate report
    validator.generate_readiness_report(checks, ready)
    
    # Summary
    print(f"\n📊 Validation Results:")
    passed = len([c for c in checks if c.status == 'pass'])
    failed = len([c for c in checks if c.status == 'fail'])
    warnings = len([c for c in checks if c.status == 'warning'])
    
    print(f"✅ Passed: {passed}")
    print(f"❌ Failed: {failed}")
    print(f"⚠️  Warnings: {warnings}")
    
    if ready:
        print("\n🎉 READY FOR PHASE 2!")
        print("All critical requirements met. You can proceed with base model migration.")
    else:
        print("\n🚨 NOT READY FOR PHASE 2")
        print("Please address failed checks before proceeding.")
        
        failed_required = [c for c in checks if c.status == 'fail' and c.required]
        print(f"\nRequired fixes:")
        for check in failed_required:
            print(f"- {check.name}: {check.details}")
    
    print(f"\n📁 Detailed report: {validator.output_dir}/phase2_readiness_report.md")

if __name__ == "__main__":
    main()

