# Mirador Simple Command Reference

## 🎯 Purpose-Aligned Commands

### Daily Life Optimization
```bash
# Morning planning
./bin/mirador_auto_router.sh "What should I focus on today based on my goals?"

# Financial check
./bin/mirador_auto_router.sh "Analyze my spending patterns and suggest optimizations"

# Career progression
./bin/mirador_auto_router.sh "Evaluate my current role and suggest next career moves"
```

### Document & File Analysis
```bash
# Analyze any document (PDF, TXT, MD, etc.)
./bin/mirador_rag_chain.sh document "Summarize key points" /path/to/document.pdf

# Code review
./bin/mirador_rag_chain.sh code "Review for improvements" /path/to/code.py

# Research paper analysis
./bin/mirador_rag_chain.sh research "Extract methodology" /path/to/paper.pdf
```

### Strategic Thinking
```bash
# Business strategy
./bin/mirador_hybrid_chains.sh synthesis "Develop 90-day plan for my startup"

# Creative projects
./bin/mirador_hybrid_chains.sh creative "Generate ideas for my music album"

# Technical solutions
./bin/mirador_hybrid_chains.sh technical "Design architecture for my app"
```

### Quick Decisions
```bash
# Fast analysis (uses smallest models)
./mirador_universal_runner_v2.sh life_optimization "Should I take this job offer?" quick

# Detailed analysis (uses full chain)
./mirador_universal_runner_v2.sh business_acceleration "Market analysis for my product" detailed
```

## 📊 Output Formats

All commands generate:
- **Summary**: Quick overview in `outputs/*/summary.md`
- **Full Analysis**: Complete chain output in `outputs/*/full_analysis.md`
- **Next Steps**: Actionable items in `outputs/*/next_steps.md`

## 🔄 Feedback Loop

After any command, rate the output:
```bash
./mirador_feedback.sh SESSION_ID 5 "Helped me save 2 hours of research"
```

## 💡 Pro Tips

1. **Let the auto-router decide**: Just describe what you need
2. **Use RAG for documents**: Best for analyzing existing content
3. **Use hybrid chains for synthesis**: Best for creating new strategies
4. **Check outputs folder**: All sessions are saved with timestamps