# Mirador with Memory - Enhances existing functionality with learning

MIRADOR_HOME="$HOME/ai_framework_git"
MEMORY_PY="$MIRADOR_HOME/mirador_memory.py"

# Initialize memory system if needed
init_memory() {
    if [ ! -f "$MIRADOR_HOME/mirador_memory.db" ]; then
        echo "Initializing Mirador memory system..."
        python3 "$MEMORY_PY"
    fi
}

# Log analysis start
log_start() {
    local query="$1"
    local models="$2"
    echo "$query|$models|$(date +%s)" > "$MIRADOR_HOME/.current_analysis"
}

# Log analysis completion
log_completion() {
    local output_path="$1"
    local quality_score="$2"
    
    if [ -f "$MIRADOR_HOME/.current_analysis" ]; then
        local data=$(cat "$MIRADOR_HOME/.current_analysis")
        local query=$(echo "$data" | cut -d'|' -f1)
        local models=$(echo "$data" | cut -d'|' -f2)
        local start_time=$(echo "$data" | cut -d'|' -f3)
        local end_time=$(date +%s)
        local exec_time=$((end_time - start_time))
        
        # Log to memory system
        python3 -c "
from mirador_memory import MiradorMemory
memory = MiradorMemory()
memory.log_analysis('$query', ['$models'], '$output_path', $exec_time, $quality_score)
memory.close()
"
        rm "$MIRADOR_HOME/.current_analysis"
    fi
}

# Check for similar past analyses
check_history() {
    local query="$1"
    python3 -c "
from mirador_memory import MiradorMemory
memory = MiradorMemory()
similar = memory.get_similar_analyses('$query')
if similar:
    print('\n=== Similar Past Analyses Found ===')
    for s in similar[:3]:
        print(f\"Query: {s['query'][:80]}...\")
        print(f\"Models: {s['models_used']}\")
        print(f\"Quality: {s['quality_score'] or 'Not rated'}\")
        print('---')
memory.close()
"
}

# Main execution wrapper
run_with_memory() {
    local command="$1"
    shift
    
    init_memory
    
    case "$command" in
        "ask")
            local model="$1"
            local query="$2"
            check_history "$query"
            log_start "$query" "$model"
            mirador-ez ask "$model" "$query"
            log_completion "individual_query" "0.5"
            ;;
        "chain")
            local query="$1"
            shift
            local models="$@"
            check_history "$query"
            log_start "$query" "$models"
            mirador-ez chain "$query" $models
            # Extract output path from mirador-ez output
            local output_path=$(mirador-ez chain "$query" $models | grep "Results saved to:" | awk '{print $4}')
            log_completion "$output_path" "0.7"
            ;;
        "insights")
            python3 -c "
from mirador_memory import MiradorMemory
import json
memory = MiradorMemory()
insights = memory.generate_insights()
print(json.dumps(insights, indent=2))
memory.close()
"
            ;;
        *)
            mirador-ez "$command" "$@"
            ;;
    esac
}

# Execute
run_with_memory "$@"
