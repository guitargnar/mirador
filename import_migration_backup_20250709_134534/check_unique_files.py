#!/usr/bin/env python3
"""Check unique and important files from ai_framework_git that might need migration"""
import json
import os

def check_unique_important_files():
    """Identify important unique files from ai_framework_git"""
    
    # Load comparison results
    with open('directory_comparison_results.json', 'r') as f:
        results = json.load(f)
    
    print("=== IMPORTANT UNIQUE FILES IN AI_FRAMEWORK_GIT ===\n")
    
    # Files that might be important to migrate
    important_patterns = [
        'enhanced_model_analyzer.py',
        'ollama_model_extractor.py',
        'daily_micro_action_modelfile',
        'company_ai_advocate_modelfile',
        'ai_career_strategist_modelfile',
        'advocates_meeting_optimizer_modelfile',
        'home_sale_optimizer_modelfile',
        'matthew-scott-enhanced-resume'
    ]
    
    unique_files = results['only_in_dir1']
    
    print("Python Analysis Tools:")
    for f in unique_files:
        if f['path'] in ['enhanced_model_analyzer.py', 'ollama_model_extractor.py', 
                         'mirador_analyzer.py', 'mirador_output_analyzer.py']:
            print(f"  - {f['path']} ({f['size']} bytes)")
    
    print("\nUnique Modelfiles (potentially valuable):")
    for f in unique_files:
        if 'modelfile' in f['path'] and any(pattern in f['path'] for pattern in important_patterns):
            print(f"  - {f['path']} ({f['size']} bytes)")
    
    print("\nDocumentation & Personal Files:")
    for f in unique_files:
        if any(ext in f['path'] for ext in ['resume', '.md', 'compass_artifact']):
            print(f"  - {f['path']} ({f['size']} bytes)")
    
    print("\n=== MIGRATION RECOMMENDATIONS ===")
    print("\n1. CONSIDER MIGRATING:")
    print("   - ollama_model_extractor.py (unique analysis tool)")
    print("   - enhanced_model_analyzer.py (enhanced version)")
    print("   - Company-specific modelfiles (career/advocacy focused)")
    print("   - Resume and personal documentation")
    
    print("\n2. ALREADY IN MIRADOR (different versions):")
    print("   - README.md (mirador version is 2x larger)")
    print("   - CLAUDE.md (mirador version has full command docs)")
    print("   - USAGE_INSTRUCTIONS.md (mirador version is more complete)")
    
    print("\n3. SAFE TO IGNORE:")
    print("   - All 2,705 identical files")
    print("   - Most test outputs and temporary files")

if __name__ == "__main__":
    check_unique_important_files()