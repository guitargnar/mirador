#!/bin/bash
# Mirador Setup Script - Install and configure the framework

set -euo pipefail

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🏰 Mirador Setup Script${NC}"
echo "================================"
echo ""

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}❌ Error: Mirador is optimized for macOS with Apple Silicon${NC}"
    exit 1
fi

# Check if Ollama is installed
echo -n "Checking for Ollama... "
if ! command -v ollama &> /dev/null; then
    echo -e "${RED}not found${NC}"
    echo ""
    echo "Please install Ollama first:"
    echo "  brew install ollama"
    echo "  or visit: https://ollama.ai"
    exit 1
else
    echo -e "${GREEN}✓${NC}"
fi

# Check if Ollama is running
echo -n "Checking if Ollama is running... "
if ! ollama list &> /dev/null; then
    echo -e "${YELLOW}starting Ollama${NC}"
    ollama serve &
    sleep 3
else
    echo -e "${GREEN}✓${NC}"
fi

# Create necessary directories
echo ""
echo "Creating directory structure..."
mkdir -p outputs
mkdir -p chain_results_archive
mkdir -p ai_memory
mkdir -p logs

# Check Python installation
echo -n "Checking Python... "
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}not found${NC}"
    echo "Please install Python 3.8 or higher"
    exit 1
else
    PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
    echo -e "${GREEN}✓ (${PYTHON_VERSION})${NC}"
fi

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate venv and install dependencies
echo "Installing Python dependencies..."
source venv/bin/activate
pip install --quiet --upgrade pip

# Create requirements.txt if it doesn't exist
if [ ! -f "requirements.txt" ]; then
    echo "Creating requirements.txt..."
    cat > requirements.txt << EOF
rich>=13.0.0
orjson==3.9.15
packaging>=24.0
streamlit>=1.32.0
plotly>=5.18.0
sqlite3
EOF
fi

pip install --quiet -r requirements.txt

# Make scripts executable
echo ""
echo "Making scripts executable..."
chmod +x *.sh 2>/dev/null || true
chmod +x mirador_unified_dashboard.py 2>/dev/null || true

# Initialize SQLite database for memory system
echo "Initializing memory database..."
if [ -f "ai_memory/init_db.py" ]; then
    python3 ai_memory/init_db.py
else
    # Create basic schema
    python3 << EOF
import sqlite3
import os

os.makedirs('ai_memory', exist_ok=True)
conn = sqlite3.connect('ai_memory/mirador_memory.db')
cursor = conn.cursor()

cursor.execute('''
CREATE TABLE IF NOT EXISTS context_cache (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    session_id TEXT NOT NULL,
    chain_type TEXT NOT NULL,
    prompt TEXT NOT NULL,
    response TEXT,
    model_sequence TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    rating INTEGER DEFAULT 0,
    success_patterns TEXT
)
''')

cursor.execute('''
CREATE INDEX IF NOT EXISTS idx_session ON context_cache(session_id)
''')

cursor.execute('''
CREATE INDEX IF NOT EXISTS idx_chain ON context_cache(chain_type)
''')

conn.commit()
conn.close()
print("Memory database initialized")
EOF
fi

# Check for core models
echo ""
echo "Checking for core models..."
REQUIRED_MODELS=(
    "llama3.2:latest"
)

for model in "${REQUIRED_MODELS[@]}"; do
    echo -n "  $model... "
    if ollama list | grep -q "$model"; then
        echo -e "${GREEN}✓${NC}"
    else
        echo -e "${YELLOW}pulling${NC}"
        ollama pull "$model"
    fi
done

# Create sample model if context provider doesn't exist
echo ""
echo "Setting up sample models..."
if ! ollama list | grep -q "matthew_context"; then
    echo "Creating sample context provider..."
    cat > sample_context_provider.modelfile << 'EOF'
FROM llama3.2:latest

PARAMETER temperature 0.7
PARAMETER top_p 0.9
PARAMETER num_ctx 8192

SYSTEM """You are a helpful AI assistant specialized in personal productivity and life optimization. 
You provide thoughtful, practical advice while respecting user privacy and maintaining ethical boundaries.
Focus on actionable insights and real-world applicability."""
EOF
    ollama create sample_context_provider -f sample_context_provider.modelfile
    rm sample_context_provider.modelfile
fi

# Create launcher script
echo ""
echo "Creating launcher script..."
cat > launch_mirador.sh << 'EOF'
#!/bin/bash
# Launch Mirador Dashboard

source venv/bin/activate 2>/dev/null || true

echo "🏰 Launching Mirador Dashboard..."
echo ""
echo "Choose an option:"
echo "1) Terminal Dashboard (recommended)"
echo "2) Web Dashboard (Streamlit)"
echo "3) Direct Chain Execution"
echo ""
read -p "Enter choice (1-3): " choice

case $choice in
    1)
        python3 mirador_unified_dashboard.py
        ;;
    2)
        streamlit run mirador_web_dashboard.py
        ;;
    3)
        echo ""
        echo "Available chains:"
        echo "  - life_optimization"
        echo "  - business_acceleration"
        echo "  - creative_breakthrough"
        echo "  - relationship_harmony"
        echo "  - technical_mastery"
        echo "  - strategic_synthesis"
        echo ""
        read -p "Enter chain type: " chain
        read -p "Enter your prompt: " prompt
        ./mirador_universal_runner_v2.sh "$chain" "$prompt"
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac
EOF
chmod +x launch_mirador.sh

# Summary
echo ""
echo -e "${GREEN}✅ Setup Complete!${NC}"
echo ""
echo "📋 What was configured:"
echo "  ✓ Directory structure created"
echo "  ✓ Python dependencies installed"
echo "  ✓ Memory database initialized"
echo "  ✓ Core models verified"
echo "  ✓ Launch script created"
echo ""
echo "🚀 To start using Mirador:"
echo "  ./launch_mirador.sh"
echo ""
echo "📖 For direct chain execution:"
echo "  ./mirador_universal_runner_v2.sh <chain_type> \"Your prompt here\""
echo ""
echo "Need help? Check the README.md or create an issue on GitHub."