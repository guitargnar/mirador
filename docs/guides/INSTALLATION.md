# Installation Guide

## Prerequisites

- macOS 11+ (Big Sur or later)
- Apple Silicon (M1/M2/M3) recommended, Intel Macs supported
- 16GB RAM minimum (32GB recommended for best performance)
- 10GB free disk space
- Python 3.8 or higher
- [Homebrew](https://brew.sh) package manager

## Quick Install

The easiest way to install Mirador is using the setup script:

```bash
git clone https://github.com/your-username/mirador.git
cd mirador
./setup_mirador.sh
```

This script will:
1. Check system requirements
2. Install Ollama (if needed)
3. Create Python virtual environment
4. Install Python dependencies
5. Initialize the SQLite database
6. Pull the base Llama model
7. Create sample configuration

## Manual Installation

### Step 1: Install Ollama

```bash
# Using Homebrew
brew install ollama

# Or download from https://ollama.ai
```

### Step 2: Start Ollama Service

```bash
# Start Ollama in the background
ollama serve &

# Verify it's running
ollama list
```

### Step 3: Clone Repository

```bash
git clone https://github.com/your-username/mirador.git
cd mirador
```

### Step 4: Set Up Python Environment

```bash
# Create virtual environment
python3 -m venv venv

# Activate it
source venv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install dependencies
pip install -r requirements.txt
```

### Step 5: Pull Base Model

```bash
# Pull the default model
ollama pull llama3.2:latest
```

### Step 6: Initialize Database

```bash
# Create the SQLite database
python -c "
from src.setup import init_db
init_db.create_database()
"
```

## Verification

Test your installation:

```bash
# Run a simple test
./mirador life_optimization "What are three ways to be more productive?"

# Check system status
python -m src.utils.system_check
```

## Troubleshooting

### Ollama Not Found
```bash
# Ensure Ollama is in PATH
which ollama

# If not found, add to PATH
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Python Version Issues
```bash
# Check Python version
python3 --version

# Install Python 3.11 via Homebrew
brew install python@3.11
```

### Memory Errors
If you encounter out-of-memory errors:
1. Close other applications
2. Reduce model size in configuration
3. Use `quick` format instead of `detailed`

### Permission Errors
```bash
# Fix script permissions
chmod +x setup_mirador.sh
chmod +x mirador
chmod +x bin/*
```

## Next Steps

- Read the [Usage Guide](USAGE.md)
- Learn about [Creating Custom Models](CUSTOM_MODELS.md)
- Explore [Advanced Configuration](CONFIGURATION.md)