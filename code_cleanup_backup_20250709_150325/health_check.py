#!/usr/bin/env python3
"""
Mirador System Health Check
Verifies all components are working correctly
"""

import os
import sys
import json
import subprocess
import requests
from pathlib import Path

def check_ollama_connection():
    """Check if Ollama is running and accessible"""
    try:
        response = requests.get("http://localhost:11434/api/tags", timeout=5)
        if response.status_code == 200:
            models = response.json().get('models', [])
            print(f"✓ Ollama is running with {len(models)} models")
            return True
        else:
            print(f"✗ Ollama responded with status {response.status_code}")
            return False
    except Exception as e:
        print(f"✗ Ollama connection failed: {e}")
        return False

def check_python_environment():
    """Check Python environment and dependencies"""
    try:
        import requests
        import json
        print("✓ Required Python packages are available")
        return True
    except ImportError as e:
        print(f"✗ Missing Python package: {e}")
        return False

def check_file_permissions():
    """Check that command files are executable"""
    commands = ['mirador', 'mirador-conductor', 'mirador-interactive']
    issues = []
    
    for cmd in commands:
        if os.path.exists(cmd):
            if not os.access(cmd, os.X_OK):
                issues.append(f"{cmd} not executable")
        else:
            issues.append(f"{cmd} missing")
    
    if not issues:
        print("✓ All command files are properly configured")
        return True
    else:
        print(f"✗ File permission issues: {', '.join(issues)}")
        return False

def main():
    """Run system health check"""
    print("Mirador System Health Check")
    print("=" * 40)
    
    checks = [
        check_python_environment,
        check_file_permissions,
        check_ollama_connection
    ]
    
    passed = 0
    total = len(checks)
    
    for check in checks:
        if check():
            passed += 1
        print()
    
    print(f"Health check results: {passed}/{total} passed")
    
    if passed == total:
        print("✓ System is healthy and ready to use")
        return 0
    else:
        print("⚠ System has some issues that should be addressed")
        return 1

if __name__ == "__main__":
    sys.exit(main())
