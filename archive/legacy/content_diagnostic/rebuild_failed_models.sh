#!/bin/bash
# Rebuild Failed Mirador Models
# Edit this script to point to your .modelfile locations

set -e

echo "🔨 Rebuilding failed Mirador models..."

# Set your modelfile directory
MODELFILE_DIR="."

# Rebuild matthew_context_provider
if [ -f "$MODELFILE_DIR/matthew_context_provider.modelfile" ]; then
    echo "Rebuilding matthew_context_provider..."
    ollama create matthew_context_provider -f "$MODELFILE_DIR/matthew_context_provider.modelfile"
    echo "✅ matthew_context_provider rebuilt"
else
    echo "⚠️  Modelfile not found: $MODELFILE_DIR/matthew_context_provider.modelfile"
fi

# Rebuild decision_simplifier
if [ -f "$MODELFILE_DIR/decision_simplifier.modelfile" ]; then
    echo "Rebuilding decision_simplifier..."
    ollama create decision_simplifier -f "$MODELFILE_DIR/decision_simplifier.modelfile"
    echo "✅ decision_simplifier rebuilt"
else
    echo "⚠️  Modelfile not found: $MODELFILE_DIR/decision_simplifier.modelfile"
fi

echo "🎉 Model rebuilding complete!"
