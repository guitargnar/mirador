# Mirador-EZ Chain Implementation Guide

**Author:** Manus AI  
**Date:** December 17, 2024  
**Version:** 1.0  

## Complete Implementation Guide for Mirador Chain Prompt Suite

This implementation guide provides everything you need to immediately begin using the comprehensive Mirador chain prompt suite for music career development and personal growth. The guide includes ready-to-use terminal commands, troubleshooting solutions for the hanging command issue, and systematic approaches to maximizing the value of your Mirador AI orchestration system.

## Immediate Setup and Configuration

### Enhanced Command Interface Installation

First, let's install the enhanced command interface that resolves the hanging "ask" command issue and provides improved functionality:

```bash
# Create the enhanced mirador-ez command with timeout and interrupt handling
cat << 'EOF' > ~/mirador-ez-enhanced
#!/bin/bash

# Enhanced Mirador-EZ with timeout handling and graceful interruption
# Resolves hanging command issues and provides better user experience

set -euo pipefail

MIRADOR_DIR="${MIRADOR_DIR:-$HOME/mirador}"
TIMEOUT_DURATION="${MIRADOR_TIMEOUT:-30}"
LOG_FILE="$HOME/.mirador-ez.log"

# Function to log with timestamp
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Function to handle interruption
cleanup() {
    log_message "Command interrupted by user"
    echo "Operation cancelled by user."
    exit 130
}

# Function to handle timeout
timeout_handler() {
    log_message "Command timed out after ${TIMEOUT_DURATION} seconds"
    echo "Command timed out. This may indicate a hanging process."
    echo "Try running: mirador-ez-enhanced diagnose"
    exit 124
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM
trap timeout_handler SIGALRM

# Function to check if mirador is responsive
check_mirador_health() {
    if ! command -v mirador-ez &> /dev/null; then
        echo "Error: mirador-ez command not found. Please ensure Mirador is properly installed."
        return 1
    fi
    
    # Quick health check with timeout
    if timeout 5s mirador-ez list &> /dev/null; then
        return 0
    else
        echo "Warning: Mirador may not be responding properly."
        return 1
    fi
}

# Function to diagnose issues
diagnose_issues() {
    echo "Mirador System Diagnostic"
    echo "========================"
    echo "Timestamp: $(date)"
    echo "Mirador Directory: $MIRADOR_DIR"
    echo "Timeout Setting: ${TIMEOUT_DURATION}s"
    echo ""
    
    echo "Checking Mirador installation..."
    if command -v mirador-ez &> /dev/null; then
        echo "✓ mirador-ez command found"
    else
        echo "✗ mirador-ez command not found"
        return 1
    fi
    
    echo ""
    echo "Checking Mirador directory..."
    if [ -d "$MIRADOR_DIR" ]; then
        echo "✓ Mirador directory exists: $MIRADOR_DIR"
    else
        echo "✗ Mirador directory not found: $MIRADOR_DIR"
        return 1
    fi
    
    echo ""
    echo "Checking for hanging processes..."
    if pgrep -f "mirador" > /dev/null; then
        echo "⚠ Found running Mirador processes:"
        pgrep -f "mirador" | while read pid; do
            echo "  PID: $pid - $(ps -p $pid -o comm= 2>/dev/null || echo 'unknown')"
        done
        echo ""
        echo "To kill hanging processes, run: mirador-ez-enhanced kill-processes"
    else
        echo "✓ No hanging Mirador processes found"
    fi
    
    echo ""
    echo "Recent log entries:"
    if [ -f "$LOG_FILE" ]; then
        tail -5 "$LOG_FILE"
    else
        echo "No log file found"
    fi
}

# Function to kill hanging processes
kill_processes() {
    echo "Killing hanging Mirador processes..."
    if pgrep -f "mirador" > /dev/null; then
        pkill -f "mirador"
        sleep 2
        if pgrep -f "mirador" > /dev/null; then
            echo "Force killing remaining processes..."
            pkill -9 -f "mirador"
        fi
        echo "Processes terminated."
    else
        echo "No Mirador processes found."
    fi
}

# Function to execute mirador commands with timeout
execute_with_timeout() {
    local cmd="$1"
    shift
    
    log_message "Executing: mirador-ez $cmd $*"
    
    # Start alarm for timeout
    (sleep "$TIMEOUT_DURATION" && kill -ALRM $$ 2>/dev/null) &
    local alarm_pid=$!
    
    # Execute the command
    if mirador-ez "$cmd" "$@"; then
        # Cancel the alarm
        kill $alarm_pid 2>/dev/null || true
        log_message "Command completed successfully"
        return 0
    else
        local exit_code=$?
        # Cancel the alarm
        kill $alarm_pid 2>/dev/null || true
        log_message "Command failed with exit code: $exit_code"
        return $exit_code
    fi
}

# Main command processing
case "${1:-help}" in
    "ask")
        shift
        if [ $# -eq 0 ]; then
            echo "Usage: mirador-ez-enhanced ask <model> <prompt>"
            echo "Example: mirador-ez-enhanced ask decision_simplifier 'What should I prioritize today?'"
            exit 1
        fi
        
        echo "Executing ask command with timeout protection..."
        if ! check_mirador_health; then
            echo "Running diagnostic..."
            diagnose_issues
            exit 1
        fi
        
        execute_with_timeout ask "$@"
        ;;
        
    "chain")
        shift
        if [ $# -eq 0 ]; then
            echo "Usage: mirador-ez-enhanced chain <model1,model2,...> <prompt>"
            echo "Example: mirador-ez-enhanced chain 'matthew_context_provider_v2,decision_simplifier' 'Help me plan my day'"
            exit 1
        fi
        
        echo "Executing chain command with timeout protection..."
        if ! check_mirador_health; then
            echo "Running diagnostic..."
            diagnose_issues
            exit 1
        fi
        
        execute_with_timeout chain "$@"
        ;;
        
    "list")
        echo "Available models:"
        execute_with_timeout list
        ;;
        
    "diagnose")
        diagnose_issues
        ;;
        
    "kill-processes")
        kill_processes
        ;;
        
    "help"|*)
        echo "Enhanced Mirador-EZ Command Interface"
        echo "===================================="
        echo ""
        echo "Usage: mirador-ez-enhanced <command> [options]"
        echo ""
        echo "Commands:"
        echo "  ask <model> <prompt>           Execute single model query with timeout protection"
        echo "  chain <models> <prompt>        Execute model chain with timeout protection"
        echo "  list                          List available models"
        echo "  diagnose                      Run system diagnostic"
        echo "  kill-processes               Kill hanging Mirador processes"
        echo "  help                         Show this help message"
        echo ""
        echo "Environment Variables:"
        echo "  MIRADOR_TIMEOUT              Timeout in seconds (default: 30)"
        echo "  MIRADOR_DIR                  Mirador installation directory"
        echo ""
        echo "Examples:"
        echo "  mirador-ez-enhanced ask decision_simplifier 'What should I focus on today?'"
        echo "  mirador-ez-enhanced chain 'matthew_context_provider_v2,decision_simplifier' 'Help me prioritize my tasks'"
        echo "  mirador-ez-enhanced diagnose"
        echo ""
        ;;
esac
EOF

# Make the enhanced command executable
chmod +x ~/mirador-ez-enhanced

# Create a convenient alias
echo "alias mez='~/mirador-ez-enhanced'" >> ~/.bashrc
echo "alias mirador-ez-enhanced='~/mirador-ez-enhanced'" >> ~/.bashrc

# Source the updated bashrc
source ~/.bashrc

echo "Enhanced Mirador-EZ interface installed successfully!"
echo "You can now use 'mez' or 'mirador-ez-enhanced' commands."
echo "Run 'mez help' to see available options."
```

### Quick Test and Verification

Test the enhanced interface to ensure it's working properly:

```bash
# Test the enhanced interface
mez diagnose

# Test a simple ask command
mez ask decision_simplifier "What's the most important thing I should focus on right now?"

# Test listing models
mez list
```

## Ready-to-Use Chain Commands

### Quick Decision Chains (Daily Use)

These chains are designed for frequent use throughout the day to support decision-making and maintain alignment with your goals:

```bash
# Morning Priority Setting
mez chain "matthew_context_provider_v2,decision_simplifier" "I'm starting my day and need to set clear priorities. Help me identify the most important tasks and activities for today based on my current goals and circumstances. Consider my energy levels, available time, and both immediate deadlines and long-term objectives."

# Quick Decision Resolution
mez chain "mirador_system_specialist,decision_simplifier" "I'm facing a decision that needs quick resolution. [Describe your specific decision/situation]. Please provide clear analysis and actionable recommendations that help me move forward confidently."

# Energy and Focus Optimization
mez chain "matthew_context_provider_v2,decision_simplifier" "I need to optimize my energy and focus for the current situation. [Describe your current energy level and what you need to accomplish]. Help me adapt my activities and approach to work with my current state rather than against it."

# Quick Financial Decision
mez chain "financial_planning_expert_v6,decision_simplifier" "I'm considering a financial decision and need quick analysis. [Describe the financial choice you're facing]. Please provide clear guidance on whether this aligns with my financial goals and priorities."

# Daily Practice Optimization
mez chain "master_guitar_instructor,decision_simplifier" "I have [X minutes/hours] available for guitar practice today. Based on my current skill level and goals, help me optimize this practice session for maximum improvement and progress toward my touring guitarist objectives."

# Quick Networking Opportunity Assessment
mez chain "music_industry_networker,decision_simplifier" "I have an opportunity to [describe networking situation]. Help me assess whether this is worth pursuing and how to approach it effectively for my music career development."

# Rapid Communication Crafting
mez chain "music_industry_networker,decision_simplifier" "I need to write a professional message to [describe recipient and context]. Help me craft communication that is effective, authentic, and supports my music career networking goals."

# Energy Management and Recovery
mez chain "matthew_context_provider_v2,decision_simplifier" "I'm feeling [describe your current energy state] and need guidance on how to manage my energy effectively. Help me optimize my approach to maintain productivity while ensuring adequate recovery."
```

### Strategic Planning Chains (Weekly/Monthly Use)

These comprehensive chains provide deep analysis for major decisions and long-term planning:

```bash
# Comprehensive Career Strategy Development
mez chain "matthew_context_provider_v2,music_career_timeline_strategist,music_industry_networker,financial_planning_expert_v6,mirador_system_specialist,decision_simplifier" "I need to develop a comprehensive career strategy for the next 1-3 years. [Provide detailed context about your current situation, goals, constraints, and aspirations]. Please provide thorough analysis and strategic recommendations for advancing my touring guitarist career."

# Professional Development Investment Analysis
mez chain "matthew_context_provider_v2,master_guitar_instructor,financial_planning_expert_v6,music_career_timeline_strategist,decision_simplifier" "I'm considering a significant investment in professional development: [describe the opportunity, costs, and expected outcomes]. Help me analyze whether this investment aligns with my career goals and represents the best use of my resources."

# Industry Positioning and Differentiation Strategy
mez chain "matthew_context_provider_v2,music_industry_networker,music_career_timeline_strategist,mirador_system_specialist,decision_simplifier" "I need to develop a clear strategy for positioning myself uniquely within the music industry. [Describe your current situation, strengths, and market context]. Help me create competitive advantages and distinctive market positioning."

# Comprehensive Financial Strategy Development
mez chain "matthew_context_provider_v2,financial_planning_expert_v6,music_career_timeline_strategist,mirador_system_specialist,decision_simplifier" "I need to develop a comprehensive financial strategy that supports my music career goals while ensuring long-term financial security. [Provide detailed financial context and goals]. Please provide thorough financial planning guidance."

# Work-Life Integration Strategy
mez chain "matthew_context_provider_v2,music_career_timeline_strategist,financial_planning_expert_v6,mirador_system_specialist,decision_simplifier" "I need to develop a sustainable strategy for integrating my music career development with my other life responsibilities and priorities. [Describe your current life situation and challenges]. Help me create an integrated approach that supports both professional advancement and personal fulfillment."
```

### Music Career Development Chains (Skill & Performance Focus)

These specialized chains address the unique aspects of music career development:

```bash
# Comprehensive Guitar Skill Assessment and Development
mez chain "matthew_context_provider_v2,master_guitar_instructor,guitar_tone_architect,music_career_timeline_strategist,decision_simplifier" "I need a comprehensive assessment of my current guitar playing abilities and a detailed development plan. [Provide detailed information about your current skills, experience, goals, and constraints]. Help me create an effective skill development strategy."

# Advanced Technique Mastery and Specialization
mez chain "master_guitar_instructor,guitar_tone_architect,music_career_timeline_strategist,decision_simplifier" "I want to develop advanced technical skills that will distinguish my playing and create competitive advantages. [Describe your current technical abilities and specialization goals]. Help me create a focused development plan for advanced techniques."

# Comprehensive Performance Readiness Assessment
mez chain "matthew_context_provider_v2,touring_readiness_coach,performance_anxiety_coach,master_guitar_instructor,decision_simplifier" "I have an upcoming performance opportunity and need comprehensive preparation guidance. [Describe the performance context, your current readiness, and any concerns]. Help me prepare thoroughly for successful performance."

# Stage Presence and Audience Engagement Development
mez chain "touring_readiness_coach,performance_anxiety_coach,music_career_timeline_strategist,decision_simplifier" "I want to develop stronger stage presence and audience engagement skills. [Describe your current performance style and goals]. Help me create compelling stage presence that enhances my performances."

# Performance Anxiety Management and Confidence Building
mez chain "performance_anxiety_coach,touring_readiness_coach,matthew_context_provider_v2,decision_simplifier" "I experience performance anxiety that interferes with my ability to perform at my best. [Describe your anxiety symptoms and triggers]. Help me develop effective strategies for managing anxiety and building confidence."

# Strategic Music Industry Networking Development
mez chain "matthew_context_provider_v2,music_industry_networker,music_career_timeline_strategist,mirador_system_specialist,decision_simplifier" "I need to develop a strategic approach to networking within the music industry. [Describe your current networking situation and goals]. Help me build meaningful professional relationships that support my career advancement."

# Music Business Development and Revenue Diversification
mez chain "matthew_context_provider_v2,music_career_timeline_strategist,financial_planning_expert_v6,music_industry_networker,decision_simplifier" "I need to develop multiple income streams and build a sustainable music business. [Describe your current income situation and business goals]. Help me create diversified revenue streams that support my touring career goals."
```

## Daily and Weekly Usage Patterns

### Recommended Daily Routine

**Morning (5-10 minutes):**
```bash
# Start each day with priority setting
mez chain "matthew_context_provider_v2,decision_simplifier" "I'm starting my day and need to set clear priorities. Help me identify the most important tasks and activities for today based on my current goals, energy levels, and both immediate deadlines and long-term objectives."

# Optimize your practice session
mez chain "master_guitar_instructor,decision_simplifier" "I have [X minutes] available for guitar practice today. Help me optimize this session for maximum improvement toward my touring guitarist goals."
```

**Throughout the Day (as needed):**
```bash
# For quick decisions
mez chain "mirador_system_specialist,decision_simplifier" "[Describe your specific decision]. Please provide clear analysis and actionable recommendations."

# For energy management
mez chain "matthew_context_provider_v2,decision_simplifier" "I'm feeling [describe energy state] and need guidance on optimizing my approach while ensuring adequate recovery."

# For networking opportunities
mez chain "music_industry_networker,decision_simplifier" "I have an opportunity to [describe situation]. Help me assess whether this is worth pursuing and how to approach it effectively."
```

**Evening (5 minutes):**
```bash
# Reflect and plan for tomorrow
mez chain "matthew_context_provider_v2,decision_simplifier" "Reflecting on today's progress and challenges, help me identify key learnings and set priorities for tomorrow that build on today's momentum."
```

### Recommended Weekly Routine

**Weekly Planning Session (15-20 minutes):**
```bash
# Comprehensive weekly planning
mez chain "matthew_context_provider_v2,music_career_timeline_strategist,financial_planning_expert_v6,decision_simplifier" "I'm planning my week and need strategic guidance. [Describe your current priorities, upcoming commitments, and goals]. Help me create an effective weekly plan that advances my music career while maintaining balance."

# Skill development planning
mez chain "master_guitar_instructor,music_career_timeline_strategist,decision_simplifier" "Based on my current skill development goals and available practice time this week, help me create an effective practice plan that maximizes progress toward my touring guitarist objectives."
```

**Weekly Review Session (10-15 minutes):**
```bash
# Progress assessment and adjustment
mez chain "matthew_context_provider_v2,mirador_system_specialist,decision_simplifier" "Reviewing this week's progress and challenges, help me identify what's working well, what needs adjustment, and how to optimize my approach for next week."
```

### Monthly Strategic Sessions

**Monthly Career Review (20-30 minutes):**
```bash
# Comprehensive monthly assessment
mez chain "matthew_context_provider_v2,music_career_timeline_strategist,music_industry_networker,financial_planning_expert_v6,mirador_system_specialist,decision_simplifier" "I'm conducting my monthly career review. [Provide comprehensive update on progress, challenges, opportunities, and changing circumstances]. Help me assess my progress and adjust my strategy for continued advancement."
```

## Troubleshooting and Optimization

### Common Issues and Solutions

**If commands still hang:**
```bash
# Diagnose the issue
mez diagnose

# Kill hanging processes
mez kill-processes

# Adjust timeout if needed
export MIRADOR_TIMEOUT=60  # Increase to 60 seconds
mez ask decision_simplifier "Test message"
```

**If you get permission errors:**
```bash
# Fix permissions
chmod +x ~/mirador-ez-enhanced
```

**If the alias doesn't work:**
```bash
# Reload your shell configuration
source ~/.bashrc

# Or add the alias manually
alias mez='~/mirador-ez-enhanced'
```

### Performance Optimization

**For faster execution:**
```bash
# Use shorter chains for quick decisions
mez chain "decision_simplifier" "Quick question: [your question]"

# Use the speed-optimized chain
mez chain "financial_planning_expert_v6,decision_simplifier" "[your question]"
```

**For highest quality analysis:**
```bash
# Use the quality-optimized chain
mez chain "mirador_system_specialist,enhanced_agent_enforcer,decision_simplifier" "[your complex question]"
```

**For balanced approach:**
```bash
# Use the balanced chain
mez chain "mirador_system_specialist,decision_simplifier" "[your question]"
```

## Success Tracking and Continuous Improvement

### Weekly Success Review

Track your progress with this weekly assessment:

```bash
mez chain "matthew_context_provider_v2,mirador_system_specialist,decision_simplifier" "I want to assess my progress this week using Mirador chains. Help me evaluate: 1) Which chains provided the most valuable guidance, 2) Which recommendations I implemented successfully, 3) What patterns I notice in my decision-making, and 4) How to optimize my use of Mirador for even better results next week."
```

### Monthly Optimization Review

Optimize your chain usage monthly:

```bash
mez chain "mirador_system_specialist,enhanced_agent_enforcer,decision_simplifier" "I want to optimize my use of Mirador chains based on my experience over the past month. Help me analyze which chains work best for different types of decisions, how to improve my prompt engineering, and what adjustments would make my Mirador usage even more effective for advancing my music career goals."
```

This implementation guide provides everything you need to immediately begin using the comprehensive Mirador chain prompt suite effectively. Start with the daily routines and gradually incorporate the more comprehensive strategic planning chains as you become comfortable with the system. The enhanced command interface resolves the hanging issue while providing better functionality and user experience.

