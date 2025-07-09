#!/bin/bash

echo "=== Mirador Model Backup ==="
echo "Timestamp: $(date)"

# Create backup directory
BACKUP_DIR="mirador_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup all model files
cp *.modelfile "$BACKUP_DIR/" 2>/dev/null || echo "No .modelfile files found"

# Backup documentation
cp *.md "$BACKUP_DIR/" 2>/dev/null || echo "No .md files found"

# Backup scripts
cp *.sh "$BACKUP_DIR/" 2>/dev/null || echo "No .sh files found"

# Create model list
ollama list > "$BACKUP_DIR/ollama_models.txt"

# Create git status
git status > "$BACKUP_DIR/git_status.txt" 2>/dev/null || echo "Not a git repository"

echo "Backup created in: $BACKUP_DIR"
echo "Files backed up:"
ls -la "$BACKUP_DIR"
