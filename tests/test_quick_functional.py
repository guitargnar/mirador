#!/usr/bin/env python3
"""
Quick Functional Test Report for Mirador AI Framework
Generates a quick test report without lengthy executions
"""

import os
import sys
import subprocess
import json
import time
from datetime import datetime

class QuickTestRunner:
    def __init__(self):
        self.project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        self.timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        self.test_log_dir = os.path.join(self.project_root, 'test_logs')
        os.makedirs(self.test_log_dir, exist_ok=True)
        
    def run_quick_tests(self):
        """Run quick tests and generate report."""
        print("🚀 Mirador AI Framework - Quick Test Report")
        print("=" * 80)
        print(f"Test Date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        print(f"Project Root: {self.project_root}")
        print("")
        
        results = {
            'timestamp': self.timestamp,
            'tests': {}
        }
        
        # 1. Check Ollama Status
        print("1. CHECKING OLLAMA STATUS")
        print("-" * 40)
        cmd = "ollama list"
        returncode, stdout, stderr = self._run_command(cmd, timeout=10)
        
        if returncode == 0:
            lines = stdout.strip().split('\n')
            model_count = len([l for l in lines[1:] if l.strip()])
            print(f"✅ Ollama is running with {model_count} models")
            results['tests']['ollama_status'] = {'status': 'running', 'model_count': model_count}
            
            # Check for critical models
            critical_models = [
                'matthew_context_provider_v6_complete',
                'master_coder',
                'speed_optimizer_phi',
                'practical_implementer',
                'universal_strategy_architect'
            ]
            
            missing_models = []
            for model in critical_models:
                if model not in stdout:
                    missing_models.append(model)
            
            if missing_models:
                print(f"⚠️  Missing critical models: {', '.join(missing_models)}")
                results['tests']['missing_models'] = missing_models
            else:
                print("✅ All critical models available")
                results['tests']['missing_models'] = []
        else:
            print("❌ Ollama not running - please start with: ollama serve")
            results['tests']['ollama_status'] = {'status': 'not_running'}
            return results
        
        # 2. Check Mirador Scripts
        print("\n2. CHECKING MIRADOR SCRIPTS")
        print("-" * 40)
        
        scripts_to_check = [
            ('bin/mirador-smart-v3', 'Smart Router v3'),
            ('bin/mirador_universal_runner_v3_optimized.sh', 'Universal Runner v3'),
            ('bin/mirador_universal_runner.sh', 'Universal Runner'),
            ('bin/mirador_feedback.sh', 'Feedback Logger')
        ]
        
        script_results = []
        for script_path, script_name in scripts_to_check:
            full_path = os.path.join(self.project_root, script_path)
            if os.path.exists(full_path):
                if os.access(full_path, os.X_OK):
                    print(f"✅ {script_name}: Found and executable")
                    script_results.append({'name': script_name, 'status': 'ok'})
                else:
                    print(f"⚠️  {script_name}: Found but not executable")
                    script_results.append({'name': script_name, 'status': 'not_executable'})
            else:
                print(f"❌ {script_name}: Not found")
                script_results.append({'name': script_name, 'status': 'missing'})
        
        results['tests']['scripts'] = script_results
        
        # 3. Test Basic Routing
        print("\n3. TESTING SMART ROUTING")
        print("-" * 40)
        
        # Just test that the script runs and detects intent
        test_query = "What time is it?"
        cmd = f"./bin/mirador-smart-v3 \"{test_query}\""
        
        # Run with short timeout for quick response
        start_time = time.time()
        process = subprocess.Popen(
            cmd,
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            cwd=self.project_root
        )
        
        # Wait max 5 seconds for intent detection
        output_lines = []
        intent_detected = None
        start = time.time()
        
        while time.time() - start < 5:
            line = process.stdout.readline()
            if line:
                output_lines.append(line.strip())
                if 'Intent detected:' in line:
                    intent_detected = line.split('Intent detected:')[1].strip()
                    break
            if process.poll() is not None:
                break
        
        process.terminate()
        execution_time = time.time() - start_time
        
        if intent_detected:
            print(f"✅ Routing working - detected intent: {intent_detected} ({execution_time:.2f}s)")
            results['tests']['routing'] = {'status': 'working', 'intent': intent_detected, 'time': execution_time}
        else:
            print(f"❌ Routing failed - no intent detected")
            results['tests']['routing'] = {'status': 'failed'}
        
        # 4. Check Output Directory
        print("\n4. CHECKING OUTPUT MANAGEMENT")
        print("-" * 40)
        
        outputs_dir = os.path.join(self.project_root, 'outputs')
        if os.path.exists(outputs_dir):
            output_dirs = [d for d in os.listdir(outputs_dir) if os.path.isdir(os.path.join(outputs_dir, d))]
            v3_dirs = [d for d in output_dirs if d.startswith('v3_')]
            print(f"✅ Output directory exists with {len(output_dirs)} subdirectories")
            print(f"   - {len(v3_dirs)} v3 output directories")
            results['tests']['output_management'] = {'status': 'ok', 'total_dirs': len(output_dirs), 'v3_dirs': len(v3_dirs)}
        else:
            print("⚠️  Output directory not found")
            results['tests']['output_management'] = {'status': 'missing'}
        
        # 5. Check Logs
        print("\n5. CHECKING LOGGING")
        print("-" * 40)
        
        logs_dir = os.path.join(self.project_root, 'logs')
        feedback_log = os.path.join(logs_dir, 'routing_feedback.log')
        
        if os.path.exists(feedback_log):
            with open(feedback_log, 'r') as f:
                lines = f.readlines()
                print(f"✅ Feedback log exists with {len(lines)} entries")
                if lines:
                    last_entry = lines[-1].strip()
                    print(f"   Last entry: {last_entry[:80]}...")
                results['tests']['logging'] = {'status': 'ok', 'entries': len(lines)}
        else:
            print("⚠️  Feedback log not found")
            results['tests']['logging'] = {'status': 'missing'}
        
        # 6. Test Speed Optimizer
        print("\n6. TESTING QUICK RESPONSE MODEL")
        print("-" * 40)
        
        cmd = "echo 'Say hello' | ollama run speed_optimizer_phi"
        start_time = time.time()
        returncode, stdout, stderr = self._run_command(cmd, timeout=30)
        execution_time = time.time() - start_time
        
        if returncode == 0 and len(stdout.strip()) > 0:
            print(f"✅ Speed optimizer working ({execution_time:.2f}s)")
            print(f"   Response: {stdout.strip()[:50]}...")
            results['tests']['speed_optimizer'] = {'status': 'working', 'time': execution_time}
        else:
            print("❌ Speed optimizer failed")
            results['tests']['speed_optimizer'] = {'status': 'failed'}
        
        # Generate Summary
        print("\n" + "=" * 80)
        print("SUMMARY")
        print("=" * 80)
        
        # Count successes
        total_tests = 0
        passed_tests = 0
        
        for test_name, test_result in results['tests'].items():
            total_tests += 1
            if isinstance(test_result, dict):
                if test_result.get('status') in ['running', 'working', 'ok']:
                    passed_tests += 1
            elif isinstance(test_result, list) and len(test_result) == 0:  # missing_models
                passed_tests += 1
        
        success_rate = (passed_tests / total_tests * 100) if total_tests > 0 else 0
        print(f"Tests Passed: {passed_tests}/{total_tests} ({success_rate:.1f}%)")
        
        # Recommendations
        print("\nRECOMMENDATIONS:")
        print("-" * 40)
        
        if results['tests'].get('missing_models'):
            print("- Install missing models:")
            for model in results['tests']['missing_models']:
                print(f"  ollama pull {model}")
        
        if success_rate < 80:
            print("- System needs attention, check failed components")
        else:
            print("- System appears to be functioning well")
        
        # Save results
        report_path = os.path.join(self.test_log_dir, f"quick_test_report_{self.timestamp}.json")
        with open(report_path, 'w') as f:
            json.dump(results, f, indent=2)
        
        print(f"\n📄 Full results saved to: {report_path}")
        
        return results
    
    def _run_command(self, command, timeout=60):
        """Execute command with timeout."""
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
            return -1, "", f"Timeout after {timeout}s"


def main():
    tester = QuickTestRunner()
    results = tester.run_quick_tests()
    
    # Exit with appropriate code
    if results['tests'].get('ollama_status', {}).get('status') != 'running':
        sys.exit(2)  # Critical failure
    
    success_count = sum(1 for t in results['tests'].values() 
                       if isinstance(t, dict) and t.get('status') in ['running', 'working', 'ok']
                       or isinstance(t, list) and len(t) == 0)
    
    if success_count < len(results['tests']) * 0.8:
        sys.exit(1)  # Some failures
    
    sys.exit(0)  # Success


if __name__ == "__main__":
    main()