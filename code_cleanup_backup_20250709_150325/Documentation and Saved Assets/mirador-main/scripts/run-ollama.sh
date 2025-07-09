#\!/bin/bash
# Ultra simple Ollama runner - just works\!

if [ $# -lt 1 ]; then
  echo "Usage: ./run-ollama.sh [model] \"Your question here\""
  echo "Example: ./run-ollama.sh fast-agent \"What is Python?\""
  echo "         ./run-ollama.sh \"What is Python?\"  (uses fast-agent by default)"
  echo ""
  echo "Available models:"
  ollama list
  exit 1
fi

# If only one argument, use fast-agent as the default model
if [ $# -eq 1 ]; then
  MODEL="fast-agent"
  PROMPT="$1"
else
  MODEL="$1"
  shift
  PROMPT="$*"
fi

# Just run Ollama directly - that's it\!
ollama run "$MODEL" "$PROMPT"
