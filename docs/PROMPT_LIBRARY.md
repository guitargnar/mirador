# Mirador AI Framework - Comprehensive Prompt Library

## Overview

This comprehensive prompt library provides ready-to-use commands spanning all aspects of personal and professional life. Each command leverages Mirador's sophisticated chain-of-thought reasoning while respecting real-world constraints.

## Table of Contents

- [Quick Reference](#quick-reference)
- [Personal Productivity](#personal-productivity)
- [Career & Professional Development](#career--professional-development)
- [Technical & Coding](#technical--coding)
- [Financial Planning](#financial-planning)
- [Health & Wellness](#health--wellness)
- [Family & Relationships](#family--relationships)
- [Music & Creative](#music--creative)
- [Strategic Planning](#strategic-planning)
- [Learning & Development](#learning--development)
- [Louisville-Specific](#louisville-specific)
- [Advanced Combinations](#advanced-combinations)
- [Custom Chain Examples](#custom-chain-examples)

## Quick Reference

### Basic Command Structure
```bash
# Smart router (automatic chain selection)
./mirador-smart-v2 "Your query here"

# Universal runner with specific chain
./mirador_universal_runner_v2.sh <chain_type> "Your query" [format]

# Optimized runner with diverse models
./bin/mirador_universal_runner_v3_optimized.sh <chain_type> "Your query" [format]

# Simple interface
./mirador-ez chain "Your query" model1 model2 model3
```

### Available Chains
- `life_optimization` - Holistic life balance
- `business_acceleration` - Career and business growth
- `creative_breakthrough` - Innovation and creative solutions
- `relationship_harmony` - Family and relationships
- `technical_mastery` - Coding and technical tasks
- `strategic_synthesis` - High-level planning
- `deep_analysis` - Thorough investigation (v3)
- `global_insight` - Multicultural perspectives (v3)
- `rapid_decision` - Fast decisions (v3)

### Output Formats
- `quick` - Key points only
- `summary` - Executive summary
- `detailed` - Full analysis (default)
- `export` - Save to file

## Personal Productivity

### Daily Planning
```bash
# Optimize your daily schedule
./mirador-smart-v2 "Create an optimal daily schedule balancing work, family time with 3 teens, guitar practice, and personal projects"

# Morning routine optimization
./mirador_universal_runner_v2.sh life_optimization "Design a morning routine that maximizes energy for a 46-year-old single dad working in corporate tech"

# Time blocking strategy
./mirador-smart-v2 "Help me implement time blocking for maximum productivity with only 9 hours of personal time daily"
```

### Energy Management
```bash
# Energy optimization throughout the day
./mirador_universal_runner_v2.sh life_optimization "How can I maintain consistent energy levels throughout my workday given my constraints"

# Burnout prevention
./mirador-smart-v2 "Create a burnout prevention plan for someone juggling corporate job, parenting, and personal ambitions"

# Recovery strategies
./mirador_universal_runner_v2.sh life_optimization "Quick recovery techniques between meetings to maintain focus and energy" quick
```

### Task Prioritization
```bash
# Weekly priority setting
./mirador-smart-v2 "Help me prioritize my tasks for the week considering work deadlines, family commitments, and personal goals"

# Project management
./mirador_universal_runner_v2.sh strategic_synthesis "Create a project management system for balancing multiple initiatives with limited time"

# Decision making framework
./mirador_universal_runner_v3_optimized.sh rapid_decision "Should I focus on AI certification or building portfolio projects this month?"
```

## Career & Professional Development

### VP Track Strategy
```bash
# Career advancement roadmap
./mirador_universal_runner_v2.sh business_acceleration "Create a detailed 18-month roadmap to VP of AI Innovation at Humana"

# Leadership development
./mirador-smart-v2 "What leadership skills should I prioritize developing for a VP role in healthcare AI"

# Political navigation
./mirador_universal_runner_v2.sh business_acceleration "How to navigate corporate politics at Humana while maintaining authenticity"
```

### AI Innovation Leadership
```bash
# AI strategy for Humana
./mirador-smart-v2 "Develop an AI innovation strategy for Humana's risk management division"

# Innovation proposals
./mirador_universal_runner_v2.sh creative_breakthrough "Generate innovative AI use cases for healthcare risk management"

# Building influence
./mirador_universal_runner_v2.sh business_acceleration "How to build influence as an AI thought leader within a large healthcare organization"
```

### Networking & Visibility
```bash
# Strategic networking
./mirador-smart-v2 "Create a networking strategy to increase visibility with Humana executives"

# Personal branding
./mirador_universal_runner_v2.sh business_acceleration "Build a personal brand as an AI innovator within corporate constraints"

# Stakeholder management
./mirador-smart-v2 "How to manage stakeholders effectively while pushing for AI adoption"
```

## Technical & Coding

### Python Development
```bash
# Data processing script
./mirador-smart-v2 "Write a Python script to process healthcare claims data and identify anomalies"

# API development
./mirador_universal_runner_v2.sh technical_mastery "Create a FastAPI service for risk scoring with authentication and rate limiting"

# Automation scripts
./mirador-smart-v2 "Python script to automate daily risk management reports with email notifications"
```

### SQL Optimization
```bash
# Query optimization
./mirador-smart-v2 "Optimize this SQL query for better performance: [paste your query]"

# Database design
./mirador_universal_runner_v2.sh technical_mastery "Design a database schema for tracking AI model performance metrics"

# Complex queries
./mirador-smart-v2 "Write SQL to analyze member risk patterns across multiple dimensions"
```

### AI/ML Implementation
```bash
# Model deployment
./mirador-smart-v2 "How to deploy a risk prediction model using Humana's infrastructure"

# LLM integration
./mirador_universal_runner_v2.sh technical_mastery "Integrate Ollama models into existing Python application"

# Performance optimization
./mirador-smart-v2 "Optimize inference speed for local LLM deployment on Apple Silicon"
```

### Automation & DevOps
```bash
# CI/CD pipeline
./mirador-smart-v2 "Create GitHub Actions workflow for automated testing and deployment"

# Infrastructure as code
./mirador_universal_runner_v2.sh technical_mastery "Write Terraform configuration for deploying Mirador to cloud"

# Monitoring setup
./mirador-smart-v2 "Implement comprehensive monitoring for AI model performance"
```

## Financial Planning

### Budget Optimization
```bash
# Monthly budget analysis
./mirador-smart-v2 "Optimize my $1,650 monthly budget with 3 teenage kids"

# Savings strategies
./mirador_universal_runner_v2.sh financial "How to save for emergency fund on tight budget with teenage expenses"

# Expense reduction
./mirador-smart-v2 "Identify areas to reduce expenses without impacting family quality of life"
```

### Investment Planning
```bash
# Investment strategy
./mirador-smart-v2 "Create investment strategy for single parent with limited disposable income"

# Retirement planning
./mirador_universal_runner_v2.sh financial "Retirement saving options for 46-year-old with late start"

# College funding
./mirador-smart-v2 "Strategies to help with college expenses for 3 teenagers on limited budget"
```

### Financial Goals
```bash
# Short-term goals
./mirador_universal_runner_v3_optimized.sh rapid_decision "Should I prioritize debt reduction or emergency fund building?"

# Long-term planning
./mirador_universal_runner_v2.sh strategic_synthesis "Create 5-year financial plan balancing current needs with future security"

# Side income
./mirador-smart-v2 "Feasible side income opportunities that won't interfere with primary job and parenting"
```

## Health & Wellness

### Stress Management
```bash
# Corporate stress relief
./mirador-smart-v2 "Quick stress management techniques for high-pressure corporate environment"

# Work-life balance
./mirador_universal_runner_v2.sh life_optimization "Strategies to maintain work-life balance as single parent in demanding job"

# Mental health
./mirador-smart-v2 "Daily mental health practices for busy professional dealing with multiple stressors"
```

### Physical Health
```bash
# Exercise routine
./mirador-smart-v2 "Design 20-minute daily exercise routine for energy and stress relief"

# Nutrition planning
./mirador_universal_runner_v2.sh health "Simple meal prep strategies for single dad with 3 teens"

# Sleep optimization
./mirador-smart-v2 "How to improve sleep quality with teenage household and work stress"
```

### Energy & Focus
```bash
# Energy management
./mirador-smart-v2 "Natural ways to boost energy without relying on excessive caffeine"

# Focus techniques
./mirador_universal_runner_v2.sh life_optimization "Techniques to maintain focus during long workdays" quick

# Recovery practices
./mirador-smart-v2 "Quick recovery practices between stressful meetings"
```

## Family & Relationships

### Parenting Teenagers
```bash
# Teen communication
./mirador-smart-v2 "How to maintain connection with teenage daughter who's pulling away"

# Boundary setting
./mirador_universal_runner_v2.sh relationship_harmony "Setting healthy boundaries with teenagers while maintaining trust"

# Educational support
./mirador-smart-v2 "Supporting 3 teens through JCPS challenges while managing work demands"
```

### Family Dynamics
```bash
# Quality time
./mirador-smart-v2 "Creative ways to spend quality time with teens who have different interests"

# Conflict resolution
./mirador_universal_runner_v2.sh relationship_harmony "Strategies for resolving conflicts between siblings in single-parent household"

# Family meetings
./mirador-smart-v2 "How to run effective family meetings with 3 teenagers"
```

### Single Parenting
```bash
# Support systems
./mirador-smart-v2 "Building support network as single father in Louisville"

# Time management
./mirador_universal_runner_v2.sh life_optimization "Balancing parenting duties with career ambitions as single parent"

# Self-care
./mirador-smart-v2 "Self-care strategies for single parents that actually work with time constraints"
```

## Music & Creative

### Guitar Practice
```bash
# Practice routine
./mirador-smart-v2 "Design 30-minute daily guitar practice routine for technical metal"

# Technique improvement
./mirador_universal_runner_v2.sh music "Exercises to improve alternate picking speed and accuracy"

# Music theory
./mirador-smart-v2 "Explain modal interchange in context of metal composition"
```

### Band Development
```bash
# Songwriting
./mirador-smart-v2 "Collaborative songwriting process for alt-metal band Annapurna"

# Performance preparation
./mirador_universal_runner_v2.sh music "Checklist for preparing for live performance at Louisville venue"

# Recording tips
./mirador-smart-v2 "Home recording setup recommendations for metal guitar"
```

### Creative Projects
```bash
# Creative inspiration
./mirador_universal_runner_v2.sh creative_breakthrough "Generate unique concepts for ambient metal compositions"

# Time for creativity
./mirador-smart-v2 "How to maintain creative music practice with demanding schedule"

# Skill development
./mirador-smart-v2 "Path to mastering seven-string guitar techniques"
```

## Strategic Planning

### Long-term Vision
```bash
# 5-year plan
./mirador_universal_runner_v2.sh strategic_synthesis "Create comprehensive 5-year plan balancing career, family, and personal goals"

# Life optimization
./mirador-smart-v2 "Design ideal life scenario and backward plan to achieve it"

# Goal alignment
./mirador_universal_runner_v2.sh strategic_synthesis "Align daily actions with long-term vision for meaningful progress"
```

### Decision Making
```bash
# Major decisions
./mirador_universal_runner_v2.sh strategic_synthesis "Framework for making major life decisions with multiple stakeholders"

# Trade-off analysis
./mirador-smart-v2 "Analyze trade-offs between career advancement and family time"

# Risk assessment
./mirador_universal_runner_v3_optimized.sh deep_analysis "Assess risks and opportunities in pursuing VP track"
```

### Personal Development
```bash
# Skill prioritization
./mirador-smart-v2 "Which skills will provide highest ROI for career and personal goals"

# Learning plan
./mirador_universal_runner_v2.sh strategic_synthesis "Create structured learning plan for AI leadership skills"

# Growth tracking
./mirador-smart-v2 "System for tracking personal and professional growth metrics"
```

## Learning & Development

### AI/ML Learning
```bash
# Learning pathway
./mirador-smart-v2 "Structured pathway to master LLMs and generative AI for healthcare"

# Certification strategy
./mirador_universal_runner_v2.sh business_acceleration "Which AI certifications provide most value for VP track"

# Practical projects
./mirador-smart-v2 "AI project ideas that demonstrate leadership and innovation"
```

### Leadership Skills
```bash
# Executive presence
./mirador-smart-v2 "Develop executive presence while maintaining authenticity"

# Strategic thinking
./mirador_universal_runner_v2.sh business_acceleration "Exercises to improve strategic thinking for executive role"

# Communication skills
./mirador-smart-v2 "Improve executive communication skills for C-suite interactions"
```

### Technical Skills
```bash
# Skill gaps
./mirador-smart-v2 "Identify and address technical skill gaps for AI leadership role"

# Learning efficiency
./mirador_universal_runner_v2.sh life_optimization "Most efficient ways to learn new technical skills with time constraints"

# Hands-on practice
./mirador-smart-v2 "Create hands-on learning projects for cloud and AI technologies"
```

## Louisville-Specific

### Local Resources
```bash
# Community connections
./mirador-smart-v2 "Tech and AI communities in Louisville for networking"

# Education options
./mirador-smart-v2 "Best JCPS schools and programs for teenagers interested in technology"

# Local opportunities
./mirador-smart-v2 "Louisville-based opportunities for AI innovation and leadership"
```

### Healthcare Landscape
```bash
# Humana ecosystem
./mirador-smart-v2 "Navigate Humana's Louisville headquarters culture and opportunities"

# Healthcare innovation
./mirador-smart-v2 "Louisville healthcare innovation ecosystem and how to contribute"

# Local partnerships
./mirador-smart-v2 "Potential Louisville partnerships for healthcare AI initiatives"
```

### Music Scene
```bash
# Venue strategies
./mirador-smart-v2 "Best Louisville venues for alt-metal band performances"

# Local networking
./mirador-smart-v2 "Connect with Louisville metal music community"

# Recording options
./mirador-smart-v2 "Recording studios in Louisville suitable for metal production"
```

## Advanced Combinations

### Complex Multi-Domain Queries
```bash
# Career + Family Balance
./mirador_universal_runner_v2.sh strategic_synthesis "How to advance to VP level while being present for teenage kids' important years"

# Technical + Financial
./mirador-smart-v2 "Monetize AI skills through side projects without conflicting with Humana employment"

# Health + Productivity
./mirador_universal_runner_v2.sh life_optimization "Optimize health routines to support demanding career and parenting schedule"
```

### Integrated Life Planning
```bash
# Holistic optimization
./mirador_universal_runner_v2.sh life_optimization "Create integrated plan covering career, family, health, finances, and personal growth"

# Constraint-aware planning
./mirador-smart-v2 "Design life system that respects all constraints while maximizing fulfillment"

# Synergy identification
./mirador_universal_runner_v2.sh strategic_synthesis "Identify synergies between different life areas for multiplicative benefits"
```

### Crisis Management
```bash
# Emergency planning
./mirador_universal_runner_v3_optimized.sh rapid_decision "Teenager having crisis during important work deadline - how to handle"

# Financial emergency
./mirador-smart-v2 "quick Unexpected $500 expense with tight budget - options?"

# Health crisis
./mirador_universal_runner_v3_optimized.sh rapid_decision "Dealing with health issue while maintaining work and family responsibilities"
```

## Custom Chain Examples

### Creating Your Own Chains
```bash
# Financial + Strategic + Implementation
./mirador-ez chain "Create a plan to increase income by 50% in 2 years" universal_financial_advisor universal_strategy_architect practical_implementer

# Creative + Technical + Practical
./mirador-ez chain "Build an AI-powered music composition tool" creative_catalyst master_coder practical_implementer

# Analysis + Strategy + Decision
./mirador-ez chain "Analyze career options and recommend best path" analytical_expert_gemma universal_strategy_architect optimized_decision_simplifier_v3
```

### Specialized Workflows
```bash
# Morning Planning Workflow
./mirador-smart-v2 "Plan my day" && ./mirador-smart-v2 "quick Top 3 priorities" && ./mirador-smart-v2 "Energy management tips for today"

# Weekly Review Workflow
./mirador_universal_runner_v2.sh strategic_synthesis "Weekly review and planning" detailed > weekly_review_$(date +%Y%m%d).md

# Project Kickoff Workflow
PROJECT="AI Innovation Initiative"
./mirador-smart-v2 "Define success criteria for $PROJECT" && \
./mirador-smart-v2 "Identify risks for $PROJECT" && \
./mirador-smart-v2 "Create implementation plan for $PROJECT"
```

### Batch Processing
```bash
# Process multiple queries
for query in "Morning routine" "Lunch break optimization" "Evening wind-down"; do
    ./mirador-smart-v2 "$query" quick
done

# Generate multiple perspectives
TOPIC="Should I pursue MBA while working"
for chain in life_optimization business_acceleration strategic_synthesis; do
    echo "=== $chain perspective ===" 
    ./mirador_universal_runner_v2.sh $chain "$TOPIC" summary
done
```

## Tips for Effective Prompts

### Be Specific
```bash
# Good: Specific context and constraints
./mirador-smart-v2 "Create 20-minute morning routine for single dad with 3 teens who needs to leave by 7:30am"

# Less effective: Too vague
./mirador-smart-v2 "Help with morning routine"
```

### Include Constraints
```bash
# Good: Clear constraints
./mirador-smart-v2 "Investment options with only $50/month available and need liquidity"

# Less effective: Missing key constraints
./mirador-smart-v2 "How should I invest"
```

### Specify Desired Output
```bash
# Good: Clear format request
./mirador-smart-v2 "Create bulleted action list for improving team communication"

# Less effective: Unclear format
./mirador-smart-v2 "Help with team communication"
```

### Use Appropriate Chains
```bash
# Good: Technical query to technical chain
./mirador_universal_runner_v2.sh technical_mastery "Debug Python async/await issues"

# Less effective: Technical query to general chain
./mirador_universal_runner_v2.sh life_optimization "Debug Python async/await issues"
```

## Troubleshooting Commands

### System Health Checks
```bash
# Check model availability
ollama list | grep -E "(matthew_context|universal_strategy|creative_catalyst|practical_implementer)"

# Test basic functionality
./mirador-smart-v2 "quick test"

# Verify routing
DEBUG=1 ./mirador-smart-v2 "Test query for debugging"
```

### Performance Testing
```bash
# Time a query
time ./mirador-smart-v2 "Quick analysis of this idea"

# Compare chain performance
time ./mirador_universal_runner_v2.sh life_optimization "Test query" quick
time ./mirador_universal_runner_v3_optimized.sh rapid_decision "Test query"
```

### Output Management
```bash
# Save output
./mirador-smart-v2 "Important analysis" > analysis_$(date +%Y%m%d).md

# Export detailed analysis
./mirador_universal_runner_v2.sh strategic_synthesis "Comprehensive plan" export

# View recent outputs
ls -la outputs/universal_*/ | tail -20
```

## Conclusion

This prompt library provides comprehensive examples spanning all aspects of the Mirador AI Framework. Each command is designed to leverage the system's sophisticated chain-of-thought reasoning while respecting real-world constraints. The examples range from simple daily planning to complex strategic analysis, demonstrating the framework's versatility.

Remember to:
1. Choose the appropriate chain for your query type
2. Include relevant context and constraints
3. Specify output format when needed
4. Use the smart router for automatic chain selection
5. Experiment with different chains for varied perspectives

The Mirador system is designed to provide practical, actionable insights that respect your time, energy, and financial constraints while helping you achieve your ambitious goals.