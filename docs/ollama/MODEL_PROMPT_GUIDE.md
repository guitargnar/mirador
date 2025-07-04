# Ollama Models & Optimal Prompts Guide

This guide maps each of your specialized Ollama models to the most effective prompts based on their system configurations and optimization parameters.

## Fast Response Models

### fast-agent (temp: 0.3, context: 2048)
*Optimized for speed and efficiency with concise, direct responses*

**Best For:**
- Quick factual questions
- Simple explanations
- Brief summaries
- Rapid task management

**Optimal Prompts:**
```bash
./direct-ollama.sh fast-agent "What is the capital of France?"
./direct-ollama.sh fast-agent "Summarize the key points of quantum computing"
./direct-ollama.sh fast-agent "List 5 exercises for improving posture"
```

### fast_agent_focused (temp: 0.3, context: 2048)
*Enhanced version with more structured, focused responses*

**Best For:**
- Structured information needs
- Step-by-step instructions
- Organized lists and points
- Quick reference information

**Optimal Prompts:**
```bash
./direct-ollama.sh fast_agent_focused "What are the steps to change a tire?"
./direct-ollama.sh fast_agent_focused "Give me a structured weekly workout plan"
./direct-ollama.sh fast_agent_focused "List the key components of a good resume"
```

## Deep Analysis Models

### enhanced-agent (temp: 0.7, context: 8192)
*Specialized in comprehensive analysis with multiple perspectives*

**Best For:**
- Research questions
- Complex explanations
- Nuanced topics
- Technical deep dives

**Optimal Prompts:**
```bash
./direct-ollama.sh enhanced-agent "Explain the ethical considerations of AI in healthcare"
./direct-ollama.sh enhanced-agent "Analyze the impact of remote work on company culture"
./direct-ollama.sh enhanced-agent "Compare different approaches to climate change mitigation"
```

### enhanced_agent (temp: 0.7, context: 8192)
*Research agent specialized in Python, AI, ML, and Security*

**Best For:**
- AI/ML explanations
- Security analysis
- Python development questions
- Technical comparisons

**Optimal Prompts:**
```bash
./direct-ollama.sh enhanced_agent "Explain how transformers work in deep learning"
./direct-ollama.sh enhanced_agent "What are best practices for securing a Python web application?"
./direct-ollama.sh enhanced_agent "Compare PyTorch and TensorFlow for NLP projects"
```

## Music & Guitar Models

### guitar_expert_precise (temp: 0.4, context: 16384)
*Guitar specialist with tablature generation capabilities*

**Best For:**
- Technique explanations with tabs
- Practice routines with examples
- Music theory for guitarists
- Song analysis and tablature

**Optimal Prompts:**
```bash
./direct-ollama.sh guitar_expert_precise "Show me a G major scale pattern with tablature"
./direct-ollama.sh guitar_expert_precise "Create a practice routine for sweep picking with tab examples"
./direct-ollama.sh guitar_expert_precise "Explain suspended chords with fretboard diagrams"
```

### guitar-expert (temp: 0.4, context: 16384)
*Base guitar specialist model*

**Best For:**
- General guitar questions
- Basic technique explanations
- Music theory concepts
- Genre exploration

**Optimal Prompts:**
```bash
./direct-ollama.sh guitar-expert "What is the CAGED system on guitar?"
./direct-ollama.sh guitar-expert "How do I improve my alternate picking?"
./direct-ollama.sh guitar-expert "Explain the use of modal interchange in composition"
```

## Coding & Development Models

### master_coder (temp: 0.4, context: 8192)
*Senior software engineer focused on clean, modular code*

**Best For:**
- Code implementation requests
- Software architecture design
- Best practices implementation
- Full function/class development

**Optimal Prompts:**
```bash
./direct-ollama.sh master_coder "Create a Python function to parse CSV files efficiently"
./direct-ollama.sh master_coder "Design a class hierarchy for a library management system"
./direct-ollama.sh master_coder "Implement a REST API endpoint for user authentication in Node.js"
```

### code_reviewer_fix (temp: 0.3, context: 8192)
*Code review specialist identifying bugs and security issues*

**Best For:**
- Code review requests
- Security vulnerability assessment
- Performance optimization
- Refactoring suggestions

**Optimal Prompts:**
```bash
./direct-ollama.sh code_reviewer_fix "Review this authentication function: function auth(user, pass) { return user === 'admin' && pass === 'password'; }"
./direct-ollama.sh code_reviewer_fix "Identify security issues in this API endpoint code: app.get('/user/:id', (req, res) => { res.send(db.getUser(req.params.id)); });"
./direct-ollama.sh code_reviewer_fix "How can I optimize this database query function for performance?"
```

### file_reviewer (temp: 0.4, context: 8192)
*Technical documentation specialist*

**Best For:**
- Documentation creation
- API documentation
- README generation
- Code explanation

**Optimal Prompts:**
```bash
./direct-ollama.sh file_reviewer "Create API documentation for this function: function createUser(username, email, password) {...}"
./direct-ollama.sh file_reviewer "Write a README.md for a React component library"
./direct-ollama.sh file_reviewer "Document this Python class with proper docstrings"
```

## Business & Design Models

### creative_entrepreneur (temp: 0.7, context: 8192)
*Visionary entrepreneur identifying business opportunities*

**Best For:**
- Business idea generation
- Market opportunity analysis
- Monetization strategies
- Startup planning

**Optimal Prompts:**
```bash
./direct-ollama.sh creative_entrepreneur "What business opportunities exist in the AI fitness space?"
./direct-ollama.sh creative_entrepreneur "Suggest monetization strategies for a guitar learning app"
./direct-ollama.sh creative_entrepreneur "Create a business plan outline for a tech consulting firm"
```

### ux_designer (temp: 0.7, context: 16384)
*UI/UX specialist for technical solutions*

**Best For:**
- Interface design suggestions
- User flow planning
- UX improvements
- Design system planning

**Optimal Prompts:**
```bash
./direct-ollama.sh ux_designer "Design a user flow for a password reset feature"
./direct-ollama.sh ux_designer "Create a wireframe description for a music learning app"
./direct-ollama.sh ux_designer "Suggest UX improvements for this checkout process"
```

## Specialized Architecture Models

### llama3.2_balanced (temp: 0.6, context: 8192)
*Balanced model with general capabilities*

**Best For:**
- Balanced responses with some creativity
- General knowledge questions
- Creative writing with factual elements
- Thoughtful discussions

**Optimal Prompts:**
```bash
./direct-ollama.sh llama3.2_balanced "Write a short story about AI in the year 2050"
./direct-ollama.sh llama3.2_balanced "Discuss the pros and cons of remote work"
./direct-ollama.sh llama3.2_balanced "What are some unusual applications of blockchain technology?"
```

### my-persistent-agent (temp: varies, context: large)
*Your custom agent for deep research and persistent context*

**Best For:**
- In-depth research topics
- Document analysis
- Complex problem solving
- Extended context requirements

**Optimal Prompts:**
```bash
./direct-ollama.sh my-persistent-agent "Research the history and current state of quantum computing"
./direct-ollama.sh my-persistent-agent "Analyze the factors that lead to successful startup ecosystems"
./direct-ollama.sh my-persistent-agent "Provide a comprehensive overview of modern web security practices"
```

## Powerful Combinations

For complex needs, combining models in sequence provides powerful results:

### Code Development Pipeline
```bash
# Create → Review → Document
./scripts/run_chain.sh "Create a secure authentication system" master_coder code_reviewer_fix file_reviewer
```

### Business Product Development
```bash
# Design → Business → User Experience
./scripts/run_chain.sh "Design a guitar learning application" master_coder creative_entrepreneur ux_designer
```

### Music Curriculum Development
```bash
# Expert Knowledge → Content Creation
./scripts/run_chain.sh "Create a sweep picking curriculum" guitar_expert_precise creative_entrepreneur
```

These combinations leverage the specialized optimization of each model for comprehensive solutions.
