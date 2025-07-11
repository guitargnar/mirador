#!/usr/bin/env python3
"""
Mirador - Interactive AI Orchestration Framework
Combines specialized Ollama models into flexible chains for various domains.
"""

import requests
import json
import time
import os
import sys
import argparse
from datetime import datetime
import readline  # For better input handling

# ANSI Colors
GREEN = '\033[0;32m'
BLUE = '\033[0;34m'
YELLOW = '\033[1;33m'
RED = '\033[0;31m'
MAGENTA = '\033[0;35m'
CYAN = '\033[0;36m'
BOLD = '\033[1m'
RESET = '\033[0m'

# Configuration
OUTPUT_DIR = os.path.expanduser("~/ai_framework_git/outputs")
DEFAULT_TIMEOUT = 60

# Role definitions
ROLES = {
    "creative_entrepreneur": {
        "prompt": "Identify potential applications for this solution: {input}",
        "temp": 0.8
    },
    "enhanced_agent": {
        "prompt": "Analyze this solution and provide additional insights: {input}",
        "temp": 0.7
    },
    "master_coder": {
        "prompt": "Optimize and improve this code: {input}",
        "temp": 0.4
    },
    "code_reviewer_fix": {
        "prompt": "Review this code for bugs and security issues: {input}",
        "temp": 0.3
    },
    "file_reviewer": {
        "prompt": "Document this solution thoroughly: {input}",
        "temp": 0.4
    },
    "ux_designer": {
        "prompt": "Design a user interface for this solution: {input}",
        "temp": 0.7
    },
    "guitar_expert_precise": {
        "prompt": "Create a detailed guitar practice routine based on: {input}",
        "temp": 0.4
    },
    "llama3.2_balanced": {
        "prompt": "Provide a balanced analysis of: {input}",
        "temp": 0.6
    },
    "fast_agent_focused": {
        "prompt": "Organize this into a structured plan: {input}",
        "temp": 0.3
    },
    "matthew_context_provider_v3": {
        "prompt": "Analyze this in the context of my current situation and goals: {input}",
        "temp": 0.4
    },
    "enhanced_agent_enforcer": {
        "prompt": "Review and enhance this analysis for actionability and strategic alignment: {input}",
        "temp": 0.3
    },
    "company_innovation_catalyst": {
        "prompt": "Identify innovation opportunities and implementation strategies within Company's constraints: {input}",
        "temp": 0.6
    },
    "company_politics_navigator": {
        "prompt": "Analyze the political dynamics and provide navigation strategies: {input}",
        "temp": 0.7
    },
    "ai_leadership_strategist": {
        "prompt": "Develop AI leadership positioning strategies for this situation: {input}",
        "temp": 0.5
    },
    "solution_architect": {
        "prompt": "Design a practical, implementable solution within corporate constraints: {input}",
        "temp": 0.4
    },
    "advocates_meeting_optimizer_v2": {
        "prompt": "Optimize this for maximum impact through the Advocates Program: {input}",
        "temp": 0.65
    }
}

# Chain templates
CHAIN_TEMPLATES = {
    "code": ["master_coder", "code_reviewer_fix", "creative_entrepreneur"],
    "guitar": ["guitar_expert_precise", "fast_agent_focused"],
    "business": ["llama3.2_balanced", "creative_entrepreneur"],
    "document": ["enhanced_agent", "file_reviewer"],
    "ui": ["master_coder", "ux_designer"],
    # Company-specific chains
    "innovation": ["matthew_context_provider_v3", "company_innovation_catalyst", "solution_architect", "enhanced_agent_enforcer"],
    "ai_leadership": ["matthew_context_provider_v3", "ai_leadership_strategist", "enhanced_agent_enforcer"],
    "corporate_nav": ["matthew_context_provider_v3", "company_politics_navigator", "enhanced_agent_enforcer"],
    "solution": ["company_innovation_catalyst", "solution_architect", "enhanced_agent_enforcer"],
    "advocates": ["matthew_context_provider_v3", "advocates_meeting_optimizer_v2", "ai_leadership_strategist", "enhanced_agent_enforcer"],
    "quick_win": ["company_innovation_catalyst", "solution_architect"],
    "strategic": ["matthew_context_provider_v3", "company_innovation_catalyst", "ai_leadership_strategist", "company_politics_navigator", "enhanced_agent_enforcer"]
}

def print_header():
    """Print the Mirador header"""
    print(f"{BLUE}{BOLD}")
    print("┌───────────────────────────────────────────┐")
    print("│                MIRADOR AI                 │")
    print("│        Interactive Model Orchestration    │")
    print("└───────────────────────────────────────────┘")
    print(f"{RESET}")

def query_model(model, prompt, temperature=None, stream=True, timeout=DEFAULT_TIMEOUT):
    """
    Query an Ollama model and return the response
    
    Args:
        model: The Ollama model name
        prompt: The prompt to send
        temperature: Optional temperature override
        stream: Whether to stream the response
        timeout: Request timeout in seconds
        
    Returns:
        The model's response text
    """
    print(f"{YELLOW}Querying {model}...{RESET}")
    
    # Set temperature based on role if not specified
    if temperature is None and model in ROLES:
        temperature = ROLES[model]["temp"]
    elif temperature is None:
        temperature = 0.7
    
    # Sanitize prompt for JSON
    json_prompt = prompt.replace('"', '\\"').replace('\n', '\\n')
    
    try:
        # Build payload with performance options
        payload = {
            "model": model,
            "prompt": prompt,
            "stream": stream,
            "temperature": temperature,
            "options": {
                "num_gpu": 1,
                "num_thread": 8
            }
        }
        
        # Make the API call
        response = requests.post(
            "http://localhost:11434/api/generate",
            json=payload,
            stream=stream,
            timeout=timeout
        )
        
        if stream:
            # Collect and print streaming responses
            result = ""
            print(f"{CYAN}Response:{RESET}")
            for line in response.iter_lines():
                if line:
                    try:
                        chunk = json.loads(line.decode('utf-8'))
                        if "response" in chunk:
                            print(chunk["response"], end="", flush=True)
                            result += chunk["response"]
                    except Exception as e:
                        print(f"\n{RED}Error parsing response: {e}{RESET}")
            print("\n")
            return result
        else:
            # Process non-streaming response
            response_json = response.json()
            return response_json.get("response", "")
            
    except requests.exceptions.Timeout:
        print(f"{RED}Request timed out after {timeout} seconds{RESET}")
        return "[ERROR: Request timed out]"
    except Exception as e:
        print(f"{RED}Error: {e}{RESET}")
        return f"[ERROR: {str(e)}]"

def run_chain(prompt, models=None, output_dir=None, use_conductor=True, visualize=True):
    """
    Run a chain of models in sequence
    
    Args:
        prompt: The initial prompt
        models: List of model names to use in sequence (optional if use_conductor=True)
        output_dir: Optional output directory override
        use_conductor: Whether to use the conductor for dynamic model selection
        visualize: Whether to show progress visualization
        
    Returns:
        Dictionary with all outputs and metadata
    """
    # Get visualization preferences from config if available
    try:
        with open(os.path.join(os.path.dirname(OUTPUT_DIR), "config", "config.json"), "r") as f:
            config = json.load(f)
            visualize = config.get("ui", {}).get("visualization_enabled", visualize)
    except:
        # Use default if config can't be loaded
        pass
    
    # Use conductor to select models if requested and available
    if models is None or (use_conductor and 'conductor' in globals() and conductor is not None):
        try:
            # Get recommended specialists from conductor
            result = conductor.ask_conductor(prompt)
            models = result["specialists"]
            conductor_explanation = result["explanation"]
            print(f"{YELLOW}Conductor Analysis:{RESET}\n{conductor_explanation}\n")
        except Exception as e:
            print(f"{RED}Error using conductor: {e}. Using default models.{RESET}")
            if models is None:
                # Default chain if conductor fails
                models = ["master_coder", "code_reviewer_fix", "creative_entrepreneur"]
    elif models is None:
        # Default chain if no models specified and conductor not available
        models = ["master_coder", "code_reviewer_fix", "creative_entrepreneur"]
    
    # Create timestamped output directory
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    if output_dir is None:
        output_dir = os.path.join(OUTPUT_DIR, f"chain_{timestamp}")
    os.makedirs(output_dir, exist_ok=True)
    
    print(f"{BLUE}Running chain with {len(models)} models{RESET}")
    print(f"{BLUE}Models: {', '.join(models)}{RESET}")
    print(f"{BLUE}Output directory: {output_dir}{RESET}")
    
    # Save the initial prompt
    with open(os.path.join(output_dir, "prompt.txt"), "w") as f:
        f.write(prompt)
    
    # Track all outputs
    outputs = {
        "prompt": prompt,
        "models": models,
        "steps": []
    }
    
    # Save conductor explanation if available
    if 'conductor_explanation' in locals():
        with open(os.path.join(output_dir, "conductor_analysis.txt"), "w") as f:
            f.write(conductor_explanation)
        outputs["conductor_analysis"] = conductor_explanation
    
    current_context = prompt
    
    # Start visualization if enabled
    if visualize:
        print(f"\n{MAGENTA}{BOLD}Chain Progress Visualization{RESET}")
        total_steps = len(models)
        # Simple progress bar
        print_progress_bar(0, total_steps)
        # Track chain start time
        chain_start_time = time.time()
    
    # Run each model in sequence
    for i, model in enumerate(models):
        step_num = i + 1
        
        # Show step start visualization
        if visualize:
            print(f"\n{CYAN}{BOLD}Step {step_num}/{len(models)}:{RESET} Running {YELLOW}{model}{RESET}")
            print(f"{BLUE}{BOLD}Specialist Role:{RESET} {model}")
            # Show "thinking" animation
            print(f"{CYAN}Initializing{RESET}", end="")
            for _ in range(3):
                time.sleep(0.3)
                print(".", end="", flush=True)
            print("\n")
            # Show model thinking animation
            print(f"{YELLOW}{model}{RESET} is thinking", end="")
            for _ in range(5):
                time.sleep(0.3)
                print(".", end="", flush=True)
            print("\n")
        else:
            print(f"\n{YELLOW}Step {step_num}: Running {model}...{RESET}")
        
        # Get role-specific prompt if available
        if model in ROLES:
            model_prompt = ROLES[model]["prompt"].replace("{input}", current_context)
        else:
            # Generic prompt for step 1
            if i == 0:
                model_prompt = current_context
            # Generic prompts for subsequent steps
            else:
                model_prompt = f"""Previous output:
{current_context}

Please build upon this information and provide further insights."""
        
        # Save the model-specific prompt
        with open(os.path.join(output_dir, f"step{step_num}_prompt.txt"), "w") as f:
            f.write(model_prompt)
        
        # Save previous context for diff visualization
        prev_context_path = os.path.join(output_dir, f"step{i}_context.txt")
        with open(prev_context_path, "w") as f:
            f.write(current_context)
        
        # Query the model
        start_time = time.time()
        response = query_model(model, model_prompt, timeout=120, stream=(not visualize))
        elapsed = time.time() - start_time
        
        # Save the response
        with open(os.path.join(output_dir, f"step{step_num}_output.txt"), "w") as f:
            f.write(response)
        
        # Track step results
        outputs["steps"].append({
            "model": model,
            "prompt": model_prompt,
            "response": response,
            "time": elapsed
        })
        
        # Show step completion visualization
        if visualize:
            elapsed_formatted = f"{int(elapsed // 60):02d}:{int(elapsed % 60):02d}"
            print(f"\n{GREEN}{BOLD}Completed:{RESET} {YELLOW}{model}{RESET} ({BLUE}{elapsed_formatted}{RESET})")
            print_progress_bar(step_num, len(models))
            
            # Show diff visualization
            current_output_path = os.path.join(output_dir, f"step{step_num}_output.txt")
            print(f"\n{MAGENTA}{BOLD}Contributions from {model}:{RESET}")
            
            # Calculate simple metrics for diff
            with open(prev_context_path) as f1, open(current_output_path) as f2:
                prev_lines = f1.readlines()
                curr_lines = f2.readlines()
                prev_words = sum(len(line.split()) for line in prev_lines)
                curr_words = sum(len(line.split()) for line in curr_lines)
                
                print(f"{BLUE}Previous length:{RESET} {prev_words} words ({len(prev_lines)} lines)")
                print(f"{BLUE}Current length:{RESET} {curr_words} words ({len(curr_lines)} lines)")
                print(f"{GREEN}Added {max(0, curr_words - prev_words)} words{RESET}, " + 
                      f"{RED}Removed {max(0, prev_words - curr_words)} words{RESET}\n")
        
        # Update context for next model
        current_context = response
        
        # Show transition animation if not the last step
        if visualize and i < len(models) - 1:
            next_model = models[i+1]
            print(f"\n{YELLOW}{BOLD}Transition:{RESET} {BLUE}{model}{RESET} → {MAGENTA}{next_model}{RESET}")
            # Simple transition animation
            for j in range(20):
                if j % 4 == 0:
                    print("\r○○○○", end="", flush=True)
                elif j % 4 == 1:
                    print("\r●○○○", end="", flush=True)
                elif j % 4 == 2:
                    print("\r●●○○", end="", flush=True)
                elif j % 4 == 3:
                    print("\r●●●○", end="", flush=True)
                time.sleep(0.1)
            print("\r●●●●")
            print("\n")
    
    # Generate summary markdown with visualization data
    generate_summary(outputs, output_dir, include_visualization=visualize)
    
    # Show chain completion if visualization enabled
    if visualize:
        chain_elapsed = time.time() - chain_start_time
        chain_elapsed_formatted = f"{int(chain_elapsed // 60):02d}:{int(chain_elapsed % 60):02d}"
        print(f"\n{GREEN}{BOLD}Chain Execution Complete{RESET} (Total time: {BLUE}{chain_elapsed_formatted}{RESET})")
    else:
        print(f"\n{GREEN}Chain execution complete!{RESET}")
        
    print(f"{BLUE}Results saved to: {output_dir}{RESET}")
    
    # Categorize output
    categorize_output(outputs, output_dir)
    
    return outputs

def print_progress_bar(current, total, bar_length=30):
    """Print a simple progress bar to the console"""
    percent = int(100.0 * current / total)
    filled_length = int(bar_length * current / total)
    bar = '=' * filled_length + ' ' * (bar_length - filled_length)
    print(f"\rProgress: [{bar}] {percent}%", end='', flush=True)
    if current == total:
        print("")

def generate_summary(outputs, output_dir, include_visualization=True):
    """Generate a markdown summary of the chain execution"""
    summary_path = os.path.join(output_dir, "summary.md")
    
    with open(summary_path, "w") as f:
        f.write("# Chain Execution Results\n\n")
        
        f.write("## Initial Prompt\n\n")
        f.write(f"{outputs['prompt']}\n\n")
        
        f.write("## Models Used\n\n")
        for i, model in enumerate(outputs["models"]):
            # Add temperature info if available
            temp = ROLES.get(model, {}).get("temp", "0.7")
            f.write(f"{i+1}. {model} (temp={temp})\n")
        f.write("\n")
        
        for i, step in enumerate(outputs["steps"]):
            # Add execution time if available
            time_info = ""
            if "time" in step:
                elapsed_mins = int(step["time"] // 60)
                elapsed_secs = int(step["time"] % 60)
                time_info = f" (execution time: {elapsed_mins:02d}:{elapsed_secs:02d})"
            
            f.write(f"## Step {i+1}: {step['model']}{time_info}\n\n")
            f.write(f"{step['response']}\n\n")
        
        # Add visualization section if enabled
        if include_visualization:
            f.write("## Chain Transformation Visualization\n\n")
            f.write("This section visualizes how each specialist transformed the solution:\n\n")
            
            # Show the progression path
            f.write("### Progress Path\n\n")
            f.write("```\n")
            f.write(f"Initial Prompt → ")
            for i, model in enumerate(outputs["models"]):
                f.write(f"{model}")
                if i < len(outputs["models"]) - 1:
                    f.write(" → ")
            f.write("\n```\n\n")
            
            # Add contribution statistics table
            f.write("### Contribution Analysis\n\n")
            f.write("| Step | Specialist | Content Length | Processing Time | Key Contribution |\n")
            f.write("|------|------------|----------------|-----------------|------------------|\n")
            
            # Add prompt stats
            prompt_words = len(outputs["prompt"].split())
            f.write(f"| 0 | Initial Prompt | {prompt_words} words | - | Starting point |\n")
            
            # Add steps stats
            for i, step in enumerate(outputs["steps"]):
                response_words = len(step["response"].split())
                time_fmt = f"{int(step['time'] // 60):02d}:{int(step['time'] % 60):02d}"
                contribution = ""
                if i == 0:
                    contribution = "Initial analysis"
                elif i == len(outputs["steps"]) - 1:
                    contribution = "Final integration"
                else:
                    contribution = "Refinement and expansion"
                
                f.write(f"| {i+1} | {step['model']} | {response_words} words | {time_fmt} | {contribution} |\n")
    
    print(f"{BLUE}Summary created: {summary_path}{RESET}")

def categorize_output(outputs, output_dir):
    """Categorize the output based on models and content"""
    # Determine the appropriate category
    prompt = outputs["prompt"].lower()
    models = " ".join(outputs["models"]).lower()
    
    if any(term in prompt or term in models for term in ["guitar", "music", "practice"]):
        category = "guitar_learning"
    elif any(term in prompt or term in models for term in ["budget", "finance", "money"]):
        category = "financial_plans"
    elif any(term in prompt or term in models for term in ["career", "job", "profession"]):
        category = "career_plans"
    elif any(term in models for term in ["master_coder", "code_reviewer"]):
        category = "technical_solutions"
    else:
        category = "business_strategies"
    
    # Create category directory and symlink
    category_dir = os.path.join(OUTPUT_DIR, category)
    os.makedirs(category_dir, exist_ok=True)
    
    try:
        link_path = os.path.join(category_dir, os.path.basename(output_dir))
        if os.path.exists(link_path):
            os.remove(link_path)
        os.symlink(output_dir, link_path)
        print(f"{GREEN}Output categorized as: {category}{RESET}")
    except Exception as e:
        print(f"{RED}Error creating category link: {e}{RESET}")

def run_role_chain(solution, models):
    """Run a technical solution through specialized roles"""
    # For role chains, always use the technical_solutions category
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_dir = os.path.join(OUTPUT_DIR, f"role_chain_{timestamp}")
    
    return run_chain(solution, models, output_dir)

def list_available_models():
    """List all available Ollama models"""
    try:
        response = requests.get("http://localhost:11434/api/tags")
        models = response.json().get("models", [])
        
        print(f"{BLUE}{BOLD}Available Ollama Models:{RESET}")
        for model in models:
            print(f"  - {model['name']}")
    except Exception as e:
        print(f"{RED}Error listing models: {e}{RESET}")

def list_mirador_roles():
    """List all Mirador specialized roles and their purposes"""
    print(f"{BLUE}{BOLD}Mirador Specialized Roles:{RESET}")
    for role, details in ROLES.items():
        temp = details["temp"]
        print(f"  - {role} (temp={temp})")

def list_chain_templates():
    """List all predefined chain templates"""
    print(f"{BLUE}{BOLD}Predefined Chain Templates:{RESET}")
    for name, models in CHAIN_TEMPLATES.items():
        print(f"  - {name}: {' → '.join(models)}")

def interactive_mode():
    """Run Mirador in interactive mode"""
    print_header()
    print(f"{BOLD}Welcome to Mirador Interactive Mode{RESET}")
    print("Type 'help' to see available commands or 'exit' to quit")
    
    while True:
        try:
            command = input(f"\n{BOLD}mirador>{RESET} ").strip()
            
            if command.lower() in ('exit', 'quit'):
                print("Goodbye!")
                break
                
            elif command.lower() == 'help':
                print("\nAvailable commands:")
                print("  help                - Show this help message")
                print("  exit, quit          - Exit the program")
                print("  models              - List available Ollama models")
                print("  roles               - List specialized Mirador roles")
                print("  templates           - List predefined chain templates")
                print("  chain PROMPT MODEL1 MODEL2 [MODEL3] - Run a model chain")
                print("  template NAME PROMPT - Run a predefined chain template")
                print("  ask MODEL PROMPT    - Query a single model")
                print("  code SOLUTION MODEL1 [MODEL2] [MODEL3] - Analyze code/solution")
                
            elif command.lower() == 'models':
                list_available_models()
                
            elif command.lower() == 'roles':
                list_mirador_roles()
                
            elif command.lower() == 'templates':
                list_chain_templates()
                
            elif command.lower().startswith('ask '):
                parts = command.split(' ', 2)
                if len(parts) != 3:
                    print(f"{RED}Usage: ask MODEL PROMPT{RESET}")
                    continue
                    
                _, model, prompt = parts
                query_model(model, prompt)
                
            elif command.lower().startswith('chain '):
                parts = command.split(' ')
                if len(parts) < 3:
                    print(f"{RED}Usage: chain PROMPT MODEL1 MODEL2 [MODEL3]{RESET}")
                    continue
                    
                prompt = parts[1]
                models = parts[2:]
                run_chain(prompt, models)
                
            elif command.lower().startswith('template '):
                parts = command.split(' ', 2)
                if len(parts) != 3:
                    print(f"{RED}Usage: template NAME PROMPT{RESET}")
                    continue
                    
                _, template_name, prompt = parts
                if template_name not in CHAIN_TEMPLATES:
                    print(f"{RED}Unknown template: {template_name}{RESET}")
                    print(f"Available templates: {', '.join(CHAIN_TEMPLATES.keys())}")
                    continue
                    
                models = CHAIN_TEMPLATES[template_name]
                run_chain(prompt, models)
                
            elif command.lower().startswith('code '):
                parts = command.split(' ', 2)
                if len(parts) < 3:
                    print(f"{RED}Usage: code SOLUTION MODEL1 [MODEL2] [MODEL3]{RESET}")
                    continue
                    
                _, solution, *models = parts
                if not models:
                    # Default to code template if no models specified
                    models = CHAIN_TEMPLATES["code"]
                    
                run_role_chain(solution, models)
                
            else:
                print(f"{RED}Unknown command: {command}{RESET}")
                print("Type 'help' to see available commands")
                
        except KeyboardInterrupt:
            print("\nOperation cancelled")
        except Exception as e:
            print(f"{RED}Error: {e}{RESET}")

def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(description="Mirador AI Orchestration Framework")
    subparsers = parser.add_subparsers(dest="command", help="Command to run")
    
    # Chain command
    chain_parser = subparsers.add_parser("chain", help="Run a model chain")
    chain_parser.add_argument("prompt", help="The initial prompt")
    chain_parser.add_argument("models", nargs="*", help="Models to use in sequence (optional with conductor)")
    chain_parser.add_argument("--no-conductor", action="store_true", help="Disable conductor for model selection")
    
    # Conductor command
    conductor_parser = subparsers.add_parser("conductor", help="Analyze task and recommend specialists")
    conductor_parser.add_argument("prompt", help="The task to analyze")
    conductor_parser.add_argument("--execute", action="store_true", help="Execute the recommended chain")
    
    # Template command
    template_parser = subparsers.add_parser("template", help="Run a predefined chain template")
    template_parser.add_argument("name", choices=CHAIN_TEMPLATES.keys(), help="Template name")
    template_parser.add_argument("prompt", help="The initial prompt")
    
    # Ask command
    ask_parser = subparsers.add_parser("ask", help="Query a single model")
    ask_parser.add_argument("model", help="Model to query")
    ask_parser.add_argument("prompt", help="The prompt to send")
    
    # Code command
    code_parser = subparsers.add_parser("code", help="Run a technical solution through specialized roles")
    code_parser.add_argument("solution", help="The code or technical solution")
    code_parser.add_argument("models", nargs="*", help="Models to use in sequence")
    code_parser.add_argument("--no-conductor", action="store_true", help="Disable conductor for model selection")
    
    # Models command
    subparsers.add_parser("models", help="List available Ollama models")
    
    # Roles command
    subparsers.add_parser("roles", help="List specialized Mirador roles")
    
    # Templates command
    subparsers.add_parser("templates", help="List predefined chain templates")
    
    # Parse arguments
    args = parser.parse_args() if len(sys.argv) > 1 else parser.parse_args(["interactive"])
    
    # Create output directory if it doesn't exist
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    
    # Use local imports for conductor if needed
    conductor_module = None
    try:
        sys.path.append(os.path.dirname(os.path.abspath(__file__)))
        from conductor import ConductorAgent
        conductor_module = ConductorAgent()
    except ImportError:
        print(f"{YELLOW}Conductor not available, using fixed chains.{RESET}")
    
    if args.command == "chain":
        # Use conductor unless explicitly disabled
        use_conductor = conductor_module is not None and not getattr(args, 'no_conductor', False)
        use_models = args.models if hasattr(args, 'models') and args.models else None
        run_chain(args.prompt, use_models, use_conductor=use_conductor)
    
    elif args.command == "conductor":
        if conductor_module is None:
            print(f"{RED}Error: Conductor module not available.{RESET}")
            sys.exit(1)
            
        # Analyze task with conductor
        result = conductor_module.ask_conductor(args.prompt)
        print(f"{YELLOW}Conductor Analysis:{RESET}\n{result['explanation']}\n")
        
        # Execute chain if requested
        if getattr(args, 'execute', False):
            run_chain(args.prompt, result["specialists"], use_conductor=False)
    
    elif args.command == "template":
        run_chain(args.prompt, CHAIN_TEMPLATES[args.name], use_conductor=False)
    
    elif args.command == "ask":
        query_model(args.model, args.prompt)
    
    elif args.command == "code":
        # Use conductor for code analysis unless explicitly disabled
        use_conductor = conductor_module is not None and not getattr(args, 'no_conductor', False)
        
        if use_conductor and (not hasattr(args, 'models') or not args.models):
            # Analyze code with conductor
            result = conductor_module.ask_conductor(args.solution)
            models = result["specialists"]
            print(f"{YELLOW}Conductor Analysis:{RESET}\n{result['explanation']}\n")
        else:
            # Use provided models or default code chain
            models = args.models if hasattr(args, 'models') and args.models else CHAIN_TEMPLATES["code"]
            
        run_role_chain(args.solution, models)
    
    elif args.command == "models":
        list_available_models()
    
    elif args.command == "roles":
        list_mirador_roles()
    
    elif args.command == "templates":
        list_chain_templates()
    
    else:
        # Default to interactive mode
        interactive_mode()

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nOperation cancelled by user")
    except Exception as e:
        print(f"{RED}Error: {e}{RESET}")