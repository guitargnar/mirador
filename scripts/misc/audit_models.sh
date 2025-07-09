#!/bin/bash

echo "=== Model Version Audit ==="
echo ""

# Group models by base name
declare -A model_versions

while read -r model; do
    base_name=$(echo "$model" | sed -E 's/_v[0-9]+.*$//' | sed -E 's/_fast$//' | sed -E 's/_optimized$//')
    model_versions["$base_name"]+="$model "
done < <(ollama list | grep -E "(financial|enhanced|louisville|matthew|mirador)" | awk '{print $1}' | cut -d: -f1)

# Display versions
for base in "${!model_versions[@]}"; do
    echo "$base:"
    for version in ${model_versions[$base]}; do
        echo "  - $version"
    done
    echo ""
done
