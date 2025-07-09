# Mirador Command Interface Troubleshooting & Fixes

**Author:** Manus AI  
**Date:** December 17, 2024  
**Version:** 1.0  

## Executive Summary

The hanging "ask" command issue in Mirador represents a critical usability problem that significantly impacts user experience and system reliability. Through systematic analysis of the command interface architecture and common failure patterns in AI orchestration systems, I have identified several probable causes and developed comprehensive solutions to address both immediate symptoms and underlying structural issues.

This document provides detailed troubleshooting procedures, immediate fixes, and long-term improvements to ensure robust command execution and enhanced user experience. The solutions range from simple timeout implementations to comprehensive process management overhauls that will improve system reliability across all operational scenarios.

## Root Cause Analysis

The hanging "ask" command issue likely stems from multiple interconnected problems in the current command interface implementation. Understanding these root causes is essential for developing effective solutions that address both immediate symptoms and underlying architectural weaknesses.

### Process Management Issues

The most probable cause of hanging commands relates to inadequate process management in the `mirador-ez` script. When the script executes Ollama models through subprocess calls, several failure modes can result in indefinite blocking without user feedback or automatic recovery mechanisms.

Subprocess communication failures occur when the parent process (mirador-ez) loses communication with the child process (Ollama model execution) due to broken pipes, signal handling issues, or resource exhaustion. In these scenarios, the parent process continues waiting for output that will never arrive, creating the appearance of a hanging command while the underlying model execution may have failed or completed unsuccessfully.

Resource contention represents another significant factor, particularly on systems with limited memory or when multiple models are loaded simultaneously. If the system runs out of available memory or CPU resources during model execution, the process may enter a suspended state while waiting for resources to become available. Without proper resource monitoring and timeout mechanisms, this suspension can appear as an indefinite hang to users.

Signal handling deficiencies in the current implementation may prevent proper cleanup when users attempt to interrupt hanging commands. If the script does not properly handle SIGINT (Ctrl+C) or SIGTERM signals, users may be unable to gracefully terminate hanging operations, requiring more drastic measures like force-killing processes or restarting terminal sessions.

### Ollama Integration Problems

The integration between the Mirador command interface and the underlying Ollama runtime may contain several points of failure that contribute to hanging behavior. These integration issues often manifest as communication protocol problems or resource management conflicts.

Model loading failures can occur when Ollama attempts to load models that are corrupted, incompatible with the current system configuration, or require more resources than are available. If the command interface does not properly detect and handle these loading failures, commands may hang while waiting for models that will never successfully initialize.

Communication protocol mismatches between the command interface and Ollama API can result in malformed requests or responses that cause parsing failures. When the interface cannot properly interpret Ollama responses or when Ollama cannot process interface requests, the communication channel may become blocked, resulting in hanging behavior.

Concurrent access conflicts may arise when multiple Mirador commands attempt to access Ollama resources simultaneously. Without proper synchronization mechanisms, these conflicts can result in deadlock situations where commands wait indefinitely for resources that are held by other blocked operations.

### Error Handling Deficiencies

The current command interface appears to lack comprehensive error handling and recovery mechanisms that would prevent hanging behavior and provide meaningful feedback to users when problems occur. These deficiencies compound other issues and make troubleshooting more difficult.

Exception handling gaps in the current implementation may allow unhandled exceptions to propagate up the call stack without proper cleanup or user notification. When exceptions occur during model execution or output processing, the command interface may enter an undefined state that appears as hanging behavior to users.

Timeout mechanism absence represents a fundamental architectural weakness that allows operations to continue indefinitely without progress indicators or automatic termination. Without proper timeout handling, any operation that encounters blocking conditions will appear to hang until manually terminated by users.

Logging and monitoring deficiencies make it difficult to diagnose hanging issues when they occur. Without comprehensive logging of command execution, resource usage, and error conditions, users and developers cannot easily identify the root causes of hanging behavior or implement targeted solutions.

## Immediate Fixes

The following immediate fixes address the most critical aspects of the hanging command issue while requiring minimal changes to the existing system architecture. These fixes can be implemented quickly to restore system usability while more comprehensive solutions are developed.

### Enhanced mirador-ez Script

The first immediate fix involves creating an enhanced version of the mirador-ez script that implements proper timeout handling, improved error management, and better user feedback mechanisms. This enhanced script maintains backward compatibility while addressing the most common causes of hanging behavior.

```bash
#!/bin/bash
# Enhanced mirador-ez with timeout and error handling

set -euo pipefail  # Exit on error, undefined variables, pipe failures

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/config/system.yaml"
LOG_FILE="${HOME}/.mirador/logs/mirador-$(date +%Y%m%d).log"
DEFAULT_TIMEOUT=120
MAX_RETRIES=3

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# Logging function
log() {
    local level="$1"
    shift
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $*" | tee -a "$LOG_FILE"
}

# Error handling function
handle_error() {
    local exit_code=$?
    local line_number=$1
    log "ERROR" "Command failed with exit code $exit_code at line $line_number"
    log "ERROR" "Last command: $BASH_COMMAND"
    cleanup_processes
    exit $exit_code
}

# Cleanup function
cleanup_processes() {
    log "INFO" "Cleaning up background processes"
    # Kill any hanging ollama processes started by this session
    pkill -f "ollama.*$(basename "$0")" 2>/dev/null || true
}

# Signal handlers
trap 'handle_error $LINENO' ERR
trap 'log "INFO" "Received SIGINT, cleaning up..."; cleanup_processes; exit 130' INT
trap 'log "INFO" "Received SIGTERM, cleaning up..."; cleanup_processes; exit 143' TERM

# Check system health
check_system_health() {
    log "INFO" "Checking system health"
    
    # Check if Ollama is running
    if ! pgrep -x "ollama" > /dev/null; then
        log "WARN" "Ollama not running, attempting to start"
        ollama serve &
        sleep 5
    fi
    
    # Check available memory
    if command -v free > /dev/null; then
        local available_mem=$(free -m | awk 'NR==2{printf "%.1f", $7/1024}')
        log "INFO" "Available memory: ${available_mem}GB"
        if (( $(echo "$available_mem < 2.0" | bc -l) )); then
            log "WARN" "Low memory detected, consider closing other applications"
        fi
    fi
    
    # Check disk space
    local available_space=$(df -h "$HOME" | awk 'NR==2 {print $4}')
    log "INFO" "Available disk space: $available_space"
}

# Execute command with timeout
execute_with_timeout() {
    local timeout="$1"
    local command="$2"
    shift 2
    local args=("$@")
    
    log "INFO" "Executing: $command ${args[*]}"
    log "INFO" "Timeout: ${timeout}s"
    
    # Create temporary file for command output
    local temp_output=$(mktemp)
    local temp_error=$(mktemp)
    
    # Execute command with timeout
    if timeout "$timeout" "$command" "${args[@]}" > "$temp_output" 2> "$temp_error"; then
        cat "$temp_output"
        rm -f "$temp_output" "$temp_error"
        return 0
    else
        local exit_code=$?
        log "ERROR" "Command failed or timed out"
        log "ERROR" "STDOUT: $(cat "$temp_output")"
        log "ERROR" "STDERR: $(cat "$temp_error")"
        rm -f "$temp_output" "$temp_error"
        return $exit_code
    fi
}

# Ask command implementation
cmd_ask() {
    local model="$1"
    local prompt="$2"
    local timeout="${3:-$DEFAULT_TIMEOUT}"
    
    log "INFO" "Ask command: model=$model, timeout=${timeout}s"
    
    # Validate model exists
    if ! ollama list | grep -q "^$model"; then
        log "ERROR" "Model '$model' not found"
        log "INFO" "Available models:"
        ollama list
        return 1
    fi
    
    # Execute with retry logic
    local attempt=1
    while [ $attempt -le $MAX_RETRIES ]; do
        log "INFO" "Attempt $attempt of $MAX_RETRIES"
        
        if execute_with_timeout "$timeout" ollama run "$model" "$prompt"; then
            log "INFO" "Command completed successfully"
            return 0
        else
            log "WARN" "Attempt $attempt failed"
            if [ $attempt -lt $MAX_RETRIES ]; then
                log "INFO" "Retrying in 5 seconds..."
                sleep 5
            fi
        fi
        
        ((attempt++))
    done
    
    log "ERROR" "All attempts failed"
    return 1
}

# Chain command implementation
cmd_chain() {
    local description="$1"
    shift
    local models=("$@")
    
    log "INFO" "Chain command: $description"
    log "INFO" "Models: ${models[*]}"
    
    # Create output directory
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local output_dir="$HOME/ai_framework_git/outputs/chain_$timestamp"
    mkdir -p "$output_dir"
    
    log "INFO" "Output directory: $output_dir"
    
    # Execute chain with enhanced error handling
    local context="$description"
    local model_count=${#models[@]}
    
    for i in "${!models[@]}"; do
        local model="${models[$i]}"
        local step=$((i + 1))
        
        log "INFO" "Executing step $step/$model_count: $model"
        
        # Create step-specific prompt
        local step_prompt="$context"
        if [ $i -gt 0 ]; then
            step_prompt="$context\n\nPrevious analysis: $(cat "$output_dir/step_$((i))_output.md" 2>/dev/null || echo 'No previous output')"
        fi
        
        # Execute step with timeout
        if execute_with_timeout "$DEFAULT_TIMEOUT" ollama run "$model" "$step_prompt" > "$output_dir/step_${step}_output.md"; then
            log "INFO" "Step $step completed successfully"
            # Update context for next step
            context="$step_prompt\n\nStep $step output: $(cat "$output_dir/step_${step}_output.md")"
        else
            log "ERROR" "Step $step failed"
            return 1
        fi
    done
    
    # Create summary
    log "INFO" "Creating chain summary"
    echo "# Chain Execution Summary" > "$output_dir/summary.md"
    echo "**Description:** $description" >> "$output_dir/summary.md"
    echo "**Timestamp:** $(date)" >> "$output_dir/summary.md"
    echo "**Models:** ${models[*]}" >> "$output_dir/summary.md"
    echo "" >> "$output_dir/summary.md"
    
    for i in "${!models[@]}"; do
        local step=$((i + 1))
        echo "## Step $step: ${models[$i]}" >> "$output_dir/summary.md"
        cat "$output_dir/step_${step}_output.md" >> "$output_dir/summary.md"
        echo "" >> "$output_dir/summary.md"
    done
    
    log "INFO" "Chain completed successfully"
    echo "Output saved to: $output_dir"
}

# Main command dispatcher
main() {
    if [ $# -eq 0 ]; then
        echo "Usage: $0 {ask|chain|health|models} [args...]"
        echo ""
        echo "Commands:"
        echo "  ask MODEL PROMPT [TIMEOUT]    - Ask a single model"
        echo "  chain DESCRIPTION MODEL...    - Execute model chain"
        echo "  health                        - Check system health"
        echo "  models                        - List available models"
        exit 1
    fi
    
    local command="$1"
    shift
    
    # Check system health before executing commands
    check_system_health
    
    case "$command" in
        "ask")
            if [ $# -lt 2 ]; then
                log "ERROR" "Ask command requires model and prompt"
                exit 1
            fi
            cmd_ask "$@"
            ;;
        "chain")
            if [ $# -lt 2 ]; then
                log "ERROR" "Chain command requires description and at least one model"
                exit 1
            fi
            cmd_chain "$@"
            ;;
        "health")
            check_system_health
            log "INFO" "System health check completed"
            ;;
        "models")
            log "INFO" "Listing available models"
            ollama list
            ;;
        *)
            log "ERROR" "Unknown command: $command"
            exit 1
            ;;
    esac
}

# Execute main function
main "$@"
```

This enhanced script addresses the hanging issue through multiple mechanisms: comprehensive timeout handling prevents indefinite blocking, retry logic handles transient failures, proper signal handling enables graceful interruption, resource monitoring provides early warning of potential issues, and detailed logging facilitates troubleshooting and debugging.

### Process Monitoring Utility

The second immediate fix involves creating a process monitoring utility that can detect and resolve hanging Mirador processes automatically. This utility runs as a background service and provides automated recovery capabilities.

```bash
#!/bin/bash
# Mirador Process Monitor and Recovery Utility

MONITOR_INTERVAL=30
MAX_EXECUTION_TIME=300
LOG_FILE="$HOME/.mirador/logs/monitor-$(date +%Y%m%d).log"
PID_FILE="$HOME/.mirador/monitor.pid"

# Ensure directories exist
mkdir -p "$(dirname "$LOG_FILE")"
mkdir -p "$(dirname "$PID_FILE")"

# Logging function
monitor_log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [MONITOR] $*" | tee -a "$LOG_FILE"
}

# Check if monitor is already running
if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    monitor_log "Monitor already running with PID $(cat "$PID_FILE")"
    exit 1
fi

# Write PID file
echo $$ > "$PID_FILE"

# Cleanup function
cleanup_monitor() {
    monitor_log "Monitor shutting down"
    rm -f "$PID_FILE"
    exit 0
}

# Signal handlers
trap cleanup_monitor INT TERM

monitor_log "Starting Mirador process monitor"

while true; do
    # Find long-running mirador processes
    while IFS= read -r line; do
        if [ -n "$line" ]; then
            local pid=$(echo "$line" | awk '{print $1}')
            local elapsed=$(echo "$line" | awk '{print $2}')
            local command=$(echo "$line" | awk '{print $3}')
            
            # Convert elapsed time to seconds
            local elapsed_seconds
            if [[ "$elapsed" =~ ^([0-9]+):([0-9]+)$ ]]; then
                elapsed_seconds=$((${BASH_REMATCH[1]} * 60 + ${BASH_REMATCH[2]}))
            elif [[ "$elapsed" =~ ^([0-9]+):([0-9]+):([0-9]+)$ ]]; then
                elapsed_seconds=$((${BASH_REMATCH[1]} * 3600 + ${BASH_REMATCH[2]} * 60 + ${BASH_REMATCH[3]}))
            else
                elapsed_seconds=0
            fi
            
            if [ "$elapsed_seconds" -gt "$MAX_EXECUTION_TIME" ]; then
                monitor_log "Found hanging process: PID=$pid, elapsed=${elapsed}s, command=$command"
                monitor_log "Terminating hanging process $pid"
                
                # Try graceful termination first
                if kill -TERM "$pid" 2>/dev/null; then
                    sleep 10
                    # Force kill if still running
                    if kill -0 "$pid" 2>/dev/null; then
                        monitor_log "Force killing process $pid"
                        kill -KILL "$pid" 2>/dev/null
                    fi
                fi
            fi
        fi
    done < <(ps -eo pid,etime,comm | grep -E "(mirador|ollama)" | grep -v grep | tail -n +2)
    
    sleep "$MONITOR_INTERVAL"
done
```

This monitoring utility provides automated detection and recovery of hanging processes, preventing the need for manual intervention in most cases. The utility can be started automatically at system boot or manually when needed.

### Quick Diagnostic Script

The third immediate fix provides a diagnostic script that users can run to quickly identify and resolve common issues that contribute to hanging behavior.

```bash
#!/bin/bash
# Mirador Quick Diagnostic and Fix Script

echo "=== Mirador Quick Diagnostic ==="
echo "Timestamp: $(date)"
echo ""

# Check Ollama status
echo "1. Checking Ollama status..."
if pgrep -x "ollama" > /dev/null; then
    echo "   ✓ Ollama is running"
    echo "   Process info: $(ps aux | grep ollama | grep -v grep | head -1)"
else
    echo "   ✗ Ollama is not running"
    echo "   Attempting to start Ollama..."
    ollama serve &
    sleep 5
    if pgrep -x "ollama" > /dev/null; then
        echo "   ✓ Ollama started successfully"
    else
        echo "   ✗ Failed to start Ollama"
    fi
fi
echo ""

# Check system resources
echo "2. Checking system resources..."
if command -v free > /dev/null; then
    echo "   Memory usage:"
    free -h | head -2
    
    local available_mem=$(free -m | awk 'NR==2{printf "%.1f", $7/1024}')
    if (( $(echo "$available_mem < 2.0" | bc -l) )); then
        echo "   ⚠ Warning: Low memory detected (${available_mem}GB available)"
        echo "   Consider closing other applications"
    else
        echo "   ✓ Memory looks good (${available_mem}GB available)"
    fi
else
    echo "   Memory check not available on this system"
fi

echo "   Disk usage:"
df -h "$HOME" | head -2
echo ""

# Check for hanging processes
echo "3. Checking for hanging processes..."
local hanging_count=0
while IFS= read -r line; do
    if [ -n "$line" ]; then
        local pid=$(echo "$line" | awk '{print $1}')
        local elapsed=$(echo "$line" | awk '{print $2}')
        local command=$(echo "$line" | awk '{print $3}')
        
        echo "   Found long-running process: PID=$pid, elapsed=$elapsed, command=$command"
        ((hanging_count++))
        
        read -p "   Kill this process? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if kill -TERM "$pid" 2>/dev/null; then
                echo "   ✓ Process $pid terminated"
            else
                echo "   ✗ Failed to terminate process $pid"
            fi
        fi
    fi
done < <(ps -eo pid,etime,comm | grep -E "(mirador|ollama)" | grep -v grep | awk '$2 ~ /:/ && $2 !~ /^0:0[0-5]$/')

if [ "$hanging_count" -eq 0 ]; then
    echo "   ✓ No hanging processes found"
fi
echo ""

# Check model availability
echo "4. Checking model availability..."
if command -v ollama > /dev/null; then
    echo "   Available models:"
    ollama list | head -10
    
    local model_count=$(ollama list | tail -n +2 | wc -l)
    if [ "$model_count" -eq 0 ]; then
        echo "   ⚠ Warning: No models installed"
        echo "   Run 'ollama pull llama3.2' to install a basic model"
    else
        echo "   ✓ Found $model_count models"
    fi
else
    echo "   ✗ Ollama command not found"
fi
echo ""

# Test basic functionality
echo "5. Testing basic functionality..."
if command -v ollama > /dev/null && ollama list | grep -q llama; then
    echo "   Testing simple query..."
    local test_model=$(ollama list | grep llama | head -1 | awk '{print $1}')
    
    if timeout 30 ollama run "$test_model" "Say 'test successful'" > /tmp/mirador_test 2>&1; then
        echo "   ✓ Basic functionality test passed"
        echo "   Response: $(cat /tmp/mirador_test | head -1)"
    else
        echo "   ✗ Basic functionality test failed"
        echo "   Error: $(cat /tmp/mirador_test)"
    fi
    rm -f /tmp/mirador_test
else
    echo "   Skipping functionality test (no suitable model found)"
fi
echo ""

# Recommendations
echo "6. Recommendations:"
if [ "$hanging_count" -gt 0 ]; then
    echo "   • Consider restarting Ollama service if hanging persists"
    echo "   • Monitor system resources during heavy usage"
fi

if (( $(echo "$available_mem < 4.0" | bc -l) )); then
    echo "   • Consider upgrading system memory for better performance"
    echo "   • Close unnecessary applications before running complex chains"
fi

echo "   • Use the enhanced mirador script with timeout handling"
echo "   • Enable process monitoring for automatic recovery"
echo "   • Check logs in ~/.mirador/logs/ for detailed error information"
echo ""

echo "=== Diagnostic Complete ==="
```

This diagnostic script provides users with a quick way to identify and resolve common issues that contribute to hanging behavior, enabling self-service troubleshooting for most scenarios.

## Long-term Solutions

While the immediate fixes address the most pressing aspects of the hanging command issue, comprehensive long-term solutions require more substantial architectural improvements that enhance system reliability, performance, and maintainability.

### Robust Process Management Architecture

The long-term solution for process management involves implementing a comprehensive architecture that handles all aspects of process lifecycle management, from initialization through cleanup. This architecture provides the foundation for reliable command execution across all system operations.

The process management system should implement proper subprocess handling with comprehensive error detection, timeout management, and resource monitoring. This includes implementing process pools for efficient resource utilization, proper signal handling for graceful shutdown procedures, and comprehensive logging for troubleshooting and optimization purposes.

Resource management improvements should include dynamic memory allocation based on available system resources, intelligent model loading and unloading strategies, and automatic resource cleanup when operations complete or fail. These improvements ensure that the system operates efficiently within available resource constraints while providing predictable performance characteristics.

Concurrency control mechanisms should prevent resource conflicts when multiple operations execute simultaneously while enabling parallel execution where appropriate. This includes implementing proper locking mechanisms, queue management for pending operations, and load balancing across available system resources.

### Enhanced Error Handling and Recovery

The long-term error handling solution involves implementing comprehensive error detection, classification, and recovery mechanisms that can automatically resolve common issues while providing meaningful feedback to users about problems that require manual intervention.

Error classification systems should categorize different types of failures and implement appropriate recovery strategies for each category. Transient failures like temporary resource exhaustion should trigger automatic retry mechanisms, while persistent failures like model corruption should provide clear guidance for manual resolution.

Recovery mechanisms should include automatic fallback strategies when primary operations fail, such as using alternative models when preferred models are unavailable or implementing degraded functionality when full system capabilities are not accessible. These mechanisms ensure that users can continue productive work even when some system components are experiencing issues.

User feedback systems should provide clear, actionable information about system status, error conditions, and recovery procedures. This includes implementing progress indicators for long-running operations, detailed error messages that explain both the problem and potential solutions, and proactive notifications about system health and performance issues.

### Performance Optimization Framework

The long-term performance optimization solution involves implementing a comprehensive framework that monitors system performance, identifies optimization opportunities, and automatically implements improvements where possible.

Dynamic optimization systems should monitor execution patterns and automatically adjust system behavior to optimize for current usage patterns. This includes implementing adaptive timeout values based on historical performance data, intelligent caching strategies that reduce redundant computations, and automatic resource allocation adjustments based on workload characteristics.

Performance monitoring systems should track detailed metrics about system operation, including execution times, resource utilization, error rates, and user satisfaction indicators. This data enables continuous improvement of system performance and early identification of potential issues before they impact user experience.

Predictive optimization capabilities should analyze usage patterns and system performance trends to proactively implement optimizations and prevent performance degradation. This includes predicting resource requirements for upcoming operations, identifying optimal scheduling for automated workflows, and recommending system configuration changes that could improve performance.

The implementation of these long-term solutions requires careful planning and phased deployment to ensure that improvements enhance rather than disrupt existing functionality. The solutions should be designed to work together as an integrated system that provides comprehensive reliability, performance, and usability improvements for all Mirador operations.

