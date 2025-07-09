#!/bin/bash
# Complete deletion script for duplicate files in ai_framework_git
# This version processes all files from the original script

# Safety checks
if [ ! -d '/Users/matthewscott/ai_framework_git' ]; then
    echo 'Error: ai_framework_git directory not found'
    exit 1
fi

# Create backup
backup_dir="/Users/matthewscott/ai_framework_git_backup_$(date +%Y%m%d_%H%M%S)"
echo "Creating backup at: $backup_dir"
echo "This may take a while due to the large number of files..."

# Use rsync for more reliable backup with progress
rsync -av --progress /Users/matthewscott/ai_framework_git/ "$backup_dir/"

# Delete duplicate files using absolute paths
deleted_count=0
base_dir="/Users/matthewscott/ai_framework_git"

echo "Starting deletion of duplicate files..."

# Extract all file paths from the original script
original_script="/Users/matthewscott/Projects/mirador/remove_duplicates.sh"

# Process the script to extract file paths and delete them
while IFS= read -r line; do
    if [[ $line =~ rm[[:space:]]+\'([^\']+)\' ]]; then
        file="${BASH_REMATCH[1]}"
        full_path="$base_dir/$file"
        if [ -f "$full_path" ]; then
            rm "$full_path"
            echo "Deleted: $file"
            ((deleted_count++))
        fi
    fi
done < "$original_script"

echo "Total files deleted: $deleted_count"
echo "Backup saved at: $backup_dir"

# Calculate space saved
if [ -d "$base_dir" ] && [ -d "$backup_dir" ]; then
    original_size=$(du -sh "$backup_dir" 2>/dev/null | cut -f1)
    new_size=$(du -sh "$base_dir" 2>/dev/null | cut -f1)
    echo "Original size: $original_size"
    echo "New size: $new_size"
    
    # Count files
    original_files=$(find "$backup_dir" -type f 2>/dev/null | wc -l | tr -d ' ')
    new_files=$(find "$base_dir" -type f 2>/dev/null | wc -l | tr -d ' ')
    echo "Original file count: $original_files"
    echo "New file count: $new_files"
    echo "Files removed: $((original_files - new_files))"
fi