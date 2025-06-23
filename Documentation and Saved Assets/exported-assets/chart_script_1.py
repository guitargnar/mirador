import plotly.graph_objects as go
import pandas as pd

# Data from the user
data = [
    {"phase": "Phase 1: Foundation", "weeks": "1-4", "activities": ["AI Tool Evaluation", "Data Governance Setup", "Privacy Framework", "Staff Training Begin"], "focus": "Planning & Preparation"},
    {"phase": "Phase 2: Pilot Implementation", "weeks": "5-12", "activities": ["Content Research Automation", "Draft Generation Testing", "Quality Assurance Framework", "Prompt Engineering Development"], "focus": "Initial Testing"},
    {"phase": "Phase 3: Scaled Deployment", "weeks": "13-20", "activities": ["Multi-Platform Integration", "Workflow Optimization", "Compliance Monitoring", "Performance Metrics"], "focus": "Expansion & Optimization"},
    {"phase": "Phase 4: Advanced Applications", "weeks": "21+", "activities": ["Automated Compliance Checking", "Risk Analysis Integration", "Continuous Improvement", "Full Workflow Integration"], "focus": "Advanced Integration"}
]

# Define colors from the brand palette
colors = ['#1FB8CD', '#FFC185', '#ECEBD5', '#5D878F']

# Create figure
fig = go.Figure()

# Process timeline data and create bars
y_positions = []
start_weeks = []
durations = []
phase_names = []
hover_texts = []

for i, item in enumerate(data):
    phase_name = item['phase']
    weeks = item['weeks']
    
    # Parse week ranges
    if '-' in weeks:
        start_week, end_week = map(int, weeks.split('-'))
    else:
        start_week = int(weeks.replace('+', ''))
        end_week = start_week + 8  # Assume 8 weeks for open-ended phase
    
    duration = end_week - start_week + 1  # Add 1 to include both start and end week
    
    # Create abbreviated phase names for display
    phase_short = f"Phase {i+1}"
    
    # Create hover text with activities
    activities_short = []
    for act in item['activities']:
        if len(act) > 15:
            activities_short.append(act[:12] + '...')
        else:
            activities_short.append(act)
    
    hover_text = f"<b>{phase_name}</b><br>Weeks: {weeks}<br>Focus: {item['focus']}<br><br>Activities:<br>" + "<br>".join([f"• {act}" for act in activities_short])
    
    y_positions.append(i)
    start_weeks.append(start_week)
    durations.append(duration)
    phase_names.append(phase_short)
    hover_texts.append(hover_text)

# Create horizontal bar chart
fig.add_trace(go.Bar(
    y=y_positions,
    x=durations,
    base=start_weeks,
    orientation='h',
    marker=dict(color=colors),
    text=phase_names,
    textposition='inside',
    hovertemplate='%{hovertext}<extra></extra>',
    hovertext=hover_texts,
    cliponaxis=False
))

# Update layout
fig.update_layout(
    title='AI Implementation Timeline',
    xaxis_title='Weeks',
    yaxis_title='Phases',
    showlegend=False,
    yaxis=dict(
        tickmode='array',
        tickvals=y_positions,
        ticktext=[f"Phase {i+1}" for i in range(len(data))],
        autorange='reversed'
    ),
    xaxis=dict(
        range=[0, 32],
        dtick=4
    ),
    bargap=0.2
)

# Save the chart
fig.write_image('ai_implementation_timeline.png')