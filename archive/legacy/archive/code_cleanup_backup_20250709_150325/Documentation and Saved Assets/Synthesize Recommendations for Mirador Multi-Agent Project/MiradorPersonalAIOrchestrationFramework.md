# Mirador Personal AI Orchestration Framework

**Version:** 1.0 Production  
**Author:** Matthew Scott  
**Last Updated:** June 6, 2025  
**Status:** Production Ready (80% Reliability)

## Overview

Mirador is a sophisticated personal AI orchestration framework designed exclusively for personal life augmentation and automation. Unlike generic AI assistants, Mirador coordinates multiple specialized AI models to provide comprehensive, multi-domain analysis and recommendations for complex personal decisions.

The framework excels at automating the mental overhead of personal life management by combining domain expertise in financial planning, local resource integration, and strategic analysis. Through validated chain orchestration, Mirador delivers emergent intelligence that exceeds what any individual AI model could provide.

## Key Capabilities

### Multi-Domain Intelligence
Mirador integrates specialized knowledge across multiple personal life domains including financial planning, Louisville/Kentucky local resources, housing decisions, educational planning, and strategic life optimization. Each specialist model contributes domain-specific expertise while the orchestration framework ensures coherent, comprehensive recommendations.

### Louisville/Kentucky Specialization
The framework includes deep local knowledge integration for Louisville Metro and Jefferson County, providing guidance that accounts for Kentucky state taxes, local housing markets, JCPS educational options, TARC transportation, and Metro Government services. This local specialization delivers actionable advice that generic AI systems cannot match.

### Privacy-First Architecture
All processing occurs locally on your MacBook, ensuring that sensitive personal information never leaves your control. The framework operates entirely through local Ollama models, providing enterprise-grade privacy protection for personal life automation.

### Validated Performance
Current system reliability stands at 80% with validated use cases in financial planning and local resource integration. Chain execution times average 20-47 seconds, making the system practical for real-time decision support.

## Quick Start

### Prerequisites
- macOS (tested on MacBook Pro)
- Ollama installed and running
- Git for version control
- Terminal access

### Installation Verification
```bash
# Verify Ollama is running
ollama list

# Check for Mirador models
ollama list | grep -E "(enhanced_agent|financial_planning|louisville_expert)"

# Verify mirador-ez command
which mirador-ez
```

### First Use
```bash
# Navigate to your Mirador directory
cd ~/ai_framework_git

# Test individual model
mirador-ez ask financial_planning_expert_v5 "Budget help for someone making 75000 per year"

# Test chain collaboration
mirador-ez chain "Create financial plan for Louisville family" financial_planning_expert_v5 enhanced_agent_fast_v3

# Check system status
./version_info.sh
```

## Core Models

### Enhanced Agent Fast V3
**Purpose:** Strategic enhancement and chain collaboration  
**Performance:** Adds 200-400 words of strategic value to chains  
**Optimization:** Content preservation with analytical depth  
**Use Case:** Final analysis and recommendation synthesis

### Financial Planning Expert V5
**Purpose:** Louisville-specific financial planning and budgeting  
**Performance:** Generates 400-600 word comprehensive responses  
**Specialization:** Kentucky taxes, Jefferson County costs, local resources  
**Use Case:** Budget optimization, savings strategies, financial decisions

### Louisville Expert V2
**Purpose:** Local resource integration and guidance  
**Performance:** Accurate local information and contacts  
**Specialization:** JCPS, TARC, Metro Government, local services  
**Use Case:** Housing decisions, school selection, local resource utilization

## Validated Use Cases

### Financial Planning
Generate comprehensive budget frameworks that account for Kentucky tax rates, Louisville housing costs, and local financial resources. The system provides actionable guidance for savings strategies, debt management, and financial goal achievement.

### Housing Decisions
Integrate financial analysis with neighborhood research, school district information, and transportation considerations. The framework evaluates housing options against personal criteria while accounting for local market conditions and regulatory factors.

### Educational Planning
Combine JCPS school information with family budget considerations and transportation logistics. The system provides comprehensive analysis for school selection, enrollment planning, and educational resource optimization.

### Local Resource Integration
Identify and evaluate local services, programs, and opportunities that align with personal goals and circumstances. The framework maintains current knowledge of Metro Government services, community programs, and local business resources.

## System Architecture

### Chain Orchestration
Mirador's core innovation lies in its ability to orchestrate multiple AI specialists through sophisticated chain patterns. Each model contributes specialized knowledge while the orchestration framework ensures coherent handoffs and comprehensive analysis.

### Model Specialization
Rather than relying on general-purpose AI, Mirador employs domain-specific models optimized for particular aspects of personal life automation. This approach delivers higher quality, more actionable recommendations than generic alternatives.

### Local Knowledge Integration
The framework maintains deep integration with Louisville/Kentucky-specific information, ensuring that recommendations account for local regulations, market conditions, and available resources.

### Performance Optimization
Models are optimized for chain collaboration with parameters tuned for reliable performance, appropriate response length, and effective handoff protocols.

## Getting Started

### Daily Usage Patterns
Begin using Mirador for routine personal decisions to build familiarity and confidence. Start with financial planning queries and local resource research before progressing to more complex multi-domain analysis.

### Chain Development
Experiment with different model combinations to discover effective patterns for your specific needs. Document successful chains for future reference and optimization.

### System Monitoring
Use the provided monitoring scripts to track system performance and identify optimization opportunities. Regular performance assessment ensures continued reliability and effectiveness.

### Backup and Recovery
Implement regular backup procedures using the provided scripts to protect your model configurations and system state. Version control enables safe experimentation and easy recovery from issues.

## Support and Development

### Version Control
The system includes comprehensive version control with Git integration, enabling safe development and easy rollback capabilities. All model configurations and documentation are tracked for complete system management.

### Performance Monitoring
Built-in monitoring tools provide visibility into system performance, model reliability, and chain effectiveness. Regular assessment enables continuous optimization and improvement.

### Development Workflow
Structured development processes support the creation of new specialist models and chain patterns. Template-based model creation streamlines the addition of new capabilities.

### Documentation
Comprehensive documentation covers all aspects of system operation, development, and optimization. Regular updates ensure that documentation remains current and useful.

This README provides the foundation for understanding and using your Mirador personal AI orchestration framework. For detailed usage instructions, technical documentation, and strategic prompt libraries, refer to the accompanying documentation files.

