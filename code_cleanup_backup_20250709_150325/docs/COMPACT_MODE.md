# Compact Mode Reference

This quick reference is designed for use with Claude Code's compact mode (`/compact`).

## Model Selection Guidance

```
┌───────────────────────────────────────────────────────────────┐
│ TASK                     │ MODEL             │ SCRIPT TO USE  │
├───────────────────────────────────────────────────────────────┤
│ Quick facts/answers      │ fast-agent        │ direct-ollama  │
│ Structured information   │ fast_agent_focused│ direct-ollama  │
│ Guitar instruction       │ guitar_expert     │ domain-collab  │
│ Code implementation      │ master_coder      │ direct-ollama  │
│ Security review          │ code_reviewer_fix │ direct-ollama  │
│ Business ideas           │ creative_entrep   │ direct-ollama  │
│ Multi-specialist collab  │ (varies)          │ mirador-collab │
└───────────────────────────────────────────────────────────────┘
```

## One-Line Commands

```bash
# Simplest: Default model (fast-agent)
./scripts/run-ollama.sh "Your question here"

# Direct model access (stateless)
./scripts/direct-ollama.sh fast-agent "Your question here"
./scripts/direct-ollama.sh master_coder "Create a function that sorts a list"

# Domain-specific chains
domain-collab domain dev "Create a secure login system"
domain-collab domain music "Show guitar sweep picking technique"

# Bidirectional specialist collaboration
./mirador-collaborate --specialists master_coder code_reviewer_fix "Create a function"
```

## Troubleshooting

- `Error: model not found`: Run `ollama list` to see available models, then `ollama pull <model>` if needed
- `Connection refused`: Start Ollama with `ollama serve`
- Wrong response format: Try a different model with appropriate temperature (lower for precision)

## Temperature Quick Reference

- 0.3: Precise, factual (fast-agent, code_reviewer_fix)
- 0.4: Technical, accurate (master_coder, guitar_expert_precise)
- 0.7: Creative, varied (creative_entrepreneur, ux_designer)

For full documentation, see:
- [Model & Prompt Guide](docs/ollama/MODEL_PROMPT_GUIDE.md)
- [Quick Reference](docs/ollama/ONE_PAGE_REFERENCE.md)
- [FAQ](docs/ollama/OLLAMA_FAQ.md)