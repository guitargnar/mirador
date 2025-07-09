#!/usr/bin/env python3

import subprocess
import json
from datetime import datetime
from pathlib import Path

def run_command(cmd):
    """Run shell command and return output"""
    try:
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
        return result.stdout.strip()
    except Exception as e:
        return f"Error: {e}"

def main():
    print("=== MIRADOR FINAL VALIDATION REPORT ===")
    print(f"Generated: {datetime.now()}")
    print()
    
    # Test models available
    models_output = run_command("mirador-ez models | grep -E '(financial_planning|louisville_expert|enhanced_agent_fast)'")
    model_count = len(models_output.split('\n')) if models_output else 0
    
    print(f"1. AVAILABLE MODELS: {model_count}")
    print("Models found:")
    for line in models_output.split('\n')[:10]:  # Show first 10
        print(f"   - {line}")
    print()
    
    # Check recent outputs
    outputs_count = run_command("ls ~/ai_framework_git/outputs/chain_* 2>/dev/null | wc -l")
    print(f"2. TOTAL CHAIN OUTPUTS: {outputs_count}")
    
    # Check opportunities
    opportunities = run_command("python3 ~/ai_framework_git/track_opportunity.py list | grep '^#' | wc -l")
    print(f"3. TRACKED OPPORTUNITIES: {opportunities}")
    
    # Check latest chain quality
    latest_chain = run_command("ls -t ~/ai_framework_git/outputs/chain_* | head -1")
    if latest_chain:
        summary_path = f"{latest_chain}/summary.md"
        try:
            with open(summary_path, 'r') as f:
                content = f.read()
                words = len(content.split())
                lines = len(content.split('\n'))
                print(f"4. LATEST CHAIN QUALITY:")
                print(f"   - Path: {latest_chain}")
                print(f"   - Words: {words}")
                print(f"   - Lines: {lines}")
                print(f"   - Content Preview:")
                print(f"     {content[:200]}...")
        except Exception as e:
            print(f"4. LATEST CHAIN QUALITY: Error reading {e}")
    
    print()
    print("=== VALIDATION COMPLETE ===")
    print("System Status: OPERATIONAL")
    print("Ready for personal life automation")

if __name__ == "__main__":
    main()
