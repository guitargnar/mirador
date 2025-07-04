#!/usr/bin/env python3
"""
Mirador Framework Bridge
-----------------------
This bridge integrates the ai_framework_git bash-based implementation with
the Python-based ai_framework system, allowing them to work together.
"""

import os
import sys
import json
import time
import argparse
import subprocess
import logging
from typing import Dict, List, Optional, Any, Union
from datetime import datetime

# Configuration
AI_FRAMEWORK_GIT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
AI_FRAMEWORK = os.path.expanduser("~/ai_framework")

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler(os.path.join(AI_FRAMEWORK_GIT, "logs", f"bridge_{time.strftime('%Y%m%d')}.log"))
    ]
)
logger = logging.getLogger("mirador-bridge")

# ANSI Colors
GREEN = '\033[0;32m'
BLUE = '\033[0;34m'
YELLOW = '\033[1;33m'
RED = '\033[0;31m'
MAGENTA = '\033[0;35m'
BOLD = '\033[1m'
RESET = '\033[0m'

class MiradorBridge:
    """
    Bridge between ai_framework_git (bash implementation) and ai_framework (Python implementation)
    """
    def __init__(self):
        """Initialize the bridge"""
        self.git_config_path = os.path.join(AI_FRAMEWORK_GIT, "config", "config.json")
        self.py_config_path = os.path.join(AI_FRAMEWORK, "config.json")
        
        # Load configurations
        self.git_config = self._load_config(self.git_config_path)
        self.py_config = self._load_config(self.py_config_path)
        
        # Build model mappings
        self.model_mappings = self._build_model_mappings()
        self.chain_mappings = self._build_chain_mappings()
        
        # Ensure output directories exist
        os.makedirs(os.path.join(AI_FRAMEWORK_GIT, "outputs"), exist_ok=True)
        
    def _load_config(self, config_path: str) -> Dict:
        """Load configuration from a JSON file"""
        try:
            with open(config_path, 'r') as f:
                return json.load(f)
        except Exception as e:
            logger.error(f"Error loading config from {config_path}: {e}")
            return {}
    
    def _build_model_mappings(self) -> Dict[str, str]:
        """Build mappings between model names in both frameworks"""
        # Map model names from ai_framework to models in ai_framework_git
        mappings = {
            "master_coder": "master-coder",
            "code_reviewer_fix": "code-reviewer-fix",
            "file_reviewer": "file-reviewer",
            "creative_entrepreneur": "creative-entrepreneur",
            "guitar_expert_precise": "guitar-expert",
            "enhanced_agent": "enhanced-agent",
            "llama3.2_balanced": "llama3.2",
            "fast_agent_focused": "fast-agent",
        }
        
        # Add reverse mappings
        for git_name, py_name in list(mappings.items()):
            mappings[py_name] = git_name
            
        return mappings
    
    def _build_chain_mappings(self) -> Dict[str, List[str]]:
        """Build mappings for predefined chains"""
        return {
            "dev": ["master_coder", "code_reviewer_fix"],
            "doc": ["master_coder", "file_reviewer"],
            "business": ["master_coder", "creative_entrepreneur"],
            "security": ["master_coder", "code_reviewer_fix"],
            "data": ["enhanced_agent", "file_reviewer"],
            "mobile": ["master_coder", "code_reviewer_fix"],
            "music": ["guitar_expert_precise", "fast_agent_focused"],
            "ui": ["master_coder", "ux_designer"],
        }
    
    def run_git_chain(self, prompt: str, model_chain: List[str]) -> str:
        """Run a chain using the bash implementation"""
        # Map models to their bash names
        bash_models = [self.model_mappings.get(m, m) for m in model_chain]
        
        # Build the command
        cmd = [
            os.path.join(AI_FRAMEWORK_GIT, "scripts", "run_chain.sh"),
            prompt
        ] + bash_models
        
        logger.info(f"Running bash chain: {' '.join(cmd)}")
        
        try:
            # Run the command
            result = subprocess.run(cmd, capture_output=True, text=True)
            
            if result.returncode != 0:
                logger.error(f"Error running chain: {result.stderr}")
                return f"Error: {result.stderr}"
            
            # Find the output directory from the command output
            output_dir = None
            for line in result.stdout.split('\n'):
                if "Results saved to:" in line:
                    output_dir = line.split("Results saved to:")[1].strip()
                    break
            
            # Return the summary file if available
            if output_dir and os.path.exists(os.path.join(output_dir, "summary.md")):
                with open(os.path.join(output_dir, "summary.md"), 'r') as f:
                    return f.read()
            
            return result.stdout
            
        except Exception as e:
            logger.error(f"Error executing bash chain: {e}")
            return f"Error: {e}"
    
    def run_py_chain(self, prompt: str, model_chain: List[str]) -> str:
        """Run a chain using the Python implementation"""
        # Convert models to Python framework names if needed
        py_models = [self.model_mappings.get(m, m) for m in model_chain]
        
        # Build the command
        cmd = [
            "python3", 
            "-m", "ai_framework.framework",
            "--prompt", prompt,
        ]
        
        # Add start and end models if specified
        if len(py_models) >= 1:
            cmd.extend(["--start", py_models[0]])
        if len(py_models) >= 2:
            cmd.extend(["--end", py_models[-1]])
        
        logger.info(f"Running Python chain: {' '.join(cmd)}")
        
        try:
            # Run the command
            result = subprocess.run(cmd, capture_output=True, text=True)
            
            if result.returncode != 0:
                logger.error(f"Error running chain: {result.stderr}")
                return f"Error: {result.stderr}"
            
            return result.stdout
            
        except Exception as e:
            logger.error(f"Error executing Python chain: {e}")
            return f"Error: {e}"
    
    def run_chain(self, prompt: str, model_chain: List[str], use_python: bool = False) -> str:
        """Run a chain using either implementation based on flags"""
        if use_python:
            return self.run_py_chain(prompt, model_chain)
        else:
            return self.run_git_chain(prompt, model_chain)
    
    def run_mode(self, mode: str, prompt: str, use_python: bool = False) -> str:
        """Run a predefined mode"""
        if mode not in self.chain_mappings:
            return f"Error: Unknown mode '{mode}'. Available modes: {', '.join(self.chain_mappings.keys())}"
        
        model_chain = self.chain_mappings[mode]
        return self.run_chain(prompt, model_chain, use_python)
    
    def list_models(self) -> List[str]:
        """List available models from both frameworks"""
        # Run ollama list
        try:
            result = subprocess.run(["ollama", "list"], capture_output=True, text=True)
            models = []
            
            for line in result.stdout.split('\n')[1:]:  # Skip header
                if line.strip():
                    parts = line.split()
                    if parts:
                        models.append(parts[0])
            
            return models
        except Exception as e:
            logger.error(f"Error listing models: {e}")
            return []
    
    def list_sessions(self) -> List[Dict[str, Any]]:
        """List sessions from both frameworks"""
        git_sessions = []
        py_sessions = []
        
        # List git sessions
        git_outputs_dir = os.path.join(AI_FRAMEWORK_GIT, "outputs")
        if os.path.exists(git_outputs_dir):
            for d in os.listdir(git_outputs_dir):
                if d.startswith("chain_") and os.path.isdir(os.path.join(git_outputs_dir, d)):
                    try:
                        # Extract timestamp from directory name
                        timestamp = d.split("_")[1]
                        date = datetime.strptime(timestamp, "%Y%m%d%H%M%S").strftime("%Y-%m-%d %H:%M:%S")
                        
                        # Check for summary
                        summary_path = os.path.join(git_outputs_dir, d, "summary.md")
                        has_summary = os.path.exists(summary_path)
                        
                        git_sessions.append({
                            "id": d,
                            "date": date,
                            "framework": "git",
                            "has_summary": has_summary,
                            "path": os.path.join(git_outputs_dir, d)
                        })
                    except Exception as e:
                        logger.error(f"Error processing session {d}: {e}")
        
        # List Python sessions using the command line tool
        try:
            result = subprocess.run(
                ["python3", "-m", "ai_framework.framework", "--list-sessions"],
                capture_output=True, text=True
            )
            
            for line in result.stdout.split('\n'):
                if line.strip() and not line.startswith("Available sessions"):
                    session_id = line.strip()
                    # Get session info
                    info_result = subprocess.run(
                        ["python3", "-m", "ai_framework.framework", "--session-info", session_id],
                        capture_output=True, text=True
                    )
                    
                    py_sessions.append({
                        "id": session_id,
                        "date": session_id.split("-")[0],
                        "framework": "python",
                        "info": info_result.stdout,
                        "path": os.path.join(AI_FRAMEWORK, "outputs", session_id)
                    })
        except Exception as e:
            logger.error(f"Error listing Python sessions: {e}")
        
        # Combine and sort by date (newest first)
        all_sessions = git_sessions + py_sessions
        all_sessions.sort(key=lambda x: x["date"], reverse=True)
        
        return all_sessions

def print_header():
    """Print Mirador header"""
    print(f"{BLUE}{BOLD}")
    print("┌───────────────────────────────────────────┐")
    print("│                MIRADOR AI                 │")
    print("│       Unified Framework Interface         │")
    print("└───────────────────────────────────────────┘")
    print(f"{RESET}")

def parse_args():
    """Parse command line arguments with simple syntax support"""
    # Handle simple syntax for common commands
    if len(sys.argv) < 2:
        return argparse.Namespace(command=None)
        
    command = sys.argv[1]
    
    # Special handling for run command
    if command == "run":
        if len(sys.argv) < 3:
            print(f"{RED}Error: Missing prompt for 'run' command{RESET}")
            sys.exit(1)
        # Combine all remaining args as the prompt
        return argparse.Namespace(
            command="run",
            prompt=" ".join(sys.argv[2:]),
            python=False
        )
    
    # Special handling for mode command
    elif command == "mode":
        if len(sys.argv) < 4:
            print(f"{RED}Error: Missing mode or prompt for 'mode' command{RESET}")
            print("Usage: mirador mode [dev|doc|business|security|data|mobile|music|ui] \"Your prompt\"")
            sys.exit(1)
        
        mode = sys.argv[2]
        # Combine all remaining args as the prompt
        return argparse.Namespace(
            command="mode",
            mode=mode,
            prompt=" ".join(sys.argv[3:]),
            python=False
        )
    
    # Special handling for chain command
    elif command == "chain":
        if len(sys.argv) < 3:
            print(f"{RED}Error: Missing models for 'chain' command{RESET}")
            print("Usage: mirador chain model1 model2 -- \"Your prompt\"")
            sys.exit(1)
        
        # Look for -- separator 
        remaining_args = sys.argv[2:]
        separator_index = -1
        
        for i, arg in enumerate(remaining_args):
            if arg == "--":
                separator_index = i
                break
        
        if separator_index != -1:
            # Split at the separator
            models = remaining_args[:separator_index]
            prompt = " ".join(remaining_args[separator_index+1:])
            
            return argparse.Namespace(
                command="chain",
                models=models,
                prompt=prompt,
                python=False
            )
        else:
            # No separator, assume last arg is the prompt
            if len(remaining_args) < 2:
                print(f"{RED}Error: Missing prompt for 'chain' command{RESET}")
                print("Usage: mirador chain model1 model2 -- \"Your prompt\"")
                sys.exit(1)
                
            models = remaining_args[:-1]
            prompt = remaining_args[-1]
            
            return argparse.Namespace(
                command="chain",
                models=models,
                prompt=prompt,
                python=False
            )
    
    # Simple commands
    elif command in ["models", "sessions"]:
        return argparse.Namespace(command=command)
    
    # Session command
    elif command == "session":
        if len(sys.argv) < 3:
            print(f"{RED}Error: Missing session ID{RESET}")
            print("Usage: mirador session SESSION_ID")
            sys.exit(1)
            
        return argparse.Namespace(
            command="session",
            id=sys.argv[2]
        )
    
    # Interactive mode
    elif command == "interactive":
        return argparse.Namespace(command="interactive")
    
    # Unknown command
    else:
        return argparse.Namespace(command=command)

def main():
    """Main entry point"""
    args = parse_args()
    bridge = MiradorBridge()
    
    if not args.command:
        # Print help
        print(f"{BLUE}{BOLD}Mirador Unified Interface{RESET}")
        print("\nAvailable commands:")
        print("  run \"Your prompt\"               - Run a full chain")
        print("  mode dev \"Create a function\"    - Run in a specific mode")
        print("  chain model1 model2 -- \"Prompt\" - Run a custom chain")
        print("  models                         - List available models")
        print("  sessions                       - List all sessions")
        print("  session ID                     - Get session info")
        print("\nTry 'mirador-unified help' for more information.")
        return
    
    elif args.command == "run":
        print(f"{YELLOW}Running prompt: {args.prompt}{RESET}")
        # Use a default chain for simplicity
        result = bridge.run_chain(args.prompt, ["master_coder", "code_reviewer_fix", "creative_entrepreneur"], args.python)
        print(result)
        
    elif args.command == "mode":
        print(f"{YELLOW}Running in {args.mode} mode: {args.prompt}{RESET}")
        result = bridge.run_mode(args.mode, args.prompt, args.python)
        print(result)
        
    elif args.command == "chain":
        # Models and prompt are already parsed by parse_args()
        print(f"{YELLOW}Running custom chain ({', '.join(args.models)}): {args.prompt}{RESET}")
        result = bridge.run_chain(args.prompt, args.models, args.python)
        print(result)
        
    elif args.command == "models":
        models = bridge.list_models()
        print(f"{BLUE}{BOLD}Available Models:{RESET}")
        for model in models:
            print(f"  - {model}")
            
    elif args.command == "sessions":
        sessions = bridge.list_sessions()
        print(f"{BLUE}{BOLD}All Sessions:{RESET}")
        for session in sessions:
            framework = "Python" if session["framework"] == "python" else "Bash"
            print(f"  - {session['id']} ({session['date']}) [{framework}]")
            
    elif args.command == "session":
        # Get session info
        print(f"{YELLOW}Getting info for session: {args.id}{RESET}")
        # TODO: Implement session info retrieval
        print(f"{RED}Session info retrieval not yet implemented{RESET}")
    
    elif args.command == "interactive":
        # Interactive mode
        print(f"{YELLOW}Starting interactive mode...{RESET}")
        print(f"{RED}Interactive mode not yet implemented{RESET}")
        
    elif args.command in ["help", "--help", "-h"]:
        # Print detailed help
        print_header()
        print(f"{BLUE}{BOLD}Mirador Unified Interface{RESET}")
        print("\nCommand reference:")
        print("  mirador-unified run \"Your prompt\"")
        print("    - Run a full chain with default models")
        print("\n  mirador-unified mode MODE \"Your prompt\"")
        print("    - Run in a specific mode (dev, doc, business, security, data, mobile, music, ui)")
        print("    - Example: mirador-unified mode dev \"Create a secure login function\"")
        print("\n  mirador-unified chain MODEL1 MODEL2 [MODEL3] -- \"Your prompt\"")
        print("    - Run a custom chain with specified models")
        print("    - Example: mirador-unified chain master_coder creative_entrepreneur -- \"Design a user registration system\"")
        print("\n  mirador-unified models")
        print("    - List all available models")
        print("\n  mirador-unified sessions")
        print("    - List all session IDs from both frameworks")
        print("\n  mirador-unified session ID")
        print("    - Get detailed information about a specific session")
        
    else:
        print(f"{RED}Unknown command: {args.command}{RESET}")
        print("Try 'mirador-unified help' for a list of available commands.")
        
if __name__ == "__main__":
    print_header()
    main()