#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <backup_directory>"
    echo "Available backups:"
    ls -d mirador_backup_* 2>/dev/null || echo "No backups found"
    exit 1
fi

BACKUP_DIR="$1"

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Backup directory $BACKUP_DIR not found"
    exit 1
fi

echo "=== Mirador Model Restoration ==="
echo "Restoring from: $BACKUP_DIR"

# Restore model files
if ls "$BACKUP_DIR"/*.modelfile 1> /dev/null 2>&1; then
    echo "Restoring model files..."
    for modelfile in "$BACKUP_DIR"/*.modelfile; do
        filename=$(basename "$modelfile")
        cp "$modelfile" .
        echo "Restored: $filename"
        
        # Recreate the model in Ollama
        model_name="${filename%.modelfile}"
        echo "Recreating model: $model_name"
        ollama create "$model_name" -f "$filename"
    done
else
    echo "No model files found in backup"
fi

# Restore documentation
if ls "$BACKUP_DIR"/*.md 1> /dev/null 2>&1; then
    echo "Restoring documentation..."
    cp "$BACKUP_DIR"/*.md .
fi

echo "Restoration complete"
