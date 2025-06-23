# Mirador Enhanced Command Interface

## Quick Implementation Scripts

The following scripts can be copied and pasted directly into your terminal to implement the enhanced Mirador command interface with timeout handling and improved error management.

### 1. Create Enhanced mirador Script

```bash
cat << 'EOF' > ~/projects/mirador/mirador
#!/bin/bash
# Enhanced mirador with timeout and error handling

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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
    cleanup_processes
    exit $exit_code
}

# Cleanup function
cleanup_processes() {
    log "INFO" "Cleaning up background processes"
    pkill -f "ollama.*$(basename "$0")" 2>/dev/null || true
}

# Signal handlers
trap 'handle_error $LINENO' ERR
trap 'log "INFO" "Received SIGINT, cleaning up..."; cleanup_processes; exit 130' INT
trap 'log "INFO" "Received SIGTERM, cleaning up..."; cleanup_processes; exit 143' TERM

# Check system health
check_system_health() {
    log "INFO" "Checking system health"
    
    if ! pgrep -x "ollama" > /dev/null; then
        log "WARN" "Ollama not running, attempting to start"
        ollama serve &
        sleep 5
    fi
    
    if command -v free > /dev/null; then
        local available_mem=$(free -m | awk 'NR==2{printf "%.1f", $7/1024}')
        log "INFO" "Available memory: ${available_mem}GB"
    fi
}

# Execute command with timeout
execute_with_timeout() {
    local timeout="$1"
    local command="$2"
    shift 2
    local args=("$@")
    
    log "INFO" "Executing: $command ${args[*]}"
    
    local temp_output=$(mktemp)
    local temp_error=$(mktemp)
    
    if timeout "$timeout" "$command" "${args[@]}" > "$temp_output" 2> "$temp_error"; then
        cat "$temp_output"
        rm -f "$temp_output" "$temp_error"
        return 0
    else
        local exit_code=$?
        log "ERROR" "Command failed or timed out"
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
    
    if ! ollama list | grep -q "^$model"; then
        log "ERROR" "Model '$model' not found"
        ollama list
        return 1
    fi
    
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
    
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local output_dir="$HOME/ai_framework_git/outputs/chain_$timestamp"
    mkdir -p "$output_dir"
    
    local context="$description"
    
    for i in "${!models[@]}"; do
        local model="${models[$i]}"
        local step=$((i + 1))
        
        log "INFO" "Executing step $step/${#models[@]}: $model"
        
        local step_prompt="$context"
        if [ $i -gt 0 ]; then
            step_prompt="$context\n\nPrevious analysis: $(cat "$output_dir/step_$((i))_output.md" 2>/dev/null || echo 'No previous output')"
        fi
        
        if execute_with_timeout "$DEFAULT_TIMEOUT" ollama run "$model" "$step_prompt" > "$output_dir/step_${step}_output.md"; then
            log "INFO" "Step $step completed successfully"
            context="$step_prompt\n\nStep $step output: $(cat "$output_dir/step_${step}_output.md")"
        else
            log "ERROR" "Step $step failed"
            return 1
        fi
    done
    
    echo "# Chain Execution Summary" > "$output_dir/summary.md"
    echo "**Description:** $description" >> "$output_dir/summary.md"
    echo "**Timestamp:** $(date)" >> "$output_dir/summary.md"
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
        exit 1
    fi
    
    local command="$1"
    shift
    
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

main "$@"
EOF

chmod +x ~/projects/mirador/mirador
```

### 2. Create Process Monitor

```bash
cat << 'EOF' > ~/projects/mirador/scripts/process_monitor.sh
#!/bin/bash
# Mirador Process Monitor

MONITOR_INTERVAL=30
MAX_EXECUTION_TIME=300
LOG_FILE="$HOME/.mirador/logs/monitor-$(date +%Y%m%d).log"
PID_FILE="$HOME/.mirador/monitor.pid"

mkdir -p "$(dirname "$LOG_FILE")"
mkdir -p "$(dirname "$PID_FILE")"

monitor_log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [MONITOR] $*" | tee -a "$LOG_FILE"
}

if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    monitor_log "Monitor already running with PID $(cat "$PID_FILE")"
    exit 1
fi

echo $$ > "$PID_FILE"

cleanup_monitor() {
    monitor_log "Monitor shutting down"
    rm -f "$PID_FILE"
    exit 0
}

trap cleanup_monitor INT TERM

monitor_log "Starting Mirador process monitor"

while true; do
    while IFS= read -r line; do
        if [ -n "$line" ]; then
            local pid=$(echo "$line" | awk '{print $1}')
            local elapsed=$(echo "$line" | awk '{print $2}')
            local command=$(echo "$line" | awk '{print $3}')
            
            local elapsed_seconds=0
            if [[ "$elapsed" =~ ^([0-9]+):([0-9]+)$ ]]; then
                elapsed_seconds=$((${BASH_REMATCH[1]} * 60 + ${BASH_REMATCH[2]}))
            elif [[ "$elapsed" =~ ^([0-9]+):([0-9]+):([0-9]+)$ ]]; then
                elapsed_seconds=$((${BASH_REMATCH[1]} * 3600 + ${BASH_REMATCH[2]} * 60 + ${BASH_REMATCH[3]}))
            fi
            
            if [ "$elapsed_seconds" -gt "$MAX_EXECUTION_TIME" ]; then
                monitor_log "Terminating hanging process: PID=$pid, elapsed=${elapsed}s"
                
                if kill -TERM "$pid" 2>/dev/null; then
                    sleep 10
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
EOF

chmod +x ~/projects/mirador/scripts/process_monitor.sh
```

### 3. Create Quick Diagnostic Script

```bash
cat << 'EOF' > ~/projects/mirador/scripts/quick_diagnostic.sh
#!/bin/bash
# Mirador Quick Diagnostic

echo "=== Mirador Quick Diagnostic ==="
echo "Timestamp: $(date)"
echo ""

echo "1. Checking Ollama status..."
if pgrep -x "ollama" > /dev/null; then
    echo "   ✓ Ollama is running"
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

echo "2. Checking system resources..."
if command -v free > /dev/null; then
    echo "   Memory usage:"
    free -h | head -2
else
    echo "   Memory check not available on this system"
fi

echo "   Disk usage:"
df -h "$HOME" | head -2
echo ""

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

echo "4. Checking model availability..."
if command -v ollama > /dev/null; then
    echo "   Available models:"
    ollama list | head -10
else
    echo "   ✗ Ollama command not found"
fi
echo ""

echo "5. Testing basic functionality..."
if command -v ollama > /dev/null && ollama list | grep -q llama; then
    echo "   Testing simple query..."
    local test_model=$(ollama list | grep llama | head -1 | awk '{print $1}')
    
    if timeout 30 ollama run "$test_model" "Say 'test successful'" > /tmp/mirador_test 2>&1; then
        echo "   ✓ Basic functionality test passed"
    else
        echo "   ✗ Basic functionality test failed"
    fi
    rm -f /tmp/mirador_test
else
    echo "   Skipping functionality test (no suitable model found)"
fi
echo ""

echo "=== Diagnostic Complete ==="
EOF

chmod +x ~/projects/mirador/scripts/quick_diagnostic.sh
```

### 4. Update mirador-ez to use new script

```bash
# Backup existing mirador-ez
if [ -f ~/projects/mirador/mirador-ez ]; then
    cp ~/projects/mirador/mirador-ez ~/projects/mirador/mirador-ez.backup
fi

# Create symlink to new enhanced script
ln -sf ~/projects/mirador/mirador ~/projects/mirador/mirador-ez
```

### 5. Test the enhanced system

```bash
# Test basic functionality
~/projects/mirador/mirador health

# Test ask command with timeout
~/projects/mirador/mirador ask llama3.2 "Hello, this is a test" 30

# Run diagnostic
~/projects/mirador/scripts/quick_diagnostic.sh

# Start process monitor (optional)
# ~/projects/mirador/scripts/process_monitor.sh &
```

## Usage Instructions

1. **Enhanced Command Interface**: The new `mirador` script replaces `mirador-ez` with timeout handling, retry logic, and comprehensive error management.

2. **Process Monitoring**: Run the process monitor in the background to automatically detect and terminate hanging processes.

3. **Quick Diagnostics**: Use the diagnostic script to quickly identify and resolve common issues.

4. **Logging**: All operations are logged to `~/.mirador/logs/` for troubleshooting.

5. **Graceful Interruption**: Use Ctrl+C to cleanly interrupt hanging commands.

The enhanced system should resolve the hanging "ask" command issue while providing better reliability and user feedback.

