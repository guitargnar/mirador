#!/bin/bash
# Performance Optimization for Large Models

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

echo -e "${BLUE}⚡ Model Performance Optimization${RESET}"
echo "=================================="
echo ""
echo "This script creates optimized versions of large models"
echo "with tuned parameters for faster response times."
echo ""

# Create optimized model directory
mkdir -p models/optimized

# Function to create optimized model
create_optimized_model() {
    local base_model=$1
    local optimized_name=$2
    local context_size=$3
    local batch_size=$4
    local gpu_layers=$5
    
    echo -e "${YELLOW}Creating $optimized_name from $base_model...${RESET}"
    
    cat > "models/optimized/${optimized_name}.modelfile" << EOF
FROM $base_model

# Performance optimizations
PARAMETER num_ctx $context_size
PARAMETER num_batch $batch_size
PARAMETER num_gpu $gpu_layers
PARAMETER num_thread 8

# Response optimizations
PARAMETER temperature 0.7
PARAMETER top_k 40
PARAMETER top_p 0.9
PARAMETER repeat_penalty 1.1
PARAMETER num_predict 2048

# Sampling optimizations
PARAMETER tfs_z 1
PARAMETER typical_p 1
PARAMETER mirostat 0
EOF

    # Create the optimized model
    ollama create "$optimized_name" -f "models/optimized/${optimized_name}.modelfile"
}

echo "Optimizing large models for performance..."
echo ""

# Optimize Gemma 2 27B
create_optimized_model "gemma2:27b" "gemma2_fast:latest" 4096 512 999

# Optimize Qwen 2.5 32B
create_optimized_model "qwen2.5:32b" "qwen2_fast:latest" 4096 512 999

# Optimize Command-R 35B
create_optimized_model "command-r:35b" "command_r_fast:latest" 8192 1024 999

echo ""
echo -e "${BLUE}📊 Creating Performance Benchmark Script${RESET}"

cat > "benchmark_models.sh" << 'EOBENCH'
#!/bin/bash
# Benchmark model performance

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

TEST_PROMPT="Explain the concept of machine learning in simple terms."
RESULTS_FILE="benchmark_results_$(date +%Y%m%d_%H%M%S).csv"

echo "model,first_token_ms,total_ms,tokens_per_sec" > "$RESULTS_FILE"

benchmark_model() {
    local model=$1
    echo -e "${YELLOW}Benchmarking $model...${RESET}"
    
    # Run multiple times and average
    local total_time=0
    local iterations=3
    
    for i in $(seq 1 $iterations); do
        # Time the model execution
        local start=$(date +%s%N)
        output=$(echo "$TEST_PROMPT" | timeout 60 ollama run "$model" 2>&1)
        local end=$(date +%s%N)
        
        local duration=$((($end - $start) / 1000000))
        total_time=$(($total_time + $duration))
        
        echo "  Run $i: ${duration}ms"
    done
    
    local avg_time=$(($total_time / $iterations))
    echo "  Average: ${avg_time}ms"
    
    # Estimate tokens per second (rough)
    local tokens=$(echo "$output" | wc -w)
    local tokens_per_sec=$(echo "scale=2; $tokens * 1000 / $avg_time" | bc)
    
    echo "$model,N/A,$avg_time,$tokens_per_sec" >> "$RESULTS_FILE"
    echo ""
}

echo -e "${BLUE}🏃 Running Model Benchmarks${RESET}"
echo "================================"
echo ""

# Benchmark original models
benchmark_model "gemma2:27b"
benchmark_model "qwen2.5:32b"
benchmark_model "command-r:35b"

# Benchmark optimized models
benchmark_model "gemma2_fast:latest"
benchmark_model "qwen2_fast:latest"
benchmark_model "command_r_fast:latest"

# Benchmark smaller models for comparison
benchmark_model "llama3.2:3b"
benchmark_model "phi3:medium"

echo -e "${GREEN}✅ Benchmark complete!${RESET}"
echo "Results saved to: $RESULTS_FILE"
echo ""
echo "Summary:"
column -t -s, "$RESULTS_FILE" | head -10
EOBENCH

chmod +x benchmark_models.sh

echo ""
echo -e "${BLUE}🧠 Creating Dynamic Model Selection Algorithm${RESET}"

cat > "select_optimal_model.py" << 'EOSELECT'
#!/usr/bin/env python3
"""
Dynamic model selection based on query characteristics
"""

import json
import re
from typing import Dict, List, Tuple

class ModelSelector:
    def __init__(self):
        # Model profiles with characteristics
        self.model_profiles = {
            # Fast models (< 1s response)
            "llama3.2:3b": {
                "speed": 10,
                "quality": 6,
                "context": 8192,
                "specialties": ["general", "quick_answers"],
                "base_llm": "llama"
            },
            "phi3:medium": {
                "speed": 9,
                "quality": 7,
                "context": 4096,
                "specialties": ["summarization", "quick_analysis"],
                "base_llm": "phi"
            },
            "speed_optimizer_phi:latest": {
                "speed": 9,
                "quality": 7,
                "context": 4096,
                "specialties": ["rapid_decision", "action_items"],
                "base_llm": "phi"
            },
            
            # Balanced models (1-5s response)
            "mistral:latest": {
                "speed": 7,
                "quality": 8,
                "context": 8192,
                "specialties": ["reasoning", "analysis"],
                "base_llm": "mistral"
            },
            "gemma2:9b": {
                "speed": 6,
                "quality": 8,
                "context": 8192,
                "specialties": ["analytical", "research"],
                "base_llm": "gemma"
            },
            
            # High-quality models (5-15s response)
            "gemma2_fast:latest": {
                "speed": 4,
                "quality": 9,
                "context": 4096,
                "specialties": ["deep_analysis", "complex_reasoning"],
                "base_llm": "gemma"
            },
            "qwen2_fast:latest": {
                "speed": 3,
                "quality": 9,
                "context": 4096,
                "specialties": ["multilingual", "cultural", "global"],
                "base_llm": "qwen"
            },
            "command_r_fast:latest": {
                "speed": 3,
                "quality": 10,
                "context": 8192,
                "specialties": ["rag", "document_analysis", "retrieval"],
                "base_llm": "command-r"
            }
        }
        
        # Query type patterns
        self.query_patterns = {
            "quick": r"(quick|brief|short|tldr|summary|list)",
            "analytical": r"(analyze|explain|compare|evaluate|assess)",
            "multilingual": r"(translate|language|cultural|international)",
            "document": r"(document|file|report|paper|code|analyze.*text)",
            "decision": r"(decide|choose|recommend|suggest|should i)",
            "complex": r"(comprehensive|detailed|in-depth|thorough)"
        }
    
    def analyze_query(self, query: str) -> Dict[str, any]:
        """Analyze query characteristics"""
        query_lower = query.lower()
        
        # Detect query type
        query_type = "general"
        for qtype, pattern in self.query_patterns.items():
            if re.search(pattern, query_lower):
                query_type = qtype
                break
        
        # Estimate required context
        word_count = len(query.split())
        required_context = min(8192, word_count * 100)
        
        # Determine speed requirement
        if re.search(r"(urgent|asap|quick|now)", query_lower):
            speed_priority = 9
        elif re.search(r"(detailed|comprehensive|thorough)", query_lower):
            speed_priority = 3
        else:
            speed_priority = 5
        
        return {
            "type": query_type,
            "required_context": required_context,
            "speed_priority": speed_priority,
            "word_count": word_count
        }
    
    def select_models(self, query: str, num_models: int = 3) -> List[str]:
        """Select optimal models for the query"""
        analysis = self.analyze_query(query)
        
        # Score each model
        model_scores = {}
        for model, profile in self.model_profiles.items():
            score = 0
            
            # Speed vs quality trade-off
            if analysis["speed_priority"] > 7:
                score += profile["speed"] * 2
                score += profile["quality"]
            else:
                score += profile["speed"]
                score += profile["quality"] * 2
            
            # Specialty match
            if analysis["type"] in profile["specialties"]:
                score += 5
            
            # Context adequacy
            if profile["context"] >= analysis["required_context"]:
                score += 3
            
            model_scores[model] = score
        
        # Sort by score and return top models
        sorted_models = sorted(model_scores.items(), key=lambda x: x[1], reverse=True)
        selected = [model for model, _ in sorted_models[:num_models]]
        
        # Ensure diversity in base LLMs
        base_llms = set()
        diverse_selection = []
        for model in selected:
            base_llm = self.model_profiles[model]["base_llm"]
            if base_llm not in base_llms or len(diverse_selection) < 2:
                diverse_selection.append(model)
                base_llms.add(base_llm)
        
        # Fill remaining slots if needed
        for model in selected:
            if model not in diverse_selection and len(diverse_selection) < num_models:
                diverse_selection.append(model)
        
        return diverse_selection
    
    def get_chain_config(self, query: str) -> Dict:
        """Get complete chain configuration"""
        analysis = self.analyze_query(query)
        models = self.select_models(query)
        
        # Add context provider as first model
        chain = ["matthew_context_provider_v6_complete:latest"] + models
        
        return {
            "query_analysis": analysis,
            "selected_models": chain,
            "estimated_time": sum(15 - self.model_profiles.get(m, {"speed": 5})["speed"] 
                                for m in models),
            "explanation": self.explain_selection(analysis, models)
        }
    
    def explain_selection(self, analysis: Dict, models: List[str]) -> str:
        """Explain why these models were selected"""
        explanations = []
        
        if analysis["type"] == "quick":
            explanations.append("Selected fast models for quick response")
        elif analysis["type"] == "analytical":
            explanations.append("Selected analytical models for deep reasoning")
        elif analysis["type"] == "multilingual":
            explanations.append("Selected multilingual models for cultural context")
        elif analysis["type"] == "document":
            explanations.append("Selected RAG-optimized models for document analysis")
        
        if analysis["speed_priority"] > 7:
            explanations.append("Prioritized speed due to urgency indicators")
        elif analysis["speed_priority"] < 3:
            explanations.append("Prioritized quality for comprehensive analysis")
        
        return ". ".join(explanations)

# CLI interface
if __name__ == "__main__":
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python select_optimal_model.py \"your query here\"")
        sys.exit(1)
    
    query = " ".join(sys.argv[1:])
    selector = ModelSelector()
    config = selector.get_chain_config(query)
    
    print(json.dumps(config, indent=2))
EOSELECT

chmod +x select_optimal_model.py

echo ""
echo -e "${BLUE}🔄 Creating Dynamic Context Sizing Script${RESET}"

cat > "dynamic_context.py" << 'EOCONTEXT'
#!/usr/bin/env python3
"""
Dynamic context sizing based on available memory and model requirements
"""

import psutil
import json
import subprocess

def get_available_memory():
    """Get available system memory in MB"""
    return psutil.virtual_memory().available // (1024 * 1024)

def get_gpu_memory():
    """Get available GPU memory (macOS Metal)"""
    try:
        # For Apple Silicon, assume we can use up to 70% of system memory for GPU
        total_memory = psutil.virtual_memory().total // (1024 * 1024)
        return int(total_memory * 0.7)
    except:
        return 0

def calculate_optimal_context(model_size_gb, available_memory_mb):
    """Calculate optimal context size based on model size and available memory"""
    # Reserve memory for model loading (GB to MB)
    model_memory = model_size_gb * 1024
    
    # Reserve 2GB for system
    system_reserve = 2048
    
    # Available for context
    context_memory = max(512, available_memory_mb - model_memory - system_reserve)
    
    # Estimate tokens per MB (rough estimate)
    tokens_per_mb = 100
    
    # Calculate context size (round to nearest power of 2)
    optimal_context = min(16384, context_memory * tokens_per_mb)
    
    # Round to nearest standard size
    standard_sizes = [2048, 4096, 8192, 16384]
    for size in standard_sizes:
        if optimal_context <= size:
            return size
    
    return 16384

def get_model_info(model_name):
    """Get model size from ollama"""
    try:
        result = subprocess.run(['ollama', 'list'], 
                              capture_output=True, text=True)
        for line in result.stdout.split('\n'):
            if model_name in line:
                parts = line.split()
                for part in parts:
                    if 'GB' in part:
                        return float(part.replace('GB', ''))
        return 5.0  # Default assumption
    except:
        return 5.0

def optimize_chain_context(models):
    """Optimize context sizes for a chain of models"""
    available_mem = get_available_memory()
    gpu_mem = get_gpu_memory()
    
    optimizations = {}
    
    for model in models:
        model_size = get_model_info(model)
        optimal_ctx = calculate_optimal_context(model_size, available_mem)
        
        optimizations[model] = {
            "context_size": optimal_ctx,
            "batch_size": min(512, optimal_ctx // 8),
            "gpu_layers": 999 if gpu_mem > model_size * 1024 else -1
        }
        
        # Reduce available memory for next model
        available_mem = max(512, available_mem - model_size * 512)
    
    return optimizations

# CLI interface
if __name__ == "__main__":
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python dynamic_context.py model1 model2 model3")
        sys.exit(1)
    
    models = sys.argv[1:]
    optimizations = optimize_chain_context(models)
    
    print(json.dumps(optimizations, indent=2))
EOCONTEXT

chmod +x dynamic_context.py

echo ""
echo -e "${GREEN}✅ Performance optimization setup complete!${RESET}"
echo ""
echo "Created files:"
echo "  - models/optimized/ - Optimized model definitions"
echo "  - benchmark_models.sh - Performance benchmarking script"
echo "  - select_optimal_model.py - Dynamic model selection"
echo "  - dynamic_context.py - Dynamic context sizing"
echo ""
echo "Next steps:"
echo "1. Run './benchmark_models.sh' to benchmark model performance"
echo "2. Test model selection: python3 select_optimal_model.py \"your query\""
echo "3. Test context sizing: python3 dynamic_context.py model1 model2 model3"