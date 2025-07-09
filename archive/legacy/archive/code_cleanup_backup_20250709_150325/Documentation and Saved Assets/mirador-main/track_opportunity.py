"""
Track opportunities from evaluation through implementation and outcomes
"""

import sys
import json
from datetime import datetime
from pathlib import Path
from mirador_memory import MiradorMemory

def track_new_opportunity(opportunity_path):
    """Parse opportunity evaluation and track it"""
    memory = MiradorMemory()
    
    # Read the opportunity summary
    summary_path = Path(opportunity_path) / "OPPORTUNITY_SUMMARY.md"
    if not summary_path.exists():
        print(f"Summary not found: {summary_path}")
        return
    
    with open(summary_path, 'r') as f:
        content = f.read()
    
    # Extract key information
    lines = content.split('\n')
    opportunity_desc = ""
    for i, line in enumerate(lines):
        if "Opportunity:" in line:
            opportunity_desc = line.split("Opportunity:")[1].strip()
            break
    
    # Log the opportunity
    opp_id = memory.track_opportunity(
        opportunity_type="business",
        description=opportunity_desc,
        initial_score=0.0,
        viability={"status": "evaluated", "path": str(opportunity_path)}
    )
    
    print(f"Tracked opportunity #{opp_id}: {opportunity_desc}")
    print(f"Path: {opportunity_path}")
    print("\nTo update outcome later:")
    print(f"python3 {__file__} update {opp_id} [implemented|abandoned] 'outcome description'")
    
    memory.close()

def update_opportunity(opp_id, status, outcome, roi=None):
    """Update opportunity with real-world outcome"""
    memory = MiradorMemory()
    
    memory.update_opportunity_outcome(
        opportunity_id=int(opp_id),
        status=status,
        outcome=outcome,
        roi=float(roi) if roi else None,
        lessons=None
    )
    
    print(f"Updated opportunity #{opp_id}")
    print(f"Status: {status}")
    print(f"Outcome: {outcome}")
    if roi:
        print(f"ROI: {roi}")
    
    memory.close()

def list_opportunities():
    """List all tracked opportunities"""
    memory = MiradorMemory()
    
    cursor = memory.conn.cursor()
    opps = cursor.execute('''
    SELECT id, opportunity_type, description, implementation_status, created_at
    FROM opportunities
    ORDER BY created_at DESC
    LIMIT 20
    ''').fetchall()
    
    print("=== Tracked Opportunities ===")
    for opp in opps:
        print(f"\n#{opp['id']} - {opp['opportunity_type']}")
        print(f"Description: {opp['description'][:80]}...")
        print(f"Status: {opp['implementation_status']}")
        print(f"Created: {opp['created_at']}")
    
    memory.close()

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage:")
        print(f"  {sys.argv[0]} track <opportunity_path>")
        print(f"  {sys.argv[0]} update <id> <status> <outcome> [roi]")
        print(f"  {sys.argv[0]} list")
        sys.exit(1)
    
    command = sys.argv[1]
    
    if command == "track" and len(sys.argv) >= 3:
        track_new_opportunity(sys.argv[2])
    elif command == "update" and len(sys.argv) >= 5:
        roi = sys.argv[5] if len(sys.argv) > 5 else None
        update_opportunity(sys.argv[2], sys.argv[3], sys.argv[4], roi)
    elif command == "list":
        list_opportunities()
    else:
        print("Invalid command")
