# Mirador Shortcuts & Automation Guide

## 🚀 Terminal Aliases

Add these to your `~/.zshrc` or `~/.bash_profile`:

```bash
# Quick navigation
alias mir="cd ~/ai_framework_git"

# Daily routine
alias morning="cd ~/ai_framework_git && ./daily_opportunity_scan.sh"
alias evening="mirador-ez ask decision_simplifier 'What are my top 3 priorities for tomorrow based on today\'s insights?'"

# Fast queries
alias mf="mirador-ez ask financial_planning_expert_v6"
alias ml="mirador-ez ask louisville_expert_v3"
alias mm="mirador-ez ask matthew_context_provider"
alias mo="mirador-ez ask opportunity_validator_v2"

# Common chains
alias career="mirador-ez chain 'Career advancement strategy' matthew_context_provider financial_planning_expert_v6 decision_simplifier"
alias invest="mirador-ez chain 'Investment analysis' financial_planning_expert_v6 opportunity_validator_v2 decision_simplifier"
alias rental="mirador-ez chain 'Rental property analysis' louisville_expert_v3 financial_planning_expert_v6 opportunity_validator_v2"

# System management
alias mstatus="cd ~/ai_framework_git && ./version_info.sh"
alias mclean="cd ~/ai_framework_git && find outputs -mtime +30 -delete"
alias mbackup="cd ~/ai_framework_git && tar -czf backups/mirador_backup_$(date +%Y%m%d).tar.gz outputs/"
```

## ⚡ Keyboard Shortcuts (macOS)

### Using Shortcuts App

**Create "Morning Mirador" Shortcut:**
1. Open Shortcuts app
2. Create new shortcut
3. Add "Run Shell Script" action
4. Enter: `cd ~/ai_framework_git && ./daily_opportunity_scan.sh`
5. Assign keyboard shortcut: ⌘⌥M

**Create "Quick Financial Check" Shortcut:**
1. Add "Run Shell Script" action
2. Enter: `mirador-ez ask financial_planning_expert_v6 "What's my highest ROI financial move today?"`
3. Assign: ⌘⌥F

**Create "Weekly Review" Shortcut:**
1. Add "Run Shell Script" action  
2. Enter: `cd ~/ai_framework_git && ./weekly_deep_analysis.sh`
3. Assign: ⌘⌥W

## 📅 Calendar Integration

### Daily Automation with Calendar

**Morning Opportunity Scan (8:00 AM)**
```bash
# Create calendar event with alert
# Alert runs: open -a Terminal ~/ai_framework_git/daily_opportunity_scan.sh
```

**Weekly Deep Dive (Sunday 7:00 PM)**
```bash
# Weekly recurring event
# Alert runs: open -a Terminal ~/ai_framework_git/weekly_deep_analysis.sh
```

**Monthly ROI Review (1st of month)**
```bash
# Monthly event
# Alert runs: open -a Terminal ~/ai_framework_git/advanced_opportunity_analytics.sh
```

## 🤖 Advanced Automation Scripts

### 1. Contextual Morning Briefing
Create `smart_morning_brief.sh`:

```bash
#!/bin/bash
# Intelligent morning briefing based on day of week

DAY=$(date +%A)
HOUR=$(date +%H)

echo "🌅 Good morning! It's $DAY at $HOUR:00"
echo ""

case $DAY in
  Monday)
    echo "📊 Weekly Strategic Planning"
    mirador-ez chain "What are the 3 highest-leverage activities for this week given my Medicare expertise and financial goals?" \
      matthew_context_provider financial_planning_expert_v6 decision_simplifier
    ;;
  Tuesday|Thursday)
    echo "💼 Career & Business Development"
    mirador-ez ask matthew_context_provider "What Medicare compliance consulting opportunity should I pursue today?"
    ;;
  Wednesday)
    echo "💰 Financial Optimization"
    mirador-ez ask financial_planning_expert_v6 "Mid-week financial check: Am I on track with my goals? Any adjustments needed?"
    ;;
  Friday)
    echo "🏠 Louisville Opportunities"
    mirador-ez ask louisville_expert_v3 "What's the best Louisville opportunity to explore this weekend?"
    ;;
  Saturday|Sunday)
    echo "🎯 Personal Development"
    mirador-ez ask mirador_system_specialist "How can I optimize my Mirador usage based on this week's patterns?"
    ;;
esac

echo ""
echo "☕ Have a productive day!"
```

### 2. Smart Decision Assistant
Create `smart_decision.sh`:

```bash
#!/bin/bash
# Context-aware decision support

echo "What type of decision are you making?"
echo "1) Financial Investment"
echo "2) Career Move"  
echo "3) Business Opportunity"
echo "4) Real Estate"
echo "5) Time Management"

read -p "Enter choice (1-5): " choice

case $choice in
  1)
    read -p "Investment amount: $" amount
    read -p "Investment option: " option
    mirador-ez chain "Should I invest $amount in $option? Compare to alternatives." \
      financial_planning_expert_v6 opportunity_validator_v2 decision_simplifier
    ;;
  2)
    read -p "Career opportunity: " opportunity
    mirador-ez chain "Evaluate career move: $opportunity" \
      matthew_context_provider financial_planning_expert_v6 \
      enhanced_agent_enforcer decision_simplifier
    ;;
  3)
    read -p "Business idea: " idea
    mirador-ez chain "Validate business opportunity: $idea" \
      matthew_context_provider louisville_expert_v3 \
      financial_planning_expert_v6 opportunity_validator_v2
    ;;
  4)
    read -p "Property budget: $" budget
    read -p "Location preference: " location
    mirador-ez chain "Analyze rental property in $location with $budget budget" \
      louisville_expert_v3 financial_planning_expert_v6 \
      opportunity_validator_v2 decision_simplifier
    ;;
  5)
    read -p "Hours available per week: " hours
    mirador-ez chain "Optimize my schedule to maximize income with $hours hours/week" \
      matthew_context_provider enhanced_agent_enforcer decision_simplifier
    ;;
esac
```

### 3. ROI Tracking Automation
Create `auto_track_roi.sh`:

```bash
#!/bin/bash
# Automated ROI tracking from calendar events

# Parse calendar for Mirador-tagged events
# Extract completed items with values
# Auto-update ROI tracking

echo "Scanning for completed opportunities..."

# Example tracking
opportunities=(
  "Medicare Compliance Workshop,5000,completed"
  "Rental Property Analysis,0,in-progress"
  "AI Consultation,1500,completed"
)

for opp in "${opportunities[@]}"; do
  IFS=',' read -r name value status <<< "$opp"
  ./track_mirador_roi.sh "$name" "$value" "$status"
done

echo "ROI tracking updated. Running analytics..."
./advanced_opportunity_analytics.sh | grep "Total ROI"
```

## 🔄 Workflow Automation

### Morning Power Hour
```bash
#!/bin/bash
# Complete morning optimization in one command

echo "⚡ MORNING POWER HOUR ⚡"
echo "========================"

# 1. System check
echo "1️⃣ System Status"
./version_info.sh | grep "Health Check"

# 2. Opportunity scan  
echo -e "\n2️⃣ Daily Opportunities"
./daily_opportunity_scan.sh

# 3. Priority setting
echo -e "\n3️⃣ Today's Priorities"
mirador-ez ask decision_simplifier "Based on all current opportunities, what are my 3 must-do items today?"

# 4. Time blocking
echo -e "\n4️⃣ Optimal Schedule"
mirador-ez ask enhanced_agent_enforcer "Create my optimal schedule for today with time blocks"

echo -e "\n✅ Morning Power Hour Complete!"
```

### Weekly Business Review
```bash
#!/bin/bash
# Comprehensive weekly business analysis

echo "📊 WEEKLY BUSINESS REVIEW"
echo "========================="

# Financial performance
echo "💰 Financial Analysis"
mirador-ez chain "Weekly financial performance review with action items" \
  financial_planning_expert_v6 opportunity_validator_v2

# Career progress
echo -e "\n🚀 Career Progress"
mirador-ez chain "Medicare consulting business progress this week" \
  matthew_context_provider enhanced_agent_enforcer

# Opportunity pipeline
echo -e "\n🎯 Opportunity Pipeline"
./advanced_opportunity_analytics.sh | head -20

# Next week planning
echo -e "\n📅 Next Week Planning"
mirador-ez chain "Top 3 opportunities to pursue next week" \
  mirador_system_specialist opportunity_validator_v2 decision_simplifier
```

## 🎯 Quick Win Templates

### Copy-Paste Power Prompts

```bash
# Monday Morning Strategy
mirador-ez chain "Design my optimal week to progress toward $150k income while maintaining work-life balance" matthew_context_provider financial_planning_expert_v6 enhanced_agent_enforcer decision_simplifier

# Investment Decision
mirador-ez chain "Compare: max 401k vs rental property vs business investment with $20k available" financial_planning_expert_v6 louisville_expert_v3 opportunity_validator_v2 decision_simplifier

# Side Business Validation  
mirador-ez chain "Validate Medicare compliance online course idea: market size, competition, revenue projection" matthew_context_provider financial_planning_expert_v6 opportunity_validator_v2

# Time Optimization
mirador-ez chain "How to add $3k monthly income with only 10 extra hours per week" matthew_context_provider enhanced_agent_enforcer decision_simplifier

# Local Opportunity
mirador-ez chain "Best Louisville healthcare consulting opportunities for Medicare expert" matthew_context_provider louisville_expert_v3 opportunity_validator_v2
```

## 📱 Mobile Access (via SSH)

### Setup Remote Access
```bash
# On your Mac
sudo systemsetup -setremotelogin on

# From iPhone/iPad (using Termius or similar)
ssh username@your-mac-ip
cd ~/ai_framework_git
./daily_opportunity_scan.sh
```

---

*Pro tip: The more you automate routine queries, the more time you have for high-value implementation*