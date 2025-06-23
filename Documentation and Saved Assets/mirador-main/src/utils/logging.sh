#!/usr/bin/env bash
# Mirador logging system

LOG_DIR="${HOME}/ai_framework_git/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/mirador_$(date +%Y%m%d).log"

# Log levels
readonly LOG_LEVEL_DEBUG=0
readonly LOG_LEVEL_INFO=1
readonly LOG_LEVEL_WARN=2
readonly LOG_LEVEL_ERROR=3

# Default log level (can be overridden by environment)
MIRADOR_LOG_LEVEL=${MIRADOR_LOG_LEVEL:-$LOG_LEVEL_INFO}

log() {   # usage: log LEVEL "message"
  local level_name=$1; shift
  local level_num
  
  case "$level_name" in
    DEBUG) level_num=$LOG_LEVEL_DEBUG ;;
    INFO)  level_num=$LOG_LEVEL_INFO ;;
    WARN)  level_num=$LOG_LEVEL_WARN ;;
    ERROR) level_num=$LOG_LEVEL_ERROR ;;
    *)     level_num=$LOG_LEVEL_INFO; level_name="INFO" ;;
  esac
  
  # Only log if level meets or exceeds the threshold
  if [[ $level_num -ge $MIRADOR_LOG_LEVEL ]]; then
    local msg=$*
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level_name] $msg" \
      | tee -a "$LOG_FILE"
  fi
}

log_debug() { log DEBUG "$@"; }
log_info()  { log INFO "$@"; }
log_warn()  { log WARN "$@"; }
log_error() { log ERROR "$@"; }

# Helper for logging execution time
time_cmd() {
  local start_time=$(date +%s)
  local cmd_name=$1
  shift
  
  log_debug "Starting $cmd_name"
  "$@"
  local status=$?
  local end_time=$(date +%s)
  local duration=$((end_time - start_time))
  
  log_info "$cmd_name completed in ${duration}s with status $status"
  return $status
}
