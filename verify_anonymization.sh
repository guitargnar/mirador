#!/bin/bash
# Verify all personal information has been removed

echo "🔍 Verifying anonymization..."

# Define personal terms to check
PERSONAL_TERMS=(
    "userdscott7"
    "userdscott7"
    "your-profile"
    "your-username"
    "User"
    "Child"
    "Partner"
    "Co-parent"
    "Family Member"
    "Family Member"
    "Manager"
    "Company"
    "\modest income"
    "\home equity"
)

# Define files/directories to exclude
EXCLUDE_DIRS=(
    ".git"
    "archive"
    "backup"
    "venv"
    "node_modules"
    ".pytest_cache"
    "__pycache__"
)

# Build exclude pattern
EXCLUDE_PATTERN=""
for dir in "${EXCLUDE_DIRS[@]}"; do
    EXCLUDE_PATTERN="$EXCLUDE_PATTERN -path ./$dir -prune -o"
done

echo "Checking for personal information..."
FOUND_ISSUES=0

for term in "${PERSONAL_TERMS[@]}"; do
    echo -n "Checking for '$term'... "
    
    # Search for the term
    results=$(find . $EXCLUDE_PATTERN -type f -name "*.py" -o -name "*.sh" -o -name "*.md" -o -name "*.txt" -o -name "*.json" -o -name "*.yaml" -o -name "*.yml" -o -name "*.modelfile" | xargs grep -l "$term" 2>/dev/null | grep -v "verify_anonymization.sh" | grep -v "remove_personal_info.sh")
    
    if [ -z "$results" ]; then
        echo "✅ Clean"
    else
        echo "❌ Found in:"
        echo "$results" | sed 's/^/    /'
        FOUND_ISSUES=1
    fi
done

echo ""
if [ $FOUND_ISSUES -eq 0 ]; then
    echo "✅ All personal information has been removed!"
    echo ""
    echo "The repository is ready for public sharing."
else
    echo "❌ Personal information still found in some files."
    echo ""
    echo "Please run: ./remove_personal_info.sh"
    echo "Or manually edit the files listed above."
fi