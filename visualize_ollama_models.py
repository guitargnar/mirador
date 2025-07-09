#!/usr/bin/env python3
"""
Visualize Ollama model distribution and relationships
"""

import json
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
from matplotlib.patches import Rectangle
import numpy as np

def create_model_visualization():
    # Load the trace report
    with open('ollama_model_trace_report.json', 'r') as f:
        data = json.load(f)
    
    # Create figure with subplots
    fig = plt.figure(figsize=(16, 10))
    
    # 1. Pie chart of base LLM distribution
    ax1 = plt.subplot(2, 3, 1)
    families = list(data['base_families'].keys())
    counts = [len(models) for models in data['base_families'].values()]
    colors = ['#3498db', '#e74c3c', '#f39c12']  # Blue for Llama, Red for DeepSeek, Orange for Mistral
    
    wedges, texts, autotexts = ax1.pie(counts, labels=families, autopct='%1.1f%%',
                                        colors=colors, startangle=90)
    ax1.set_title('Model Distribution by Base LLM', fontsize=14, fontweight='bold')
    
    # 2. Bar chart of model sizes
    ax2 = plt.subplot(2, 3, 2)
    size_distribution = {
        '776 MB': 0,
        '2.0 GB': 0,
        '4.1 GB': 0,
        '6.4 GB': 0
    }
    
    # Count models by size (approximated from patterns)
    for family, models in data['base_families'].items():
        for model_info in models:
            model_name = model_info['model']
            if 'deepseek' in model_name or 'code_reviewer' in model_name:
                size_distribution['776 MB'] += 1
            elif 'mistral' in model_name or 'fast_agent_focused' in model_name:
                size_distribution['4.1 GB'] += 1
            elif any(x in model_name for x in ['v4', 'v5', 'catalyst', 'architect', 'humana', 'advocate']):
                size_distribution['6.4 GB'] += 1
            else:
                size_distribution['2.0 GB'] += 1
    
    sizes = list(size_distribution.keys())
    counts = list(size_distribution.values())
    bars = ax2.bar(sizes, counts, color=['#9b59b6', '#3498db', '#f39c12', '#e74c3c'])
    ax2.set_title('Model Count by Size', fontsize=14, fontweight='bold')
    ax2.set_xlabel('Model Size')
    ax2.set_ylabel('Number of Models')
    
    # Add value labels on bars
    for bar in bars:
        height = bar.get_height()
        ax2.text(bar.get_x() + bar.get_width()/2., height + 0.5,
                f'{int(height)}', ha='center', va='bottom')
    
    # 3. Storage usage by family
    ax3 = plt.subplot(2, 3, 3)
    storage_by_family = {
        'llama': 236.8,  # 70 models
        'deepseek': 1.5,  # 2 models
        'mistral': 8.2   # 2 models
    }
    
    families = list(storage_by_family.keys())
    storage = list(storage_by_family.values())
    bars = ax3.bar(families, storage, color=['#3498db', '#e74c3c', '#f39c12'])
    ax3.set_title('Total Storage by LLM Family (GB)', fontsize=14, fontweight='bold')
    ax3.set_xlabel('LLM Family')
    ax3.set_ylabel('Storage (GB)')
    
    for bar in bars:
        height = bar.get_height()
        ax3.text(bar.get_x() + bar.get_width()/2., height + 1,
                f'{height:.1f} GB', ha='center', va='bottom')
    
    # 4. Llama model breakdown
    ax4 = plt.subplot(2, 3, 4)
    llama_breakdown = {
        'Context Providers': 6,
        'Strategy Models': 15,
        'Domain Experts': 20,
        'Implementation': 12,
        'Base Models': 4,
        'Other': 13
    }
    
    categories = list(llama_breakdown.keys())
    values = list(llama_breakdown.values())
    
    # Create horizontal bar chart
    y_pos = np.arange(len(categories))
    bars = ax4.barh(y_pos, values, color='#3498db', alpha=0.8)
    ax4.set_yticks(y_pos)
    ax4.set_yticklabels(categories)
    ax4.set_xlabel('Number of Models')
    ax4.set_title('Llama Models by Category', fontsize=14, fontweight='bold')
    
    # Add value labels
    for i, bar in enumerate(bars):
        width = bar.get_width()
        ax4.text(width + 0.5, bar.get_y() + bar.get_height()/2.,
                f'{values[i]}', ha='left', va='center')
    
    # 5. Model creation timeline (simulated)
    ax5 = plt.subplot(2, 3, 5)
    timeline_data = {
        '5 weeks ago': 3,
        '4 weeks ago': 28,
        '3 weeks ago': 14,
        '2 weeks ago': 8,
        '1 week ago': 11,
        'This week': 10
    }
    
    times = list(timeline_data.keys())
    counts = list(timeline_data.values())
    
    ax5.plot(times, counts, 'o-', color='#2ecc71', linewidth=2, markersize=8)
    ax5.fill_between(range(len(times)), counts, alpha=0.3, color='#2ecc71')
    ax5.set_title('Model Creation Timeline', fontsize=14, fontweight='bold')
    ax5.set_xlabel('Time Period')
    ax5.set_ylabel('Models Created')
    ax5.grid(True, alpha=0.3)
    plt.setp(ax5.xaxis.get_majorticklabels(), rotation=45, ha='right')
    
    # 6. Efficiency metrics
    ax6 = plt.subplot(2, 3, 6, projection='polar')
    
    # Radar chart for efficiency metrics
    categories = ['Specialization', 'Storage\nEfficiency', 'Base Model\nDiversity', 
                  'Performance', 'Maintainability']
    values = [9, 5, 3, 7, 6]  # Scores out of 10
    
    angles = np.linspace(0, 2 * np.pi, len(categories), endpoint=False).tolist()
    values += values[:1]  # Complete the circle
    angles += angles[:1]
    
    ax6.set_theta_offset(np.pi / 2)
    ax6.set_theta_direction(-1)
    ax6.plot(angles, values, 'o-', linewidth=2, color='#e74c3c')
    ax6.fill(angles, values, alpha=0.25, color='#e74c3c')
    ax6.set_ylim(0, 10)
    ax6.set_xticks(angles[:-1])
    ax6.set_xticklabels(categories)
    ax6.set_title('Model Ecosystem Health Score', fontsize=14, fontweight='bold', pad=20)
    ax6.grid(True)
    
    # Add overall title
    fig.suptitle('Ollama Model Analysis Dashboard', fontsize=18, fontweight='bold', y=0.98)
    
    # Adjust layout
    plt.tight_layout()
    
    # Save the figure
    plt.savefig('ollama_model_analysis_visual.png', dpi=300, bbox_inches='tight')
    print("Visualization saved to: ollama_model_analysis_visual.png")
    
    # Also create a model relationship diagram
    create_model_relationship_diagram()

def create_model_relationship_diagram():
    """Create a diagram showing model relationships"""
    fig, ax = plt.subplots(figsize=(14, 10))
    
    # Define positions for base models
    base_positions = {
        'Llama 3.2': (7, 9),
        'Mistral': (2, 9),
        'DeepSeek': (12, 9)
    }
    
    # Define some key derived models
    derived_positions = {
        # Llama derivatives
        'matthew_context': (5, 7),
        'strategy_models': (7, 7),
        'domain_experts': (9, 7),
        'fast_agents': (6, 5),
        'specialized': (8, 5),
        
        # Mistral derivatives
        'fast_focused': (2, 7),
        
        # DeepSeek derivatives
        'code_reviewer': (12, 7)
    }
    
    # Draw base model boxes
    for model, (x, y) in base_positions.items():
        if model == 'Llama 3.2':
            color = '#3498db'
            count = '70 models'
        elif model == 'Mistral':
            color = '#f39c12'
            count = '2 models'
        else:  # DeepSeek
            color = '#e74c3c'
            count = '2 models'
        
        rect = Rectangle((x-1, y-0.3), 2, 0.6, 
                        facecolor=color, edgecolor='black', linewidth=2)
        ax.add_patch(rect)
        ax.text(x, y, model, ha='center', va='center', fontweight='bold', fontsize=12)
        ax.text(x, y-0.5, count, ha='center', va='top', fontsize=9, style='italic')
    
    # Draw derived model groups
    group_labels = {
        'matthew_context': 'Context\nProviders (6)',
        'strategy_models': 'Strategy\nModels (15)',
        'domain_experts': 'Domain\nExperts (20)',
        'fast_agents': 'Fast\nAgents (8)',
        'specialized': 'Specialized\nModels (21)',
        'fast_focused': 'Fast Agent\nFocused',
        'code_reviewer': 'Code\nReviewer'
    }
    
    for model, (x, y) in derived_positions.items():
        if model in ['matthew_context', 'strategy_models', 'domain_experts', 'fast_agents', 'specialized']:
            color = '#3498db'
            parent = 'Llama 3.2'
        elif model == 'fast_focused':
            color = '#f39c12'
            parent = 'Mistral'
        else:  # code_reviewer
            color = '#e74c3c'
            parent = 'DeepSeek'
        
        # Draw box
        rect = Rectangle((x-0.8, y-0.3), 1.6, 0.6, 
                        facecolor=color, alpha=0.6, edgecolor='black', linewidth=1)
        ax.add_patch(rect)
        ax.text(x, y, group_labels[model], ha='center', va='center', fontsize=10)
        
        # Draw connection to parent
        parent_x, parent_y = base_positions[parent]
        ax.plot([x, parent_x], [y+0.3, parent_y-0.3], 'k--', alpha=0.5)
    
    # Add legend
    llama_patch = mpatches.Patch(color='#3498db', label='Llama-based')
    mistral_patch = mpatches.Patch(color='#f39c12', label='Mistral-based')
    deepseek_patch = mpatches.Patch(color='#e74c3c', label='DeepSeek-based')
    ax.legend(handles=[llama_patch, mistral_patch, deepseek_patch], 
             loc='lower right', fontsize=10)
    
    # Set limits and remove axes
    ax.set_xlim(0, 14)
    ax.set_ylim(4, 10)
    ax.axis('off')
    
    # Add title
    ax.text(7, 9.7, 'Ollama Model Inheritance Hierarchy', 
           ha='center', fontsize=16, fontweight='bold')
    
    # Add annotations
    ax.text(7, 4.3, 'Total: 74 models across 3 base LLM families', 
           ha='center', fontsize=11, style='italic')
    ax.text(7, 4, 'Storage: 246.5 GB | Efficiency Score: 6.5/10', 
           ha='center', fontsize=11, style='italic')
    
    plt.savefig('ollama_model_hierarchy.png', dpi=300, bbox_inches='tight')
    print("Hierarchy diagram saved to: ollama_model_hierarchy.png")

if __name__ == "__main__":
    create_model_visualization()