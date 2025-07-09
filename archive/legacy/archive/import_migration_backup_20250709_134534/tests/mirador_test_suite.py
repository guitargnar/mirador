#!/usr/bin/env python3
"""
Comprehensive Test Suite for Mirador AI Framework
Execute this in a separate terminal to test all components
"""

import os
import sys
import subprocess
import json
import time
import unittest
import tempfile
import shutil
from datetime import datetime
from typing import Dict, List, Tuple, Optional
import psutil

# Add parent directory to path for imports
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

class MiradorTestSuite:
    """Main test orchestrator for Mirador framework."""
    
    def __init__(self):
        self.project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        self.test_results = []
        self.start_time = time.time()
        self.test_log_dir = os.path.join(self.project_root, 'test_logs')
        os.makedirs(self.test_log_dir, exist_ok=True)
        
        # Test configuration
        self.test_config = {
            'verbose': True,
            'fail_fast': False,
            'parallel': False,
            'timeout': 300  # 5 minutes per test category
        }
    
    def log(self, message: str, level: str = "INFO"):
        """Log test messages with timestamp."""
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        log_entry = f"[{timestamp}] [{level}] {message}"
        print(log_entry)
        
        # Also write to log file
        log_file = os.path.join(self.test_log_dir, f"test_run_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log")
        with open(log_file, 'a') as f:
            f.write(log_entry + '\n')
    
    def run_command(self, command: str, timeout: int = 60) -> Tuple[int, str, str]:
        """Execute shell command with timeout."""
        try:
            process = subprocess.Popen(
                command,
                shell=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                cwd=self.project_root
            )
            stdout, stderr = process.communicate(timeout=timeout)
            return process.returncode, stdout, stderr
        except subprocess.TimeoutExpired:
            process.kill()
            return -1, "", f"Command timed out after {timeout} seconds"
    
    def test_python_imports(self) -> Dict[str, any]:
        """Test that all Python modules can be imported."""
        self.log("Testing Python module imports...")
        results = {'passed': 0, 'failed': 0, 'modules': []}
        
        python_files = [
            'mirador.py',
            'framework.py',
            'enhanced_mirador.py',
            'metrics_tracker.py',
            'pain_point_analyzer.py',
            'memory_system.py',
            'quality_assurance.py',
            'automation_engine.py',
            'advocates_program.py'
        ]
        
        for module_file in python_files:
            module_name = module_file.replace('.py', '')
            try:
                # Create test import script
                test_script = f"""
import sys
sys.path.insert(0, '{self.project_root}')
try:
    import {module_name}
    print('SUCCESS')
except Exception as e:
    print(f'FAILED: {{str(e)}}')
"""
                with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False) as f:
                    f.write(test_script)
                    temp_file = f.name
                
                returncode, stdout, stderr = self.run_command(f"python3 {temp_file}", timeout=10)
                os.unlink(temp_file)
                
                if 'SUCCESS' in stdout:
                    results['passed'] += 1
                    results['modules'].append((module_name, 'PASS', ''))
                    self.log(f"✅ {module_name}: Import successful")
                else:
                    results['failed'] += 1
                    error_msg = stdout.strip() if stdout else stderr.strip()
                    results['modules'].append((module_name, 'FAIL', error_msg))
                    self.log(f"❌ {module_name}: Import failed - {error_msg}", "ERROR")
                    
            except Exception as e:
                results['failed'] += 1
                results['modules'].append((module_name, 'FAIL', str(e)))
                self.log(f"❌ {module_name}: Test error - {str(e)}", "ERROR")
        
        return results
    
    def test_shell_scripts(self) -> Dict[str, any]:
        """Test shell script syntax and basic execution."""
        self.log("Testing shell scripts...")
        results = {'passed': 0, 'failed': 0, 'scripts': []}
        
        # Key shell scripts to test
        shell_scripts = [
            'company_chain_runner.sh',
            'robust_chain_runner.sh',
            'daily_check.sh',
            'test_suite.sh',
            'audit_models.sh'
        ]
        
        for script in shell_scripts:
            script_path = os.path.join(self.project_root, script)
            if not os.path.exists(script_path):
                results['failed'] += 1
                results['scripts'].append((script, 'FAIL', 'File not found'))
                self.log(f"❌ {script}: File not found", "ERROR")
                continue
            
            # Test bash syntax
            returncode, stdout, stderr = self.run_command(f"bash -n {script_path}", timeout=5)
            
            if returncode == 0:
                results['passed'] += 1
                results['scripts'].append((script, 'PASS', 'Syntax valid'))
                self.log(f"✅ {script}: Syntax valid")
            else:
                results['failed'] += 1
                results['scripts'].append((script, 'FAIL', stderr.strip()))
                self.log(f"❌ {script}: Syntax error - {stderr.strip()}", "ERROR")
        
        return results
    
    def test_ollama_connectivity(self) -> Dict[str, any]:
        """Test Ollama service connectivity."""
        self.log("Testing Ollama connectivity...")
        results = {'status': 'unknown', 'models': [], 'error': None}
        
        # Check if Ollama is running
        returncode, stdout, stderr = self.run_command("ollama list", timeout=10)
        
        if returncode == 0:
            results['status'] = 'connected'
            # Parse available models
            lines = stdout.strip().split('\n')[1:]  # Skip header
            for line in lines:
                if line.strip():
                    model_name = line.split()[0]
                    results['models'].append(model_name)
            self.log(f"✅ Ollama connected with {len(results['models'])} models")
        else:
            results['status'] = 'disconnected'
            results['error'] = stderr.strip() if stderr else 'Ollama not running'
            self.log(f"❌ Ollama not accessible: {results['error']}", "ERROR")
        
        return results
    
    def test_configuration_files(self) -> Dict[str, any]:
        """Test configuration file validity."""
        self.log("Testing configuration files...")
        results = {'passed': 0, 'failed': 0, 'configs': []}
        
        config_files = [
            'config.json',
            'ai_framework/config.json',
            'company_chain_templates.json',
            'config/intervention.json'
        ]
        
        for config_file in config_files:
            config_path = os.path.join(self.project_root, config_file)
            if not os.path.exists(config_path):
                results['failed'] += 1
                results['configs'].append((config_file, 'FAIL', 'File not found'))
                self.log(f"❌ {config_file}: File not found", "WARNING")
                continue
            
            try:
                with open(config_path, 'r') as f:
                    json.load(f)
                results['passed'] += 1
                results['configs'].append((config_file, 'PASS', 'Valid JSON'))
                self.log(f"✅ {config_file}: Valid JSON")
            except json.JSONDecodeError as e:
                results['failed'] += 1
                results['configs'].append((config_file, 'FAIL', f'Invalid JSON: {str(e)}'))
                self.log(f"❌ {config_file}: Invalid JSON - {str(e)}", "ERROR")
        
        return results
    
    def test_productivity_tools(self) -> Dict[str, any]:
        """Test productivity tools functionality."""
        self.log("Testing productivity tools...")
        results = {'passed': 0, 'failed': 0, 'tools': []}
        
        tools_dir = os.path.join(self.project_root, 'productivity_tools')
        if not os.path.exists(tools_dir):
            self.log("⚠️  Productivity tools directory not found", "WARNING")
            return results
        
        # Test each tool can be imported
        tool_files = [f for f in os.listdir(tools_dir) if f.endswith('.py') and not f.startswith('__')]
        
        for tool_file in tool_files[:5]:  # Test first 5 tools
            tool_name = tool_file.replace('.py', '')
            try:
                test_script = f"""
import sys
sys.path.insert(0, '{tools_dir}')
try:
    import {tool_name}
    print('SUCCESS')
except Exception as e:
    print(f'FAILED: {{str(e)}}')
"""
                with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False) as f:
                    f.write(test_script)
                    temp_file = f.name
                
                returncode, stdout, stderr = self.run_command(f"python3 {temp_file}", timeout=5)
                os.unlink(temp_file)
                
                if 'SUCCESS' in stdout:
                    results['passed'] += 1
                    results['tools'].append((tool_name, 'PASS', ''))
                    self.log(f"✅ {tool_name}: Import successful")
                else:
                    results['failed'] += 1
                    results['tools'].append((tool_name, 'FAIL', stdout.strip()))
                    self.log(f"❌ {tool_name}: Import failed", "ERROR")
                    
            except Exception as e:
                results['failed'] += 1
                results['tools'].append((tool_name, 'FAIL', str(e)))
                self.log(f"❌ {tool_name}: Test error - {str(e)}", "ERROR")
        
        return results
    
    def test_memory_system(self) -> Dict[str, any]:
        """Test memory system functionality."""
        self.log("Testing memory system...")
        results = {'status': 'unknown', 'tests': []}
        
        try:
            # Create test script for memory system
            test_script = """
import sys
sys.path.insert(0, '""" + self.project_root + """')
from memory_system import MemorySystem

# Test basic functionality
memory = MemorySystem()
memory.store('test_key', 'test_value')
retrieved = memory.retrieve('test_key')

if retrieved == 'test_value':
    print('PASS: Store and retrieve working')
else:
    print(f'FAIL: Expected test_value, got {retrieved}')

# Test persistence
memory.save_to_disk()
memory2 = MemorySystem()
memory2.load_from_disk()
retrieved2 = memory2.retrieve('test_key')

if retrieved2 == 'test_value':
    print('PASS: Persistence working')
else:
    print('FAIL: Persistence not working')
"""
            with tempfile.NamedTemporaryFile(mode='w', suffix='.py', delete=False) as f:
                f.write(test_script)
                temp_file = f.name
            
            returncode, stdout, stderr = self.run_command(f"python3 {temp_file}", timeout=10)
            os.unlink(temp_file)
            
            if returncode == 0 and 'PASS' in stdout:
                results['status'] = 'working'
                results['tests'] = stdout.strip().split('\n')
                self.log("✅ Memory system tests passed")
            else:
                results['status'] = 'failed'
                results['tests'] = [stderr.strip() if stderr else stdout.strip()]
                self.log(f"❌ Memory system tests failed: {results['tests'][0]}", "ERROR")
                
        except Exception as e:
            results['status'] = 'error'
            results['tests'] = [str(e)]
            self.log(f"❌ Memory system test error: {str(e)}", "ERROR")
        
        return results
    
    def test_system_resources(self) -> Dict[str, any]:
        """Test system resource availability."""
        self.log("Testing system resources...")
        
        # Check CPU usage
        cpu_percent = psutil.cpu_percent(interval=1)
        
        # Check memory
        memory = psutil.virtual_memory()
        memory_available_gb = memory.available / (1024**3)
        
        # Check disk space
        disk = psutil.disk_usage(self.project_root)
        disk_free_gb = disk.free / (1024**3)
        
        results = {
            'cpu_usage': cpu_percent,
            'memory_available_gb': round(memory_available_gb, 2),
            'disk_free_gb': round(disk_free_gb, 2),
            'status': 'healthy' if cpu_percent < 80 and memory_available_gb > 2 and disk_free_gb > 5 else 'constrained'
        }
        
        self.log(f"📊 System resources - CPU: {cpu_percent}%, Memory: {memory_available_gb}GB free, Disk: {disk_free_gb}GB free")
        
        return results
    
    def generate_report(self):
        """Generate comprehensive test report."""
        elapsed_time = time.time() - self.start_time
        
        report_lines = [
            "=" * 80,
            "MIRADOR AI FRAMEWORK - COMPREHENSIVE TEST REPORT",
            "=" * 80,
            f"Test Date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
            f"Total Duration: {elapsed_time:.2f} seconds",
            f"Project Root: {self.project_root}",
            "",
            "TEST RESULTS SUMMARY",
            "-" * 80
        ]
        
        total_passed = 0
        total_failed = 0
        
        for test_category, results in self.test_results:
            report_lines.append(f"\n{test_category}:")
            
            if 'passed' in results and 'failed' in results:
                total_passed += results['passed']
                total_failed += results['failed']
                report_lines.append(f"  ✅ Passed: {results['passed']}")
                report_lines.append(f"  ❌ Failed: {results['failed']}")
            elif 'status' in results:
                status_emoji = "✅" if results['status'] in ['connected', 'working', 'healthy'] else "❌"
                report_lines.append(f"  {status_emoji} Status: {results['status']}")
            
            # Add details for failed tests
            if 'modules' in results:
                for module, status, error in results['modules']:
                    if status == 'FAIL':
                        report_lines.append(f"    ❌ {module}: {error}")
            elif 'scripts' in results:
                for script, status, error in results['scripts']:
                    if status == 'FAIL':
                        report_lines.append(f"    ❌ {script}: {error}")
        
        report_lines.extend([
            "",
            "=" * 80,
            f"OVERALL: {total_passed} passed, {total_failed} failed",
            f"Success Rate: {(total_passed / (total_passed + total_failed) * 100):.1f}%" if (total_passed + total_failed) > 0 else "N/A",
            "=" * 80
        ])
        
        # Save report
        report_path = os.path.join(self.test_log_dir, f"test_report_{datetime.now().strftime('%Y%m%d_%H%M%S')}.txt")
        with open(report_path, 'w') as f:
            f.write('\n'.join(report_lines))
        
        # Print report
        print('\n'.join(report_lines))
        print(f"\n📄 Full report saved to: {report_path}")
        
        return report_path
    
    def run_all_tests(self):
        """Execute all test categories."""
        self.log("🚀 Starting Mirador comprehensive test suite...")
        
        test_categories = [
            ("Python Module Imports", self.test_python_imports),
            ("Shell Script Validation", self.test_shell_scripts),
            ("Ollama Connectivity", self.test_ollama_connectivity),
            ("Configuration Files", self.test_configuration_files),
            ("Productivity Tools", self.test_productivity_tools),
            ("Memory System", self.test_memory_system),
            ("System Resources", self.test_system_resources)
        ]
        
        for category_name, test_func in test_categories:
            self.log(f"\n{'='*60}")
            self.log(f"Running: {category_name}")
            self.log('='*60)
            
            try:
                results = test_func()
                self.test_results.append((category_name, results))
            except Exception as e:
                self.log(f"❌ Fatal error in {category_name}: {str(e)}", "ERROR")
                self.test_results.append((category_name, {'status': 'error', 'error': str(e)}))
                
                if self.test_config['fail_fast']:
                    break
        
        # Generate final report
        report_path = self.generate_report()
        
        return report_path


def main():
    """Main entry point for test suite."""
    import argparse
    
    parser = argparse.ArgumentParser(description='Mirador AI Framework Test Suite')
    parser.add_argument('--verbose', '-v', action='store_true', help='Verbose output')
    parser.add_argument('--fail-fast', '-f', action='store_true', help='Stop on first failure')
    parser.add_argument('--parallel', '-p', action='store_true', help='Run tests in parallel')
    parser.add_argument('--timeout', '-t', type=int, default=300, help='Timeout per test category (seconds)')
    
    args = parser.parse_args()
    
    # Create and configure test suite
    suite = MiradorTestSuite()
    suite.test_config['verbose'] = args.verbose
    suite.test_config['fail_fast'] = args.fail_fast
    suite.test_config['parallel'] = args.parallel
    suite.test_config['timeout'] = args.timeout
    
    # Run tests
    report_path = suite.run_all_tests()
    
    # Exit with appropriate code
    total_failed = sum(1 for _, results in suite.test_results 
                      if 'failed' in results and results['failed'] > 0)
    sys.exit(1 if total_failed > 0 else 0)


if __name__ == "__main__":
    main()