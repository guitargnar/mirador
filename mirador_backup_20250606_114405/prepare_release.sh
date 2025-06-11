#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <version_number> [release_notes]"
    echo "Example: $0 v1.1 'Added parenting specialist and improved chain reliability'"
    exit 1
fi

VERSION="$1"
NOTES="${2:-Release $VERSION}"

echo "=== Preparing Mirador Release $VERSION ==="

# Ensure we're on main branch
git checkout main

# Ensure working directory is clean
if [ -n "$(git status --porcelain)" ]; then
    echo "Working directory is not clean. Please commit or stash changes first."
    git status
    exit 1
fi

# Run tests
echo "Running system tests..."
./test_model_performance.sh enhanced_agent_fast_v3 "Test release readiness"
./test_model_performance.sh financial_planning_expert_v5 "Test release readiness"

# Create backup
echo "Creating pre-release backup..."
./backup_models.sh

# Update version info
echo "Updating version documentation..."
echo "# Mirador Release $VERSION" > RELEASE_NOTES.md
echo "Date: $(date)" >> RELEASE_NOTES.md
echo "" >> RELEASE_NOTES.md
echo "## Release Notes" >> RELEASE_NOTES.md
echo "$NOTES" >> RELEASE_NOTES.md
echo "" >> RELEASE_NOTES.md
echo "## Model Inventory" >> RELEASE_NOTES.md
cat MODEL_INVENTORY.md >> RELEASE_NOTES.md

git add RELEASE_NOTES.md
git commit -m "Prepare release $VERSION"

# Create release tag
git tag -a "$VERSION" -m "$NOTES"

echo "Release $VERSION prepared successfully"
echo "To push to remote: git push origin main --tags"
