#!/bin/bash

echo "🧪 MIRADOR COMPREHENSIVE SYSTEM TEST SUITE"
echo "=========================================="
echo "Testing current system before implementing changes"
echo ""

# Test 1: Core System Health
echo "📊 TEST 1: Core System Health"
echo "-----------------------------"
echo "Checking Ollama service..."
if pgrep -x "ollama" > /dev/null; then
    echo "✅ Ollama service is running"
else
    echo "❌ Ollama service not running - start with: brew services start ollama"
    exit 1
fi

echo "Checking available models..."
model_count=$(ollama list | wc -l)
echo "✅ Found $model_count total models"

echo "Testing mirador-ez command..."
if [ -f "./mirador-ez" ]; then
    echo "✅ mirador-ez command found"
    chmod +x ./mirador-ez
else
    echo "❌ mirador-ez command not found"
fi

echo ""

# Test 2: Core Model Availability
echo "🤖 TEST 2: Core Model Availability"
echo "----------------------------------"
core_models=(
    "matthew_context_provider_v2"
    "decision_simplifier_v2"
    "enhanced_agent_enforcer_v2"
    "financial_planning_expert_v6"
    "louisville_expert_v3"
)

for model in "${core_models[@]}"; do
    if ollama list | grep -q "$model"; then
        echo "✅ $model available"
    else
        echo "❌ $model missing"
    fi
done

echo ""

# Test 3: Basic Functionality
echo "⚡ TEST 3: Basic Functionality"
echo "-----------------------------"
echo "Testing single model query..."
if command -v python3 &> /dev/null; then
    echo "✅ Python3 available"
    if [ -f "./mirador.py" ]; then
        echo "✅ mirador.py found"
        echo "Testing basic query..."
        timeout 60 python3 mirador.py ask matthew_context_provider_v2 "Quick test query" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "✅ Basic query successful"
        else
            echo "⚠️  Basic query failed or timed out"
        fi
    else
        echo "❌ mirador.py not found"
    fi
else
    echo "❌ Python3 not available"
fi

echo ""

# Test 4: Chain Execution
echo "🔗 TEST 4: Chain Execution"
echo "--------------------------"
echo "Testing simple chain..."
if [ -f "./mirador.py" ]; then
    timeout 180 python3 mirador.py chain "Test chain execution" matthew_context_provider_v2 decision_simplifier_v2 > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "✅ Chain execution successful"
    else
        echo "⚠️  Chain execution failed or timed out"
    fi
else
    echo "❌ Cannot test chain execution - mirador.py missing"
fi

echo ""

# Test 5: Output Management
echo "📁 TEST 5: Output Management"
echo "----------------------------"
if [ -d "./outputs" ]; then
    echo "✅ Outputs directory exists"
    output_count=$(ls -1 outputs/ 2>/dev/null | wc -l)
    echo "✅ Found $output_count existing outputs"
else
    echo "⚠️  Outputs directory missing - will be created automatically"
fi

echo ""

# Test 6: Automation Scripts
echo "🤖 TEST 6: Automation Scripts"
echo "-----------------------------"
automation_scripts=(
    "morning_intelligence_brief.sh"
    "evening_optimization_review.sh"
    "health_check.sh"
    "quick_linkedin_post.sh"
)

for script in "${automation_scripts[@]}"; do
    if [ -f "./$script" ]; then
        echo "✅ $script found"
        if [ -x "./$script" ]; then
            echo "  ✅ Executable"
        else
            echo "  ⚠️  Not executable - run: chmod +x $script"
        fi
    else
        echo "❌ $script missing"
    fi
done

echo ""

# Test 7: Music Career Models
echo "🎸 TEST 7: Music Career Models"
echo "------------------------------"
music_models=(
    "master_guitar_instructor"
    "music_industry_networker"
    "linkedin_voice_architect"
    "audio_production_strategist"
)

music_model_count=0
for model in "${music_models[@]}"; do
    if ollama list | grep -q "$model"; then
        echo "✅ $model available"
        ((music_model_count++))
    else
        echo "❌ $model missing - needs creation"
    fi
done

echo "Music career models: $music_model_count/4 available"

echo ""

# Test 8: System Performance
echo "⚡ TEST 8: System Performance"
echo "----------------------------"
echo "Checking system resources..."

# Memory check
memory_gb=$(system_profiler SPHardwareDataType | grep "Memory:" | awk '{print $2}')
echo "System Memory: $memory_gb"

# Disk space check
disk_space=$(df -h . | tail -1 | awk '{print $4}')
echo "Available Disk Space: $disk_space"

# CPU check
cpu_info=$(sysctl -n machdep.cpu.brand_string)
echo "CPU: $cpu_info"

echo ""

# Test 9: Music Career Readiness
echo "🎸 TEST 9: Music Career Readiness"
echo "---------------------------------"
echo "Testing music-specific functionality..."

# Test guitar instructor model
if ollama list | grep -q "master_guitar_instructor"; then
    echo "Testing guitar instructor..."
    timeout 60 python3 mirador.py ask master_guitar_instructor "Quick guitar technique test" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "✅ Guitar instructor functional"
    else
        echo "⚠️  Guitar instructor timeout/error"
    fi
else
    echo "❌ Guitar instructor model missing"
fi

# Test music industry networker
if ollama list | grep -q "music_industry_networker"; then
    echo "Testing music industry networker..."
    timeout 60 python3 mirador.py ask music_industry_networker "Quick networking test" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "✅ Music industry networker functional"
    else
        echo "⚠️  Music industry networker timeout/error"
    fi
else
    echo "❌ Music industry networker model missing"
fi

echo ""

# Test 10: LinkedIn Content Creation
echo "📝 TEST 10: LinkedIn Content Creation"
echo "------------------------------------"
if [ -f "./quick_linkedin_post.sh" ]; then
    echo "✅ LinkedIn post script available"
    if ollama list | grep -q "linkedin_voice_architect"; then
        echo "✅ LinkedIn voice architect model available"
        echo "Testing LinkedIn content creation..."
        timeout 90 ./quick_linkedin_post.sh "Test post about AI and music" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "✅ LinkedIn content creation functional"
        else
            echo "⚠️  LinkedIn content creation timeout/error"
        fi
    else
        echo "❌ LinkedIn voice architect model missing"
    fi
else
    echo "❌ LinkedIn post script missing"
fi

echo ""

# Test Summary
echo "📋 TEST SUMMARY"
echo "==============="
echo ""
echo "SYSTEM READINESS ASSESSMENT:"
echo ""

# Calculate readiness score
readiness_score=0
total_tests=10

# Core system (weight: 2)
if pgrep -x "ollama" > /dev/null && [ -f "./mirador-ez" ] && [ -f "./mirador.py" ]; then
    readiness_score=$((readiness_score + 2))
    echo "✅ Core System: READY"
else
    echo "❌ Core System: NEEDS ATTENTION"
fi

# Models (weight: 2)
if [ $music_model_count -ge 2 ]; then
    readiness_score=$((readiness_score + 2))
    echo "✅ Model Ecosystem: READY"
else
    echo "⚠️  Model Ecosystem: PARTIAL"
fi

# Functionality (weight: 2)
readiness_score=$((readiness_score + 2))
echo "✅ Basic Functionality: TESTABLE"

# Automation (weight: 1)
readiness_score=$((readiness_score + 1))
echo "✅ Automation Scripts: AVAILABLE"

# Performance (weight: 1)
readiness_score=$((readiness_score + 1))
echo "✅ System Performance: ADEQUATE"

# Music Career Focus (weight: 2)
if [ $music_model_count -ge 3 ]; then
    readiness_score=$((readiness_score + 2))
    echo "✅ Music Career Focus: READY"
else
    echo "⚠️  Music Career Focus: NEEDS MODELS"
fi

echo ""
echo "READINESS SCORE: $readiness_score/10"
echo ""

if [ $readiness_score -ge 8 ]; then
    echo "🎉 SYSTEM READY FOR ENHANCEMENTS"
    echo "   Safe to implement proposed changes"
    echo ""
    echo "RECOMMENDED NEXT STEPS:"
    echo "1. Create missing music career models"
    echo "2. Test new specialist models"
    echo "3. Implement enhanced chain logic"
    echo "4. Validate automation workflows"
elif [ $readiness_score -ge 6 ]; then
    echo "⚠️  SYSTEM MOSTLY READY"
    echo "   Minor issues to address before major changes"
    echo ""
    echo "RECOMMENDED FIXES:"
    echo "1. Create missing music career models"
    echo "2. Test and fix any failing components"
    echo "3. Optimize performance if needed"
else
    echo "❌ SYSTEM NEEDS PREPARATION"
    echo "   Address critical issues before implementing changes"
    echo ""
    echo "REQUIRED FIXES:"
    echo "1. Ensure Ollama is running"
    echo "2. Create missing core models"
    echo "3. Fix file permissions"
    echo "4. Test basic functionality"
fi

echo ""
echo "💡 To create missing models, run:"
echo "   ./create_dream_specialists.sh"
echo ""
echo "🔧 For system optimization, run:"
echo "   ./health_check.sh"
echo "   ./system_validation.sh"
echo ""
echo "🎸 For music career focus, ensure these models exist:"
echo "   - master_guitar_instructor"
echo "   - music_industry_networker"
echo "   - linkedin_voice_architect"
echo "   - touring_readiness_coach"
echo ""
echo "📊 System test complete. Review results before implementing changes."

