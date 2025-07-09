#!/usr/bin/env python3
"""
Improved integration tests for Mirador Framework
"""

import os
import sys
import json
import subprocess
import tempfile
from pathlib import Path

# Add current directory to path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

def test_basic_imports():
    """Test that core modules can be imported"""
    try:
        import conductor
        import mirador
        print("✓ Core modules imported successfully")
        return True
    except ImportError as e:
        print(f"✗ Import failed: {e}")
        return False

def test_config_loading():
    """Test that configuration can be loaded"""
    try:
        with open('config.json', 'r') as f:
            config = json.load(f)
        print("✓ Configuration loaded successfully")
        return True
    except Exception as e:
        print(f"✗ Config loading failed: {e}")
        return False

def test_command_execution():
    """Test that commands can be executed"""
    try:
        # Test mirador help
        result = subprocess.run(['./mirador', '--help'], 
                              capture_output=True, text=True, timeout=10)
        if result.returncode == 0:
            print("✓ Mirador command executed successfully")
            return True
        else:
            print(f"✗ Mirador command failed: {result.stderr}")
            return False
    except Exception as e:
        print(f"✗ Command execution failed: {e}")
        return False

def test_directory_structure():
    """Test that required directories exist"""
    required_dirs = ['logs', 'outputs', 'src']
    missing_dirs = []
    
    for dir_name in required_dirs:
        if not os.path.exists(dir_name):
            missing_dirs.append(dir_name)
    
    if not missing_dirs:
        print("✓ Directory structure is complete")
        return True
    else:
        print(f"✗ Missing directories: {missing_dirs}")
        return False

def main():
    """Run all integration tests"""
    print("Running improved integration tests...")
    
    tests = [
        test_directory_structure,
        test_config_loading,
        test_basic_imports,
        test_command_execution
    ]
    
    passed = 0
    total = len(tests)
    
    for test in tests:
        if test():
            passed += 1
    
    print(f"\nIntegration test results: {passed}/{total} passed")
    
    if passed == total:
        print("SUCCESS: All integration tests passed")
        return 0
    else:
        print("FAILURE: Some integration tests failed")
        return 1

if __name__ == "__main__":
    sys.exit(main())
