#!/bin/bash
# Cleanup old outputs and temporary files

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

echo -e "${BLUE}🧹 Mirador Output Cleanup${RESET}"
echo "=========================="
echo ""

# Check if outputs directory exists
if [ ! -d "outputs" ]; then
    echo "No outputs directory found. Nothing to clean."
    exit 0
fi

# Count files
TOTAL_DIRS=$(find outputs -type d -name "universal_*" -o -name "rag_*" -o -name "hybrid_*" | wc -l)
OLD_DIRS=$(find outputs -type d -mtime +7 -name "universal_*" -o -name "rag_*" -o -name "hybrid_*" | wc -l)

echo "Found $TOTAL_DIRS output directories"
echo "Found $OLD_DIRS directories older than 7 days"
echo ""

# Calculate space usage
SPACE_USED=$(du -sh outputs 2>/dev/null | cut -f1)
echo "Current space usage: $SPACE_USED"
echo ""

# Options
echo "Cleanup options:"
echo "1. Remove outputs older than 7 days"
echo "2. Remove outputs older than 1 day"
echo "3. Keep only last 10 outputs per type"
echo "4. Remove all outputs (clean slate)"
echo "5. Cancel"
echo ""

read -p "Select option (1-5): " OPTION

case $OPTION in
    1)
        echo -e "${YELLOW}Removing outputs older than 7 days...${RESET}"
        find outputs -type d -mtime +7 \( -name "universal_*" -o -name "rag_*" -o -name "hybrid_*" \) -exec rm -rf {} + 2>/dev/null
        ;;
    2)
        echo -e "${YELLOW}Removing outputs older than 1 day...${RESET}"
        find outputs -type d -mtime +1 \( -name "universal_*" -o -name "rag_*" -o -name "hybrid_*" \) -exec rm -rf {} + 2>/dev/null
        ;;
    3)
        echo -e "${YELLOW}Keeping only last 10 outputs per type...${RESET}"
        for pattern in "universal_*" "rag_*" "hybrid_*"; do
            dirs=($(find outputs -type d -name "$pattern" | sort -r))
            if [ ${#dirs[@]} -gt 10 ]; then
                for ((i=10; i<${#dirs[@]}; i++)); do
                    rm -rf "${dirs[$i]}"
                done
            fi
        done
        ;;
    4)
        echo -e "${RED}WARNING: This will remove ALL outputs!${RESET}"
        read -p "Are you sure? (yes/no): " CONFIRM
        if [ "$CONFIRM" = "yes" ]; then
            rm -rf outputs/*
            echo -e "${GREEN}All outputs removed.${RESET}"
        else
            echo "Cancelled."
            exit 0
        fi
        ;;
    5)
        echo "Cleanup cancelled."
        exit 0
        ;;
    *)
        echo "Invalid option."
        exit 1
        ;;
esac

# Clean other temporary files
echo ""
echo -e "${YELLOW}Cleaning other temporary files...${RESET}"

# Remove test outputs
find . -name "test_output_*" -type f -mtime +1 -delete 2>/dev/null
find . -name "benchmark_results_*.csv" -type f -mtime +7 -delete 2>/dev/null

# Remove old backups
find . -name "ollama_models_backup_*.txt" -type f -mtime +30 -delete 2>/dev/null
find . -name "chain_backups_*" -type d -mtime +30 -exec rm -rf {} + 2>/dev/null

# Show results
echo ""
echo -e "${GREEN}✅ Cleanup complete!${RESET}"
echo ""

# Show new space usage
NEW_SPACE=$(du -sh outputs 2>/dev/null | cut -f1 || echo "0")
echo "New space usage: $NEW_SPACE"

# Count remaining
REMAINING=$(find outputs -type d \( -name "universal_*" -o -name "rag_*" -o -name "hybrid_*" \) 2>/dev/null | wc -l)
echo "Remaining output directories: $REMAINING"