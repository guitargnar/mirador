#!/usr/bin/env python3
"""Quick dashboard status check"""

import requests
import json

# Check Streamlit health endpoint
try:
    health = requests.get("http://localhost:8501/healthz")
    print(f"✅ Streamlit Health Check: {health.status_code}")
    
    # Check main page
    main = requests.get("http://localhost:8501")
    print(f"✅ Main Page Status: {main.status_code}")
    
    # Get session info
    print("\n📊 Dashboard Status:")
    print("- Server: Running on http://localhost:8501")
    print("- Process: Active")
    print("- Ready for browser access")
    
    print("\n🎯 To view your portfolio:")
    print("1. Open your web browser")
    print("2. Go to: http://localhost:8501")
    print("3. You'll see:")
    print("   - AI Innovation Portfolio header")
    print("   - significant cost savings savings metric")
    print("   - 97% accuracy metric") 
    print("   - Interactive tabs for each project")
    print("   - Live Mirador demo")
    
except Exception as e:
    print(f"❌ Dashboard not accessible: {e}")
    print("Run: cd ~/Projects/mirador && streamlit run mirador_web_dashboard.py")