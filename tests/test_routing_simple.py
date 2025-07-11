#!/usr/bin/env python3
"""
Simple test to diagnose routing issues
"""

import os
import sys
import subprocess

# Test if we can call the analyze_query function directly
test_script = """#!/bin/bash
# Source the mirador-smart-v3 script
source /Users/matthewscott/Projects/mirador/bin/mirador-smart-v3

# Test the analyze_query function
query="Write a Python script to automate file processing"
intent=$(analyze_query "$query")
echo "Query: $query"
echo "Detected intent: $intent"
"""

# Write test script
with open('/tmp/test_routing.sh', 'w') as f:
    f.write(test_script)

os.chmod('/tmp/test_routing.sh', 0o755)

# Run it
result = subprocess.run(['/bin/bash', '/tmp/test_routing.sh'], capture_output=True, text=True)
print("STDOUT:")
print(result.stdout)
print("\nSTDERR:")
print(result.stderr)
print(f"\nReturn code: {result.returncode}")

# Now test the actual mirador-smart-v3 script
print("\n" + "="*50)
print("Testing actual mirador-smart-v3 script:")
print("="*50)

# Check if script exists
script_path = "/Users/matthewscott/Projects/mirador/bin/mirador-smart-v3"
if os.path.exists(script_path):
    print(f"✓ Script exists at {script_path}")
    
    # Test with a query
    cmd = [script_path, "Write Python code to sort a list"]
    result = subprocess.run(cmd, capture_output=True, text=True, cwd="/Users/matthewscott/Projects/mirador")
    print(f"\nReturn code: {result.returncode}")
    print(f"Output length: {len(result.stdout)} chars")
    if result.stderr:
        print(f"Errors: {result.stderr[:200]}")
else:
    print(f"✗ Script not found at {script_path}")

# Clean up
os.unlink('/tmp/test_routing.sh')