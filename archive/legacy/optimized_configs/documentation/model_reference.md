# Mirador Optimized Model Reference

**Generated:** 2025-06-19T09:52:51.316592

This document provides a comprehensive reference for the optimized Mirador model set.

## Model Categories

### Core Models

#### matthew_context_provider_v2

- **Role:** Personal context and preference provider
- **Base Model:** llama3.2_balanced
- **Temperature:** 0.5
- **Context Window:** 3072
- **Priority:** high
- **Parameters:**
  - temperature: 0.5
  - top_p: 0.9
  - repeat_penalty: 1.1

#### decision_simplifier_v2

- **Role:** Final synthesis and action-oriented recommendations
- **Base Model:** llama3.2_balanced
- **Temperature:** 0.4
- **Context Window:** 2048
- **Priority:** high
- **Parameters:**
  - temperature: 0.4
  - top_p: 0.8
  - repeat_penalty: 1.1

### Domain Specialists

#### financial_planning_expert_v6

- **Role:** Comprehensive financial analysis and planning
- **Base Model:** llama3.2_balanced
- **Temperature:** 0.4
- **Context Window:** 2048
- **Priority:** high
- **Parameters:**
  - temperature: 0.4
  - top_p: 0.8
  - repeat_penalty: 1.1

#### financial_planning_expert_fast

- **Role:** Quick financial queries and calculations
- **Base Model:** llama3.2_balanced
- **Temperature:** 0.5
- **Context Window:** 1536
- **Priority:** medium
- **Parameters:**
  - temperature: 0.5
  - top_p: 0.9
  - repeat_penalty: 1.0

#### louisville_expert_v3

- **Role:** Louisville-specific context and opportunities
- **Base Model:** llama3.2_balanced
- **Temperature:** 0.6
- **Context Window:** 2048
- **Priority:** high
- **Parameters:**
  - temperature: 0.6
  - top_p: 0.9
  - repeat_penalty: 1.1

### Quality Assurance

#### enhanced_agent_enforcer_v2

- **Role:** Quality validation and consistency checking
- **Base Model:** llama3.2_balanced
- **Temperature:** 0.3
- **Context Window:** 2048
- **Priority:** high
- **Parameters:**
  - temperature: 0.3
  - top_p: 0.8
  - repeat_penalty: 1.2

#### enhanced_agent_fast_v6

- **Role:** Quick validation and error checking
- **Base Model:** llama3.2_balanced
- **Temperature:** 0.4
- **Context Window:** 1536
- **Priority:** medium
- **Parameters:**
  - temperature: 0.4
  - top_p: 0.8
  - repeat_penalty: 1.1

### System Optimization

#### mirador_system_specialist_v2

- **Role:** Meta-analysis and system optimization
- **Base Model:** llama3.2_balanced
- **Temperature:** 0.5
- **Context Window:** 2048
- **Priority:** medium
- **Parameters:**
  - temperature: 0.5
  - top_p: 0.9
  - repeat_penalty: 1.1

### Content Specialists

#### linkedin_content_expert

- **Role:** Professional content creation and communication
- **Base Model:** llama3.2_balanced
- **Temperature:** 0.7
- **Context Window:** 2048
- **Priority:** medium
- **Parameters:**
  - temperature: 0.7
  - top_p: 0.9
  - repeat_penalty: 1.0

#### real_estate_analyzer

- **Role:** Real estate analysis and investment evaluation
- **Base Model:** llama3.2_balanced
- **Temperature:** 0.4
- **Context Window:** 2048
- **Priority:** low
- **Parameters:**
  - temperature: 0.4
  - top_p: 0.8
  - repeat_penalty: 1.1

#### health_wellness_optimizer

- **Role:** Health and wellness optimization guidance
- **Base Model:** llama3.2_balanced
- **Temperature:** 0.5
- **Context Window:** 2048
- **Priority:** low
- **Parameters:**
  - temperature: 0.5
  - top_p: 0.9
  - repeat_penalty: 1.1

#### productivity_optimizer

- **Role:** Productivity and efficiency enhancement
- **Base Model:** llama3.2_balanced
- **Temperature:** 0.5
- **Context Window:** 2048
- **Priority:** low
- **Parameters:**
  - temperature: 0.5
  - top_p: 0.9
  - repeat_penalty: 1.1

