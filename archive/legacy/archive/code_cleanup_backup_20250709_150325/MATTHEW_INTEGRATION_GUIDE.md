# Matthew's Mirador Integration Guide

## 🚀 Quick Start - Your Models with Mirador v2.0

### 1. Test Your Existing Models with Enhanced Framework
```bash
# Use your proven chains with metrics tracking
python3 mirador_v2.py run \
  --prompt "What should I focus on today at Company?" \
  --chain "matthew_context_provider_v3,ai_leadership_strategist,enhanced_agent_enforcer"

# Financial planning with metrics
python3 mirador_v2.py run \
  --prompt "Analyze my path to financial independence" \
  --chain "matthew_context_provider_v3,financial_planning_expert_v6,enhanced_agent_enforcer"

# Company navigation
python3 mirador_v2.py run \
  --prompt "How to position AI innovation at Company" \
  --chain "company_ai_advocate,company_innovation_catalyst,company_politics_navigator"
```

### 2. Create Custom Launchers for Your Workflows
```bash
# Create matthew-daily launcher
cat > matthew-daily << 'EOF'
#!/bin/bash
# Your daily strategic briefing with metrics
python3 mirador_v2.py run \
  --prompt "Create my strategic daily briefing for Company considering current priorities" \
  --chain "matthew_context_provider_v3,ai_leadership_strategist,enhanced_agent_enforcer"
EOF
chmod +x matthew-daily

# Create company-innovate launcher
cat > company-innovate << 'EOF'
#!/bin/bash
# Innovation positioning at Company
python3 mirador_v2.py run \
  --prompt "$*" \
  --chain "company_innovation_catalyst,company_politics_navigator,solution_architect"
EOF
chmod +x company-innovate
```

### 3. Configure Your Model Preferences
```bash
# Create your model configuration
cat > ~/.mirador/matthew_models.json << 'EOF'
{
  "favorite_chains": {
    "daily": ["matthew_context_provider_v3", "ai_leadership_strategist", "enhanced_agent_enforcer"],
    "financial": ["matthew_context_provider_v3", "financial_planning_expert_v6", "personal_finance_navigator"],
    "company": ["company_ai_advocate", "company_innovation_catalyst", "company_politics_navigator"],
    "career": ["matthew_context_provider_v3", "ai_career_strategist", "opportunity_validator_v2"]
  },
  "model_aliases": {
    "matthew": "matthew_context_provider_v3",
    "finance": "financial_planning_expert_v6",
    "company": "company_ai_advocate",
    "leadership": "ai_leadership_strategist"
  }
}
EOF
```

## 📊 Working Examples

### Morning Workflow
```bash
# 1. Check your metrics from yesterday
python3 metrics_tracker.py summary --days 1

# 2. Run your daily briefing
./matthew-daily

# 3. Report any pain points
python3 advocates_program.py report \
  --description "SharePoint search still broken" \
  --category "tools" \
  --impact high

# 4. Check the dashboard
open http://localhost:5000
```

### Strategic Decision Making
```bash
# Complex career decision
python3 mirador_v2.py run \
  --prompt "Should I pursue the enterprise architect role or stay focused on AI leadership?" \
  --chain "matthew_context_provider_v3,ai_career_strategist,financial_planning_expert_v6,enhanced_agent_enforcer"

# Innovation proposal
./company-innovate "How to position Mirador as enterprise solution"
```

### Automation Setup
```bash
# Create automation script
cat > matthew_automations.py << 'EOF'
from automation_engine import AutomationEngine
import subprocess

engine = AutomationEngine()

# Daily briefing at 7 AM
def morning_briefing():
    return subprocess.run([
        'python3', 'mirador_v2.py', 'run',
        '--prompt', 'Create my strategic daily briefing',
        '--chain', 'matthew_context_provider_v3,ai_leadership_strategist,enhanced_agent_enforcer'
    ], capture_output=True, text=True)

# Weekly financial review
def weekly_financial():
    return subprocess.run([
        'python3', 'mirador_v2.py', 'run',
        '--prompt', 'Weekly financial progress review and recommendations',
        '--chain', 'matthew_context_provider_v3,financial_planning_expert_v6,enhanced_agent_enforcer'
    ], capture_output=True, text=True)

# Register tasks
engine.register_task('morning_briefing', morning_briefing, 
                    {'schedule': {'type': 'daily', 'time': '07:00'}})
engine.register_task('weekly_financial', weekly_financial,
                    {'schedule': {'type': 'weekly', 'day': 'sunday', 'time': '18:00'}})

# Start engine
engine.start()
EOF

# Run automations
python3 matthew_automations.py
```

## 🎯 Your Specific Use Cases

### 1. Company AI Leadership Positioning
```bash
# Daily visibility builder
python3 mirador_v2.py run \
  --prompt "What AI initiative should I champion today to build leadership visibility?" \
  --chain "company_ai_advocate,company_innovation_catalyst,company_politics_navigator"

# Track impact
python3 advocates_program.py solution \
  --description "Implemented AI review process saving 5 hours/week" \
  --pain-point-id 123
```

### 2. Financial Independence Acceleration  
```bash
# Multi-model financial analysis
python3 mirador_v2.py run \
  --prompt "Analyze all income optimization opportunities" \
  --chain "matthew_context_provider_v3,financial_planning_expert_v6,financial_planning_expert_optimized,louisville_expert_v3"
```

### 3. Music Career Integration
```bash
# Balance analysis
python3 mirador_v2.py run \
  --prompt "How to balance Company leadership goals with music performance schedule" \
  --chain "matthew_context_provider_v3,music_career_timeline_strategist,life_transition_coordinator"
```

## 🔧 Troubleshooting

### If framework.py has issues:
```bash
# Use direct ollama chains
./company_chain_runner.sh ai_leadership "Your prompt here"

# Or classic mirador
./mirador-smart-v2 "Your prompt here"
```

### Check what's working:
```bash
# Test individual components
python3 metrics_tracker.py --help
python3 advocates_program.py --help
python3 pain_point_analyzer.py --help

# View your metrics
python3 metrics_tracker.py summary
```

### Access Points:
- Web Dashboard: http://localhost:5000
- Metrics Database: ~/Projects/mirador/mirador_metrics.db
- Advocates Database: ~/Projects/mirador/advocates.db
- Memory System: ~/.mirador/memory/

## 📈 Next Steps

1. **Import Your History**: 
   ```bash
   # Import your chain history for metrics
   python3 import_history.py --source ~/ai_framework_git/outputs
   ```

2. **Set Up Dashboards**:
   - Advocates Dashboard: Already running at localhost:5000
   - Create personal metrics dashboard
   - Export weekly reports

3. **Build Your Playbook**:
   - Document successful chain combinations
   - Track which models work best for specific tasks
   - Share insights via Advocates Program

Remember: Your sophisticated model library + Mirador v2.0's tracking = Measurable impact and continuous improvement!