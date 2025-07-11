#!/usr/bin/env python3
"""
Functional Tests for Mirador AI Framework
Tests actual functionality rather than internals
"""

import os
import sys
import subprocess
import json
import time
from datetime import datetime
from typing import Dict, List, Tuple

class MiradorFunctionalTester:
    """Test Mirador functionality end-to-end."""
    
    def __init__(self):
        self.project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        self.test_results = []
        self.test_log_dir = os.path.join(self.project_root, 'test_logs')
        os.makedirs(self.test_log_dir, exist_ok=True)
        self.timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        
    def log(self, message: str, level: str = "INFO"):
        """Log test messages."""
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        print(f"[{timestamp}] [{level}] {message}")
        
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
    
    def test_mirador_smart_v3_routing(self):
        """Test mirador-smart-v3 with different query types."""
        self.log("\n=== Testing Mirador Smart v3 Routing ===")
        
        test_cases = [
            {
                'query': 'Write a Python script to process CSV files',
                'expected_intent': 'technical',
                'expected_models': ['master_coder', 'command_r_code_analyst']
            },
            {
                'query': 'Quick summary of my day',
                'expected_intent': 'quick',
                'expected_models': ['speed_optimizer_phi']
            },
            {
                'query': 'Plan my monthly budget with teenagers',
                'expected_intent': 'financial',
                'expected_models': ['universal_financial_advisor']
            },
            {
                'query': 'Improve my guitar soloing technique',
                'expected_intent': 'music',
                'expected_models': ['universal_music_mentor']
            },
            {
                'query': 'Strategy for AI leadership at work',
                'expected_intent': 'career',
                'expected_models': ['universal_career_strategist']
            }
        ]
        
        results = []
        for test in test_cases:
            self.log(f"\nTesting: '{test['query']}'")
            
            # Run mirador-smart-v3
            cmd = f"./bin/mirador-smart-v3 \"{test['query']}\""
            start_time = time.time()
            returncode, stdout, stderr = self.run_command(cmd, timeout=120)
            execution_time = time.time() - start_time
            
            # Check results
            result = {
                'query': test['query'],
                'expected_intent': test['expected_intent'],
                'execution_time': execution_time,
                'success': False,
                'detected_intent': None,
                'models_used': []
            }
            
            if returncode == 0:
                # Parse output for intent detection
                if 'Intent detected:' in stdout:
                    for line in stdout.split('\n'):
                        if 'Intent detected:' in line:
                            result['detected_intent'] = line.split('Intent detected:')[1].strip()
                            break
                
                # Check for model execution
                for model in test['expected_models']:
                    if model in stdout:
                        result['models_used'].append(model)
                
                # Check output directory creation
                if 'Output saved to' in stdout:
                    result['output_saved'] = True
                    
                result['success'] = len(stdout) > 100
                
                if result['success']:
                    self.log(f"✅ Success: {execution_time:.2f}s, {len(stdout)} chars output")
                    if result['detected_intent']:
                        self.log(f"   Detected intent: {result['detected_intent']}")
                else:
                    self.log(f"❌ Failed: Output too short")
            else:
                self.log(f"❌ Failed: Return code {returncode}")
                if stderr:
                    self.log(f"   Error: {stderr[:100]}")
            
            results.append(result)
        
        # Summary
        success_count = sum(1 for r in results if r['success'])
        self.log(f"\nRouting Test Summary: {success_count}/{len(results)} successful")
        
        return results
    
    def test_chain_execution(self):
        """Test chain execution functionality."""
        self.log("\n=== Testing Chain Execution ===")
        
        # Test universal runner
        chains = [
            ('life_optimization', 'Optimize my daily routine'),
            ('technical_mastery', 'Master Python async programming'),
            ('creative_breakthrough', 'Generate innovative AI ideas')
        ]
        
        results = []
        for chain_type, prompt in chains:
            self.log(f"\nTesting chain: {chain_type}")
            
            # Try different runner locations
            runners = [
                './bin/mirador_universal_runner_v3_optimized.sh',
                './bin/mirador_universal_runner.sh'
            ]
            
            chain_result = {
                'chain': chain_type,
                'prompt': prompt,
                'success': False,
                'runner': None,
                'execution_time': 0,
                'output_length': 0
            }
            
            for runner in runners:
                if os.path.exists(runner):
                    cmd = f"{runner} {chain_type} \"{prompt}\" quick"
                    start_time = time.time()
                    returncode, stdout, stderr = self.run_command(cmd, timeout=180)
                    execution_time = time.time() - start_time
                    
                    if returncode == 0 and len(stdout) > 100:
                        chain_result['success'] = True
                        chain_result['runner'] = runner
                        chain_result['execution_time'] = execution_time
                        chain_result['output_length'] = len(stdout)
                        self.log(f"✅ Success with {runner}: {execution_time:.2f}s")
                        break
                    else:
                        self.log(f"   Failed with {runner}")
            
            if not chain_result['success']:
                self.log(f"❌ Failed all runners")
            
            results.append(chain_result)
        
        success_count = sum(1 for r in results if r['success'])
        self.log(f"\nChain Test Summary: {success_count}/{len(results)} successful")
        
        return results
    
    def test_model_availability(self):
        """Test model availability and response."""
        self.log("\n=== Testing Model Availability ===")
        
        # Check Ollama status
        returncode, stdout, stderr = self.run_command("ollama list", timeout=10)
        
        if returncode != 0:
            self.log("❌ Ollama not running")
            return []
        
        # Parse installed models
        installed_models = []
        for line in stdout.strip().split('\n')[1:]:
            if line.strip():
                model_name = line.split()[0]
                installed_models.append(model_name)
        
        self.log(f"Found {len(installed_models)} installed models")
        
        # Test critical models
        critical_models = [
            'matthew_context_provider_v6_complete',
            'universal_strategy_architect',
            'practical_implementer',
            'master_coder',
            'speed_optimizer_phi'
        ]
        
        results = []
        for model in critical_models:
            is_available = model in installed_models
            result = {
                'model': model,
                'available': is_available,
                'response_test': False
            }
            
            if is_available:
                self.log(f"✅ {model}: Available")
                
                # Test response
                test_prompt = "Say 'Hello' in one word"
                cmd = f"echo '{test_prompt}' | ollama run {model}"
                returncode, stdout, stderr = self.run_command(cmd, timeout=30)
                
                if returncode == 0 and len(stdout.strip()) > 0:
                    result['response_test'] = True
                    self.log(f"   Response test: ✅")
                else:
                    self.log(f"   Response test: ❌")
            else:
                self.log(f"❌ {model}: Not found")
            
            results.append(result)
        
        available_count = sum(1 for r in results if r['available'])
        responding_count = sum(1 for r in results if r['response_test'])
        
        self.log(f"\nModel Summary: {available_count}/{len(results)} available, {responding_count} responding")
        
        return results
    
    def test_output_management(self):
        """Test output file creation and management."""
        self.log("\n=== Testing Output Management ===")
        
        # Run a simple query
        test_query = "Quick test for output management"
        cmd = f"./bin/mirador-smart-v3 \"{test_query}\""
        
        returncode, stdout, stderr = self.run_command(cmd, timeout=60)
        
        result = {
            'query': test_query,
            'output_created': False,
            'files_found': [],
            'feedback_logged': False
        }
        
        if returncode == 0:
            # Check for output directory
            outputs_dir = os.path.join(self.project_root, 'outputs')
            if os.path.exists(outputs_dir):
                # Find recent v3 output directories
                v3_dirs = [d for d in os.listdir(outputs_dir) if d.startswith('v3_')]
                if v3_dirs:
                    latest_dir = sorted(v3_dirs)[-1]
                    output_path = os.path.join(outputs_dir, latest_dir)
                    
                    # Check for expected files
                    for file in os.listdir(output_path):
                        result['files_found'].append(file)
                    
                    result['output_created'] = len(result['files_found']) > 0
                    
                    if result['output_created']:
                        self.log(f"✅ Output created in {latest_dir}")
                        self.log(f"   Files: {', '.join(result['files_found'])}")
                    else:
                        self.log("❌ No files in output directory")
                else:
                    self.log("❌ No v3 output directories found")
            
            # Check feedback log
            feedback_log = os.path.join(self.project_root, 'logs', 'routing_feedback.log')
            if os.path.exists(feedback_log):
                with open(feedback_log, 'r') as f:
                    content = f.read()
                    if test_query in content:
                        result['feedback_logged'] = True
                        self.log("✅ Feedback logged")
                    else:
                        self.log("❌ Feedback not logged")
        else:
            self.log(f"❌ Command failed with code {returncode}")
        
        return result
    
    def test_performance(self):
        """Test performance characteristics."""
        self.log("\n=== Testing Performance ===")
        
        test_queries = [
            ('quick', 'What time is it?'),
            ('technical', 'Write a quick Python function'),
            ('strategic', 'Analyze this simple decision')
        ]
        
        results = []
        for intent_type, query in test_queries:
            self.log(f"\nTesting {intent_type} performance...")
            
            cmd = f"./bin/mirador-smart-v3 \"{query}\""
            
            # Run multiple times for average
            times = []
            for i in range(3):
                start_time = time.time()
                returncode, stdout, stderr = self.run_command(cmd, timeout=60)
                execution_time = time.time() - start_time
                
                if returncode == 0:
                    times.append(execution_time)
            
            if times:
                avg_time = sum(times) / len(times)
                result = {
                    'intent': intent_type,
                    'query': query,
                    'avg_time': avg_time,
                    'runs': len(times)
                }
                self.log(f"✅ Average time: {avg_time:.2f}s over {len(times)} runs")
            else:
                result = {
                    'intent': intent_type,
                    'query': query,
                    'avg_time': None,
                    'runs': 0
                }
                self.log("❌ All runs failed")
            
            results.append(result)
        
        return results
    
    def generate_report(self):
        """Generate comprehensive test report."""
        report_lines = [
            "=" * 80,
            "MIRADOR AI FRAMEWORK - FUNCTIONAL TEST REPORT",
            "=" * 80,
            f"Test Date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
            f"Project Root: {self.project_root}",
            "",
            "TEST RESULTS",
            "-" * 80
        ]
        
        # Count totals
        total_tests = 0
        passed_tests = 0
        
        for category, results in self.test_results:
            report_lines.append(f"\n{category}:")
            
            if isinstance(results, list):
                success_count = sum(1 for r in results if r.get('success', r.get('available', False)))
                total_count = len(results)
                total_tests += total_count
                passed_tests += success_count
                
                report_lines.append(f"  Results: {success_count}/{total_count} successful")
                
                # Add details for failures
                for result in results:
                    if not result.get('success', result.get('available', True)):
                        if 'query' in result:
                            report_lines.append(f"  ❌ Failed: {result['query'][:50]}...")
                        elif 'model' in result:
                            report_lines.append(f"  ❌ Missing: {result['model']}")
            else:
                # Single result
                if results.get('output_created') or results.get('feedback_logged'):
                    report_lines.append("  ✅ Output management working")
                    passed_tests += 1
                else:
                    report_lines.append("  ❌ Output management issues")
                total_tests += 1
        
        # Overall summary
        if total_tests > 0:
            success_rate = (passed_tests / total_tests) * 100
            report_lines.extend([
                "",
                "=" * 80,
                f"OVERALL: {passed_tests}/{total_tests} tests passed ({success_rate:.1f}%)",
                "=" * 80
            ])
        
        # Performance summary
        perf_results = next((r for c, r in self.test_results if c == "Performance"), [])
        if perf_results:
            report_lines.extend([
                "",
                "PERFORMANCE SUMMARY:",
                "-" * 40
            ])
            for result in perf_results:
                if result['avg_time']:
                    report_lines.append(f"  {result['intent']}: {result['avg_time']:.2f}s average")
        
        # Recommendations
        report_lines.extend([
            "",
            "RECOMMENDATIONS:",
            "-" * 40
        ])
        
        if success_rate < 80:
            report_lines.append("- System needs attention, several tests failing")
        if any(not r.get('available', True) for c, results in self.test_results if isinstance(results, list) for r in results):
            report_lines.append("- Install missing models with ollama pull")
        if success_rate >= 80:
            report_lines.append("- System functioning well, continue monitoring")
        
        # Save report
        report_path = os.path.join(self.test_log_dir, f"functional_test_report_{self.timestamp}.txt")
        with open(report_path, 'w') as f:
            f.write('\n'.join(report_lines))
        
        # Print report
        print('\n'.join(report_lines))
        print(f"\n📄 Report saved to: {report_path}")
        
        # Save JSON results
        json_path = os.path.join(self.test_log_dir, f"functional_test_results_{self.timestamp}.json")
        json_data = {
            'timestamp': self.timestamp,
            'results': {category: results for category, results in self.test_results}
        }
        with open(json_path, 'w') as f:
            json.dump(json_data, f, indent=2)
        print(f"📊 JSON results saved to: {json_path}")
        
        return report_path
    
    def run_all_tests(self):
        """Execute all functional tests."""
        self.log("🚀 Starting Mirador Functional Test Suite")
        
        # Check Ollama first
        returncode, stdout, stderr = self.run_command("ollama list", timeout=10)
        if returncode != 0:
            self.log("❌ CRITICAL: Ollama is not running!")
            self.log("Please start Ollama with: ollama serve")
            return None
        
        # Run test categories
        test_functions = [
            ("Smart v3 Routing", self.test_mirador_smart_v3_routing),
            ("Chain Execution", self.test_chain_execution),
            ("Model Availability", self.test_model_availability),
            ("Output Management", self.test_output_management),
            ("Performance", self.test_performance)
        ]
        
        for category_name, test_func in test_functions:
            try:
                results = test_func()
                self.test_results.append((category_name, results))
            except Exception as e:
                self.log(f"❌ Error in {category_name}: {str(e)}", "ERROR")
                self.test_results.append((category_name, []))
        
        # Generate report
        report_path = self.generate_report()
        return report_path


def main():
    """Main entry point."""
    tester = MiradorFunctionalTester()
    report_path = tester.run_all_tests()
    
    if report_path:
        print(f"\n✅ Testing complete!")
        print(f"View full report: cat {report_path}")
    else:
        print("\n❌ Testing failed - Ollama not running")
        sys.exit(1)


if __name__ == "__main__":
    main()