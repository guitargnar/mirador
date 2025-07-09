#!/bin/bash
# Organize Mirador repository structure

echo "🧹 Organizing Mirador repository..."

# Create directory structure
mkdir -p models/{core,domain,personal,experimental}
mkdir -p scripts/{chains,analysis,utilities,setup}
mkdir -p docs/{technical,guides,personal}
mkdir -p src/{core,utils,dashboard}
mkdir -p archive/{old_outputs,conversation_logs}

# Move modelfiles
echo "📁 Organizing model files..."
mv *.modelfile models/domain/ 2>/dev/null || true
mv models/domain/matthew_*.modelfile models/personal/ 2>/dev/null || true
mv models/domain/*context*.modelfile models/core/ 2>/dev/null || true

# Move Python files
echo "📁 Organizing Python files..."
mv advocates*.py src/core/ 2>/dev/null || true
mv *dashboard*.py src/dashboard/ 2>/dev/null || true
mv *analyzer*.py src/utils/ 2>/dev/null || true
mv *tracker*.py src/utils/ 2>/dev/null || true

# Move shell scripts
echo "📁 Organizing shell scripts..."
# Keep main runners in root
mv *chain*.sh scripts/chains/ 2>/dev/null || true
mv *test*.sh scripts/utilities/ 2>/dev/null || true
mv *analysis*.sh scripts/analysis/ 2>/dev/null || true
mv *check*.sh scripts/utilities/ 2>/dev/null || true

# Move documentation
echo "📁 Organizing documentation..."
mv MIRADOR_*.md docs/technical/ 2>/dev/null || true
mv *GUIDE*.md docs/guides/ 2>/dev/null || true
mv *README*.md docs/guides/ 2>/dev/null || true
mv README.md . 2>/dev/null || true  # Keep main README in root

# Move old outputs
echo "📁 Archiving old outputs..."
find outputs -type f -mtime +7 -exec mv {} archive/old_outputs/ \; 2>/dev/null || true

# Move JSON files
echo "📁 Organizing data files..."
mkdir -p data
mv *.json data/ 2>/dev/null || true

# Clean up
echo "📁 Final cleanup..."
mv *.txt archive/ 2>/dev/null || true
mv *.log archive/ 2>/dev/null || true

echo "✅ Organization complete!"
echo ""
echo "New structure:"
echo "  models/     - AI model definitions"
echo "  scripts/    - Utility scripts" 
echo "  docs/       - Documentation"
echo "  src/        - Python source code"
echo "  data/       - Configuration and data files"
echo "  archive/    - Old files and logs"