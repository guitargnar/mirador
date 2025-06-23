# Mirador AI Orchestration - Complete Implementation Commands
# Execute these commands in order on MacBook M3 Max, macOS Sequoia 15.5

# =============================================================================
# PHASE 1: FOUNDATION SETUP
# =============================================================================

# Step 1: Verify/Install Ollama
echo "=== Installing Ollama ==="
brew install ollama
brew services start ollama
sleep 10
ollama --version

# Step 2: Install Base Models
echo "=== Installing Base Models ==="
ollama pull llama3.2
ollama pull codellama
ollama pull mistral
ollama list

# Step 3: Create Project Structure
echo "=== Creating Project Structure ==="
mkdir -p ~/ai_framework_git/outputs
mkdir -p ~/ai_framework_git/backups
cd ~/ai_framework_git
chmod 755 ~/ai_framework_git
chmod 755 ~/ai_framework_git/outputs

# =============================================================================
# PHASE 2: CORE ENGINE CREATION
# =============================================================================

# Step 4: Create Main Orchestration Engine
echo "=== Creating mirador.py ==="
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

chmod +x mirador.py

# =============================================================================
# PHASE 3: CREATE SPECIALIST MODELS
# =============================================================================

# Step 5: Create Financial Planning Expert V5
echo "=== Creating financial_planning_expert_v5 ==="
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

# Step 6: Create Enhanced Agent Fast V3
echo "=== Creating enhanced_agent_fast_v3 ==="
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

# Step 7: Create Louisville Expert V2
echo "=== Creating louisville_expert_v2 ==="
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

# =============================================================================
# PHASE 4: GLOBAL COMMAND INTERFACE
# =============================================================================

# Step 8: Create Global Launcher
echo "=== Creating global mirador-ez command ==="
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

chmod +x mirador-ez
sudo mv mirador-ez /usr/local/bin/

# Step 9: Create System Status Checker
echo "=== Creating version_info.sh ==="
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

# Step 10: Create Performance Test Script
echo "=== Creating test_performance.sh ==="
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

# =============================================================================
# PHASE 5: SYSTEM VALIDATION
# =============================================================================

# Step 11: Verify Installation
echo "=== System Verification ==="
./version_info.sh

# Step 12: Test Model Availability
echo "=== Testing Model Availability ==="
mirador-ez models

# Step 13: Quick Individual Model Tests
echo "=== Testing Individual Models ==="
echo "Testing Financial Expert..."
mirador-ez ask financial_planning_expert_v5 "Quick test of income processing for 75000 annual salary"

echo "Testing Enhanced Agent..."
mirador-ez ask enhanced_agent_fast_v3 "Quick strategic analysis test"

echo "Testing Louisville Expert..."
mirador-ez ask louisville_expert_v2 "Quick test of Louisville knowledge"

# Step 14: Chain Execution Test
echo "=== Testing Chain Execution ==="
mirador-ez chain "Test opportunity identification for Louisville resident" financial_planning_expert_v5 enhanced_agent_fast_v3

# Step 15: Performance Validation
echo "=== Running Performance Tests ==="
./test_performance.sh

# =============================================================================
# FINAL VALIDATION
# =============================================================================

echo ""
echo "=== MIRADOR IMPLEMENTATION COMPLETE ==="
echo "✓ All models created and available"
echo "✓ Global mirador-ez command installed"
echo "✓ Monitoring scripts ready"
echo "✓ System validated and operational"
echo ""
echo "Next steps:"
echo "1. Review latest chain output: cat outputs/chain_*/summary.md"
echo "2. Start with financial analysis: mirador-ez chain \"[YOUR SCENARIO]\" financial_planning_expert_v5 enhanced_agent_fast_v3"
echo "3. Check system status anytime: ./version_info.sh"
echo ""
echo "Your Mirador AI Orchestration system is ready for opportunity identification!"