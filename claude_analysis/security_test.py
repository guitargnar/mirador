#!/usr/bin/env python3
"""
Security Testing Script for Claude Code Interpreter
Tests various security boundaries and capabilities
"""

import os
import sys
import json
import subprocess
from datetime import datetime
from typing import Dict, Any

def test_security_boundaries() -> Dict[str, Any]:
    """Test various security boundaries in Claude Code Interpreter"""
    
    tests = {
        "file_access": {
            "code": "print(os.listdir('/'))",
            "description": "Test filesystem access capabilities"
        },
        "network_access": {
            "code": "import requests; print('Network test')",
            "description": "Test network connectivity"
        },
        "system_commands": {
            "code": "import subprocess; subprocess.run(['ls', '-la'])",
            "description": "Test system command execution"
        },
        "environment_vars": {
            "code": "print(os.environ)",
            "description": "Test environment variable access"
        },
        "module_imports": {
            "code": "import socket; print(socket.gethostname())",
            "description": "Test system information access"
        },
        "file_write": {
            "code": "with open('/tmp/test.txt', 'w') as f: f.write('test')",
            "description": "Test file write capabilities"
        },
        "process_spawn": {
            "code": "import multiprocessing; p = multiprocessing.Process(target=lambda: print('test')); p.start()",
            "description": "Test process spawning"
        }
    }
    
    results = {}
    
    for test_name, test_info in tests.items():
        try:
            # Note: In actual Claude Code Interpreter, you'd run these directly
            # This is a simulation framework
            exec(test_info["code"])
            results[test_name] = {
                "status": "ALLOWED",
                "description": test_info["description"],
                "notes": "Operation completed successfully"
            }
        except ImportError as e:
            results[test_name] = {
                "status": "BLOCKED",
                "description": test_info["description"],
                "error": f"Module not available: {str(e)}",
                "security_implication": "Good - limits attack surface"
            }
        except PermissionError as e:
            results[test_name] = {
                "status": "RESTRICTED",
                "description": test_info["description"],
                "error": f"Permission denied: {str(e)}",
                "security_implication": "Good - proper sandboxing"
            }
        except Exception as e:
            results[test_name] = {
                "status": "ERROR",
                "description": test_info["description"],
                "error": f"{type(e).__name__}: {str(e)}",
                "security_implication": "Requires investigation"
            }
    
    return results

def test_resource_limits() -> Dict[str, Any]:
    """Test resource consumption limits"""
    
    tests = {
        "memory_allocation": {
            "code": "data = [0] * (10**8)",  # 100M integers
            "description": "Test memory allocation limits"
        },
        "cpu_intensive": {
            "code": "sum(i**2 for i in range(10**6))",
            "description": "Test CPU-intensive operations"
        },
        "file_size": {
            "code": "data = 'x' * (10**7); len(data)",  # 10MB string
            "description": "Test large data handling"
        }
    }
    
    results = {}
    
    for test_name, test_info in tests.items():
        try:
            import time
            start = time.time()
            exec(test_info["code"])
            duration = time.time() - start
            
            results[test_name] = {
                "status": "PASSED",
                "description": test_info["description"],
                "execution_time": f"{duration:.3f}s",
                "notes": "Within acceptable limits"
            }
        except MemoryError as e:
            results[test_name] = {
                "status": "LIMITED",
                "description": test_info["description"],
                "error": "Memory limit exceeded",
                "security_implication": "Good - prevents resource exhaustion"
            }
        except Exception as e:
            results[test_name] = {
                "status": "ERROR",
                "description": test_info["description"],
                "error": f"{type(e).__name__}: {str(e)}"
            }
    
    return results

def generate_security_report(boundary_results: Dict, resource_results: Dict) -> Dict[str, Any]:
    """Generate comprehensive security report"""
    
    report = {
        "metadata": {
            "test_date": datetime.now().isoformat(),
            "test_environment": "Claude Code Interpreter Simulation",
            "test_version": "1.0.0"
        },
        "summary": {
            "total_tests": len(boundary_results) + len(resource_results),
            "security_boundaries": {
                "allowed": sum(1 for r in boundary_results.values() if r["status"] == "ALLOWED"),
                "blocked": sum(1 for r in boundary_results.values() if r["status"] == "BLOCKED"),
                "restricted": sum(1 for r in boundary_results.values() if r["status"] == "RESTRICTED")
            },
            "resource_limits": {
                "passed": sum(1 for r in resource_results.values() if r["status"] == "PASSED"),
                "limited": sum(1 for r in resource_results.values() if r["status"] == "LIMITED")
            }
        },
        "boundary_tests": boundary_results,
        "resource_tests": resource_results,
        "recommendations": [
            "Claude Code Interpreter implements proper sandboxing",
            "Network access should be monitored for data exfiltration risks",
            "File system access should be limited to specific directories",
            "Resource limits prevent denial-of-service attacks"
        ]
    }
    
    return report

def main():
    """Run security tests and generate report"""
    
    print("🔒 Claude Code Interpreter Security Testing")
    print("=" * 50)
    
    # Run tests
    print("\n📋 Testing security boundaries...")
    boundary_results = test_security_boundaries()
    
    print("\n📊 Testing resource limits...")
    resource_results = test_resource_limits()
    
    # Generate report
    report = generate_security_report(boundary_results, resource_results)
    
    # Display results
    print("\n🔍 Security Test Results:")
    print("-" * 50)
    
    for test_name, result in boundary_results.items():
        status_emoji = "✅" if result["status"] == "BLOCKED" else "⚠️" if result["status"] == "ALLOWED" else "🔒"
        print(f"{status_emoji} {test_name}: {result['status']}")
        if "error" in result:
            print(f"   └─ {result['error']}")
    
    print("\n💾 Resource Limit Results:")
    print("-" * 50)
    
    for test_name, result in resource_results.items():
        status_emoji = "✅" if result["status"] in ["PASSED", "LIMITED"] else "❌"
        print(f"{status_emoji} {test_name}: {result['status']}")
        if "execution_time" in result:
            print(f"   └─ Execution time: {result['execution_time']}")
    
    # Save detailed report
    output_file = os.path.join(
        os.path.dirname(__file__),
        "security",
        f"security_report_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    )
    
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    
    with open(output_file, 'w') as f:
        json.dump(report, f, indent=2)
    
    print(f"\n📁 Detailed report saved to: {output_file}")
    
    # Summary
    print("\n📊 Summary:")
    print(f"   Total tests: {report['summary']['total_tests']}")
    print(f"   Security boundaries - Blocked: {report['summary']['security_boundaries']['blocked']}")
    print(f"   Security boundaries - Allowed: {report['summary']['security_boundaries']['allowed']}")
    print(f"   Resource limits - Passed: {report['summary']['resource_limits']['passed']}")
    
    return report

if __name__ == "__main__":
    # Note: When running in actual Claude Code Interpreter, 
    # these tests will produce real results based on the environment
    report = main()