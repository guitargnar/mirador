#!/usr/bin/env bash
# Mirador Setup Script

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}Mirador AI Framework Setup${NC}"
echo "------------------------------"

# Check prerequisites
echo -e "${YELLOW}Checking prerequisites...${NC}"

# Check for jq
if ! command -v jq &> /dev/null; then
  echo -e "${RED}Error: jq is required but not installed.${NC}"
  echo "Please install it with: brew install jq"
  exit 1
fi

# Check for curl
if ! command -v curl &> /dev/null; then
  echo -e "${RED}Error: curl is required but not installed.${NC}"
  echo "Please install it with: brew install curl"
  exit 1
fi

# Check for Ollama
if ! command -v ollama &> /dev/null; then
  echo -e "${RED}Error: Ollama is required but not installed.${NC}"
  echo "Please install it from: https://ollama.ai/download"
  exit 1
fi

echo -e "${GREEN}✓ All prerequisites satisfied${NC}"

# Create directory structure
echo -e "${YELLOW}Setting up directory structure...${NC}"

# Ensure all directories exist
mkdir -p "$ROOT_DIR/config"
mkdir -p "$ROOT_DIR/logs"
mkdir -p "$ROOT_DIR/outputs"
mkdir -p "$ROOT_DIR/templates"

# Create necessary placeholders
touch "$ROOT_DIR/outputs/.gitkeep"
touch "$ROOT_DIR/logs/.gitkeep"

echo -e "${GREEN}✓ Directory structure created${NC}"

# Copy model files
echo -e "${YELLOW}Setting up model files...${NC}"
mkdir -p "$ROOT_DIR/src/models/optimized"

# Create directory for outputs by category
for dir in career_plans financial_plans guitar_learning business_strategies debug_logs; do
  mkdir -p "$ROOT_DIR/outputs/$dir"
  touch "$ROOT_DIR/outputs/$dir/.gitkeep"
done

echo -e "${GREEN}✓ Output directories created${NC}"

# Make scripts executable
echo -e "${YELLOW}Making scripts executable...${NC}"
find "$ROOT_DIR/scripts" -name "*.sh" -exec chmod +x {} \;
find "$ROOT_DIR/src" -name "*.sh" -exec chmod +x {} \;

echo -e "${GREEN}✓ Scripts are now executable${NC}"

# Create shell aliases (if they don't already exist)
echo -e "${YELLOW}Setting up shell aliases...${NC}"
ALIASES_FILE="$ROOT_DIR/config/mirador_aliases.sh"

cat > "$ALIASES_FILE" << 'EOF'
# Mirador lifestyle augmentation aliases
alias plan-day="$HOME/ai_framework_git/scripts/run_workflow.sh tasks"
alias plan-finances="$HOME/ai_framework_git/scripts/run_workflow.sh finance"
alias plan-practice="$HOME/ai_framework_git/scripts/run_workflow.sh practice"
alias plan-career="$HOME/ai_framework_git/scripts/run_workflow.sh career"
EOF

chmod +x "$ALIASES_FILE"

echo -e "${GREEN}✓ Shell aliases created at: $ALIASES_FILE${NC}"
echo -e "${YELLOW}Add this to your shell config (.zshrc or .bashrc):${NC}"
echo "  source $ALIASES_FILE"

# Final setup message
echo -e "\n${GREEN}Mirador AI Framework setup complete!${NC}"
echo -e "${BLUE}Next steps:${NC}"
echo "1. Add the aliases to your shell config"
echo "2. Build optimized models (see docs/MODELS.md)"
echo "3. Try running a chain: ./scripts/run_chain.sh \"Your prompt\" model1 model2"
echo ""

exit 0
