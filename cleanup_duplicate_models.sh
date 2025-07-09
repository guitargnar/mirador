#!/bin/bash
# Ollama Model Cleanup Script
# Generated: 2025-07-09T17:13:39.885242
# This script will safely remove duplicate models

echo "🧹 Ollama Model Cleanup"
echo "======================"
echo ""
echo "This script will remove duplicate models to free up storage."
echo "A backup list of all models will be saved first."
echo ""

# Backup current model list
echo "📋 Backing up model list..."
ollama list > ollama_models_backup_20250709_171339.txt
echo "Backup saved to: ollama_models_backup_20250709_171339.txt"
echo ""

# Confirmation
read -p "Continue with cleanup? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cleanup cancelled."
    exit 1
fi

echo ""
echo "🗑️  Removing duplicate models..."
echo ""

# Remove exact duplicates
REMOVED=0
FAILED=0


echo -n "Removing llama3.2:latest... "
if ollama rm llama3.2:latest 2>/dev/null; then
    echo "✓"
    ((REMOVED++))
else
    echo "✗ Failed"
    ((FAILED++))
fi

echo ""
echo "📊 Cleanup Summary"
echo "=================="
echo "Models removed: $REMOVED"
echo "Failed removals: $FAILED"
echo ""

# Show storage saved
echo "💾 Storage impact:"
ollama list

echo ""
echo "✅ Cleanup complete!"
echo ""
echo "To restore removed models, use the model creation scripts in the 'models' directory."
