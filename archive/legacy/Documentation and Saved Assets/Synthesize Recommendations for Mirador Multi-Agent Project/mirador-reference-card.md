# 🚀 MIRADOR AI Framework - Complete Reference Card

## 📍 Quick Access Commands

```bash
# From anywhere in terminal:
mirador-ez [command] [options]

# From ~/projects/mirador directory:
python3 mirador.py [command] [options]

# Legacy shortcuts (if set up):
deep "Research question"
work-ai "Work question"
```

## 🎯 Core Commands

### 1. **List Available Models**
```bash
mirador-ez models
```
Shows all 17 available AI models

### 2. **Ask a Single Model**
```bash
mirador-ez ask [MODEL_NAME] "Your question or task"

# Examples:
mirador-ez ask enhanced_agent "Explain quantum computing"
mirador-ez ask master_coder "Write a Python web scraper"
mirador-ez ask guitar_expert_precise "Create tabs for metal riff in drop D"
```

### 3. **Run Model Chains**
```bash
mirador-ez chain "Task description" [MODEL1] [MODEL2] [MODEL3...]

# Examples:
mirador-ez chain "Build a mobile app" master_coder ux_designer creative_entrepreneur
mirador-ez chain "Create web scraper" enhanced_agent llama3.2_balanced
mirador-ez chain "Analyze codebase" master_coder code_reviewer_fix
```

### 4. **Run Predefined Templates**
```bash
mirador-ez template [TEMPLATE_NAME]
```

### 5. **Get Help**
```bash
mirador-ez --help
mirador-ez ask --help
mirador-ez chain --help
```

## 🤖 Available Models & Their Specialties

### **Custom Specialist Models**
| Model | Specialty | Best For |
|-------|-----------|----------|
| `master_coder` | Senior software engineering | Code generation, architecture design |
| `code_reviewer_fix` | Code analysis & optimization | Code reviews, refactoring, bug fixes |
| `creative_entrepreneur` | Business strategy | Monetization, market analysis, startups |
| `guitar_expert_precise` | Guitar & music theory | Tablature, techniques, music analysis |
| `fast_agent_focused` | Quick concise answers | Rapid responses, summaries |

### **Enhanced Models**
| Model | Specialty | Best For |
|-------|-----------|----------|
| `enhanced_agent` | Deep analysis & research | Complex questions, detailed explanations |
| `enhanced_agent_v2` | Updated deep analysis | Alternative to enhanced_agent |
| `llama3.2_balanced` | Balanced responses | General tasks, coding, writing |
| `ux_designer` | UI/UX design | Interface design, user experience |

### **Base Models**
| Model | Specialty | Best For |
|-------|-----------|----------|
| `llama3.2` | General purpose | Versatile tasks |
| `mistral` | Fast responses | Quick queries |
| `codellama` | Code-focused | Programming tasks |
| `deepseek-extended` | Extended context | Long documents |
| `deepseek-coder-lowtemp` | Precise coding | Deterministic code generation |

### **Other Models**
- `fast_agent_ultimate`
- `fast_agent_llama`
- `my-persistent-agent`

## 💡 Usage Patterns & Examples

### **Single Model Queries**
```bash
# Technical
mirador-ez ask master_coder "Build REST API with authentication"
mirador-ez ask code_reviewer_fix "Optimize this Python function"

# Creative/Business
mirador-ez ask creative_entrepreneur "How to monetize an AI tool"
mirador-ez ask creative_entrepreneur "Business idea for AI automation"

# Music
mirador-ez ask guitar_expert_precise "Explain sweep picking technique"
mirador-ez ask guitar_expert_precise "Create death metal riff tabs"

# Research/Analysis
mirador-ez ask enhanced_agent "What will the world be like in 24 months?"
mirador-ez ask llama3.2_balanced "Write a Python function"

# Quick Answers
mirador-ez ask fast_agent_focused "Quick explanation of Docker"
```

### **Powerful Chain Combinations**

#### **Development Chains**
```bash
# Full development cycle
mirador-ez chain "Build e-commerce platform" master_coder ux_designer creative_entrepreneur

# Code review pipeline
mirador-ez chain "Review and optimize code" master_coder code_reviewer_fix

# Technical documentation
mirador-ez chain "Document API" master_coder enhanced_agent
```

#### **Business Chains**
```bash
# Startup ideation
mirador-ez chain "AI startup idea" creative_entrepreneur enhanced_agent master_coder

# Market analysis
mirador-ez chain "Analyze market opportunity" enhanced_agent creative_entrepreneur
```

#### **Creative Chains**
```bash
# Music tech fusion
mirador-ez chain "Guitar learning app" guitar_expert_precise master_coder ux_designer creative_entrepreneur

# Content creation
mirador-ez chain "Create tutorial" enhanced_agent llama3.2_balanced
```

## 🔧 Advanced Usage

### **Save Output to File**
```bash
mirador-ez ask master_coder "Create todo app" > todo_app.py
```

### **Chain with Context**
```bash
# First generate code
mirador-ez ask master_coder "Create Python script" > script.py

# Then review it
mirador-ez ask code_reviewer_fix "Review this: $(cat script.py)"
```

### **View Chain Results**
```bash
# Results are saved in:
cd ~/ai_framework_git/outputs/

# View latest result
ls -t | head -1 | xargs cat

# Each chain creates:
# - Individual model outputs
# - summary.md (final result)
# - Categorized by type (technical_solutions, business_strategies, etc.)
```

## 🎨 Output Categories

Chains automatically categorize outputs:
- `technical_solutions` - Code and technical implementations
- `business_strategies` - Business plans and analysis  
- `guitar_learning` - Music-related content
- `content_creation` - General creative content

## ⚡ Quick Tips

1. **For Complex Tasks**: Use chains with multiple specialists
2. **For Quick Answers**: Use `fast_agent_focused` or `mistral`
3. **For Code**: Start with `master_coder`, review with `code_reviewer_fix`
4. **For Business**: Combine `creative_entrepreneur` with `enhanced_agent`
5. **Timeouts**: Normal for complex models - they're thinking deeply!

## 🛠️ Troubleshooting

| Issue | Solution |
|-------|----------|
| "Conductor not available" | Normal - using fixed chains |
| Model timeout (120s) | Normal for complex tasks - model is thinking |
| Can't find output | Check `~/ai_framework_git/outputs/` |
| Command not found | Ensure you're using `mirador-ez` |

## 📊 Model Selection Guide

**Need Code?**
- First draft: `master_coder`
- Optimization: `code_reviewer_fix`
- Quick snippet: `llama3.2_balanced`

**Need Business Insights?**
- Strategy: `creative_entrepreneur`
- Deep analysis: `enhanced_agent`
- Quick ideas: `fast_agent_focused`

**Need Music/Guitar?**
- Techniques: `guitar_expert_precise`
- Theory integration: Chain with `enhanced_agent`

**Need UI/UX?**
- Design: `ux_designer`
- Implementation: Chain with `master_coder`

## 🚀 Power User Combos

```bash
# The Full Stack
mirador-ez chain "SaaS product" creative_entrepreneur master_coder ux_designer code_reviewer_fix

# The Analyst
mirador-ez chain "Market research" enhanced_agent creative_entrepreneur llama3.2_balanced

# The Musician's Toolkit
mirador-ez chain "Guitar course platform" guitar_expert_precise creative_entrepreneur master_coder

# The Code Perfectionist
mirador-ez chain "Production-ready code" master_coder code_reviewer_fix enhanced_agent
```

---

**Remember**: MIRADOR's power comes from combining specialists. Don't hesitate to chain multiple models for comprehensive solutions!