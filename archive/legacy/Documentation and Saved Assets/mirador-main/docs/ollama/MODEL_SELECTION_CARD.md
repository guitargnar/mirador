# Model Selection Quick Reference

## Choose the Right Model for Your Task

```
┌──────────────────────────────────────────────────────────────────┐
│ TASK TYPE                  │ RECOMMENDED MODEL                   │
├──────────────────────────────────────────────────────────────────┤
│ Quick factual question     │ fast-agent                          │
│ Structured information     │ fast_agent_focused                  │
│ Deep research              │ enhanced_agent                      │
│ Guitar/music instruction   │ guitar_expert_precise               │
│ Code implementation        │ master_coder                        │
│ Code review/security       │ code_reviewer_fix                   │
│ Documentation              │ file_reviewer                       │
│ Business ideas             │ creative_entrepreneur               │
│ User interface design      │ ux_designer                         │
│ Balanced response          │ llama3.2_balanced                   │
└──────────────────────────────────────────────────────────────────┘
```

## Command Reference by Complexity

```
┌──────────────────────────────────────────────────────────────────┐
│ INTERFACE                  │ COMMAND EXAMPLE                     │
├──────────────────────────────────────────────────────────────────┤
│ SIMPLEST (stateless)       │ ./scripts/direct-ollama.sh model    │
│ SIMPLE (with session)      │ ./scripts/run-ollama.sh [model]     │
│ DOMAIN-SPECIFIC            │ domain-collab domain dev "prompt"   │
│ SEQUENTIAL CHAIN           │ ./scripts/run_chain.sh "prompt" m1  │
│ BIDIRECTIONAL              │ ./mirador-collaborate "prompt"      │
└──────────────────────────────────────────────────────────────────┘
```

## Model Temperature Guide

```
┌──────────────────────────────────────────────────────────────────┐
│ TEMPERATURE  │ BEHAVIOR                │ BEST FOR                │
├──────────────────────────────────────────────────────────────────┤
│ 0.3 (LOW)    │ Precise, deterministic  │ Facts, code, technical  │
│ 0.4 (LOW)    │ Mostly deterministic    │ Documentation, music    │
│ 0.6 (MEDIUM) │ Balanced                │ General knowledge       │
│ 0.7 (HIGH)   │ Creative, varied        │ Ideas, design, business │
└──────────────────────────────────────────────────────────────────┘
```

## Optimal Model Combinations by Domain

```
┌──────────────────────────────────────────────────────────────────┐
│ DOMAIN       │ RECOMMENDED CHAIN                                 │
├──────────────────────────────────────────────────────────────────┤
│ SOFTWARE     │ master_coder → code_reviewer_fix → file_reviewer  │
│ BUSINESS     │ enhanced_agent → creative_entrepreneur            │
│ MUSIC        │ guitar_expert_precise → fast_agent_focused        │
│ PRODUCT DEV  │ ux_designer → master_coder → creative_entrepreneur│
│ EDUCATION    │ enhanced_agent → fast_agent_focused               │
└──────────────────────────────────────────────────────────────────┘
```

## Quick Examples by Task

```
┌──────────────────────────────────────────────────────────────────┐
│ "Tell me about Python"         │ ./direct-ollama.sh fast-agent   │
│ "Create a guitar practice"     │ domain-collab domain music      │
│ "Design a secure login system" │ domain-collab domain dev        │
│ "Create a business plan"       │ domain-collab domain business   │
└──────────────────────────────────────────────────────────────────┘
```