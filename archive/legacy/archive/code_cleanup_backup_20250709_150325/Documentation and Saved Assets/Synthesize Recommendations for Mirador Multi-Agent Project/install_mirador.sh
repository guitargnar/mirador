#!/bin/bash

# Mirador Installation Script
# Sets up the complete Mirador AI orchestration system

echo "🎭 Mirador AI Orchestration System Installation"
echo "=============================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() { echo -e "${BLUE}$1${NC}"; }
print_success() { echo -e "${GREEN}$1${NC}"; }
print_warning() { echo -e "${YELLOW}$1${NC}"; }
print_error() { echo -e "${RED}$1${NC}"; }

# Check prerequisites
echo "🔍 Checking prerequisites..."

# Check if Ollama is installed
if ! command -v ollama &> /dev/null; then
    print_error "❌ Ollama not found"
    echo ""
    echo "Please install Ollama first:"
    echo "  macOS: brew install ollama"
    echo "  Linux: curl -fsSL https://ollama.ai/install.sh | sh"
    echo ""
    echo "Then start the service: ollama serve"
    exit 1
fi

print_success "✅ Ollama found"

# Check if Ollama service is running
if ! ollama list &> /dev/null; then
    print_warning "⚠️  Ollama service not running"
    echo "Starting Ollama service..."
    
    # Try to start Ollama in background
    if command -v brew &> /dev/null; then
        # macOS with Homebrew
        brew services start ollama
    else
        # Linux - start in background
        nohup ollama serve > /dev/null 2>&1 &
        sleep 3
    fi
    
    # Check again
    if ! ollama list &> /dev/null; then
        print_error "❌ Could not start Ollama service"
        echo "Please start manually: ollama serve"
        exit 1
    fi
fi

print_success "✅ Ollama service running"

# Check Python
if ! command -v python3 &> /dev/null; then
    print_error "❌ Python 3 not found"
    echo "Please install Python 3.7 or later"
    exit 1
fi

print_success "✅ Python 3 found"

echo ""

# Set up directory structure
MIRADOR_DIR="$HOME/ai_framework_git"
print_status "📁 Setting up directory structure..."

mkdir -p "$MIRADOR_DIR"
mkdir -p "$MIRADOR_DIR/outputs"
mkdir -p "$MIRADOR_DIR/models"

print_success "✅ Directory structure created"

# Copy files if running from different location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$SCRIPT_DIR" != "$MIRADOR_DIR" ]; then
    print_status "📋 Copying Mirador files..."
    
    # Copy core files
    cp "$SCRIPT_DIR/mirador.py" "$MIRADOR_DIR/" 2>/dev/null || true
    cp "$SCRIPT_DIR/mirador-ez" "$MIRADOR_DIR/" 2>/dev/null || true
    cp "$SCRIPT_DIR/create_core_models.sh" "$MIRADOR_DIR/" 2>/dev/null || true
    
    # Make executable
    chmod +x "$MIRADOR_DIR/mirador.py" 2>/dev/null || true
    chmod +x "$MIRADOR_DIR/mirador-ez" 2>/dev/null || true
    chmod +x "$MIRADOR_DIR/create_core_models.sh" 2>/dev/null || true
    
    print_success "✅ Files copied to $MIRADOR_DIR"
fi

# Install mirador-ez globally
print_status "🔗 Installing mirador-ez command globally..."

# Create symlink in /usr/local/bin if it exists and is writable
if [ -d "/usr/local/bin" ] && [ -w "/usr/local/bin" ]; then
    ln -sf "$MIRADOR_DIR/mirador-ez" "/usr/local/bin/mirador-ez"
    print_success "✅ mirador-ez installed to /usr/local/bin"
elif sudo -n true 2>/dev/null; then
    # Can sudo without password
    sudo ln -sf "$MIRADOR_DIR/mirador-ez" "/usr/local/bin/mirador-ez"
    print_success "✅ mirador-ez installed to /usr/local/bin (with sudo)"
else
    # Add to user's local bin
    mkdir -p "$HOME/.local/bin"
    ln -sf "$MIRADOR_DIR/mirador-ez" "$HOME/.local/bin/mirador-ez"
    
    # Add to PATH if not already there
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc" 2>/dev/null || true
        print_warning "⚠️  Added $HOME/.local/bin to PATH"
        print_warning "   Please restart your terminal or run: source ~/.bashrc"
    fi
    
    print_success "✅ mirador-ez installed to $HOME/.local/bin"
fi

echo ""

# Create core models
print_status "🤖 Creating core AI models..."
cd "$MIRADOR_DIR"

if [ -f "create_core_models.sh" ]; then
    ./create_core_models.sh
else
    print_error "❌ Model creation script not found"
    exit 1
fi

echo ""

# Create basic configuration
print_status "⚙️  Creating configuration..."

cat > "$MIRADOR_DIR/config.json" << 'EOF'
{
    "version": "1.0.0",
    "base_dir": "~/ai_framework_git",
    "default_timeout": 60,
    "max_chain_length": 6,
    "core_models": [
        "matthew_context_provider_v2",
        "enhanced_agent_enforcer_v2", 
        "decision_simplifier_v2",
        "financial_planning_expert_v6",
        "louisville_expert_v3",
        "mirador_system_specialist_v2"
    ],
    "chain_configs": {
        "financial": ["matthew_context_provider_v2", "financial_planning_expert_v6", "decision_simplifier_v2"],
        "career": ["matthew_context_provider_v2", "enhanced_agent_enforcer_v2", "decision_simplifier_v2"],
        "louisville": ["matthew_context_provider_v2", "louisville_expert_v3", "decision_simplifier_v2"],
        "comprehensive": ["matthew_context_provider_v2", "mirador_system_specialist_v2", "enhanced_agent_enforcer_v2", "decision_simplifier_v2"]
    }
}
EOF

print_success "✅ Configuration created"

# Create README
print_status "📚 Creating documentation..."

cat > "$MIRADOR_DIR/README.md" << 'EOF'
# Mirador AI Orchestration System

## Quick Start

### Basic Commands
```bash
# Check system status
mirador-ez status

# Ask a single model
mirador-ez ask matthew_context_provider_v2 "What should I focus on today?"

# Run intelligent chain (auto-selects models)
mirador-ez chain "Investment opportunities this week"

# Run custom chain
mirador-ez chain "Career strategy" matthew_context_provider_v2 enhanced_agent_enforcer_v2
```

### Core Models
- `matthew_context_provider_v2` - Personal context and values alignment
- `enhanced_agent_enforcer_v2` - Strategic implementation and analysis
- `decision_simplifier_v2` - Action-focused synthesis
- `financial_planning_expert_v6` - Louisville-specific financial guidance
- `louisville_expert_v3` - Local market intelligence
- `mirador_system_specialist_v2` - System optimization

### Chain Types
- **Financial**: Automatically selected for money/investment queries
- **Career**: Automatically selected for job/business queries  
- **Louisville**: Automatically selected for local/community queries
- **Comprehensive**: Automatically selected for complex analysis
- **Standard**: Default chain for general queries

### Output Management
All chain executions create timestamped directories in `outputs/` with:
- Individual model outputs
- Comprehensive summary
- Execution metadata
- Performance metrics

### Troubleshooting
```bash
# Check system health
mirador-ez status

# List available models
mirador-ez models

# Test core functionality
python3 mirador.py status
```

For issues, check that Ollama is running: `ollama serve`
EOF

print_success "✅ Documentation created"

echo ""
echo "🎉 Mirador Installation Complete!"
echo "================================="
echo ""
print_success "✅ Core orchestration engine installed"
print_success "✅ 6 specialist models created and tested"
print_success "✅ mirador-ez command available globally"
print_success "✅ Configuration and documentation ready"
echo ""
echo "🚀 Quick Test:"
echo "  mirador-ez status"
echo "  mirador-ez ask matthew_context_provider_v2 \"Hello, introduce yourself\""
echo ""
echo "📁 Project location: $MIRADOR_DIR"
echo "📚 Documentation: $MIRADOR_DIR/README.md"
echo ""
print_status "🎭 Welcome to Mirador - Your Personal AI Orchestration System!"

