Mirador Architecture Overview
System Architecture Visualization
┌────────────────────────────────────────────────────────────────────────────┐
│                              MIRADOR AI SYSTEM                              │
│                         "Your Personal AI Orchestra"                        │
└────────────────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────────────────┐
│                            🎯 USER INTERFACE LAYER                          │
├────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐           │
│  │ mirador-smart-v2│  │   mirador-ez    │  │  Daily Scripts  │           │
│  │ (Smart Routing) │  │ (Direct Access) │  │  (Automation)   │           │
│  └────────┬────────┘  └────────┬────────┘  └────────┬────────┘           │
│           │                    │                     │                      │
│           └────────────────────┴─────────────────────┘                     │
│                                │                                            │
└────────────────────────────────┼────────────────────────────────────────────┘
                                 │
┌────────────────────────────────┼────────────────────────────────────────────┐
│                     🧠 ORCHESTRATION ENGINE                                │
├────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────┐      │
│  │                     Query Analysis & Routing                      │      │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │      │
│  │  │  Financial  │  │    Music    │  │   Local     │             │      │
│  │  │  Detector   │  │  Detector   │  │  Detector   │             │      │
│  │  └─────────────┘  └─────────────┘  └─────────────┘             │      │
│  └─────────────────────────────────────────────────────────────────┘      │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────┐      │
│  │                      Chain Execution Manager                      │      │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │      │
│  │  │   Context   │  │  Progress   │  │   Output    │             │      │
│  │  │   Builder   │  │  Tracker    │  │  Processor  │             │      │
│  │  └─────────────┘  └─────────────┘  └─────────────┘             │      │
│  └─────────────────────────────────────────────────────────────────┘      │
│                                                                             │
└────────────────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────────────────┐
│                        🤖 SPECIALIZED AI MODELS                            │
├────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────────┐     ┌─────────────────────┐                      │
│  │ PERSONALITY LAYER   │     │  DOMAIN EXPERTS     │                      │
│  ├─────────────────────┤     ├─────────────────────┤                      │
│  │ matthew_context_v3  │     │ financial_expert_v8 │                      │
│  │ • Big Five Profile  │     │ • $75k Optimization │                      │
│  │ • Goals & Values    │     │ • Louisville Focus  │                      │
│  │ • Family Context    │     │ • KY Tax Rules     │                      │
│  └─────────────────────┘     ├─────────────────────┤                      │
│                              │ louisville_expert_v3│                      │
│  ┌─────────────────────┐     │ • Local Resources  │                      │
│  │ SYNTHESIS LAYER     │     │ • Music Venues     │                      │
│  ├─────────────────────┤     │ • Networking Opps  │                      │
│  │ enhanced_agent_v1   │     ├─────────────────────┤                      │
│  │ • Strategic Analysis│     │ music_networker     │                      │
│  │ • Cross-Domain     │     │ • Industry Contacts │                      │
│  │ • Pattern Finding   │     │ • Tour Planning    │                      │
│  ├─────────────────────┤     │ • Skill Building   │                      │
│  │ decision_simplifier │     └─────────────────────┘                      │
│  │ • Action Generation │                                                   │
│  │ • Timeline Creation │     ┌─────────────────────┐                      │
│  │ • Priority Setting  │     │ META-COGNITIVE      │                      │
│  └─────────────────────┘     ├─────────────────────┤                      │
│                              │ system_specialist_v2│                      │
│                              │ • Self-Optimization │                      │
│                              │ • Pattern Learning  │                      │
│                              │ • Feedback Loops    │                      │
│                              └─────────────────────┘                      │
│                                                                             │
└────────────────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────────────────┐
│                         ⚙️ RUNTIME LAYER (Ollama)                          │
├────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐           │
│  │ Model Loader    │  │ Inference Engine│  │ Resource Manager│           │
│  │ • Dynamic Load  │  │ • LLaMA Runtime │  │ • Memory Limits │           │
│  │ • Hot Swap      │  │ • GPU Accel     │  │ • CPU Allocation│           │
│  │ • Caching       │  │ • Quantization  │  │ • Timeout Mgmt  │           │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘           │
│                                                                             │
└────────────────────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────────────────────┐
│                          💾 STORAGE & MEMORY LAYER                         │
├────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌──────────────────────────┐  ┌──────────────────────────┐              │
│  │    SQLite Database       │  │    File System          │              │
│  ├──────────────────────────┤  ├──────────────────────────┤              │
│  │ • analysis_history       │  │ • outputs/              │              │
│  │ • model_performance      │  │   └── chain_[timestamp] │              │
│  │ • success_patterns       │  │ • ~/.ollama/models/     │              │
│  │ • opportunities          │  │ • logs/                 │              │
│  │ • user_context          │  │ • cache/                │              │
│  └──────────────────────────┘  └──────────────────────────┘              │
│                                                                             │
└────────────────────────────────────────────────────────────────────────────┘
Data Flow Diagram
┌─────────┐      ┌─────────────┐      ┌──────────────┐
│  User   │      │   Smart     │      │   Pattern    │
│  Query  │ ───> │   Router    │ ───> │   Matcher    │
└─────────┘      └─────────────┘      └──────────────┘
                                              │
                                              ▼
                                    ┌─────────────────┐
                                    │  Chain Builder  │
                                    └─────────────────┘
                                              │
                 ┌────────────────────────────┴────────────────────────┐
                 ▼                            ▼                         ▼
        ┌──────────────┐            ┌──────────────┐          ┌──────────────┐
        │   Context    │            │    Domain    │          │  Synthesis   │
        │   Provider   │    ───>    │    Expert    │   ───>   │    Model     │
        └──────────────┘            └──────────────┘          └──────────────┘
                                                                       │
                                                                       ▼
                                                              ┌──────────────┐
                                                              │   Decision   │
                                                              │  Simplifier  │
                                                              └──────────────┘
                                                                       │
                 ┌─────────────────────────────────────────────────────┴───┐
                 ▼                           ▼                             ▼
        ┌──────────────┐           ┌──────────────┐             ┌──────────────┐
        │   Memory     │           │   Output     │             │    User      │
        │   Storage    │           │    Files     │             │   Response   │
        └──────────────┘           └──────────────┘             └──────────────┘
Chain Execution Patterns
Financial Query Chain
[User Query: "Budget optimization for $75k"]
         │
         ▼
[matthew_context_provider_v3]
    "User Profile: High Openness, Family-focused, Louisville-based"
         │
         ▼
[financial_planning_expert_v8]
    "Detailed budget with Louisville costs, KY taxes, savings goals"
         │
         ▼
[decision_simplifier_v3]
    "TODAY: Open high-yield savings
     THIS WEEK: Automate transfers
     THIS MONTH: Review investment options"
Music Career Chain
[User Query: "Become touring guitarist"]
         │
         ▼
[matthew_context_provider_v3]
    "Musical goals, Cody Ash connection, current skill level"
         │
         ▼
[music_industry_networker]
    "Nashville connections, touring requirements, skill gaps"
         │
         ▼
[master_guitar_instructor]
    "Practice routine, technique improvements, repertoire"
         │
         ▼
[decision_simplifier_v3]
    "Daily practice schedule with specific exercises"
Opportunity Discovery Chain
[User Query: "Top opportunities this week"]
         │
         ▼
[matthew_context_provider_v3]
    "Personality strengths, current priorities"
         │
         ▼
[enhanced_agent_enforcer]
    "Cross-domain analysis, pattern recognition"
         │
         ▼
[decision_simplifier_v3]
    "Prioritized action list with impact scores"
Model Communication Protocol
Context Propagation
python# Each model receives accumulated context
context = {
    "original_query": user_query,
    "user_profile": matthew_context_output,
    "previous_analyses": [model1_output, model2_output],
    "chain_position": current_step,
    "total_steps": len(chain)
}
Output Format
json{
    "model": "financial_planning_expert_v8",
    "timestamp": "2025-06-18T09:06:33",
    "execution_time": 22,
    "word_count": 523,
    "key_insights": ["budget_breakdown", "savings_strategy", "local_resources"],
    "confidence": 0.92,
    "content": "Full model response text..."
}
Performance Characteristics
Response Time Distribution
Individual Models:
┌─────────────────────────────────────┐
│ 0-5s   │████████░░░░░░░░░░░░│ 40%   │  <- Simple queries
│ 5-10s  │██████████████░░░░░░│ 70%   │  <- Most queries
│ 10-15s │████████████████████░│ 95%   │  <- Complex queries
│ 15-25s │█████████████████████│ 100%  │  <- Max observed
└─────────────────────────────────────┘

Chain Execution (3 models):
┌─────────────────────────────────────┐
│ 30-45s │██████████░░░░░░░░░░│ 50%   │  <- Fast chains
│ 45-60s │██████████████████░░│ 90%   │  <- Typical chains
│ 60-90s │█████████████████████│ 100%  │  <- Complex chains
└─────────────────────────────────────┘
Resource Usage
Memory per Model:
┌─────────────────────────────────────┐
│ Base Load      │ 2.0 GB             │
│ During Inference│ 3-4 GB             │
│ Peak Usage     │ 4.5 GB             │
└─────────────────────────────────────┘

CPU Usage Pattern:
┌─────────────────────────────────────┐
│ Idle           │ 1-2%               │
│ Model Loading  │ 40-60%             │
│ Inference      │ 60-80%             │
│ Peak (chains)  │ 90-100%            │
└─────────────────────────────────────┘
Scalability Considerations
Current Limits

Concurrent Chains: 1 (sequential execution)
Max Chain Length: 6 models (tested up to 4)
Context Window: 4096 tokens (8192 available)
Storage: 447 analyses in 22MB

Growth Potential

Parallel Execution: Independent models can run concurrently
Distributed Processing: Multiple Ollama instances possible
Cloud Integration: Optional for scaling beyond local resources
Model Specialization: Unlimited custom models can be added

Security Architecture
Data Protection Layers
┌─────────────────────────────────────┐
│         User Data                   │
├─────────────────────────────────────┤
│ • Local Storage Only               │
│ • No Network Transmission          │
│ • File System Permissions          │
└─────────────────────────────────────┘
              │
┌─────────────────────────────────────┐
│      Process Isolation              │
├─────────────────────────────────────┤
│ • Separate Model Contexts          │
│ • Memory Isolation                 │
│ • Resource Limits                  │
└─────────────────────────────────────┘
              │
┌─────────────────────────────────────┐
│     Output Sanitization             │
├─────────────────────────────────────┤
│ • No PII in Logs                   │
│ • Configurable Redaction           │
│ • Secure File Permissions          │
└─────────────────────────────────────┘
