# Mirador Version Control Setup Commands

## Complete Git Repository Initialization

Here are all the bash commands to set up comprehensive version control for your current Mirador system state:

### Step 1: Navigate to Project Directory and Initialize Git
```bash
cd ~/ai_framework_git

# Initialize git repository
git init

# Configure git user (replace with your information)
git config user.name "Matthew Scott"
git config user.email "your.email@example.com"
```

### Step 2: Create Comprehensive .gitignore File
```bash
cat > .gitignore << 'EOF'
# Mirador Output Files
outputs/
chain_*/
temp_*.txt
qa_results/

# System Files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# Virtual Environments
venv/
env/
ENV/
env.bak/
venv.bak/
google-env/

# IDE Files
.vscode/
.idea/
*.swp
*.swo
*~

# Logs
*.log
logs/

# Temporary Files
tmp/
temp/
*.tmp
*.temp

# Backup Files
*.bak
*.backup
*~

# Model Cache (if any)
.ollama/
model_cache/

# Performance Monitoring
performance_*.txt
monitor_*.log
EOF
```

### Step 3: Add All Current Model Files and Documentation
```bash
# Add all model definition files
git add *.modelfile

# Add documentation and configuration files
git add *.md
git add *.sh
git add *.py

# Add any configuration files
git add mirador-*
git add .gitignore

# Check what will be committed
git status
```

### Step 4: Create Initial Commit with Current System State
```bash
# Create initial commit
git commit -m "Initial commit: Mirador v5 production-ready system

- Enhanced Agent Fast V3: Content preservation and strategic enhancement
- Financial Planning Expert V5: Louisville-specific financial guidance
- Louisville Expert V2: Local resource integration
- Chain orchestration achieving 80% reliability
- Validated use cases for personal life automation
- Performance optimized to 20-47 second execution times"
```

### Step 5: Create Version Tags for Current State
```bash
# Tag the current production-ready state
git tag -a v1.0-production -m "Production-ready Mirador system
- 80% reliability achieved
- Financial planning and Louisville expertise validated
- Chain collaboration functional
- Ready for daily personal life automation"

# Create development branch for future improvements
git checkout -b development
git checkout main
```

### Step 6: Create Model Inventory and Documentation
```bash
# Create comprehensive model inventory
cat > MODEL_INVENTORY.md << 'EOF'
# Mirador Model Inventory

## Production Models (v1.0)

### Enhanced Agent Fast V3
- **File**: enhanced_agent_fast_v3.modelfile
- **Status**: Production Ready
- **Purpose**: Strategic enhancement and chain collaboration
- **Performance**: Adds 200-400 words of strategic value
- **Base Model**: llama3.2_balanced

### Financial Planning Expert V5
- **File**: financial_planning_expert_v5.modelfile
- **Status**: Production Ready
- **Purpose**: Louisville-specific financial planning
- **Performance**: Generates 400-600 word comprehensive responses
- **Specialization**: Kentucky taxes, Jefferson County, Louisville market

### Louisville Expert V2
- **File**: louisville_expert_v2.modelfile
- **Status**: Production Ready
- **Purpose**: Local resource integration and guidance
- **Performance**: Accurate local information and contacts
- **Specialization**: JCPS, TARC, Metro Government, local services

## Legacy Models (Deprecated)

### Enhanced Agent Fast V2
- **Status**: Deprecated (content destruction issues)
- **Replaced by**: Enhanced Agent Fast V3

### Financial Planning Expert V1-V4
- **Status**: Deprecated (input processing issues)
- **Replaced by**: Financial Planning Expert V5

## Chain Patterns (Validated)

### Financial Planning Chain
```bash
mirador-ez chain "Create financial plan for Louisville family" financial_planning_expert_v5 enhanced_agent_fast_v3
```

### Local Integration Chain
```bash
mirador-ez chain "Analyze housing options in Louisville" louisville_expert_v2 enhanced_agent_fast_v3
```

### Comprehensive Planning Chain
```bash
mirador-ez chain "Optimize budget and local resources" financial_planning_expert_v5 louisville_expert_v2
```
EOF

git add MODEL_INVENTORY.md
git commit -m "Add comprehensive model inventory and documentation"
```

### Step 7: Create Backup and Recovery Scripts
```bash
# Create model backup script
cat > backup_models.sh << 'EOF'
#!/bin/bash

echo "=== Mirador Model Backup ==="
echo "Timestamp: $(date)"

# Create backup directory
BACKUP_DIR="mirador_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Backup all model files
cp *.modelfile "$BACKUP_DIR/" 2>/dev/null || echo "No .modelfile files found"

# Backup documentation
cp *.md "$BACKUP_DIR/" 2>/dev/null || echo "No .md files found"

# Backup scripts
cp *.sh "$BACKUP_DIR/" 2>/dev/null || echo "No .sh files found"

# Create model list
ollama list > "$BACKUP_DIR/ollama_models.txt"

# Create git status
git status > "$BACKUP_DIR/git_status.txt" 2>/dev/null || echo "Not a git repository"

echo "Backup created in: $BACKUP_DIR"
echo "Files backed up:"
ls -la "$BACKUP_DIR"
EOF

chmod +x backup_models.sh

# Create model restoration script
cat > restore_models.sh << 'EOF'
#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <backup_directory>"
    echo "Available backups:"
    ls -d mirador_backup_* 2>/dev/null || echo "No backups found"
    exit 1
fi

BACKUP_DIR="$1"

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Backup directory $BACKUP_DIR not found"
    exit 1
fi

echo "=== Mirador Model Restoration ==="
echo "Restoring from: $BACKUP_DIR"

# Restore model files
if ls "$BACKUP_DIR"/*.modelfile 1> /dev/null 2>&1; then
    echo "Restoring model files..."
    for modelfile in "$BACKUP_DIR"/*.modelfile; do
        filename=$(basename "$modelfile")
        cp "$modelfile" .
        echo "Restored: $filename"
        
        # Recreate the model in Ollama
        model_name="${filename%.modelfile}"
        echo "Recreating model: $model_name"
        ollama create "$model_name" -f "$filename"
    done
else
    echo "No model files found in backup"
fi

# Restore documentation
if ls "$BACKUP_DIR"/*.md 1> /dev/null 2>&1; then
    echo "Restoring documentation..."
    cp "$BACKUP_DIR"/*.md .
fi

echo "Restoration complete"
EOF

chmod +x restore_models.sh

git add backup_models.sh restore_models.sh
git commit -m "Add backup and recovery scripts for model management"
```

### Step 8: Create Development Workflow Scripts
```bash
# Create model development script
cat > create_new_model.sh << 'EOF'
#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 <model_name> <base_model> [description]"
    echo "Example: $0 parenting_expert llama3.2_balanced 'JCPS and child development specialist'"
    exit 1
fi

MODEL_NAME="$1"
BASE_MODEL="$2"
DESCRIPTION="${3:-New Mirador specialist model}"

echo "=== Creating New Mirador Model ==="
echo "Model Name: $MODEL_NAME"
echo "Base Model: $BASE_MODEL"
echo "Description: $DESCRIPTION"

# Create model file template
cat > "${MODEL_NAME}.modelfile" << MODELEOF
FROM $BASE_MODEL

PARAMETER temperature 0.3
PARAMETER top_p 0.8
PARAMETER num_predict 1500
PARAMETER repeat_penalty 1.1

SYSTEM """You are a specialized expert for the Mirador personal life automation framework.

CORE MISSION: [Define the specific domain expertise and mission]

MIRADOR INTEGRATION:
- Provide actionable, specific recommendations
- Include Louisville/Kentucky context when relevant
- Structure responses for chain collaboration
- Focus on practical implementation guidance

RESPONSE STRUCTURE:
1. [Define appropriate response structure]
2. [Include relevant sections]
3. [End with clear next steps]

EXPERTISE AREAS:
- [List specific areas of expertise]
- [Include local knowledge integration]
- [Define scope and limitations]

You excel at [specific capabilities] while maintaining focus on practical personal life automation."""
MODELEOF

echo "Model file created: ${MODEL_NAME}.modelfile"
echo "Next steps:"
echo "1. Edit the model file to add specific expertise"
echo "2. Create the model: ollama create $MODEL_NAME -f ${MODEL_NAME}.modelfile"
echo "3. Test the model: mirador-ez ask $MODEL_NAME 'test query'"
echo "4. Add to git: git add ${MODEL_NAME}.modelfile && git commit -m 'Add $MODEL_NAME specialist'"
EOF

chmod +x create_new_model.sh

# Create testing script
cat > test_model_performance.sh << 'EOF'
#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <model_name> [test_query]"
    echo "Available models:"
    ollama list | grep -E "(enhanced_agent|financial_planning|louisville_expert)"
    exit 1
fi

MODEL_NAME="$1"
TEST_QUERY="${2:-Quick test of model capabilities and response quality}"

echo "=== Testing Model Performance ==="
echo "Model: $MODEL_NAME"
echo "Query: $TEST_QUERY"
echo "Timestamp: $(date)"
echo ""

# Test individual model performance
echo "Testing individual model response..."
start_time=$(date +%s)
mirador-ez ask "$MODEL_NAME" "$TEST_QUERY" > "test_${MODEL_NAME}_$(date +%Y%m%d_%H%M%S).txt"
end_time=$(date +%s)
duration=$((end_time - start_time))

echo "Response time: ${duration} seconds"
echo "Output saved to: test_${MODEL_NAME}_$(date +%Y%m%d_%H%M%S).txt"

if [ $duration -lt 30 ]; then
    echo "✓ Performance: GOOD (under 30s)"
elif [ $duration -lt 60 ]; then
    echo "⚠ Performance: ACCEPTABLE (30-60s)"
else
    echo "✗ Performance: SLOW (over 60s)"
fi
EOF

chmod +x test_model_performance.sh

git add create_new_model.sh test_model_performance.sh
git commit -m "Add development workflow scripts for model creation and testing"
```

### Step 9: Create Version Management System
```bash
# Create version tracking script
cat > version_info.sh << 'EOF'
#!/bin/bash

echo "=== Mirador System Version Information ==="
echo "Timestamp: $(date)"
echo ""

echo "Git Repository Status:"
git status --porcelain
echo ""

echo "Current Branch:"
git branch --show-current
echo ""

echo "Latest Commits:"
git log --oneline -5
echo ""

echo "Version Tags:"
git tag -l
echo ""

echo "Production Models:"
ls -la *.modelfile 2>/dev/null || echo "No model files found"
echo ""

echo "Ollama Models:"
ollama list | grep -E "(enhanced_agent|financial_planning|louisville_expert)" || echo "No Mirador models found in Ollama"
echo ""

echo "System Health Check:"
if command -v mirador-ez &> /dev/null; then
    echo "✓ mirador-ez command available"
else
    echo "✗ mirador-ez command not found"
fi

if command -v ollama &> /dev/null; then
    echo "✓ ollama command available"
else
    echo "✗ ollama command not found"
fi
EOF

chmod +x version_info.sh

# Create release preparation script
cat > prepare_release.sh << 'EOF'
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
EOF

chmod +x prepare_release.sh

git add version_info.sh prepare_release.sh
git commit -m "Add version management and release preparation scripts"
```

### Step 10: Create Remote Repository Setup (Optional)
```bash
# Create script for setting up remote repository
cat > setup_remote.sh << 'EOF'
#!/bin/bash

echo "=== Setting Up Remote Repository ==="
echo "This script helps you connect your local Mirador repository to a remote Git service"
echo ""

echo "Choose your Git service:"
echo "1. GitHub"
echo "2. GitLab"
echo "3. Custom Git server"
echo "4. Skip remote setup"

read -p "Enter choice (1-4): " choice

case $choice in
    1)
        echo "GitHub Setup:"
        echo "1. Create a new private repository on GitHub named 'mirador-personal'"
        echo "2. Copy the repository URL (e.g., git@github.com:username/mirador-personal.git)"
        read -p "Enter GitHub repository URL: " repo_url
        ;;
    2)
        echo "GitLab Setup:"
        echo "1. Create a new private repository on GitLab named 'mirador-personal'"
        echo "2. Copy the repository URL (e.g., git@gitlab.com:username/mirador-personal.git)"
        read -p "Enter GitLab repository URL: " repo_url
        ;;
    3)
        echo "Custom Git Server Setup:"
        read -p "Enter custom Git repository URL: " repo_url
        ;;
    4)
        echo "Skipping remote setup"
        exit 0
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

if [ -n "$repo_url" ]; then
    echo "Adding remote repository..."
    git remote add origin "$repo_url"
    
    echo "Pushing to remote repository..."
    git push -u origin main
    git push origin --tags
    
    echo "Remote repository setup complete!"
    echo "Repository URL: $repo_url"
else
    echo "No repository URL provided"
fi
EOF

chmod +x setup_remote.sh

git add setup_remote.sh
git commit -m "Add remote repository setup script"
```

### Step 11: Final System Verification
```bash
# Run final verification
echo "=== Final Verification ==="

# Check git status
echo "Git repository status:"
git status

# Show commit history
echo ""
echo "Commit history:"
git log --oneline -10

# Show tags
echo ""
echo "Version tags:"
git tag -l

# Show file structure
echo ""
echo "Repository structure:"
find . -name "*.modelfile" -o -name "*.md" -o -name "*.sh" | grep -v ".git" | sort

# Create final summary
echo ""
echo "=== Version Control Setup Complete ==="
echo "✓ Git repository initialized"
echo "✓ .gitignore configured for Mirador"
echo "✓ All model files and documentation committed"
echo "✓ Production version tagged as v1.0-production"
echo "✓ Backup and recovery scripts created"
echo "✓ Development workflow scripts added"
echo "✓ Version management system implemented"
echo ""
echo "Your Mirador system is now under version control!"
echo "Use './version_info.sh' to check system status anytime"
```

## Summary of Created Files

The version control setup creates these key files:
- `.gitignore` - Excludes temporary and output files
- `MODEL_INVENTORY.md` - Comprehensive model documentation
- `backup_models.sh` - Backup script for models and configs
- `restore_models.sh` - Recovery script for system restoration
- `create_new_model.sh` - Template for new model development
- `test_model_performance.sh` - Model testing and validation
- `version_info.sh` - System status and version information
- `prepare_release.sh` - Release management and tagging
- `setup_remote.sh` - Remote repository configuration

Your Mirador system is now fully version controlled and ready for continued development!

