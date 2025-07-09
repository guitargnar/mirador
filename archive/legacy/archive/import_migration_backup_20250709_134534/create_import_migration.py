#!/usr/bin/env python3
"""
Import Migration Script - Updates all Python files to use mirador-core
"""

import os
import re
from pathlib import Path
import shutil
from datetime import datetime

class ImportMigrator:
    def __init__(self):
        self.backup_dir = f"import_migration_backup_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
        self.migrations = {
            # Map old imports to new mirador-core imports
            r'from error_handler import': 'from mirador_core.error_handler import',
            r'import error_handler': 'import mirador_core.error_handler as error_handler',
            r'from src.error_handler import': 'from mirador_core.error_handler import',
            r'from context_manager import': 'from mirador_core.context_manager import',
            r'import context_manager': 'import mirador_core.context_manager as context_manager',
            r'from constraint_validator import': 'from mirador_core.constraint_validator import',
            r'import constraint_validator': 'import mirador_core.constraint_validator as constraint_validator',
        }
        self.files_updated = 0
        self.files_skipped = 0
        
    def create_backup(self):
        """Create backup of all Python files before migration"""
        print(f"Creating backup in {self.backup_dir}/")
        os.makedirs(self.backup_dir, exist_ok=True)
        
        for root, dirs, files in os.walk('.'):
            # Skip certain directories
            if any(skip in root for skip in ['.git', '__pycache__', 'venv', 'backup', self.backup_dir]):
                continue
                
            for file in files:
                if file.endswith('.py'):
                    src = os.path.join(root, file)
                    dst_dir = os.path.join(self.backup_dir, root)
                    os.makedirs(dst_dir, exist_ok=True)
                    dst = os.path.join(dst_dir, file)
                    shutil.copy2(src, dst)
                    
    def update_imports(self, filepath):
        """Update imports in a single Python file"""
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
                
            original_content = content
            
            # Apply all import migrations
            for old_pattern, new_import in self.migrations.items():
                content = re.sub(old_pattern, new_import, content)
                
            # Only write if changes were made
            if content != original_content:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(content)
                self.files_updated += 1
                print(f"✓ Updated: {filepath}")
                return True
            else:
                self.files_skipped += 1
                return False
                
        except Exception as e:
            print(f"✗ Error updating {filepath}: {e}")
            return False
            
    def update_shell_scripts(self):
        """Update PYTHONPATH in shell scripts"""
        shell_files = [
            'mirador-smart-v2',
            'mirador_universal_runner_v2.sh',
            'company_chain_runner.sh',
            'mirador-ez'
        ]
        
        for script in shell_files:
            if os.path.exists(script):
                try:
                    with open(script, 'r') as f:
                        content = f.read()
                        
                    # Add mirador-core to PYTHONPATH if not already there
                    if 'mirador-core' not in content and 'PYTHONPATH' in content:
                        content = re.sub(
                            r'export PYTHONPATH="\$SCRIPT_DIR:\$PYTHONPATH"',
                            'export PYTHONPATH="$SCRIPT_DIR:$SCRIPT_DIR/mirador-core:$PYTHONPATH"',
                            content
                        )
                        
                        with open(script, 'w') as f:
                            f.write(content)
                        print(f"✓ Updated PYTHONPATH in: {script}")
                        
                except Exception as e:
                    print(f"✗ Error updating {script}: {e}")
                    
    def run(self):
        """Run the complete migration"""
        print("=== Import Migration Tool ===")
        print("This will update all Python imports to use mirador-core\n")
        
        # Create backup first
        self.create_backup()
        print(f"\nBackup created successfully!\n")
        
        # Update Python files
        print("Updating Python imports...")
        for root, dirs, files in os.walk('.'):
            # Skip certain directories
            if any(skip in root for skip in ['.git', '__pycache__', 'venv', 'backup', self.backup_dir, 'mirador-core']):
                continue
                
            for file in files:
                if file.endswith('.py'):
                    filepath = os.path.join(root, file)
                    self.update_imports(filepath)
                    
        # Update shell scripts
        print("\nUpdating shell script PYTHONPATH...")
        self.update_shell_scripts()
        
        # Summary
        print(f"\n=== Migration Complete ===")
        print(f"Files updated: {self.files_updated}")
        print(f"Files skipped: {self.files_skipped}")
        print(f"Backup location: {self.backup_dir}/")
        print(f"\nTo rollback: cp -r {self.backup_dir}/* .")
        
        # Create requirements update
        if os.path.exists('requirements.txt'):
            with open('requirements.txt', 'a') as f:
                if 'mirador-core' not in open('requirements.txt').read():
                    f.write('\n# Local mirador-core library\n-e ./mirador-core\n')
                    print("\nAdded mirador-core to requirements.txt")

if __name__ == '__main__':
    migrator = ImportMigrator()
    migrator.run()