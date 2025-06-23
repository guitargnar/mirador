# Mirador Complete Setup and Usage Guide - CORRECTED VERSION

## Prerequisites and Initial Setup

### 1. System Requirements
```bash
# Verify Python version (3.11+ required)
python3 --version

# Install required Python packages
pip3 install requests flask flask-cors

# Install jq for JSON processing
# macOS:
brew install jq
# Ubuntu/Debian:
sudo apt install jq
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

# Create Mirador-specific models from modelfiles
cd /path/to/mirador
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

### 3. Mirador Installation
```bash
# Navigate to your Mirador directory
cd /path/to/mirador

# Make all commands executable
chmod +x mirador*
chmod +x *.sh
chmod +x *.py

# Create required directories
mkdir -p logs outputs config src/core data

# Verify Mirador can connect to Ollama
curl http://localhost:11434/api/tags

# Run system optimization (use my optimized version)
./optimize_system.sh

# Verify installation
./health_check.py
```

## Terminal Command Usage

### Basic Commands

#### 1. Main Mirador Command
```bash
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
# Let conductor analyze and recommend specialists
./mirador-conductor "Design a secure web application with user authentication"

# Analyze without execution
./mirador-conductor "Create a business plan for a SaaS product" --analyze-only

# Execute conductor recommendations
./mirador-conductor "Build a mobile app backend" --execute
```

#### 3. Collaborative Mode (Bidirectional Communication)
```bash
# Start collaborative session
./mirador-collaborate "Develop a comprehensive marketing strategy for a tech startup"

# Specify particular specialists
./mirador-collaborate --specialists creative_entrepreneur enhanced_agent "Create product roadmap"

# Run collaboration test
./mirador-collaborate --test
```

#### 4. Interactive Mode (Conversational Interface)
```bash
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
# Quick idea generation
./mirador-rapid "Design a productivity app for remote teams"

# Focus on specific domain
./mirador-rapid --domain business "Monetization strategies for SaaS"
./mirador-rapid --domain technical "Architecture for scalable web service"
```

#### 6. Intervention Mode (Human-in-the-Loop)
```bash
# Run with intervention opportunities
./mirador-intervene "Create a complex data processing pipeline"

# Set intervention frequency
./mirador-intervene --intervention-level high "Design system architecture"
./mirador-intervene --intervention-level low "Generate documentation"
```

#### 7. Unified Interface
```bash
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
# Use predefined templates
./mirador template code "Build a REST API with authentication"
./mirador template business "Analyze market opportunity for AI tools"
./mirador template creative "Design user experience for mobile app"

# List available templates
./mirador templates
```

#### Custom Chains
```bash
# Create custom chain sequences
./mirador chain "Analyze requirements, design architecture, implement solution" \
  --models enhanced_agent master_coder code_reviewer_fix

# Save successful chains as templates
./mirador save-chain "web-development" \
  --models enhanced_agent master_coder ux_designer code_reviewer_fix
```

## API Usage - CORRECTED FOR DIRECT OLLAMA INTEGRATION

### 1. Understanding Mirador's API Architecture

**IMPORTANT**: Mirador uses **direct Ollama API integration** on port 11434, NOT a separate Flask wrapper.

#### Verify Ollama API is Running
```bash
# Check Ollama API status
curl http://localhost:11434/api/tags

# Expected response: JSON list of available models
```

### 2. Direct Ollama API Endpoints (What Mirador Actually Uses)

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

#### Model Information
```bash
# Get model details
curl -X POST http://localhost:11434/api/show \
  -H "Content-Type: application/json" \
  -d '{
    "name": "enhanced_agent"
  }'
```

### 3. Mirador's Python API Integration

#### How Mirador Calls Ollama (Internal Architecture)
```python
import requests
import json

class MiradorOllamaClient:
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
            raise Exception(f"API Error: {response.status_code}")
    
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
            raise Exception(f"API Error: {response.status_code}")

# Usage example
client = MiradorOllamaClient()
result = client.generate("enhanced_agent", "Create a Python function")
print(result['response'])
```

### 4. Mirador Chain Execution via API

#### Programmatic Chain Execution
```python
# mirador_chain_client.py
import requests
import json

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

## Webhook Usage - CORRECTED

### 1. Setting Up Webhooks with Ollama Integration

#### Webhook Server Configuration
```python
# webhook_server_corrected.py
from flask import Flask, request, jsonify
import requests
import json

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
        return jsonify({"error": "Ollama API error"}), 500

@app.route('/mirador/chain', methods=['POST'])
def mirador_chain():
    data = request.json
    prompt = data.get("prompt")
    models = data.get("models", ["enhanced_agent"])
    
    results = []
    current_prompt = prompt
    
    for model in models:
        ollama_response = requests.post(
            f"{OLLAMA_BASE_URL}/api/generate",
            json={
                "model": model,
                "prompt": current_prompt,
                "stream": False
            }
        )
        
        if ollama_response.status_code == 200:
            result = ollama_response.json()
            results.append({
                "model": model,
                "response": result['response']
            })
            current_prompt = f"{prompt}\n\nPrevious analysis: {result['response']}"
    
    # Send callback if provided
    if data.get("callback_url"):
        callback_data = {
            "status": "completed",
            "results": results,
            "original_request": data
        }
        requests.post(data["callback_url"], json=callback_data)
    
    return jsonify({"results": results})

if __name__ == '__main__':
    app.run(port=8080)
```

### 2. Webhook Event Processing

#### Send Webhook Events (Corrected)
```bash
# Test single model via webhook
curl -X POST http://localhost:8080/mirador/generate \
  -H "Content-Type: application/json" \
  -d '{
    "model": "enhanced_agent",
    "prompt": "Create a data visualization script",
    "callback_url": "http://your-app.com/callback"
  }'

# Test chain execution via webhook
curl -X POST http://localhost:8080/mirador/chain \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Create a secure web application",
    "models": ["master_coder", "code_reviewer_fix"],
    "callback_url": "http://your-app.com/callback"
  }'
```

## Troubleshooting - UPDATED

### Common Issues and Solutions

#### 1. 404 Client Error: Not Found for url: http://localhost:11434/api/generate
```bash
# Problem: Ollama is not running
# Solution: Start Ollama
ollama serve

# Verify it's running
curl http://localhost:11434/api/tags
```

#### 2. Model Not Found Errors
```bash
# Problem: Model doesn't exist in Ollama
# Solution: Create the model
ollama create enhanced_agent -f enhanced_agent.modelfile

# Verify model exists
ollama list | grep enhanced_agent
```

#### 3. Connection Refused Errors
```bash
# Problem: Ollama service not accessible
# Solution: Check if Ollama is bound to correct interface
ps aux | grep ollama

# Restart Ollama if needed
pkill ollama
ollama serve
```

#### 4. Model Profile Errors
```bash
# Problem: Model profiles not found
# Solution: Ensure data directory exists
mkdir -p /path/to/mirador/data

# Check if model profiles are being saved correctly
ls -la /path/to/mirador/data/model_profiles.json
```

### Health Monitoring - Updated
```bash
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
```

## Key Corrections Summary

### What Changed:
1. **API Port**: 11434 (Ollama) instead of 5000 (Flask wrapper)
2. **API Endpoints**: Direct Ollama API calls instead of custom endpoints
3. **Architecture**: Direct integration rather than wrapper layer
4. **Model Management**: Ollama handles model loading and profiles
5. **Error Handling**: Focus on Ollama connectivity issues

### What Stayed the Same:
- Terminal command usage
- Chain execution concepts
- Webhook callback patterns
- Model creation from modelfiles
- Health monitoring approaches

This corrected documentation reflects the actual architecture of your Mirador system as revealed by the screenshot errors.

