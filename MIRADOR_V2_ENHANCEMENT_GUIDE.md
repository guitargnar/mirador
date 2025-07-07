# Mirador v2.0 Enhancement Guide
## From Advisory Tool to Adaptive Life Orchestration System

### 🚀 **Quick Start with Enhanced Features**

```bash
# Quick actions format - get immediate next steps
./mirador_universal_runner_v2.sh life_optimization "How do I balance work and family today?" quick

# Executive summary format - one paragraph overview
./mirador_universal_runner_v2.sh business_acceleration "Scale my innovation strategy" summary

# Full detailed analysis (default)
./mirador_universal_runner_v2.sh strategic_synthesis "Comprehensive life planning" detailed

# JSON export for tool integration
./mirador_universal_runner_v2.sh relationship_harmony "Strengthen partnership with Katie" export
```

### 📊 **New Feedback System**

```bash
# Rate your results to improve future recommendations
./mirador_feedback.sh SESSION_ID 5 "Excellent - saved 2 hours"
./mirador_feedback.sh SESSION_ID 3 "Good but too generic"
./mirador_feedback.sh SESSION_ID 1 "Not helpful"

# View analytics on what's working
python3 context_manager.py stats
```

### ⚖️ **Constraint Validation**

```bash
# Validate any recommendation file for realistic time/energy allocations
python3 constraint_validator.py validate outputs/session_folder/summary.md

# Check your constraint profile
python3 constraint_validator.py summary

# Test the validator
python3 constraint_validator.py test
```

---

## 🎯 **What's New in v2.0**

### **1. Multi-Format Output System**
- **Quick**: 3-5 bullet points for immediate action
- **Summary**: One paragraph executive overview  
- **Detailed**: Full analysis with implementation steps
- **Export**: JSON format for productivity tool integration

### **2. Intelligent Feedback Loop**
- Rate outputs from 1-5 stars
- Track time saved for ROI measurement
- System learns your preferences over time
- Analytics show what chain types work best for you

### **3. Smart Context Caching**
- Remembers successful patterns from previous sessions
- Automatically applies learnings to new recommendations
- Builds personal pattern library over time
- Faster execution through context continuity

### **4. Constraint Validation Engine**
- Validates time allocations don't exceed 24 hours/day
- Checks energy requirements against sustainable capacity
- Monitors financial impact against your $1,650 budget
- Ensures relationship time is balanced with work activities

---

## 📁 **Enhanced File Structure**

```
mirador/
├── mirador_universal_runner_v2.sh    # Enhanced runner with format options
├── mirador_feedback.sh               # Feedback collection system
├── context_manager.py                # Context caching and pattern extraction
├── constraint_validator.py           # Time/energy/financial validation
├── MIRADOR_SCALING_COMMANDS.md       # Context-aware command library
└── outputs/                          # Enhanced output structure
    └── universal_[type]_[timestamp]/
        ├── summary.md                 # Main output
        ├── format.txt                 # Format used
        ├── quick_actions.md           # Quick format output
        ├── export.json                # JSON export
        └── step*_*.txt                # Detailed step outputs
```

---

## 🔄 **The Learning Loop**

```
Query → Context Loading → Enhanced Execution → Format Selection
   ↑                                                      ↓
Feedback → Pattern Learning ← Constraint Validation ← Output
```

### **How the System Gets Smarter:**

1. **Initial Run**: Standard context-aware recommendations
2. **Feedback Collection**: You rate the helpfulness (1-5 stars)  
3. **Pattern Extraction**: System identifies what worked well
4. **Context Caching**: Successful patterns stored for future use
5. **Improved Recommendations**: Next runs incorporate learned patterns

---

## 💡 **Advanced Usage Patterns**

### **Morning Planning Session**
```bash
# Quick daily plan
./mirador_universal_runner_v2.sh life_optimization "Today's priorities: work, Sage, Katie, coursework" quick

# Validate the plan
python3 constraint_validator.py validate outputs/latest/summary.md

# Rate the result
./mirador_feedback.sh TIMESTAMP 5 "Perfect morning structure"
```

### **Weekly Strategic Review**
```bash
# Comprehensive analysis
./mirador_universal_runner_v2.sh strategic_synthesis "Week ahead: balance innovation, relationships, education" detailed

# Get context from previous weeks
python3 context_manager.py context strategic_synthesis "weekly planning"
```

### **Quick Decision Making**
```bash
# Immediate actionable insights
./mirador_universal_runner_v2.sh business_acceleration "Should I prioritize patent filing or prototype development?" quick

# Export for further analysis
./mirador_universal_runner_v2.sh technical_mastery "Architecture decision for Mirador scaling" export
```

---

## 📈 **Performance Tracking**

### **Built-in Analytics**

```bash
# View feedback trends
python3 context_manager.py stats

# Check constraint patterns
python3 constraint_validator.py summary

# Review session history
ls -la outputs/universal_*/ | tail -10
```

### **ROI Measurement**
- Track time saved through feedback system
- Monitor constraint adherence improvement
- Measure decision speed enhancement
- Analyze pattern learning effectiveness

---

## 🎛️ **Configuration & Personalization**

### **Constraint Customization**
Edit `constraint_validator.py` to adjust:
- Available personal hours (default: 9 hours)
- Energy capacity levels (default: 10-point scale)
- Financial constraints (default: $1,650 income)
- Priority activity definitions

### **Context Pattern Tuning**
- High-rated sessions automatically become patterns
- Manual pattern injection via context cache files
- Pattern weighting based on recency and success
- Domain-specific pattern libraries

### **Format Preferences**
- Set default format per chain type
- Custom format definitions
- Integration export templates
- Output post-processing rules

---

## 🔧 **Integration with Existing Tools**

### **Productivity Apps**
```bash
# Export to Notion/Obsidian
./mirador_universal_runner_v2.sh life_optimization "Weekly planning" export
# Then import the JSON output

# Calendar integration
grep -o '\d\+\.\?\d* hours' outputs/latest/summary.md
```

### **Development Workflow**
```bash
# Quick technical decisions
./mirador_universal_runner_v2.sh technical_mastery "API design choice" quick

# Validate time estimates
python3 constraint_validator.py validate project_timeline.md
```

### **Relationship Management**
```bash
# Quick relationship check-ins
./mirador_universal_runner_v2.sh relationship_harmony "Katie conversation topics" quick

# Weekly relationship planning
./mirador_universal_runner_v2.sh relationship_harmony "Family time optimization" summary
```

---

## 🚨 **Troubleshooting**

### **Common Issues**

**Models not found:**
```bash
ollama list  # Check available models
# Ensure matthew_context_provider_v5_complete, practical_implementer, etc. exist
```

**Constraint validation errors:**
```bash
python3 constraint_validator.py test  # Run built-in test
# Adjust parameters if needed for your specific constraints
```

**Context cache not loading:**
```bash
ls -la ~/.mirador/context_cache/  # Check cache directory
python3 context_manager.py stats  # Verify database
```

### **Performance Optimization**

**Speed up execution:**
- Use `quick` format for faster responses
- Clear old context cache: `python3 context_manager.py cleanup`
- Limit model sequence for simple queries

**Improve recommendations:**
- Provide consistent feedback ratings
- Use specific prompts rather than general questions
- Review and rate outputs to build pattern library

---

## 🎉 **Success Metrics**

### **You'll Know It's Working When:**

✅ **Quick format gives you exactly what you need** - no fluff, just actions  
✅ **Recommendations stay within your time/energy constraints** - realistic plans  
✅ **System remembers what worked before** - consistent improvement  
✅ **Decision speed increases** - faster clarity on complex choices  
✅ **Work-life balance improves** - sustainable scheduling  
✅ **Relationship time is protected** - family priorities maintained  

### **Target Improvements:**
- **Decision Speed**: 50% faster complex decisions
- **Plan Adherence**: 80% of recommendations actually implementable  
- **Time ROI**: 2+ hours saved per week through better planning
- **Constraint Respect**: 95% of plans fit within real limitations
- **Pattern Learning**: Each week more personalized than the last

---

## 🔮 **What's Next: Roadmap to v3.0**

### **Phase 2: Intelligence**
- Real-time calendar integration
- Energy pattern learning from completion data
- Automatic crisis mode detection
- Relationship health indicators

### **Phase 3: Ecosystem**
- Mobile app with quick action triggers
- Slack/Teams integration for work planning
- Apple Shortcuts for voice activation
- Notion/Obsidian bi-directional sync

### **Phase 4: Autonomy**
- Proactive recommendations based on patterns
- Automatic schedule optimization
- Predictive constraint management
- Self-improving model fine-tuning

---

**Mirador v2.0 transforms from a smart advisory tool into a true life orchestration system that learns, adapts, and grows with you. Every interaction makes it smarter, every feedback improves it, and every constraint respected builds trust in its recommendations.**

*The system that helps you conduct the symphony of your competing priorities.* 🎼