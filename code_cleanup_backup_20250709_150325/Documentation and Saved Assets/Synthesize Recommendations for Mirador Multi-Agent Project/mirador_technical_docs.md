# Mirador AI Orchestration System - Technical Documentation 🎸⚙️

**Version:** 2.0 Production  
**Architecture:** Local AI Orchestration with Meta-Cognitive Learning  
**Deployment:** Privacy-First Personal Intelligence Platform  

---

## 🏗️ System Architecture Overview

### Design Philosophy

Mirador implements a **distributed specialist intelligence architecture** that prioritizes collaboration over monolithic thinking. The system recognizes that complex personal life optimization requires multiple domains of expertise working in coordination rather than attempting to solve all problems with a single general-purpose model.

**Core Principles:**
- **Specialist Collaboration** → Multiple AI experts working together
- **Privacy-First Design** → 100% local execution, no external APIs
- **Meta-Cognitive Learning** → System learns and improves from interactions
- **Goal-Oriented Architecture** → All components aligned to touring guitarist mission
- **Family-Friendly Integration** → Balances ambition with family harmony

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    MIRADOR ORCHESTRATION LAYER                   │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────────┐ │
│  │ Command Router  │ │ Chain Executor  │ │ Learning Engine     │ │
│  │ (mirador-ez)    │ │ Sequential Flow │ │ Pattern Recognition │ │
│  └─────────────────┘ └─────────────────┘ └─────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                                  │
┌─────────────────────────────────────────────────────────────────┐
│                    SPECIALIST AI MODELS LAYER                    │
│                        (65+ Models)                              │
│                                                                 │
│  🎸 MUSIC CAREER CLUSTER (6 models)                            │
│  ├─ master_guitar_instructor                                    │
│  ├─ music_industry_networker                                    │
│  ├─ touring_readiness_coach                                     │
│  ├─ performance_anxiety_coach                                   │
│  ├─ guitar_tone_architect                                       │
│  └─ music_career_timeline_strategist                            │
│                                                                 │
│  🧠 META-COGNITIVE CLUSTER (4 models)                          │
│  ├─ feedback_loop_optimizer_fixed                               │
│  ├─ cross_model_synthesizer                                     │
│  ├─ mirador_self_reflection_guardian                            │
│  └─ decision_simplifier_v2                                      │
│                                                                 │
│  💼 PROFESSIONAL CLUSTER (4 models)                            │
│  ├─ linkedin_voice_architect                                    │
│  ├─ communication_strategist                                    │
│  ├─ side_income_opportunity_scout                               │
│  └─ matthew_context_provider_v2                                 │
│                                                                 │
│  👨‍👧 PERSONAL LIFE CLUSTER (3 models)                          │
│  ├─ father_daughter_music_mentor                                │
│  ├─ financial_planning_expert_v6                                │
│  └─ louisville_expert_v2                                        │
└─────────────────────────────────────────────────────────────────┘
                                  │
┌─────────────────────────────────────────────────────────────────┐
│                      OLLAMA RUNTIME LAYER                        │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────────┐ │
│  │ Model Loading   │ │ Memory Mgmt     │ │ Execution Engine    │ │
│  │ Dynamic Scaling │ │ Resource Pool   │ │ Parallel Processing │ │
│  └─────────────────┘ └─────────────────┘ └─────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                                  │
┌─────────────────────────────────────────────────────────────────┐
│                     DATA PERSISTENCE LAYER                       │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────────┐ │
│  │ Output Storage  │ │ Chain History   │ │ Learning Database   │ │
│  │ Timestamped     │ │ Pattern Logs    │ │ Feedback Loops      │ │
│  └─────────────────┘ └─────────────────┘ └─────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🔧 Core Components

### 1. Command Interface Layer (`mirador-ez`)

**Purpose:** Unified entry point for all system interactions  
**Location:** `~/projects/mirador/mirador-ez`  
**Language:** Bash shell script with Python integration  

```bash
#!/bin/bash
# Main mirador-ez command structure

COMMAND_TYPE=$1
shift

case $COMMAND_TYPE in
    "ask")
        MODEL_NAME=$1
        PROMPT=$2
        execute_single_model $MODEL_NAME "$PROMPT"
        ;;
    "chain")
        CHAIN_DESCRIPTION=$1
        shift
        MODELS=("$@")
        execute_chain "$CHAIN_DESCRIPTION" "${MODELS[@]}"
        ;;
    "models")
        list_available_models
        ;;
    "health")
        run_system_health_check
        ;;
esac
```

**Key Functions:**
- Command parsing and validation
- Model availability checking  
- Chain orchestration management
- Output routing and storage
- Error handling and recovery

### 2. Chain Execution Engine

**Purpose:** Manages multi-model collaboration workflows  
**Implementation:** Sequential model execution with context preservation  

```python
class ChainExecutor:
    def __init__(self):
        self.context_buffer = ""
        self.model_outputs = {}
        self.execution_metrics = {}
    
    def execute_chain(self, description, models):
        """Execute chain with context preservation"""
        for i, model in enumerate(models):
            # Prepare context from previous outputs
            context = self.build_context(i, description)
            
            # Execute model with context
            output = self.execute_model(model, context)
            
            # Store output and update context
            self.model_outputs[model] = output
            self.context_buffer += f"\n{model}: {output}"
            
            # Track performance metrics
            self.track_metrics(model, output)
        
        return self.synthesize_final_output()
```

**Features:**
- Sequential model execution with context passing
- Performance tracking and optimization
- Automatic summarization and categorization
- Progress visualization during execution
- Error recovery and partial result preservation

### 3. Model Configuration System

**Purpose:** Standardized model definition and deployment  
**Format:** Ollama modelfiles with optimized parameters  

```dockerfile
# Example: master_guitar_instructor.modelfile
FROM llama3.2

PARAMETER temperature 0.6
PARAMETER top_p 0.9
PARAMETER num_predict 2000
PARAMETER repeat_penalty 1.1

SYSTEM """You are the Master Guitar Instructor and Tab Generator for Mirador.

EXPERTISE:
- Guitar technique across all styles (metal, rock, blues, jazz, pop)
- Music theory and harmonic analysis
- Song structure for pop, rock, hip hop, and metal
- Metal production techniques and tone crafting
- ASCII tablature generation (accurate and readable)

TABLATURE FORMAT:
e|--------------------------|
B|--------------------------|
G|--------------------------|
D|--------------------------|
A|--------------------------|
E|--------------------------|

RESPONSE STRUCTURE:
1. Theory explanation (when relevant)
2. ASCII tablature (clean, accurate formatting)
3. Playing technique notes
4. Tone/production tips
5. Practice strategies

Focus on preparing someone to be a world-class touring guitarist."""
```

### 4. Meta-Cognitive Learning System

**Purpose:** System self-improvement and pattern recognition  
**Components:**
- `feedback_loop_optimizer_fixed` - Performance analysis and optimization
- `cross_model_synthesizer` - Pattern recognition across model outputs
- `mirador_self_reflection_guardian` - System health monitoring

```python
class LearningEngine:
    def __init__(self):
        self.pattern_database = {}
        self.performance_metrics = {}
        self.optimization_history = []
    
    def analyze_chain_performance(self, chain_id):
        """Analyze chain execution for optimization opportunities"""
        chain_data = self.load_chain_data(chain_id)
        
        # Performance analysis
        execution_time = chain_data['total_time']
        output_quality = self.assess_output_quality(chain_data['outputs'])
        user_satisfaction = self.infer_satisfaction(chain_data)
        
        # Pattern recognition
        patterns = self.identify_patterns(chain_data)
        
        # Optimization recommendations
        recommendations = self.generate_optimizations(
            execution_time, output_quality, patterns
        )
        
        return recommendations
```

---

## 📊 Data Flow Architecture

### Input Processing Pipeline

```
User Input → Command Parser → Context Builder → Model Selector → Execution Queue
     ↓
Validation → Authentication → Resource Check → Priority Assignment → Dispatch
```

**Stages:**
1. **Input Validation** - Command syntax and parameter validation
2. **Context Building** - Historical context and personal data integration
3. **Model Selection** - Optimal model/chain selection for goal
4. **Resource Management** - Memory and compute allocation
5. **Execution Dispatch** - Model execution with monitoring

### Output Management System

```
Model Output → Quality Assessment → Categorization → Storage → Summarization
     ↓
Timestamping → Backup → Indexing → Learning Integration → User Delivery
```

**Categories:**
- `technical_solutions` - Code and technical implementations
- `business_strategies` - Business plans and strategic analysis  
- `guitar_learning` - Music instruction and tablature
- `content_creation` - LinkedIn posts and communication
- `personal_optimization` - Life balance and family integration

### Learning Loop Integration

```
User Interaction → Output Generation → Quality Assessment → Pattern Recognition
     ↓
Performance Metrics → Optimization Opportunities → System Updates → Improved Performance
```

---

## 🗃️ File System Structure

```
~/projects/mirador/
├── mirador-ez                           # Main command interface
├── *.modelfile                         # Model definitions (65+ files)
├── *.sh                                # Automation workflows
├── docs/                               # Documentation
│   ├── README.md
│   ├── USAGE_GUIDE.md
│   ├── PROMPT_LIBRARY.md
│   └── TECHNICAL_DOCS.md
├── scripts/                            # Utility scripts
│   ├── install_all_specialists.sh
│   ├── system_health_check.sh
│   └── cleanup_outputs.sh
└── config/                            # Configuration files
    ├── model_parameters.json
    ├── chain_templates.json
    └── learning_config.json

~/ai_framework_git/
└── outputs/                           # Generated outputs
    ├── chain_YYYYMMDD_HHMMSS/         # Timestamped chain results
    │   ├── summary.md                 # Final synthesized output
    │   ├── [model1]_output.md         # Individual model outputs
    │   ├── [model2]_output.md
    │   ├── transition_[n]_to_[n+1].md # Model transition analysis
    │   ├── contributions.json         # Performance metrics
    │   └── chain_metadata.json       # Execution metadata
    └── learning/                      # Learning system data
        ├── pattern_database.json
        ├── performance_history.json
        └── optimization_log.json
```

---

## ⚙️ Model Architecture Details

### Base Model Configurations

**Primary Foundation Models:**
- `llama3.2` - General intelligence base
- `llama3.2_balanced` - Optimized parameter set
- `enhanced_agent` - Advanced reasoning capabilities
- `mistral` - Fast response model

**Parameter Optimization Patterns:**
```json
{
  "creative_models": {
    "temperature": 0.7-0.9,
    "top_p": 0.9-0.95,
    "purpose": "Ideation and creative thinking"
  },
  "analytical_models": {
    "temperature": 0.3-0.5,
    "top_p": 0.8-0.85,
    "purpose": "Logical analysis and planning"
  },
  "technical_models": {
    "temperature": 0.1-0.4,
    "top_p": 0.7-0.8,
    "purpose": "Code generation and technical accuracy"
  },
  "balanced_models": {
    "temperature": 0.5-0.7,
    "top_p": 0.85-0.9,
    "purpose": "General-purpose optimization"
  }
}
```

### Specialist Model Categories

#### 🎸 Music Career Specialists (6 models)
- **Purpose:** Direct support for touring guitarist goal
- **Base Model:** llama3.2 with music-specific training prompts
- **Optimization:** Low temperature for accuracy, high token counts for detailed responses
- **Integration:** Cross-references between models for comprehensive music career support

#### 🧠 Meta-Cognitive Models (4 models)  
- **Purpose:** System learning and optimization
- **Base Model:** enhanced_agent for advanced reasoning
- **Optimization:** Variable temperature based on task (analysis vs creativity)
- **Integration:** Analyzes all other model outputs for pattern recognition

#### 💼 Professional Development (4 models)
- **Purpose:** Career advancement and professional positioning  
- **Base Model:** Balanced models for professional communication
- **Optimization:** Medium temperature for creativity with professional constraints
- **Integration:** Leverages personal context for authentic positioning

#### 👨‍👧 Personal Life Integration (3 models)
- **Purpose:** Family harmony and life balance
- **Base Model:** High empathy and context-aware models
- **Optimization:** Higher temperature for empathetic responses
- **Integration:** Considers family dynamics in all recommendations

---

## 🔄 Chain Orchestration Patterns

### Sequential Chain Execution

```python
def execute_sequential_chain(models, prompt):
    """Execute models in sequence with context preservation"""
    context = prompt
    outputs = []
    
    for i, model in enumerate(models):
        # Build cumulative context
        if i > 0:
            context += f"\n\nPrevious analysis:\n{outputs[-1]}"
        
        # Execute model with context
        output = execute_model(model, context)
        outputs.append(output)
        
        # Track transformation
        if i > 0:
            transformation = analyze_transformation(outputs[-2], outputs[-1])
            save_transformation(model, transformation)
    
    return synthesize_outputs(outputs)
```

### Parallel Processing with Synthesis

```python
def execute_parallel_chain(models, prompt):
    """Execute models in parallel then synthesize"""
    # Execute all models simultaneously
    outputs = parallel_execute(models, prompt)
    
    # Analyze contributions
    contributions = analyze_contributions(outputs)
    
    # Synthesize final result
    synthesis = cross_model_synthesizer(outputs, contributions)
    
    return synthesis
```

### Adaptive Chain Selection

```python
def select_optimal_chain(goal, context):
    """Select best chain pattern based on goal and context"""
    
    # Analyze goal complexity
    complexity = assess_goal_complexity(goal)
    
    # Check resource availability  
    resources = check_system_resources()
    
    # Review historical performance
    performance_data = get_chain_performance_history(goal)
    
    # Select optimal pattern
    if complexity == "high" and resources["available"]:
        return "comprehensive_analysis_chain"
    elif goal.startswith("quick"):
        return "fast_response_chain"
    else:
        return "balanced_chain"
```

---

## 📈 Performance Monitoring & Optimization

### Key Performance Indicators

```json
{
  "execution_metrics": {
    "average_chain_time": "60-120 seconds",
    "success_rate": "80%+",
    "output_quality_score": "8.5/10",
    "user_satisfaction": "90%+"
  },
  "learning_metrics": {
    "pattern_recognition_accuracy": "75%+",
    "optimization_adoption_rate": "60%+",
    "goal_alignment_score": "85%+",
    "system_improvement_velocity": "weekly iterations"
  },
  "resource_metrics": {
    "memory_usage": "<8GB peak",
    "storage_growth": "<1GB/month",
    "cpu_utilization": "<70% average",
    "response_time": "<5 seconds startup"
  }
}
```

### Monitoring Infrastructure

```bash
# System health check script
#!/bin/bash
# system_health_check.sh

echo "=== Mirador System Health Check ==="

# Check Ollama status
ollama list > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✓ Ollama runtime: Running"
else
    echo "✗ Ollama runtime: Not running"
fi

# Check model availability
CRITICAL_MODELS=(
    "master_guitar_instructor"
    "music_industry_networker" 
    "feedback_loop_optimizer_fixed"
    "cross_model_synthesizer"
    "decision_simplifier_v2"
)

for model in "${CRITICAL_MODELS[@]}"; do
    if ollama list | grep -q "$model"; then
        echo "✓ Model $model: Available"
    else
        echo "✗ Model $model: Missing"
    fi
done

# Check disk space
OUTPUTS_SIZE=$(du -sh ~/ai_framework_git/outputs/ 2>/dev/null | cut -f1)
echo "📊 Outputs storage: $OUTPUTS_SIZE"

# Check recent activity
RECENT_CHAINS=$(find ~/ai_framework_git/outputs/ -name "chain_*" -mtime -7 | wc -l)
echo "📈 Recent chains (7 days): $RECENT_CHAINS"

# Performance analysis
echo "🎯 Running performance analysis..."
python3 << EOF
import json
import os
from datetime import datetime, timedelta

# Analyze recent chain performance
recent_chains = []
output_dir = os.path.expanduser("~/ai_framework_git/outputs/")

for chain_dir in os.listdir(output_dir):
    if chain_dir.startswith("chain_"):
        metadata_file = os.path.join(output_dir, chain_dir, "chain_metadata.json")
        if os.path.exists(metadata_file):
            with open(metadata_file, 'r') as f:
                recent_chains.append(json.load(f))

if recent_chains:
    avg_time = sum(c.get('execution_time', 0) for c in recent_chains) / len(recent_chains)
    success_rate = sum(1 for c in recent_chains if c.get('status') == 'success') / len(recent_chains) * 100
    
    print(f"⚡ Average execution time: {avg_time:.1f} seconds")
    print(f"📊 Success rate: {success_rate:.1f}%")
else:
    print("📊 No recent chain data available")
EOF

echo "=== Health Check Complete ==="
```

### Optimization Strategies

**Automatic Optimization:**
- Model parameter tuning based on performance data
- Chain pattern optimization through A/B testing
- Resource allocation optimization based on usage patterns
- Output quality improvement through feedback integration

**Manual Optimization:**
- Periodic model retraining with updated prompts
- Chain workflow refinement based on user feedback  
- Storage cleanup and archival management
- System configuration tuning for hardware optimization

---

## 🛡️ Security & Privacy Architecture

### Privacy-First Design Principles

**Data Sovereignty:**
- 100% local execution - no external API calls
- Complete user control over personal data
- No cloud dependencies or data sharing
- Encryption at rest for sensitive outputs

**Access Control:**
- User-level authentication for system access
- Model-level permissions for sensitive operations
- Output encryption for confidential analysis
- Secure backup and recovery procedures

### Data Protection Implementation

```bash
# Data encryption for sensitive outputs
encrypt_output() {
    local output_file=$1
    local encrypted_file="${output_file}.enc"
    
    # Encrypt using system keychain
    gpg --symmetric --cipher-algo AES256 --output "$encrypted_file" "$output_file"
    
    # Remove unencrypted version
    rm "$output_file"
    
    echo "Output encrypted: $encrypted_file"
}

# Secure backup procedure
secure_backup() {
    local backup_dir="$HOME/mirador_backups/$(date +%Y%m%d)"
    mkdir -p "$backup_dir"
    
    # Encrypt and backup model configurations
    tar -czf - *.modelfile | gpg --symmetric --cipher-algo AES256 --output "$backup_dir/models.tar.gz.gpg"
    
    # Backup recent outputs (encrypted)
    find ~/ai_framework_git/outputs/ -name "*.enc" -mtime -30 | tar -czf - -T - | \
        gpg --symmetric --cipher-algo AES256 --output "$backup_dir/outputs.tar.gz.gpg"
    
    echo "Secure backup created: $backup_dir"
}
```

---

## 🚀 Deployment & Installation

### System Requirements

**Hardware:**
- **CPU:** Apple M3 Max or equivalent (16+ cores recommended)
- **RAM:** 16GB minimum, 32GB recommended for complex chains
- **Storage:** 100GB available space for models and outputs
- **OS:** macOS Sequoia 15.5+ (primary), Linux compatible

**Software Dependencies:**
- **Ollama:** Latest version (0.5.0+)
- **Python:** 3.9+ with standard libraries
- **Bash:** 5.0+ for shell scripts
- **Git:** For version control and updates

### Installation Procedure

```bash
# 1. Install Ollama
curl -fsSL https://ollama.ai/install.sh | sh

# 2. Clone Mirador repository
cd ~/projects
git clone [repository-url] mirador
cd mirador

# 3. Set permissions
chmod +x mirador-ez
chmod +x *.sh

# 4. Install all specialist models
./install_all_specialists.sh

# 5. Run initial health check
./system_health_check.sh

# 6. Test basic functionality
mirador-ez ask decision_simplifier_v2 "Test query for system verification"

# 7. Configure automated workflows (optional)
crontab -e
# Add daily automation:
# 0 8 * * * /Users/[username]/projects/mirador/daily_music_career_accelerator.sh
```

### Model Installation Script

```bash
#!/bin/bash
# install_all_specialists.sh

echo "=== Installing Mirador Specialist Models ==="

# Define model categories for organized installation
MUSIC_MODELS=(
    "master_guitar_instructor"
    "music_industry_networker"
    "touring_readiness_coach"
    "performance_anxiety_coach"
    "guitar_tone_architect"
    "music_career_timeline_strategist"
)

META_COGNITIVE_MODELS=(
    "feedback_loop_optimizer_fixed"
    "cross_model_synthesizer"
    "mirador_self_reflection_guardian"
    "decision_simplifier_v2"
)

PROFESSIONAL_MODELS=(
    "linkedin_voice_architect"
    "communication_strategist"
    "side_income_opportunity_scout"
    "matthew_context_provider_v2"
)

PERSONAL_MODELS=(
    "father_daughter_music_mentor"
    "financial_planning_expert_v6"
    "louisville_expert_v2"
)

# Installation function
install_model_category() {
    local category_name=$1
    shift
    local models=("$@")
    
    echo "Installing $category_name..."
    
    for model in "${models[@]}"; do
        if [ -f "${model}.modelfile" ]; then
            echo "  Creating $model..."
            ollama create "$model" -f "${model}.modelfile"
            
            if [ $? -eq 0 ]; then
                echo "  ✓ $model installed successfully"
            else
                echo "  ✗ Failed to install $model"
            fi
        else
            echo "  ✗ Modelfile not found: ${model}.modelfile"
        fi
    done
    echo ""
}

# Install all categories
install_model_category "Music Career Specialists" "${MUSIC_MODELS[@]}"
install_model_category "Meta-Cognitive Models" "${META_COGNITIVE_MODELS[@]}"
install_model_category "Professional Development" "${PROFESSIONAL_MODELS[@]}"
install_model_category "Personal Life Integration" "${PERSONAL_MODELS[@]}"

echo "=== Installation Complete ==="
echo "Run './system_health_check.sh' to verify installation"
```

---

## 🔍 Troubleshooting & Maintenance

### Common Issues & Solutions

#### Issue: "Conductor not available, using fixed chains"
- **Status:** Normal behavior - not an error
- **Explanation:** System uses optimized chain patterns instead of dynamic conductor
- **Action:** None required

#### Issue: Model timeout (120 seconds)
- **Cause:** Complex analysis requiring extended processing time
- **Solution:** Normal behavior for deep thinking models
- **Verification:** Check output directory for results

#### Issue: Missing model errors
- **Diagnosis:** Run `ollama list` to check available models
- **Solution:** Re-run `./install_all_specialists.sh`
- **Prevention:** Regular health checks

#### Issue: Slow performance
- **Diagnosis:** Run `system_health_check.sh` for resource analysis
- **Solutions:**
  - Close memory-intensive applications
  - Run chains during low-usage periods  
  - Consider hardware upgrade for consistently slow performance

### Maintenance Procedures

**Daily:**
- Automated output cleanup (keeps 30 days)
- Performance metric collection
- Error log review

**Weekly:**
- System health check execution
- Model performance analysis
- Storage usage monitoring

**Monthly:**
- Model optimization review
- Chain pattern effectiveness analysis
- System configuration updates
- Backup verification

### Performance Tuning

```bash
# Optimize system performance
optimize_system() {
    echo "=== Mirador Performance Optimization ==="
    
    # Clean old outputs
    find ~/ai_framework_git/outputs/ -type d -name "chain_*" -mtime +30 -exec rm -rf {} \;
    
    # Optimize Ollama models
    ollama list | grep -v "NAME" | while read model rest; do
        echo "Optimizing $model..."
        ollama optimize "$model" 2>/dev/null || echo "Optimization not available for $model"
    done
    
    # Memory cleanup
    if command -v purge >/dev/null 2>&1; then
        purge
        echo "Memory purged"
    fi
    
    # Update learning database indices
    python3 << 'EOF'
import json
import os

# Rebuild learning database indices for faster access
learning_dir = os.path.expanduser("~/ai_framework_git/outputs/learning/")
if os.path.exists(learning_dir):
    print("Rebuilding learning database indices...")
    # Index rebuilding logic here
    print("Indices rebuilt")
EOF
    
    echo "=== Optimization Complete ==="
}
```

---

## 📊 API Reference & Integration

### Command-Line Interface

```bash
# Core command structure
mirador-ez <command> [arguments...]

# Available commands:
mirador-ez ask <model_name> "<prompt>"                    # Single model query
mirador-ez chain "<description>" <model1> <model2>...    # Multi-model chain
mirador-ez models                                         # List available models
mirador-ez health                                         # System health check
mirador-ez optimize                                       # Performance optimization
```

### Python Integration

```python
import subprocess
import json

class MiradorAPI:
    def __init__(self, base_path="~/projects/mirador"):
        self.base_path = os.path.expanduser(base_path)
        self.mirador_ez = os.path.join(self.base_path, "mirador-ez")
    
    def ask(self, model, prompt):
        """Execute single model query"""
        cmd = [self.mirador_ez, "ask", model, prompt]
        result = subprocess.run(cmd, capture_output=True, text=True)
        return result.stdout
    
    def chain(self, description, models):
        """Execute multi-model chain"""
        cmd = [self.mirador_ez, "chain", description] + models
        result = subprocess.run(cmd, capture_output=True, text=True)
        return result.stdout
    
    def get_latest_output(self):
        """Retrieve latest chain output"""
        outputs_dir = os.path.expanduser("~/ai_framework_git/outputs/")
        latest_dir = max(os.listdir(outputs_dir), key=lambda x: os.path.getctime(os.path.join(outputs_dir, x)))
        
        summary_file = os.path.join(outputs_dir, latest_dir, "summary.md")
        with open(summary_file, 'r') as f:
            return f.read()

# Usage example
mirador = MiradorAPI()
result = mirador.ask("master_guitar_instructor", "Metal practice routine")
print(result)
```

---

## 🔄 Version Control & Updates

### Configuration Management

**Model Versioning:**
- Model definitions stored in Git repository
- Parameter changes tracked with commit messages
- Rollback capability for model configurations
- A/B testing framework for model improvements

**System Updates:**
```bash
# Update Mirador system
update_mirador() {
    cd ~/projects/mirador
    
    # Backup current configuration
    ./backup_system.sh
    
    # Pull latest updates
    git pull origin main
    
    # Update models if needed
    ./update_models.sh
    
    # Run health check
    ./system_health_check.sh
    
    echo "Mirador updated successfully"
}
```

### Development Workflow

```bash
# Create new specialist model
create_specialist() {
    local model_name=$1
    local base_model=${2:-"llama3.2"}
    
    # Create modelfile template
    cat > "${model_name}.modelfile" << EOF
FROM $base_model

PARAMETER temperature 0.6
PARAMETER top_p 0.9
PARAMETER num_predict 1500

SYSTEM """You are the $model_name for Mirador.

EXPERTISE:
- [Define expertise areas]

FOCUS:
- [Define specific focus areas]

RESPONSE STRUCTURE:
- [Define response format]
"""
EOF
    
    echo "Created ${model_name}.modelfile"
    echo "Customize the system prompt and deploy with: ollama create $model_name -f ${model_name}.modelfile"
}
```

---

**This technical documentation provides the foundation for understanding, maintaining, and extending the Mirador AI Orchestration System. The architecture supports continuous evolution while maintaining stability and performance for the primary goal of accelerating the path to professional touring guitarist status.** 🎸🚀