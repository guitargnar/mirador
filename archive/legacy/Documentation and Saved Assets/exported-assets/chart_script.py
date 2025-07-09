import pandas as pd
import plotly.express as px
import plotly.graph_objects as go

# Create the data
data = [
    {"category": "Benefits", "factor": "Enhanced Productivity", "impact_score": 9, "description": "5-9x faster content creation"},
    {"category": "Benefits", "factor": "Quality & Consistency", "impact_score": 8, "description": "Standardized documentation"},
    {"category": "Benefits", "factor": "Scalable Personalization", "impact_score": 7, "description": "Tailored communications"},
    {"category": "Benefits", "factor": "Advanced Research", "impact_score": 8, "description": "Pattern analysis capabilities"},
    {"category": "Benefits", "factor": "Cost Efficiency", "impact_score": 9, "description": "90% reduction in manual work"},
    {"category": "Challenges", "factor": "Data Privacy & Security", "impact_score": 9, "description": "Critical for sensitive data"},
    {"category": "Challenges", "factor": "Quality Control", "impact_score": 8, "description": "AI hallucinations risk"},
    {"category": "Challenges", "factor": "Regulatory Compliance", "impact_score": 9, "description": "Complex frameworks"},
    {"category": "Challenges", "factor": "Algorithmic Bias", "impact_score": 7, "description": "Transparency issues"},
    {"category": "Challenges", "factor": "Integration & Change", "impact_score": 6, "description": "System compatibility"}
]

df = pd.DataFrame(data)

# Better factor name abbreviations within 15 character limit
df['factor_short'] = df['factor'].map({
    'Enhanced Productivity': 'Productivity',
    'Quality & Consistency': 'Quality',
    'Scalable Personalization': 'Personaliztn',
    'Advanced Research': 'Research',
    'Cost Efficiency': 'Cost Efficiency',
    'Data Privacy & Security': 'Data Privacy',
    'Quality Control': 'Quality Control',
    'Regulatory Compliance': 'Regulatory',
    'Algorithmic Bias': 'Algorithm Bias',
    'Integration & Change': 'Integration'
})

# Create diverging values - benefits positive, challenges negative
df['diverging_score'] = df.apply(lambda row: row['impact_score'] if row['category'] == 'Benefits' else -row['impact_score'], axis=1)

# Sort by category and score for better visualization
df_sorted = df.sort_values(['category', 'impact_score'], ascending=[True, False])

# Create the horizontal bar chart
fig = go.Figure()

# Add benefits bars (positive values) - using green color
benefits_data = df_sorted[df_sorted['category'] == 'Benefits']
fig.add_trace(go.Bar(
    y=benefits_data['factor_short'],
    x=benefits_data['diverging_score'],
    orientation='h',
    name='Benefits',
    marker_color='#28a745',  # Professional green color
    cliponaxis=False,
    text=benefits_data['impact_score'],
    textposition='outside',
    hovertemplate='<b>%{y}</b><br>Impact Score: %{x}<br>%{customdata}<extra></extra>',
    customdata=benefits_data['description']
))

# Add challenges bars (negative values) - using orange color
challenges_data = df_sorted[df_sorted['category'] == 'Challenges']
fig.add_trace(go.Bar(
    y=challenges_data['factor_short'],
    x=challenges_data['diverging_score'],
    orientation='h',
    name='Challenges',
    marker_color='#FFC185',
    cliponaxis=False,
    text=challenges_data['impact_score'],
    textposition='outside',
    hovertemplate='<b>%{y}</b><br>Impact Score: %{x:.0f}<br>%{customdata}<extra></extra>',
    customdata=challenges_data['description']
))

# Update layout
fig.update_layout(
    title='AI Content Tools: Benefits vs Challenges',
    xaxis_title='Impact Score',
    yaxis_title='Factors',
    barmode='relative',
    legend=dict(orientation='h', yanchor='bottom', y=1.05, xanchor='center', x=0.5)
)

# Update x-axis with better formatting
fig.update_xaxes(
    range=[-10, 10],
    tickvals=[-9, -6, -3, 0, 3, 6, 9],
    ticktext=['9', '6', '3', '0', '3', '6', '9'],
    showgrid=True,
    gridwidth=1,
    gridcolor='lightgray'
)

# Update y-axis
fig.update_yaxes(
    showgrid=True,
    gridwidth=1,
    gridcolor='lightgray'
)

# Add a vertical line at x=0
fig.add_vline(x=0, line_dash="solid", line_color="gray", line_width=2)

# Save the chart
fig.write_image('ai_content_tools_comparison.png')