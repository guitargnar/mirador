#!/usr/bin/env python3
"""
Direct Ollama Model Analyzer using API calls
Extracts base LLM information from all installed models
"""

import subprocess
import json
import re
from datetime import datetime
from collections import defaultdict
import time

def get_all_models():
    """Get list of all installed Ollama models with their details"""
    try:
        result = subprocess.run(['ollama', 'list'], capture_output=True, text=True)
        if result.returncode != 0:
            return []
        
        models = []
        lines = result.stdout.strip().split('\n')[1:]  # Skip header
        
        for line in lines:
            if line.strip():
                parts = line.split()
                if len(parts) >= 4:
                    model_info = {
                        'name': parts[0],
                        'id': parts[1],
                        'size': f"{parts[2]} {parts[3]}",
                        'modified': ' '.join(parts[4:])
                    }
                    models.append(model_info)
        
        return models
    except Exception as e:
        print(f"Error getting models: {e}")
        return []

def get_model_info(model_name):
    """Get detailed model information using ollama show"""
    try:
        # Get model details
        result = subprocess.run(['ollama', 'show', model_name], 
                              capture_output=True, text=True)
        
        if result.returncode != 0:
            return None
        
        info = {
            'name': model_name,
            'details': result.stdout,
            'modelfile': None,
            'base_model': None,
            'parameters': {}
        }
        
        # Try to get modelfile
        result_modelfile = subprocess.run(['ollama', 'show', model_name, '--modelfile'], 
                                        capture_output=True, text=True)
        
        if result_modelfile.returncode == 0:
            info['modelfile'] = result_modelfile.stdout
            
            # Extract base model from FROM line
            from_match = re.search(r'^FROM\s+(.+)$', result_modelfile.stdout, re.MULTILINE)
            if from_match:
                info['base_model'] = from_match.group(1).strip()
            
            # Extract parameters
            param_matches = re.findall(r'^PARAMETER\s+(\w+)\s+(.+)$', 
                                     result_modelfile.stdout, re.MULTILINE)
            for param, value in param_matches:
                info['parameters'][param] = value
        
        return info
        
    except Exception as e:
        print(f"Error getting info for {model_name}: {e}")
        return None

def identify_llm_family(model_info):
    """Identify the LLM family from model information"""
    if not model_info:
        return "Unknown"
    
    # Check base model first
    base_model = model_info.get('base_model', '').lower()
    
    # Direct identification from base model
    if 'llama3.2' in base_model:
        return "Llama 3.2"
    elif 'llama3.1' in base_model:
        return "Llama 3.1"
    elif 'llama3' in base_model:
        return "Llama 3"
    elif 'llama2' in base_model:
        return "Llama 2"
    elif 'codellama' in base_model:
        return "Code Llama"
    elif 'mistral' in base_model:
        return "Mistral"
    elif 'mixtral' in base_model:
        return "Mixtral"
    elif 'deepseek' in base_model:
        return "DeepSeek"
    elif 'qwen2.5' in base_model:
        return "Qwen 2.5"
    elif 'qwen2' in base_model:
        return "Qwen 2"
    elif 'qwen' in base_model:
        return "Qwen"
    elif 'gemma2' in base_model:
        return "Gemma 2"
    elif 'gemma' in base_model:
        return "Gemma"
    elif 'phi3' in base_model or 'phi-3' in base_model:
        return "Phi-3"
    elif 'phi' in base_model:
        return "Phi"
    elif 'vicuna' in base_model:
        return "Vicuna"
    elif 'yi' in base_model:
        return "Yi"
    elif 'solar' in base_model:
        return "Solar"
    elif 'dolphin' in base_model:
        return "Dolphin"
    elif 'openhermes' in base_model:
        return "OpenHermes"
    elif 'neural-chat' in base_model:
        return "Neural Chat"
    
    # If base model references another custom model, try to trace it
    if base_model and not any(known in base_model for known in 
                              ['/', '.', 'llama', 'mistral', 'deepseek', 'qwen', 
                               'gemma', 'phi', 'vicuna', 'yi']):
        # This might be a custom model, check if we have info about it
        return f"Custom ({base_model})"
    
    # Fallback to checking model details
    details = model_info.get('details', '').lower()
    if 'llama 3.2' in details:
        return "Llama 3.2"
    elif 'llama' in details:
        return "Llama"
    elif 'mistral' in details:
        return "Mistral"
    
    return "Unknown"

def analyze_all_models():
    """Analyze all installed Ollama models"""
    print("🔍 Starting comprehensive Ollama model analysis...")
    
    # Get all models
    models = get_all_models()
    print(f"Found {len(models)} models to analyze\n")
    
    results = []
    llm_families = defaultdict(list)
    
    # Analyze each model
    for i, model in enumerate(models):
        print(f"Analyzing {i+1}/{len(models)}: {model['name']}...", end='', flush=True)
        
        # Get detailed info
        model_info = get_model_info(model['name'])
        
        # Identify LLM family
        llm_family = identify_llm_family(model_info)
        
        # Create result entry
        result = {
            'name': model['name'],
            'size': model['size'],
            'llm_family': llm_family,
            'base_model': model_info.get('base_model', 'Unknown') if model_info else 'Unknown',
            'parameters': model_info.get('parameters', {}) if model_info else {},
            'modified': model['modified']
        }
        
        results.append(result)
        llm_families[llm_family].append(result)
        
        print(f" ✓ {llm_family}")
        
        # Small delay to avoid overwhelming the system
        time.sleep(0.1)
    
    return results, llm_families

def generate_report(results, llm_families):
    """Generate comprehensive analysis report"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # Create detailed JSON report
    json_report = {
        'timestamp': timestamp,
        'total_models': len(results),
        'models': results,
        'summary_by_family': {
            family: {
                'count': len(models),
                'models': [{'name': m['name'], 'size': m['size']} for m in models]
            }
            for family, models in llm_families.items()
        }
    }
    
    with open('ollama_model_analysis.json', 'w') as f:
        json.dump(json_report, f, indent=2)
    
    # Create markdown report
    with open('OLLAMA_MODEL_REPORT.md', 'w') as f:
        f.write("# 🤖 Ollama Model Analysis Report\n\n")
        f.write(f"**Generated:** {timestamp}\n\n")
        f.write(f"**Total Models:** {len(results)}\n\n")
        
        # Summary chart
        f.write("## 📊 Model Distribution by LLM Family\n\n")
        f.write("| LLM Family | Count | Percentage | Total Size |\n")
        f.write("|------------|-------|------------|------------|\n")
        
        # Calculate totals
        total_by_family = []
        for family, models in sorted(llm_families.items(), 
                                   key=lambda x: len(x[1]), reverse=True):
            count = len(models)
            percentage = (count / len(results)) * 100
            
            # Calculate total size for this family
            total_size_gb = 0
            for model in models:
                size_str = model['size']
                if 'GB' in size_str:
                    size_gb = float(size_str.split()[0])
                    total_size_gb += size_gb
                elif 'MB' in size_str:
                    size_mb = float(size_str.split()[0])
                    total_size_gb += size_mb / 1024
            
            total_by_family.append((family, count, percentage, total_size_gb))
            f.write(f"| {family} | {count} | {percentage:.1f}% | {total_size_gb:.1f} GB |\n")
        
        # Detailed breakdown
        f.write("\n## 📋 Detailed Model Inventory\n\n")
        
        for family, models in sorted(llm_families.items()):
            f.write(f"### {family} Models ({len(models)})\n\n")
            
            # Group by base model
            by_base = defaultdict(list)
            for model in models:
                base = model.get('base_model', 'Unknown')
                by_base[base].append(model)
            
            for base, base_models in sorted(by_base.items()):
                if base != 'Unknown':
                    f.write(f"**Base: `{base}`**\n\n")
                
                f.write("| Model Name | Size | Modified |\n")
                f.write("|------------|------|----------|\n")
                
                for model in sorted(base_models, key=lambda x: x['name']):
                    f.write(f"| {model['name']} | {model['size']} | {model['modified']} |\n")
                
                f.write("\n")
        
        # Model creation chains
        f.write("## 🔗 Model Dependency Chains\n\n")
        f.write("Models that are built on other custom models:\n\n")
        
        custom_chains = []
        for result in results:
            base = result.get('base_model', '')
            if base and not any(x in base for x in ['/', '.', 'llama', 'mistral', 
                                                     'deepseek', 'qwen', 'gemma']):
                custom_chains.append((result['name'], base))
        
        if custom_chains:
            f.write("```mermaid\ngraph TD\n")
            for model, base in sorted(custom_chains):
                f.write(f"    {base} --> {model}\n")
            f.write("```\n\n")
        else:
            f.write("*No custom model chains detected*\n\n")
        
        # Size analysis
        f.write("## 💾 Storage Analysis\n\n")
        
        total_storage = sum(item[3] for item in total_by_family)
        f.write(f"**Total Storage Used:** {total_storage:.1f} GB\n\n")
        
        f.write("### Storage by Model Size\n\n")
        size_groups = defaultdict(list)
        for result in results:
            size = result['size']
            size_groups[size].append(result['name'])
        
        f.write("| Size | Count | Models (sample) |\n")
        f.write("|------|-------|----------------|\n")
        
        for size, models in sorted(size_groups.items(), 
                                  key=lambda x: len(x[1]), reverse=True):
            sample = ', '.join(models[:3])
            if len(models) > 3:
                sample += f" (+{len(models)-3} more)"
            f.write(f"| {size} | {len(models)} | {sample} |\n")
    
    print(f"\n✅ Analysis complete! Reports saved to:")
    print(f"   - ollama_model_analysis.json")
    print(f"   - OLLAMA_MODEL_REPORT.md")

def main():
    """Main analysis function"""
    results, llm_families = analyze_all_models()
    generate_report(results, llm_families)
    
    # Print quick summary
    print(f"\n📊 Quick Summary:")
    for family, models in sorted(llm_families.items(), 
                               key=lambda x: len(x[1]), reverse=True)[:5]:
        print(f"   {family}: {len(models)} models")

if __name__ == "__main__":
    main()