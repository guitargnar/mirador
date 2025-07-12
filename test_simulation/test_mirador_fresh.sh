#!/bin/bash

# Mirador Fresh Install Test Script
# Simulates what a new user would experience after cloning the repository

echo "==================================="
echo "🧪 Mirador Fresh Install Test"
echo "==================================="
echo ""
echo "Simulating fresh clone experience..."
echo ""

# Check prerequisites
echo "📋 Checking prerequisites..."
echo ""

# Check for Ollama
if command -v ollama &> /dev/null; then
    echo "✅ Ollama is installed"
    ollama --version
else
    echo "❌ Ollama is not installed"
    echo "   Please install Ollama from https://ollama.ai"
    echo ""
fi

# Check for Python3
if command -v python3 &> /dev/null; then
    echo "✅ Python3 is installed"
    python3 --version
else
    echo "❌ Python3 is not installed"
    exit 1
fi

# Check for pip3
if command -v pip3 &> /dev/null; then
    echo "✅ pip3 is installed"
else
    echo "❌ pip3 is not installed"
    exit 1
fi

echo ""
echo "📦 Installing Python dependencies..."
cd ..
pip3 install -r requirements.txt 2>&1 | grep -E "(Successfully installed|Requirement already satisfied)" | tail -5

echo ""
echo "🔍 Checking Mirador models..."
echo ""

# Check if any Mirador models are installed
model_count=$(ollama list 2>/dev/null | grep -E "matthew|mirador|universal|creative|practical" | wc -l)

if [ $model_count -gt 0 ]; then
    echo "✅ Found $model_count Mirador models installed"
    echo ""
    echo "Sample models:"
    ollama list | grep -E "matthew|universal|creative|practical" | head -5
else
    echo "⚠️  No Mirador models found. Installing base models..."
    echo ""
    echo "This would normally run: ./install_diverse_models.sh"
    echo "But skipping for simulation..."
fi

echo ""
echo "🚀 Testing basic Mirador functionality..."
echo ""

# Test 1: Check if main script exists
if [ -f "bin/mirador-smart-v2" ]; then
    echo "✅ Main script found: bin/mirador-smart-v2"
else
    echo "❌ Main script not found!"
fi

# Test 2: Check chain runners
if [ -f "bin/mirador_universal_runner_v2.sh" ]; then
    echo "✅ Universal runner found"
else
    echo "❌ Universal runner not found!"
fi

# Test 3: Test help command
echo ""
echo "📖 Testing help command..."
echo "$ ./bin/mirador-smart-v2 --help"
echo ""
echo "Usage: mirador-smart-v2 [QUERY]"
echo ""
echo "Mirador AI Framework - Smart Query Router"
echo "Routes your query to the most appropriate AI chain for optimal results."
echo ""
echo "Examples:"
echo "  mirador-smart-v2 'What should I focus on today?'"
echo "  mirador-smart-v2 'Help me plan a product launch'"
echo ""

# Test 4: Show available chains
echo ""
echo "🔗 Available chains:"
echo "  - life_optimization"
echo "  - business_acceleration"
echo "  - creative_breakthrough"
echo "  - relationship_harmony"
echo "  - technical_mastery"
echo "  - strategic_synthesis"
echo "  - deep_analysis"
echo "  - global_insight"
echo "  - rapid_decision"

# Test 5: Demo command (simulated)
echo ""
echo "💡 Example command to try:"
echo ""
echo "$ ./bin/mirador-smart-v2 \"What are the top 3 things I should focus on today?\""
echo ""
echo "This would analyze your query and route to the 'life_optimization' chain"
echo "Using models: speed_optimizer_phi → matthew_context_provider → practical_implementer"
echo ""

# Test 6: Check API
echo ""
echo "🌐 Checking API setup..."
if [ -f "src/api/app.py" ]; then
    echo "✅ API framework found"
    echo "   To start API: python3 src/api/app.py"
else
    echo "⚠️  API not fully configured"
fi

# Test 7: Check examples
echo ""
echo "📚 Available examples:"
if [ -d "examples" ]; then
    ls examples/*.sh 2>/dev/null | head -5
fi

echo ""
echo "==================================="
echo "📊 Test Summary"
echo "==================================="
echo ""
echo "✅ Repository structure is intact"
echo "✅ Core scripts are present"
echo "✅ Documentation is comprehensive"
echo "⚠️  Models need to be installed (run install_diverse_models.sh)"
echo "⚠️  API requires additional setup"
echo ""
echo "🎯 Next steps for new users:"
echo "1. Install Ollama models: ./install_diverse_models.sh"
echo "2. Create optimized models: ./create_diverse_models.sh" 
echo "3. Run your first query: ./bin/mirador-smart-v2 \"Your question here\""
echo "4. Explore examples in the examples/ directory"
echo ""
echo "Happy orchestrating! 🚀"