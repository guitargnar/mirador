#!/bin/bash

# Claude Code Interpreter Analysis Runner
# This script orchestrates all analysis tasks

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "🚀 Claude Code Interpreter Analysis Suite"
echo "========================================"
echo ""

# Function to display menu
show_menu() {
    echo "Select an analysis to run:"
    echo "1) Run Performance Benchmarks"
    echo "2) Run Security Tests"
    echo "3) Run Platform Comparison"
    echo "4) Generate Weekly Report"
    echo "5) Run All Tests"
    echo "6) Exit"
    echo ""
}

# Function to run benchmarks
run_benchmarks() {
    echo "📊 Running Performance Benchmarks..."
    echo "-----------------------------------"
    
    if [[ -z "$ANTHROPIC_API_KEY" ]]; then
        echo "⚠️  Warning: ANTHROPIC_API_KEY not set. Using simulation mode."
        echo ""
    fi
    
    python3 benchmark_claude.py --iterations 5
    echo ""
}

# Function to run security tests
run_security() {
    echo "🔒 Running Security Tests..."
    echo "---------------------------"
    python3 security_test.py
    echo ""
}

# Function to run platform comparison
run_comparison() {
    echo "🏃 Running Platform Comparison..."
    echo "--------------------------------"
    python3 performance_comparison.py
    echo ""
}

# Function to generate weekly report
generate_report() {
    echo "📝 Generating Weekly Report..."
    echo "-----------------------------"
    
    # Create report directory
    REPORT_DIR="reports/week_$(date +%Y%m%d)"
    mkdir -p "$REPORT_DIR"
    
    # Compile report
    cat > "$REPORT_DIR/weekly_report.md" << EOF
# Claude Code Interpreter Analysis - Weekly Report
Generated: $(date)

## This Week's Progress

### Completed Tasks
$(find benchmarks -name "*.json" -mtime -7 | wc -l) benchmark runs completed
$(find security -name "*.json" -mtime -7 | wc -l) security assessments completed
$(find case_studies -name "*.md" -mtime -7 | wc -l) case studies documented

### Key Findings

#### Performance Metrics
- Average execution time: [Run benchmarks to populate]
- Token throughput: [Run benchmarks to populate]
- Cost per operation: [Run benchmarks to populate]

#### Security Assessment
- Sandboxing: [Run security tests to populate]
- Network isolation: [Run security tests to populate]
- Resource limits: [Run security tests to populate]

#### Platform Comparison
- Best for prototyping: [Run comparison to populate]
- Best for production: [Run comparison to populate]
- Most cost-effective: [Run comparison to populate]

## Next Week's Objectives

1. [ ] Interview 3 more users for case studies
2. [ ] Test advanced ML workloads
3. [ ] Document enterprise integration patterns
4. [ ] Create video demonstration

## Recommendations

Based on this week's analysis:
1. Claude Code Interpreter is best suited for [TBD]
2. Key limitations to be aware of: [TBD]
3. Cost optimization strategies: [TBD]

EOF

    echo "✅ Report saved to: $REPORT_DIR/weekly_report.md"
    echo ""
}

# Function to run all tests
run_all() {
    echo "🎯 Running Complete Test Suite..."
    echo "================================"
    echo ""
    
    run_benchmarks
    run_security
    run_comparison
    generate_report
    
    echo "✅ All tests completed!"
    echo ""
}

# Main menu loop
while true; do
    show_menu
    read -p "Enter your choice [1-6]: " choice
    echo ""
    
    case $choice in
        1) run_benchmarks ;;
        2) run_security ;;
        3) run_comparison ;;
        4) generate_report ;;
        5) run_all ;;
        6) echo "👋 Exiting..."; exit 0 ;;
        *) echo "❌ Invalid option. Please try again." ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
    clear
done