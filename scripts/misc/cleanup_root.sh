#!/bin/bash
# Clean up root directory to match professional repository standards

echo "🧹 Creating minimal root directory..."

# Move all markdown docs except README, LICENSE, CHANGELOG
mkdir -p docs/archive
mv *.md docs/archive/ 2>/dev/null || true
mv docs/archive/README.md . 2>/dev/null || true
mv docs/archive/LICENSE.md . 2>/dev/null || true
mv docs/archive/CHANGELOG.md . 2>/dev/null || true
mv docs/archive/CONTRIBUTING.md . 2>/dev/null || true

# Move all Python files except main entry point
mkdir -p src/tools
mv mirador*.py src/tools/ 2>/dev/null || true
mv src/tools/mirador.py . 2>/dev/null || true  # Keep main entry point

# Move all shell scripts except critical ones
mkdir -p bin
mv mirador*.sh bin/ 2>/dev/null || true
# Keep only the main runner and setup in root
mv bin/mirador_universal_runner_v2.sh . 2>/dev/null || true
mv bin/mirador-smart-v2 . 2>/dev/null || true
mv bin/setup_mirador.sh . 2>/dev/null || true

# Create proper Python package structure
touch src/__init__.py
touch src/tools/__init__.py

# Move any remaining scripts
mv *.sh scripts/misc/ 2>/dev/null || true
mv *.py src/misc/ 2>/dev/null || true

# Restore essential files
mv scripts/misc/setup_mirador.sh . 2>/dev/null || true

echo "✅ Root cleanup complete!"