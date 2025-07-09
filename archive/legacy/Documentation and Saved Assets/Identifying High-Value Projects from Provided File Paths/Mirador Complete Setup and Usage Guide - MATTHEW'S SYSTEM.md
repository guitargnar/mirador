# Mirador Complete Setup and Usage Guide - MATTHEW'S SYSTEM

## Prerequisites and Initial Setup

### 1. System Requirements
```bash
# Verify Python version (3.11+ required)
python3 --version

# Install required Python packages
pip3 install requests flask flask-cors

# Install jq for JSON processing (macOS)
brew install jq
```

### 2. Ollama Installation and Setup
```bash
# Install Ollama (if not already installed)
curl -fsSL https://ollama.ai/install.sh | sh

# Start Ollama service (CRITICAL - this must be running)
ollama serve

# Verify Ollama is running on correct port
curl http://localhost:11434/api/tags

# In a new terminal, pull required models
ollama pull llama3.2
ollama pull codellama
ollama pull mistral

# Navigate to your Mirador directory
cd /Users/matthewscott/ai_framework

# Create Mirador-specific models from modelfiles
ollama create enhanced_agent -f enhanced_agent.modelfile
ollama create master_coder -f master_coder.modelfile
ollama create code_reviewer_fix -f code_reviewer_fix.modelfile
ollama create creative_entrepreneur -f creative_entrepreneur.modelfile
ollama create guitar_expert_precise -f guitar_expert_precise.modelfile
ollama create fast_agent_focused -f fast_agent_focused.modelfile
ollama create file_reviewer -f file_reviewer.modelfile
ollama create ux_designer -f ux_designer.modelfile

# Verify models are created
ollama list
```

### 3. Mirador Installation and Setup
```bash
# Navigate to your Mirador directory
cd /Users/matthewscott/ai_framework

# Make all commands executable
chmod +x mirador*
chmod +x *.sh
chmod +x *.py

# Create required directories
mkdir -p logs outputs config src/core data

# Verify Mirador can connect to Ollama
curl http://localhost:11434/api/tags

# Check if framework.py exists (this is where your error occurred)
ls -la framework.py

# Verify installation
python3 -c "import sys; sys.path.append('.'); import framework; print('Framework imported successfully')"
```

## Terminal Command Usage

### Basic Commands

#### 1. Main Mirador Command
```bash
# Navigate to your Mirador directory first
cd /Users/matthewscott/ai_framework

# Interactive mode (default)
./mirador

# Get help
./mirador --help

# List available models (queries Ollama directly)
./mirador models

# List specialized roles
./mirador roles

# Query a single model (uses Ollama API on port 11434)
./mirador ask enhanced_agent "What is machine learning?"

# Run a simple chain
./mirador chain "Create a Python function to calculate fibonacci numbers"

# Run chain with specific models
./mirador chain "Build a REST API" --models master_coder code_reviewer_fix
```

#### 2. Conductor Mode (Intelligent Specialist Selection)
```bash
# Navigate to Mirador directory
cd /Users/matthewscott/ai_framework

# Let conductor analyze and recommend specialists
./mirador-conductor "Design a secure web application with user authentication"

# Analyze without execution
./mirador-conductor "Create a business plan for a SaaS product" --analyze-only

# Execute conductor recommendations
./mirador-conductor "Build a mobile app backend" --execute
```

#### 3. Collaborative Mode (Bidirectional Communication)
```bash
# Navigate to Mirador directory
cd /Users/matthewscott/ai_framework

# Start collaborative session
./mirador-collaborate "Develop a comprehensive marketing strategy for a tech startup"

# Specify particular specialists
./mirador-collaborate --specialists creative_entrepreneur enhanced_agent "Create product roadmap"

# Run collaboration test
./mirador-collaborate --test
```

#### 4. Interactive Mode (Conversational Interface)
```bash
# Navigate to Mirador directory
cd /Users/matthewscott/ai_framework

# Start interactive session
./mirador-interactive

# Within the session, you can:
# - Ask questions and get responses
# - Request specialist recommendations
# - Execute chains based on conversation
# - Refine and iterate on solutions
```

#### 5. Rapid Prototyping Mode
```bash
# Navigate to Mirador directory
cd /Users/matthewscott/ai_framework

# Quick idea generation
./mirador-rapid "Design a productivity app for remote teams"

# Focus on specific domain
./mirador-rapid --domain business "Monetization strategies for SaaS"
./mirador-rapid --domain technical "Architecture for scalable web service"
```

#### 6. Intervention Mode (Human-in-the-Loop)
```bash
# Navigate to Mirador directory
cd /Users/matthewscott/ai_framework

# Run with intervention opportunities
./mirador-intervene "Create a complex data processing pipeline"

# Set intervention frequency
./mirador-intervene --intervention-level high "Design system architecture"
./mirador-intervene --intervention-level low "Generate documentation"
```

#### 7. Unified Interface
```bash
# Navigate to Mirador directory
cd /Users/matthewscott/ai_framework

# Access all functionality through one command
./mirador-unified run "Your prompt here"

# Use specialized modes
./mirador-unified mode dev "Create a function"
./mirador-unified mode business "Market analysis"
./mirador-unified mode creative "Design user interface"
```

### Advanced Terminal Usage

#### Chain Templates
```bash
# Navigate to Mirador directory
cd /Users/matthewscott/ai_framework

# Use predefined templates
./mirador template code "Build a REST API with authentication"
./mirador template business "Analyze market opportunity for AI tools"
./mirador template creative "Design user experience for mobile app"

# List available templates
./mirador templates
```

#### Custom Chains
```bash
# Navigate to Mirador directory
cd /Users/matthewscott/ai_framework

# Create custom chain sequences
./mirador chain "Analyze requirements, design architecture, implement solution" \
  --models enhanced_agent master_coder code_reviewer_fix

# Save successful chains as templates
./mirador save-chain "web-development" \
  --models enhanced_agent master_coder ux_designer code_reviewer_fix
```

## API Usage - Direct Ollama Integration

### 1. Understanding Mirador's API Architecture

**IMPORTANT**: Mirador uses **direct Ollama API integration** on port 11434.

#### Verify Ollama API is Running
```bash
# Check Ollama API status
curl http://localhost:11434/api/tags

# Expected response: JSON list of available models
```

### 2. Direct Ollama API Endpoints (What Mirador Uses)

#### Health Check
```bash
curl http://localhost:11434/api/tags
```

#### Single Model Query
```bash
curl -X POST http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{
    "model": "enhanced_agent",
    "prompt": "Explain machine learning in simple terms",
    "stream": false
  }'
```

#### Chat Interface (for conversational models)
```bash
curl -X POST http://localhost:11434/api/chat \
  -H "Content-Type: application/json" \
  -d '{
    "model": "enhanced_agent",
    "messages": [
      {
        "role": "user",
        "content": "Explain machine learning in simple terms"
      }
    ],
    "stream": false
  }'
```

### 3. Mirador's Python API Integration

#### How to Call Mirador Models Programmatically
```python
# mirador_client.py
import requests
import json
import os

# Change to Mirador directory
os.chdir('/Users/matthewscott/ai_framework')

class MiradorClient:
    def __init__(self, base_url="http://localhost:11434"):
        self.base_url = base_url
    
    def generate(self, model, prompt, stream=False):
        url = f"{self.base_url}/api/generate"
        data = {
            "model": model,
            "prompt": prompt,
            "stream": stream
        }
        
        response = requests.post(url, json=data)
        if response.status_code == 200:
            return response.json()
        else:
            raise Exception(f"API Error: {response.status_code} - {response.text}")
    
    def chat(self, model, messages, stream=False):
        url = f"{self.base_url}/api/chat"
        data = {
            "model": model,
            "messages": messages,
            "stream": stream
        }
        
        response = requests.post(url, json=data)
        if response.status_code == 200:
            return response.json()
        else:
            raise Exception(f"API Error: {response.status_code} - {response.text}")

# Usage example
client = MiradorClient()
result = client.generate("enhanced_agent", "Create a Python function")
print(result['response'])
```

### 4. Mirador Chain Execution via API

#### Programmatic Chain Execution
```python
# mirador_chain_client.py
import requests
import json
import os

# Change to Mirador directory
os.chdir('/Users/matthewscott/ai_framework')

def execute_mirador_chain(prompt, models=None):
    """
    Execute a Mirador chain using direct Ollama API calls
    """
    if models is None:
        models = ["enhanced_agent"]
    
    results = []
    current_prompt = prompt
    
    for model in models:
        # Call Ollama API directly
        response = requests.post("http://localhost:11434/api/generate", 
                               json={
                                   "model": model,
                                   "prompt": current_prompt,
                                   "stream": False
                               })
        
        if response.status_code == 200:
            result = response.json()
            results.append({
                "model": model,
                "response": result['response']
            })
            # Use previous response as context for next model
            current_prompt = f"{prompt}\n\nPrevious analysis: {result['response']}"
        else:
            print(f"Error with model {model}: {response.status_code}")
    
    return results

# Usage
chain_result = execute_mirador_chain(
    "Create a secure REST API", 
    ["master_coder", "code_reviewer_fix"]
)
```

## Webhook Usage

### 1. Setting Up Webhooks with Ollama Integration

#### Start Webhook Server (from your Mirador directory)
```bash
# Navigate to Mirador directory
cd /Users/matthewscott/ai_framework

# Start the webhook test server
python3 webhook_test_server.py

# Server will listen on http://localhost:8080
```

#### Webhook Server Configuration
```python
# webhook_server_matthew.py
from flask import Flask, request, jsonify
import requests
import json
import os

# Change to Mirador directory
os.chdir('/Users/matthewscott/ai_framework')

app = Flask(__name__)

OLLAMA_BASE_URL = "http://localhost:11434"

@app.route('/mirador/generate', methods=['POST'])
def mirador_generate():
    data = request.json
    
    # Forward to Ollama API
    ollama_response = requests.post(
        f"{OLLAMA_BASE_URL}/api/generate",
        json={
            "model": data.get("model", "enhanced_agent"),
            "prompt": data.get("prompt"),
            "stream": False
        }
    )
    
    if ollama_response.status_code == 200:
        result = ollama_response.json()
        
        # Send callback if provided
        if data.get("callback_url"):
            callback_data = {
                "status": "completed",
                "result": result,
                "original_request": data
            }
            requests.post(data["callback_url"], json=callback_data)
        
        return jsonify(result)
    else:
        return jsonify({"error": f"Ollama API error: {ollama_response.status_code}"}), 500

if __name__ == '__main__':
    app.run(port=8080)
```

### 2. Webhook Event Processing

#### Send Webhook Events
```bash
# Test single model via webhook
curl -X POST http://localhost:8080/mirador/generate \
  -H "Content-Type: application/json" \
  -d '{
    "model": "enhanced_agent",
    "prompt": "Create a data visualization script",
    "callback_url": "http://your-app.com/callback"
  }'
```

## Troubleshooting - Matthew's System Specific

### Common Issues and Solutions

#### 1. Fix Your Current 404 Errors
```bash
# Problem: 404 Client Error: Not Found for url: http://localhost:11434/api/generate
# Solution: Start Ollama
ollama serve

# Verify it's running
curl http://localhost:11434/api/tags

# Should return JSON with available models
```

#### 2. Model Not Found Errors
```bash
# Navigate to your Mirador directory
cd /Users/matthewscott/ai_framework

# Check if modelfiles exist
ls -la *.modelfile

# Create missing models
ollama create creative_entrepreneur -f creative_entrepreneur.modelfile
ollama create enhanced_agent -f enhanced_agent.modelfile

# Verify model exists
ollama list | grep creative_entrepreneur
```

#### 3. Framework.py Import Errors
```bash
# Navigate to your Mirador directory
cd /Users/matthewscott/ai_framework

# Check if framework.py exists
ls -la framework.py

# Test import
python3 -c "import framework; print('Success')"

# If import fails, check Python path
python3 -c "import sys; print(sys.path)"
```

#### 4. Model Profile Errors
```bash
# Navigate to your Mirador directory
cd /Users/matthewscott/ai_framework

# Ensure data directory exists
mkdir -p data

# Check if model profiles are being saved correctly
ls -la data/model_profiles.json

# If file doesn't exist, it will be created on first run
```

#### 5. Permission Issues
```bash
# Navigate to your Mirador directory
cd /Users/matthewscott/ai_framework

# Make all scripts executable
chmod +x mirador*
chmod +x *.sh
chmod +x *.py

# Verify permissions
ls -la mirador*
```

### Health Monitoring - Matthew's System
```bash
# Navigate to your Mirador directory
cd /Users/matthewscott/ai_framework

# Check Ollama API health
curl http://localhost:11434/api/tags

# Check specific model availability
curl -X POST http://localhost:11434/api/show \
  -H "Content-Type: application/json" \
  -d '{"name": "enhanced_agent"}'

# Test model generation
curl -X POST http://localhost:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{
    "model": "enhanced_agent",
    "prompt": "Hello, test response",
    "stream": false
  }'

# Run Mirador health check (if available)
python3 health_check.py
```

## Complete Usage Examples - Matthew's System

### Example 1: Business Analysis Workflow
```bash
# Navigate to your Mirador directory
cd /Users/matthewscott/ai_framework

# Terminal approach
./mirador-conductor "Analyze market opportunity for AI-powered productivity tools"
```

### Example 2: Code Development Chain
```bash
# Navigate to your Mirador directory
cd /Users/matthewscott/ai_framework

# Terminal approach
./mirador chain "Create a secure REST API with user authentication" \
  --models master_coder code_reviewer_fix enhanced_agent
```

### Example 3: Interactive Development Session
```bash
# Navigate to your Mirador directory
cd /Users/matthewscott/ai_framework

# Start interactive session
./mirador-interactive
```

## Quick Start Checklist - Matthew's System

### Step 1: Verify Ollama
```bash
# Check if Ollama is running
curl http://localhost:11434/api/tags

# If not running, start it
ollama serve
```

### Step 2: Navigate to Mirador
```bash
cd /Users/matthewscott/ai_framework
```

### Step 3: Check Models
```bash
# List available models
ollama list

# Create missing models if needed
ollama create enhanced_agent -f enhanced_agent.modelfile
```

### Step 4: Test Mirador
```bash
# Simple test
./mirador-conductor "Create a simple Python function"
```

### Step 5: Verify Success
```bash
# Should complete without 404 errors
# Check logs if issues persist
tail -f logs/system.log
```

This documentation is now specifically tailored to your system at `/Users/matthewscott/ai_framework` and should resolve the 404 errors you were experiencing.

