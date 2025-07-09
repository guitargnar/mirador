#!/usr/bin/env python3
"""
Automated refactoring tool to add consistent error handling across Mirador codebase.
Demonstrates Claude Code's multi-file refactoring capabilities.
"""

import os
import re
import ast
from typing import List, Tuple, Dict

class ErrorHandlingRefactorer:
    """Refactor Python files to use centralized error handling."""
    
    def __init__(self):
        self.files_to_refactor = []
        self.refactoring_report = []
    
    def find_python_files(self, directory: str, exclude_dirs: List[str] = None) -> List[str]:
        """Find all Python files in directory."""
        exclude_dirs = exclude_dirs or ['.git', '__pycache__', 'venv', '.env']
        python_files = []
        
        for root, dirs, files in os.walk(directory):
            # Remove excluded directories
            dirs[:] = [d for d in dirs if d not in exclude_dirs]
            
            for file in files:
                if file.endswith('.py'):
                    python_files.append(os.path.join(root, file))
        
        return python_files
    
    def analyze_file(self, filepath: str) -> Dict[str, any]:
        """Analyze a Python file for error handling patterns."""
        with open(filepath, 'r') as f:
            content = f.read()
        
        analysis = {
            'filepath': filepath,
            'has_try_except': 'try:' in content,
            'has_logging': 'import logging' in content or 'from logging' in content,
            'bare_excepts': len(re.findall(r'except\s*:', content)),
            'generic_excepts': len(re.findall(r'except\s+Exception\s*:', content)),
            'custom_errors': len(re.findall(r'class\s+\w*Error\s*\(', content)),
            'needs_refactoring': False
        }
        
        # Determine if file needs refactoring
        if analysis['bare_excepts'] > 0 or not analysis['has_logging']:
            analysis['needs_refactoring'] = True
        
        return analysis
    
    def generate_refactoring_suggestions(self, analysis: Dict) -> List[str]:
        """Generate refactoring suggestions for a file."""
        suggestions = []
        
        if analysis['bare_excepts'] > 0:
            suggestions.append(f"Replace {analysis['bare_excepts']} bare except clauses with specific exceptions")
        
        if not analysis['has_logging']:
            suggestions.append("Add logging import and configuration")
        
        if analysis['generic_excepts'] > 0:
            suggestions.append(f"Consider making {analysis['generic_excepts']} generic exceptions more specific")
        
        if analysis['has_try_except'] and not analysis['custom_errors']:
            suggestions.append("Consider using custom MiradorError exceptions")
        
        return suggestions
    
    def create_refactoring_plan(self, directory: str) -> str:
        """Create a comprehensive refactoring plan."""
        python_files = self.find_python_files(directory)
        files_needing_refactoring = []
        
        report = ["# Mirador Error Handling Refactoring Plan\n"]
        report.append(f"Analyzed {len(python_files)} Python files\n")
        
        for filepath in python_files:
            if 'create_error_handler.py' in filepath or 'refactor_error_handling.py' in filepath:
                continue
                
            analysis = self.analyze_file(filepath)
            if analysis['needs_refactoring']:
                files_needing_refactoring.append(analysis)
        
        report.append(f"\n## Files Needing Refactoring: {len(files_needing_refactoring)}\n")
        
        for analysis in files_needing_refactoring:
            report.append(f"\n### {analysis['filepath']}")
            suggestions = self.generate_refactoring_suggestions(analysis)
            for suggestion in suggestions:
                report.append(f"- {suggestion}")
        
        report.append("\n## Refactoring Actions:")
        report.append("1. Add import: `from productivity_tools.create_error_handler import error_handler, with_error_handling, MiradorError`")
        report.append("2. Replace bare except clauses with specific exceptions")
        report.append("3. Add error logging to exception handlers")
        report.append("4. Use @with_error_handling decorator for high-level functions")
        report.append("5. Replace print statements in error handlers with logger calls")
        
        return '\n'.join(report)


if __name__ == "__main__":
    refactorer = ErrorHandlingRefactorer()
    
    # Analyze the Mirador codebase
    mirador_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    
    # Generate refactoring plan
    plan = refactorer.create_refactoring_plan(mirador_dir)
    
    # Save plan
    with open(os.path.join(mirador_dir, 'REFACTORING_PLAN.md'), 'w') as f:
        f.write(plan)
    
    print("Refactoring plan created: REFACTORING_PLAN.md")
    print("\nSummary:")
    print(plan.split('\n')[1])  # Show file count
    print(plan.split('\n')[3])  # Show refactoring count