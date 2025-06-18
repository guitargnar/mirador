

if [ $
    echo "Usage: $0 <version_number> [release_notes]"
    echo "Example: $0 v1.1 'Added parenting specialist and improved chain reliability'"
    exit 1
fi

VERSION="$1"
NOTES="${2:-Release $VERSION}"

echo "=== Preparing Mirador Release $VERSION ==="


git checkout main


if [ -n "$(git status --porcelain)" ]; then
    echo "Working directory is not clean. Please commit or stash changes first."
    git status
    exit 1
fi


echo "Running system tests..."
./test_model_performance.sh enhanced_agent_fast_v3 "Test release readiness"
./test_model_performance.sh financial_planning_expert_v5 "Test release readiness"


echo "Creating pre-release backup..."
./backup_models.sh


echo "Updating version documentation..."
echo "
echo "Date: $(date)" >> RELEASE_NOTES.md
echo "" >> RELEASE_NOTES.md
echo "
echo "$NOTES" >> RELEASE_NOTES.md
echo "" >> RELEASE_NOTES.md
echo "
cat MODEL_INVENTORY.md >> RELEASE_NOTES.md

git add RELEASE_NOTES.md
git commit -m "Prepare release $VERSION"


git tag -a "$VERSION" -m "$NOTES"

echo "Release $VERSION prepared successfully"
echo "To push to remote: git push origin main --tags"
