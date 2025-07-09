"""
Simple dashboard to visualize Mirador performance and patterns
"""

from mirador_memory import MiradorMemory
from datetime import datetime, timedelta
import json

def show_dashboard():
    memory = MiradorMemory()
    
    print("=" * 60)
    print("MIRADOR PERFORMANCE DASHBOARD")
    print("=" * 60)
    
    # Get insights
    insights = memory.generate_insights()
    
    print(f"\nTotal Analyses: {insights['total_analyses']}")
    if insights['avg_execution_time']:
        print(f"Average Execution Time: {insights['avg_execution_time']:.1f} seconds")
    else:
        print("Average Execution Time: No data yet")
    
    # Model performance
    print("\n=== TOP PERFORMING MODELS ===")
    if insights['preferred_models']:
        for model in insights['preferred_models'][:5]:
            print(f"{model['model_name']}: {model['avg_quality']:.2f} quality, {model['uses']} uses")
    else:
        print("No model performance data yet")
    
    # Recent analyses
    cursor = memory.conn.cursor()
    recent = cursor.execute('''
    SELECT query, models_used, execution_time, created_at
    FROM analysis_history
    ORDER BY created_at DESC
    LIMIT 5
    ''').fetchall()
    
    print("\n=== RECENT ANALYSES ===")
    if recent:
        for analysis in recent:
            print(f"\n{analysis['created_at']}")
            print(f"Query: {analysis['query'][:60]}...")
            print(f"Models: {analysis['models_used']}")
            print(f"Time: {analysis['execution_time']:.1f}s")
    else:
        print("No analyses recorded yet")
    
    # Opportunities
    opps = cursor.execute('''
    SELECT COUNT(*) as total,
           SUM(CASE WHEN implementation_status = 'implemented' THEN 1 ELSE 0 END) as implemented,
           AVG(CASE WHEN roi_actual IS NOT NULL THEN roi_actual ELSE 0 END) as avg_roi
    FROM opportunities
    ''').fetchone()
    
    print("\n=== OPPORTUNITY TRACKING ===")
    print(f"Total Evaluated: {opps['total']}")
    print(f"Implemented: {opps['implemented']}")
    if opps['avg_roi']:
        print(f"Average ROI: {opps['avg_roi']:.1%}")
    
    # Patterns
    if insights['success_patterns']:
        print("\n=== SUCCESS PATTERNS ===")
        for pattern in insights['success_patterns']:
            print(f"\nChain: {pattern['recommended_chain']}")
            print(f"Success Rate: {pattern['success_rate']:.1%}")
    
    memory.close()

if __name__ == "__main__":
    show_dashboard()
