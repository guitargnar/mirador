#!/bin/bash
# Remove all personal information from public repository

echo "🔒 Removing personal information from repository..."

# Remove personal story file
rm -f docs/personal/PERSONAL_STORY.md

# Create anonymized modelfiles
echo "📝 Anonymizing model files..."
find models/ -name "*.modelfile" -type f | while read file; do
    if grep -q -i "user\|sage\|katie\|carey\|angela\|peter\|jon foster" "$file" 2>/dev/null; then
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
            -e 's/parent/parent/g' \
            -e 's/\modest income/modest income/g' \
            -e 's/\home equity/home equity/g' \
            -e 's/ACL\/MCL injury/injury/g' \
            -e 's/past experiences/past experiences/g' \
            -e 's/challenging background/challenging background/g' \
            "$file"
        echo "  ✓ Anonymized: $file"
    fi
done

# Check Python files
echo "📝 Checking Python files..."
find src/ -name "*.py" -type f | while read file; do
    if grep -q -i "user\|sage\|katie" "$file" 2>/dev/null; then
        sed -i '' \
            -e 's/User/User/g' \
            -e 's/user/user/g' \
            -e 's/User/User/g' \
            "$file"
        echo "  ✓ Anonymized: $file"
    fi
done

# Update CLAUDE.md
if [ -f "CLAUDE.md" ]; then
    echo "📝 Updating CLAUDE.md..."
    sed -i '' \
        -e 's/contact@example.com/contact@example.com/g' \
        -e 's/User/User/g' \
        "$file"
fi

# Create professional model descriptions
cat > models/README.md << 'EOF'
# Mirador Model Library

This directory contains specialized AI models for the Mirador framework.

## Model Categories

### Core Models
- Context providers for maintaining conversation state
- Base models with framework-specific prompts

### Domain Models  
- Business and career planning
- Creative and artistic projects
- Technical problem solving
- Health and wellness optimization
- Financial planning
- Relationship dynamics

### Personal Context Models
- User-specific context models (customize for your needs)
- Example templates provided

## Creating Personal Models

To create models with your personal context:

1. Copy a template from `models/templates/`
2. Replace generic placeholders with your information
3. Create the model: `ollama create your_model -f your_modelfile`

## Privacy Note

The models in this repository are generic templates. Personal information should be added only to your local copies, never committed to version control.
EOF

echo ""
echo "✅ Personal information removed!"
echo ""
echo "Next steps:"
echo "1. Review changes: git diff"
echo "2. Commit: git commit -am 'Remove personal information for public repository'"
echo "3. Push: git push origin main"