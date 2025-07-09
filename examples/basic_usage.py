#!/usr/bin/env python3
"""Basic usage example for Mirador AI Framework"""

import subprocess
import json

def run_mirador_chain(chain_type, prompt):
    """Run a Mirador chain and return the result"""
    cmd = ["./mirador", chain_type, prompt]
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result.stdout

# Example: Life optimization
response = run_mirador_chain(
    "life_optimization",
    "Help me plan a productive week balancing work and personal time"
)
print(response)
