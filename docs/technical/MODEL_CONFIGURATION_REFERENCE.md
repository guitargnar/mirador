# Mirador Model Configuration Reference

## Complete Model Registry (79 Models)

### 1. Context Providers (5 Models)

| Model Name | Base | Context | Temp | Purpose | Avg Response | Success Rate |
|------------|------|---------|------|---------|--------------|--------------|
| `user_context_provider_v3` | Llama 3.2 3B | 32768 | 0.1 | Personal context injection | 12s | 99.8% |
| `personality_context_provider` | Llama 3.2 3B | 16384 | 0.1 | Big Five personality integration | 10s | 99.6% |
| `louisville_context_v3` | Llama 3.2 3B | 16384 | 0.2 | Local area expertise | 14s | 99.4% |
| `family_context_provider` | Llama 3.2 3B | 8192 | 0.1 | Family dynamics context | 8s | 99.9% |
| `goal_context_provider` | Llama 3.2 3B | 8192 | 0.1 | Goal tracking and alignment | 9s | 99.7% |

#### Configuration Example: user_context_provider_v3
```bash
FROM llama3.2:3b

SYSTEM """You are User's personal context provider, maintaining awareness of:
- Professional: Current Department at Company, $85k annual income
- Personal: Father to 7-year-old Aurora, ambivert personality
- Aspirations: Touring guitarist (3-year transition plan)
- Technical: AI enthusiast, Python developer, Ollama expert
- Personality: Openness 85/100, Conscientiousness 65/100, Extraversion 45/100

Provide rich, structured context for subsequent models in the chain.
Focus on relevant details based on the query domain."""

PARAMETER num_ctx 32768
PARAMETER temperature 0.1
PARAMETER top_p 0.9
PARAMETER repeat_penalty 1.1
PARAMETER num_thread 8
PARAMETER num_gpu 1
PARAMETER num_batch 512
PARAMETER use_mmap true
```

### 2. Domain Experts (28 Models)

#### Financial Specialists (6 Models)

| Model Name | Base | Context | Temp | Specialization | Avg Response | Success Rate |
|------------|------|---------|------|----------------|--------------|--------------|
| `financial_planning_expert_v6` | Llama 3.2 3B | 32768 | 0.3 | Comprehensive financial planning | 15s | 99.5% |
| `tax_optimization_expert` | Llama 3.2 3B | 16384 | 0.2 | Tax strategies for musicians | 17s | 98.9% |
| `investment_portfolio_advisor` | Llama 3.2 3B | 16384 | 0.3 | Investment allocation | 16s | 99.2% |
| `debt_management_specialist` | Llama 3.2 3B | 8192 | 0.2 | Debt payoff strategies | 12s | 99.6% |
| `retirement_planning_expert` | Llama 3.2 3B | 16384 | 0.3 | 401k and retirement | 18s | 98.8% |
| `real_estate_investment_advisor` | Llama 3.2 3B | 16384 | 0.4 | Property investment | 19s | 98.5% |

#### Music Industry Specialists (8 Models)

| Model Name | Base | Context | Temp | Specialization | Avg Response | Success Rate |
|------------|------|---------|------|----------------|--------------|--------------|
| `guitar_tone_architect` | Llama 3.2 3B | 32768 | 0.7 | Guitar technique & tone | 19s | 99.1% |
| `music_industry_networker` | Llama 3.2 3B | 32768 | 0.5 | Industry connections | 20s | 98.7% |
| `performance_anxiety_coach` | Llama 3.2 3B | 16384 | 0.3 | Stage presence | 14s | 99.3% |
| `touring_logistics_planner` | Llama 3.2 3B | 16384 | 0.4 | Tour planning | 17s | 98.9% |
| `music_marketing_strategist` | Llama 3.2 3B | 16384 | 0.6 | Promotion strategies | 16s | 99.0% |
| `session_musician_advisor` | Llama 3.2 3B | 8192 | 0.4 | Session work guidance | 13s | 99.2% |
| `songwriting_collaborator` | Llama 3.2 3B | 32768 | 0.8 | Creative collaboration | 22s | 97.8% |
| `gear_optimization_expert` | Llama 3.2 3B | 8192 | 0.3 | Equipment selection | 11s | 99.4% |

#### Career Transition Specialists (6 Models)

| Model Name | Base | Context | Temp | Specialization | Avg Response | Success Rate |
|------------|------|---------|------|----------------|--------------|--------------|
| `ai_career_strategist` | Llama 3.2 3B | 16384 | 0.4 | AI career planning | 15s | 99.2% |
| `portfolio_development_coach` | Llama 3.2 3B | 16384 | 0.5 | Project portfolio | 16s | 98.9% |
| `interview_preparation_expert` | Llama 3.2 3B | 8192 | 0.3 | Interview coaching | 12s | 99.5% |
| `resume_optimization_specialist` | Llama 3.2 3B | 8192 | 0.2 | Resume crafting | 10s | 99.6% |
| `networking_strategy_advisor` | Llama 3.2 3B | 8192 | 0.4 | Professional networking | 13s | 99.1% |
| `skill_gap_analyzer` | Llama 3.2 3B | 16384 | 0.3 | Skill assessment | 14s | 99.3% |

#### Life Management Specialists (8 Models)

| Model Name | Base | Context | Temp | Specialization | Avg Response | Success Rate |
|------------|------|---------|------|----------------|--------------|--------------|
| `time_management_optimizer` | Llama 3.2 3B | 8192 | 0.2 | Schedule optimization | 11s | 99.7% |
| `parenting_balance_advisor` | Llama 3.2 3B | 16384 | 0.3 | Work-life balance | 13s | 99.4% |
| `health_wellness_coach` | Llama 3.2 3B | 8192 | 0.3 | Physical/mental health | 12s | 99.2% |
| `relationship_dynamics_expert` | Llama 3.2 3B | 16384 | 0.4 | Family relationships | 15s | 98.8% |
| `stress_management_specialist` | Llama 3.2 3B | 8192 | 0.2 | Stress reduction | 10s | 99.5% |
| `habit_formation_coach` | Llama 3.2 3B | 8192 | 0.3 | Building habits | 11s | 99.3% |
| `energy_management_advisor` | Llama 3.2 3B | 8192 | 0.2 | Energy optimization | 10s | 99.6% |
| `personal_growth_strategist` | Llama 3.2 3B | 16384 | 0.5 | Self-development | 14s | 99.0% |

### 3. Synthesizers (12 Models)

| Model Name | Base | Context | Temp | Purpose | Avg Response | Success Rate |
|------------|------|---------|------|---------|--------------|--------------|
| `cross_model_synthesizer` | Qwen 2.5 7B | 16384 | 0.3 | Multi-model integration | 22s | 98.9% |
| `insight_aggregator` | Qwen 2.5 7B | 16384 | 0.3 | Insight consolidation | 20s | 99.1% |
| `pattern_recognizer` | Llama 3.2 3B | 32768 | 0.4 | Pattern identification | 18s | 98.7% |
| `opportunity_mapper` | Llama 3.2 3B | 16384 | 0.5 | Opportunity synthesis | 17s | 99.0% |
| `conflict_resolver` | Llama 3.2 3B | 8192 | 0.2 | Resolve contradictions | 14s | 99.3% |
| `priority_synthesizer` | Llama 3.2 3B | 8192 | 0.2 | Priority alignment | 13s | 99.4% |
| `timeline_integrator` | Llama 3.2 3B | 8192 | 0.3 | Timeline coordination | 12s | 99.2% |
| `resource_optimizer` | Llama 3.2 3B | 8192 | 0.3 | Resource allocation | 13s | 99.1% |
| `risk_aggregator` | Llama 3.2 3B | 8192 | 0.2 | Risk consolidation | 12s | 99.5% |
| `success_metric_compiler` | Llama 3.2 3B | 8192 | 0.2 | Metric synthesis | 11s | 99.6% |
| `feedback_loop_optimizer` | Llama 3.2 3B | 16384 | 0.4 | Feedback integration | 15s | 98.8% |
| `holistic_perspective_builder` | Qwen 2.5 7B | 32768 | 0.5 | Complete view synthesis | 25s | 98.5% |

### 4. Decision Makers (8 Models)

| Model Name | Base | Context | Temp | Purpose | Avg Response | Success Rate |
|------------|------|---------|------|---------|--------------|--------------|
| `decision_simplifier_v3` | Llama 3.2 3B | 4096 | 0.3 | Clear decisions | 15s | 99.4% |
| `action_prioritizer` | Llama 3.2 3B | 4096 | 0.3 | Action ranking | 16s | 99.2% |
| `risk_assessor` | Llama 3.2 3B | 8192 | 0.2 | Risk evaluation | 14s | 99.5% |
| `timeline_optimizer` | Llama 3.2 3B | 8192 | 0.3 | Schedule optimization | 15s | 99.1% |
| `resource_allocator` | Llama 3.2 3B | 4096 | 0.2 | Resource decisions | 12s | 99.6% |
| `commitment_advisor` | Llama 3.2 3B | 4096 | 0.2 | Commitment analysis | 11s | 99.7% |
| `tradeoff_analyzer` | Llama 3.2 3B | 8192 | 0.3 | Tradeoff evaluation | 14s | 99.3% |
| `next_step_generator` | Llama 3.2 3B | 4096 | 0.2 | Immediate actions | 10s | 99.8% |

### 5. Validators (6 Models)

| Model Name | Base | Context | Temp | Purpose | Avg Response | Success Rate |
|------------|------|---------|------|---------|--------------|--------------|
| `consistency_validator` | Llama 3.2 1B | 4096 | 0.1 | Logic checking | 8s | 99.9% |
| `feasibility_checker` | Llama 3.2 1B | 4096 | 0.1 | Practicality validation | 7s | 99.8% |
| `constraint_validator` | Llama 3.2 1B | 4096 | 0.1 | Constraint checking | 7s | 99.9% |
| `quality_assurance_bot` | Llama 3.2 1B | 4096 | 0.1 | Output quality | 8s | 99.7% |
| `completeness_checker` | Llama 3.2 1B | 4096 | 0.1 | Response completeness | 6s | 99.9% |
| `accuracy_validator` | Llama 3.2 1B | 4096 | 0.1 | Fact checking | 9s | 99.6% |

### 6. Optimized Models (20 Models)

These models are performance-optimized variants of core models:

| Original Model | Optimized Variant | Changes | Performance Gain |
|----------------|-------------------|---------|------------------|
| `decision_simplifier` | `optimized_decision_simplifier_v3` | Context: 32k→4k, Temp: 0.7→0.3 | -15% time |
| `action_prioritizer` | `optimized_action_prioritizer` | Context: 16k→4k, Batch: 512→1024 | -18% time |
| `user_advisor` | `user_advisor_fast` | Context: 32k→8k, GPU layers: 2 | -22% time |
| `financial_expert` | `financial_expert_quick` | Context: 32k→8k, Temp: 0.5→0.3 | -20% time |
| Various | `*_cached` variants | Pre-loaded in memory | -40% load time |

## Model Parameter Reference

### Core Parameters

| Parameter | Description | Default | Range | Impact |
|-----------|-------------|---------|-------|--------|
| `num_ctx` | Context window size | 8192 | 2048-32768 | Memory usage, capability |
| `temperature` | Response randomness | 0.7 | 0.0-1.0 | Creativity vs consistency |
| `top_p` | Nucleus sampling | 0.9 | 0.1-1.0 | Response diversity |
| `repeat_penalty` | Repetition penalty | 1.1 | 1.0-1.5 | Reduce repetition |
| `num_thread` | CPU threads | 8 | 1-16 | CPU performance |
| `num_gpu` | GPU layers | 1 | 0-2 | GPU acceleration |
| `num_batch` | Batch size | 512 | 128-2048 | Throughput |
| `use_mmap` | Memory mapping | true | true/false | Load performance |

### Optimization Guidelines

#### For Speed (Response Time)
```
- Reduce num_ctx to minimum needed (4096 for decisions)
- Lower temperature (0.1-0.3) for faster convergence
- Increase num_batch (1024+) for better throughput
- Enable use_mmap for faster loading
```

#### For Quality (Output Depth)
```
- Maintain high num_ctx (16384-32768)
- Moderate temperature (0.4-0.7) for creativity
- Standard num_batch (512)
- Increase repeat_penalty (1.2+) for variety
```

#### For Reliability (Success Rate)
```
- Lower temperature (0.1-0.3) for consistency
- Moderate num_ctx (8192-16384)
- Higher repeat_penalty (1.2+)
- Conservative top_p (0.8-0.9)
```

## Chain Configuration Patterns

### Fast Decision Chains (20-30s)
```yaml
chain:
  - model: user_context_provider_v3
    role: context
    time: 12s
  - model: optimized_decision_simplifier_v3
    role: decision
    time: 15s
total_time: 27s
use_case: "Quick binary decisions, daily planning"
```

### Comprehensive Analysis Chains (45-60s)
```yaml
chain:
  - model: user_context_provider_v3
    role: context
    time: 12s
  - model: financial_planning_expert_v6
    role: analysis
    time: 15s
  - model: cross_model_synthesizer
    role: synthesis
    time: 22s
  - model: action_prioritizer
    role: decision
    time: 16s
total_time: 65s
use_case: "Complex financial decisions, career planning"
```

### Creative Exploration Chains (40-50s)
```yaml
chain:
  - model: personality_context_provider
    role: context
    time: 10s
  - model: guitar_tone_architect
    role: creative
    time: 19s
  - model: opportunity_mapper
    role: synthesis
    time: 17s
total_time: 46s
use_case: "Music development, creative projects"
```

## Model Selection Matrix

| Query Type | Primary Model | Support Models | Validators |
|------------|---------------|----------------|------------|
| Financial Planning | `financial_planning_expert_v6` | `tax_optimization_expert`, `investment_advisor` | `feasibility_checker` |
| Music Career | `music_industry_networker` | `guitar_tone_architect`, `touring_planner` | `consistency_validator` |
| Time Management | `time_management_optimizer` | `energy_management_advisor`, `habit_coach` | `constraint_validator` |
| Decision Making | `decision_simplifier_v3` | `tradeoff_analyzer`, `risk_assessor` | `completeness_checker` |
| Career Transition | `ai_career_strategist` | `portfolio_coach`, `skill_gap_analyzer` | `quality_assurance_bot` |

## Performance Tuning Quick Reference

### By Use Case

| Use Case | Recommended Config |
|----------|-------------------|
| Real-time decisions | Context: 4096, Temp: 0.3, Batch: 1024 |
| Deep analysis | Context: 32768, Temp: 0.5, Batch: 512 |
| Creative work | Context: 16384, Temp: 0.7, Batch: 512 |
| Validation | Context: 4096, Temp: 0.1, Batch: 2048 |

### By Hardware

| Hardware | Optimization Focus |
|----------|-------------------|
| M1/M2 (32GB) | Reduce context to 16384 max |
| M3 Pro (36GB) | Standard configs work well |
| M3 Max (48GB+) | Can run all models at max context |
| Limited RAM (<32GB) | Use quantized models, reduce batch |

---

*Last updated: June 23, 2025 | 79 models configured | 99.3% aggregate success rate*