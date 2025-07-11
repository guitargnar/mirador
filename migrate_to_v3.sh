#!/bin/bash
# Mirador V3 Migration Script
# Helps users transition from V2 to V3 streaming architecture

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Mirador V3 Migration Assistant"
echo "=================================="
echo ""
echo "This script will help you migrate to Mirador V3's streaming architecture."
echo "V3 provides <1s first token latency while maintaining backward compatibility."
echo ""

# Check prerequisites
check_prerequisites() {
    echo "📋 Checking prerequisites..."
    
    # Check Python
    if ! command -v python3 &> /dev/null; then
        echo "❌ Python 3 is required but not installed."
        echo "   Please install Python 3.8 or later."
        return 1
    fi
    echo "✅ Python 3 found: $(python3 --version)"
    
    # Check Ollama
    if ! command -v ollama &> /dev/null; then
        echo "❌ Ollama is required but not installed."
        echo "   Please install Ollama from https://ollama.ai"
        return 1
    fi
    echo "✅ Ollama found: $(ollama --version)"
    
    # Check for asyncio support
    if ! python3 -c "import asyncio" 2>/dev/null; then
        echo "❌ Python asyncio module not available."
        return 1
    fi
    echo "✅ Python asyncio available"
    
    return 0
}

# Install Python dependencies
install_dependencies() {
    echo ""
    echo "📦 Installing Python dependencies..."
    
    # Create requirements file if it doesn't exist
    cat > "$SCRIPT_DIR/requirements_streaming.txt" << EOF
ollama>=0.1.7
httpx>=0.24.0
aiofiles>=23.0.0
EOF
    
    # Install dependencies
    if pip3 install -r "$SCRIPT_DIR/requirements_streaming.txt"; then
        echo "✅ Dependencies installed successfully"
    else
        echo "⚠️  Some dependencies failed to install. You may need to run:"
        echo "   pip3 install ollama httpx aiofiles"
    fi
}

# Check and optimize models
check_models() {
    echo ""
    echo "🤖 Checking models for V3 optimization..."
    
    # Check for speed-optimized model
    if ! ollama list | grep -q "speed_optimizer_phi:latest"; then
        echo "📥 Creating speed-optimized model for <1s latency..."
        
        # Create optimized modelfile
        cat > "$SCRIPT_DIR/speed_optimizer_phi.modelfile" << 'EOF'
FROM phi3:mini

PARAMETER temperature 0.1
PARAMETER top_p 0.9
PARAMETER num_predict 150
PARAMETER num_ctx 4096
PARAMETER stop "<|end|>"
PARAMETER stop "<|user|>"
PARAMETER stop "<|assistant|>"

SYSTEM You are a helpful AI assistant. Provide quick, concise responses.
EOF
        
        # Create the model
        if ollama create speed_optimizer_phi:latest -f "$SCRIPT_DIR/speed_optimizer_phi.modelfile"; then
            echo "✅ Speed-optimized model created"
        else
            echo "⚠️  Failed to create speed-optimized model"
        fi
        
        rm -f "$SCRIPT_DIR/speed_optimizer_phi.modelfile"
    else
        echo "✅ Speed-optimized model already exists"
    fi
    
    # List key models
    echo ""
    echo "📊 Key models for V3:"
    echo "   - speed_optimizer_phi:latest (quick response, <1s)"
    echo "   - gemma2:9b (deep analysis)"
    echo "   - matthew_context_provider_v6_complete:latest (synthesis)"
}

# Create aliases for easy migration
setup_aliases() {
    echo ""
    echo "🔧 Setting up command aliases..."
    
    # Backup existing mirador command
    if [ -f "$SCRIPT_DIR/mirador" ] && [ ! -f "$SCRIPT_DIR/mirador-v2-backup" ]; then
        cp "$SCRIPT_DIR/mirador" "$SCRIPT_DIR/mirador-v2-backup"
        echo "✅ Backed up original mirador to mirador-v2-backup"
    fi
    
    # Create convenience scripts
    cat > "$SCRIPT_DIR/bin/mirador-quick" << 'EOF'
#!/bin/bash
# Quick response only - fastest option
exec "$(dirname "$0")/mirador-stream" "$1" --stages quick_response
EOF
    chmod +x "$SCRIPT_DIR/bin/mirador-quick"
    
    cat > "$SCRIPT_DIR/bin/mirador-full" << 'EOF'
#!/bin/bash
# All stages - most comprehensive
exec "$(dirname "$0")/mirador-stream" "$1"
EOF
    chmod +x "$SCRIPT_DIR/bin/mirador-full"
    
    echo "✅ Created convenience commands:"
    echo "   - mirador-quick: Ultra-fast responses only"
    echo "   - mirador-full: Complete multi-stage analysis"
}

# Run benchmark comparison
run_benchmark() {
    echo ""
    echo "📊 Would you like to run a benchmark comparison? (y/n)"
    read -r response
    
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo ""
        echo "🏁 Running V2 vs V3 benchmark..."
        
        if [ -f "$SCRIPT_DIR/benchmark_streaming.py" ]; then
            python3 "$SCRIPT_DIR/benchmark_streaming.py"
        else
            echo "⚠️  Benchmark script not found"
        fi
    fi
}

# Test the installation
test_v3() {
    echo ""
    echo "🧪 Testing V3 streaming..."
    
    if [ -x "$SCRIPT_DIR/bin/mirador-stream" ]; then
        echo "Running test query..."
        "$SCRIPT_DIR/bin/mirador-stream" "List three benefits of the V3 architecture" --stages quick_response --no-color
        echo ""
        echo "✅ V3 streaming is working!"
    else
        echo "❌ V3 streaming not available"
        return 1
    fi
}

# Main migration flow
main() {
    # Check prerequisites
    if ! check_prerequisites; then
        echo ""
        echo "❌ Prerequisites check failed. Please install missing components."
        exit 1
    fi
    
    # Install dependencies
    install_dependencies
    
    # Check and optimize models
    check_models
    
    # Setup aliases
    setup_aliases
    
    # Test V3
    test_v3
    
    # Optionally run benchmark
    run_benchmark
    
    # Final instructions
    echo ""
    echo "🎉 Migration Complete!"
    echo "===================="
    echo ""
    echo "You can now use Mirador V3 with these commands:"
    echo ""
    echo "1. Smart wrapper (auto-selects best approach):"
    echo "   ./mirador-v3 \"Your query\""
    echo ""
    echo "2. Direct streaming interface:"
    echo "   ./bin/mirador-stream \"Your query\""
    echo ""
    echo "3. Quick response only (fastest):"
    echo "   ./bin/mirador-quick \"Your query\""
    echo ""
    echo "4. Full analysis (all stages):"
    echo "   ./bin/mirador-full \"Your query\""
    echo ""
    echo "5. Traditional V2 (fallback):"
    echo "   ./mirador-v2-backup \"Your query\""
    echo ""
    echo "📚 Documentation: docs/V3_Streaming_Architecture.md"
    echo ""
    echo "Enjoy your <1s first token latency! 🚀"
}

# Run main function
main