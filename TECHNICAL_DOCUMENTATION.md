Mirador Technical Documentation
Table of Contents

System Architecture
Component Details
Model Specifications
Chain Execution Flow
Memory System
Performance Optimization
Troubleshooting

System Architecture
Overview
Mirador employs a layered architecture that separates concerns and enables flexible orchestration of multiple AI models:
┌─────────────────────────────────────────────────────────────┐
│                    APPLICATION LAYER                         │
├─────────────────────────────────────────────────────────────┤
│ • mirador-smart-v2: Intelligent query routing               │
│ • mirador-ez: Direct model access                           │
│ • mirador_with_memory.sh: Memory-enhanced queries          │
│ • CLI Scripts: Automation and workflows                     │
└─────────────────────────────────────────────────────────────┘
                               │
┌─────────────────────────────────────────────────────────────┐
│                  ORCHESTRATION LAYER                         │
├─────────────────────────────────────────────────────────────┤
│ • Chain Manager: Sequential model execution                 │
│ • Context Builder: Inter-model communication               │
│ • Smart Router: Query pattern matching                      │
│ • Cache Manager: Response optimization                      │
└─────────────────────────────────────────────────────────────┘
                               │
┌─────────────────────────────────────────────────────────────┐
│                     MODEL LAYER                              │
├─────────────────────────────────────────────────────────────┤
│ • Personality Models: matthew_context_provider_v3           │
│ • Domain Experts: financial, louisville, music             │
│ • Synthesis Models: enhanced_agent, decision_simplifier     │
│ • Meta Models: system_specialist, feedback_optimizer        │
└─────────────────────────────────────────────────────────────┘
                               │
┌─────────────────────────────────────────────────────────────┐
│                   RUNTIME LAYER (Ollama)                     │
├─────────────────────────────────────────────────────────────┤
│ • Model Loading: Dynamic model initialization               │
│ • Inference Engine: LLM computation                         │
│ • Resource Management: Memory and CPU allocation            │
│ • Model Storage: ~/.ollama/models/                         │
└─────────────────────────────────────────────────────────────┘
                               │
┌─────────────────────────────────────────────────────────────┐
│                    STORAGE LAYER                             │
├─────────────────────────────────────────────────────────────┤
│ • SQLite Database: mirador_memory.db                        │
│ • Output Files: ~/ai_framework_git/outputs/                │
│ • Model Cache: ~/.ollama/models/blobs/                     │
│ • Logs: ~/.mirador/logs/                                   │
└─────────────────────────────────────────────────────────────┘
Data Flow
mermaidgraph TD
    A[User Query] --> B{Smart Router}
    B -->|Financial| C[Financial Chain]
    B -->|Music| D[Music Chain]
    B -->|Local| E[Louisville Chain]
    B -->|General| F[Default Chain]
    
    C --> G[matthew_context_provider_v3]
    D --> G
    E --> G
    F --> G
    
    G --> H[Domain Expert]
    H --> I[Synthesis Model]
    I --> J[decision_simplifier_v3]
    J --> K[Formatted Output]
    
    K --> L[(Memory DB)]
    K --> M[Output Files]
    K --> N[User Response]
Component Details
1. Command Line Interface
mirador-smart-v2

Purpose: Intelligent query routing based on content analysis
Technology: Bash script with regex pattern matching
Features:

Automatic chain selection
Query type detection
Progress visualization
Error handling



mirador-ez

Purpose: Direct access to Mirador Python core
Technology: Bash wrapper around Python
Features:

Model querying
Chain execution
Output management



2. Python Core Components
mirador.py

Main orchestration engine
Handles chain execution logic
Manages model communication
Implements timeout handling

mirador_memory.py

SQLite database interface
Query history tracking
Pattern recognition
Performance analytics

3. Model Management
Model Files (.modelfile)
Standard Ollama modelfile format:
FROM llama3.2
SYSTEM """[System prompt defining model behavior]"""
PARAMETER temperature 0.3
PARAMETER top_p 0.9
PARAMETER repeat_penalty 1.1
PARAMETER num_predict 800
Model Specifications
Personality Model
yamlname: matthew_context_provider_v3
base: llama3.2
purpose: Provide personality context and user profile
parameters:
  temperature: 0.3  # Low for consistency
  top_p: 0.9
  num_predict: 800
  repeat_penalty: 1.1
key_features:
  - Big Five personality integration
  - Personal goals and values
  - Location context
  - Family considerations
Domain Expert Models
yamlfinancial_planning_expert_v8:
  base: llama3.2
  specialization: Louisville-specific financial planning
  context_window: 4096
  response_length: 1500 tokens
  
louisville_expert_v3:
  base: llama3.2
  specialization: Local knowledge and resources
  context_window: 4096
  response_length: 1200 tokens
Synthesis Models
yamlenhanced_agent_enforcer:
  base: llama3.2
  purpose: Strategic analysis and synthesis
  temperature: 0.4  # Balanced creativity
  
decision_simplifier_v3:
  base: llama3.2
  purpose: Convert analysis to actions
  temperature: 0.3  # Focused output
  format: Structured with timelines
Chain Execution Flow
1. Query Reception
pythondef process_query(query: str) -> dict:
    # Pattern matching for query type
    query_type = detect_query_type(query)
    
    # Select appropriate chain
    chain = select_chain(query_type)
    
    # Execute chain
    return execute_chain(query, chain)
2. Context Building
Each model in the chain receives:

Original query
Previous model outputs
User context (from matthew_context_provider)
Chain position awareness

3. Model Execution
bash# Timeout wrapper for reliability
timeout 30s ollama run "$model" "$prompt"

# Progress tracking
echo "Step $current/$total: Running $model"
4. Output Processing

Content length tracking
Contribution analysis
Category assignment
Summary generation

Memory System
Database Schema
sql-- Core tables in mirador_memory.db

CREATE TABLE analysis_history (
    id INTEGER PRIMARY KEY,
    query TEXT NOT NULL,
    query_hash TEXT NOT NULL,
    models_used TEXT NOT NULL,
    output_path TEXT,
    execution_time REAL,
    quality_score REAL,
    user_rating INTEGER,
    was_actionable BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE model_performance (
    id INTEGER PRIMARY KEY,
    model_name TEXT NOT NULL,
    query_type TEXT,
    response_quality REAL,
    execution_time REAL,
    hallucination_detected BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE success_patterns (
    id INTEGER PRIMARY KEY,
    pattern_type TEXT NOT NULL,
    pattern_description TEXT,
    success_rate REAL,
    sample_queries TEXT,
    recommended_chain TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
Memory Integration
python# Query similarity detection
def find_similar_queries(query: str, threshold: float = 0.7):
    query_hash = generate_hash(query)
    similar = db.execute("""
        SELECT * FROM analysis_history 
        WHERE similarity(query_hash, ?) > ?
        ORDER BY created_at DESC
        LIMIT 5
    """, (query_hash, threshold))
    return similar
Performance Optimization
1. Model Loading Strategy

Keep frequently used models in memory
Lazy loading for specialized models
Automatic unloading after timeout

2. Caching System
bash# Response caching for repeated queries
CACHE_DIR="$HOME/.mirador/cache"
CACHE_KEY=$(echo "$query$model" | md5)
CACHE_FILE="$CACHE_DIR/$CACHE_KEY"

if [ -f "$CACHE_FILE" ] && [ $(find "$CACHE_FILE" -mmin -60) ]; then
    cat "$CACHE_FILE"
else
    # Execute and cache
    response=$(ollama run "$model" "$query")
    echo "$response" > "$CACHE_FILE"
    echo "$response"
fi
3. Parallel Processing
For independent analyses:
bash# Run Louisville and Financial experts in parallel
{
    mirador-ez ask louisville_expert_v3 "$query" > /tmp/louisville_out &
    mirador-ez ask financial_planning_expert_v8 "$query" > /tmp/financial_out &
    wait
}
4. Resource Management

Memory limits: 8GB per model max
CPU allocation: 4 cores per inference
Timeout limits: 30s individual, 180s chain

Troubleshooting
Common Issues
1. "Conductor not available"

Cause: Fallback message when conductor script not integrated
Solution: Use mirador-smart-v2 for intelligent routing
Impact: None - system works normally

2. Model Timeout

Symptoms: Process hangs beyond 30 seconds
Solution:
bash# Kill hanging process
pkill -f "ollama run"

# Restart with shorter prompt
mirador-ez ask model "Shorter query"


3. Memory Database Errors

Check database integrity:
bashsqlite3 mirador_memory.db "PRAGMA integrity_check"

Reset if corrupted:
bashmv mirador_memory.db mirador_memory.db.backup
python3 mirador_memory.py --init


4. High Memory Usage

Monitor usage:
bashps aux | grep ollama

Clear model cache:
bashollama rm unused_model


Performance Tuning
Optimize Response Time
bash# Reduce num_predict for faster responses
PARAMETER num_predict 500  # Instead of 800

# Use lower temperature for deterministic output
PARAMETER temperature 0.2  # Instead of 0.4
Optimize Quality
bash# Increase context window
PARAMETER num_ctx 8192  # Instead of 4096

# Adjust repetition penalty
PARAMETER repeat_penalty 1.2  # Reduce repetition
Debug Mode
Enable verbose logging:
bash# Set debug environment variable
export MIRADOR_DEBUG=1

# Run with debug output
./mirador-smart-v2 "Test query" 2>&1 | tee debug.log
API Reference
Model Interface
pythonclass MiradorModel:
    def __init__(self, name: str, base: str = "llama3.2"):
        self.name = name
        self.base = base
        
    def query(self, prompt: str, timeout: int = 30) -> str:
        """Execute model query with timeout"""
        
    def health_check(self) -> bool:
        """Verify model is responsive"""
Chain Interface
pythonclass MiradorChain:
    def __init__(self, models: List[str]):
        self.models = models
        
    def execute(self, query: str) -> ChainResult:
        """Execute full chain with progress tracking"""
        
    def visualize(self) -> str:
        """Generate execution visualization"""
System Requirements
Minimum Specifications

CPU: Apple M1 or Intel i7 (8th gen+)
RAM: 16GB (8GB available for Ollama)
Storage: 50GB free space
OS: macOS 13+ or Ubuntu 20.04+

Recommended Specifications

CPU: Apple M3 Max or Intel i9
RAM: 32GB+
Storage: 100GB+ SSD
GPU: Optional but improves performance

Software Dependencies
txtollama>=2.0.0
python>=3.11
sqlite3>=3.35
bash>=5.0
coreutils  # For gtimeout on macOS
Security Considerations

Local Execution: All processing happens locally
No External APIs: No data leaves your machine
Secure Storage: SQLite database with local access only
Model Isolation: Each model runs in isolated context
Output Sanitization: Automatic PII detection available


For additional technical details, see the source code documentation in each component file.
