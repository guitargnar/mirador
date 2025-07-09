# Mirador Immediate Improvement Action Plan

## Priority 1: Model Base Migration (30 minutes)

Execute these commands to migrate to the more reliable `llama3.2_balanced` base:

```bash
cd ~/ai_framework_git

# Update financial_planning_expert_v5
sed -i '' 's/FROM llama3.2/FROM llama3.2_balanced/' financial_planning_expert_v5.modelfile
ollama create financial_planning_expert_v5 -f financial_planning_expert_v5.modelfile

# Update enhanced_agent_fast_v3  
sed -i '' 's/FROM llama3.2/FROM llama3.2_balanced/' enhanced_agent_fast_v3.modelfile
ollama create enhanced_agent_fast_v3 -f enhanced_agent_fast_v3.modelfile

# Update louisville_expert_v2
sed -i '' 's/FROM llama3.2/FROM llama3.2_balanced/' louisville_expert_v2.modelfile
ollama create louisville_expert_v2 -f louisville_expert_v2.modelfile

# Test the updated models
mirador-ez ask financial_planning_expert_v5 "Quick test of updated model"
```

## Priority 2: Enhanced Error Handling (45 minutes)

Add this improved error handling to your mirador.py:

```python
def query_model(self, model_name, prompt, context="", max_retries=3):
    """Query a single model with retry logic"""
    full_prompt = f"{context}\n\n{prompt}" if context else prompt
    
    for attempt in range(max_retries):
        try:
            payload = {
                "model": model_name,
                "prompt": full_prompt,
                "stream": False
            }
            
            print(f"Querying {model_name}... (attempt {attempt + 1})")
            start_time = time.time()
            
            response = requests.post(
                f"{self.ollama_url}/api/generate",
                json=payload,
                timeout=self.timeout
            )
            
            end_time = time.time()
            duration = end_time - start_time
            
            if response.status_code == 200:
                result = response.json()
                response_text = result.get('response', '')
                if len(response_text.strip()) > 50:  # Validate meaningful response
                    print(f"✓ {model_name} completed ({duration:.0f}s)")
                    return response_text
                else:
                    print(f"⚠ {model_name} returned short response, retrying...")
                    continue
            else:
                print(f"⚠ HTTP {response.status_code}, retrying...")
                continue
                
        except requests.exceptions.Timeout:
            print(f"⚠ {model_name} timeout (attempt {attempt + 1}), retrying...")
            continue
        except Exception as e:
            print(f"⚠ Error with {model_name}: {e}")
            if attempt == max_retries - 1:
                return f"Error: Failed to get response from {model_name} after {max_retries} attempts"
            continue
    
    return f"Error: {model_name} failed after {max_retries} attempts"
```

## Priority 3: Model Consolidation (15 minutes)

Clean up model versions to focus on the best performers:

```bash
# Remove older model versions (keep only the latest working versions)
ollama rm financial_planning_expert_v2:latest
ollama rm financial_planning_expert_v3:latest  
ollama rm financial_planning_expert_v4:latest
ollama rm enhanced_agent_fast_v2:latest
ollama rm enhanced_agent_fast_v4:latest
ollama rm enhanced_agent_fast_v5:latest
ollama rm enhanced_agent_fast_v6:latest

# Keep only: financial_planning_expert_v5, enhanced_agent_fast_v3, louisville_expert_v2
# Verify remaining models
ollama list | grep -E "(financial_planning_expert_v5|enhanced_agent_fast_v3|louisville_expert_v2)"
```

## Priority 4: System Health Monitoring (20 minutes)

Create an enhanced monitoring script:

```bash
cat > enhanced_health_check.sh << 'EOF'
#!/bin/bash

echo "=== Mirador Enhanced Health Check ==="
echo "Timestamp: $(date)"
echo ""

# Check Ollama service
if ! pgrep ollama > /dev/null; then
    echo "❌ Ollama service not running - starting..."
    brew services restart ollama
    sleep 10
fi

# Test core models
models=("financial_planning_expert_v5" "enhanced_agent_fast_v3" "louisville_expert_v2")
for model in "${models[@]}"; do
    echo "Testing $model..."
    start_time=$(date +%s)
    result=$(mirador-ez ask "$model" "Health check test" 2>&1)
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    
    if [[ $result == *"Error"* ]] || [ $duration -gt 60 ]; then
        echo "❌ $model: FAILED (${duration}s)"
    else
        echo "✅ $model: OK (${duration}s)"
    fi
done

# Check output directory health
output_count=$(ls ~/ai_framework_git/outputs/ 2>/dev/null | wc -l | tr -d ' ')
echo ""
echo "Output Directory: $output_count chains stored"

# Check for recent activity
recent=$(find ~/ai_framework_git/outputs/ -name "summary.md" -newermt "24 hours ago" | wc -l | tr -d ' ')
echo "Recent Activity: $recent chains in last 24 hours"

echo ""
echo "=== Health Check Complete ==="
EOF

chmod +x enhanced_health_check.sh
./enhanced_health_check.sh
```

## Priority 5: Quick Performance Test (10 minutes)

Validate improvements with a comprehensive test:

```bash
# Test the improved system
echo "Testing improved Mirador system..."

# Single model test
time mirador-ez ask financial_planning_expert_v5 "Analyze budget optimization for $75,000 income in Louisville"

# Chain test  
time mirador-ez chain "Financial optimization with local resources" financial_planning_expert_v5 louisville_expert_v2 enhanced_agent_fast_v3

# Check results
ls -la outputs/
cat outputs/chain_*/summary.md | head -50
```

## Expected Improvements

After implementing these changes, you should see:

- **Reliability**: Reduced timeout errors and failed model responses
- **Performance**: More consistent response times (15-25 seconds per model)
- **Quality**: Better chain coherence with llama3.2_balanced base
- **Maintenance**: Cleaner model inventory and easier troubleshooting
- **Monitoring**: Proactive identification of system issues

## Next Steps After Immediate Fixes

1. **Week 2**: Implement automated scheduling for weekly analysis
2. **Week 3**: Add external data integration (financial APIs, local news)
3. **Week 4**: Create quality scoring and validation framework
4. **Month 2**: Build advanced output formatting and task integration

This action plan addresses the most critical issues identified in the analysis while setting up the foundation for longer-term enhancements.

