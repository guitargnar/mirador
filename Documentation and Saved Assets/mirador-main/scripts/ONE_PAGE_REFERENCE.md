# Ollama Quick Reference

## 📝 Model Selection Guide

| When You Need | Use This Model | Sample Prompt |
|---------------|----------------|---------------|
| **Quick facts/answers** | `fast-agent` | "What is the capital of France?" |
| **Structured information** | `fast_agent_focused` | "Steps to make sourdough bread" |
| **Deep research** | `enhanced-agent` | "Explain quantum computing applications" |
| **Guitar instruction** | `guitar_expert_precise` | "Show G major scale with tabs" |
| **Code creation** | `master_coder` | "Write a Python function to sort a list" |
| **Code review** | `code_reviewer_fix` | "Review this authentication function" |
| **Documentation** | `file_reviewer` | "Document this API endpoint" |
| **Business ideas** | `creative_entrepreneur` | "Monetize a guitar learning app" |
| **UI/UX design** | `ux_designer` | "Design a music app interface" |

## 🛠️ Command Syntax

**Direct API (no session):**
```bash
./direct-ollama.sh fast-agent "What is Python?"
```

**Standard Ollama:**
```bash
ollama run master_coder "Create a Python function"
```

**Multi-model chain:**
```bash
./scripts/run_chain.sh "Create an app" master_coder code_reviewer_fix
```

## 🌟 Optimal Combinations

| Task | Models to Chain |
|------|----------------|
| **Code project** | master_coder → code_reviewer_fix → file_reviewer |
| **Business app** | master_coder → creative_entrepreneur → ux_designer |
| **Music content** | guitar_expert_precise → creative_entrepreneur |
| **Tech research** | enhanced_agent → master_coder → creative_entrepreneur |

## 🎯 Temperature Settings

| Model | Temp | Best For |
|-------|------|----------|
| `fast-agent` | 0.3 | Precise, concise answers |
| `enhanced-agent` | 0.7 | Creative, thorough analysis |
| `master_coder` | 0.4 | Clean, working code |
| `guitar_expert_precise` | 0.4 | Accurate music instruction |
| `creative_entrepreneur` | 0.7 | Creative business ideas |
