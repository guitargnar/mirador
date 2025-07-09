#!/usr/bin/env python3
"""
Trace Ollama models back to their true base LLMs.
This script recursively follows FROM references to identify the actual base model,
correctly distinguishing between Llama, Mistral, DeepSeek, and other model families.
"""

import subprocess
import json
import re
from typing import Dict, Set, Optional, Tuple
from collections import defaultdict
import hashlib

# Known base model patterns
BASE_MODEL_PATTERNS = {
    'llama': [
        r'llama3\.2',
        r'llama3\.1', 
        r'llama3',
        r'llama2',
        r'llama-?3',
        r'llama-?2',
        r'meta-llama',
        r'meta/llama'
    ],
    'mistral': [
        r'mistral',
        r'mixtral',
        r'mistralai',
        r'mistral-7b',
        r'mistral.*instruct'
    ],
    'deepseek': [
        r'deepseek',
        r'deepseek-coder',
        r'deepseek-llm',
        r'deepseek.*coder'
    ],
    'qwen': [
        r'qwen',
        r'qwen2',
        r'qwen-.*'
    ],
    'gemma': [
        r'gemma',
        r'gemma2',
        r'google.*gemma'
    ],
    'phi': [
        r'phi',
        r'phi-?3',
        r'microsoft.*phi'
    ],
    'codellama': [
        r'codellama',
        r'code-?llama'
    ],
    'vicuna': [
        r'vicuna'
    ],
    'alpaca': [
        r'alpaca'
    ],
    'orca': [
        r'orca'
    ],
    'dolphin': [
        r'dolphin'
    ],
    'openhermes': [
        r'openhermes',
        r'open-?hermes'
    ],
    'neural-chat': [
        r'neural-?chat'
    ],
    'starling': [
        r'starling'
    ],
    'yi': [
        r'yi-'
    ],
    'falcon': [
        r'falcon'
    ],
    'starcoder': [
        r'starcoder'
    ],
    'codestral': [
        r'codestral'
    ],
    'granite': [
        r'granite'
    ],
    'command': [
        r'command'
    ],
    'claude': [
        r'claude'
    ],
    'gpt': [
        r'gpt'
    ]
}

# Known blob hash prefixes (first 12 chars) to base models
# These are common patterns found in blob paths
BLOB_SIGNATURES = {
    # Llama 3.2 variants
    'e2f46f5b501c': 'llama3.2',  # llama3.2:3b-instruct-fp16
    'dde5aa99be56': 'llama3.2',  # llama3.2:3b
    '8eeb52d7deb6': 'llama3.2',
    'f84e20b55d15': 'llama3.2',
    
    # Llama 3.1
    '7e5b3242f5cd': 'llama3.1',
    'c666f95c8640': 'llama3.1',
    
    # Mistral
    'ff82381e2bea': 'mistral',  # mistral:latest
    'e8a35b5937ce': 'mistral',
    '61e88e884507': 'mistral',
    
    # DeepSeek Coder
    'd040cc185215': 'deepseek-coder',  # deepseek-coder:latest
    'e3b0c44298fc': 'deepseek-coder',
    '6adf2c87a8f4': 'deepseek-coder',
    
    # Qwen
    '74701a8c35f6': 'qwen2',
    
    # Gemma
    '1e4c1534ac77': 'gemma2',
    'b50d6c2e2b6e': 'gemma',
    
    # Phi
    '4b78265f7990': 'phi3',
    '633fc3e3e3bd': 'phi',
    
    # CodeLlama
    '8fdf8f752f01': 'codellama',
}

class OllamaModelTracer:
    def __init__(self):
        self.model_cache: Dict[str, Dict] = {}
        self.traced_models: Dict[str, str] = {}
        self.visited: Set[str] = set()
        
    def get_installed_models(self) -> list:
        """Get list of all installed Ollama models."""
        try:
            result = subprocess.run(['ollama', 'list'], 
                                  capture_output=True, text=True, check=True)
            models = []
            for line in result.stdout.strip().split('\n')[1:]:  # Skip header
                if line.strip():
                    model_name = line.split()[0]
                    models.append(model_name)
            return models
        except subprocess.CalledProcessError as e:
            print(f"Error getting model list: {e}")
            return []
    
    def get_modelfile(self, model_name: str) -> Optional[str]:
        """Get the modelfile content for a given model."""
        try:
            result = subprocess.run(['ollama', 'show', '--modelfile', model_name],
                                  capture_output=True, text=True, check=True)
            return result.stdout
        except subprocess.CalledProcessError:
            return None
    
    def extract_from_reference(self, modelfile_content: str) -> Optional[str]:
        """Extract the FROM reference from modelfile content."""
        if not modelfile_content:
            return None
            
        for line in modelfile_content.split('\n'):
            if line.strip().upper().startswith('FROM'):
                # Extract everything after FROM
                from_value = line[4:].strip()
                # Remove quotes if present
                from_value = from_value.strip('"\'')
                return from_value
        return None
    
    def identify_base_model_from_name(self, model_name: str) -> Optional[str]:
        """Identify base model from model name patterns."""
        model_name_lower = model_name.lower()
        
        for base_model, patterns in BASE_MODEL_PATTERNS.items():
            for pattern in patterns:
                if re.search(pattern, model_name_lower):
                    return base_model
        return None
    
    def identify_base_model_from_blob(self, blob_path: str) -> Tuple[Optional[str], Optional[str]]:
        """Identify base model from blob hash patterns. Returns (family, specific_version)."""
        if '/blobs/sha256-' in blob_path:
            # Extract the hash part
            hash_part = blob_path.split('sha256-')[1]
            # Check first 12 characters against known signatures
            hash_prefix = hash_part[:12]
            
            if hash_prefix in BLOB_SIGNATURES:
                base = BLOB_SIGNATURES[hash_prefix]
                # Map specific versions to general family
                if base.startswith('llama'):
                    return 'llama', base
                elif base.startswith('mistral'):
                    return 'mistral', base
                elif base.startswith('deepseek'):
                    return 'deepseek', base
                elif base.startswith('qwen'):
                    return 'qwen', base
                elif base.startswith('gemma'):
                    return 'gemma', base
                elif base.startswith('phi'):
                    return 'phi', base
                elif base.startswith('codellama'):
                    return 'codellama', base
                return base, base
        return None, None
    
    def trace_model(self, model_name: str, depth: int = 0) -> Tuple[str, list]:
        """Recursively trace a model to its base LLM."""
        if depth > 10:  # Prevent infinite recursion
            return "unknown (max depth reached)", []
        
        if model_name in self.visited:
            return self.traced_models.get(model_name, "unknown (circular reference)"), []
        
        self.visited.add(model_name)
        trace_path = [model_name]
        
        # First check if this is a known base model
        base_from_name = self.identify_base_model_from_name(model_name)
        if base_from_name and ':' not in model_name:  # Base models don't have tags
            self.traced_models[model_name] = base_from_name
            return base_from_name, trace_path
        
        # Get modelfile content
        modelfile = self.get_modelfile(model_name)
        if not modelfile:
            # If we can't get modelfile, try to identify from name
            if base_from_name:
                self.traced_models[model_name] = base_from_name
                return base_from_name, trace_path
            return "unknown (no modelfile)", trace_path
        
        # Extract FROM reference
        from_ref = self.extract_from_reference(modelfile)
        if not from_ref:
            # No FROM found, check if model name gives us a clue
            if base_from_name:
                self.traced_models[model_name] = base_from_name
                return base_from_name, trace_path
            return "unknown (no FROM)", trace_path
        
        # Check if FROM is a blob path
        if '/blobs/sha256-' in from_ref:
            # Try to identify from blob hash
            base_family, base_version = self.identify_base_model_from_blob(from_ref)
            if base_family:
                self.traced_models[model_name] = base_family
                self.model_cache[model_name] = {'family': base_family, 'version': base_version}
                trace_path.append(f"blob:{from_ref.split('/')[-1][:12]}... ({base_version})")
                return base_family, trace_path
            
            # If we can't identify from blob, use model name
            if base_from_name:
                self.traced_models[model_name] = base_from_name
                trace_path.append(f"blob:{from_ref.split('/')[-1][:12]}...")
                return base_from_name, trace_path
            
            return "unknown (unidentified blob)", trace_path
        
        # FROM references another model, trace recursively
        if ':' in from_ref or '/' not in from_ref:
            # It's another ollama model
            base_model, sub_trace = self.trace_model(from_ref, depth + 1)
            trace_path.extend(sub_trace)
            self.traced_models[model_name] = base_model
            return base_model, trace_path
        
        # FROM might be a direct reference to a base model
        base_from_ref = self.identify_base_model_from_name(from_ref)
        if base_from_ref:
            self.traced_models[model_name] = base_from_ref
            trace_path.append(from_ref)
            return base_from_ref, trace_path
        
        return "unknown", trace_path
    
    def discover_blob_signatures(self):
        """Discover blob signatures from known base models."""
        discovered = {}
        base_models = ['llama3.2:3b', 'llama3.2:3b-instruct-fp16', 'mistral:latest', 
                      'deepseek-coder:latest', 'llama3.2:latest']
        
        for model in base_models:
            modelfile = self.get_modelfile(model)
            if modelfile:
                from_ref = self.extract_from_reference(modelfile)
                if from_ref and '/blobs/sha256-' in from_ref:
                    hash_part = from_ref.split('sha256-')[1]
                    hash_prefix = hash_part[:12]
                    discovered[hash_prefix] = model
        
        return discovered
    
    def analyze_all_models(self):
        """Analyze all installed models and generate report."""
        print("Tracing Ollama Models to Base LLMs")
        print("=" * 80)
        print()
        
        models = self.get_installed_models()
        if not models:
            print("No models found or error accessing Ollama.")
            return
        
        print(f"Found {len(models)} installed models\n")
        
        # Discover additional blob signatures
        print("Discovering blob signatures from base models...")
        discovered_sigs = self.discover_blob_signatures()
        if discovered_sigs:
            print(f"Found {len(discovered_sigs)} additional blob signatures")
            # Update our signature database
            for sig, model in discovered_sigs.items():
                if sig not in BLOB_SIGNATURES:
                    BLOB_SIGNATURES[sig] = model.split(':')[0]  # Get base name
        print()
        
        # Group models by base LLM
        base_model_groups = defaultdict(list)
        unknown_models = []
        
        # Trace each model
        for model in models:
            print(f"Tracing {model}...", end='', flush=True)
            base_model, trace_path = self.trace_model(model)
            
            if base_model.startswith("unknown"):
                unknown_models.append((model, base_model, trace_path))
            else:
                base_model_groups[base_model].append((model, trace_path))
            
            print(f" → {base_model}")
        
        # Generate report
        print("\n" + "=" * 80)
        print("MODEL TRACE REPORT")
        print("=" * 80)
        
        # Sort base models by number of derivatives
        sorted_bases = sorted(base_model_groups.items(), 
                            key=lambda x: len(x[1]), reverse=True)
        
        for base_model, model_list in sorted_bases:
            print(f"\n{base_model.upper()} Family ({len(model_list)} models)")
            print("-" * 40)
            
            # Group by version within family
            version_groups = defaultdict(list)
            for model_name, trace_path in model_list:
                version = None
                if model_name in self.model_cache and 'version' in self.model_cache[model_name]:
                    version = self.model_cache[model_name]['version']
                else:
                    # Extract version from trace path
                    for part in trace_path:
                        if '(' in part and ')' in part:
                            version = part.split('(')[1].rstrip(')')
                            break
                version_groups[version or 'unknown'].append((model_name, trace_path))
            
            # Display by version
            for version in sorted(version_groups.keys()):
                if version != 'unknown':
                    print(f"\n  Based on {version}:")
                else:
                    print(f"\n  Version unknown:")
                
                for model_name, trace_path in sorted(version_groups[version]):
                    if len(trace_path) > 1:
                        trace_str = " → ".join(trace_path[-2:])  # Show last 2 steps
                        print(f"    {model_name} ({trace_str})")
                    else:
                        print(f"    {model_name} (direct)")
        
        if unknown_models:
            print(f"\nUNKNOWN/UNIDENTIFIED ({len(unknown_models)} models)")
            print("-" * 40)
            for model_name, reason, trace_path in sorted(unknown_models):
                print(f"  {model_name} - {reason}")
                if len(trace_path) > 1:
                    trace_str = " → ".join(trace_path[:3])
                    if len(trace_path) > 3:
                        trace_str += " → ..."
                    print(f"    Trace: {trace_str}")
        
        # Summary statistics
        print("\n" + "=" * 80)
        print("SUMMARY")
        print("=" * 80)
        total_models = len(models)
        identified_models = sum(len(models) for models in base_model_groups.values())
        
        print(f"Total models: {total_models}")
        print(f"Successfully traced: {identified_models} ({identified_models/total_models*100:.1f}%)")
        print(f"Unknown/Unidentified: {len(unknown_models)} ({len(unknown_models)/total_models*100:.1f}%)")
        print(f"\nBase model families found: {len(base_model_groups)}")
        for base, models in sorted_bases[:5]:  # Top 5
            print(f"  - {base}: {len(models)} models")
        
        # Export to JSON
        output_data = {
            'total_models': total_models,
            'base_families': {
                base: [{'model': m[0], 'trace': m[1]} for m in models]
                for base, models in base_model_groups.items()
            },
            'unknown': [
                {'model': m[0], 'reason': m[1], 'trace': m[2]}
                for m in unknown_models
            ]
        }
        
        with open('ollama_model_trace_report.json', 'w') as f:
            json.dump(output_data, f, indent=2)
        
        print(f"\nDetailed report saved to: ollama_model_trace_report.json")


if __name__ == "__main__":
    tracer = OllamaModelTracer()
    tracer.analyze_all_models()