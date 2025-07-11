#!/usr/bin/env python3
"""
Mirador Model Ecosystem Analyzer

This script analyzes the complete Mirador model ecosystem to understand:
- Model definitions and metadata
- Base model dependencies
- Model families and specializations
- Usage across different chains
- Complexity metrics and relationships
"""

import os
import re
import json
import glob
from pathlib import Path
from collections import defaultdict, Counter
from typing import Dict, List, Set, Tuple, Optional
import networkx as nx
import matplotlib.pyplot as plt
from datetime import datetime


class ModelEcosystemAnalyzer:
    def __init__(self, base_path: str):
        self.base_path = Path(base_path)
        self.models_dir = self.base_path / "models"
        self.models = {}
        self.model_graph = nx.DiGraph()
        self.chain_usage = defaultdict(list)
        self.base_model_stats = Counter()
        
    def parse_modelfile(self, filepath: Path) -> Dict:
        """Parse a modelfile and extract metadata."""
        model_info = {
            'name': filepath.stem,
            'path': str(filepath),
            'category': self._get_category(filepath),
            'base_model': None,
            'parameters': {},
            'system_prompt': None,
            'template': None,
            'size': os.path.getsize(filepath),
            'imports': [],
            'specialization': None
        }
        
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
                
            # Extract FROM directive (base model)
            from_match = re.search(r'^FROM\s+(.+)$', content, re.MULTILINE)
            if from_match:
                model_info['base_model'] = from_match.group(1).strip()
                
            # Extract PARAMETER directives
            param_matches = re.findall(r'^PARAMETER\s+(\w+)\s+(.+)$', content, re.MULTILINE)
            for param, value in param_matches:
                model_info['parameters'][param] = value.strip()
                
            # Extract SYSTEM prompt
            system_match = re.search(r'^SYSTEM\s+"""(.+?)"""', content, re.MULTILINE | re.DOTALL)
            if not system_match:
                system_match = re.search(r'^SYSTEM\s+"(.+?)"', content, re.MULTILINE | re.DOTALL)
            if system_match:
                model_info['system_prompt'] = system_match.group(1).strip()
                
            # Extract TEMPLATE
            template_match = re.search(r'^TEMPLATE\s+"""(.+?)"""', content, re.MULTILINE | re.DOTALL)
            if template_match:
                model_info['template'] = template_match.group(1).strip()
                
            # Detect specialization from name or content
            model_info['specialization'] = self._detect_specialization(filepath.stem, content)
            
        except Exception as e:
            print(f"Error parsing {filepath}: {e}")
            
        return model_info
    
    def _get_category(self, filepath: Path) -> str:
        """Determine model category from file path."""
        relative_path = filepath.relative_to(self.models_dir)
        parts = relative_path.parts
        if len(parts) > 1:
            return parts[0]
        return "root"
    
    def _detect_specialization(self, name: str, content: str) -> str:
        """Detect model specialization from name and content."""
        specializations = {
            'context': ['context', 'background', 'profile'],
            'financial': ['financial', 'money', 'investment', 'budget'],
            'strategy': ['strategy', 'planning', 'architect', 'design'],
            'implementation': ['implement', 'action', 'practical', 'execute'],
            'synthesis': ['synthesis', 'combine', 'integrate', 'merge'],
            'expert': ['expert', 'specialist', 'master', 'authority'],
            'decision': ['decision', 'choice', 'select', 'evaluate'],
            'creative': ['creative', 'innovation', 'idea', 'breakthrough'],
            'analysis': ['analysis', 'analyze', 'examine', 'investigate'],
            'optimization': ['optim', 'enhance', 'improve', 'boost']
        }
        
        name_lower = name.lower()
        content_lower = content.lower()
        
        for spec, keywords in specializations.items():
            if any(kw in name_lower or kw in content_lower[:500] for kw in keywords):
                return spec
                
        return 'general'
    
    def analyze_chains(self):
        """Analyze model usage in chain scripts."""
        chain_files = []
        
        # Find chain runner scripts
        patterns = [
            'mirador_universal_runner*.sh',
            'humana_chain_runner.sh',
            'bin/mirador-smart*',
            'bin/mirador_*runner*.sh',
            'bin/mirador_*.sh',
            'chain_backups*/*runner*.sh',
            'mirador-ez',
            'mirador',
            'mirador-v3'
        ]
        
        for pattern in patterns:
            found_files = glob.glob(str(self.base_path / pattern))
            chain_files.extend(found_files)
            
        # Also check bin directory specifically
        bin_dir = self.base_path / 'bin'
        if bin_dir.exists():
            for file in bin_dir.iterdir():
                if file.is_file() and ('mirador' in file.name or 'runner' in file.name):
                    chain_files.append(str(file))
                    
        # Remove duplicates
        chain_files = list(set(chain_files))
        
        print(f"   Found {len(chain_files)} potential chain files to analyze")
            
        for chain_file in chain_files:
            if os.path.isfile(chain_file) and not chain_file.endswith('.log'):
                self._parse_chain_file(chain_file)
    
    def _parse_chain_file(self, filepath: str):
        """Parse a chain file to extract model usage."""
        try:
            with open(filepath, 'r') as f:
                content = f.read()
                
            # Extract chain type
            chain_name = Path(filepath).stem
            
            # Find model references (ollama run commands)
            model_refs = re.findall(r'ollama run\s+([^\s\'"]+)', content)
            
            # Find model arrays (various formats)
            # Format 1: MODELS=(...)
            array_matches = re.findall(r'MODELS=\((.*?)\)', content, re.DOTALL)
            for match in array_matches:
                models = re.findall(r'["\']([\w_\-:]+)["\']', match)
                model_refs.extend(models)
                
            # Format 2: declare -a MODELS=(...)
            declare_matches = re.findall(r'declare -a \w+_MODELS=\((.*?)\)', content, re.DOTALL)
            for match in declare_matches:
                models = re.findall(r'["\']([\w_\-:]+)["\']', match)
                model_refs.extend(models)
                
            # Format 3: case statements with model lists
            case_matches = re.findall(r'MODELS=\("([^"]+)"(?:\s+"([^"]+)")*\)', content)
            for match in case_matches:
                for model in match:
                    if model:
                        model_refs.append(model)
                        
            # Format 4: Direct model references in case statements
            case_model_matches = re.findall(r'["\'](matthew_[\w_]+|[\w_]+_expert[\w_]*|[\w_]+_strategist|[\w_]+_optimizer)["\']', content)
            model_refs.extend(case_model_matches)
                
            # Store unique models for this chain
            unique_models = list(set(model_refs))
            unique_models = [m for m in unique_models if m and not m.startswith('$')]  # Filter out variables
            
            if unique_models:
                self.chain_usage[chain_name] = unique_models
                
        except Exception as e:
            print(f"Error parsing chain file {filepath}: {e}")
    
    def build_model_graph(self):
        """Build a directed graph of model dependencies."""
        for name, info in self.models.items():
            self.model_graph.add_node(name, **info)
            
            # Add edge from base model if exists
            if info['base_model']:
                base = info['base_model'].split(':')[0]  # Remove version tag
                if base in self.models or base in ['llama3.2', 'gemma2', 'qwen2.5', 'phi3', 'command-r']:
                    self.model_graph.add_edge(base, name)
    
    def calculate_metrics(self) -> Dict:
        """Calculate various ecosystem metrics."""
        metrics = {
            'total_models': len(self.models),
            'categories': Counter(m['category'] for m in self.models.values()),
            'specializations': Counter(m['specialization'] for m in self.models.values()),
            'base_models': self.base_model_stats,
            'avg_model_size': sum(m['size'] for m in self.models.values()) / len(self.models) if self.models else 0,
            'parameter_usage': self._analyze_parameters(),
            'chain_coverage': len(self.chain_usage),
            'model_families': self._identify_families(),
            'complexity_scores': self._calculate_complexity()
        }
        
        return metrics
    
    def _analyze_parameters(self) -> Dict:
        """Analyze parameter usage across models."""
        param_stats = defaultdict(list)
        
        for model in self.models.values():
            for param, value in model['parameters'].items():
                param_stats[param].append(value)
                
        return {
            param: {
                'count': len(values),
                'unique_values': len(set(values)),
                'common_value': Counter(values).most_common(1)[0] if values else None
            }
            for param, values in param_stats.items()
        }
    
    def _identify_families(self) -> Dict[str, List[str]]:
        """Identify model families based on naming patterns."""
        families = defaultdict(list)
        
        # Common family patterns
        patterns = {
            'matthew_': 'matthew_family',
            'financial_': 'financial_family',
            'louisville_': 'louisville_family',
            'enhanced_agent_': 'enhanced_agent_family',
            '_expert': 'expert_family',
            '_optimizer': 'optimizer_family',
            '_strategy': 'strategy_family'
        }
        
        for name in self.models:
            for pattern, family in patterns.items():
                if pattern in name:
                    families[family].append(name)
                    break
            else:
                families['other'].append(name)
                
        return dict(families)
    
    def _calculate_complexity(self) -> Dict[str, float]:
        """Calculate complexity scores for models."""
        complexity = {}
        
        for name, info in self.models.items():
            score = 0.0
            
            # Size contribution
            score += info['size'] / 10000  # Normalize by 10KB
            
            # Parameter complexity
            score += len(info['parameters']) * 2
            
            # Prompt complexity (word count)
            if info['system_prompt']:
                score += len(info['system_prompt'].split()) / 100
                
            # Graph centrality
            if name in self.model_graph:
                score += self.model_graph.in_degree(name) * 3
                score += self.model_graph.out_degree(name) * 2
                
            complexity[name] = round(score, 2)
            
        return complexity
    
    def visualize_ecosystem(self, output_path: str = None):
        """Create visualizations of the model ecosystem."""
        if not output_path:
            output_path = self.base_path / 'model_ecosystem_visualization.png'
            
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(16, 12))
        
        # 1. Category distribution
        categories = dict(self.calculate_metrics()['categories'])
        ax1.pie(categories.values(), labels=categories.keys(), autopct='%1.1f%%')
        ax1.set_title('Model Distribution by Category')
        
        # 2. Base model usage
        base_models = dict(self.base_model_stats.most_common(10))
        ax2.bar(range(len(base_models)), list(base_models.values()))
        ax2.set_xticks(range(len(base_models)))
        ax2.set_xticklabels(list(base_models.keys()), rotation=45, ha='right')
        ax2.set_title('Top 10 Base Models')
        ax2.set_ylabel('Number of Models')
        
        # 3. Specialization distribution
        specs = dict(self.calculate_metrics()['specializations'])
        ax3.barh(list(specs.keys()), list(specs.values()))
        ax3.set_xlabel('Number of Models')
        ax3.set_title('Model Specializations')
        
        # 4. Model complexity distribution
        complexity = self.calculate_metrics()['complexity_scores']
        if complexity:
            sorted_complexity = sorted(complexity.items(), key=lambda x: x[1], reverse=True)[:20]
            names, scores = zip(*sorted_complexity)
            ax4.barh(range(len(names)), scores)
            ax4.set_yticks(range(len(names)))
            ax4.set_yticklabels(names, fontsize=8)
            ax4.set_xlabel('Complexity Score')
            ax4.set_title('Top 20 Models by Complexity')
        
        plt.tight_layout()
        plt.savefig(output_path, dpi=300, bbox_inches='tight')
        print(f"Visualization saved to {output_path}")
    
    def generate_report(self) -> str:
        """Generate a comprehensive text report of the ecosystem."""
        metrics = self.calculate_metrics()
        
        report = f"""
# Mirador Model Ecosystem Analysis Report
Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}

## Executive Summary
- Total Models: {metrics['total_models']}
- Model Categories: {len(metrics['categories'])}
- Active Chains: {metrics['chain_coverage']}
- Average Model Size: {metrics['avg_model_size']:.2f} bytes

## Model Categories
"""
        for category, count in metrics['categories'].most_common():
            report += f"- {category}: {count} models\n"
            
        report += "\n## Base Model Distribution\n"
        for base, count in self.base_model_stats.most_common():
            percentage = (count / metrics['total_models']) * 100
            report += f"- {base}: {count} models ({percentage:.1f}%)\n"
            
        report += "\n## Model Specializations\n"
        for spec, count in metrics['specializations'].most_common():
            report += f"- {spec}: {count} models\n"
            
        report += "\n## Model Families\n"
        for family, members in metrics['model_families'].items():
            if members:
                report += f"\n### {family} ({len(members)} models)\n"
                for member in sorted(members)[:5]:
                    report += f"  - {member}\n"
                if len(members) > 5:
                    report += f"  ... and {len(members) - 5} more\n"
                    
        report += "\n## Chain Usage Analysis\n"
        for chain, models in sorted(self.chain_usage.items()):
            report += f"\n### {chain}\n"
            report += f"Models used: {len(models)}\n"
            for model in models[:5]:
                report += f"  - {model}\n"
            if len(models) > 5:
                report += f"  ... and {len(models) - 5} more\n"
                
        report += "\n## Parameter Analysis\n"
        for param, stats in metrics['parameter_usage'].items():
            if stats['common_value']:
                report += f"- {param}: used in {stats['count']} models, "
                report += f"most common value: {stats['common_value'][0]} ({stats['common_value'][1]} times)\n"
                
        report += "\n## Complexity Analysis\n"
        complexity_sorted = sorted(metrics['complexity_scores'].items(), 
                                 key=lambda x: x[1], reverse=True)[:10]
        report += "Top 10 Most Complex Models:\n"
        for model, score in complexity_sorted:
            report += f"  - {model}: {score}\n"
            
        report += "\n## Model Dependency Graph Statistics\n"
        if self.model_graph.number_of_nodes() > 0:
            report += f"- Nodes: {self.model_graph.number_of_nodes()}\n"
            report += f"- Edges: {self.model_graph.number_of_edges()}\n"
            
            # Find most connected models
            in_degrees = dict(self.model_graph.in_degree())
            out_degrees = dict(self.model_graph.out_degree())
            
            if in_degrees:
                most_inherited = max(in_degrees.items(), key=lambda x: x[1])
                report += f"- Most inherited from: {most_inherited[0]} ({most_inherited[1]} dependencies)\n"
                
            if out_degrees:
                most_base = max(out_degrees.items(), key=lambda x: x[1])
                report += f"- Most used as base: {most_base[0]} ({most_base[1]} derivatives)\n"
        
        return report
    
    def run_analysis(self):
        """Run the complete ecosystem analysis."""
        print("Starting Mirador Model Ecosystem Analysis...")
        
        # Step 1: Find and parse all modelfiles
        print("\n1. Discovering modelfiles...")
        modelfiles = list(self.models_dir.rglob("*.modelfile"))
        print(f"   Found {len(modelfiles)} modelfiles")
        
        # Step 2: Parse each modelfile
        print("\n2. Parsing modelfiles...")
        for filepath in modelfiles:
            model_info = self.parse_modelfile(filepath)
            self.models[model_info['name']] = model_info
            
            # Track base models
            if model_info['base_model']:
                base = model_info['base_model'].split(':')[0]
                self.base_model_stats[base] += 1
        
        print(f"   Parsed {len(self.models)} models successfully")
        
        # Step 3: Analyze chain usage
        print("\n3. Analyzing chain usage...")
        self.analyze_chains()
        print(f"   Found {len(self.chain_usage)} chains using models")
        
        # Step 4: Build dependency graph
        print("\n4. Building model dependency graph...")
        self.build_model_graph()
        print(f"   Graph has {self.model_graph.number_of_nodes()} nodes and {self.model_graph.number_of_edges()} edges")
        
        # Step 5: Generate visualizations
        print("\n5. Creating visualizations...")
        self.visualize_ecosystem()
        
        # Step 6: Generate report
        print("\n6. Generating comprehensive report...")
        report = self.generate_report()
        
        report_path = self.base_path / 'model_ecosystem_report.txt'
        with open(report_path, 'w') as f:
            f.write(report)
        print(f"   Report saved to {report_path}")
        
        # Save raw data as JSON
        data_path = self.base_path / 'model_ecosystem_data.json'
        with open(data_path, 'w') as f:
            json.dump({
                'models': self.models,
                'chain_usage': dict(self.chain_usage),
                'metrics': self.calculate_metrics(),
                'graph_data': {
                    'nodes': list(self.model_graph.nodes()),
                    'edges': list(self.model_graph.edges())
                }
            }, f, indent=2, default=str)
        print(f"   Raw data saved to {data_path}")
        
        print("\nAnalysis complete!")
        return report


def main():
    """Main execution function."""
    base_path = "/Users/matthewscott/Projects/mirador"
    analyzer = ModelEcosystemAnalyzer(base_path)
    report = analyzer.run_analysis()
    
    # Print summary to console
    print("\n" + "="*80)
    print("ANALYSIS SUMMARY")
    print("="*80)
    
    lines = report.split('\n')
    for line in lines[:50]:  # Print first 50 lines of report
        print(line)
    
    print("\n... (see full report in model_ecosystem_report.txt)")


if __name__ == "__main__":
    main()