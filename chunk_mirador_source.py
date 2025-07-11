#!/usr/bin/env python3
"""
Mirador Source Code Atlas Generator
===================================

This script analyzes the entire Mirador AI Framework codebase to:
1. Create a hierarchical map of all subdirectories and their purposes
2. Calculate size metrics for each component
3. Identify the technology stack used
4. Map relationships between different parts
5. Generate visual representations and reports
"""

import os
import json
import re
from pathlib import Path
from collections import defaultdict, Counter
from datetime import datetime
import subprocess
import sys

class MiradorSourceAnalyzer:
    def __init__(self, root_path):
        self.root = Path(root_path)
        self.components = defaultdict(dict)
        self.file_types = Counter()
        self.language_stats = defaultdict(int)
        self.dependency_map = defaultdict(set)
        self.model_registry = []
        self.chain_registry = []
        self.script_registry = []
        
    def analyze(self):
        """Main analysis entry point"""
        print("🔍 Starting Mirador Source Code Analysis...")
        print(f"   Root path: {self.root}")
        print("=" * 70)
        
        # Phase 1: Directory structure analysis
        self.analyze_directory_structure()
        
        # Phase 2: Technology stack identification
        self.identify_tech_stack()
        
        # Phase 3: Component chunking
        self.chunk_components()
        
        # Phase 4: Dependency analysis
        self.analyze_dependencies()
        
        # Phase 5: Generate reports
        self.generate_reports()
        
    def analyze_directory_structure(self):
        """Analyze the directory structure and categorize components"""
        print("\n📁 Analyzing Directory Structure...")
        
        # Define component categories
        categories = {
            'core': ['src/core', 'src/misc', 'src/framework.py', 'src/conductor.py'],
            'api': ['src/api', 'api/'],
            'models': ['models/', 'src/ai_framework/models/', 'modelfiles'],
            'chains': ['chains/', 'src/chains/', 'bin/mirador_universal_runner'],
            'scripts': ['scripts/', 'bin/', '*.sh'],
            'tests': ['tests/', 'test_*.py', 'test_*.sh'],
            'docs': ['docs/', '*.md', 'README*'],
            'config': ['config/', '.env*', '*.yaml', '*.yml'],
            'outputs': ['outputs/', 'test_logs/', 'logs/'],
            'archive': ['archive/'],
            'tools': ['src/tools/', 'src/utils/'],
            'dashboard': ['src/dashboard/', 'dashboard/'],
            'memory': ['src/memory/', 'ai_memory/'],
            'streaming': ['src/streaming/'],
            'examples': ['examples/'],
            'deployment': ['docker*', 'nginx/', 'Dockerfile'],
        }
        
        for category, patterns in categories.items():
            self.components[category] = {
                'files': [],
                'size': 0,
                'count': 0,
                'purpose': self._get_category_purpose(category)
            }
        
        # Walk the directory tree
        for root, dirs, files in os.walk(self.root):
            # Skip .git and __pycache__ directories
            dirs[:] = [d for d in dirs if d not in ['.git', '__pycache__', '.pytest_cache']]
            
            rel_path = Path(root).relative_to(self.root)
            
            for file in files:
                if file.startswith('.DS_Store'):
                    continue
                    
                file_path = Path(root) / file
                rel_file_path = file_path.relative_to(self.root)
                
                # Skip if file doesn't exist (broken symlink or deleted)
                try:
                    file_size = file_path.stat().st_size
                except (FileNotFoundError, OSError):
                    continue
                
                # Track file types
                suffix = file_path.suffix.lower()
                if suffix:
                    self.file_types[suffix] += 1
                
                # Categorize file
                categorized = False
                for category, patterns in categories.items():
                    if self._matches_pattern(str(rel_file_path), patterns):
                        self.components[category]['files'].append(str(rel_file_path))
                        self.components[category]['size'] += file_size
                        self.components[category]['count'] += 1
                        categorized = True
                        break
                
                if not categorized:
                    # Put uncategorized files in 'other'
                    if 'other' not in self.components:
                        self.components['other'] = {
                            'files': [],
                            'size': 0,
                            'count': 0,
                            'purpose': 'Miscellaneous files not fitting other categories'
                        }
                    self.components['other']['files'].append(str(rel_file_path))
                    self.components['other']['size'] += file_size
                    self.components['other']['count'] += 1
    
    def _matches_pattern(self, path, patterns):
        """Check if a path matches any of the given patterns"""
        for pattern in patterns:
            if '*' in pattern:
                # Handle wildcards
                if pattern.startswith('*'):
                    if path.endswith(pattern[1:]):
                        return True
                elif pattern.endswith('*'):
                    if path.startswith(pattern[:-1]):
                        return True
                else:
                    # Handle patterns like test_*.py
                    import fnmatch
                    if fnmatch.fnmatch(os.path.basename(path), pattern):
                        return True
            else:
                # Exact match or path contains pattern
                if pattern in path:
                    return True
        return False
    
    def _get_category_purpose(self, category):
        """Get the purpose description for each category"""
        purposes = {
            'core': 'Core framework logic, conductors, and essential components',
            'api': 'REST API, GraphQL endpoints, and web service interfaces',
            'models': 'Ollama model definitions, configurations, and AI model files',
            'chains': 'Chain orchestration scripts and universal runners',
            'scripts': 'Utility scripts, installers, and automation tools',
            'tests': 'Test suites, validation scripts, and quality assurance',
            'docs': 'Documentation, guides, specifications, and README files',
            'config': 'Configuration files, environment settings, and manifests',
            'outputs': 'Generated outputs, logs, and runtime artifacts',
            'archive': 'Legacy code, backups, and historical versions',
            'tools': 'Development tools, analyzers, and utilities',
            'dashboard': 'Web dashboards, UI components, and visualizations',
            'memory': 'Memory systems, context management, and persistence',
            'streaming': 'Streaming capabilities and real-time processing',
            'examples': 'Example usage, demos, and sample implementations',
            'deployment': 'Docker configs, deployment scripts, and infrastructure',
        }
        return purposes.get(category, 'Uncategorized components')
    
    def identify_tech_stack(self):
        """Identify the technology stack used in the project"""
        print("\n🔧 Identifying Technology Stack...")
        
        tech_indicators = {
            'Python': ['.py', 'requirements.txt', 'setup.py'],
            'Shell/Bash': ['.sh', 'bin/'],
            'JavaScript': ['.js', 'package.json'],
            'TypeScript': ['.ts', '.tsx'],
            'Docker': ['Dockerfile', 'docker-compose.yml'],
            'YAML': ['.yaml', '.yml'],
            'JSON': ['.json'],
            'Markdown': ['.md'],
            'GraphQL': ['schema.graphql', 'graphql/'],
            'SQL': ['.sql', 'migrations/'],
            'Nginx': ['nginx.conf', 'nginx/'],
        }
        
        self.tech_stack = defaultdict(list)
        
        for tech, indicators in tech_indicators.items():
            for indicator in indicators:
                if indicator.startswith('.'):
                    # File extension
                    count = self.file_types.get(indicator, 0)
                    if count > 0:
                        self.tech_stack[tech].append(f"{count} files with {indicator}")
                else:
                    # Directory or specific file
                    paths = list(self.root.rglob(indicator))
                    if paths:
                        self.tech_stack[tech].append(f"Found {indicator}")
    
    def chunk_components(self):
        """Chunk the codebase into logical components"""
        print("\n🧩 Chunking Components...")
        
        # Identify special components
        self._identify_models()
        self._identify_chains()
        self._identify_scripts()
        
    def _identify_models(self):
        """Identify all Ollama models in the project"""
        model_patterns = ['*.modelfile', '*matthew*', '*universal*', '*expert*']
        
        for pattern in model_patterns:
            for path in self.root.rglob(pattern):
                if path.is_file() and 'archive' not in str(path):
                    self.model_registry.append({
                        'name': path.stem,
                        'path': str(path.relative_to(self.root)),
                        'size': path.stat().st_size
                    })
    
    def _identify_chains(self):
        """Identify all chain runner scripts"""
        chain_patterns = ['*runner*.sh', '*chain*.sh', 'mirador-*']
        
        for pattern in chain_patterns:
            for path in self.root.rglob(pattern):
                if path.is_file() and path.stat().st_mode & 0o111:  # Executable
                    self.chain_registry.append({
                        'name': path.name,
                        'path': str(path.relative_to(self.root)),
                        'type': self._get_chain_type(path)
                    })
    
    def _identify_scripts(self):
        """Identify all utility scripts"""
        script_patterns = ['test_*.sh', 'setup*.sh', 'install*.sh', 'create*.sh']
        
        for pattern in script_patterns:
            for path in self.root.rglob(pattern):
                if path.is_file() and 'archive' not in str(path):
                    self.script_registry.append({
                        'name': path.name,
                        'path': str(path.relative_to(self.root)),
                        'purpose': self._infer_script_purpose(path.name)
                    })
    
    def _get_chain_type(self, path):
        """Determine the type of chain based on filename"""
        name = path.name.lower()
        if 'universal' in name:
            return 'universal'
        elif 'smart' in name:
            return 'smart-routing'
        elif 'stream' in name:
            return 'streaming'
        elif 'ez' in name or 'simple' in name:
            return 'simplified'
        else:
            return 'standard'
    
    def _infer_script_purpose(self, name):
        """Infer the purpose of a script from its name"""
        name_lower = name.lower()
        if 'test' in name_lower:
            return 'Testing and validation'
        elif 'setup' in name_lower or 'install' in name_lower:
            return 'Installation and setup'
        elif 'create' in name_lower:
            return 'Resource creation'
        elif 'clean' in name_lower:
            return 'Cleanup and maintenance'
        elif 'analyze' in name_lower:
            return 'Analysis and reporting'
        else:
            return 'Utility script'
    
    def analyze_dependencies(self):
        """Analyze dependencies between components"""
        print("\n🔗 Analyzing Dependencies...")
        
        # Python dependencies from requirements.txt files
        for req_file in self.root.rglob('requirements*.txt'):
            if 'archive' not in str(req_file):
                try:
                    with open(req_file, 'r') as f:
                        deps = [line.strip() for line in f if line.strip() and not line.startswith('#')]
                        self.dependency_map['python'].update(deps)
                except:
                    pass
        
        # Shell script dependencies (look for ollama commands)
        for sh_file in self.root.rglob('*.sh'):
            if 'archive' not in str(sh_file):
                try:
                    with open(sh_file, 'r') as f:
                        content = f.read()
                        if 'ollama' in content:
                            self.dependency_map['ollama'].add(sh_file.name)
                        if 'docker' in content:
                            self.dependency_map['docker'].add(sh_file.name)
                        if 'python' in content or 'pip' in content:
                            self.dependency_map['python-scripts'].add(sh_file.name)
                except:
                    pass
    
    def generate_reports(self):
        """Generate comprehensive reports"""
        print("\n📊 Generating Reports...")
        
        # 1. Component Summary Report
        self._generate_component_summary()
        
        # 2. Visual Tree Structure
        self._generate_tree_structure()
        
        # 3. Technology Stack Report
        self._generate_tech_report()
        
        # 4. Model and Chain Registry
        self._generate_registry_report()
        
        # 5. Size Metrics Report
        self._generate_metrics_report()
        
        # 6. Save JSON data
        self._save_json_data()
        
    def _generate_component_summary(self):
        """Generate component summary report"""
        report_path = self.root / 'mirador_source_atlas_report.txt'
        
        with open(report_path, 'w') as f:
            f.write("=" * 80 + "\n")
            f.write("MIRADOR AI FRAMEWORK - SOURCE CODE ATLAS\n")
            f.write("=" * 80 + "\n")
            f.write(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"Root Path: {self.root}\n")
            f.write("\n")
            
            # Component Overview
            f.write("COMPONENT OVERVIEW\n")
            f.write("-" * 40 + "\n")
            
            total_size = 0
            total_files = 0
            
            for category in sorted(self.components.keys()):
                comp = self.components[category]
                size_mb = comp['size'] / 1024 / 1024
                total_size += comp['size']
                total_files += comp['count']
                
                f.write(f"\n📁 {category.upper()}\n")
                f.write(f"   Purpose: {comp['purpose']}\n")
                f.write(f"   Files: {comp['count']:,}\n")
                f.write(f"   Size: {size_mb:.2f} MB\n")
                
                # Show top files for this category
                if comp['files']:
                    f.write("   Key files:\n")
                    for file in sorted(comp['files'])[:5]:
                        f.write(f"     - {file}\n")
                    if len(comp['files']) > 5:
                        f.write(f"     ... and {len(comp['files']) - 5} more\n")
            
            f.write(f"\nTOTAL: {total_files:,} files, {total_size / 1024 / 1024:.2f} MB\n")
            
        print(f"✅ Component summary saved to: {report_path}")
    
    def _generate_tree_structure(self):
        """Generate visual tree structure"""
        tree_path = self.root / 'mirador_source_tree.txt'
        
        # Use tree command if available, otherwise custom implementation
        try:
            cmd = f"tree -d -L 3 --charset=utf-8 -I '__pycache__|.git|.pytest_cache' {self.root}"
            result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
            tree_output = result.stdout
        except:
            # Fallback to custom tree generation
            tree_output = self._custom_tree(self.root, max_depth=3)
        
        with open(tree_path, 'w', encoding='utf-8') as f:
            f.write("MIRADOR DIRECTORY STRUCTURE\n")
            f.write("=" * 50 + "\n\n")
            f.write(tree_output)
        
        print(f"✅ Tree structure saved to: {tree_path}")
    
    def _custom_tree(self, path, prefix="", max_depth=3, current_depth=0):
        """Generate custom tree structure if tree command not available"""
        if current_depth >= max_depth:
            return ""
        
        output = []
        path = Path(path)
        
        dirs = sorted([d for d in path.iterdir() if d.is_dir() 
                      and d.name not in ['.git', '__pycache__', '.pytest_cache']])
        
        for i, dir_path in enumerate(dirs):
            is_last = i == len(dirs) - 1
            current_prefix = "└── " if is_last else "├── "
            next_prefix = "    " if is_last else "│   "
            
            output.append(f"{prefix}{current_prefix}{dir_path.name}/")
            
            sub_tree = self._custom_tree(
                dir_path, 
                prefix + next_prefix, 
                max_depth, 
                current_depth + 1
            )
            if sub_tree:
                output.append(sub_tree)
        
        return "\n".join(output)
    
    def _generate_tech_report(self):
        """Generate technology stack report"""
        tech_path = self.root / 'mirador_tech_stack.txt'
        
        with open(tech_path, 'w') as f:
            f.write("MIRADOR TECHNOLOGY STACK\n")
            f.write("=" * 50 + "\n\n")
            
            # File type distribution
            f.write("FILE TYPE DISTRIBUTION:\n")
            f.write("-" * 30 + "\n")
            for ext, count in self.file_types.most_common(15):
                f.write(f"  {ext:15} {count:5} files\n")
            
            f.write("\n\nDETECTED TECHNOLOGIES:\n")
            f.write("-" * 30 + "\n")
            for tech, indicators in sorted(self.tech_stack.items()):
                f.write(f"\n{tech}:\n")
                for indicator in indicators:
                    f.write(f"  ✓ {indicator}\n")
            
            # Python package analysis
            if self.dependency_map.get('python'):
                f.write("\n\nPYTHON DEPENDENCIES:\n")
                f.write("-" * 30 + "\n")
                for dep in sorted(self.dependency_map['python']):
                    f.write(f"  - {dep}\n")
        
        print(f"✅ Technology stack report saved to: {tech_path}")
    
    def _generate_registry_report(self):
        """Generate model and chain registry report"""
        registry_path = self.root / 'mirador_registry.txt'
        
        with open(registry_path, 'w') as f:
            f.write("MIRADOR MODEL & CHAIN REGISTRY\n")
            f.write("=" * 50 + "\n\n")
            
            # Models
            f.write(f"OLLAMA MODELS ({len(self.model_registry)} found):\n")
            f.write("-" * 40 + "\n")
            for model in sorted(self.model_registry, key=lambda x: x['name']):
                f.write(f"  📦 {model['name']}\n")
                f.write(f"     Path: {model['path']}\n")
                f.write(f"     Size: {model['size']} bytes\n\n")
            
            # Chains
            f.write(f"\nCHAIN RUNNERS ({len(self.chain_registry)} found):\n")
            f.write("-" * 40 + "\n")
            chain_types = defaultdict(list)
            for chain in self.chain_registry:
                chain_types[chain['type']].append(chain)
            
            for chain_type, chains in sorted(chain_types.items()):
                f.write(f"\n{chain_type.upper()} chains:\n")
                for chain in sorted(chains, key=lambda x: x['name']):
                    f.write(f"  ⚡ {chain['name']}\n")
                    f.write(f"     Path: {chain['path']}\n")
            
            # Scripts
            f.write(f"\n\nUTILITY SCRIPTS ({len(self.script_registry)} found):\n")
            f.write("-" * 40 + "\n")
            script_purposes = defaultdict(list)
            for script in self.script_registry:
                script_purposes[script['purpose']].append(script)
            
            for purpose, scripts in sorted(script_purposes.items()):
                f.write(f"\n{purpose}:\n")
                for script in sorted(scripts, key=lambda x: x['name']):
                    f.write(f"  🔧 {script['name']}\n")
        
        print(f"✅ Registry report saved to: {registry_path}")
    
    def _generate_metrics_report(self):
        """Generate detailed metrics report"""
        metrics_path = self.root / 'mirador_metrics.txt'
        
        with open(metrics_path, 'w') as f:
            f.write("MIRADOR CODEBASE METRICS\n")
            f.write("=" * 50 + "\n\n")
            
            # Calculate totals
            total_size = sum(comp['size'] for comp in self.components.values())
            total_files = sum(comp['count'] for comp in self.components.values())
            
            f.write("OVERALL METRICS:\n")
            f.write("-" * 30 + "\n")
            f.write(f"Total Files: {total_files:,}\n")
            f.write(f"Total Size: {total_size / 1024 / 1024:.2f} MB\n")
            f.write(f"Components: {len(self.components)}\n")
            f.write(f"File Types: {len(self.file_types)}\n")
            
            # Component size distribution
            f.write("\n\nCOMPONENT SIZE DISTRIBUTION:\n")
            f.write("-" * 30 + "\n")
            sorted_components = sorted(
                self.components.items(), 
                key=lambda x: x[1]['size'], 
                reverse=True
            )
            
            for category, comp in sorted_components:
                percentage = (comp['size'] / total_size * 100) if total_size > 0 else 0
                bar_length = int(percentage / 2)
                bar = "█" * bar_length
                f.write(f"{category:15} {percentage:5.1f}% {bar}\n")
            
            # Language distribution (approximate based on file extensions)
            f.write("\n\nLANGUAGE DISTRIBUTION:\n")
            f.write("-" * 30 + "\n")
            
            language_map = {
                '.py': 'Python',
                '.sh': 'Shell',
                '.js': 'JavaScript',
                '.ts': 'TypeScript',
                '.md': 'Markdown',
                '.json': 'JSON',
                '.yaml': 'YAML',
                '.yml': 'YAML',
            }
            
            language_counts = defaultdict(int)
            for ext, count in self.file_types.items():
                lang = language_map.get(ext, 'Other')
                language_counts[lang] += count
            
            for lang, count in sorted(language_counts.items(), key=lambda x: x[1], reverse=True):
                f.write(f"{lang:15} {count:5} files\n")
        
        print(f"✅ Metrics report saved to: {metrics_path}")
    
    def _save_json_data(self):
        """Save all analysis data as JSON for further processing"""
        json_path = self.root / 'mirador_analysis_data.json'
        
        data = {
            'timestamp': datetime.now().isoformat(),
            'root_path': str(self.root),
            'components': dict(self.components),
            'file_types': dict(self.file_types),
            'tech_stack': dict(self.tech_stack),
            'dependencies': {k: list(v) for k, v in self.dependency_map.items()},
            'models': self.model_registry,
            'chains': self.chain_registry,
            'scripts': self.script_registry,
            'summary': {
                'total_files': sum(comp['count'] for comp in self.components.values()),
                'total_size_mb': sum(comp['size'] for comp in self.components.values()) / 1024 / 1024,
                'total_components': len(self.components),
                'total_models': len(self.model_registry),
                'total_chains': len(self.chain_registry),
                'total_scripts': len(self.script_registry),
            }
        }
        
        with open(json_path, 'w') as f:
            json.dump(data, f, indent=2)
        
        print(f"✅ Analysis data saved to: {json_path}")
        
        # Also create a visualization HTML
        self._create_visualization_html(data)
    
    def _create_visualization_html(self, data):
        """Create an HTML visualization of the analysis"""
        html_path = self.root / 'mirador_source_atlas.html'
        
        html_content = """
<!DOCTYPE html>
<html>
<head>
    <title>Mirador Source Code Atlas</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            margin: 0;
            padding: 20px;
            background: #f5f5f5;
            color: #333;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            border-bottom: 3px solid #3498db;
            padding-bottom: 10px;
        }
        h2 {
            color: #34495e;
            margin-top: 30px;
        }
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        .stat-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            border: 1px solid #e9ecef;
        }
        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #3498db;
        }
        .stat-label {
            color: #7f8c8d;
            margin-top: 5px;
        }
        .component-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        .component-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #3498db;
        }
        .component-title {
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        .tech-badge {
            display: inline-block;
            background: #3498db;
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            margin: 5px;
            font-size: 0.9em;
        }
        .tree-view {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            font-family: monospace;
            overflow-x: auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔍 Mirador Source Code Atlas</h1>
        <p>Generated: """ + datetime.now().strftime('%Y-%m-%d %H:%M:%S') + """</p>
        
        <h2>📊 Overview Statistics</h2>
        <div class="stats">
            <div class="stat-card">
                <div class="stat-number">""" + f"{data['summary']['total_files']:,}" + """</div>
                <div class="stat-label">Total Files</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">""" + f"{data['summary']['total_size_mb']:.1f}" + """ MB</div>
                <div class="stat-label">Total Size</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">""" + str(data['summary']['total_components']) + """</div>
                <div class="stat-label">Components</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">""" + str(data['summary']['total_models']) + """</div>
                <div class="stat-label">AI Models</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">""" + str(data['summary']['total_chains']) + """</div>
                <div class="stat-label">Chain Runners</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">""" + str(data['summary']['total_scripts']) + """</div>
                <div class="stat-label">Utility Scripts</div>
            </div>
        </div>
        
        <h2>🧩 Component Breakdown</h2>
        <div class="component-grid">
"""
        
        # Add component cards
        for category, comp in sorted(data['components'].items(), 
                                   key=lambda x: x[1]['size'], reverse=True):
            size_mb = comp['size'] / 1024 / 1024
            html_content += f"""
            <div class="component-card">
                <div class="component-title">{category.upper()}</div>
                <p>{comp['purpose']}</p>
                <p><strong>Files:</strong> {comp['count']:,}</p>
                <p><strong>Size:</strong> {size_mb:.2f} MB</p>
            </div>
"""
        
        html_content += """
        </div>
        
        <h2>🔧 Technology Stack</h2>
        <div>
"""
        
        # Add tech badges
        for tech in sorted(data['tech_stack'].keys()):
            html_content += f'<span class="tech-badge">{tech}</span>'
        
        html_content += """
        </div>
        
        <h2>📁 Key Directories</h2>
        <div class="tree-view">
            <pre>
mirador/
├── src/              # Core source code
│   ├── api/          # REST API and GraphQL
│   ├── core/         # Core framework components
│   ├── dashboard/    # Web dashboards
│   ├── memory/       # Memory and context systems
│   ├── streaming/    # Streaming capabilities
│   └── tools/        # Development tools
├── bin/              # Executable scripts and runners
├── models/           # Ollama model definitions
├── tests/            # Test suites
├── docs/             # Documentation
├── examples/         # Usage examples
└── outputs/          # Generated outputs
            </pre>
        </div>
    </div>
</body>
</html>
"""
        
        with open(html_path, 'w') as f:
            f.write(html_content)
        
        print(f"✅ Visualization saved to: {html_path}")


def main():
    """Main entry point"""
    if len(sys.argv) > 1:
        root_path = sys.argv[1]
    else:
        root_path = "/Users/matthewscott/Projects/mirador"
    
    analyzer = MiradorSourceAnalyzer(root_path)
    analyzer.analyze()
    
    print("\n✨ Analysis complete! Generated files:")
    print("   - mirador_source_atlas_report.txt")
    print("   - mirador_source_tree.txt")
    print("   - mirador_tech_stack.txt")
    print("   - mirador_registry.txt")
    print("   - mirador_metrics.txt")
    print("   - mirador_analysis_data.json")
    print("   - mirador_source_atlas.html")
    print("\n📖 Open mirador_source_atlas.html in a browser for interactive visualization!")


if __name__ == "__main__":
    main()