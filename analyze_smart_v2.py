#!/usr/bin/env python3
"""
Analyze Mirador Smart V2 Router
Extracts chain types, routing patterns, and creates visualizations
"""

import re
import json
import yaml
from collections import defaultdict
from typing import Dict, List, Tuple
import os

class MiradorSmartV2Analyzer:
    def __init__(self):
        self.script_path = "bin/mirador-smart-v2"
        self.config_path = "config/model_routing_v2.yaml"
        self.routing_patterns = defaultdict(list)
        self.model_chains = {}
        self.intent_descriptions = {}
        
    def parse_bash_script(self):
        """Parse the bash script to extract routing logic"""
        with open(self.script_path, 'r') as f:
            content = f.read()
        
        # Extract query patterns from analyze_query function
        pattern_blocks = re.findall(r'if \[\[ "\$query_lower" =~ \((.*?)\) \]\]; then\s*echo "(\w+)"', content, re.DOTALL)
        
        for patterns, intent in pattern_blocks:
            # Clean up patterns
            pattern_list = patterns.split('|')
            pattern_list = [p.strip() for p in pattern_list]
            self.routing_patterns[intent] = pattern_list
        
        # Extract model chains from get_model_chain function
        chain_blocks = re.findall(r'"(\w+)"\)\s*echo "(.*?)"', content)
        
        for intent, models in chain_blocks:
            model_list = models.split()
            self.model_chains[intent] = model_list
        
        # Extract intent descriptions from usage section
        desc_pattern = re.findall(r'echo "  - (\w+): (.*?)"', content)
        for intent, desc in desc_pattern:
            self.intent_descriptions[intent] = desc
    
    def parse_yaml_config(self):
        """Parse the YAML config file for additional details"""
        if os.path.exists(self.config_path):
            with open(self.config_path, 'r') as f:
                config = yaml.safe_load(f)
            return config
        return None
    
    def generate_decision_tree(self) -> str:
        """Generate a text-based decision tree visualization"""
        tree = ["Mirador Smart V2 Decision Tree", "=" * 40, ""]
        tree.append("Query Analysis Flow:")
        tree.append("├── Quick Response Check")
        tree.append("│   └── Keywords: " + ", ".join(self.routing_patterns.get('quick', [])))
        tree.append("│")
        
        intents = ['financial', 'health', 'location', 'music', 'career', 'creative', 'family', 'strategic']
        
        for i, intent in enumerate(intents):
            is_last = i == len(intents) - 1
            prefix = "└──" if is_last else "├──"
            continuation = "    " if is_last else "│   "
            
            tree.append(f"{prefix} {intent.title()} Check")
            
            # Add keywords
            keywords = self.routing_patterns.get(intent, [])
            if keywords:
                tree.append(f"{continuation}├── Keywords: {', '.join(keywords[:5])}")
                if len(keywords) > 5:
                    tree.append(f"{continuation}│   {'...' + str(len(keywords) - 5) + ' more'}")
            
            # Add models
            models = self.model_chains.get(intent, [])
            if models:
                tree.append(f"{continuation}└── Models: {' → '.join(models)}")
            
            if not is_last:
                tree.append("│")
        
        return "\n".join(tree)
    
    def generate_mapping_report(self) -> Dict:
        """Generate comprehensive mapping report"""
        report = {
            "summary": {
                "total_intents": len(self.routing_patterns),
                "total_unique_patterns": sum(len(patterns) for patterns in self.routing_patterns.values()),
                "model_usage_frequency": defaultdict(int)
            },
            "intent_details": {},
            "model_details": {},
            "routing_matrix": []
        }
        
        # Count model usage
        for models in self.model_chains.values():
            for model in models:
                report["summary"]["model_usage_frequency"][model] += 1
        
        # Intent details
        for intent in self.routing_patterns:
            report["intent_details"][intent] = {
                "description": self.intent_descriptions.get(intent, ""),
                "trigger_patterns": self.routing_patterns[intent],
                "model_chain": self.model_chains.get(intent, []),
                "chain_length": len(self.model_chains.get(intent, []))
            }
        
        # Model analysis
        all_models = set()
        for models in self.model_chains.values():
            all_models.update(models)
        
        for model in all_models:
            used_in_intents = []
            for intent, models in self.model_chains.items():
                if model in models:
                    position = models.index(model) + 1
                    used_in_intents.append({
                        "intent": intent,
                        "position": position,
                        "total_in_chain": len(models)
                    })
            
            report["model_details"][model] = {
                "usage_count": report["summary"]["model_usage_frequency"][model],
                "used_in_intents": used_in_intents,
                "typical_position": sum(u["position"] for u in used_in_intents) / len(used_in_intents) if used_in_intents else 0
            }
        
        # Routing matrix
        for intent, patterns in self.routing_patterns.items():
            for pattern in patterns:
                report["routing_matrix"].append({
                    "pattern": pattern,
                    "intent": intent,
                    "models": self.model_chains.get(intent, [])
                })
        
        return report
    
    def generate_html_visualization(self) -> str:
        """Generate an HTML visualization of the routing logic"""
        html = """
<!DOCTYPE html>
<html>
<head>
    <title>Mirador Smart V2 Routing Analysis</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; background-color: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        h1, h2 { color: #333; }
        .intent-card { border: 1px solid #ddd; padding: 15px; margin: 10px 0; border-radius: 5px; background-color: #f9f9f9; }
        .intent-header { font-weight: bold; color: #2c5aa0; font-size: 18px; margin-bottom: 10px; }
        .patterns { background-color: #e8f4f8; padding: 10px; border-radius: 3px; margin: 5px 0; }
        .pattern-tag { display: inline-block; background-color: #2c5aa0; color: white; padding: 3px 8px; margin: 2px; border-radius: 3px; font-size: 12px; }
        .model-chain { background-color: #f0f8ff; padding: 10px; border-radius: 3px; margin: 5px 0; }
        .model { display: inline-block; background-color: #4caf50; color: white; padding: 5px 10px; margin: 2px; border-radius: 3px; }
        .arrow { color: #666; margin: 0 5px; }
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin: 20px 0; }
        .stat-card { background-color: #f8f8f8; padding: 15px; border-radius: 5px; text-align: center; border: 1px solid #e0e0e0; }
        .stat-number { font-size: 28px; font-weight: bold; color: #2c5aa0; }
        .stat-label { color: #666; font-size: 14px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Mirador Smart V2 Routing Analysis</h1>
        
        <div class="stats">
            <div class="stat-card">
                <div class="stat-number">""" + str(len(self.routing_patterns)) + """</div>
                <div class="stat-label">Intent Types</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">""" + str(sum(len(p) for p in self.routing_patterns.values())) + """</div>
                <div class="stat-label">Total Patterns</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">""" + str(len(set(m for models in self.model_chains.values() for m in models))) + """</div>
                <div class="stat-label">Unique Models</div>
            </div>
        </div>
        
        <h2>Intent Routing Details</h2>
"""
        
        for intent, patterns in self.routing_patterns.items():
            models = self.model_chains.get(intent, [])
            desc = self.intent_descriptions.get(intent, "")
            
            html += f"""
        <div class="intent-card">
            <div class="intent-header">{intent.upper()}</div>
            <div style="color: #666; margin-bottom: 10px;">{desc}</div>
            
            <div class="patterns">
                <strong>Trigger Patterns:</strong><br>
                {''.join(f'<span class="pattern-tag">{p}</span>' for p in patterns)}
            </div>
            
            <div class="model-chain">
                <strong>Model Chain:</strong><br>
                {' <span class="arrow">→</span> '.join(f'<span class="model">{m}</span>' for m in models)}
            </div>
        </div>
"""
        
        html += """
    </div>
</body>
</html>
"""
        return html
    
    def save_report(self):
        """Save all analysis outputs"""
        # Parse the script
        self.parse_bash_script()
        
        # Generate outputs
        decision_tree = self.generate_decision_tree()
        mapping_report = self.generate_mapping_report()
        html_viz = self.generate_html_visualization()
        
        # Save text report
        with open('mirador_smart_v2_analysis.txt', 'w') as f:
            f.write("MIRADOR SMART V2 ROUTING ANALYSIS\n")
            f.write("=" * 50 + "\n\n")
            
            f.write("EXECUTIVE SUMMARY\n")
            f.write("-" * 20 + "\n")
            f.write(f"Total Intent Types: {mapping_report['summary']['total_intents']}\n")
            f.write(f"Total Pattern Matches: {mapping_report['summary']['total_unique_patterns']}\n")
            f.write(f"Unique Models Used: {len(mapping_report['model_details'])}\n\n")
            
            f.write("DECISION TREE\n")
            f.write("-" * 20 + "\n")
            f.write(decision_tree + "\n\n")
            
            f.write("INTENT ROUTING DETAILS\n")
            f.write("-" * 20 + "\n")
            for intent, details in mapping_report['intent_details'].items():
                f.write(f"\n{intent.upper()}:\n")
                f.write(f"  Description: {details['description']}\n")
                f.write(f"  Pattern Count: {len(details['trigger_patterns'])}\n")
                f.write(f"  Patterns: {', '.join(details['trigger_patterns'][:10])}\n")
                if len(details['trigger_patterns']) > 10:
                    f.write(f"            ... and {len(details['trigger_patterns']) - 10} more\n")
                f.write(f"  Model Chain ({details['chain_length']} models): {' → '.join(details['model_chain'])}\n")
            
            f.write("\n\nMODEL USAGE ANALYSIS\n")
            f.write("-" * 20 + "\n")
            for model, details in sorted(mapping_report['model_details'].items(), 
                                       key=lambda x: x[1]['usage_count'], reverse=True):
                f.write(f"\n{model}:\n")
                f.write(f"  Usage Count: {details['usage_count']}\n")
                f.write(f"  Average Position: {details['typical_position']:.1f}\n")
                f.write(f"  Used In: {', '.join(u['intent'] for u in details['used_in_intents'])}\n")
        
        # Save JSON report
        with open('mirador_smart_v2_analysis.json', 'w') as f:
            json.dump(mapping_report, f, indent=2)
        
        # Save HTML visualization
        with open('mirador_smart_v2_visualization.html', 'w') as f:
            f.write(html_viz)
        
        print("Analysis complete! Generated files:")
        print("  - mirador_smart_v2_analysis.txt (detailed text report)")
        print("  - mirador_smart_v2_analysis.json (structured data)")
        print("  - mirador_smart_v2_visualization.html (interactive visualization)")

def main():
    analyzer = MiradorSmartV2Analyzer()
    analyzer.save_report()

if __name__ == "__main__":
    main()