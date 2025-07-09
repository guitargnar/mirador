# 📚 MIRADOR Usage Guide

## 🎯 Overview

MIRADOR can be used in two ways:
1. **Global Command**: `mirador-ez` (works from anywhere)
2. **Direct Python**: `python3 mirador.py` (from project directory)

## 🔧 Command Syntax

```bash
mirador-ez [command] [options]
```

### Available Commands

| Command | Description | Syntax |
|---------|-------------|--------|
| `models` | List all available AI models | `mirador-ez models` |
| `ask` | Query a single model | `mirador-ez ask [MODEL] "question"` |
| `chain` | Run multiple models in sequence | `mirador-ez chain "task" [MODEL1] [MODEL2]...` |
| `template` | Run predefined chain templates | `mirador-ez template [TEMPLATE_NAME]` |
| `roles` | List specialized MIRADOR roles | `mirador-ez roles` |
| `templates` | List available templates | `mirador-ez templates` |

## 📖 Detailed Command Usage

### 1. Listing Models

```bash
mirador-ez models
```

Output shows all 17 available models:
- Custom specialists (5)
- Enhanced models (4)
- Base models (8)

### 2. Single Model Queries

```bash
mirador-ez ask [MODEL_NAME] "Your question or task"
```

#### Examples by Domain

**📝 Code Generation**
```bash
mirador-ez ask master_coder "Create a Python web scraper"
mirador-ez ask master_coder "Build a REST API with authentication"
mirador-ez ask master_coder "Write a sorting algorithm"
```

**🔍 Code Review**
```bash
mirador-ez ask code_reviewer_fix "Optimize this Python function for performance"
mirador-ez ask code_reviewer_fix "Review this: $(cat script.py)"
```

**💼 Business Strategy**
```bash
mirador-ez ask creative_entrepreneur "How to monetize an AI tool"
mirador-ez ask creative_entrepreneur "Business idea for AI automation"
mirador-ez ask creative_entrepreneur "Create a SaaS pricing strategy"
```

**🎸 Music & Guitar**
```bash
mirador-ez ask guitar_expert_precise "Explain sweep picking technique"
mirador-ez ask guitar_expert_precise "Create tabs for a metal riff in drop D"
mirador-ez ask guitar_expert_precise "Analyze this chord progression"
```

**🧠 Deep Analysis**
```bash
mirador-ez ask enhanced_agent "Explain quantum computing"
mirador-ez ask enhanced_agent "What will the world be like in 24 months?"
mirador-ez ask enhanced_agent "Analyze the impact of AI on education"
```

**⚡ Quick Responses**
```bash
mirador-ez ask fast_agent_focused "Quick explanation of Docker"
mirador-ez ask llama3.2_balanced "Write a Python function"
```

### 3. Multi-Model Chains

```bash
mirador-ez chain "Task description" [MODEL1] [MODEL2] [MODEL3]...
```

#### Chain Patterns by Use Case

**🚀 Full-Stack Development**
```bash
# Complete application development
mirador-ez chain "Build a task management app" master_coder ux_designer creative_entrepreneur code_reviewer_fix

# API Development
mirador-ez chain "Create a payment processing API" master_coder code_reviewer_fix enhanced_agent

# Frontend Development
mirador-ez chain "Modern React dashboard" ux_designer master_coder code_reviewer_fix
```

**💡 Business Development**
```bash
# Startup Ideation
mirador-ez chain "AI startup in healthcare" creative_entrepreneur enhanced_agent master_coder

# Market Analysis
mirador-ez chain "Analyze edtech market opportunity" enhanced_agent creative_entrepreneur

# Product Strategy
mirador-ez chain "SaaS product roadmap" creative_entrepreneur ux_designer master_coder
```

**🎨 Creative Projects**
```bash
# Music Technology
mirador-ez chain "Guitar learning platform" guitar_expert_precise master_coder ux_designer creative_entrepreneur

# Content Creation
mirador-ez chain "YouTube channel strategy" creative_entrepreneur enhanced_agent

# Game Development
mirador-ez chain "Music rhythm game concept" guitar_expert_precise master_coder ux_designer
```

**🔧 Code Quality Pipelines**
```bash
# Code Review Pipeline
mirador-ez chain "Review and optimize codebase" master_coder code_reviewer_fix

# Documentation
mirador-ez chain "Document this API" master_coder enhanced_agent

# Refactoring
mirador-ez chain "Refactor legacy code" code_reviewer_fix master_coder enhanced_agent
```

## 💡 Advanced Usage Patterns

### Saving Output to Files

```bash
# Save single model output
mirador-ez ask master_coder "Create a web scraper" > scraper.py

# Save chain summary
mirador-ez chain "Build app" master_coder ux_designer > app_plan.md
```

### Using File Input

```bash
# Review existing code
mirador-ez ask code_reviewer_fix "Review this: $(cat app.py)"

# Analyze project structure
mirador-ez ask enhanced_agent "Analyze this project: $(ls -la)"
```

### Chaining with Context

```bash
# First generate
mirador-ez ask master_coder "Create user authentication system" > auth.py

# Then review
mirador-ez ask code_reviewer_fix "Security review: $(cat auth.py)" > review.md

# Finally optimize
mirador-ez ask master_coder "Implement suggestions from: $(cat review.md)"
```

### Viewing Results

```bash
# Navigate to outputs
cd ~/ai_framework_git/outputs/

# View latest chain result
ls -t | head -1 | xargs -I {} cat {}/summary.md

# View specific model contribution
cat chain_20250605_001724/enhanced_agent_output.md
```

## 🎯 Model Selection Guide

### By Task Type

**Need Code?**
- Initial implementation: `master_coder`
- Optimization: `code_reviewer_fix`  
- Quick snippets: `llama3.2_balanced`
- Complex systems: Chain with `enhanced_agent`

**Need Business Insights?**
- Strategy: `creative_entrepreneur`
- Market analysis: `enhanced_agent`
- Quick ideas: `fast_agent_focused`
- Comprehensive plans: Chain multiple models

**Need Design?**
- UI/UX: `ux_designer`
- Implementation: Chain with `master_coder`
- User research: Chain with `enhanced_agent`

**Need Music/Guitar?**
- Techniques: `guitar_expert_precise`
- Theory: `enhanced_agent`
- Tabs/Notation: `guitar_expert_precise`
- Music apps: Chain with `master_coder`

### By Response Style

**Comprehensive & Detailed**
- `enhanced_agent` - Thorough analysis
- `enhanced_agent_v2` - Alternative deep analysis

**Quick & Concise**
- `fast_agent_focused` - Rapid responses
- `mistral` - Fast general purpose

**Balanced**
- `llama3.2_balanced` - Good all-rounder
- `llama3.2` - Base model

**Specialized**
- `codellama` - Code-focused
- `deepseek-coder-lowtemp` - Precise code generation

## 📊 Output Structure

Each chain creates:
```
chain_[timestamp]/
├── summary.md                    # Final synthesized result
├── [model1]_output.md           # First model's contribution
├── [model2]_output.md           # Second model's contribution
├── transition_1_to_2.md         # How ideas evolved
└── contributions.json           # Metrics and changes
```

### Output Categories
- `technical_solutions` - Code and implementations
- `business_strategies` - Business plans and analysis
- `guitar_learning` - Music-related content
- `content_creation` - General creative output

## 🚀 Power User Tips

### 1. Optimal Chain Order
- Start with analysis (`enhanced_agent`)
- Move to implementation (`master_coder`)
- Add polish (`ux_designer`)
- Review quality (`code_reviewer_fix`)
- Consider business (`creative_entrepreneur`)

### 2. Model Combinations
```bash
# The Analyst
enhanced_agent → creative_entrepreneur → llama3.2_balanced

# The Builder  
master_coder → code_reviewer_fix → enhanced_agent

# The Strategist
creative_entrepreneur → enhanced_agent → master_coder

# The Creative
guitar_expert_precise → creative_entrepreneur → master_coder
```

### 3. Handling Timeouts
- Complex models may timeout (120s limit)
- This is normal for deep thinking
- Results are still saved
- Check output directory for partial results

### 4. Best Practices
- Be specific in your prompts
- Use chains for complex tasks
- Save important outputs
- Review individual contributions
- Iterate based on results

## 🎪 Example Workflows

### Complete Project Development
```bash
# 1. Ideation
mirador-ez ask creative_entrepreneur "SaaS idea for remote teams"

# 2. Research
mirador-ez ask enhanced_agent "Analyze remote work collaboration tools market"

# 3. Design
mirador-ez chain "Design remote collaboration platform" ux_designer master_coder

# 4. Implementation
mirador-ez chain "Build MVP" master_coder code_reviewer_fix

# 5. Business Model
mirador-ez chain "Monetization strategy" creative_entrepreneur enhanced_agent
```

### Code Quality Pipeline
```bash
# 1. Generate
mirador-ez ask master_coder "Create async web scraper" > scraper.py

# 2. Review
mirador-ez ask code_reviewer_fix "Review: $(cat scraper.py)" > review.md

# 3. Optimize
mirador-ez ask master_coder "Apply improvements: $(cat review.md)" > scraper_v2.py

# 4. Document
mirador-ez ask enhanced_agent "Create docs for: $(cat scraper_v2.py)" > docs.md
```

## 🛠️ Troubleshooting

| Issue | Solution |
|-------|----------|
| "Conductor not available" | Normal - using fixed chains |
| Model timeout | Complex models thinking - check outputs |
| No output | Check `~/ai_framework_git/outputs/` |
| Command not found | Ensure using `mirador-ez` |
| Model not found | Run `mirador-ez models` to see available |

## 📝 Quick Reference Card

```bash
# Essential Commands
mirador-ez models                          # List models
mirador-ez ask [model] "prompt"           # Single query
mirador-ez chain "task" [m1] [m2]...     # Multi-model
mirador-ez --help                         # Get help

# Common Chains
mirador-ez chain "Build app" master_coder ux_designer creative_entrepreneur
mirador-ez chain "Review code" master_coder code_reviewer_fix
mirador-ez chain "Business plan" creative_entrepreneur enhanced_agent
mirador-ez chain "Music app" guitar_expert_precise master_coder creative_entrepreneur

# Power User
mirador-ez ask master_coder "prompt" > output.py
mirador-ez ask code_reviewer_fix "Review: $(cat file.py)"
cd ~/ai_framework_git/outputs/ && ls -t | head -1
```