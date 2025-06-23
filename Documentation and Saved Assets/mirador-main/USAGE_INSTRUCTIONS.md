Mirador Usage Instructions
Table of Contents

Getting Started
Basic Commands
Smart Chains
Daily Workflows
Advanced Usage
Best Practices
Troubleshooting

Getting Started
First Time Setup
After installation, run these commands to verify your system:
bash# Check system status
./daily_check_enhanced.sh

# Test basic functionality
mirador-ez ask matthew_context_provider_v3 "Tell me about my personality"

# Run your first smart chain
./mirador-smart-v2 "What are my top opportunities today?"
Understanding Output
Mirador saves all outputs in timestamped directories:
outputs/
├── chain_20250618_090633/
│   ├── step_1_output.md      # First model's response
│   ├── step_2_output.md      # Second model's response
│   ├── step_3_output.md      # Third model's response
│   └── summary.md            # Complete chain summary
Basic Commands
Direct Model Queries
Use mirador-ez ask for single model queries:
bash# Ask a specific model
mirador-ez ask [model_name] "[your question]"

# Examples
mirador-ez ask financial_planning_expert_v8 "How should I invest $5000?"
mirador-ez ask louisville_expert_v3 "Best coffee shops near Bardstown Road"
mirador-ez ask enhanced_agent_enforcer "Strategic analysis of remote work"
Manual Chain Execution
Use mirador-ez chain for multi-model analysis:
bash# Basic syntax
mirador-ez chain "[description]" model1 model2 model3

# Example
mirador-ez chain "Career planning analysis" \
    matthew_context_provider_v3 \
    enhanced_agent_enforcer \
    decision_simplifier_v3
Smart Chains
Using mirador-smart-v2
The intelligent wrapper automatically selects the best chain:
bash# Financial queries
./mirador-smart-v2 "How can I save for a house with 75000 income?"
# → Uses: matthew_context → financial_expert → decision_simplifier

# Music career queries
./mirador-smart-v2 "Steps to become touring guitarist this year"
# → Uses: matthew_context → music_networker → guitar_instructor → decision_simplifier

# Local opportunity queries
./mirador-smart-v2 "Louisville networking events for musicians"
# → Uses: matthew_context → louisville_expert → decision_simplifier

# General strategic queries
./mirador-smart-v2 "Identify my best opportunities this month"
# → Uses: matthew_context → enhanced_agent → decision_simplifier
Chain Selection Logic
Query Contains          →  Selected Chain
─────────────────────────────────────────
financial/money/budget  →  Financial Optimization Chain
music/guitar/touring    →  Music Career Chain  
Louisville/local/KY     →  Local Resources Chain
opportunity/strategy    →  Strategic Analysis Chain
personality/traits      →  Self-Awareness Chain
(default)              →  General Analysis Chain
Daily Workflows
Morning Routine (5 minutes)
bash# 1. System health check
./daily_check_enhanced.sh

# 2. Daily opportunities
./quick_opportunity.sh

# 3. Focus area for today
./mirador-smart-v2 "What should I focus on today given my goals?"
Weekly Planning (30 minutes)
bash# Run on Sunday evenings
./weekly_personality_optimization.sh

# Review the week
./mirador-smart-v2 "Analyze my progress this week toward touring guitarist goal"

# Plan next week
./mirador-smart-v2 "Create actionable plan for next week with daily tasks"
Monthly Review (1 hour)
bash# First of month
./monthly_optimization.sh

# Financial review
./mirador-smart-v2 "Comprehensive financial analysis and next month's budget"

# Goal progress
./mirador-smart-v2 "Evaluate monthly progress on all major goals"

# Clean up old outputs
./archive_old_outputs.sh
Advanced Usage
Custom Chains for Specific Needs
Music Practice Routine
bashmirador-ez chain "Weekly guitar practice plan" \
    matthew_context_provider_v3 \
    master_guitar_instructor \
    music_career_timeline_strategist \
    decision_simplifier_v3
Financial Deep Dive
bashmirador-ez chain "Comprehensive financial optimization" \
    matthew_context_provider_v3 \
    financial_planning_expert_v8 \
    louisville_expert_v3 \
    enhanced_agent_enforcer \
    decision_simplifier_v3
Networking Strategy
bashmirador-ez chain "Music industry networking plan" \
    matthew_context_provider_v3 \
    music_industry_networker \
    louisville_expert_v3 \
    linkedin_voice_architect \
    decision_simplifier_v3
Memory-Enhanced Queries
Use the memory wrapper for context-aware responses:
bash# Uses SQLite database to track patterns
./mirador_with_memory.sh ask enhanced_agent_enforcer "Follow up on last week's opportunities"

# Memory system tracks:
# - Previous queries and responses
# - Success patterns
# - Implementation results
Parallel Analysis
For faster results on independent analyses:
bash# Run multiple queries simultaneously
{
    ./mirador-smart-v2 "Financial opportunities" > financial.md &
    ./mirador-smart-v2 "Music career steps" > music.md &
    ./mirador-smart-v2 "Local resources" > local.md &
    wait
}
# Combine results
cat financial.md music.md local.md > combined_analysis.md
Creating Custom Models
Add specialized expertise:
bash# Create modelfile
cat > my_custom_expert.modelfile << 'EOF'
FROM llama3.2
SYSTEM """You are an expert in [specific domain].
Provide actionable advice focused on [specific goals]."""
PARAMETER temperature 0.3
PARAMETER num_predict 800
