#!/bin/bash
# Final cleanup to match professional repository standards

echo "🎯 Creating professional minimal root directory..."

# Move everything except essentials
mkdir -p .archive_temp
mv * .archive_temp/ 2>/dev/null || true

# Restore only essential files to root
mv .archive_temp/README.md . 2>/dev/null || true
mv .archive_temp/LICENSE . 2>/dev/null || true
mv .archive_temp/CHANGELOG.md . 2>/dev/null || true
mv .archive_temp/CONTRIBUTING.md . 2>/dev/null || true
mv .archive_temp/requirements.txt . 2>/dev/null || true
mv .archive_temp/setup_mirador.sh . 2>/dev/null || true
mv .archive_temp/mirador . 2>/dev/null || true  # Main executable symlink

# Restore essential directories
mv .archive_temp/src . 2>/dev/null || true
mv .archive_temp/docs . 2>/dev/null || true
mv .archive_temp/tests . 2>/dev/null || true
mv .archive_temp/scripts . 2>/dev/null || true
mv .archive_temp/models . 2>/dev/null || true
mv .archive_temp/bin . 2>/dev/null || true

# Move everything else to archive
mkdir -p archive/legacy
mv .archive_temp/* archive/legacy/ 2>/dev/null || true
rmdir .archive_temp 2>/dev/null || true

# Create examples directory with sample usage
mkdir -p examples
cat > examples/basic_usage.py << 'EOF'
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
EOF

# Create simple Makefile
cat > Makefile << 'EOF'
.PHONY: install test clean help

help:
	@echo "Mirador AI Framework"
	@echo "==================="
	@echo "make install    Install dependencies and setup"
	@echo "make test       Run test suite"
	@echo "make clean      Clean temporary files"

install:
	./setup_mirador.sh

test:
	python -m pytest tests/

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	rm -rf .pytest_cache
	rm -rf htmlcov
	rm -rf .coverage
EOF

echo "✅ Professional repository structure created!"
echo ""
echo "Root directory now contains only:"
ls -la | grep -v "^d" | grep -v "^total"