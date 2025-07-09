#!/usr/bin/env python3
"""
Analyze Ollama models to identify duplicates and consolidation opportunities
"""

import subprocess
import json
import hashlib
from collections import defaultdict
from datetime import datetime
import os

def get_model_hash(modelfile_content):
    """Generate a hash of the meaningful content of a modelfile"""
    if not modelfile_content:
        return None
    
    # Extract meaningful parts (ignore comments and whitespace)
    lines = []
    for line in modelfile_content.split('\n'):
        line = line.strip()
        # Skip comments and empty lines
        if line and not line.startswith('#'):
            # Normalize the line
            if line.upper().startswith('FROM'):
                # Normalize FROM references
                lines.append(line.upper())
            elif line.upper().startswith('PARAMETER'):
                # Include parameters as they affect behavior
                lines.append(line.upper())
            elif line.upper().startswith('SYSTEM'):
                # System prompts are important for differentiation
                lines.append(line)
    
    # Create hash of normalized content
    content = '\n'.join(sorted(lines))  # Sort to ignore order
    return hashlib.md5(content.encode()).hexdigest()

def get_modelfile(model_name):
    """Get modelfile content for a model"""
    try:
        result = subprocess.run(['ollama', 'show', '--modelfile', model_name],
                              capture_output=True, text=True, check=True)
        return result.stdout
    except:
        return None

def analyze_duplicates():
    """Analyze all models for duplication"""
    print("🔍 Analyzing Ollama models for duplicates...\n")
    
    # Get all models
    result = subprocess.run(['ollama', 'list'], capture_output=True, text=True)
    models = []
    for line in result.stdout.strip().split('\n')[1:]:
        if line.strip():
            model_name = line.split()[0]
            size = ' '.join(line.split()[2:4])
            models.append({'name': model_name, 'size': size})
    
    # Group models by various criteria
    by_hash = defaultdict(list)
    by_base_and_size = defaultdict(list)
    by_system_prompt = defaultdict(list)
    model_details = {}
    
    print(f"Analyzing {len(models)} models...")
    
    for model in models:
        model_name = model['name']
        print(f"  Checking {model_name}...", end='', flush=True)
        
        modelfile = get_modelfile(model_name)
        if not modelfile:
            print(" ❌ No modelfile")
            continue
        
        # Extract details
        from_line = None
        system_prompt = None
        parameters = {}
        
        for line in modelfile.split('\n'):
            if line.strip().upper().startswith('FROM'):
                from_line = line.strip()
            elif line.strip().upper().startswith('SYSTEM'):
                # Extract system prompt
                start_idx = modelfile.find('SYSTEM')
                if start_idx != -1:
                    # Find the end of system prompt (next command or end)
                    end_markers = ['PARAMETER', 'FROM', 'TEMPLATE', 'LICENSE']
                    end_idx = len(modelfile)
                    for marker in end_markers:
                        idx = modelfile.find(marker, start_idx + 6)
                        if idx != -1 and idx < end_idx:
                            end_idx = idx
                    system_prompt = modelfile[start_idx:end_idx].strip()
                    # Get first 100 chars for comparison
                    system_prompt = system_prompt[:100]
            elif line.strip().upper().startswith('PARAMETER'):
                parts = line.split(None, 2)
                if len(parts) >= 3:
                    parameters[parts[1]] = parts[2]
        
        # Generate hash
        content_hash = get_model_hash(modelfile)
        
        # Store details
        model_details[model_name] = {
            'size': model['size'],
            'from': from_line,
            'system_prompt': system_prompt,
            'parameters': parameters,
            'hash': content_hash
        }
        
        # Group by hash (exact duplicates)
        if content_hash:
            by_hash[content_hash].append(model_name)
        
        # Group by base model and size (potential duplicates)
        if from_line:
            base_key = f"{from_line}_{model['size']}"
            by_base_and_size[base_key].append(model_name)
        
        # Group by system prompt start
        if system_prompt:
            prompt_key = system_prompt[:50]  # First 50 chars
            by_system_prompt[prompt_key].append(model_name)
        
        print(" ✓")
    
    # Generate report
    report = {
        'timestamp': datetime.now().isoformat(),
        'total_models': len(models),
        'duplicate_groups': [],
        'consolidation_opportunities': [],
        'model_details': model_details
    }
    
    print("\n" + "="*80)
    print("DUPLICATE ANALYSIS REPORT")
    print("="*80)
    
    # 1. Exact duplicates (same hash)
    print("\n1. EXACT DUPLICATES (identical modelfiles)")
    print("-" * 40)
    exact_duplicates = 0
    for hash_val, model_list in by_hash.items():
        if len(model_list) > 1:
            exact_duplicates += len(model_list) - 1
            print(f"\nDuplicate group ({len(model_list)} models):")
            for model in sorted(model_list):
                size = model_details[model]['size']
                print(f"  - {model} ({size})")
            report['duplicate_groups'].append({
                'type': 'exact',
                'models': model_list,
                'hash': hash_val
            })
    
    if exact_duplicates == 0:
        print("  No exact duplicates found!")
    else:
        print(f"\nTotal redundant models: {exact_duplicates}")
    
    # 2. Near duplicates (same base and size)
    print("\n\n2. NEAR DUPLICATES (same base model and size)")
    print("-" * 40)
    near_duplicates = 0
    for base_key, model_list in by_base_and_size.items():
        if len(model_list) > 1:
            # Check if they're actually different
            hashes = set(model_details[m]['hash'] for m in model_list)
            if len(hashes) > 1:  # Different content
                print(f"\nPotential consolidation ({len(model_list)} models):")
                print(f"Base: {base_key.split('_')[0]}")
                for model in sorted(model_list):
                    prompt = model_details[model].get('system_prompt', 'No prompt')
                    if prompt:
                        prompt = prompt[:50]
                        if len(prompt) > 47:
                            prompt += "..."
                    else:
                        prompt = 'No prompt'
                    print(f"  - {model}: {prompt}")
                near_duplicates += len(model_list) - 1
                report['consolidation_opportunities'].append({
                    'type': 'same_base',
                    'models': model_list,
                    'base': base_key
                })
    
    # 3. Model families (by name pattern)
    print("\n\n3. MODEL FAMILIES (candidates for version consolidation)")
    print("-" * 40)
    
    # Group by base name
    families = defaultdict(list)
    for model in models:
        base_name = model['name'].split('_v')[0].split(':')[0]
        if any(x in base_name for x in ['matthew_context_provider', 'enhanced_agent', 
                                         'financial_planning_expert', 'matthews_']):
            families[base_name].append(model['name'])
    
    for family, members in sorted(families.items()):
        if len(members) > 1:
            print(f"\n{family} family ({len(members)} versions):")
            for model in sorted(members):
                size = model_details.get(model, {}).get('size', 'Unknown')
                print(f"  - {model} ({size})")
            report['consolidation_opportunities'].append({
                'type': 'version_family',
                'family': family,
                'models': members
            })
    
    # 4. Storage impact
    print("\n\n4. STORAGE IMPACT ANALYSIS")
    print("-" * 40)
    
    total_size_gb = 0
    duplicate_size_gb = 0
    
    # Calculate sizes
    size_map = {'MB': 0.001, 'GB': 1.0}
    
    for model in models:
        size_parts = model['size'].split()
        if len(size_parts) == 2:
            amount = float(size_parts[0])
            unit = size_parts[1]
            size_gb = amount * size_map.get(unit, 0)
            total_size_gb += size_gb
            
            # Check if it's a duplicate
            model_name = model['name']
            if model_name in model_details:
                hash_val = model_details[model_name].get('hash')
                if hash_val and len(by_hash.get(hash_val, [])) > 1:
                    # It's a duplicate (not the first one)
                    if by_hash[hash_val].index(model_name) > 0:
                        duplicate_size_gb += size_gb
    
    print(f"Total storage used: {total_size_gb:.1f} GB")
    print(f"Duplicate storage: {duplicate_size_gb:.1f} GB")
    print(f"Potential savings: {duplicate_size_gb:.1f} GB ({duplicate_size_gb/total_size_gb*100:.1f}%)")
    
    # 5. Recommendations
    print("\n\n5. RECOMMENDATIONS")
    print("-" * 40)
    
    recommendations = []
    
    # Exact duplicates to remove
    remove_count = 0
    for hash_val, model_list in by_hash.items():
        if len(model_list) > 1:
            keep = model_list[0]  # Keep the first one
            remove = model_list[1:]
            remove_count += len(remove)
            recommendations.append({
                'action': 'remove_duplicates',
                'keep': keep,
                'remove': remove
            })
    
    if remove_count > 0:
        print(f"1. Remove {remove_count} exact duplicate models")
        
    # Version consolidation
    consolidate_families = []
    for family, members in families.items():
        if len(members) > 2:  # More than 2 versions
            consolidate_families.append(family)
            recommendations.append({
                'action': 'consolidate_versions',
                'family': family,
                'versions': members
            })
    
    if consolidate_families:
        print(f"2. Consolidate these model families:")
        for family in consolidate_families:
            print(f"   - {family} ({len(families[family])} versions → 1)")
    
    # Save report
    report['recommendations'] = recommendations
    report['summary'] = {
        'exact_duplicates': exact_duplicates,
        'near_duplicates': near_duplicates,
        'storage_impact_gb': duplicate_size_gb,
        'potential_savings_percent': duplicate_size_gb/total_size_gb*100 if total_size_gb > 0 else 0
    }
    
    with open('ollama_duplicate_analysis.json', 'w') as f:
        json.dump(report, f, indent=2)
    
    print("\n\nDetailed report saved to: ollama_duplicate_analysis.json")
    
    return report

def generate_cleanup_script(report):
    """Generate a script to safely remove duplicates"""
    print("\n📝 Generating cleanup script...")
    
    script_content = """#!/bin/bash
# Ollama Model Cleanup Script
# Generated: {timestamp}
# This script will safely remove duplicate models

echo "🧹 Ollama Model Cleanup"
echo "======================"
echo ""
echo "This script will remove duplicate models to free up storage."
echo "A backup list of all models will be saved first."
echo ""

# Backup current model list
echo "📋 Backing up model list..."
ollama list > ollama_models_backup_{date}.txt
echo "Backup saved to: ollama_models_backup_{date}.txt"
echo ""

# Confirmation
read -p "Continue with cleanup? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cleanup cancelled."
    exit 1
fi

echo ""
echo "🗑️  Removing duplicate models..."
echo ""

# Remove exact duplicates
REMOVED=0
FAILED=0

""".format(
        timestamp=datetime.now().isoformat(),
        date=datetime.now().strftime('%Y%m%d_%H%M%S')
    )
    
    # Add removal commands
    for rec in report['recommendations']:
        if rec['action'] == 'remove_duplicates':
            for model in rec['remove']:
                script_content += f"""
echo -n "Removing {model}... "
if ollama rm {model} 2>/dev/null; then
    echo "✓"
    ((REMOVED++))
else
    echo "✗ Failed"
    ((FAILED++))
fi
"""
    
    script_content += """
echo ""
echo "📊 Cleanup Summary"
echo "=================="
echo "Models removed: $REMOVED"
echo "Failed removals: $FAILED"
echo ""

# Show storage saved
echo "💾 Storage impact:"
ollama list

echo ""
echo "✅ Cleanup complete!"
echo ""
echo "To restore removed models, use the model creation scripts in the 'models' directory."
"""
    
    with open('cleanup_duplicate_models.sh', 'w') as f:
        f.write(script_content)
    
    os.chmod('cleanup_duplicate_models.sh', 0o755)
    print("Cleanup script saved to: cleanup_duplicate_models.sh")

if __name__ == "__main__":
    report = analyze_duplicates()
    generate_cleanup_script(report)