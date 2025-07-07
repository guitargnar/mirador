#!/usr/bin/env python3
"""
Performance Testing for Mirador AI Framework
Measures speed, resource usage, and scalability
"""

import os
import sys
import time
import psutil
import subprocess
import threading
import json
from datetime import datetime
from concurrent.futures import ThreadPoolExecutor, as_completed

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

class PerformanceTester:
    """Performance testing for Mirador components."""
    
    def __init__(self):
        self.project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        self.results = {
            'timestamp': datetime.now().isoformat(),
            'system_info': self.get_system_info(),
            'tests': []
        }
    
    def get_system_info(self):
        """Get system information."""
        return {
            'cpu_count': psutil.cpu_count(),
            'cpu_freq': psutil.cpu_freq().current if psutil.cpu_freq() else 'N/A',
            'memory_total_gb': round(psutil.virtual_memory().total / (1024**3), 2),
            'platform': sys.platform
        }
    
    def monitor_resources(self, duration: int = 10):
        """Monitor system resources for a given duration."""
        print(f"📊 Monitoring system resources for {duration} seconds...")
        
        cpu_usage = []
        memory_usage = []
        
        for _ in range(duration):
            cpu_usage.append(psutil.cpu_percent(interval=1))
            memory_usage.append(psutil.virtual_memory().percent)
        
        return {
            'cpu_avg': round(sum(cpu_usage) / len(cpu_usage), 2),
            'cpu_max': max(cpu_usage),
            'memory_avg': round(sum(memory_usage) / len(memory_usage), 2),
            'memory_max': max(memory_usage)
        }
    
    def test_chain_performance(self, chain_runner: str, chain_type: str, iterations: int = 3):
        """Test chain execution performance."""
        print(f"\n⚡ Testing {chain_type} performance ({iterations} iterations)...")
        
        times = []
        cmd = f"cd {self.project_root} && ./{chain_runner} {chain_type} 'Test performance'"
        
        for i in range(iterations):
            start_time = time.time()
            try:
                result = subprocess.run(cmd, shell=True, capture_output=True, timeout=60)
                duration = time.time() - start_time
                
                if result.returncode == 0:
                    times.append(duration)
                    print(f"  Iteration {i+1}: {duration:.2f}s")
                else:
                    print(f"  Iteration {i+1}: Failed")
            except subprocess.TimeoutExpired:
                print(f"  Iteration {i+1}: Timeout")
            except Exception as e:
                print(f"  Iteration {i+1}: Error - {str(e)}")
        
        if times:
            return {
                'chain': chain_type,
                'runner': chain_runner,
                'iterations': iterations,
                'avg_time': round(sum(times) / len(times), 2),
                'min_time': round(min(times), 2),
                'max_time': round(max(times), 2),
                'success_rate': f"{len(times)}/{iterations}"
            }
        else:
            return {
                'chain': chain_type,
                'runner': chain_runner,
                'status': 'failed',
                'error': 'All iterations failed'
            }
    
    def test_concurrent_chains(self, max_workers: int = 3):
        """Test concurrent chain execution."""
        print(f"\n🔄 Testing concurrent execution with {max_workers} workers...")
        
        chains = [
            ('humana_chain_runner.sh', 'strategic_synthesis'),
            ('humana_chain_runner.sh', 'corporate_nav'),
            ('humana_chain_runner.sh', 'innovation_discovery')
        ]
        
        start_time = time.time()
        results = []
        
        with ThreadPoolExecutor(max_workers=max_workers) as executor:
            futures = []
            for runner, chain in chains:
                future = executor.submit(self._run_chain, runner, chain)
                futures.append((future, runner, chain))
            
            for future, runner, chain in futures:
                try:
                    result = future.result(timeout=60)
                    results.append(result)
                except Exception as e:
                    results.append({
                        'runner': runner,
                        'chain': chain,
                        'status': 'error',
                        'error': str(e)
                    })
        
        total_time = time.time() - start_time
        
        return {
            'test': 'concurrent_chains',
            'max_workers': max_workers,
            'total_time': round(total_time, 2),
            'chains_tested': len(chains),
            'results': results
        }
    
    def _run_chain(self, runner: str, chain: str):
        """Helper to run a single chain."""
        cmd = f"cd {self.project_root} && ./{runner} {chain} 'Concurrent test'"
        start = time.time()
        
        try:
            result = subprocess.run(cmd, shell=True, capture_output=True, timeout=60)
            return {
                'runner': runner,
                'chain': chain,
                'status': 'success' if result.returncode == 0 else 'failed',
                'duration': round(time.time() - start, 2)
            }
        except Exception as e:
            return {
                'runner': runner,
                'chain': chain,
                'status': 'error',
                'error': str(e)
            }
    
    def test_memory_usage(self):
        """Test memory usage of key components."""
        print("\n💾 Testing memory usage...")
        
        # Test Python import memory
        import_test = """
import tracemalloc
import sys
sys.path.insert(0, '""" + self.project_root + """')

tracemalloc.start()

# Import main modules
import mirador
import framework
import enhanced_mirador
import metrics_tracker
import pain_point_analyzer

current, peak = tracemalloc.get_traced_memory()
tracemalloc.stop()

print(f"Current memory: {current / 1024 / 1024:.2f} MB")
print(f"Peak memory: {peak / 1024 / 1024:.2f} MB")
"""
        
        try:
            result = subprocess.run(
                ['python3', '-c', import_test],
                capture_output=True,
                text=True
            )
            
            if result.returncode == 0:
                print(result.stdout)
                # Parse memory values
                lines = result.stdout.strip().split('\n')
                current_mb = float(lines[0].split(':')[1].strip().split()[0])
                peak_mb = float(lines[1].split(':')[1].strip().split()[0])
                
                return {
                    'test': 'import_memory',
                    'current_mb': current_mb,
                    'peak_mb': peak_mb,
                    'status': 'success'
                }
            else:
                return {
                    'test': 'import_memory',
                    'status': 'failed',
                    'error': result.stderr
                }
        except Exception as e:
            return {
                'test': 'import_memory',
                'status': 'error',
                'error': str(e)
            }
    
    def test_startup_time(self):
        """Test startup time for key components."""
        print("\n⏱️  Testing startup times...")
        
        components = [
            ('Python framework', 'python3 -c "import mirador"'),
            ('Chain runner', './humana_chain_runner.sh strategic_synthesis "test" | head -n 1'),
            ('Ollama list', 'ollama list')
        ]
        
        results = []
        
        for name, cmd in components:
            start = time.time()
            try:
                subprocess.run(cmd, shell=True, capture_output=True, timeout=10)
                duration = time.time() - start
                results.append({
                    'component': name,
                    'startup_time': round(duration, 3),
                    'status': 'success'
                })
                print(f"  {name}: {duration:.3f}s")
            except Exception as e:
                results.append({
                    'component': name,
                    'status': 'error',
                    'error': str(e)
                })
                print(f"  {name}: Error - {str(e)}")
        
        return {
            'test': 'startup_times',
            'results': results
        }
    
    def run_all_performance_tests(self):
        """Run all performance tests."""
        print("🚀 Mirador Performance Test Suite")
        print("=" * 60)
        
        # Check if Ollama is running
        ollama_check = subprocess.run(['ollama', 'list'], capture_output=True)
        if ollama_check.returncode != 0:
            print("⚠️  WARNING: Ollama is not running. Some tests will fail.")
        
        # Run tests
        tests = [
            ('System Resources', lambda: self.monitor_resources(5)),
            ('Memory Usage', self.test_memory_usage),
            ('Startup Times', self.test_startup_time),
            ('Chain Performance', lambda: self.test_chain_performance('humana_chain_runner.sh', 'strategic_synthesis', 2)),
            ('Concurrent Execution', lambda: self.test_concurrent_chains(2))
        ]
        
        for test_name, test_func in tests:
            print(f"\n{'='*60}")
            print(f"Running: {test_name}")
            print('='*60)
            
            try:
                result = test_func()
                self.results['tests'].append({
                    'name': test_name,
                    'result': result
                })
            except Exception as e:
                print(f"❌ Test failed: {str(e)}")
                self.results['tests'].append({
                    'name': test_name,
                    'status': 'error',
                    'error': str(e)
                })
        
        # Generate report
        self.generate_report()
    
    def generate_report(self):
        """Generate performance test report."""
        print("\n" + "=" * 60)
        print("PERFORMANCE TEST REPORT")
        print("=" * 60)
        
        # System info
        print(f"\n📊 System Information:")
        for key, value in self.results['system_info'].items():
            print(f"  {key}: {value}")
        
        # Test summaries
        print(f"\n📈 Test Results:")
        for test in self.results['tests']:
            print(f"\n{test['name']}:")
            if 'result' in test:
                result = test['result']
                if isinstance(result, dict):
                    for key, value in result.items():
                        if key != 'results':  # Skip nested results
                            print(f"  {key}: {value}")
            else:
                print(f"  Status: {test.get('status', 'unknown')}")
                if 'error' in test:
                    print(f"  Error: {test['error']}")
        
        # Save detailed results
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        results_file = os.path.join(self.project_root, 'test_logs', f'performance_test_{timestamp}.json')
        os.makedirs(os.path.dirname(results_file), exist_ok=True)
        
        with open(results_file, 'w') as f:
            json.dump(self.results, f, indent=2)
        
        print(f"\n📄 Detailed results saved to: {results_file}")


if __name__ == "__main__":
    tester = PerformanceTester()
    tester.run_all_performance_tests()