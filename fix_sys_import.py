#!/usr/bin/env python3
import fileinput
import re

# Read the file and fix sys import issues
with open('mirador.py', 'r') as f:
    content = f.read()

# Remove duplicate sys imports
lines = content.split('\n')
seen_sys_import = False
fixed_lines = []

for line in lines:
    if line.strip() == 'import sys':
        if not seen_sys_import:
            fixed_lines.append(line)
            seen_sys_import = True
        # Skip duplicate imports
    else:
        fixed_lines.append(line)

# Write the fixed content
with open('mirador.py', 'w') as f:
    f.write('\n'.join(fixed_lines))

print("Fixed duplicate sys imports")
