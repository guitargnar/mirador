#!/bin/bash
# Monitor for hanging mirador processes

echo "Monitoring Mirador processes..."
mirador-ez ask enhanced_agent_enforcer "Test query" &
PID=$!

sleep 30
if ps -p $PID > /dev/null; then
    echo "WARNING: Process still running after 30s (PID: $PID)"
    kill -TERM $PID
    echo "Process terminated"
else
    echo "Process completed normally"
fi
