# Complete Commands Reference

## Quick Start Commands

```bash
# Clone the repository
git clone https://github.com/yourusername/productivity-tools.git
cd productivity-tools

# Run the main suite
python3 productivity_suite.py

# Make all scripts executable (Unix/Linux/macOS)
chmod +x *.py
```

## Core Productivity Tools

### 1. Meeting Notes Formatter
```bash
# Interactive mode
python3 meeting_notes_formatter.py

# With input file
python3 meeting_notes_formatter.py < meeting_notes.txt

# With output redirect
python3 meeting_notes_formatter.py > formatted_notes.txt

# Quick one-liner
echo "discussed budget with john, decision: postpone to Q2" | python3 meeting_notes_formatter.py
```

### 2. Email Action Parser
```bash
# Interactive mode
python3 email_action_parser.py

# Parse email file
python3 email_action_parser.py < email_thread.txt

# Extract and save actions
python3 email_action_parser.py < inbox.txt > actions.md

# Process multiple emails
cat email1.txt email2.txt | python3 email_action_parser.py
```

### 3. CMS Guidance Analyzer
```bash
# Interactive mode
python3 cms_guidance_analyzer.py

# Analyze Federal Register document
python3 cms_guidance_analyzer.py < federal_register.txt

# Generate compliance report
python3 cms_guidance_analyzer.py < cms_guidance.txt > compliance_requirements.txt

# Quick analysis
curl -s https://federalregister.gov/documents/... | python3 cms_guidance_analyzer.py
```

### 4. Weekly Accomplishments Tracker
```bash
# Interactive menu mode
python3 weekly_accomplishments_tracker.py

# Quick add mode
python3 weekly_accomplishments_tracker.py "Completed risk assessment for Q4"

# Add with category
python3 weekly_accomplishments_tracker.py "Fixed critical bug" --category development

# Generate weekly summary
python3 weekly_accomplishments_tracker.py --generate-summary

# Export for performance review
python3 weekly_accomplishments_tracker.py --export-review
```

### 5. Star Ratings Analyzer
```bash
# Interactive mode
python3 star_ratings_analyzer.py

# Analyze CSV file
python3 star_ratings_analyzer.py < star_ratings_data.csv

# Generate executive report
python3 star_ratings_analyzer.py --input ratings.csv --output executive_summary.txt

# Quick metrics
python3 star_ratings_analyzer.py --metrics-only < data.csv
```

### 6. Productivity Suite (Main Interface)
```bash
# Standard launch
python3 productivity_suite.py

# With AI enhancement (if available)
python3 productivity_suite.py --ai-enhanced

# Skip menu for specific tool
python3 productivity_suite.py --tool meeting_notes

# Batch mode
python3 productivity_suite.py --batch --tool email_parser < emails.txt
```

## Analytics and Feedback Commands

### Analytics Tracker
```bash
# View analytics dashboard
python3 analytics_tracker.py

# Generate analytics report
python3 analytics_tracker.py --report

# Export analytics data
python3 analytics_tracker.py --export

# View personal stats
python3 analytics_tracker.py --user "your_name"

# Manual time entry
python3 analytics_tracker.py --track --tool meeting_notes --time 30
```

### Feedback Collector
```bash
# Interactive feedback
python3 feedback_collector.py

# Quick rating
python3 feedback_collector.py --rate 5 --tool email_parser

# Submit bug report
python3 feedback_collector.py --bug "Issue with date parsing"

# View feedback summary
python3 feedback_collector.py --summary
```

## AI Integration Commands

### Mirador Integration Check
```bash
# Check integration status
python3 mirador_integration.py

# Test AI enhancement
python3 mirador_integration.py --test

# Check specific tool enhancement
python3 mirador_integration.py --tool meeting_notes --test

# Verbose mode
python3 mirador_integration.py --verbose
```

### AI-Enhanced Tool Usage
```bash
# Enhance meeting notes with AI
python3 meeting_notes_formatter.py --enhance

# Email parser with AI prioritization
python3 email_action_parser.py --ai-prioritize

# CMS analyzer with risk assessment
python3 cms_guidance_analyzer.py --risk-assessment

# Star ratings with predictions
python3 star_ratings_analyzer.py --predict
```

## Utility Commands

### Setup and Configuration
```bash
# Check Python version
python3 --version

# Verify all tools are accessible
ls -la *.py

# Run system check
python3 -c "import sys; print(f'Python {sys.version}')"

# Create output directory
mkdir -p output_files

# Set permissions (Unix/Linux/macOS)
chmod +x *.py
```

### Data Management
```bash
# Backup accomplishments data
cp my_accomplishments_*.json backup/

# Clear analytics data
rm productivity_analytics.json

# Archive old output files
tar -czf output_archive_$(date +%Y%m%d).tar.gz output_files/

# View current data files
ls -la *.json
```

### Integration Testing
```bash
# Test all tools sequentially
for tool in meeting_notes_formatter.py email_action_parser.py cms_guidance_analyzer.py weekly_accomplishments_tracker.py star_ratings_analyzer.py; do
    echo "Testing $tool..."
    python3 $tool --test
done

# Verify Mirador connection
curl -s http://localhost:11434/api/tags | python3 -m json.tool

# Check Ollama models
ollama list
```

## Advanced Usage Patterns

### Pipe Chaining
```bash
# Meeting notes to email actions
python3 meeting_notes_formatter.py < meeting.txt | python3 email_action_parser.py

# Email actions to accomplishments
python3 email_action_parser.py < emails.txt | grep "COMPLETED" | python3 weekly_accomplishments_tracker.py --batch-add

# CMS analysis to star ratings impact
python3 cms_guidance_analyzer.py < federal_register.txt | python3 star_ratings_analyzer.py --impact-analysis
```

### Automation Scripts
```bash
# Daily productivity routine
#!/bin/bash
echo "=== Daily Productivity Routine ==="
python3 email_action_parser.py < inbox.txt > today_actions.md
python3 weekly_accomplishments_tracker.py --add-from today_actions.md
python3 analytics_tracker.py --report

# Weekly summary generation
#!/bin/bash
echo "=== Weekly Summary ==="
python3 weekly_accomplishments_tracker.py --generate-summary > weekly_summary.md
python3 star_ratings_analyzer.py --weekly-trends >> weekly_summary.md
python3 analytics_tracker.py --weekly-report >> weekly_summary.md
```

### Scheduled Tasks (Cron)
```bash
# Add to crontab -e

# Daily email parsing at 8 AM
0 8 * * * cd ~/productivity_tools && python3 email_action_parser.py < ~/inbox.txt > ~/today_actions.md

# Weekly accomplishments summary every Friday at 4 PM
0 16 * * 5 cd ~/productivity_tools && python3 weekly_accomplishments_tracker.py --generate-summary > ~/weekly_summary.md

# Monthly analytics report
0 9 1 * * cd ~/productivity_tools && python3 analytics_tracker.py --monthly-report > ~/monthly_productivity.txt
```

## Troubleshooting Commands

### Debug Mode
```bash
# Run with debug output
PYTHONPATH=. python3 -m pdb productivity_suite.py

# Verbose execution
python3 -v meeting_notes_formatter.py

# Check for syntax errors
python3 -m py_compile *.py

# Trace execution
python3 -m trace -t email_action_parser.py
```

### Common Fixes
```bash
# Fix permission denied
chmod +x *.py

# Fix module not found
export PYTHONPATH="${PYTHONPATH}:$(pwd)"

# Fix encoding issues
export PYTHONIOENCODING=utf-8

# Clear Python cache
find . -type d -name __pycache__ -exec rm -rf {} +
```

## Environment Variables

```bash
# Set user for analytics
export PRODUCTIVITY_USER="john_doe"

# Custom data directory
export PRODUCTIVITY_DATA_DIR="$HOME/productivity_data"

# AI enhancement settings
export OLLAMA_HOST="http://localhost:11434"
export MIRADOR_PATH="$HOME/Projects/mirador"

# Debug mode
export PRODUCTIVITY_DEBUG="1"

# Disable analytics
export PRODUCTIVITY_NO_ANALYTICS="1"
```

## Quick Reference Card

```bash
# Most Common Commands
python3 productivity_suite.py                    # Main menu
python3 meeting_notes_formatter.py              # Format notes
python3 email_action_parser.py                  # Parse emails
python3 weekly_accomplishments_tracker.py "Task" # Quick add
python3 analytics_tracker.py                    # View stats

# AI Enhancement
python3 mirador_integration.py                  # Check AI
python3 productivity_suite.py --ai-enhanced     # Use with AI

# Reports
python3 analytics_tracker.py --report           # Analytics
python3 feedback_collector.py --summary         # Feedback
```

---

*From simple commands to sophisticated workflows - master your productivity.*