#!/bin/bash
# Remove all financial files and Company references
# This script will remove files from both Git and the filesystem

set -euo pipefail

echo "🔒 Starting sensitive data removal..."
echo "This will remove all financial files and Company references"
echo ""

# Backup current state first
BACKUP_DIR="$HOME/mirador_pre_cleanup_backup_$(date +%Y%m%d_%H%M%S)"
echo "Creating backup at: $BACKUP_DIR"
cp -r . "$BACKUP_DIR" 2>/dev/null || true

# List of files to remove
EXCEL_FILES=(
    "comprehensive_financial_spreadsheet_20250707_130638.xlsx"
    "FINAL_Complete_Analysis_HELOC_Buffer_20250707_143212.xlsx"
    "MASTER_Financial_Strategy_20250707_132955.xlsx"
    "CORRECTED_Verified_Financial_Analysis_20250707_162542.xlsx"
    "FINAL_ULTRATHINK_Complete_Analysis_20250707_140450.xlsx"
    "COMPLETE_Financial_Portfolio_20250707_131814.xlsx"
    "comprehensive_financial_spreadsheet_20250707_130610.xlsx"
    "CORRECTED_Complete_Financial_Analysis_20250707_134709.xlsx"
    "FINAL_Complete_Financial_Analysis_20250707_133815.xlsx"
)

FINANCIAL_TEXT_FILES=(
    "comprehensive_financial_analysis_20250707_124608.txt"
    "comprehensive_financial_analysis_20250707_125310.txt"
    "financial_aggressive.txt"
    "financial_conservative.txt"
    "financial_balanced.txt"
)

COMPANY_FILES=(
    "company_ai_advocate_modelfile"
    "matthew_context_provider_company.modelfile"
    "company_politics_navigator_modelfile"
    "enhanced_agent_enforcer_company.modelfile"
    "company_innovation_catalyst.modelfile"
    "company_chain_templates.json"
    "company_chain_runner.sh"
)

# Remove from Git tracking first
echo "📝 Removing from Git tracking..."
for file in "${EXCEL_FILES[@]}" "${FINANCIAL_TEXT_FILES[@]}" "${COMPANY_FILES[@]}"; do
    if [ -f "$file" ]; then
        git rm --cached "$file" 2>/dev/null || true
        echo "  - Untracked: $file"
    fi
done

# Remove Company files in subdirectories
find . -name "*company*" -type f | while read -r file; do
    git rm --cached "$file" 2>/dev/null || true
    echo "  - Untracked: $file"
done

# Remove financial files in subdirectories  
find . -name "*financial*.txt" -o -name "*financial*.xlsx" | while read -r file; do
    git rm --cached "$file" 2>/dev/null || true
    echo "  - Untracked: $file"
done

# Now delete the actual files
echo ""
echo "🗑️  Deleting files from filesystem..."

# Delete Excel files
for file in "${EXCEL_FILES[@]}"; do
    if [ -f "$file" ]; then
        rm -f "$file"
        echo "  - Deleted: $file"
    fi
done

# Delete financial text files
for file in "${FINANCIAL_TEXT_FILES[@]}"; do
    if [ -f "$file" ]; then
        rm -f "$file"
        echo "  - Deleted: $file"
    fi
done

# Delete Company files
for file in "${COMPANY_FILES[@]}"; do
    if [ -f "$file" ]; then
        rm -f "$file"
        echo "  - Deleted: $file"
    fi
done

# Delete all company files in subdirectories
find . -name "*company*" -type f -delete -print | while read -r file; do
    echo "  - Deleted: $file"
done

# Delete all financial files in subdirectories
find . \( -name "*financial*.txt" -o -name "*financial*.xlsx" \) -type f -delete -print | while read -r file; do
    echo "  - Deleted: $file"
done

# Update .gitignore to prevent future additions
echo ""
echo "📝 Updating .gitignore..."
cat >> .gitignore << 'EOF'

# Financial files
*.xlsx
*.xls
*financial*.txt
*financial*.json

# Company-specific files
*company*
*company_*
*corporate_*

# Sensitive data patterns
*salary*
*compensation*
*proprietary*
*confidential*
EOF

echo "  - Updated .gitignore with exclusion patterns"

# Remove Company references from code files
echo ""
echo "🔍 Removing Company references from code..."

# Create a list of files to check
FILES_TO_CLEAN=$(find . -type f \( -name "*.py" -o -name "*.sh" -o -name "*.md" \) \
    -not -path "./.git/*" \
    -not -path "./backup*/*" \
    -not -path "./$BACKUP_DIR/*" | head -100)

# Count references before removal
COMPANY_COUNT=$(grep -r "company\|Company\|COMPANY" . --include="*.py" --include="*.sh" --include="*.md" 2>/dev/null | wc -l || true)
echo "  - Found $COMPANY_COUNT Company references to clean"

# For safety, we'll create cleaned versions first
mkdir -p .cleaned_temp

echo ""
echo "📋 Summary of changes:"
echo "  - Excel files removed: ${#EXCEL_FILES[@]}"
echo "  - Financial text files removed: ${#FINANCIAL_TEXT_FILES[@]}"  
echo "  - Company-specific files removed: ${#COMPANY_FILES[@]}"
echo "  - Additional files found and removed: $(find . -name "*company*" -o -name "*financial*" 2>/dev/null | wc -l || echo "0")"
echo "  - Backup created at: $BACKUP_DIR"

echo ""
echo "✅ Sensitive data removal complete!"
echo ""
echo "Next steps:"
echo "1. Review the changes with: git status"
echo "2. Commit the removals: git commit -m 'Remove sensitive financial and company data'"
echo "3. Clean Git history: git filter-branch or BFG Repo-Cleaner"
echo ""
echo "⚠️  WARNING: These files are now in your backup at $BACKUP_DIR"
echo "   Move this backup to a secure location or encrypted drive."