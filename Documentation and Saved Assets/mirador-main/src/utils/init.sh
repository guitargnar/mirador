#!/usr/bin/env bash
# Init script for Mirador

# Set strict error handling
set -eo pipefail

# Identify the script's directory and the project root
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$( cd "$SCRIPT_DIR/../.." && pwd )"

# Source logging module
source "${ROOT_DIR}/src/utils/logging.sh"

# Set up error trap that logs the error details
trap 'log_error "Error at line $LINENO: $BASH_COMMAND"' ERR

# Initialize: load configuration, check dependencies, etc.
log_debug "Initializing Mirador script from: $ROOT_DIR"

# Check required commands
for cmd in jq curl ollama; do
  if ! command -v "$cmd" &> /dev/null; then
    log_error "Required command not found: $cmd"
    echo "Error: $cmd is required but not installed."
    exit 1
  fi
done

# Export common variables
export MIRADOR_ROOT="$ROOT_DIR"
export MIRADOR_CONFIG_DIR="$ROOT_DIR/config"
export MIRADOR_LOGS_DIR="$ROOT_DIR/logs"
export MIRADOR_OUTPUTS_DIR="$ROOT_DIR/outputs"
export MIRADOR_TEMPLATES_DIR="$ROOT_DIR/templates"
export MIRADOR_SESSIONS_DIR="$ROOT_DIR/outputs/sessions"

# Create required directories
mkdir -p "$MIRADOR_LOGS_DIR" "$MIRADOR_OUTPUTS_DIR" "$MIRADOR_CONFIG_DIR" "$MIRADOR_TEMPLATES_DIR" "$MIRADOR_SESSIONS_DIR"

log_debug "Mirador initialized successfully"
