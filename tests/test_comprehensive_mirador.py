#!/usr/bin/env python3
"""
Comprehensive Test Suite for Mirador AI Framework
Tests all major functionality including v3 routing, chains, models, and edge cases
"""

import os
import sys
import subprocess
import json
import time
import logging
import tempfile
import shutil
from datetime import datetime
from typing import Dict, List, Tuple, Optional, Any
from concurrent.futures import ThreadPoolExecutor, as_completed
import statistics

# Add parent directory to path for imports
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

class MiradorComprehensiveTester:
    """Comprehensive test suite for Mirador framework."""
    
    def __init__(self):
        self.project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        self.test_results = {
            'routing': [],
            'chains': [],
            'models': [],
            'performance': [],
            'edge_cases': [],
            'feedback': []
        }
        self.start_time = time.time()
        self.test_log_dir = os.path.join(self.project_root, 'test_logs')
        self.timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        os.makedirs(self.test_log_dir, exist_ok=True)
        
        # Setup logging
        self.setup_logging()
        
        # Test configuration
        self.test_config = {
            'verbose': True,
            'parallel': True,
            'timeout': 120,  # 2 minutes per test
            'save_outputs': True
        }
        
        # Define test cases for routing
        self.routing_test_cases = [
            # Technical queries
            ("Write a Python script to automate file processing", "technical"),
            ("Debug this SQL query that's running slow", "technical"),
            ("How do I implement unit tests for my JavaScript code?", "technical"),
            ("Create a PowerShell script for compliance monitoring", "technical"),
            ("Fix this bash syntax error in my automation script", "technical"),
            
            # Quick queries
            ("Quick summary of today's priorities", "quick"),
            ("What is the weather like?", "quick"),
            ("Tell me briefly about AI trends", "quick"),
            
            # Financial queries
            ("Plan my monthly budget with three teenagers", "financial"),
            ("How should I invest my 401k?", "financial"),
            ("Calculate my debt-to-income ratio", "financial"),
            
            # Health queries
            ("Create a workout plan for stress reduction", "health"),
            ("How can I improve my sleep quality?", "health"),
            ("Nutrition tips for energy throughout the day", "health"),
            
            # Location queries
            ("Best schools in Louisville for my kids", "location"),
            ("Find local tech meetups in Kentucky", "location"),
            ("JCPS magnet program recommendations", "location"),
            
            # Music queries
            ("Improve my blues guitar soloing", "music"),
            ("Practice routine for metal rhythm guitar", "music"),
            ("How to play jazz chords on guitar", "music"),
            
            # Career queries
            ("Position myself as AI leader at Humana", "career"),
            ("Navigate corporate politics in my department", "career"),
            ("Strategy for VP promotion", "career"),
            
            # Creative queries
            ("Innovative ideas for team building", "creative"),
            ("Design a breakthrough AI solution", "creative"),
            ("Create content for my blog", "creative"),
            
            # Family queries
            ("Handle teenage rebellion effectively", "family"),
            ("Balance work and family as single parent", "family"),
            ("Communication strategies with teenagers", "family"),
            
            # Strategic queries (default)
            ("Analyze pros and cons of this decision", "strategic"),
            ("Create a roadmap for Q4 goals", "strategic"),
            ("Prioritize my projects using Eisenhower matrix", "strategic")
        ]
        
        # Define chain test cases
        self.chain_test_cases = [
            ("life_optimization", "Plan my ideal work-life balance routine"),
            ("business_acceleration", "Accelerate our AI adoption at Humana"),
            ("creative_breakthrough", "Generate innovative automation ideas"),
            ("relationship_harmony", "Improve family communication dynamics"),
            ("technical_mastery", "Master advanced Python programming techniques"),
            ("strategic_synthesis", "Synthesize quarterly objectives into action plan"),
            ("deep_analysis", "Analyze market trends for AI implementation"),
            ("global_insight", "Understand global AI regulatory landscape"),
            ("rapid_decision", "Decide between two job opportunities quickly")
        ]
    
    def setup_logging(self):
        """Setup comprehensive logging."""
        log_file = os.path.join(self.test_log_dir, f'comprehensive_test_{self.timestamp}.log')
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(log_file),
                logging.StreamHandler(sys.stdout)
            ]
        )
        self.logger = logging.getLogger(__name__)
    
    def run_command(self, command: str, timeout: int = None) -> Tuple[int, str, str]:
        """Execute shell command with timeout."""
        timeout = timeout or self.test_config['timeout']
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
        except Exception as e:
            return -2, "", str(e)
    
    def test_smart_routing_v3(self):
        """Test Mirador Smart v3 routing accuracy."""
        self.logger.info("\n" + "="*80)
        self.logger.info("TESTING: Smart Routing v3")
        self.logger.info("="*80)
        
        correct_routes = 0
        total_routes = len(self.routing_test_cases)
        
        for query, expected_intent in self.routing_test_cases:
            self.logger.info(f"\nTesting query: '{query[:50]}...'")
            self.logger.info(f"Expected intent: {expected_intent}")
            
            # Create a test script to analyze the query
            test_script = f"""
#!/bin/bash
source /Users/matthewscott/Projects/mirador/bin/mirador-smart-v3

# Override to just output the intent
INTENT=$(analyze_query "{query}")
echo "$INTENT"
"""
            with tempfile.NamedTemporaryFile(mode='w', suffix='.sh', delete=False) as f:
                f.write(test_script)
                temp_file = f.name
            
            os.chmod(temp_file, 0o755)
            returncode, stdout, stderr = self.run_command(f"bash {temp_file}", timeout=10)
            os.unlink(temp_file)
            
            detected_intent = stdout.strip()
            is_correct = detected_intent == expected_intent
            
            if is_correct:
                correct_routes += 1
                self.logger.info(f"✅ Correctly routed to: {detected_intent}")
            else:
                self.logger.error(f"❌ Incorrectly routed to: {detected_intent}")
            
            self.test_results['routing'].append({
                'query': query,
                'expected': expected_intent,
                'detected': detected_intent,
                'correct': is_correct,
                'timestamp': datetime.now().isoformat()
            })
        
        accuracy = (correct_routes / total_routes) * 100
        self.logger.info(f"\nRouting Accuracy: {accuracy:.1f}% ({correct_routes}/{total_routes})")
        
        return accuracy
    
    def test_chain_execution(self):
        """Test execution of all chain types."""
        self.logger.info("\n" + "="*80)
        self.logger.info("TESTING: Chain Execution")
        self.logger.info("="*80)
        
        successful_chains = 0
        total_chains = len(self.chain_test_cases)
        
        # Test each chain
        for chain_type, test_prompt in self.chain_test_cases:
            self.logger.info(f"\nTesting chain: {chain_type}")
            
            # Try multiple runner locations
            runners = [
                f"./bin/mirador_universal_runner_v3_optimized.sh",
                f"./bin/mirador_universal_runner.sh",
                f"./mirador_universal_runner_v2.sh"
            ]
            
            chain_success = False
            for runner in runners:
                if os.path.exists(os.path.join(self.project_root, runner)):
                    cmd = f"{runner} {chain_type} \"{test_prompt}\" quick"
                    start_time = time.time()
                    returncode, stdout, stderr = self.run_command(cmd, timeout=120)
                    execution_time = time.time() - start_time
                    
                    if returncode == 0 and len(stdout) > 100:
                        chain_success = True
                        successful_chains += 1
                        self.logger.info(f"✅ Chain executed successfully in {execution_time:.2f}s")
                        self.logger.info(f"   Output length: {len(stdout)} chars")
                        
                        self.test_results['chains'].append({
                            'chain': chain_type,
                            'runner': runner,
                            'status': 'success',
                            'execution_time': execution_time,
                            'output_length': len(stdout),
                            'timestamp': datetime.now().isoformat()
                        })
                        break
                    else:
                        self.logger.warning(f"   Runner {runner} failed: {stderr[:100]}")
            
            if not chain_success:
                self.logger.error(f"❌ Chain failed on all runners")
                self.test_results['chains'].append({
                    'chain': chain_type,
                    'status': 'failed',
                    'error': 'No working runner found',
                    'timestamp': datetime.now().isoformat()
                })
        
        success_rate = (successful_chains / total_chains) * 100
        self.logger.info(f"\nChain Success Rate: {success_rate:.1f}% ({successful_chains}/{total_chains})")
        
        return success_rate
    
    def test_model_availability(self):
        """Test that required models are available."""
        self.logger.info("\n" + "="*80)
        self.logger.info("TESTING: Model Availability")
        self.logger.info("="*80)
        
        # Get list of installed models
        returncode, stdout, stderr = self.run_command("ollama list", timeout=10)
        
        if returncode != 0:
            self.logger.error("❌ Ollama not running or accessible")
            return 0
        
        installed_models = set()
        for line in stdout.strip().split('\n')[1:]:  # Skip header
            if line.strip():
                model_name = line.split()[0]
                installed_models.add(model_name)
        
        # Critical models for v3
        critical_models = [
            "matthew_context_provider_v6_complete",
            "universal_strategy_architect",
            "practical_implementer",
            "master_coder",
            "speed_optimizer_phi",
            "analytical_expert_gemma",
            "universal_financial_advisor",
            "universal_health_wellness",
            "universal_louisville_expert",
            "universal_music_mentor",
            "universal_creative_catalyst",
            "universal_career_strategist",
            "universal_corporate_navigator",
            "universal_relationship_harmony"
        ]
        
        available_count = 0
        for model in critical_models:
            is_available = model in installed_models
            if is_available:
                available_count += 1
                self.logger.info(f"✅ {model}: Available")
            else:
                self.logger.error(f"❌ {model}: Not found")
            
            self.test_results['models'].append({
                'model': model,
                'available': is_available,
                'timestamp': datetime.now().isoformat()
            })
        
        # Test a sample model response
        if "matthew_context_provider_v6_complete" in installed_models:
            self.logger.info("\nTesting model response...")
            test_prompt = "Provide a brief introduction of Matthew Scott in one sentence."
            cmd = f"echo '{test_prompt}' | ollama run matthew_context_provider_v6_complete"
            returncode, stdout, stderr = self.run_command(cmd, timeout=30)
            
            if returncode == 0 and len(stdout) > 10:
                self.logger.info("✅ Model response test successful")
                self.logger.info(f"   Response: {stdout[:100]}...")
            else:
                self.logger.error("❌ Model response test failed")
        
        availability_rate = (available_count / len(critical_models)) * 100
        self.logger.info(f"\nModel Availability: {availability_rate:.1f}% ({available_count}/{len(critical_models)})")
        
        return availability_rate
    
    def test_performance_metrics(self):
        """Test performance of different routing options."""
        self.logger.info("\n" + "="*80)
        self.logger.info("TESTING: Performance Metrics")
        self.logger.info("="*80)
        
        test_queries = [
            ("Quick test", "quick"),
            ("Write Python code to sort a list", "technical"),
            ("Plan my financial future", "financial")
        ]
        
        for query, intent in test_queries:
            self.logger.info(f"\nPerformance test: {intent} intent")
            
            # Test v3 routing
            cmd = f"./bin/mirador-smart-v3 \"{query}\""
            start_time = time.time()
            returncode, stdout, stderr = self.run_command(cmd, timeout=60)
            execution_time = time.time() - start_time
            
            if returncode == 0:
                self.logger.info(f"✅ Execution time: {execution_time:.2f}s")
                self.logger.info(f"   Output size: {len(stdout)} chars")
                
                self.test_results['performance'].append({
                    'query': query,
                    'intent': intent,
                    'execution_time': execution_time,
                    'output_size': len(stdout),
                    'status': 'success',
                    'timestamp': datetime.now().isoformat()
                })
            else:
                self.logger.error(f"❌ Failed to execute: {stderr[:100]}")
                self.test_results['performance'].append({
                    'query': query,
                    'intent': intent,
                    'status': 'failed',
                    'error': stderr[:100],
                    'timestamp': datetime.now().isoformat()
                })
        
        # Calculate average performance
        successful_tests = [t for t in self.test_results['performance'] if t['status'] == 'success']
        if successful_tests:
            avg_time = statistics.mean([t['execution_time'] for t in successful_tests])
            self.logger.info(f"\nAverage execution time: {avg_time:.2f}s")
        
        return len(successful_tests) / len(test_queries) * 100
    
    def test_edge_cases(self):
        """Test edge cases and error handling."""
        self.logger.info("\n" + "="*80)
        self.logger.info("TESTING: Edge Cases & Error Handling")
        self.logger.info("="*80)
        
        edge_cases = [
            ("", "Empty query"),
            ("a" * 1000, "Very long query"),
            ("!@#$%^&*()", "Special characters only"),
            ("Write code; DROP TABLE users;--", "SQL injection attempt"),
            ("多语言测试", "Non-English characters"),
            ("WRITE CODE IN CAPS", "All caps query"),
            ("write\nmultiline\nquery", "Multiline query")
        ]
        
        handled_correctly = 0
        
        for query, description in edge_cases:
            self.logger.info(f"\nTesting edge case: {description}")
            
            cmd = f"./bin/mirador-smart-v3 \"{query}\""
            returncode, stdout, stderr = self.run_command(cmd, timeout=30)
            
            # We expect the system to handle these gracefully (not crash)
            if returncode in [0, 1]:  # 0 = success, 1 = controlled exit
                handled_correctly += 1
                self.logger.info(f"✅ Handled gracefully")
            else:
                self.logger.error(f"❌ Crashed or timed out")
            
            self.test_results['edge_cases'].append({
                'query': query[:50],  # Truncate for logging
                'description': description,
                'handled': returncode in [0, 1],
                'returncode': returncode,
                'timestamp': datetime.now().isoformat()
            })
        
        handling_rate = (handled_correctly / len(edge_cases)) * 100
        self.logger.info(f"\nEdge case handling rate: {handling_rate:.1f}% ({handled_correctly}/{len(edge_cases)})")
        
        return handling_rate
    
    def test_output_formatting(self):
        """Test output formatting and file saving."""
        self.logger.info("\n" + "="*80)
        self.logger.info("TESTING: Output Formatting & Saving")
        self.logger.info("="*80)
        
        test_query = "Create a simple Python function"
        cmd = f"./bin/mirador-smart-v3 \"{test_query}\""
        
        # Execute command
        returncode, stdout, stderr = self.run_command(cmd, timeout=60)
        
        if returncode == 0:
            # Check if output directory was created
            output_dirs = [d for d in os.listdir(os.path.join(self.project_root, "outputs")) 
                          if d.startswith("v3_")]
            
            if output_dirs:
                latest_dir = sorted(output_dirs)[-1]
                output_path = os.path.join(self.project_root, "outputs", latest_dir)
                
                expected_files = ["query.log", "response.txt"]
                found_files = []
                
                for expected_file in expected_files:
                    file_path = os.path.join(output_path, expected_file)
                    if os.path.exists(file_path):
                        found_files.append(expected_file)
                        self.logger.info(f"✅ Found {expected_file}")
                        
                        # Check file content
                        with open(file_path, 'r') as f:
                            content = f.read()
                            self.logger.info(f"   Content length: {len(content)} chars")
                    else:
                        self.logger.error(f"❌ Missing {expected_file}")
                
                self.logger.info(f"\nOutput directory: {output_path}")
                return len(found_files) / len(expected_files) * 100
            else:
                self.logger.error("❌ No output directory created")
                return 0
        else:
            self.logger.error(f"❌ Command failed: {stderr[:100]}")
            return 0
    
    def test_feedback_logging(self):
        """Test feedback logging mechanism."""
        self.logger.info("\n" + "="*80)
        self.logger.info("TESTING: Feedback Logging")
        self.logger.info("="*80)
        
        # Execute a query to generate feedback log entry
        test_query = "Test feedback logging"
        cmd = f"./bin/mirador-smart-v3 \"{test_query}\""
        returncode, stdout, stderr = self.run_command(cmd, timeout=30)
        
        if returncode == 0:
            feedback_log = os.path.join(self.project_root, "logs", "routing_feedback.log")
            if os.path.exists(feedback_log):
                with open(feedback_log, 'r') as f:
                    lines = f.readlines()
                    if lines:
                        last_line = lines[-1]
                        if test_query in last_line:
                            self.logger.info("✅ Feedback logged correctly")
                            self.logger.info(f"   Entry: {last_line.strip()}")
                            return 100
                        else:
                            self.logger.error("❌ Query not found in feedback log")
                            return 50
            else:
                self.logger.error("❌ Feedback log file not found")
                return 0
        else:
            self.logger.error("❌ Command execution failed")
            return 0
    
    def generate_comprehensive_report(self):
        """Generate comprehensive test report."""
        elapsed_time = time.time() - self.start_time
        
        report_lines = [
            "=" * 100,
            "MIRADOR AI FRAMEWORK - COMPREHENSIVE TEST REPORT",
            "=" * 100,
            f"Test Date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
            f"Total Duration: {elapsed_time:.2f} seconds",
            f"Project Root: {self.project_root}",
            "",
            "EXECUTIVE SUMMARY",
            "-" * 100
        ]
        
        # Calculate overall metrics
        total_tests = 0
        passed_tests = 0
        
        # Routing accuracy
        routing_correct = sum(1 for r in self.test_results['routing'] if r['correct'])
        routing_total = len(self.test_results['routing'])
        if routing_total > 0:
            routing_accuracy = (routing_correct / routing_total) * 100
            report_lines.append(f"Routing Accuracy: {routing_accuracy:.1f}% ({routing_correct}/{routing_total} correct)")
            total_tests += routing_total
            passed_tests += routing_correct
        
        # Chain success
        chain_success = sum(1 for c in self.test_results['chains'] if c['status'] == 'success')
        chain_total = len(self.test_results['chains'])
        if chain_total > 0:
            chain_rate = (chain_success / chain_total) * 100
            report_lines.append(f"Chain Success Rate: {chain_rate:.1f}% ({chain_success}/{chain_total} successful)")
            total_tests += chain_total
            passed_tests += chain_success
        
        # Model availability
        models_available = sum(1 for m in self.test_results['models'] if m['available'])
        models_total = len(self.test_results['models'])
        if models_total > 0:
            model_rate = (models_available / models_total) * 100
            report_lines.append(f"Model Availability: {model_rate:.1f}% ({models_available}/{models_total} available)")
            total_tests += models_total
            passed_tests += models_available
        
        # Performance metrics
        perf_success = sum(1 for p in self.test_results['performance'] if p['status'] == 'success')
        perf_total = len(self.test_results['performance'])
        if perf_total > 0:
            perf_rate = (perf_success / perf_total) * 100
            report_lines.append(f"Performance Tests: {perf_rate:.1f}% ({perf_success}/{perf_total} successful)")
            
            # Average execution time
            successful_perfs = [p for p in self.test_results['performance'] if p['status'] == 'success']
            if successful_perfs:
                avg_time = statistics.mean([p['execution_time'] for p in successful_perfs])
                report_lines.append(f"Average Execution Time: {avg_time:.2f} seconds")
        
        # Edge case handling
        edge_handled = sum(1 for e in self.test_results['edge_cases'] if e['handled'])
        edge_total = len(self.test_results['edge_cases'])
        if edge_total > 0:
            edge_rate = (edge_handled / edge_total) * 100
            report_lines.append(f"Edge Case Handling: {edge_rate:.1f}% ({edge_handled}/{edge_total} handled)")
            total_tests += edge_total
            passed_tests += edge_handled
        
        # Overall score
        if total_tests > 0:
            overall_score = (passed_tests / total_tests) * 100
            report_lines.extend([
                "",
                f"OVERALL SCORE: {overall_score:.1f}% ({passed_tests}/{total_tests} tests passed)",
                ""
            ])
        
        # Detailed sections
        report_lines.extend([
            "DETAILED RESULTS",
            "-" * 100,
            "",
            "1. ROUTING ACCURACY",
            "-" * 50
        ])
        
        # Routing details
        intent_accuracy = {}
        for result in self.test_results['routing']:
            intent = result['expected']
            if intent not in intent_accuracy:
                intent_accuracy[intent] = {'correct': 0, 'total': 0}
            intent_accuracy[intent]['total'] += 1
            if result['correct']:
                intent_accuracy[intent]['correct'] += 1
        
        for intent, stats in sorted(intent_accuracy.items()):
            accuracy = (stats['correct'] / stats['total']) * 100
            report_lines.append(f"  {intent}: {accuracy:.1f}% ({stats['correct']}/{stats['total']})")
        
        # Failed routing examples
        failed_routes = [r for r in self.test_results['routing'] if not r['correct']]
        if failed_routes:
            report_lines.extend([
                "",
                "Failed Routing Examples:",
            ])
            for fail in failed_routes[:5]:  # Show first 5
                report_lines.append(f"  Query: '{fail['query'][:50]}...'")
                report_lines.append(f"  Expected: {fail['expected']}, Got: {fail['detected']}")
                report_lines.append("")
        
        # Chain execution details
        report_lines.extend([
            "",
            "2. CHAIN EXECUTION",
            "-" * 50
        ])
        
        for chain in self.test_results['chains']:
            status_icon = "✅" if chain['status'] == 'success' else "❌"
            report_lines.append(f"  {status_icon} {chain['chain']}: {chain['status']}")
            if chain['status'] == 'success' and 'execution_time' in chain:
                report_lines.append(f"     Time: {chain['execution_time']:.2f}s, Output: {chain['output_length']} chars")
        
        # Model availability details
        report_lines.extend([
            "",
            "3. MODEL AVAILABILITY",
            "-" * 50
        ])
        
        missing_models = [m for m in self.test_results['models'] if not m['available']]
        if missing_models:
            report_lines.append("Missing Critical Models:")
            for model in missing_models:
                report_lines.append(f"  ❌ {model['model']}")
        else:
            report_lines.append("✅ All critical models available")
        
        # Performance analysis
        report_lines.extend([
            "",
            "4. PERFORMANCE ANALYSIS",
            "-" * 50
        ])
        
        if successful_perfs:
            by_intent = {}
            for perf in successful_perfs:
                intent = perf['intent']
                if intent not in by_intent:
                    by_intent[intent] = []
                by_intent[intent].append(perf['execution_time'])
            
            for intent, times in sorted(by_intent.items()):
                avg_time = statistics.mean(times)
                report_lines.append(f"  {intent}: {avg_time:.2f}s average")
        
        # Edge case summary
        report_lines.extend([
            "",
            "5. EDGE CASE HANDLING",
            "-" * 50
        ])
        
        for edge in self.test_results['edge_cases']:
            status = "✅ Handled" if edge['handled'] else "❌ Failed"
            report_lines.append(f"  {edge['description']}: {status}")
        
        # Recommendations
        report_lines.extend([
            "",
            "RECOMMENDATIONS",
            "-" * 100
        ])
        
        recommendations = []
        
        if routing_accuracy < 90:
            recommendations.append("- Improve routing logic for better intent detection")
        
        if missing_models:
            recommendations.append(f"- Install {len(missing_models)} missing models")
        
        if avg_time > 30:
            recommendations.append("- Optimize model chains for faster response times")
        
        if edge_rate < 100:
            recommendations.append("- Improve error handling for edge cases")
        
        if not recommendations:
            recommendations.append("- System performing well, continue monitoring")
        
        report_lines.extend(recommendations)
        
        # Footer
        report_lines.extend([
            "",
            "=" * 100,
            f"Report generated in {elapsed_time:.2f} seconds",
            "=" * 100
        ])
        
        # Save report
        report_path = os.path.join(self.test_log_dir, f"comprehensive_test_report_{self.timestamp}.txt")
        with open(report_path, 'w') as f:
            f.write('\n'.join(report_lines))
        
        # Also save JSON results
        json_path = os.path.join(self.test_log_dir, f"test_results_{self.timestamp}.json")
        with open(json_path, 'w') as f:
            json.dump(self.test_results, f, indent=2)
        
        # Print report
        print('\n'.join(report_lines))
        
        self.logger.info(f"\n📄 Full report saved to: {report_path}")
        self.logger.info(f"📊 JSON results saved to: {json_path}")
        
        return report_path, overall_score if total_tests > 0 else 0
    
    def run_all_tests(self):
        """Execute all comprehensive tests."""
        self.logger.info("🚀 Starting Mirador Comprehensive Test Suite")
        self.logger.info(f"Timestamp: {self.timestamp}")
        
        # Check Ollama first
        returncode, stdout, stderr = self.run_command("ollama list", timeout=10)
        if returncode != 0:
            self.logger.error("❌ CRITICAL: Ollama is not running!")
            self.logger.error("Please start Ollama with: ollama serve")
            return None, 0
        
        # Run test categories
        test_functions = [
            ("Smart Routing v3", self.test_smart_routing_v3),
            ("Chain Execution", self.test_chain_execution),
            ("Model Availability", self.test_model_availability),
            ("Performance Metrics", self.test_performance_metrics),
            ("Edge Cases", self.test_edge_cases),
            ("Output Formatting", self.test_output_formatting),
            ("Feedback Logging", self.test_feedback_logging)
        ]
        
        category_scores = {}
        
        for category_name, test_func in test_functions:
            try:
                score = test_func()
                category_scores[category_name] = score
            except Exception as e:
                self.logger.error(f"❌ Fatal error in {category_name}: {str(e)}")
                category_scores[category_name] = 0
        
        # Generate final report
        report_path, overall_score = self.generate_comprehensive_report()
        
        return report_path, overall_score


def main():
    """Main entry point for comprehensive test suite."""
    import argparse
    
    parser = argparse.ArgumentParser(description='Mirador AI Framework Comprehensive Test Suite')
    parser.add_argument('--parallel', '-p', action='store_true', help='Run tests in parallel where possible')
    parser.add_argument('--verbose', '-v', action='store_true', help='Verbose output')
    parser.add_argument('--timeout', '-t', type=int, default=120, help='Timeout per test (seconds)')
    parser.add_argument('--quick', '-q', action='store_true', help='Run quick subset of tests')
    
    args = parser.parse_args()
    
    # Create and configure test suite
    tester = MiradorComprehensiveTester()
    tester.test_config['parallel'] = args.parallel
    tester.test_config['verbose'] = args.verbose
    tester.test_config['timeout'] = args.timeout
    
    if args.quick:
        # Reduce test cases for quick mode
        tester.routing_test_cases = tester.routing_test_cases[:5]
        tester.chain_test_cases = tester.chain_test_cases[:3]
        tester.logger.info("Running in QUICK mode with reduced test set")
    
    # Run tests
    report_path, overall_score = tester.run_all_tests()
    
    # Exit with appropriate code
    if report_path:
        sys.exit(0 if overall_score >= 80 else 1)
    else:
        sys.exit(2)  # Critical failure


if __name__ == "__main__":
    main()