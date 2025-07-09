#!/usr/bin/env python3
import os
import hashlib
import json
from pathlib import Path

def get_file_hash(filepath):
    """Calculate MD5 hash of a file."""
    hash_md5 = hashlib.md5()
    try:
        with open(filepath, "rb") as f:
            for chunk in iter(lambda: f.read(4096), b""):
                hash_md5.update(chunk)
        return hash_md5.hexdigest()
    except:
        return None

def compare_directories(dir1, dir2):
    """Compare two directories and categorize files."""
    dir1_path = Path(dir1)
    dir2_path = Path(dir2)
    
    # Get all files in each directory (relative paths)
    dir1_files = {}
    dir2_files = {}
    
    # Scan directory 1
    for root, dirs, files in os.walk(dir1_path):
        # Skip hidden directories and common non-essential directories
        dirs[:] = [d for d in dirs if not d.startswith('.') and d not in ['__pycache__', 'node_modules', 'outputs']]
        for file in files:
            if file.startswith('.') or file.endswith('.pyc'):
                continue
            full_path = os.path.join(root, file)
            rel_path = os.path.relpath(full_path, dir1_path)
            file_hash = get_file_hash(full_path)
            if file_hash:
                dir1_files[rel_path] = {
                    'hash': file_hash,
                    'size': os.path.getsize(full_path),
                    'full_path': full_path
                }
    
    # Scan directory 2
    for root, dirs, files in os.walk(dir2_path):
        # Skip hidden directories and common non-essential directories
        dirs[:] = [d for d in dirs if not d.startswith('.') and d not in ['__pycache__', 'node_modules', 'outputs']]
        for file in files:
            if file.startswith('.') or file.endswith('.pyc'):
                continue
            full_path = os.path.join(root, file)
            rel_path = os.path.relpath(full_path, dir2_path)
            file_hash = get_file_hash(full_path)
            if file_hash:
                dir2_files[rel_path] = {
                    'hash': file_hash,
                    'size': os.path.getsize(full_path),
                    'full_path': full_path
                }
    
    # Categorize files
    identical_files = []
    different_versions = []
    only_in_dir1 = []
    only_in_dir2 = []
    
    # Check files in dir1
    for rel_path, file_info1 in dir1_files.items():
        if rel_path in dir2_files:
            file_info2 = dir2_files[rel_path]
            if file_info1['hash'] == file_info2['hash']:
                identical_files.append({
                    'path': rel_path,
                    'size': file_info1['size'],
                    'hash': file_info1['hash']
                })
            else:
                different_versions.append({
                    'path': rel_path,
                    'dir1_size': file_info1['size'],
                    'dir2_size': file_info2['size'],
                    'dir1_hash': file_info1['hash'],
                    'dir2_hash': file_info2['hash']
                })
        else:
            only_in_dir1.append({
                'path': rel_path,
                'size': file_info1['size']
            })
    
    # Check files only in dir2
    for rel_path, file_info2 in dir2_files.items():
        if rel_path not in dir1_files:
            only_in_dir2.append({
                'path': rel_path,
                'size': file_info2['size']
            })
    
    return {
        'identical': identical_files,
        'different_versions': different_versions,
        'only_in_dir1': only_in_dir1,
        'only_in_dir2': only_in_dir2,
        'summary': {
            'total_dir1': len(dir1_files),
            'total_dir2': len(dir2_files),
            'identical_count': len(identical_files),
            'different_versions_count': len(different_versions),
            'only_in_dir1_count': len(only_in_dir1),
            'only_in_dir2_count': len(only_in_dir2)
        }
    }

if __name__ == "__main__":
    dir1 = "/Users/matthewscott/ai_framework_git"
    dir2 = "/Users/matthewscott/Projects/mirador"
    
    print("Comparing directories...")
    print(f"Directory 1: {dir1}")
    print(f"Directory 2: {dir2}")
    print("\nThis may take a few minutes...")
    
    results = compare_directories(dir1, dir2)
    
    # Save full results to JSON
    with open('directory_comparison_results.json', 'w') as f:
        json.dump(results, f, indent=2)
    
    # Print summary
    print("\n=== SUMMARY ===")
    print(f"Total files in ai_framework_git: {results['summary']['total_dir1']}")
    print(f"Total files in mirador: {results['summary']['total_dir2']}")
    print(f"Identical files: {results['summary']['identical_count']}")
    print(f"Files with different versions: {results['summary']['different_versions_count']}")
    print(f"Files only in ai_framework_git: {results['summary']['only_in_dir1_count']}")
    print(f"Files only in mirador: {results['summary']['only_in_dir2_count']}")
    
    # Show some key files
    print("\n=== KEY IDENTICAL FILES (can be safely deduplicated) ===")
    for file in sorted(results['identical'][:20], key=lambda x: x['path']):
        if any(file['path'].endswith(ext) for ext in ['.py', '.sh', 'modelfile', '.md']):
            print(f"  {file['path']} (size: {file['size']} bytes)")
    
    print("\n=== KEY FILES WITH DIFFERENT VERSIONS (need review) ===")
    for file in sorted(results['different_versions'][:20], key=lambda x: x['path']):
        if any(file['path'].endswith(ext) for ext in ['.py', '.sh', 'modelfile', '.md']):
            print(f"  {file['path']} (ai_framework: {file['dir1_size']} bytes, mirador: {file['dir2_size']} bytes)")
    
    print("\n=== KEY FILES ONLY IN AI_FRAMEWORK_GIT ===")
    for file in sorted(results['only_in_dir1'][:20], key=lambda x: x['path']):
        if any(file['path'].endswith(ext) for ext in ['.py', '.sh', 'modelfile', '.md']):
            print(f"  {file['path']} (size: {file['size']} bytes)")
    
    print("\n=== KEY FILES ONLY IN MIRADOR ===")
    for file in sorted(results['only_in_dir2'][:20], key=lambda x: x['path']):
        if any(file['path'].endswith(ext) for ext in ['.py', '.sh', 'modelfile', '.md']):
            print(f"  {file['path']} (size: {file['size']} bytes)")
    
    print(f"\nFull results saved to: directory_comparison_results.json")