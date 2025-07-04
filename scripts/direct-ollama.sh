#\!/bin/bash
# Direct Ollama interaction - NO SESSION management
# Just run model, get answer, and exit immediately

if [ $# -lt 2 ]; then
  echo "Usage: ./direct-ollama.sh <model> \"Your question here\""
  echo "Example: ./direct-ollama.sh fast-agent \"What is Python?\""
  echo ""
  echo "Available models:"
  ollama list
  exit 1
fi

MODEL="$1"
shift
PROMPT="$*"

# Use curl to call Ollama API directly - no session
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"$MODEL\", \"prompt\": \"$PROMPT\", \"stream\": false}" | \
  jq -r '.response'
