# Ollama & Mirador FAQ

## Basic Questions

**Q: What's the simplest way to use Ollama models?**  
A: Use the ultra-simple script: `./scripts/run-ollama.sh "Your question here"`

**Q: How do I specify which model to use?**  
A: Add the model name: `./scripts/run-ollama.sh master_coder "Create a function"`

**Q: How do I access models without session/context?**  
A: Use the direct script: `./scripts/direct-ollama.sh fast-agent "Quick question"`

**Q: Which model should I use for quick factual questions?**  
A: Use `fast-agent` for speed and precision.

**Q: How can I see what models are available?**  
A: Run `ollama list` to see all available models.

## Model Selection

**Q: Which model is best for code writing?**  
A: Use `master_coder` for clean, modular code implementation.

**Q: Which model is best for security reviews?**  
A: Use `code_reviewer_fix` to identify bugs and security issues.

**Q: Which model is best for guitar/music questions?**  
A: Use `guitar_expert_precise` for detailed instruction with tablature.

**Q: How do I choose the right temperature setting?**  
A: Lower (0.3-0.4) for precision, higher (0.6-0.7) for creativity.

**Q: What's the difference between fast-agent and fast_agent_focused?**  
A: `fast_agent_focused` provides more structured, organized information.

## Advanced Features

**Q: How do I chain multiple models together?**  
A: Use `./scripts/run_chain.sh "Prompt" model1 model2 model3`

**Q: How do I use domain-specific chains?**  
A: Use `domain-collab domain dev "Create a function"`

**Q: What domains are available in domain-collab?**  
A: music, dev, business, finance, cross, and custom

**Q: How do I enable bidirectional specialist communication?**  
A: Use `./mirador-collaborate "Your prompt here"`

**Q: How do I specify which specialists to use?**  
A: Use `./mirador-collaborate --specialists model1 model2 "Prompt"`

## Technical Questions

**Q: What's the difference between run-ollama.sh and direct-ollama.sh?**  
A: `run-ollama.sh` uses Ollama's CLI (maintains session), while `direct-ollama.sh` uses the API directly (no session).

**Q: How do context windows affect model performance?**  
A: Larger context windows (e.g., 16384 tokens) allow models to process more information but may be slower.

**Q: Can I modify the system prompts for models?**  
A: Yes, edit the modelfiles in `/src/models/optimized/` and rebuild with `ollama create`.

**Q: How many models should I chain together?**  
A: 2-3 models is optimal for most tasks; more can lead to diminishing returns.

**Q: How do I get visualization of specialist contributions?**  
A: Add the `--visualize` flag: `domain-collab --visualize domain dev "Prompt"`

## Troubleshooting

**Q: What if Ollama isn't responding?**  
A: Check if the Ollama service is running with `ps aux | grep ollama`

**Q: What if a model gives a poor response?**  
A: Try a different specialist or adjust the prompt to be more specific.

**Q: How do I update models to the latest version?**  
A: Run `ollama pull modelname` to update a specific model.

**Q: What if I get "model not found" errors?**  
A: Run `ollama list` to see available models, and `ollama pull` to download missing ones.

**Q: How do I stop a running model?**  
A: Press Ctrl+C to interrupt the current execution.