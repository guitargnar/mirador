#!/usr/bin/env python3
"""
Mirador Bin Directory Scanner and Analyzer
Analyzes the bin/ directory structure, identifies patterns, and maps dependencies
"""

import os
import re
import json
import subprocess
from pathlib import Path
from collections import defaultdict, Counter
from datetime import datetime
import networkx as nx
import matplotlib.pyplot as plt
from typing import Dict, List, Set, Tuple, Optional

class MiradorBinScanner:
    def __init__(self, bin_path: str = "bin"):
        self.bin_path = Path(bin_path)
        self.scripts = {}
        self.dependencies = defaultdict(set)
        self.patterns = defaultdict(list)
        self.models_used = defaultdict(set)
        self.chain_definitions = {}
        self.script_metadata = {}
        
    def scan_directory(self) -> Dict:
        """Scan the bin directory and categorize all files"""
        categories = {
            'smart_routers': [],
            'universal_runners': [],
            'specialized_chains': [],
            'utilities': [],
            'core_interfaces': [],
            'maintenance': [],
            'feedback_systems': [],
            'directories': [],
            'backups': [],
            'others': []
        }
        
        for item in self.bin_path.iterdir():
            if item.is_dir():
                categories['directories'].append(item.name)
                continue
                
            if not item.is_file():
                continue
                
            name = item.name
            
            # Categorize based on naming patterns
            if 'backup' in name or name.endswith('.backup'):
                categories['backups'].append(name)
            elif name.startswith('mirador-smart'):
                categories['smart_routers'].append(name)
            elif 'universal_runner' in name:
                categories['universal_runners'].append(name)
            elif name.startswith('mirador_') and name.endswith('.sh'):
                # Further categorize shell scripts
                if any(word in name for word in ['feedback', 'qa', 'test']):
                    categories['feedback_systems'].append(name)
                elif any(word in name for word in ['maintenance', 'cleanup']):
                    categories['maintenance'].append(name)
                else:
                    categories['specialized_chains'].append(name)
            elif name.startswith('mirador-'):
                categories['core_interfaces'].append(name)
            elif name.endswith('.sh'):
                categories['utilities'].append(name)
            else:
                categories['others'].append(name)
                
        return categories
    
    def analyze_script(self, script_path: Path) -> Dict:
        """Analyze a single script for patterns and dependencies"""
        try:
            with open(script_path, 'r') as f:
                content = f.read()
        except Exception as e:
            return {'error': str(e)}
            
        analysis = {
            'name': script_path.name,
            'size': script_path.stat().st_size,
            'lines': len(content.splitlines()),
            'models': set(),
            'scripts_referenced': set(),
            'chains': [],
            'functions': [],
            'external_commands': set(),
            'patterns': [],
            'description': '',
            'version': None
        }
        
        # Extract description from comments
        desc_match = re.search(r'^#\s*(.+?)(?:\n|$)', content, re.MULTILINE)
        if desc_match:
            analysis['description'] = desc_match.group(1).strip()
            
        # Extract version
        version_match = re.search(r'[Vv]ersion:?\s*([\d.]+)', content)
        if version_match:
            analysis['version'] = version_match.group(1)
            
        # Find models used (ollama run patterns)
        model_patterns = [
            r'ollama run\s+"?([a-zA-Z0-9_\-:]+)"?',
            r'MODEL=["\'"]([a-zA-Z0-9_\-:]+)["\']',
            r'MODELS=\(([^)]+)\)',
        ]
        
        for pattern in model_patterns:
            matches = re.findall(pattern, content)
            for match in matches:
                if isinstance(match, str):
                    # Handle both single models and model lists
                    models = re.findall(r'["\'"]?([a-zA-Z0-9_\-:]+)["\'"]?', match)
                    analysis['models'].update(models)
                    
        # Find references to other scripts
        script_refs = re.findall(r'(?:\.\/|bash\s+)?(\$?(?:MIRADOR_HOME|HOME)?[/\w]*\/?)?(mirador[a-zA-Z0-9_\-]*\.sh|mirador-[a-zA-Z0-9\-]+)', content)
        for ref in script_refs:
            if ref[1] and ref[1] != script_path.name:
                analysis['scripts_referenced'].add(ref[1])
                
        # Find chain definitions
        chain_matches = re.findall(r'["\'"](\w+_\w+)["\'"].*?\)', content, re.DOTALL)
        analysis['chains'] = list(set(chain_matches))
        
        # Find function definitions
        func_matches = re.findall(r'^(\w+)\s*\(\)\s*\{', content, re.MULTILINE)
        analysis['functions'] = func_matches
        
        # Find external commands
        commands = ['python3?', 'npm', 'git', 'curl', 'wget', 'jq', 'grep', 'sed', 'awk']
        for cmd in commands:
            if re.search(rf'\b{cmd}\b', content):
                analysis['external_commands'].add(cmd)
                
        # Identify common patterns
        patterns = {
            'uses_colors': bool(re.search(r'\\033\[', content)),
            'has_usage': bool(re.search(r'[Uu]sage:', content)),
            'has_error_handling': bool(re.search(r'set -e|trap|error\(\)', content)),
            'uses_timeout': bool(re.search(r'timeout\s+\d+', content)),
            'creates_output_dir': bool(re.search(r'mkdir.*outputs?', content)),
            'has_logging': bool(re.search(r'log_|echo.*\[.*\]', content)),
            'interactive': bool(re.search(r'read\s+-p', content)),
            'uses_context_accumulation': bool(re.search(r'CONTEXT.*=.*CONTEXT', content)),
            'has_feedback_integration': bool(re.search(r'feedback', content, re.IGNORECASE)),
            'uses_python': bool(re.search(r'python3?\s+<<', content)),
        }
        
        analysis['patterns'] = [k for k, v in patterns.items() if v]
        
        return analysis
    
    def build_dependency_graph(self) -> nx.DiGraph:
        """Build a directed graph of script dependencies"""
        G = nx.DiGraph()
        
        for script, data in self.scripts.items():
            G.add_node(script, **data)
            
            for ref in data.get('scripts_referenced', []):
                if ref in self.scripts:
                    G.add_edge(script, ref)
                    
        return G
    
    def find_model_usage_patterns(self) -> Dict:
        """Analyze model usage patterns across scripts"""
        model_stats = Counter()
        model_combinations = defaultdict(list)
        
        for script, data in self.scripts.items():
            models = data.get('models', set())
            for model in models:
                model_stats[model] += 1
                
            if len(models) > 1:
                model_combinations[frozenset(models)].append(script)
                
        return {
            'most_used_models': model_stats.most_common(10),
            'model_combinations': {
                str(sorted(list(k))): v 
                for k, v in model_combinations.items()
            },
            'total_unique_models': len(model_stats),
            'scripts_using_models': sum(1 for s in self.scripts.values() if s.get('models'))
        }
    
    def identify_script_families(self) -> Dict:
        """Group scripts into families based on naming and functionality"""
        families = defaultdict(list)
        
        # Group by prefix patterns
        for script in self.scripts:
            if script.startswith('mirador-smart'):
                families['smart_routing'].append(script)
            elif script.startswith('mirador-') and not '_' in script[8:]:
                families['core_interfaces'].append(script)
            elif 'universal_runner' in script:
                families['universal_runners'].append(script)
            elif '_' in script:
                # Extract the domain from mirador_domain_*.sh pattern
                parts = script.split('_')
                if len(parts) > 1:
                    domain = parts[1]
                    families[f'domain_{domain}'].append(script)
                    
        return dict(families)
    
    def find_hidden_features(self) -> List[Dict]:
        """Identify less documented or hidden features"""
        hidden_features = []
        
        for script, data in self.scripts.items():
            # Scripts with no usage documentation
            if not any(p in data['patterns'] for p in ['has_usage']):
                hidden_features.append({
                    'script': script,
                    'type': 'undocumented',
                    'description': data.get('description', 'No description found')
                })
                
            # Scripts with unique patterns
            unique_patterns = set(data['patterns']) - {'uses_colors', 'has_error_handling'}
            if len(unique_patterns) > 3:
                hidden_features.append({
                    'script': script,
                    'type': 'feature_rich',
                    'patterns': list(unique_patterns)
                })
                
            # Scripts using unique models
            unique_models = data['models'] - set(m for s, d in self.scripts.items() 
                                               if s != script for m in d.get('models', []))
            if unique_models:
                hidden_features.append({
                    'script': script,
                    'type': 'unique_models',
                    'models': list(unique_models)
                })
                
        return hidden_features
    
    def generate_report(self) -> str:
        """Generate a comprehensive report of the bin directory"""
        report = []
        report.append("# Mirador Bin Directory Analysis Report")
        report.append(f"\nGenerated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        report.append("\n## Directory Overview")
        
        categories = self.scan_directory()
        
        # Analyze all scripts
        for cat_name, scripts in categories.items():
            if cat_name in ['directories', 'backups', 'others']:
                continue
            for script in scripts:
                script_path = self.bin_path / script
                if script_path.is_file() and os.access(script_path, os.X_OK):
                    self.scripts[script] = self.analyze_script(script_path)
        
        # Category summary
        report.append("\n### File Categories")
        total_files = sum(len(v) for k, v in categories.items() if k != 'directories')
        report.append(f"\nTotal files: {total_files}")
        report.append(f"Total directories: {len(categories['directories'])}")
        
        for cat, items in sorted(categories.items()):
            if items and cat != 'directories':
                report.append(f"\n**{cat.replace('_', ' ').title()}** ({len(items)} files):")
                for item in sorted(items)[:5]:  # Show first 5
                    desc = self.scripts.get(item, {}).get('description', '')
                    if desc:
                        report.append(f"  - `{item}`: {desc}")
                    else:
                        report.append(f"  - `{item}`")
                if len(items) > 5:
                    report.append(f"  - ... and {len(items) - 5} more")
        
        # Script families
        report.append("\n## Script Families")
        families = self.identify_script_families()
        for family, scripts in sorted(families.items()):
            if scripts:
                report.append(f"\n### {family.replace('_', ' ').title()}")
                report.append(f"Members: {', '.join(f'`{s}`' for s in sorted(scripts))}")
        
        # Model usage analysis
        report.append("\n## Model Usage Analysis")
        model_analysis = self.find_model_usage_patterns()
        
        report.append(f"\nTotal unique models referenced: {model_analysis['total_unique_models']}")
        report.append(f"Scripts using models: {model_analysis['scripts_using_models']}")
        
        report.append("\n### Most Used Models")
        for model, count in model_analysis['most_used_models'][:10]:
            report.append(f"  - `{model}`: used in {count} scripts")
        
        # Dependency analysis
        report.append("\n## Script Dependencies")
        G = self.build_dependency_graph()
        
        # Find scripts with most dependencies
        out_degrees = [(n, G.out_degree(n)) for n in G.nodes()]
        out_degrees.sort(key=lambda x: x[1], reverse=True)
        
        report.append("\n### Scripts with Most Dependencies")
        for script, deps in out_degrees[:5]:
            if deps > 0:
                report.append(f"  - `{script}`: references {deps} other scripts")
                dep_list = list(G.successors(script))
                report.append(f"    → {', '.join(f'`{d}`' for d in dep_list)}")
        
        # Find entry points (no incoming edges)
        entry_points = [n for n in G.nodes() if G.in_degree(n) == 0]
        report.append(f"\n### Primary Entry Points ({len(entry_points)} scripts)")
        for ep in sorted(entry_points)[:10]:
            desc = self.scripts.get(ep, {}).get('description', '')
            if desc:
                report.append(f"  - `{ep}`: {desc}")
            else:
                report.append(f"  - `{ep}`")
        
        # Pattern analysis
        report.append("\n## Common Patterns")
        pattern_counts = Counter()
        for data in self.scripts.values():
            pattern_counts.update(data.get('patterns', []))
        
        report.append("\n### Feature Adoption")
        for pattern, count in pattern_counts.most_common():
            percentage = (count / len(self.scripts)) * 100
            report.append(f"  - {pattern.replace('_', ' ').title()}: {count} scripts ({percentage:.1f}%)")
        
        # Hidden features
        report.append("\n## Hidden or Less Documented Features")
        hidden = self.find_hidden_features()
        
        for feature in hidden[:10]:
            report.append(f"\n### {feature['script']}")
            report.append(f"Type: {feature['type'].replace('_', ' ').title()}")
            if 'patterns' in feature:
                report.append(f"Unique patterns: {', '.join(feature['patterns'])}")
            if 'models' in feature:
                report.append(f"Unique models: {', '.join(f'`{m}`' for m in feature['models'])}")
        
        # Version tracking
        report.append("\n## Version Information")
        versioned = [(s, d['version']) for s, d in self.scripts.items() if d.get('version')]
        if versioned:
            report.append("\n### Scripts with Version Numbers")
            for script, version in sorted(versioned):
                report.append(f"  - `{script}`: v{version}")
        
        # External dependencies
        report.append("\n## External Command Usage")
        cmd_usage = Counter()
        for data in self.scripts.values():
            cmd_usage.update(data.get('external_commands', []))
        
        report.append("\n### Most Used External Commands")
        for cmd, count in cmd_usage.most_common():
            report.append(f"  - `{cmd}`: used in {count} scripts")
        
        # Recommendations
        report.append("\n## Recommendations")
        report.append("\n### Consolidation Opportunities")
        
        # Find duplicate functionality
        similar_scripts = defaultdict(list)
        for script, data in self.scripts.items():
            key = (frozenset(data.get('models', [])), frozenset(data.get('patterns', [])))
            if key != (frozenset(), frozenset()):
                similar_scripts[key].append(script)
        
        for scripts in similar_scripts.values():
            if len(scripts) > 1:
                report.append(f"  - Consider consolidating: {', '.join(f'`{s}`' for s in scripts)}")
        
        report.append("\n### Documentation Needs")
        undocumented = [s for s, d in self.scripts.items() 
                       if 'has_usage' not in d.get('patterns', [])]
        if undocumented:
            report.append(f"  - Add usage documentation to: {', '.join(f'`{s}`' for s in undocumented[:5])}")
            if len(undocumented) > 5:
                report.append(f"    ... and {len(undocumented) - 5} more scripts")
        
        return '\n'.join(report)
    
    def save_dependency_graph(self, filename: str = "bin_dependencies.png"):
        """Save a visualization of the dependency graph"""
        G = self.build_dependency_graph()
        
        plt.figure(figsize=(20, 15))
        
        # Create layout
        pos = nx.spring_layout(G, k=3, iterations=50)
        
        # Color nodes by category
        node_colors = []
        for node in G.nodes():
            if 'smart' in node:
                node_colors.append('lightblue')
            elif 'universal' in node:
                node_colors.append('lightgreen')
            elif node.startswith('mirador-'):
                node_colors.append('lightcoral')
            else:
                node_colors.append('lightyellow')
        
        # Draw the graph
        nx.draw(G, pos, 
                node_color=node_colors,
                node_size=3000,
                font_size=8,
                font_weight='bold',
                arrows=True,
                edge_color='gray',
                alpha=0.7,
                with_labels=True)
        
        plt.title("Mirador Bin Directory Dependency Graph", fontsize=16)
        plt.axis('off')
        plt.tight_layout()
        plt.savefig(filename, dpi=300, bbox_inches='tight')
        plt.close()
        
        print(f"Dependency graph saved to {filename}")


def main():
    scanner = MiradorBinScanner()
    
    print("Scanning Mirador bin directory...")
    report = scanner.generate_report()
    
    # Save report
    report_file = "bin_directory_analysis.md"
    with open(report_file, 'w') as f:
        f.write(report)
    print(f"\nReport saved to {report_file}")
    
    # Save dependency graph
    try:
        scanner.save_dependency_graph()
    except Exception as e:
        print(f"Could not generate dependency graph: {e}")
    
    # Save raw data as JSON
    data = {
        'scripts': scanner.scripts,
        'categories': scanner.scan_directory(),
        'families': scanner.identify_script_families(),
        'model_analysis': scanner.find_model_usage_patterns(),
        'hidden_features': scanner.find_hidden_features()
    }
    
    # Convert sets to lists for JSON serialization
    def convert_sets(obj):
        if isinstance(obj, set):
            return list(obj)
        elif isinstance(obj, dict):
            return {k: convert_sets(v) for k, v in obj.items()}
        elif isinstance(obj, list):
            return [convert_sets(i) for i in obj]
        return obj
    
    data = convert_sets(data)
    
    with open('bin_directory_data.json', 'w') as f:
        json.dump(data, f, indent=2)
    print("Raw data saved to bin_directory_data.json")
    
    # Print summary
    print("\n=== SUMMARY ===")
    print(f"Total scripts analyzed: {len(scanner.scripts)}")
    print(f"Total models referenced: {scanner.find_model_usage_patterns()['total_unique_models']}")
    print(f"Script families identified: {len(scanner.identify_script_families())}")
    print(f"Hidden features found: {len(scanner.find_hidden_features())}")


if __name__ == "__main__":
    main()