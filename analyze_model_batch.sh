#!/bin/bash
# Analyze Ollama models in batches using parallel agents

echo "🔍 Starting parallel Ollama model analysis..."

# Get total number of models
TOTAL_MODELS=$(ollama list | tail -n +2 | wc -l)
echo "Found $TOTAL_MODELS models to analyze"

# Create results directory
RESULTS_DIR="ollama_analysis_results"
mkdir -p "$RESULTS_DIR"

# Function to analyze a single model
analyze_model() {
    local model=$1
    local index=$2
    local output_file="$RESULTS_DIR/model_${index}_$(echo $model | tr ':/' '_').json"
    
    echo "Analyzing model $index: $model"
    
    # Extract modelfile using expect script for better interaction
    cat > "$RESULTS_DIR/interact_${index}.exp" << EOF
#!/usr/bin/expect -f
set timeout 10
spawn ollama run $model
expect ">>>"
send "/show modelfile\r"
expect -re {FROM.*} {
    set output \$expect_out(buffer)
    puts "\$output"
}
send "/bye\r"
expect eof
EOF
    
    chmod +x "$RESULTS_DIR/interact_${index}.exp"
    
    # Run expect script and capture output
    modelfile_output=$("$RESULTS_DIR/interact_${index}.exp" 2>/dev/null | grep -A 50 "FROM" | head -n 30)
    
    # Extract base model information
    base_model=$(echo "$modelfile_output" | grep -i "^FROM" | awk '{print $2}' | head -1)
    
    # Determine LLM family
    if [[ $base_model == *"llama"* ]]; then
        if [[ $base_model == *"3.2"* ]]; then
            llm_family="Llama 3.2"
        elif [[ $base_model == *"3.1"* ]]; then
            llm_family="Llama 3.1"
        elif [[ $base_model == *"3"* ]]; then
            llm_family="Llama 3"
        else
            llm_family="Llama"
        fi
    elif [[ $base_model == *"mistral"* ]]; then
        llm_family="Mistral"
    elif [[ $base_model == *"deepseek"* ]]; then
        llm_family="DeepSeek"
    elif [[ $base_model == *"gemma"* ]]; then
        llm_family="Gemma"
    elif [[ $base_model == *"qwen"* ]]; then
        llm_family="Qwen"
    elif [[ $base_model == *"phi"* ]]; then
        llm_family="Phi"
    else
        llm_family="Unknown"
    fi
    
    # Get model size
    model_size=$(ollama list | grep "^$model" | awk '{print $3 " " $4}')
    
    # Create JSON output
    cat > "$output_file" << EOF
{
  "model": "$model",
  "index": $index,
  "base_model": "$base_model",
  "llm_family": "$llm_family",
  "size": "$model_size",
  "modelfile_preview": "$(echo "$modelfile_output" | head -10 | jq -Rs .)"
}
EOF
    
    echo "✓ Completed analysis of $model"
    
    # Cleanup
    rm -f "$RESULTS_DIR/interact_${index}.exp"
}

# Export function for parallel execution
export -f analyze_model
export RESULTS_DIR

# Process models in parallel batches
echo "Processing models in parallel..."

# Get model list
ollama list | tail -n +2 | awk '{print $1}' > "$RESULTS_DIR/model_list.txt"

# Process in batches of 5
batch_size=5
index=0

while IFS= read -r model; do
    ((index++))
    # Run in background, limit to batch_size concurrent processes
    analyze_model "$model" "$index" &
    
    # Wait for batch to complete
    if (( index % batch_size == 0 )); then
        wait
        echo "Completed batch of $batch_size models..."
    fi
done < "$RESULTS_DIR/model_list.txt"

# Wait for final batch
wait

echo "✅ All models analyzed!"

# Combine results
echo "Combining results..."
python3 << 'EOF'
import json
import glob
from datetime import datetime

results_dir = "ollama_analysis_results"
all_results = []

# Read all individual results
for json_file in glob.glob(f"{results_dir}/model_*.json"):
    try:
        with open(json_file, 'r') as f:
            data = json.load(f)
            all_results.append(data)
    except:
        pass

# Sort by index
all_results.sort(key=lambda x: x.get('index', 0))

# Create summary
summary = {}
for result in all_results:
    llm_family = result.get('llm_family', 'Unknown')
    if llm_family not in summary:
        summary[llm_family] = []
    summary[llm_family].append({
        'model': result['model'],
        'size': result.get('size', 'Unknown')
    })

# Save combined results
output = {
    'timestamp': datetime.now().isoformat(),
    'total_models': len(all_results),
    'models': all_results,
    'summary': summary
}

with open('ollama_model_analysis_complete.json', 'w') as f:
    json.dump(output, f, indent=2)

# Create markdown report
with open('OLLAMA_MODEL_ANALYSIS.md', 'w') as f:
    f.write("# Ollama Model Analysis Report\n\n")
    f.write(f"Generated: {output['timestamp']}\n\n")
    f.write(f"Total models analyzed: {output['total_models']}\n\n")
    
    f.write("## Summary by LLM Family\n\n")
    for llm_family, models in sorted(summary.items()):
        f.write(f"### {llm_family} ({len(models)} models)\n\n")
        f.write("| Model | Size |\n")
        f.write("|-------|------|\n")
        for model_info in sorted(models, key=lambda x: x['model']):
            f.write(f"| {model_info['model']} | {model_info['size']} |\n")
        f.write("\n")
    
    f.write("## Model Distribution\n\n")
    f.write("```\n")
    for llm_family, models in sorted(summary.items(), key=lambda x: len(x[1]), reverse=True):
        percentage = len(models) / len(all_results) * 100
        f.write(f"{llm_family:20} {len(models):3} models ({percentage:5.1f}%)\n")
    f.write("```\n")

print("✅ Analysis complete! Results saved to:")
print("  - ollama_model_analysis_complete.json")
print("  - OLLAMA_MODEL_ANALYSIS.md")
EOF

# Cleanup
rm -rf "$RESULTS_DIR"

echo "🎉 Ollama model analysis complete!"