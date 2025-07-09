# Enhanced Mirador Implementation with Troubleshooting

I'll now create the complete enhanced Mirador system that integrates your existing implementation with the advanced chain prompt suite, while fixing the hanging command issues and providing robust error handling.

## Complete Enhanced Mirador Core Engine

```bash
# Step 1: Create the enhanced mirador.py orchestration engine
cd ~/ai_framework_git

cat > mirador.py << 'EOF'
#!/usr/bin/env python3
"""
Mirador AI Orchestration Framework - Enhanced Version
Advanced Multi-Agent System for Personal Life Optimization
Integrates chain prompt suite with robust error handling
"""

import argparse
import json
import os
import re
import requests
import sys
import time
import signal
from datetime import datetime
from pathlib import Path
import subprocess
from typing import List, Dict, Optional, Tuple
import threading

class TimeoutError(Exception):
    pass

class MiradorOrchestrator:
    def __init__(self):
        self.ollama_url = "http://localhost:11434"
        self.output_dir = Path.home() / "ai_framework_git" / "outputs"
        self.timeout = 60  # Reduced timeout to prevent hanging
        self.output_dir.mkdir(parents=True, exist_ok=True)
        
        # Enhanced chain routing patterns with music career focus
        self.chain_patterns = {
            'financial': re.compile(r'(financial|money|budget|invest|savings|income|expense|401k|retirement|tax|cost)', re.I),
            'music_career': re.compile(r'(music|guitar|touring|performance|band|recording|gig|musician|career)', re.I),
            'skill_development': re.compile(r'(skill|practice|learn|technique|improvement|training|development)', re.I),
            'networking': re.compile(r'(network|connect|industry|professional|contact|relationship|linkedin)', re.I),
            'performance': re.compile(r'(performance|stage|anxiety|confidence|audience|show|live)', re.I),
            'business': re.compile(r'(business|revenue|income|marketing|promotion|brand|client)', re.I),
            'louisville': re.compile(r'(louisville|kentucky|local|neighborhood|community)', re.I),
            'health': re.compile(r'(health|medical|wellness|fitness|energy|stress)', re.I),
            'strategy': re.compile(r'(strategy|planning|goal|decision|optimize|improve|priority)', re.I),
            'quick_decision': re.compile(r'(quick|fast|immediate|urgent|now|today)', re.I)
        }
        
        # Enhanced chain definitions with music career specialization
        self.chains = {
            # Quick Decision Chains (2-3 models)
            'quick_decision': ['matthew_context_provider_v2', 'decision_simplifier'],
            'quick_financial': ['financial_planning_expert_v6', 'decision_simplifier'],
            'quick_practice': ['master_guitar_instructor', 'decision_simplifier'],
            'quick_networking': ['music_industry_networker', 'decision_simplifier'],
            
            # Music Career Development Chains
            'music_career': ['matthew_context_provider_v2', 'master_guitar_instructor', 'music_career_timeline_strategist', 'decision_simplifier'],
            'skill_development': ['matthew_context_provider_v2', 'master_guitar_instructor', 'guitar_tone_architect', 'decision_simplifier'],
            'performance_prep': ['matthew_context_provider_v2', 'touring_readiness_coach', 'performance_anxiety_coach', 'decision_simplifier'],
            'industry_networking': ['matthew_context_provider_v2', 'music_industry_networker', 'music_career_timeline_strategist', 'decision_simplifier'],
            'music_business': ['matthew_context_provider_v2', 'music_career_timeline_strategist', 'financial_planning_expert_v6', 'decision_simplifier'],
            
            # Strategic Planning Chains (4-6 models)
            'comprehensive_career': ['matthew_context_provider_v2', 'music_career_timeline_strategist', 'music_industry_networker', 'financial_planning_expert_v6', 'mirador_system_specialist', 'decision_simplifier'],
            'financial_strategy': ['matthew_context_provider_v2', 'financial_planning_expert_v6', 'music_career_timeline_strategist', 'mirador_system_specialist', 'decision_simplifier'],
            'performance_mastery': ['matthew_context_provider_v2', 'master_guitar_instructor', 'touring_readiness_coach', 'performance_anxiety_coach', 'decision_simplifier'],
            
            # General chains
            'louisville': ['matthew_context_provider_v2', 'louisville_expert_v3', 'decision_simplifier'],
            'health': ['matthew_context_provider_v2', 'enhanced_agent_enforcer', 'decision_simplifier'],
            'standard': ['matthew_context_provider_v2', 'mirador_system_specialist', 'decision_simplifier']
        }
        
        # Predefined chain prompts from the comprehensive suite
        self.chain_prompts = {
            'morning_priorities': {
                'chain': 'quick_decision',
                'prompt': "I'm starting my day and need to set clear priorities. Help me identify the most important tasks and activities for today based on my current goals and circumstances. Consider my energy levels, available time, and both immediate deadlines and long-term objectives."
            },
            'practice_optimization': {
                'chain': 'quick_practice',
                'prompt': "I have {time} available for guitar practice today. Based on my current skill level and goals, help me optimize this practice session for maximum improvement and progress toward my touring guitarist objectives."
            },
            'career_strategy': {
                'chain': 'comprehensive_career',
                'prompt': "I need to develop a comprehensive career strategy for the next 1-3 years. Please provide thorough analysis and strategic recommendations for advancing my touring guitarist career."
            },
            'performance_prep': {
                'chain': 'performance_prep',
                'prompt': "I have an upcoming performance opportunity and need comprehensive preparation guidance. Help me prepare thoroughly for successful performance."
            }
        }
    
    def check_ollama_health(self) -> bool:
        """Check if Ollama is running and responsive"""
        try:
            response = requests.get(f"{self.ollama_url}/api/tags", timeout=5)
            return response.status_code == 200
        except:
            return False
    
    def list_models(self):
        """List all available Ollama models with enhanced filtering"""
        if not self.check_ollama_health():
            print("❌ Ollama is not running or not responding")
            print("Start Ollama with: brew services start ollama")
            return False
            
        try:
            response = requests.get(f"{self.ollama_url}/api/tags")
            if response.status_code == 200:
                models = response.json()
                print("\n=== Available Mirador Models ===")
                
                # Categorize models
                categories = {
                    'Core Models': [],
                    'Music Career': [],
                    'Financial': [],
                    'Local Expert': [],
                    'System': []
                }
                
                for model in models.get('models', []):
                    name = model['name']
                    size = model.get('size', 0) / (1024**3)  # Convert to GB
                    model_info = f"  ✓ {name:<40} ({size:.1f}GB)"
                    
                    if 'matthew_context' in name or 'decision_simplifier' in name:
                        categories['Core Models'].append(model_info)
                    elif any(keyword in name for keyword in ['guitar', 'music', 'performance', 'touring']):
                        categories['Music Career'].append(model_info)
                    elif 'financial' in name:
                        categories['Financial'].append(model_info)
                    elif 'louisville' in name:
                        categories['Local Expert'].append(model_info)
                    elif any(keyword in name for keyword in ['mirador', 'system', 'enforcer']):
                        categories['System'].append(model_info)
                
                total_models = 0
                for category, model_list in categories.items():
                    if model_list:
                        print(f"\n{category}:")
                        print("\n".join(sorted(model_list)))
                        total_models += len(model_list)
                
                print(f"\nTotal Mirador models: {total_models}")
                return True
        except Exception as e:
            print(f"Error connecting to Ollama: {e}")
            return False
    
    def select_chain(self, query: str) -> Tuple[str, List[str]]:
        """Intelligently select the appropriate chain based on query content"""
        query_lower = query.lower()
        
        # Check for quick decision indicators first
        if any(word in query_lower for word in ['quick', 'fast', 'immediate', 'urgent', 'now']):
            if self.chain_patterns['financial'].search(query):
                return 'quick_financial', self.chains['quick_financial']
            elif self.chain_patterns['music_career'].search(query) or 'practice' in query_lower:
                return 'quick_practice', self.chains['quick_practice']
            elif self.chain_patterns['networking'].search(query):
                return 'quick_networking', self.chains['quick_networking']
            else:
                return 'quick_decision', self.chains['quick_decision']
        
        # Check each pattern for specialized chains
        matches = {}
        for chain_type, pattern in self.chain_patterns.items():
            if pattern.search(query):
                matches[chain_type] = len(pattern.findall(query))
        
        # Map patterns to chains
        if 'music_career' in matches:
            if 'performance' in matches:
                return 'performance_prep', self.chains['performance_prep']
            elif 'skill_development' in matches:
                return 'skill_development', self.chains['skill_development']
            elif 'networking' in matches:
                return 'industry_networking', self.chains['industry_networking']
            elif 'business' in matches:
                return 'music_business', self.chains['music_business']
            else:
                return 'music_career', self.chains['music_career']
        
        if 'financial' in matches:
            if len(query.split()) > 30:  # Complex financial query
                return 'financial_strategy', self.chains['financial_strategy']
            else:
                return 'quick_financial', self.chains['quick_financial']
        
        if 'louisville' in matches:
            return 'louisville', self.chains['louisville']
        
        # Default to comprehensive for complex queries
        if len(query.split()) > 25:
            return 'comprehensive_career', self.chains['comprehensive_career']
        
        # Default to standard
        return 'standard', self.chains['standard']
    
    def query_model_with_timeout(self, model_name: str, prompt: str, context: str = "") -> Optional[str]:
        """Query a single model with robust timeout handling"""
        full_prompt = f"{context}\n\n{prompt}" if context else prompt
        
        payload = {
            "model": model_name,
            "prompt": full_prompt,
            "stream": False,
            "options": {
                "temperature": 0.7,
                "top_p": 0.9,
                "num_predict": 1500
            }
        }
        
        result = {'response': None, 'error': None}
        
        def query_thread():
            try:
                response = requests.post(
                    f"{self.ollama_url}/api/generate",
                    json=payload,
                    timeout=self.timeout
                )
                
                if response.status_code == 200:
                    result['response'] = response.json().get('response', '')
                else:
                    result['error'] = f"HTTP {response.status_code}"
            except Exception as e:
                result['error'] = str(e)
        
        print(f"  → Querying {model_name}...", end='', flush=True)
        start_time = time.time()
        
        # Start query in separate thread
        thread = threading.Thread(target=query_thread)
        thread.daemon = True
        thread.start()
        
        # Wait for completion or timeout
        thread.join(timeout=self.timeout)
        
        end_time = time.time()
        duration = end_time - start_time
        
        if thread.is_alive():
            print(f" ⏰ (Timeout after {self.timeout}s)")
            return None
        elif result['error']:
            print(f" ✗ ({result['error']})")
            return None
        elif result['response']:
            print(f" ✓ ({duration:.0f}s)")
            return result['response']
        else:
            print(f" ✗ (No response)")
            return None
    
    def run_predefined_chain(self, chain_name: str, **kwargs) -> bool:
        """Run a predefined chain with template substitution"""
        if chain_name not in self.chain_prompts:
            print(f"❌ Unknown predefined chain: {chain_name}")
            print(f"Available chains: {', '.join(self.chain_prompts.keys())}")
            return False
        
        chain_config = self.chain_prompts[chain_name]
        prompt = chain_config['prompt'].format(**kwargs)
        chain_type = chain_config['chain']
        models = self.chains[chain_type]
        
        print(f"🔗 Running predefined chain: {chain_name}")
        return self.run_chain(prompt, models, chain_type)
    
    def run_chain(self, task: str, models: List[str], chain_type: str = "custom") -> bool:
        """Execute a chain of models with enhanced error handling"""
        if not self.check_ollama_health():
            print("❌ Ollama is not running or not responding")
            print("Start Ollama with: brew services start ollama")
            return False
        
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        chain_dir = self.output_dir / f"chain_{timestamp}"
        chain_dir.mkdir(parents=True, exist_ok=True)
        
        print(f"\n=== Mirador Chain Execution ===")
        print(f"Type: {chain_type.title()}")
        print(f"Models: {len(models)}")
        print(f"Task: {task[:100]}...")
        print(f"Output: {chain_dir}")
        print(f"\nExecuting chain:")
        
        all_outputs = []
        successful_models = []
        start_time = time.time()
        
        for i, model in enumerate(models, 1):
            print(f"\n[{i}/{len(models)}] {model}")
            
            # Build context from previous outputs
            if i == 1:
                prompt = f"Task: {task}\n\nProvide comprehensive analysis with specific, actionable recommendations."
            else:
                # Include last 2 outputs as context
                recent_outputs = all_outputs[-2:] if len(all_outputs) >= 2 else all_outputs
                context = "\n\n".join([f"Previous Analysis:\n{out[:1000]}..." for out in recent_outputs])
                prompt = f"Task: {task}\n\n{context}\n\nBuild upon the previous analysis with your specialized expertise."
            
            # Query the model with timeout protection
            output = self.query_model_with_timeout(model, prompt)
            
            if output:
                all_outputs.append(output)
                successful_models.append(model)
                
                # Save individual output
                output_file = chain_dir / f"{i:02d}_{model}_output.md"
                with open(output_file, 'w') as f:
                    f.write(f"# {model} Output\n\n")
                    f.write(f"**Step:** {i}/{len(models)}\n")
                    f.write(f"**Task:** {task}\n\n")
                    f.write("---\n\n")
                    f.write(output)
            else:
                print(f"  ⚠️  Skipping {model} due to error")
                # Continue with chain even if one model fails
        
        # Generate summary if we have any outputs
        if all_outputs:
            self._generate_enhanced_summary(chain_dir, task, successful_models, all_outputs, chain_type, start_time)
            print(f"\n✅ Chain completed successfully!")
            print(f"📁 Results saved to: {chain_dir}")
            print(f"📊 Successful models: {len(successful_models)}/{len(models)}")
            return True
        else:
            print(f"\n❌ Chain failed - no outputs generated")
            return False
    
    def _generate_enhanced_summary(self, chain_dir: Path, task: str, models: List[str], 
                                 outputs: List[str], chain_type: str, start_time: float):
        """Generate a comprehensive summary with enhanced formatting"""
        end_time = time.time()
        total_duration = end_time - start_time
        
        summary_file = chain_dir / "summary.md"
        with open(summary_file, 'w') as f:
            f.write("# Mirador Chain Analysis Summary\n\n")
            f.write(f"**Generated:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"**Chain Type:** {chain_type.title()}\n")
            f.write(f"**Execution Time:** {total_duration:.0f} seconds\n")
            f.write(f"**Models Used:** {len(models)}\n")
            f.write(f"**Success Rate:** {len(outputs)}/{len(models)} models\n\n")
            
            f.write("## Task\n")
            f.write(f"{task}\n\n")
            
            f.write("## Key Insights\n\n")
            for i, (model, output) in enumerate(zip(models, outputs), 1):
                f.write(f"### {i}. {model}\n")
                # Extract first paragraph as key insight
                first_para = output.split('\n\n')[0] if output else "No output generated"
                f.write(f"{first_para[:300]}...\n\n")
            
            f.write("## Action Items\n\n")
            # Extract action items from all outputs
            action_items = []
            for output in outputs:
                lines = output.split('\n')
                for line in lines:
                    if any(keyword in line.lower() for keyword in ['action', 'step', 'recommend', 'should', 'next']):
                        if len(line.strip()) > 20 and len(line.strip()) < 200:
                            action_items.append(f"- {line.strip()}")
            
            if action_items:
                for item in action_items[:10]:  # Limit to top 10
                    f.write(f"{item}\n")
            else:
                f.write("- Review detailed outputs for specific recommendations\n")
            
            f.write(f"\n## Detailed Outputs\n\n")
            f.write("See individual model output files in this directory for complete analysis.\n\n")
            
            f.write("---\n")
            f.write("*Generated by Mirador AI Orchestration Framework*\n")

def main():
    parser = argparse.ArgumentParser(description="Mirador AI Orchestration - Enhanced Version")
    subparsers = parser.add_subparsers(dest='command', help='Commands')
    
    # Models command
    models_parser = subparsers.add_parser('models', help='List available models')
    
    # Ask command
    ask_parser = subparsers.add_parser('ask', help='Query a single model')
    ask_parser.add_argument('model', help='Model name')
    ask_parser.add_argument('prompt', help='Prompt text')
    
    # Chain command
    chain_parser = subparsers.add_parser('chain', help='Run a model chain')
    chain_parser.add_argument('task', help='Task description')
    chain_parser.add_argument('models', nargs='*', help='Models to chain (optional - auto-selected if not provided)')
    
    # Auto command (intelligent chain selection)
    auto_parser = subparsers.add_parser('auto', help='Automatically select and run appropriate chain')
    auto_parser.add_argument('query', help='Your question or task')
    
    # Predefined chains
    quick_parser = subparsers.add_parser('quick', help='Run predefined quick chains')
    quick_parser.add_argument('type', choices=['priorities', 'practice', 'financial', 'networking'], help='Quick chain type')
    quick_parser.add_argument('--time', help='Available time (for practice)', default='30 minutes')
    
    # Health check
    health_parser = subparsers.add_parser('health', help='Check system health')
    
    args = parser.parse_args()
    
    orchestrator = MiradorOrchestrator()
    
    if args.command == 'models':
        orchestrator.list_models()
    elif args.command == 'ask':
        if not orchestrator.check_ollama_health():
            print("❌ Ollama is not running. Start with: brew services start ollama")
            sys.exit(1)
        output = orchestrator.query_model_with_timeout(args.model, args.prompt)
        if output:
            print(f"\n{args.model} response:\n{output}")
    elif args.command == 'chain':
        if args.models:
            orchestrator.run_chain(args.task, args.models)
        else:
            # Auto-select chain
            chain_type, models = orchestrator.select_chain(args.task)
            print(f"🤖 Auto-selected chain: {chain_type}")
            orchestrator.run_chain(args.task, models, chain_type)
    elif args.command == 'auto':
        chain_type, models = orchestrator.select_chain(args.query)
        print(f"🤖 Auto-selected chain: {chain_type}")
        orchestrator.run_chain(args.query, models, chain_type)
    elif args.command == 'quick':
        if args.type == 'priorities':
            orchestrator.run_predefined_chain('morning_priorities')
        elif args.type == 'practice':
            orchestrator.run_predefined_chain('practice_optimization', time=args.time)
        elif args.type == 'financial':
            orchestrator.run_chain("Quick financial optimization analysis", ['financial_planning_expert_v6', 'decision_simplifier'], 'quick_financial')
        elif args.type == 'networking':
            orchestrator.run_chain("Quick networking opportunity assessment", ['music_industry_networker', 'decision_simplifier'], 'quick_networking')
    elif args.command == 'health':
        print("=== Mirador Health Check ===")
        if orchestrator.check_ollama_health():
            print("✅ Ollama is running and responsive")
            orchestrator.list_models()
        else:
            print("❌ Ollama is not running or not responding")
            print("Start Ollama with: brew services start ollama")
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
EOF

chmod +x mirador.py
```

## Enhanced Global Command with Timeout Protection

```bash
# Step 2: Create the enhanced mirador-ez command
cat > mirador-ez << 'EOF'
#!/bin/bash
# Enhanced Mirador-EZ Global Launcher with Timeout Protection
# Resolves hanging command issues and provides better user experience

set -euo pipefail

MIRADOR_HOME="$HOME/ai_framework_git"
TIMEOUT_DURATION="${MIRADOR_TIMEOUT:-45}"
LOG_FILE="$HOME/.mirador-ez.log"

# Function to log with timestamp
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Function to handle interruption
cleanup() {
    log_message "Command interrupted by user"
    echo "🛑 Operation cancelled by user."
    exit 130
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM

# Function to check if mirador.py exists
check_mirador_installation() {
    if [ ! -f "$MIRADOR_HOME/mirador.py" ]; then
        echo "❌ Mirador not found at $MIRADOR_HOME"
        echo "Please run the installation commands first."
        return 1
    fi
    return 0
}

# Function to check Ollama health
check_ollama() {
    if ! command -v ollama &> /dev/null; then
        echo "❌ Ollama not installed. Install with: brew install ollama"
        return 1
    fi
    
    if ! pgrep -f ollama > /dev/null; then
        echo "⚠️  Ollama not running. Starting..."
        brew services start ollama
        sleep 5
    fi
    
    return 0
}

# Function to execute with timeout
execute_with_timeout() {
    local cmd="$*"
    
    log_message "Executing: $cmd"
    
    # Check prerequisites
    if ! check_mirador_installation; then
        return 1
    fi
    
    if ! check_ollama; then
        return 1
    fi
    
    # Change to mirador directory and execute
    cd "$MIRADOR_HOME"
    
    # Use timeout command for protection
    if timeout "$TIMEOUT_DURATION" python3 mirador.py "$@"; then
        log_message "Command completed successfully"
        return 0
    else
        local exit_code=$?
        if [ $exit_code -eq 124 ]; then
            echo "⏰ Command timed out after ${TIMEOUT_DURATION} seconds"
            echo "This may indicate a hanging process or slow model response."
            echo "Try: mirador-ez health"
        fi
        log_message "Command failed with exit code: $exit_code"
        return $exit_code
    fi
}

# Main command processing
case "${1:-help}" in
    "ask")
        shift
        if [ $# -lt 2 ]; then
            echo "Usage: mirador-ez ask <model> <prompt>"
            echo "Example: mirador-ez ask decision_simplifier 'What should I prioritize today?'"
            exit 1
        fi
        execute_with_timeout ask "$@"
        ;;
        
    "chain")
        shift
        if [ $# -eq 0 ]; then
            echo "Usage: mirador-ez chain <task> [model1 model2 ...]"
            echo "Example: mirador-ez chain 'Help me plan my day'"
            echo "Note: Models are auto-selected if not specified"
            exit 1
        fi
        execute_with_timeout chain "$@"
        ;;
        
    "auto")
        shift
        if [ $# -eq 0 ]; then
            echo "Usage: mirador-ez auto <query>"
            echo "Example: mirador-ez auto 'I need help with my music career strategy'"
            exit 1
        fi
        execute_with_timeout auto "$@"
        ;;
        
    "quick")
        shift
        if [ $# -eq 0 ]; then
            echo "Usage: mirador-ez quick <type> [options]"
            echo "Types: priorities, practice, financial, networking"
            echo "Example: mirador-ez quick practice --time '1 hour'"
            exit 1
        fi
        execute_with_timeout quick "$@"
        ;;
        
    "models"|"list")
        execute_with_timeout models
        ;;
        
    "health")
        execute_with_timeout health
        ;;
        
    "help"|*)
        echo "Enhanced Mirador-EZ Command Interface"
        echo "===================================="
        echo ""
        echo "Usage: mirador-ez <command> [options]"
        echo ""
        echo "Commands:"
        echo "  ask <model> <prompt>           Query a single model"
        echo "  chain <task> [models...]       Run model chain (auto-selects models if not specified)"
        echo "  auto <query>                   Automatically select and run appropriate chain"
        echo "  quick <type> [options]         Run predefined quick chains"
        echo "  models                         List available models"
        echo "  health                         Check system health"
        echo "  help                          Show this help message"
        echo ""
        echo "Quick Chain Types:"
        echo "  priorities                     Set daily priorities"
        echo "  practice [--time <duration>]   Optimize guitar practice"
        echo "  financial                      Quick financial analysis"
        echo "  networking                     Networking opportunity assessment"
        echo ""
        echo "Environment Variables:"
        echo "  MIRADOR_TIMEOUT               Timeout in seconds (default: 45)"
        echo ""
        echo "Examples:"
        echo "  mirador-ez auto 'Help me improve my guitar skills'"
        echo "  mirador-ez quick priorities"
        echo "  mirador-ez chain 'Plan my music career strategy'"
        echo "  mirador-ez ask decision_simplifier 'What should I focus on today?'"
        echo ""
        ;;
esac
EOF

chmod +x mirador-ez

# Install globally (requires sudo)
if [ -w /usr/local/bin ]; then
    cp mirador-ez /usr/local/bin/
else
    sudo cp mirador-ez /usr/local/bin/
fi

echo "✅ Enhanced mirador-ez command installed globally"
```

## Create All Required Specialist Models

```bash
# Step 3: Create all the specialist models for the comprehensive chain suite

# Core Context Provider
cat > matthew_context_provider_v2.modelfile << 'EOF'
FROM llama3.2

PARAMETER temperature 0.3
PARAMETER top_p 0.8
PARAMETER num_predict 1500
PARAMETER repeat_penalty 1.05

SYSTEM """You are Matthew's Context Provider V2 for the Mirador personal AI orchestration framework.

PERSONAL CONTEXT:
- Name: Matthew
- Location: Louisville, Kentucky
- Primary Goal: Become a touring guitarist
- Current Role: Healthcare compliance professional at Company
- Life Stage: Career transition and skill development phase
- Family: Married with daughter, balancing family responsibilities with career aspirations

CORE MISSION: Provide personalized context and recommendations that account for Matthew's specific situation, goals, and constraints.

EXPERTISE AREAS:
1. Personal Goal Alignment
   - Music career development priorities
   - Work-life balance considerations
   - Family responsibility integration
   - Financial stability requirements

2. Louisville/Kentucky Context
   - Local music scene opportunities
   - Regional cost of living advantages
   - Healthcare industry connections
   - Geographic considerations for touring

3. Career Transition Strategy
   - Skill development prioritization
   - Timeline and milestone planning
   - Risk management during transition
   - Resource allocation optimization

RESPONSE FRAMEWORK:
1. Personal Context Assessment
2. Goal Alignment Analysis
3. Constraint Consideration
4. Personalized Recommendations
5. Next Steps with Timeline

Always consider Matthew's family responsibilities, financial needs, and long-term touring guitarist aspirations in all recommendations."""
EOF

ollama create matthew_context_provider_v2 -f matthew_context_provider_v2.modelfile

# Decision Simplifier
cat > decision_simplifier.modelfile << 'EOF'
FROM llama3.2

PARAMETER temperature 0.2
PARAMETER top_p 0.7
PARAMETER num_predict 1200
PARAMETER repeat_penalty 1.1

SYSTEM """You are the Decision Simplifier for the Mirador AI orchestration framework.

CORE MISSION: Transform complex analysis into clear, actionable decisions and next steps.

OPERATING PRINCIPLES:
1. Clarity Over Complexity: Distill insights into simple, understandable actions
2. Actionability: Every recommendation must be immediately implementable
3. Prioritization: Rank actions by impact and feasibility
4. Timeline Specificity: Provide clear timeframes for each action

RESPONSE STRUCTURE:
1. **Decision Summary** (1-2 sentences)
2. **Top 3 Priority Actions** (with specific timelines)
3. **Quick Wins** (actions for today/this week)
4. **Success Metrics** (how to measure progress)
5. **Next Review Point** (when to reassess)

FORMATTING REQUIREMENTS:
- Use bullet points for actions
- Include specific timeframes (today, this week, this month)
- Provide measurable outcomes
- Keep language simple and direct
- Focus on what Matthew can control

Always end with a clear, motivating call to action that moves Matthew closer to his touring guitarist goal."""
EOF

ollama create decision_simplifier -f decision_simplifier.modelfile

# Master Guitar Instructor
cat > master_guitar_instructor.modelfile << 'EOF'
FROM llama3.2

PARAMETER temperature 0.4
PARAMETER top_p 0.85
PARAMETER num_predict 1800
PARAMETER repeat_penalty 1.05

SYSTEM """You are the Master Guitar Instructor for the Mirador framework, specializing in developing touring-level guitar skills.

EXPERTISE AREAS:
1. Technical Skill Development
   - Advanced techniques for touring guitarists
   - Genre-specific skills (rock, pop, metal, country)
   - Performance-ready repertoire building
   - Equipment and tone optimization

2. Practice Optimization
   - Efficient practice routines for busy professionals
   - Skill assessment and gap analysis
   - Progressive difficulty structuring
   - Time-constrained practice strategies

3. Performance Preparation
   - Stage-ready skill development
   - Repertoire memorization techniques
   - Performance anxiety management through preparation
   - Equipment setup and backup planning

4. Career-Focused Learning
   - Industry-standard techniques and expectations
   - Collaboration and ensemble skills
   - Recording and studio preparation
   - Touring-specific skill requirements

RESPONSE FRAMEWORK:
1. Skill Assessment (current level analysis)
2. Targeted Development Plan (specific techniques/songs)
3. Practice Schedule (optimized for available time)
4. Progress Milestones (measurable goals)
5. Performance Application (how skills apply to touring goals)

Always provide specific exercises, songs, or techniques with clear practice instructions and realistic timelines for mastery."""
EOF

ollama create master_guitar_instructor -f master_guitar_instructor.modelfile

# Music Career Timeline Strategist
cat > music_career_timeline_strategist.modelfile << 'EOF'
FROM llama3.2

PARAMETER temperature 0.4
PARAMETER top_p 0.8
PARAMETER num_predict 1600
PARAMETER repeat_penalty 1.05

SYSTEM """You are the Music Career Timeline Strategist for the Mirador framework, specializing in strategic career development for aspiring touring guitarists.

EXPERTISE AREAS:
1. Career Pathway Planning
   - Touring guitarist career progression
   - Skill development sequencing
   - Industry networking timeline
   - Revenue stream development

2. Strategic Milestone Setting
   - Short-term achievable goals (3-6 months)
   - Medium-term career markers (1-2 years)
   - Long-term touring objectives (3-5 years)
   - Contingency planning and pivots

3. Industry Timing and Opportunities
   - Music industry seasonal patterns
   - Optimal timing for career moves
   - Market opportunity identification
   - Competition and positioning analysis

4. Resource and Investment Planning
   - Equipment acquisition timeline
   - Education and training investments
   - Marketing and promotion scheduling
   - Financial milestone coordination

RESPONSE FRAMEWORK:
1. Current Position Assessment
2. Strategic Timeline (3-month, 1-year, 3-year goals)
3. Critical Path Analysis (must-have vs. nice-to-have)
4. Resource Allocation Strategy
5. Risk Mitigation and Backup Plans

Focus on realistic, achievable timelines that account for Matthew's current responsibilities while maintaining momentum toward touring guitarist goals."""
EOF

ollama create music_career_timeline_strategist -f music_career_timeline_strategist.modelfile

# Music Industry Networker
cat > music_industry_networker.modelfile << 'EOF'
FROM llama3.2

PARAMETER temperature 0.5
PARAMETER top_p 0.85
PARAMETER num_predict 1500
PARAMETER repeat_penalty 1.05

SYSTEM """You are the Music Industry Networker for the Mirador framework, specializing in building professional relationships for touring guitarist career development.

EXPERTISE AREAS:
1. Industry Relationship Building
   - Venue owners and booking agents
   - Other musicians and band members
   - Producers and recording professionals
   - Music industry professionals and managers

2. Strategic Networking
   - LinkedIn optimization for musicians
   - Industry event identification and preparation
   - Online community engagement
   - Local music scene integration

3. Professional Communication
   - Industry-appropriate messaging and outreach
   - Portfolio and demo presentation
   - Professional brand development
   - Follow-up and relationship maintenance

4. Opportunity Creation
   - Collaboration opportunity identification
   - Performance opportunity development
   - Recording and session work networking
   - Teaching and workshop opportunities

RESPONSE FRAMEWORK:
1. Networking Goal Definition
2. Target Contact Identification
3. Outreach Strategy and Messaging
4. Relationship Building Plan
5. Opportunity Conversion Tactics

Always provide specific, actionable networking strategies with sample messages, contact approaches, and relationship building techniques tailored to the music industry."""
EOF

ollama create music_industry_networker -f music_industry_networker.modelfile

# Financial Planning Expert V6
cat > financial_planning_expert_v6.modelfile << 'EOF'
FROM llama3.2

PARAMETER temperature 0.3
PARAMETER top_p 0.8
PARAMETER num_predict 1600
PARAMETER repeat_penalty 1.05

SYSTEM """You are the Financial Planning Expert V6 for the Mirador framework, specializing in financial strategy for music career transitions.

EXPERTISE AREAS:
1. Career Transition Financial Planning
   - Income diversification strategies
   - Financial runway calculation for career changes
   - Risk management during transition periods
   - Emergency fund optimization

2. Music Career Financial Management
   - Irregular income planning and budgeting
   - Equipment and education investment strategies
   - Tax planning for musicians and freelancers
   - Revenue stream development and optimization

3. Louisville/Kentucky Financial Optimization
   - Cost of living advantages
   - State and local tax considerations
   - Regional investment opportunities
   - Healthcare industry financial benefits

4. Long-term Wealth Building
   - Retirement planning for non-traditional careers
   - Investment strategies for variable income
   - Real estate and asset building
   - Insurance and protection planning

RESPONSE FRAMEWORK:
1. Current Financial Assessment
2. Transition Financial Strategy
3. Music Career Financial Planning
4. Investment and Growth Recommendations
5. Current Department and Protection

Always provide specific dollar amounts, percentages, and concrete financial actions with realistic timelines and measurable outcomes."""
EOF

ollama create financial_planning_expert_v6 -f financial_planning_expert_v6.modelfile

# Continue with remaining models...
echo "✅ Core models created successfully"
echo "Creating additional specialist models..."
```

This enhanced implementation provides:

1. **Robust timeout protection** that prevents hanging commands
2. **Intelligent chain selection** based on query analysis
3. **Enhanced error handling** with graceful degradation
4. **Comprehensive logging** for troubleshooting
5. **Predefined chain templates** for common use cases
6. **Health checking** and diagnostic capabilities
7. **Integration** with the comprehensive chain prompt suite

The system now automatically selects appropriate chains based on your queries and provides much better reliability and user experience. Would you like me to continue with the remaining specialist models and complete the implementation?

