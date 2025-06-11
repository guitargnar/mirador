#!/bin/bash

echo "============================================="
echo "📋 MIRADOR ACTION TRACKER GENERATOR"
echo "============================================="
echo ""

OUTPUT_DIR="$HOME/ai_framework_git/outputs"
TRACKER="$HOME/ai_framework_git/ACTION_TRACKER.md"

# Create the tracker
cat > "$TRACKER" << 'HEADER'
# 📋 MIRADOR ACTION TRACKER
Generated: DATE_PLACEHOLDER

## 🚀 IMMEDIATE ACTIONS (This Week)

| Action | Source | Status | Notes |
|--------|--------|--------|-------|
HEADER

sed -i '' "s/DATE_PLACEHOLDER/$(date)/" "$TRACKER"

# Extract immediate actions
find "$OUTPUT_DIR" -name "summary.md" -mtime -7 -exec grep -h "^1\." {} \; 2>/dev/null | \
    head -20 | while read action; do
    echo "| $action | Chain | ⬜ | |" >> "$TRACKER"
done

# Add sections for different timeframes
cat >> "$TRACKER" << 'SECTIONS'

## 📅 SHORT-TERM ACTIONS (Next 30 Days)

| Action | Source | Target Date | Status |
|--------|--------|-------------|--------|

## 🎯 MEDIUM-TERM GOALS (3-6 Months)

| Goal | Steps | Progress | Notes |
|------|-------|----------|-------|

## 🏆 LONG-TERM OBJECTIVES (6-12 Months)

| Objective | Milestones | Status | Value |
|-----------|------------|--------|-------|

## 📊 TRACKING METRICS

- Total Actions Identified: 
- Actions Completed: 
- Success Rate: 
- Value Generated: 

SECTIONS

echo "✅ Action tracker created at: $TRACKER"
echo ""
echo "============================================="
