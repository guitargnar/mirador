#!/usr/bin/env bash
# Wrapper script to run the workflow script

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

# Forward all arguments to the actual script
exec "$ROOT_DIR/src/workflows/mirador_workflow.sh" "$@"
