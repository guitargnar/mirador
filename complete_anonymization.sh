#!/bin/bash
# Complete anonymization of all personal information

echo "🔒 Running complete anonymization..."

# Function to anonymize a file
anonymize_file() {
    local file=$1
    echo "  Anonymizing: $file"
    
    # Create backup
    cp "$file" "$file.bak"
    
    # Perform replacements
    sed -i '' \
        -e 's/User/User/g' \
        -e 's/user/user/g' \
        -e 's/User/User/g' \
        -e 's/Child/Child/g' \
        -e 's/Partner/Partner/g' \
        -e 's/Co-parent/Co-parent/g' \
        -e 's/Family Member/Family Member/g' \
        -e 's/Family Member/Family Member/g' \
        -e 's/Manager/Manager/g' \
        -e 's/userdscott7@gmail\.com/contact@example.com/g' \
        -e 's/userdscott7@gmail\.com/contact@example.com/g' \
        -e 's/your-profile/your-profile/g' \
        -e 's/your-username/your-username/g' \
        -e 's/Company/Company/g' \
        -e 's/\modest income/modest income/g' \
        -e 's/\home equity/home equity/g' \
        -e 's/\home equity/home equity/g' \
        -e 's/city/city/g' \
        -e 's/state/state/g' \
        -e 's/ACL\/MCL injury/injury/g' \
        -e 's/past experiences/past experiences/g' \
        -e 's/challenging background/challenging background/g' \
        -e 's/parent/parent/g' \
        -e 's/separated/separated/g' \
        "$file"
    
    # Check if file changed
    if cmp -s "$file" "$file.bak"; then
        rm "$file.bak"
    else
        echo "    ✓ Updated"
        rm "$file.bak"
    fi
}

# Find and process all relevant files
echo "Processing files..."

# Python files
find . -path ./venv -prune -o -path ./archive -prune -o -path ./.git -prune -o -name "*.py" -type f -print | while read file; do
    if grep -q -E "User|Child|Partner|Co-parent|Family Member|Family Member|Manager|Company|userdscott7|userdscott7|your-profile|your-username|\\\modest income|\\\home equity" "$file" 2>/dev/null; then
        anonymize_file "$file"
    fi
done

# Shell scripts
find . -path ./venv -prune -o -path ./archive -prune -o -path ./.git -prune -o -name "*.sh" -type f -print | while read file; do
    if grep -q -E "User|Child|Partner|Co-parent|Family Member|Family Member|Manager|Company|userdscott7|userdscott7|your-profile|your-username|\\\modest income|\\\home equity" "$file" 2>/dev/null; then
        anonymize_file "$file"
    fi
done

# Markdown files
find . -path ./venv -prune -o -path ./archive -prune -o -path ./.git -prune -o -name "*.md" -type f -print | while read file; do
    if grep -q -E "User|Child|Partner|Co-parent|Family Member|Family Member|Manager|Company|userdscott7|userdscott7|your-profile|your-username|\\\modest income|\\\home equity" "$file" 2>/dev/null; then
        anonymize_file "$file"
    fi
done

# Modelfiles
find . -path ./venv -prune -o -path ./archive -prune -o -path ./.git -prune -o -name "*.modelfile" -type f -print | while read file; do
    if grep -q -E "User|Child|Partner|Co-parent|Family Member|Family Member|Manager|Company|userdscott7|userdscott7|your-profile|your-username|\\\modest income|\\\home equity" "$file" 2>/dev/null; then
        anonymize_file "$file"
    fi
done

echo ""
echo "✅ Complete anonymization finished!"
echo ""
echo "Running verification..."
./verify_anonymization.sh