#!/usr/bin/env python3
"""
Generate an architecture diagram for the Mirador AI Framework
"""

import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.patches import FancyBboxPatch, ConnectionPatch
import numpy as np

# Create figure and axis
fig, ax = plt.subplots(1, 1, figsize=(16, 12))
ax.set_xlim(0, 10)
ax.set_ylim(0, 10)
ax.axis('off')

# Define colors
colors = {
    'core': '#3498db',
    'api': '#e74c3c',
    'models': '#2ecc71',
    'chains': '#f39c12',
    'tools': '#9b59b6',
    'data': '#1abc9c',
    'ui': '#e67e22',
    'infra': '#34495e'
}

# Title
plt.title('Mirador AI Framework Architecture', fontsize=24, fontweight='bold', pad=20)

# Layer 1: Entry Points (top)
entry_y = 8.5
entry_boxes = [
    ('CLI\n(mirador-*)', 1.5, entry_y, colors['ui']),
    ('API\n(REST/GraphQL)', 3.5, entry_y, colors['api']),
    ('Web Dashboard\n(Streamlit)', 5.5, entry_y, colors['ui']),
    ('SDK\n(Python)', 7.5, entry_y, colors['tools'])
]

for label, x, y, color in entry_boxes:
    box = FancyBboxPatch((x-0.6, y-0.3), 1.2, 0.6, boxstyle="round,pad=0.1",
                         facecolor=color, edgecolor='black', alpha=0.8)
    ax.add_patch(box)
    ax.text(x, y, label, ha='center', va='center', fontsize=10, fontweight='bold', color='white')

# Layer 2: Core Orchestration
orch_y = 6.5
orch_box = FancyBboxPatch((1, orch_y-0.4), 8, 0.8, boxstyle="round,pad=0.1",
                          facecolor=colors['core'], edgecolor='black', alpha=0.9)
ax.add_patch(orch_box)
ax.text(5, orch_y, 'Orchestration Layer', ha='center', va='center', 
        fontsize=14, fontweight='bold', color='white')

# Sub-components in orchestration
orch_components = [
    ('Smart Router', 2, orch_y-0.2),
    ('Chain Selector', 3.5, orch_y-0.2),
    ('Context Manager', 5, orch_y-0.2),
    ('Stream Handler', 6.5, orch_y-0.2),
    ('Memory System', 8, orch_y-0.2)
]

for label, x, y in orch_components:
    ax.text(x, y, label, ha='center', va='center', fontsize=9, color='white')

# Layer 3: Chain Types
chain_y = 4.5
chain_types = [
    ('Life\nOptimization', 1.5, chain_y),
    ('Business\nAcceleration', 2.8, chain_y),
    ('Creative\nBreakthrough', 4.1, chain_y),
    ('Technical\nMastery', 5.4, chain_y),
    ('Strategic\nSynthesis', 6.7, chain_y),
    ('Deep\nAnalysis', 8, chain_y)
]

for label, x, y in chain_types:
    box = FancyBboxPatch((x-0.5, y-0.3), 1, 0.6, boxstyle="round,pad=0.05",
                         facecolor=colors['chains'], edgecolor='black', alpha=0.7)
    ax.add_patch(box)
    ax.text(x, y, label, ha='center', va='center', fontsize=8, color='white')

# Layer 4: Model Pipeline
model_y = 2.5
model_box = FancyBboxPatch((0.5, model_y-0.5), 9, 1, boxstyle="round,pad=0.1",
                           facecolor=colors['models'], edgecolor='black', alpha=0.8)
ax.add_patch(model_box)
ax.text(5, model_y+0.3, 'Model Pipeline (80+ Specialized Models)', ha='center', va='center',
        fontsize=12, fontweight='bold', color='white')

# Model flow
model_flow = [
    ('Context\nProvider', 1.5, model_y-0.1),
    ('→', 2.3, model_y-0.1),
    ('Domain\nExpert', 3.1, model_y-0.1),
    ('→', 3.9, model_y-0.1),
    ('Strategy\nArchitect', 4.7, model_y-0.1),
    ('→', 5.5, model_y-0.1),
    ('Implementation\nModel', 6.3, model_y-0.1),
    ('→', 7.1, model_y-0.1),
    ('Decision\nSimplifier', 7.9, model_y-0.1)
]

for label, x, y in model_flow:
    ax.text(x, y, label, ha='center', va='center', fontsize=8, color='white')

# Layer 5: Infrastructure
infra_y = 0.8
infra_components = [
    ('Ollama\nEngine', 1.5, infra_y, colors['infra']),
    ('SQLite\nMemory', 3, infra_y, colors['data']),
    ('Redis\nCache', 4.5, infra_y, colors['data']),
    ('Docker\nContainers', 6, infra_y, colors['infra']),
    ('Monitoring\n(Prometheus)', 7.5, infra_y, colors['tools'])
]

for label, x, y, color in infra_components:
    box = FancyBboxPatch((x-0.5, y-0.3), 1, 0.6, boxstyle="round,pad=0.05",
                         facecolor=color, edgecolor='black', alpha=0.7)
    ax.add_patch(box)
    ax.text(x, y, label, ha='center', va='center', fontsize=8, color='white')

# Add arrows showing data flow
# Entry to Orchestration
for x in [1.5, 3.5, 5.5, 7.5]:
    arrow = ConnectionPatch((x, entry_y-0.3), (x, orch_y+0.4), "data", "data",
                           arrowstyle="->", shrinkA=0, shrinkB=0,
                           mutation_scale=20, fc="black", alpha=0.5)
    ax.add_artist(arrow)

# Orchestration to Chains
arrow = ConnectionPatch((5, orch_y-0.4), (5, chain_y+0.3), "data", "data",
                       arrowstyle="->", shrinkA=0, shrinkB=0,
                       mutation_scale=20, fc="black", alpha=0.5)
ax.add_artist(arrow)

# Chains to Models
arrow = ConnectionPatch((5, chain_y-0.3), (5, model_y+0.5), "data", "data",
                       arrowstyle="->", shrinkA=0, shrinkB=0,
                       mutation_scale=20, fc="black", alpha=0.5)
ax.add_artist(arrow)

# Models to Infrastructure
arrow = ConnectionPatch((5, model_y-0.5), (5, infra_y+0.3), "data", "data",
                       arrowstyle="->", shrinkA=0, shrinkB=0,
                       mutation_scale=20, fc="black", alpha=0.5)
ax.add_artist(arrow)

# Add legend
legend_elements = [
    patches.Patch(color=colors['ui'], label='User Interface'),
    patches.Patch(color=colors['api'], label='API Layer'),
    patches.Patch(color=colors['core'], label='Core Framework'),
    patches.Patch(color=colors['chains'], label='Chain Types'),
    patches.Patch(color=colors['models'], label='AI Models'),
    patches.Patch(color=colors['data'], label='Data Storage'),
    patches.Patch(color=colors['infra'], label='Infrastructure'),
    patches.Patch(color=colors['tools'], label='Tools & Monitoring')
]
ax.legend(handles=legend_elements, loc='upper left', bbox_to_anchor=(0, 1), frameon=False)

# Add annotations
ax.text(9.5, 9, 'User Layer', ha='right', va='top', fontsize=10, style='italic', color='gray')
ax.text(9.5, 7, 'Processing Layer', ha='right', va='top', fontsize=10, style='italic', color='gray')
ax.text(9.5, 3.5, 'Model Layer', ha='right', va='top', fontsize=10, style='italic', color='gray')
ax.text(9.5, 1.5, 'Infrastructure Layer', ha='right', va='top', fontsize=10, style='italic', color='gray')

# Save the diagram
plt.tight_layout()
plt.savefig('/Users/matthewscott/Projects/mirador/mirador_architecture_diagram.png', 
            dpi=300, bbox_inches='tight', facecolor='white')
plt.savefig('/Users/matthewscott/Projects/mirador/mirador_architecture_diagram.pdf', 
            bbox_inches='tight', facecolor='white')

print("Architecture diagram saved as:")
print("  - mirador_architecture_diagram.png")
print("  - mirador_architecture_diagram.pdf")