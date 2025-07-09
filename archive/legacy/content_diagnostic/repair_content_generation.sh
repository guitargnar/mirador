#!/bin/bash
# Mirador Content Generation Repair Script
# Generated based on diagnostic results

set -e

echo "🔧 Repairing Mirador content generation issues..."

# Failed models detected - attempting repair

echo "Checking matthew_context_provider..."
if ollama list | grep -q 'matthew_context_provider'; then
    echo "Model matthew_context_provider exists, checking configuration..."
    ollama show matthew_context_provider > /tmp/matthew_context_provider_config.txt
    if ! grep -q 'SYSTEM' /tmp/matthew_context_provider_config.txt; then
        echo "⚠️  matthew_context_provider missing SYSTEM prompt - may need rebuilding"
    fi
    if ! grep -q 'FROM' /tmp/matthew_context_provider_config.txt; then
        echo "⚠️  matthew_context_provider missing base model - may be corrupted"
    fi
else
    echo "❌ Model matthew_context_provider not found in Ollama"
fi

echo "Checking decision_simplifier..."
if ollama list | grep -q 'decision_simplifier'; then
    echo "Model decision_simplifier exists, checking configuration..."
    ollama show decision_simplifier > /tmp/decision_simplifier_config.txt
    if ! grep -q 'SYSTEM' /tmp/decision_simplifier_config.txt; then
        echo "⚠️  decision_simplifier missing SYSTEM prompt - may need rebuilding"
    fi
    if ! grep -q 'FROM' /tmp/decision_simplifier_config.txt; then
        echo "⚠️  decision_simplifier missing base model - may be corrupted"
    fi
else
    echo "❌ Model decision_simplifier not found in Ollama"
fi

echo "🎉 Diagnostic complete. Check output above for issues."
echo "If models need rebuilding, look for corresponding .modelfile files."
