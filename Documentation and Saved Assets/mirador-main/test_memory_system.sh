#!/bin/bash

echo "=== Testing Memory System ==="

# Check if memory integration is active
echo "Checking memory integration..."
if [ -f mirador_with_memory.sh ]; then
    echo "✓ Memory wrapper script found"
    
    # Test memory recording
    echo "Testing memory recording..."
    ./mirador_with_memory.sh ask llama3.2 "Memory test: Remember this number 42"
    
    # Check if recorded
    echo "Recent memory entries:"
    sqlite3 mirador_memory.db "SELECT query, created_at FROM analysis_history ORDER BY created_at DESC LIMIT 3"
else
    echo "✗ Memory wrapper not found - using standard mirador"
fi
