#!/usr/bin/env bash
# Mirador Workflow Integration Script

# Initialize the environment
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$( cd "$SCRIPT_DIR/../.." && pwd )"
source "$ROOT_DIR/src/utils/init.sh"

# Create templates directory if it doesn't exist
JOURNAL_DIR="$HOME/mirador_journal"
TEMPLATE_DIR="$JOURNAL_DIR/templates"
DATE=$(date +%Y%m%d)

# Ensure directories exist
mkdir -p "$JOURNAL_DIR"
mkdir -p "$TEMPLATE_DIR"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to display help
show_help() {
    echo -e "${BLUE}Mirador Workflow Script${NC}"
    echo -e "Seamlessly integrate Mirador AI orchestration into your daily life\n"
    echo -e "Usage: ./mirador_workflow.sh [command] [options]\n"
    echo -e "Commands:"
    echo -e "  ${GREEN}finance${NC}    - Financial planning and budget management"
    echo -e "  ${GREEN}practice${NC}   - Guitar practice planning"
    echo -e "  ${GREEN}career${NC}     - Career development planning"
    echo -e "  ${GREEN}tasks${NC}      - Daily task management"
    echo -e "  ${GREEN}template${NC}   - Use a specific template"
    echo -e "  ${GREEN}review${NC}     - Review past entries"
    echo -e "\nExamples:"
    echo -e "  ./mirador_workflow.sh finance"
    echo -e "  ./mirador_workflow.sh practice"
    echo -e "  ./mirador_workflow.sh tasks"
    echo -e "  ./mirador_workflow.sh template career_development.txt"
    echo -e "  ./mirador_workflow.sh review finance\n"
}

# Create default templates if they don't exist
create_default_templates() {
    log_debug "Checking if default templates need to be created"
    
    # Financial planning template
    if [ ! -f "$TEMPLATE_DIR/financial_planning.txt" ]; then
        log_info "Creating default financial planning template"
        cat > "$TEMPLATE_DIR/financial_planning.txt" << 'EOF'
Financial Planning Request:

Current account balance: 
Monthly income: 
Fixed expenses: 

Current financial goals:
1. 
2. 
3. 

Specific questions or concerns:

Timeframe for planning: 
EOF
    fi
    
    # Guitar practice template
    if [ ! -f "$TEMPLATE_DIR/guitar_practice.txt" ]; then
        log_info "Creating default guitar practice template"
        cat > "$TEMPLATE_DIR/guitar_practice.txt" << 'EOF'
Guitar Practice Request:

Current skill level: 
Specific techniques I want to work on: 

Musical goals:
1. 
2. 
3. 

Time available for practice daily: 
EOF
    fi
    
    # Career development template
    if [ ! -f "$TEMPLATE_DIR/career_development.txt" ]; then
        log_info "Creating default career development template"
        cat > "$TEMPLATE_DIR/career_development.txt" << 'EOF'
Career Development Request:

Current role: 
Years of experience: 
Key skills: 

Career goals:
1. 
2. 
3. 

Skills I want to develop:

Timeframe for career plan: 
EOF
    fi
    
    # Daily planning template
    if [ ! -f "$TEMPLATE_DIR/daily_planning.txt" ]; then
        log_info "Creating default daily planning template"
        cat > "$TEMPLATE_DIR/daily_planning.txt" << 'EOF'
Daily Planning Request:

Today's tasks:
1. 
2. 
3. 
4. 
5. 

Priorities: 
Available time: 
Energy level: 

Special considerations for today:
EOF
    fi
}

# Function to run Mirador with a template
run_with_template() {
    template="$1"
    output_dir="$2"
    models=(${3//,/ })
    
    if [ ! -f "$TEMPLATE_DIR/$template" ]; then
        log_error "Template not found: $template"
        echo -e "${YELLOW}Template not found: $template${NC}"
        return 1
    fi
    
    # Create output directory if it doesn't exist
    mkdir -p "$JOURNAL_DIR/$output_dir"
    
    # Open template in editor
    echo -e "${BLUE}Opening template for editing...${NC}"
    if [ -n "$EDITOR" ]; then
        "$EDITOR" "$TEMPLATE_DIR/$template"
    else
        nano "$TEMPLATE_DIR/$template"
    fi
    
    # Ask user if they want to proceed
    echo -e "${YELLOW}Proceed with generating Mirador output? (y/n)${NC}"
    read -r proceed
    
    if [[ "$proceed" == "y" ]]; then
        output_file="$JOURNAL_DIR/$output_dir/${output_dir}_${DATE}.md"
        log_info "Running Mirador with models: ${models[*]} and template $template"
        echo -e "${BLUE}Running Mirador chain with models: ${models[*]}...${NC}"
        
        # Run the chain with appropriate models
        if [ ${#models[@]} -eq 1 ]; then
            "$ROOT_DIR/scripts/run_chain.sh" "$(cat "$TEMPLATE_DIR/$template")" "${models[0]}"
        elif [ ${#models[@]} -eq 2 ]; then
            "$ROOT_DIR/scripts/run_chain.sh" "$(cat "$TEMPLATE_DIR/$template")" "${models[0]}" "${models[1]}"
        elif [ ${#models[@]} -ge 3 ]; then
            "$ROOT_DIR/scripts/run_chain.sh" "$(cat "$TEMPLATE_DIR/$template")" "${models[0]}" "${models[1]}" "${models[2]}"
        fi
        
        log_info "Output saved to journal directory"
        echo -e "${GREEN}Output saved to journal directory. You can review it using the 'review' command.${NC}"
    else
        log_info "Operation cancelled by user"
        echo -e "${BLUE}Operation cancelled.${NC}"
    fi
}

# Function to review past entries
review_entries() {
    domain="$1"
    
    if [ ! -d "$JOURNAL_DIR/$domain" ]; then
        log_error "No entries found for domain: $domain"
        echo -e "${YELLOW}No entries found for domain: $domain${NC}"
        return 1
    fi
    
    entries=$(ls -t "$JOURNAL_DIR/$domain" | grep -v "README")
    
    if [ -z "$entries" ]; then
        log_error "No entries found for domain: $domain"
        echo -e "${YELLOW}No entries found for domain: $domain${NC}"
        return 1
    fi
    
    echo -e "${BLUE}Entries for domain '$domain':${NC}"
    echo "$entries" | cat -n
    
    echo -e "${YELLOW}Enter number to view (or 0 to cancel):${NC}"
    read -r entry_num
    
    if [ "$entry_num" -eq 0 ]; then
        log_info "Operation cancelled by user"
        echo -e "${BLUE}Operation cancelled.${NC}"
        return 0
    fi
    
    entry=$(echo "$entries" | sed -n "${entry_num}p")
    
    if [ -n "$entry" ]; then
        less "$JOURNAL_DIR/$domain/$entry"
    else
        log_error "Invalid entry number"
        echo -e "${YELLOW}Invalid entry number.${NC}"
    fi
}

# Load workflow configuration
load_workflow_config() {
    local workflow="$1"
    
    if [ -f "$MIRADOR_CONFIG_DIR/config.json" ]; then
        if jq -e ".workflows.\"$workflow\"" "$MIRADOR_CONFIG_DIR/config.json" > /dev/null; then
            local template=$(jq -r ".workflows.\"$workflow\".template" "$MIRADOR_CONFIG_DIR/config.json")
            local category=$(jq -r ".workflows.\"$workflow\".output_category" "$MIRADOR_CONFIG_DIR/config.json")
            
            # Get models as comma-separated string
            local models_json=$(jq -r ".workflows.\"$workflow\".chain | join(\",\")" "$MIRADOR_CONFIG_DIR/config.json")
            
            echo "$template:$category:$models_json"
            return 0
        fi
    fi
    
    # Default fallbacks if config not found
    case "$workflow" in
        finance)
            echo "financial_planning.txt:financial_plans:llama3.2_balanced,fast_agent_focused"
            ;;
        practice)
            echo "guitar_practice.txt:guitar_learning:guitar_expert_precise,fast_agent_focused"
            ;;
        career)
            echo "career_development.txt:career_plans:llama3.2_balanced,fast_agent_focused"
            ;;
        tasks)
            echo "daily_planning.txt:business_strategies:fast_agent_focused"
            ;;
        *)
            echo ""
            return 1
            ;;
    esac
}

# Ensure templates exist
create_default_templates

# Main logic
log_info "Running workflow with args: $*"

case "$1" in
    finance|practice|career|tasks)
        workflow_config=$(load_workflow_config "$1")
        IFS=':' read -r template category models <<< "$workflow_config"
        
        if [ -n "$template" ]; then
            run_with_template "$template" "$category" "$models"
        else
            log_error "Could not load workflow configuration for $1"
            echo -e "${RED}Error: Could not load workflow configuration for $1${NC}"
            exit 1
        fi
        ;;
    template)
        if [ -z "$2" ]; then
            log_error "Please specify a template file"
            echo -e "${YELLOW}Please specify a template file.${NC}"
            exit 1
        fi
        
        # Try to find workflow for this template
        found=false
        if [ -f "$MIRADOR_CONFIG_DIR/config.json" ]; then
            workflow=$(jq -r '.workflows | to_entries[] | select(.value.template == "'"$2"'") | .key' "$MIRADOR_CONFIG_DIR/config.json")
            
            if [ -n "$workflow" ]; then
                found=true
                workflow_config=$(load_workflow_config "$workflow")
                IFS=':' read -r template category models <<< "$workflow_config"
                run_with_template "$template" "$category" "$models"
            fi
        fi
        
        # Fallback to template mapping if not found in config
        if [ "$found" = false ]; then
            case "$2" in
                financial_planning.txt)
                    run_with_template "$2" "financial_plans" "llama3.2_balanced,fast_agent_focused"
                    ;;
                career_development.txt)
                    run_with_template "$2" "career_plans" "llama3.2_balanced,fast_agent_focused"
                    ;;
                guitar_practice.txt)
                    run_with_template "$2" "guitar_learning" "guitar_expert_precise,fast_agent_focused"
                    ;;
                daily_planning.txt)
                    run_with_template "$2" "business_strategies" "fast_agent_focused"
                    ;;
                *)
                    log_error "Unknown template: $2"
                    echo -e "${YELLOW}Unknown template: $2${NC}"
                    exit 1
                    ;;
            esac
        fi
        ;;
    review)
        if [ -z "$2" ]; then
            log_error "Please specify a domain to review"
            echo -e "${YELLOW}Please specify a domain to review (finance, guitar, career, productivity).${NC}"
            exit 1
        fi
        
        review_entries "$2"
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        show_help
        exit 1
        ;;
esac

log_info "Workflow completed successfully"
exit 0
