# Mirador Complete Setup and Usage Guide

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

# Start Ollama service
ollama serve

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
mkdir -p logs outputs config src/core

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

# List available models
./mirador models

# List specialized roles
./mirador roles

# Query a single model
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

## API Usage

### 1. Starting the API Server
```bash
# Start the Mirador API server
python3 api.py

# The API will be available at http://localhost:5000
# Check if it's running:
curl http://localhost:5000/health
```

### 2. API Endpoints

#### Health Check
```bash
curl http://localhost:5000/health
```

#### Single Model Query
```bash
curl -X POST http://localhost:5000/ask \
  -H "Content-Type: application/json" \
  -d '{
    "model": "enhanced_agent",
    "prompt": "Explain machine learning in simple terms"
  }'
```

#### Chain Execution
```bash
curl -X POST http://localhost:5000/chain \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Create a Python web scraper",
    "models": ["master_coder", "code_reviewer_fix"]
  }'
```

#### Conductor Analysis
```bash
curl -X POST http://localhost:5000/conductor \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Design a secure authentication system",
    "analyze_only": false
  }'
```

#### Collaborative Session
```bash
curl -X POST http://localhost:5000/collaborate \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Develop a business strategy for AI startup",
    "specialists": ["creative_entrepreneur", "enhanced_agent"]
  }'
```

### 3. API Response Handling
```python
import requests
import json

# Example Python client
def query_mirador(prompt, models=None):
    url = "http://localhost:5000/chain"
    data = {
        "prompt": prompt,
        "models": models or ["enhanced_agent"]
    }
    
    response = requests.post(url, json=data)
    if response.status_code == 200:
        result = response.json()
        return result
    else:
        print(f"Error: {response.status_code}")
        return None

# Usage
result = query_mirador("Create a data analysis script", ["master_coder", "enhanced_agent"])
print(result)
```

## Webhook Usage

### 1. Setting Up Webhooks

#### Start Webhook Server
```bash
# Start the webhook test server
python3 webhook_test_server.py

# Server will listen on http://localhost:8080
```

#### Configure Webhook Endpoints
```python
# webhook_config.py
WEBHOOK_CONFIG = {
    "endpoints": {
        "/mirador/chain": {
            "method": "POST",
            "handler": "chain_webhook_handler"
        },
        "/mirador/conductor": {
            "method": "POST", 
            "handler": "conductor_webhook_handler"
        },
        "/mirador/collaborate": {
            "method": "POST",
            "handler": "collaborate_webhook_handler"
        }
    }
}
```

### 2. Webhook Event Processing

#### Send Webhook Events
```bash
# Test chain execution via webhook
curl -X POST http://localhost:8080/mirador/chain \
  -H "Content-Type: application/json" \
  -d '{
    "event_type": "chain_request",
    "prompt": "Create a data visualization script",
    "models": ["master_coder", "enhanced_agent"],
    "callback_url": "http://your-app.com/callback"
  }'

# Test conductor analysis via webhook
curl -X POST http://localhost:8080/mirador/conductor \
  -H "Content-Type: application/json" \
  -d '{
    "event_type": "conductor_analysis",
    "prompt": "Design microservices architecture",
    "callback_url": "http://your-app.com/callback"
  }'
```

#### Webhook Response Handling
```python
# webhook_handler.py
from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

@app.route('/callback', methods=['POST'])
def handle_mirador_callback():
    data = request.json
    
    # Process Mirador response
    if data['status'] == 'completed':
        result = data['result']
        # Handle successful completion
        process_mirador_result(result)
    elif data['status'] == 'error':
        error = data['error']
        # Handle error
        handle_mirador_error(error)
    
    return jsonify({"status": "received"})

def process_mirador_result(result):
    # Your application logic here
    print(f"Mirador completed: {result}")

if __name__ == '__main__':
    app.run(port=9000)
```

### 3. Advanced Webhook Features

#### Event Streaming
```python
# webhook_stream.py
import requests
import json

def stream_mirador_events():
    url = "http://localhost:8080/mirador/stream"
    
    with requests.get(url, stream=True) as response:
        for line in response.iter_lines():
            if line:
                event = json.loads(line)
                handle_mirador_event(event)

def handle_mirador_event(event):
    if event['type'] == 'chain_progress':
        print(f"Chain progress: {event['progress']}%")
    elif event['type'] == 'specialist_response':
        print(f"Specialist {event['specialist']}: {event['response']}")
```

#### Webhook Authentication
```bash
# Send authenticated webhook request
curl -X POST http://localhost:8080/mirador/chain \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer your-api-key" \
  -d '{
    "prompt": "Secure task execution",
    "models": ["enhanced_agent"]
  }'
```

## Complete Usage Examples

### Example 1: Business Analysis Workflow
```bash
# Terminal approach
./mirador-conductor "Analyze market opportunity for AI-powered productivity tools"

# API approach
curl -X POST http://localhost:5000/conductor \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Analyze market opportunity for AI-powered productivity tools",
    "execute": true
  }'

# Webhook approach
curl -X POST http://localhost:8080/mirador/conductor \
  -H "Content-Type: application/json" \
  -d '{
    "event_type": "business_analysis",
    "prompt": "Analyze market opportunity for AI-powered productivity tools",
    "callback_url": "http://localhost:9000/callback"
  }'
```

### Example 2: Code Development Chain
```bash
# Terminal approach
./mirador chain "Create a secure REST API with user authentication" \
  --models master_coder code_reviewer_fix enhanced_agent

# API approach
curl -X POST http://localhost:5000/chain \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Create a secure REST API with user authentication",
    "models": ["master_coder", "code_reviewer_fix", "enhanced_agent"]
  }'
```

### Example 3: Interactive Development Session
```bash
# Start interactive session
./mirador-interactive

# Within the session:
User: "I want to build a guitar learning app"
Mirador: "I'll connect you with our specialists..."
User: "Focus on the practice tracking features"
Mirador: "Let me analyze this with our UX and technical specialists..."
```

## Monitoring and Troubleshooting

### Health Monitoring
```bash
# Check system health
./health_check.py

# Run comprehensive tests
./test_suite.sh

# Check specific component
./test_integration_improved.py

# Monitor logs
tail -f logs/system.log
tail -f logs/conductor.log
```

### Performance Monitoring
```bash
# Check API performance
curl http://localhost:5000/metrics

# Monitor webhook processing
tail -f logs/webhook.log

# Check model response times
./mirador models --performance
```

### Common Issues and Solutions
```bash
# Issue: Models not found
# Solution: Verify Ollama models are created
ollama list

# Issue: Permission denied
# Solution: Make scripts executable
chmod +x mirador*

# Issue: Import errors
# Solution: Run optimization script
./optimize_system.sh

# Issue: API not responding
# Solution: Check if server is running
ps aux | grep api.py
```

This comprehensive guide covers all aspects of Mirador usage from basic terminal commands to advanced webhook integration. Start with the terminal commands to get familiar with the system, then progress to API and webhook usage as your needs become more sophisticated.

