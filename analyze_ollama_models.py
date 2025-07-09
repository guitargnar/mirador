#!/usr/bin/env python3
"""
Analyze Ollama models to determine which base LLMs they use
"""

import subprocess
import json
import re
import sys
from datetime import datetime
from pathlib import Path
import time

def get_model_list():
    """Get list of all Ollama models"""
    try:
        result = subprocess.run(['ollama', 'list'], capture_output=True, text=True)
        if result.returncode != 0:
            print(f"Error running ollama list: {result.stderr}")
            return []
        
        models = []
        lines = result.stdout.strip().split('\n')[1:]  # Skip header
        for line in lines:
            if line.strip():
                parts = line.split()
                if parts:
                    model_name = parts[0]
                    models.append(model_name)
        
        return models
    except Exception as e:
        print(f"Error getting model list: {e}")
        return []

def extract_modelfile(model_name):
    """Extract modelfile for a given model"""
    try:
        # Create a script to send commands to ollama
        script = f"""
echo "/show modelfile" | ollama run {model_name} --nowordwrap 2>/dev/null | grep -A 1000 "FROM" | head -n 50
"""
        
        result = subprocess.run(script, shell=True, capture_output=True, text=True)
        
        if result.returncode != 0 or not result.stdout:
            # Try alternative approach
            alt_script = f"""
printf "/show modelfile\\nexit\\n" | ollama run {model_name} 2>/dev/null | grep -A 1000 "FROM" | head -n 50
"""
            result = subprocess.run(alt_script, shell=True, capture_output=True, text=True)
        
        return result.stdout.strip()
    except Exception as e:
        print(f"Error extracting modelfile for {model_name}: {e}")
        return ""

def identify_base_llm(modelfile_content):
    """Identify the base LLM from modelfile content"""
    if not modelfile_content:
        return "Unknown"
    
    # Look for FROM line
    from_match = re.search(r'FROM\s+(\S+)', modelfile_content, re.IGNORECASE)
    if from_match:
        base_model = from_match.group(1).lower()
        
        # Identify base LLM family
        if 'llama' in base_model:
            if '3.2' in base_model:
                return "Llama 3.2"
            elif '3.1' in base_model:
                return "Llama 3.1"
            elif '3' in base_model:
                return "Llama 3"
            elif '2' in base_model:
                return "Llama 2"
            else:
                return "Llama (version unknown)"
        elif 'mistral' in base_model:
            return "Mistral"
        elif 'deepseek' in base_model:
            return "DeepSeek Coder"
        elif 'gemma' in base_model:
            if '2' in base_model:
                return "Gemma 2"
            else:
                return "Gemma"
        elif 'qwen' in base_model:
            if '2' in base_model:
                return "Qwen 2"
            else:
                return "Qwen"
        elif 'phi' in base_model:
            if '3' in base_model:
                return "Phi-3"
            else:
                return "Phi"
        elif 'vicuna' in base_model:
            return "Vicuna"
        elif 'alpaca' in base_model:
            return "Alpaca"
        elif 'codellama' in base_model:
            return "Code Llama"
        elif 'solar' in base_model:
            return "Solar"
        elif 'neural-chat' in base_model:
            return "Neural Chat"
        elif 'openhermes' in base_model:
            return "OpenHermes"
        elif 'dolphin' in base_model:
            return "Dolphin"
        else:
            # Return the base model name if we can't identify the family
            return f"Base: {base_model}"
    
    return "Unknown"

def analyze_models_batch(models, start_idx=0, batch_size=10):
    """Analyze a batch of models"""
    results = []
    end_idx = min(start_idx + batch_size, len(models))
    
    for i in range(start_idx, end_idx):
        model = models[i]
        print(f"\nAnalyzing model {i+1}/{len(models)}: {model}")
        
        # Extract modelfile
        modelfile_content = extract_modelfile(model)
        
        # Identify base LLM
        base_llm = identify_base_llm(modelfile_content)
        
        # Get model size from ollama list
        size = "Unknown"
        try:
            result = subprocess.run(['ollama', 'list'], capture_output=True, text=True)
            for line in result.stdout.split('\n'):
                if line.startswith(model):
                    parts = line.split()
                    if len(parts) >= 3:
                        size = parts[2] + " " + parts[3]
                    break
        except:
            pass
        
        results.append({
            'model': model,
            'base_llm': base_llm,
            'size': size,
            'modelfile_preview': modelfile_content[:200] + '...' if modelfile_content else 'Not available'
        })
        
        # Small delay to avoid overwhelming the system
        time.sleep(0.5)
    
    return results

def save_results(results, filename="ollama_model_analysis.json"):
    """Save analysis results to file"""
    output = {
        'timestamp': datetime.now().isoformat(),
        'total_models': len(results),
        'models': results,
        'summary': {}
    }
    
    # Create summary by base LLM
    for result in results:
        base_llm = result['base_llm']
        if base_llm not in output['summary']:
            output['summary'][base_llm] = []
        output['summary'][base_llm].append(result['model'])
    
    # Save to JSON
    with open(filename, 'w') as f:
        json.dump(output, f, indent=2)
    
    # Also create a readable report
    report_file = filename.replace('.json', '_report.md')
    with open(report_file, 'w') as f:
        f.write("# Ollama Model Analysis Report\n\n")
        f.write(f"Generated: {output['timestamp']}\n\n")
        f.write(f"Total models analyzed: {output['total_models']}\n\n")
        
        f.write("## Summary by Base LLM\n\n")
        for base_llm, model_list in sorted(output['summary'].items()):
            f.write(f"### {base_llm} ({len(model_list)} models)\n")
            for model in sorted(model_list):
                # Find size for this model
                size = next((r['size'] for r in results if r['model'] == model), 'Unknown')
                f.write(f"- {model} ({size})\n")
            f.write("\n")
        
        f.write("## Detailed Model Information\n\n")
        for result in sorted(results, key=lambda x: x['model']):
            f.write(f"### {result['model']}\n")
            f.write(f"- **Base LLM**: {result['base_llm']}\n")
            f.write(f"- **Size**: {result['size']}\n")
            f.write(f"- **Modelfile Preview**: \n```\n{result['modelfile_preview']}\n```\n\n")
    
    print(f"\nResults saved to {filename} and {report_file}")

def main():
    """Main analysis function"""
    print("Starting Ollama model analysis...")
    
    # Get all models
    models = get_model_list()
    print(f"Found {len(models)} models to analyze")
    
    if not models:
        print("No models found!")
        return
    
    # Check if we're running a specific batch
    if len(sys.argv) > 1:
        try:
            start_idx = int(sys.argv[1])
            batch_size = int(sys.argv[2]) if len(sys.argv) > 2 else 10
        except:
            start_idx = 0
            batch_size = len(models)
    else:
        start_idx = 0
        batch_size = len(models)
    
    # Analyze models
    results = analyze_models_batch(models, start_idx, batch_size)
    
    # Save results
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"ollama_model_analysis_{timestamp}.json"
    save_results(results, filename)
    
    print("\nAnalysis complete!")

if __name__ == "__main__":
    main()