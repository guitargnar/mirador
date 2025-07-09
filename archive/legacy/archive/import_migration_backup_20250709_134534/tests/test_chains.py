#!/usr/bin/env python3
"""
Test Mirador Chain Functionality
Tests all chain runners with various inputs
"""

import os
import sys
import subprocess
import json
import time
from datetime import datetime

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

class ChainTester:
    """Test all Mirador chains."""
    
    def __init__(self):
        self.project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        self.test_results = []
    
    def test_chain(self, chain_runner: str, chain_type: str, test_input: str, timeout: int = 60):
        """Test a specific chain."""
        print(f"\n🔗 Testing {chain_type} with {chain_runner}...")
        
        cmd = f"cd {self.project_root} && ./{chain_runner} {chain_type} '{test_input}'"
        
        try:
            start_time = time.time()
            process = subprocess.Popen(
                cmd,
                shell=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )
            stdout, stderr = process.communicate(timeout=timeout)
            duration = time.time() - start_time
            
            result = {
                'chain': chain_type,
                'runner': chain_runner,
                'status': 'success' if process.returncode == 0 else 'failed',
                'duration': duration,
                'output_length': len(stdout),
                'error': stderr if stderr else None
            }
            
            if process.returncode == 0:
                print(f"✅ {chain_type}: Success ({duration:.2f}s, {len(stdout)} chars)")
            else:
                print(f"❌ {chain_type}: Failed - {stderr[:100]}")
                
        except subprocess.TimeoutExpired:
            process.kill()
            result = {
                'chain': chain_type,
                'runner': chain_runner,
                'status': 'timeout',
                'duration': timeout,
                'error': f'Timed out after {timeout}s'
            }
            print(f"⏱️  {chain_type}: Timeout after {timeout}s")
        
        except Exception as e:
            result = {
                'chain': chain_type,
                'runner': chain_runner,
                'status': 'error',
                'error': str(e)
            }
            print(f"❌ {chain_type}: Error - {str(e)}")
        
        self.test_results.append(result)
        return result
    
    def run_all_chain_tests(self):
        """Run tests for all major chains."""
        print("🚀 Testing Mirador Chain Functionality")
        print("=" * 60)
        
        # Define test cases
        test_cases = [
            # Company chains
            ('company_chain_runner.sh', 'strategic_synthesis', 'Plan my day for maximum impact'),
            ('company_chain_runner.sh', 'corporate_nav', 'How do I navigate a difficult meeting?'),
            ('company_chain_runner.sh', 'innovation_discovery', 'Find automation opportunities'),
            ('company_chain_runner.sh', 'ai_leadership', 'Position myself as AI leader'),
            ('company_chain_runner.sh', 'solution_design', 'Design solution for manual process'),
            
            # Robust chains
            ('robust_chain_runner.sh', 'strategic_synthesis', 'Analyze current project status'),
            
            # Role chains
            ('role_chain.sh', 'business', 'Improve customer acquisition'),
            ('role_chain.sh', 'code', 'Review Python code quality'),
            ('role_chain.sh', 'guitar', 'Improve fingerstyle technique'),
        ]
        
        # Check if Ollama is running first
        ollama_check = subprocess.run(['ollama', 'list'], capture_output=True)
        if ollama_check.returncode != 0:
            print("⚠️  WARNING: Ollama is not running. Chain tests will fail.")
            print("   Start Ollama with: ollama serve")
            return
        
        # Run each test
        for runner, chain, test_input in test_cases:
            runner_path = os.path.join(self.project_root, runner)
            if os.path.exists(runner_path):
                self.test_chain(runner, chain, test_input)
            else:
                print(f"⚠️  Skipping {runner} - file not found")
                self.test_results.append({
                    'chain': chain,
                    'runner': runner,
                    'status': 'skipped',
                    'error': 'Runner script not found'
                })
        
        # Generate summary
        self.generate_summary()
    
    def generate_summary(self):
        """Generate test summary."""
        print("\n" + "=" * 60)
        print("CHAIN TEST SUMMARY")
        print("=" * 60)
        
        success_count = sum(1 for r in self.test_results if r['status'] == 'success')
        failed_count = sum(1 for r in self.test_results if r['status'] == 'failed')
        timeout_count = sum(1 for r in self.test_results if r['status'] == 'timeout')
        skipped_count = sum(1 for r in self.test_results if r['status'] == 'skipped')
        
        print(f"✅ Success: {success_count}")
        print(f"❌ Failed: {failed_count}")
        print(f"⏱️  Timeout: {timeout_count}")
        print(f"⚠️  Skipped: {skipped_count}")
        
        if failed_count > 0:
            print("\nFailed chains:")
            for result in self.test_results:
                if result['status'] == 'failed':
                    print(f"  - {result['chain']} ({result['runner']}): {result['error'][:50]}")
        
        # Save detailed results
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        results_file = os.path.join(self.project_root, 'test_logs', f'chain_test_results_{timestamp}.json')
        os.makedirs(os.path.dirname(results_file), exist_ok=True)
        
        with open(results_file, 'w') as f:
            json.dump(self.test_results, f, indent=2)
        
        print(f"\n📄 Detailed results saved to: {results_file}")


if __name__ == "__main__":
    tester = ChainTester()
    tester.run_all_chain_tests()