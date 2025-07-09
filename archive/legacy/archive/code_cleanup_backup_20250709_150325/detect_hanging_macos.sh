#!/bin/bash

echo "=== Monitoring for Hanging Processes ==="

# Function to check if process is hanging
check_hanging() {
    local model=$1
    echo "Testing $model..."
    
    # Start process in background
    mirador-ez ask "$model" "Complex analysis of multiple opportunities" &
    local pid=$!
    
    # Monitor for 30 seconds
    local count=0
    while [ $count -lt 30 ]; do
        if ! ps -p $pid > /dev/null 2>&1; then
            echo "✓ $model completed in ${count}s"
            return 0
        fi
        sleep 1
        ((count++))
    done
    
    # Process still running after 30s
    echo "⚠️ $model: HANGING - killing process $pid"
    kill -TERM $pid 2>/dev/null
    sleep 2
    kill -KILL $pid 2>/dev/null
    return 1
}

# Test potentially problematic models
check_hanging "enhanced_agent_enforcer"
check_hanging "enhanced_agent_fast_v6"
check_hanging "feedback_loop_optimizer_fixed"
