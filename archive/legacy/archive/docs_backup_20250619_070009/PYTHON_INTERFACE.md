# Mirador Python Interface

The Mirador framework now includes a streamlined Python interface for interactive model orchestration.

## Getting Started

```bash
# Launch interactive mode
~/ai_framework_git/mirador

# Or use command-line mode
~/ai_framework_git/mirador chain "Create a guitar practice routine" guitar_expert_precise fast_agent_focused
```

## Key Features

- **Interactive CLI**: Full interactive mode with command history
- **Python API**: Built on the Ollama API for maximum flexibility
- **Role-Based Chains**: Specialized roles for code and technical solutions
- **Predefined Templates**: Common model chains for different domains
- **Streaming Responses**: Real-time output from models
- **Categorized Output**: Organized results by domain

## Commands

### Interactive Mode

When in interactive mode, you can use the following commands:

- `help` - Show help message
- `models` - List available Ollama models
- `roles` - List specialized Mirador roles
- `templates` - List predefined chain templates
- `ask MODEL PROMPT` - Query a single model
- `chain PROMPT MODEL1 MODEL2 [MODEL3]` - Run a model chain
- `template NAME PROMPT` - Run a predefined chain template
- `code SOLUTION MODEL1 [MODEL2] [MODEL3]` - Analyze code/solution

### Command-Line Mode

```bash
# Run a model chain
~/ai_framework_git/mirador chain "Your prompt here" model1 model2

# Use a predefined template
~/ai_framework_git/mirador template code "Your code problem here"

# Ask a single model
~/ai_framework_git/mirador ask llama3.2_balanced "Your question here"

# Analyze code
~/ai_framework_git/mirador code "function example() { return true; }"
```

## Predefined Templates

- `code`: master_coder → code_reviewer_fix → creative_entrepreneur
- `guitar`: guitar_expert_precise → fast_agent_focused
- `business`: llama3.2_balanced → creative_entrepreneur
- `document`: enhanced_agent → file_reviewer
- `ui`: master_coder → ux_designer

## Specialized Roles

- `creative_entrepreneur`: Identify business applications
- `enhanced_agent`: Comprehensive analysis and insights
- `master_coder`: Code optimization and improvement
- `code_reviewer_fix`: Bug and security fixes
- `file_reviewer`: Documentation generation
- `ux_designer`: User interface design
- `guitar_expert_precise`: Guitar practice routines
- `llama3.2_balanced`: Balanced analysis
- `fast_agent_focused`: Structured planning

## Output Organization

All outputs are saved to `~/ai_framework_git/outputs/` and categorized by domain:

- `guitar_learning/`: Guitar and music outputs
- `financial_plans/`: Financial planning outputs
- `career_plans/`: Career development outputs
- `technical_solutions/`: Code and technical solutions
- `business_strategies/`: Business analysis outputs