#!/usr/bin/env bash
# Output Manager - Organizes and maintains output directories

# Initialize the environment
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$( cd "$SCRIPT_DIR/../.." && pwd )"
source "$ROOT_DIR/src/utils/init.sh"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

INDEX_FILE="$MIRADOR_OUTPUTS_DIR/output_index.json"

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    log_error "jq is required but not installed"
    echo -e "${RED}Error: jq is required but not installed.${NC}"
    echo "Please install it with: brew install jq"
    exit 1
fi

# Create the directory structure if it doesn't exist
ensure_directories() {
    log_debug "Ensuring output directory structure exists"
    
    # Create base categories from config
    if [ -f "$MIRADOR_CONFIG_DIR/config.json" ]; then
        mapfile -t categories < <(jq -r '.output_categories | keys[]' "$MIRADOR_CONFIG_DIR/config.json")
        
        for category in "${categories[@]}"; do
            mkdir -p "$MIRADOR_OUTPUTS_DIR/$category"
            log_debug "Created category directory: $category"
        done
    else
        # Default categories if no config exists
        for dir in career_plans financial_plans guitar_learning business_strategies debug_logs archives; do
            mkdir -p "$MIRADOR_OUTPUTS_DIR/$dir"
            log_debug "Created default category directory: $dir"
        done
    fi
    
    # Create archives directory
    mkdir -p "$MIRADOR_OUTPUTS_DIR/archives"
    
    # Create index file if it doesn't exist
    if [ ! -f "$INDEX_FILE" ]; then
        log_info "Creating new output index file"
        
        # Start with basic structure
        echo '{' > "$INDEX_FILE"
        echo '  "version": "1.0",' >> "$INDEX_FILE"
        echo '  "last_updated": "'$(date +%Y-%m-%d)'",' >> "$INDEX_FILE"
        echo '  "total_outputs": 0,' >> "$INDEX_FILE"
        echo '  "categories": {' >> "$INDEX_FILE"
        
        # Add each category
        local first=true
        for category in "${categories[@]}"; do
            local description=$(jq -r ".output_categories.\"$category\".description" "$MIRADOR_CONFIG_DIR/config.json")
            
            if [ "$first" = true ]; then
                first=false
            else
                echo '    ,' >> "$INDEX_FILE"
            fi
            
            echo '    "'"$category"'": {' >> "$INDEX_FILE"
            echo '      "path": "'"$category"'",' >> "$INDEX_FILE"
            echo '      "description": "'"$description"'",' >> "$INDEX_FILE"
            echo '      "entries": []' >> "$INDEX_FILE"
            echo '    }' >> "$INDEX_FILE"
        done
        
        # Add archives category
        if [ "$first" = false ]; then
            echo '    ,' >> "$INDEX_FILE"
        fi
        
        echo '    "archives": {' >> "$INDEX_FILE"
        echo '      "path": "archives",' >> "$INDEX_FILE"
        echo '      "description": "Compressed archives of older outputs",' >> "$INDEX_FILE"
        echo '      "entries": []' >> "$INDEX_FILE"
        echo '    }' >> "$INDEX_FILE"
        
        # Close the structure
        echo '  }' >> "$INDEX_FILE"
        echo '}' >> "$INDEX_FILE"
        
        # Format with jq for consistency
        jq '.' "$INDEX_FILE" > "${INDEX_FILE}.tmp" && mv "${INDEX_FILE}.tmp" "$INDEX_FILE"
    fi
}

# Register a new output in the index
register_output() {
    local source_dir=$1
    local category=$2
    local prompt=$3
    
    log_info "Registering output to index: $(basename "$source_dir") in category $category"
    
    # Extract the date from directory name, assuming format *_YYYYMMDD_HHMMSS or chain_YYYYMMDD_HHMMSS
    local dir_name=$(basename "$source_dir")
    local timestamp=$(echo "$dir_name" | grep -o '[0-9]\{8\}_[0-9]\{6\}' || echo "$(date +%Y%m%d_%H%M%S)")
    local date_created=$(echo "$timestamp" | sed 's/\([0-9]\{4\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)_\([0-9]\{2\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)/\1-\2-\3 \4:\5:\6/')
    
    # Extract keywords from summary.md if it exists
    local keywords=""
    local summary_file="$source_dir/summary.md"
    if [ -f "$summary_file" ]; then
        keywords=$(grep -E '^#{1,3} ' "$summary_file" | sed 's/^#\+\s//g' | tr '\n' ',' | sed 's/,$//')
    fi
    
    # Create entry
    local entry=$(cat <<EOF
{
  "id": "$(uuidgen | tr -d '-')" ,
  "source_dir": "$dir_name",
  "dest_dir": "$MIRADOR_OUTPUTS_DIR/$category/$dir_name",
  "prompt": "$prompt",
  "date_created": "$date_created",
  "date_indexed": "$(date +%Y-%m-%d' '%H:%M:%S)",
  "keywords": "$keywords",
  "archived": false
}
EOF
)
    
    # Add to index
    local new_index=$(jq --arg category "$category" --argjson entry "$entry" \
        '.categories[$category].entries += [$entry] | .total_outputs = (.total_outputs + 1) | .last_updated = "'$(date +%Y-%m-%d)'"' \
        "$INDEX_FILE")
    
    echo "$new_index" > "$INDEX_FILE"
    
    log_info "Successfully registered output in index"
    echo -e "${GREEN}Registered output to index: ${BLUE}$dir_name${NC}"
}

# Move outputs to the appropriate category directories
move_to_category() {
    local source_dir=$1
    local category=$2
    local prompt=$3
    
    log_info "Moving output to category $category: $(basename "$source_dir")"
    
    # Create destination directory
    local dir_name=$(basename "$source_dir")
    local dest_dir="$MIRADOR_OUTPUTS_DIR/$category/$dir_name"
    
    # Move the directory
    mkdir -p "$dest_dir"
    cp -r "$source_dir"/* "$dest_dir"/
    
    # Register in index
    register_output "$source_dir" "$category" "$prompt"
    
    log_info "Successfully moved output to category"
    echo -e "${GREEN}Moved output to category ${BLUE}$category${NC}: ${YELLOW}$dest_dir${NC}"
}

# Archive outputs older than specified days per category
archive_old_outputs() {
    log_info "Checking for outputs to archive"
    echo -e "${BLUE}Checking for outputs to archive...${NC}"
    
    # Get archive days from config file if it exists
    declare -A archive_days
    if [ -f "$MIRADOR_CONFIG_DIR/config.json" ]; then
        mapfile -t categories < <(jq -r '.output_categories | keys[]' "$MIRADOR_CONFIG_DIR/config.json")
        
        for category in "${categories[@]}"; do
            days=$(jq -r ".output_categories.\"$category\".archive_days" "$MIRADOR_CONFIG_DIR/config.json")
            if [[ "$days" != "null" && "$days" -gt 0 ]]; then
                archive_days["$category"]=$days
                log_debug "Category $category will archive after $days days"
            else
                archive_days["$category"]=30  # Default to 30 days
            fi
        done
    else
        # Default archive days if no config
        archive_days["career_plans"]=60
        archive_days["financial_plans"]=90
        archive_days["guitar_learning"]=30
        archive_days["business_strategies"]=45
        archive_days["debug_logs"]=7
    fi
    
    # Check each category
    for category in "${!archive_days[@]}"; do
        local days=${archive_days["$category"]}
        local category_dir="$MIRADOR_OUTPUTS_DIR/$category"
        
        if [ ! -d "$category_dir" ]; then
            log_debug "Skipping non-existent category directory: $category"
            continue
        fi
        
        log_info "Processing category $category (archive after $days days)"
        echo -e "${BLUE}Processing category ${YELLOW}$category${NC} (archive after $days days)"
        
        # Find directories older than specified days
        find "$category_dir" -type d -maxdepth 1 -mtime +$days | while read -r old_dir; do
            if [ "$old_dir" = "$category_dir" ]; then
                continue  # Skip category directory itself
            fi
            
            local dir_name=$(basename "$old_dir")
            local archive_file="$MIRADOR_OUTPUTS_DIR/archives/${dir_name}.tar.gz"
            
            log_info "Archiving old output: $dir_name"
            echo -e "${YELLOW}Archiving old output: ${BLUE}$dir_name${NC}"
            
            # Create archive
            tar -czf "$archive_file" -C "$category_dir" "$dir_name"
            
            # Update index to mark as archived
            local new_index=$(jq --arg category "$category" --arg dir_name "$dir_name" --arg archive_file "$archive_file" '
                .categories[$category].entries = (.categories[$category].entries | map(
                    if .source_dir == $dir_name then
                        . + {archived: true, archive_path: $archive_file}
                    else
                        .
                    end
                ))
            ' "$INDEX_FILE")
            
            echo "$new_index" > "$INDEX_FILE"
            
            # Remove original directory
            rm -rf "$old_dir"
            
            log_info "Archived successfully to $archive_file"
            echo -e "${GREEN}Archived: ${BLUE}$dir_name${NC} to ${YELLOW}$archive_file${NC}"
        done
    done
}

# Identify output category from directory name and content
identify_category() {
    local dir_name=$(basename "$1")
    
    if [[ "$dir_name" == career_plan_* ]]; then
        echo "career_plans"
    elif [[ "$dir_name" == financial_plan_* ]]; then
        echo "financial_plans"
    elif [[ "$dir_name" == guitar_learning_* ]]; then
        echo "guitar_learning"
    elif [[ "$dir_name" == *chain_* || "$dir_name" == business_* || "$dir_name" == fixed_chain_* ]]; then
        echo "business_strategies"
    elif [[ "$dir_name" == debug_* ]]; then
        echo "debug_logs"
    else
        # Default category based on summary content
        if [ -f "$1/summary.md" ]; then
            if grep -q "Career Development Plan\|career\|job\|profession" "$1/summary.md"; then
                echo "career_plans"
            elif grep -q "Financial Planning\|budget\|investment\|money" "$1/summary.md"; then
                echo "financial_plans"
            elif grep -q "Guitar Learning\|practice\|music\|tab\|fret" "$1/summary.md"; then
                echo "guitar_learning"
            elif grep -q "Business\|strategy\|marketing\|content" "$1/summary.md"; then
                echo "business_strategies"
            else
                echo "business_strategies"  # Default if no category is clearly identified
            fi
        else
            echo "business_strategies"  # Default if no summary exists
        fi
    fi
}

# Extract prompt from file if available
extract_prompt() {
    local dir=$1
    
    if [ -f "$dir/summary.md" ]; then
        local prompt=$(grep -A 1 "Initial Request\|Initial Prompt\|Initial Prompt" "$dir/summary.md" | tail -n 1 | sed 's/^[[:space:]]*//' || echo "Unknown prompt")
        echo "$prompt"
    elif [ -f "$dir/step1_prompt.txt" ]; then
        local prompt=$(head -n 1 "$dir/step1_prompt.txt" | sed 's/^[[:space:]]*//' || echo "Unknown prompt")
        echo "$prompt"
    else
        echo "Unknown prompt"
    fi
}

# Organize all existing outputs
organize_existing_outputs() {
    log_info "Organizing existing outputs"
    echo -e "${BLUE}Organizing existing outputs...${NC}"
    
    # Find all output directories in home directory
    find "$HOME" -type d -maxdepth 1 \( -name "*_chain_*" -o -name "career_plan_*" -o -name "financial_plan_*" -o -name "guitar_learning_*" -o -name "debug_*" \) | while read -r output_dir; do
        if [ -d "$output_dir" ]; then
            local category=$(identify_category "$output_dir")
            local prompt=$(extract_prompt "$output_dir")
            
            log_debug "Found output: $output_dir - Category: $category"
            move_to_category "$output_dir" "$category" "$prompt"
        fi
    done
    
    # Archive old outputs
    if [[ "$(jq -r '.system.archive_enabled' "$MIRADOR_CONFIG_DIR/config.json")" == "true" ]]; then
        archive_old_outputs
    else
        log_info "Automatic archiving is disabled in config"
    fi
    
    log_info "Organization complete"
    echo -e "${GREEN}Organization complete!${NC}"
}

# Main execution
ensure_directories

# Parse command line arguments
case "$1" in
    organize)
        organize_existing_outputs
        ;;
    archive)
        archive_old_outputs
        ;;
    register)
        if [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
            log_error "Missing arguments for register"
            echo -e "${RED}Error: Missing arguments for register${NC}"
            echo "Usage: $0 register <source_dir> <category> \"<prompt>\""
            exit 1
        fi
        register_output "$2" "$3" "$4"
        ;;
    move)
        if [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
            log_error "Missing arguments for move"
            echo -e "${RED}Error: Missing arguments for move${NC}"
            echo "Usage: $0 move <source_dir> <category> \"<prompt>\""
            exit 1
        fi
        move_to_category "$2" "$3" "$4"
        ;;
    *)
        echo "Mirador Output Manager"
        echo "---------------------"
        echo "Usage: $0 <command>"
        echo ""
        echo "Commands:"
        echo "  organize    - Organize all existing outputs in home directory"
        echo "  archive     - Archive outputs older than configured days"
        echo "  register    - Register a directory in the index"
        echo "  move        - Move a directory to a category"
        echo ""
        echo "Examples:"
        echo "  $0 organize"
        echo "  $0 register ~/debug_chain_20250514_222613 debug_logs \"Test prompt\""
        echo "  $0 move ~/chain_20250514_223248 career_plans \"Career development plan\""
        ;;
esac

exit 0
