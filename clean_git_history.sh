#!/bin/bash
# Clean Git history to remove sensitive files permanently
# This script uses BFG Repo-Cleaner (if available) or git filter-branch

set -euo pipefail

echo "🔒 Cleaning Git history to remove sensitive files permanently..."
echo ""
echo "⚠️  WARNING: This will rewrite Git history!"
echo "Make sure you have backed up your repository."
echo ""
read -p "Continue? (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

# List of files to remove from history
FILES_TO_REMOVE=(
    "*.xlsx"
    "*financial*.txt"
    "*humana*"
    "*company*"
    "comprehensive_financial_*"
    "FINAL_*Analysis*.xlsx"
    "MASTER_Financial_*.xlsx"
    "CORRECTED_*Analysis*.xlsx"
)

# Check if BFG is available
if command -v bfg &> /dev/null; then
    echo "Using BFG Repo-Cleaner (faster)..."
    
    # Create patterns file for BFG
    echo "Creating patterns file..."
    cat > .bfg-patterns.txt <<EOF
*.xlsx
*financial*.txt
*humana*
comprehensive_financial_*
FINAL_*Analysis*.xlsx
MASTER_Financial_*.xlsx
CORRECTED_*Analysis*.xlsx
EOF
    
    # Run BFG to remove files
    bfg --delete-files .bfg-patterns.txt --no-blob-protection
    
    # Clean up
    rm .bfg-patterns.txt
    
else
    echo "BFG not found. Using git filter-branch (slower)..."
    echo "Consider installing BFG for faster cleaning: brew install bfg"
    echo ""
    
    # Build filter-branch command
    FILTER_CMD=""
    for pattern in "${FILES_TO_REMOVE[@]}"; do
        if [ -z "$FILTER_CMD" ]; then
            FILTER_CMD="git rm --cached --ignore-unmatch '$pattern'"
        else
            FILTER_CMD="$FILTER_CMD; git rm --cached --ignore-unmatch '$pattern'"
        fi
    done
    
    # Run filter-branch
    git filter-branch --force --index-filter "$FILTER_CMD" \
        --prune-empty --tag-name-filter cat -- --all
fi

echo ""
echo "🧹 Cleaning up..."

# Clean up refs and garbage collect
git reflog expire --expire=now --all
git gc --prune=now --aggressive

echo ""
echo "📊 Repository size comparison:"
echo "Before: $(du -sh .git | cut -f1)"

# Force garbage collection
git repack -a -d -f --depth=250 --window=250

echo "After: $(du -sh .git | cut -f1)"

echo ""
echo "✅ Git history cleaned!"
echo ""
echo "⚠️  IMPORTANT NEXT STEPS:"
echo "1. Force push to remote: git push --force --all"
echo "2. Force push tags: git push --force --tags"
echo "3. Tell all collaborators to re-clone the repository"
echo "4. Delete any backups containing sensitive data"
echo ""
echo "Note: The old commits still exist in any existing clones."
echo "Everyone must delete their local repos and re-clone."