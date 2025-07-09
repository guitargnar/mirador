#!/usr/bin/env python3
"""
Deduplication Strategy for ai_framework_git and mirador directories
"""
import os
import json
import shutil
from pathlib import Path
from datetime import datetime

def create_deduplication_report():
    """Create a comprehensive deduplication strategy report."""
    
    # Load the comparison results
    with open('directory_comparison_results.json', 'r') as f:
        results = json.load(f)
    
    report = []
    report.append("# DEDUPLICATION STRATEGY REPORT")
    report.append(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
    
    report.append("## EXECUTIVE SUMMARY")
    report.append(f"- Total files in ai_framework_git: {results['summary']['total_dir1']}")
    report.append(f"- Total files in mirador: {results['summary']['total_dir2']}")
    report.append(f"- Identical files (can be safely removed): {results['summary']['identical_count']}")
    report.append(f"- Files with different versions (need review): {results['summary']['different_versions_count']}")
    report.append(f"- Unique to ai_framework_git: {results['summary']['only_in_dir1_count']}")
    report.append(f"- Unique to mirador: {results['summary']['only_in_dir2_count']}\n")
    
    # Calculate space savings
    total_duplicate_size = sum(f['size'] for f in results['identical'])
    report.append(f"**Potential space savings: {total_duplicate_size / 1024 / 1024:.2f} MB**\n")
    
    report.append("## RECOMMENDED ACTIONS\n")
    
    report.append("### 1. SAFE TO DELETE (Identical Files)")
    report.append("These files exist in both directories with identical content.")
    report.append("**Recommendation**: Keep in mirador (active project), delete from ai_framework_git\n")
    
    # Group by file type
    py_files = [f for f in results['identical'] if f['path'].endswith('.py')]
    sh_files = [f for f in results['identical'] if f['path'].endswith('.sh')]
    modelfiles = [f for f in results['identical'] if 'modelfile' in f['path']]
    md_files = [f for f in results['identical'] if f['path'].endswith('.md')]
    
    report.append(f"#### Python Scripts ({len(py_files)} files)")
    for f in sorted(py_files[:10], key=lambda x: x['path']):
        report.append(f"- {f['path']} ({f['size']} bytes)")
    if len(py_files) > 10:
        report.append(f"... and {len(py_files) - 10} more\n")
    
    report.append(f"\n#### Shell Scripts ({len(sh_files)} files)")
    for f in sorted(sh_files[:10], key=lambda x: x['path']):
        report.append(f"- {f['path']} ({f['size']} bytes)")
    if len(sh_files) > 10:
        report.append(f"... and {len(sh_files) - 10} more\n")
    
    report.append(f"\n#### Modelfiles ({len(modelfiles)} files)")
    for f in sorted(modelfiles[:10], key=lambda x: x['path']):
        report.append(f"- {f['path']} ({f['size']} bytes)")
    if len(modelfiles) > 10:
        report.append(f"... and {len(modelfiles) - 10} more\n")
    
    report.append("\n### 2. REQUIRES MANUAL REVIEW (Different Versions)")
    report.append("These files exist in both directories but have different content.")
    report.append("**Action Required**: Review each file to determine which version to keep\n")
    
    for f in results['different_versions']:
        report.append(f"#### {f['path']}")
        report.append(f"- ai_framework_git: {f['dir1_size']} bytes")
        report.append(f"- mirador: {f['dir2_size']} bytes")
        size_diff = f['dir2_size'] - f['dir1_size']
        if size_diff > 0:
            report.append(f"- mirador version is {size_diff} bytes larger\n")
        else:
            report.append(f"- ai_framework_git version is {-size_diff} bytes larger\n")
    
    report.append("\n### 3. UNIQUE TO AI_FRAMEWORK_GIT")
    report.append("Files that only exist in ai_framework_git - evaluate if needed\n")
    
    unique_ai = results['only_in_dir1']
    unique_py = [f for f in unique_ai if f['path'].endswith('.py')]
    unique_sh = [f for f in unique_ai if f['path'].endswith('.sh')]
    unique_modelfiles = [f for f in unique_ai if 'modelfile' in f['path']]
    
    if unique_py:
        report.append("#### Unique Python Scripts")
        for f in sorted(unique_py[:5], key=lambda x: x['path']):
            report.append(f"- {f['path']} ({f['size']} bytes)")
        if len(unique_py) > 5:
            report.append(f"... and {len(unique_py) - 5} more\n")
    
    if unique_sh:
        report.append("\n#### Unique Shell Scripts")
        for f in sorted(unique_sh[:5], key=lambda x: x['path']):
            report.append(f"- {f['path']} ({f['size']} bytes)")
        if len(unique_sh) > 5:
            report.append(f"... and {len(unique_sh) - 5} more\n")
    
    if unique_modelfiles:
        report.append("\n#### Unique Modelfiles")
        for f in sorted(unique_modelfiles[:5], key=lambda x: x['path']):
            report.append(f"- {f['path']} ({f['size']} bytes)")
        if len(unique_modelfiles) > 5:
            report.append(f"... and {len(unique_modelfiles) - 5} more\n")
    
    report.append("\n### 4. UNIQUE TO MIRADOR")
    report.append("Files that only exist in mirador - these are likely newer additions\n")
    
    unique_mirador = results['only_in_dir2'][:20]  # Show first 20
    for f in sorted(unique_mirador, key=lambda x: x['path']):
        if any(f['path'].endswith(ext) for ext in ['.py', '.sh', 'modelfile', '.md']):
            report.append(f"- {f['path']} ({f['size']} bytes)")
    
    report.append("\n## DEDUPLICATION SCRIPT")
    report.append("```bash")
    report.append("#!/bin/bash")
    report.append("# Run this script to remove duplicate files from ai_framework_git")
    report.append("# CAUTION: This will permanently delete files!")
    report.append("")
    report.append("echo 'This will delete duplicate files from ai_framework_git'")
    report.append("echo 'Press Ctrl+C to cancel, or Enter to continue'")
    report.append("read")
    report.append("")
    report.append("# Create backup directory")
    report.append("backup_dir='/Users/userscott/ai_framework_git_backup_$(date +%Y%m%d_%H%M%S)'")
    report.append("echo 'Creating backup at: $backup_dir'")
    report.append("cp -r /Users/userscott/ai_framework_git \"$backup_dir\"")
    report.append("")
    report.append("# Remove duplicate files")
    report.append("cd /Users/userscott/ai_framework_git")
    report.append("```\n")
    
    report.append("## NEXT STEPS")
    report.append("1. **Review Different Versions**: Manually compare the 6 files with different versions")
    report.append("2. **Backup ai_framework_git**: Create a full backup before any deletions")
    report.append("3. **Run Deduplication**: Execute the generated script to remove duplicates")
    report.append("4. **Migrate Unique Files**: Copy any needed unique files from ai_framework_git to mirador")
    report.append("5. **Archive ai_framework_git**: Once verified, archive or remove the old directory")
    
    return "\n".join(report)

def generate_deletion_script():
    """Generate a safe deletion script for duplicate files."""
    with open('directory_comparison_results.json', 'r') as f:
        results = json.load(f)
    
    script = []
    script.append("#!/bin/bash")
    script.append("# Safe deletion script for duplicate files in ai_framework_git")
    script.append("# Generated: " + datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
    script.append("")
    script.append("# Safety checks")
    script.append("if [ ! -d '/Users/userscott/ai_framework_git' ]; then")
    script.append("    echo 'Error: ai_framework_git directory not found'")
    script.append("    exit 1")
    script.append("fi")
    script.append("")
    script.append("# Create backup")
    script.append("backup_dir=\"/Users/userscott/ai_framework_git_backup_$(date +%Y%m%d_%H%M%S)\"")
    script.append("echo \"Creating backup at: $backup_dir\"")
    script.append("cp -r /Users/userscott/ai_framework_git \"$backup_dir\"")
    script.append("")
    script.append("# Delete duplicate files")
    script.append("cd /Users/userscott/ai_framework_git")
    script.append("deleted_count=0")
    script.append("")
    
    for file_info in results['identical']:
        file_path = file_info['path']
        script.append(f"if [ -f '{file_path}' ]; then")
        script.append(f"    rm '{file_path}'")
        script.append(f"    echo 'Deleted: {file_path}'")
        script.append("    ((deleted_count++))")
        script.append("fi")
    
    script.append("")
    script.append("echo \"Total files deleted: $deleted_count\"")
    script.append("echo \"Backup saved at: $backup_dir\"")
    
    return "\n".join(script)

if __name__ == "__main__":
    # Generate the deduplication report
    report = create_deduplication_report()
    
    # Save the report
    with open('DEDUPLICATION_STRATEGY.md', 'w') as f:
        f.write(report)
    
    print("Deduplication strategy report saved to: DEDUPLICATION_STRATEGY.md")
    
    # Generate the deletion script
    script = generate_deletion_script()
    with open('remove_duplicates.sh', 'w') as f:
        f.write(script)
    
    os.chmod('remove_duplicates.sh', 0o755)
    print("Deletion script saved to: remove_duplicates.sh")
    
    # Show summary of files needing manual review
    with open('directory_comparison_results.json', 'r') as f:
        results = json.load(f)
    
    print("\n=== FILES REQUIRING MANUAL REVIEW ===")
    for f in results['different_versions']:
        print(f"\n{f['path']}:")
        print(f"  - ai_framework_git: {f['dir1_size']} bytes")
        print(f"  - mirador: {f['dir2_size']} bytes")
        print(f"  - Size difference: {abs(f['dir2_size'] - f['dir1_size'])} bytes")