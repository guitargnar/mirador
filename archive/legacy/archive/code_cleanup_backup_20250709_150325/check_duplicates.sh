#!/bin/bash
# Check how many duplicate files actually exist

base_dir="/Users/matthewscott/ai_framework_git"
exist_count=0
missing_count=0
total_count=0

echo "Checking for duplicate files..."

# Extract file paths from the original script and check if they exist
while IFS= read -r line; do
    if [[ $line =~ rm[[:space:]]+\'([^\']+)\' ]]; then
        file="${BASH_REMATCH[1]}"
        full_path="$base_dir/$file"
        ((total_count++))
        
        if [ -f "$full_path" ]; then
            ((exist_count++))
            echo "EXISTS: $file"
        else
            ((missing_count++))
        fi
    fi
done < /Users/matthewscott/Projects/mirador/remove_duplicates.sh

echo "========================"
echo "Total files in script: $total_count"
echo "Files that exist: $exist_count"
echo "Files already missing: $missing_count"