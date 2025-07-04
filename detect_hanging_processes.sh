#!/bin/bash
# Detect and handle hanging Mirador processes

LOG_FILE="${HOME}/.mirador/logs/process-monitor-$(date +%Y%m%d).log"
HANG_THRESHOLD=300  # 5 minutes

mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

check_hanging_processes() {
    # Find ollama processes older than threshold
    while read -r pid elapsed cmd; do
        if [ "$elapsed" -gt "$HANG_THRESHOLD" ]; then
            log "ALERT: Found hanging process PID $pid (${elapsed}s): $cmd"
            
            # Try graceful termination first
            if kill -TERM "$pid" 2>/dev/null; then
                log "INFO: Sent SIGTERM to PID $pid"
                sleep 5
                
                # Check if still running
                if kill -0 "$pid" 2>/dev/null; then
                    log "WARN: Process $pid still running, force killing"
                    kill -KILL "$pid" 2>/dev/null
                fi
            fi
        fi
    done < <(ps -eo pid,etime,command | grep -E "(ollama|mirador)" | grep -v grep | awk '{print $1, $2, $0}')
}

log "Starting process monitor (threshold: ${HANG_THRESHOLD}s)"
check_hanging_processes
log "Process monitor check complete"
