#!/bin/bash
# Safe deletion script for duplicate files in ai_framework_git
# Fixed version that uses absolute paths

# Safety checks
if [ ! -d '/Users/matthewscott/ai_framework_git' ]; then
    echo 'Error: ai_framework_git directory not found'
    exit 1
fi

# Create backup
backup_dir="/Users/matthewscott/ai_framework_git_backup_$(date +%Y%m%d_%H%M%S)"
echo "Creating backup at: $backup_dir"
cp -r /Users/matthewscott/ai_framework_git "$backup_dir"

# Delete duplicate files using absolute paths
deleted_count=0
base_dir="/Users/matthewscott/ai_framework_git"

# Extract file deletion commands from original script and use absolute paths
echo "Starting deletion of duplicate files..."

# Read the original script and process deletions
while IFS= read -r line; do
    if [[ $line =~ ^[[:space:]]*if[[:space:]]+\[[[:space:]]-f[[:space:]]+\'(.+)\' ]]; then
        file="${BASH_REMATCH[1]}"
        full_path="$base_dir/$file"
        if [ -f "$full_path" ]; then
            rm "$full_path"
            echo "Deleted: $file"
            ((deleted_count++))
        fi
    fi
done < <(grep -E "if \[ -f '.+' \]" /Users/matthewscott/Projects/mirador/remove_duplicates.sh | sed "s/^[[:space:]]*//")

echo "Total files deleted: $deleted_count"
echo "Backup saved at: $backup_dir"

# Calculate space saved
if [ -d "$base_dir" ] && [ -d "$backup_dir" ]; then
    original_size=$(du -sh "$backup_dir" | cut -f1)
    new_size=$(du -sh "$base_dir" | cut -f1)
    echo "Original size: $original_size"
    echo "New size: $new_size"
fi