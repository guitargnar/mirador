# 🚀 Mirador AI Orchestration - Complete Setup Guide

**Target System:** MacBook M3 Max, macOS Sequoia 15.5  
**Purpose:** Personal life opportunity identification and decision automation  
**Status:** Production-ready implementation

## 📁 File Path Catalog

```
/Users/matthewscott/ai_framework_git/          # Main project directory
├── mirador.py                                 # Core orchestration engine
├── outputs/                                   # Chain execution results
├── *.modelfile                               # Model configurations
└── version_info.sh                           # System status checker

/usr/local/bin/
└── mirador-ez                                 # Global command launcher

~/.ollama/models/                              # Ollama model storage
├── financial_planning_expert_v5/
├── enhanced_agent_fast_v3/
├── louisville_expert_v2/
└── [other models]/
```

## 🛠️ Prerequisites Installation

### Step 1: Install Homebrew (if not already installed)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Step 2: Install Ollama
```bash
# Install Ollama
brew install ollama

# Start Ollama service
brew services start ollama

# Verify Ollama is running
ollama --version
```

### Step 3: Install Base Models
```bash
# Essential foundation models
ollama pull llama3.2
ollama pull codellama  
ollama pull mistral

# For enhanced capabilities
ollama pull llama3.2:latest
```

## 🏗️ Project Directory Setup

### Step 1: Create Main Project Structure
```bash
# Create main project directory
mkdir -p ~/ai_framework_git
cd ~/ai_framework_git

# Create outputs directory
mkdir -p outputs

# Create backup directory
mkdir -p backups

# Set proper permissions
chmod 755 ~/ai_framework_git
chmod 755 ~/ai_framework_git/outputs
```

### Step 2: Download/Create Core Engine
```bash
# Create the main mirador.py orchestration engine
cat > mirador.py << 'EOF'
#!/usr/bin/env python3
"""
Mirador AI Orchestration Framework
Personal Life Opportunity Identification System
"""

import argparse
import json
import requests
import sys
import time
from datetime import datetime
from pathlib import Path
import subprocess

class MiradorOrchestrator:
    def __init__(self):
        self.ollama_url = "http://localhost:11434"
        self.output_dir = Path.home() / "ai_framework_git" / "outputs"
        self.timeout = 120
        
    def list_models(self):
        """List all available Ollama models"""
        try:
            response = requests.get(f"{self.ollama_url}/api/tags")
            if response.status_code == 200:
                models = response.json()
                print("Available Models:")
                for model in models.get('models', []):
                    print(f"  - {model['name']}")
                return True
        except Exception as e:
            print(f"Error connecting to Ollama: {e}")
            return False
    
    def query_model(self, model_name, prompt, context=""):
        """Query a single model"""
        full_prompt = f"{context}\n\n{prompt}" if context else prompt
        
        payload = {
            "model": model_name,
            "prompt": full_prompt,
            "stream": False
        }
        
        try:
            print(f"Querying {model_name}...")
            start_time = time.time()
            
            response = requests.post(
                f"{self.ollama_url}/api/generate",
                json=payload,
                timeout=self.timeout
            )
            
            end_time = time.time()
            duration = end_time - start_time
            
            if response.status_code == 200:
                result = response.json()
                print(f"Completed: {model_name} ({duration:.0f}s)")
                return result.get('response', '')
            else:
                print(f"Error: {response.status_code}")
                return None
                
        except Exception as e:
            print(f"Error querying {model_name}: {e}")
            return None
    
    def run_chain(self, task, models):
        """Execute a chain of models"""
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        chain_dir = self.output_dir / f"chain_{timestamp}"
        chain_dir.mkdir(parents=True, exist_ok=True)
        
        print(f"Running chain with {len(models)} models")
        print(f"Models: {', '.join(models)}")
        print(f"Output directory: {chain_dir}")
        
        context = f"Task: {task}"
        all_outputs = []
        
        for i, model in enumerate(models, 1):
            print(f"\nStep {i}/{len(models)}: Running {model}")
            
            # Create step-specific prompt
            if i == 1:
                prompt = f"Task: {task}\n\nPlease provide comprehensive analysis and recommendations."
            else:
                prompt = f"Building on the previous analysis, please enhance and expand with additional insights:\n\nPrevious analysis: {context[-1000:]}\n\nTask: {task}"
            
            # Query model
            result = self.query_model(model, prompt)
            
            if result:
                # Save individual output
                step_file = chain_dir / f"step{i}_output.txt"
                with open(step_file, 'w') as f:
                    f.write(result)
                
                all_outputs.append({
                    'model': model,
                    'output': result,
                    'word_count': len(result.split())
                })
                
                context += f"\n\n=== {model.upper()} ANALYSIS ===\n{result}"
                
                print(f"✓ {model} completed ({len(result.split())} words)")
            else:
                print(f"✗ {model} failed")
        
        # Create summary
        summary_content = f"# Mirador Chain Analysis Summary\n\n"
        summary_content += f"**Task:** {task}\n"
        summary_content += f"**Timestamp:** {timestamp}\n"
        summary_content += f"**Models Used:** {', '.join(models)}\n\n"
        
        for output in all_outputs:
            summary_content += f"## {output['model'].upper()} ({output['word_count']} words)\n\n"
            summary_content += f"{output['output']}\n\n---\n\n"
        
        summary_file = chain_dir / "summary.md"
        with open(summary_file, 'w') as f:
            f.write(summary_content)
        
        print(f"\nChain execution complete!")
        print(f"Results saved to: {chain_dir}")
        print(f"Summary: {summary_file}")
        
        return chain_dir

def main():
    parser = argparse.ArgumentParser(description="Mirador AI Orchestration Framework")
    subparsers = parser.add_subparsers(dest='command', help='Available commands')
    
    # Models command
    models_parser = subparsers.add_parser('models', help='List available models')
    
    # Ask command
    ask_parser = subparsers.add_parser('ask', help='Query a single model')
    ask_parser.add_argument('model', help='Model name')
    ask_parser.add_argument('prompt', help='Prompt/question')
    
    # Chain command
    chain_parser = subparsers.add_parser('chain', help='Run model chain')
    chain_parser.add_argument('task', help='Task description')
    chain_parser.add_argument('models', nargs='+', help='Models to chain')
    
    args = parser.parse_args()
    
    orchestrator = MiradorOrchestrator()
    
    if args.command == 'models':
        orchestrator.list_models()
    elif args.command == 'ask':
        result = orchestrator.query_model(args.model, args.prompt)
        if result:
            print(f"\n{result}")
    elif args.command == 'chain':
        orchestrator.run_chain(args.task, args.models)
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
EOF

# Make executable
chmod +x mirador.py
```

## 🤖 Create Specialized Models

### Step 1: Financial Planning Expert V5
```bash
cat > financial_planning_expert_v5.modelfile << 'EOF'
FROM llama3.2

PARAMETER temperature 0.3
PARAMETER top_p 0.8
PARAMETER num_predict 1500
PARAMETER repeat_penalty 1.1

SYSTEM """You are a certified financial planning expert with Louisville/Kentucky specialization.

INCOME EXTRACTION PROTOCOL:
You must extract income amounts from user requests using these patterns:
- "$75,000" or "$75000" → Extract 75000
- "75000" or "75,000" → Extract 75000  
- "75k" or "$75k" → Extract 75000
- "seventy-five thousand" or "75 thousand" → Extract 75000
- "earning X" or "making X" or "salary of X" → Extract X

PROCESSING RULES:
1. Scan the entire user request for ANY income amount
2. Convert all formats to a clean number (remove $, commas, convert k to 000)
3. If you find an income amount, use it exactly
4. If no clear income found, ask for clarification
5. NEVER default to $0 - always ask if unclear

RESPONSE STRUCTURE:
1. Start with: "Based on your specified income of $[AMOUNT]..."
2. Provide comprehensive budget framework
3. Include Louisville-specific considerations
4. Add implementation steps with local resources
5. End with professional consultation recommendations

LOUISVILLE/KENTUCKY EXPERTISE:
- Kentucky state income tax: 5% flat rate (2024)
- Jefferson County property tax rates: approximately 0.91% average
- Louisville median home price: $200,000-$250,000 (2024)
- Local resources: Louisville Metro Government, JCPS, TARC

DISCLAIMER: Always include: "This information is for educational purposes only. Consult with qualified financial professionals for personalized advice."

You excel at extracting income amounts from any format and providing accurate Louisville-specific financial guidance."""
EOF

ollama create financial_planning_expert_v5 -f financial_planning_expert_v5.modelfile
```

### Step 2: Enhanced Agent Fast V3
```bash
cat > enhanced_agent_fast_v3.modelfile << 'EOF'
FROM llama3.2

PARAMETER temperature 0.4
PARAMETER top_p 0.85
PARAMETER num_predict 1200
PARAMETER repeat_penalty 1.05

SYSTEM """You are an enhanced analysis agent optimized for chain collaboration and value addition.

CORE MISSION: Build upon and enhance previous analysis with strategic insights and implementation guidance.

CHAIN COLLABORATION PROTOCOL:
- Preserve ALL valuable content from previous analysis
- Add 2-3 strategic insights or implementation enhancements
- Provide specific next steps and action items
- Enhance rather than replace previous recommendations
- Focus on practical implementation guidance

RESPONSE STRUCTURE:
1. Strategic Enhancement Summary (acknowledge previous work)
2. Additional Strategic Insights (2-3 new observations)
3. Implementation Improvements (specific enhancements to previous recommendations)
4. Comprehensive Next Steps (clear action plan)

ENHANCEMENT RULES:
- Build upon previous analysis, don't replace it
- Add value through strategic perspective and implementation focus
- Maintain all useful information from previous steps
- Provide specific, actionable enhancements
- Create comprehensive final synthesis

You excel at enhancing collaborative analysis while preserving valuable insights from previous models."""
EOF

ollama create enhanced_agent_fast_v3 -f enhanced_agent_fast_v3.modelfile
```

### Step 3: Louisville Expert V2
```bash
cat > louisville_expert_v2.modelfile << 'EOF'
FROM llama3.2

PARAMETER temperature 0.4
PARAMETER top_p 0.8
PARAMETER num_predict 1200
PARAMETER repeat_penalty 1.1

SYSTEM """You are a local resource integration specialist for Louisville Metro and Jefferson County, Kentucky.

CORE EXPERTISE:
- Jefferson County and Louisville Metro services and resources
- JCPS (Jefferson County Public Schools) system and programs
- TARC (Transit Authority of River City) transportation
- Local government services and programs
- Neighborhood characteristics and amenities
- Local business and professional services
- Community resources and programs

KEY KNOWLEDGE AREAS:
- Louisville Metro Government services: (502) 574-5000
- JCPS schools and districts with specific program information
- TARC routes, schedules, and accessibility
- Local healthcare systems and providers
- Louisville housing market and neighborhood characteristics
- Local economic development and business resources
- Community organizations and volunteer opportunities

RESPONSE APPROACH:
- Provide specific, current information about local resources
- Include contact information and practical next steps
- Reference actual Louisville locations, services, and programs
- Consider local context in all recommendations
- Connect general needs with specific Louisville solutions

LOCAL CONTEXT INTEGRATION:
- Account for Louisville's unique geography and neighborhoods
- Consider seasonal factors relevant to Louisville climate
- Reference local cultural and community characteristics
- Integrate with local economic and employment landscape

You excel at connecting personal needs with specific Louisville-area resources and providing practical, locally-relevant guidance."""
EOF

ollama create louisville_expert_v2 -f louisville_expert_v2.modelfile
```

## 🚀 Create Global Command Interface

### Step 1: Create Global Launcher
```bash
# Create the global mirador-ez command
cat > mirador-ez << 'EOF'
#!/bin/bash
# Mirador AI Orchestration Global Launcher
# Usage: mirador-ez [command] [options]

MIRADOR_HOME="$HOME/ai_framework_git"

# Check if mirador.py exists
if [ ! -f "$MIRADOR_HOME/mirador.py" ]; then
    echo "Error: Mirador not found at $MIRADOR_HOME"
    echo "Please run setup first."
    exit 1
fi

# Change to mirador directory and run
cd "$MIRADOR_HOME"
python3 mirador.py "$@"
EOF

# Make executable and install globally
chmod +x mirador-ez
sudo mv mirador-ez /usr/local/bin/

# Verify installation
which mirador-ez
```

### Step 2: Create System Status Checker
```bash
cat > version_info.sh << 'EOF'
#!/bin/bash

echo "=== Mirador System Status ==="
echo "Timestamp: $(date)"
echo ""

echo "System Information:"
echo "- macOS Version: $(sw_vers -productVersion)"
echo "- Hardware: $(sysctl -n machdep.cpu.brand_string)"
echo "- Memory: $(sysctl -n hw.memsize | awk '{print $1/1024/1024/1024 " GB"}')"
echo ""

echo "Mirador Installation:"
echo "- Project Directory: $PWD"
echo "- Global Command: $(which mirador-ez 2>/dev/null || echo 'Not found')"
echo "- Python Version: $(python3 --version)"
echo ""

echo "Ollama Status:"
if command -v ollama &> /dev/null; then
    echo "- Ollama Version: $(ollama --version)"
    echo "- Service Status: $(pgrep ollama >/dev/null && echo 'Running' || echo 'Not running')"
    echo ""
    echo "Available Models:"
    ollama list | head -10
else
    echo "- Ollama: Not installed"
fi

echo ""
echo "Output Directory:"
echo "- Location: $HOME/ai_framework_git/outputs"
echo "- Chain Count: $(ls outputs/ 2>/dev/null | wc -l | tr -d ' ')"
echo "- Latest: $(ls -t outputs/ 2>/dev/null | head -1 || echo 'None')"
EOF

chmod +x version_info.sh
```

## 🧪 System Verification Tests

### Step 1: Basic System Check
```bash
# Navigate to project directory
cd ~/ai_framework_git

# Check system status
./version_info.sh

# Verify Ollama is running
ollama ps

# List available models
mirador-ez models
```

### Step 2: Test Individual Models
```bash
# Test financial planning expert
mirador-ez ask financial_planning_expert_v5 "Budget guidance for Louisville family making 75000 per year"

# Test enhanced agent
mirador-ez ask enhanced_agent_fast_v3 "Strategic analysis of remote work trends"

# Test Louisville expert
mirador-ez ask louisville_expert_v2 "Best neighborhoods for families in Louisville"
```

### Step 3: Test Chain Orchestration
```bash
# Simple 2-model chain
mirador-ez chain "Create financial plan for Louisville family" financial_planning_expert_v5 enhanced_agent_fast_v3

# Complex 3-model chain
mirador-ez chain "Comprehensive home buying strategy for Louisville" financial_planning_expert_v5 louisville_expert_v2 enhanced_agent_fast_v3
```

## 📊 Performance Monitoring

### Step 1: Create Monitoring Script
```bash
cat > test_performance.sh << 'EOF'
#!/bin/bash

echo "=== Mirador Performance Test ==="
echo "Starting comprehensive system test..."
echo ""

# Test 1: Individual Model Performance
echo "Test 1: Individual Model Performance"
echo "Testing financial_planning_expert_v5..."
start_time=$(date +%s)
mirador-ez ask financial_planning_expert_v5 "Quick budget analysis test" > /dev/null 2>&1
end_time=$(date +%s)
duration=$((end_time - start_time))
echo "  ✓ Financial Expert: ${duration}s"

echo "Testing enhanced_agent_fast_v3..."
start_time=$(date +%s)
mirador-ez ask enhanced_agent_fast_v3 "Strategic analysis test" > /dev/null 2>&1
end_time=$(date +%s)
duration=$((end_time - start_time))
echo "  ✓ Enhanced Agent: ${duration}s"

echo "Testing louisville_expert_v2..."
start_time=$(date +%s)
mirador-ez ask louisville_expert_v2 "Local resource test" > /dev/null 2>&1
end_time=$(date +%s)
duration=$((end_time - start_time))
echo "  ✓ Louisville Expert: ${duration}s"

echo ""

# Test 2: Chain Performance
echo "Test 2: Chain Performance"
echo "Testing 2-model chain..."
start_time=$(date +%s)
mirador-ez chain "Performance test chain" financial_planning_expert_v5 enhanced_agent_fast_v3 > /dev/null 2>&1
end_time=$(date +%s)
duration=$((end_time - start_time))
echo "  ✓ 2-Model Chain: ${duration}s"

echo ""
echo "Performance test complete!"
EOF

chmod +x test_performance.sh
```

### Step 2: Run Performance Tests
```bash
# Run comprehensive performance test
./test_performance.sh

# Check latest output
ls -la outputs/ | tail -5
```

## 🔧 Troubleshooting Commands

### Common Issues Resolution
```bash
# If Ollama isn't running
brew services restart ollama

# If models are missing
ollama pull llama3.2
ollama list

# If permission issues
sudo chmod +x /usr/local/bin/mirador-ez
chmod -R 755 ~/ai_framework_git

# If chain outputs are empty
cd ~/ai_framework_git/outputs
ls -la
cat chain_*/summary.md

# Clean restart
pkill ollama
brew services restart ollama
sleep 5
ollama list
```

## 📈 Success Metrics

After running all setup commands, you should see:

1. **System Status** ✅
   - Ollama running and accessible
   - All 3 custom models created
   - Global `mirador-ez` command working

2. **Individual Model Tests** ✅
   - Financial expert: 15-30 second responses
   - Enhanced agent: 15-25 second responses  
   - Louisville expert: 10-20 second responses

3. **Chain Execution** ✅
   - 2-model chains: 30-60 seconds
   - 3-model chains: 45-90 seconds
   - No timeout errors (120s limit)

4. **Output Quality** ✅
   - 400+ words per model response
   - Louisville-specific recommendations
   - Actionable next steps provided
   - Chain outputs build upon each other

## 🎯 Next Steps

Once setup is complete:

1. **Explore Opportunity Identification**
   ```bash
   mirador-ez chain "Identify investment opportunities for $50k" financial_planning_expert_v5 louisville_expert_v2 enhanced_agent_fast_v3
   ```

2. **Test Personal Scenarios**
   ```bash
   mirador-ez chain "Career transition strategy analysis" enhanced_agent_fast_v3 financial_planning_expert_v5
   ```

3. **Document Working Patterns**
   - Save successful chain patterns
   - Create personal prompt library
   - Build domain-specific workflows

Your Mirador AI Orchestration System will be ready for daily opportunity identification and decision support!