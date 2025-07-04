# Workflow Patterns & Optimal Model Combinations

This guide documents established patterns for combining specialized models in the Mirador Framework to solve complex problems across different domains.

## Core Workflow Patterns

### 1. Create → Review → Document Pattern

**Best for**: Software development, technical solutions, code projects

**Standard Sequence**:
1. `master_coder`: Creates the initial implementation
2. `code_reviewer_fix`: Reviews for bugs, security issues, and performance
3. `file_reviewer`: Creates documentation and explanatory materials

**Example Command**:
```bash
./scripts/run_chain.sh "Create a secure user authentication system in Python" master_coder code_reviewer_fix file_reviewer
```

**When to use**: For any technical solution that needs implementation, security review, and documentation.

### 2. Design → Implement → Test Pattern

**Best for**: Building complete software features

**Standard Sequence**:
1. `ux_designer`: Creates the user experience design
2. `master_coder`: Implements the technical solution
3. `code_reviewer_fix`: Tests, validates, and improves the implementation

**Example Command**:
```bash
./scripts/run_chain.sh "Design a password reset feature for a web app" ux_designer master_coder code_reviewer_fix
```

**When to use**: When building user-facing features that require both design and technical implementation.

### 3. Research → Apply → Monetize Pattern

**Best for**: Business solutions, product development

**Standard Sequence**:
1. `enhanced_agent`: Researches deeply into the problem space
2. `master_coder`: Implements a technical solution
3. `creative_entrepreneur`: Identifies business opportunities and marketing strategies

**Example Command**:
```bash
./scripts/run_chain.sh "Create a guitar learning application" enhanced_agent master_coder creative_entrepreneur
```

**When to use**: When developing a solution that needs market analysis and business strategy.

### 4. Expert → Content Creation Pattern

**Best for**: Educational materials, tutorials, learning resources

**Standard Sequence**:
1. `guitar_expert_precise` / `master_coder` / domain expert: Provides specialized knowledge
2. `fast_agent_focused`: Structures the content clearly
3. `creative_entrepreneur`: Enhances engagement and presentation

**Example Command**:
```bash
./scripts/run_chain.sh "Create a beginner's guide to sweep picking" guitar_expert_precise fast_agent_focused creative_entrepreneur
```

**When to use**: For creating educational content that needs to be both technically accurate and engaging.

## Domain-Specific Combinations

### Software Development Domain

**Rapid Prototyping**:
```bash
domain-collab domain dev "Prototype a REST API for user management"
```
Uses: `master_coder` → `code_reviewer_fix` → `security_expert`

**Complete Project**:
```bash
./mirador-collaborate --specialists ux_designer master_coder code_reviewer_fix file_reviewer "Create a complete user authentication system"
```

**Code Interview Preparation**:
```bash
./scripts/run_chain.sh "Prepare interview solutions for sorting algorithms" master_coder enhanced_agent
```

### Music Education Domain

**Practice Routine Creation**:
```bash
domain-collab domain music "Create a jazz improvisation practice routine"
```
Uses: `guitar_expert_precise` → `content_creator`

**Comprehensive Learning Plan**:
```bash
./mirador-collaborate --specialists guitar_expert_precise fast_agent_focused creative_entrepreneur "Design a 30-day guitar improvement program"
```

**Song Analysis and Learning**:
```bash
./scripts/run_chain.sh "Analyze the guitar techniques in Master of Puppets" guitar_expert_precise llama3.2_balanced
```

### Business Development Domain

**Product Ideation**:
```bash
domain-collab domain business "Generate SaaS ideas for the fitness market"
```
Uses: `creative_entrepreneur` → `content_creator`

**Market Analysis**:
```bash
./mirador-collaborate --specialists enhanced_agent creative_entrepreneur "Analyze the market for guitar learning apps"
```

**Business Plan Development**:
```bash
./scripts/run_chain.sh "Create a business plan for a guitar teaching studio" creative_entrepreneur fast_agent_focused
```

## Bidirectional Communication Patterns

Unlike sequential chains, bidirectional communication allows specialists to query each other for information.

### Development Team Simulation

```bash
./mirador-collaborate --specialists master_coder security_expert ux_designer "Design a secure password reset system"
```

In this pattern:
- `master_coder` can ask `security_expert` about security best practices
- `security_expert` can request implementation details from `master_coder`
- `ux_designer` can coordinate with both to ensure security doesn't compromise usability

### Cross-Domain Expert Panel

```bash
./mirador-collaborate --specialists guitar_expert_precise master_coder creative_entrepreneur "Create a guitar learning application with practice tracking"
```

In this pattern:
- `guitar_expert_precise` provides music education expertise
- `master_coder` implements technical specifications
- `creative_entrepreneur` identifies business opportunities and user engagement strategies

## Custom Workflow Creation

You can create custom workflows by selecting specialists based on these principles:

1. **Balance precision and creativity**:
   - At least one low-temperature model (0.3-0.4) for precise, factual content
   - At least one high-temperature model (0.6-0.7) for creative ideas

2. **Include domain expertise**:
   - Select domain-specific models for specialized knowledge (e.g., `guitar_expert_precise` for music)

3. **Consider implementation needs**:
   - Technical implementation: include `master_coder`
   - Documentation: include `file_reviewer`
   - Business aspects: include `creative_entrepreneur`

4. **Limit chain length**:
   - Optimal performance with 2-3 specialists
   - For more complex needs, use bidirectional communication instead of longer chains

## Workflow Examples by Complexity

### Simple (Single Model)
```bash
./scripts/direct-ollama.sh fast-agent "What is the capital of France?"
```

### Moderate (Sequential Chain)
```bash
./scripts/run_chain.sh "Create a Python function to sort a list" master_coder code_reviewer_fix
```

### Complex (Bidirectional Communication)
```bash
./mirador-collaborate --specialists master_coder security_expert ux_designer file_reviewer "Create a secure user authentication system"
```

### Enterprise (Domain-Specific With Intervention)
```bash
domain-collab --visualize domain dev "Design a microservice architecture for a financial application"
```

By following these established patterns, you can effectively leverage the specialized capabilities of each model while ensuring comprehensive solutions to complex problems.