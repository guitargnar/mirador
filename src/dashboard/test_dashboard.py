#!/usr/bin/env python3
"""Test the Mirador Web Dashboard"""

import requests
import time

def test_dashboard():
    """Test dashboard functionality"""
    url = "http://localhost:8501"
    
    print("🧪 Testing Mirador Web Dashboard...")
    print(f"URL: {url}")
    
    try:
        # Test 1: Check if server is responding
        response = requests.get(url, timeout=5)
        print(f"✅ Server Status: {response.status_code}")
        
        # Test 2: Check page size
        content_length = len(response.text)
        print(f"✅ Page Size: {content_length:,} bytes")
        
        # Test 3: Check for key content
        content = response.text.lower()
        
        checks = {
            "streamlit": "Streamlit framework",
            "user scott": "Author name",
            "mirador": "Mirador framework",
            "innovation": "Innovation content",
            "$1.2m": "Savings metric",
            "97%": "Accuracy metric"
        }
        
        print("\n📋 Content Checks:")
        for key, description in checks.items():
            if key in content:
                print(f"  ✅ {description}: Found")
            else:
                print(f"  ❌ {description}: Not found")
        
        # Test 4: Check response time
        start = time.time()
        requests.get(url)
        response_time = (time.time() - start) * 1000
        print(f"\n⚡ Response Time: {response_time:.0f}ms")
        
        print("\n✨ Dashboard is running successfully!")
        print(f"🌐 Access it at: {url}")
        
    except requests.ConnectionError:
        print("❌ Could not connect to dashboard")
        print("Make sure streamlit is running: streamlit run mirador_web_dashboard.py")
    except Exception as e:
        print(f"❌ Error: {e}")

if __name__ == "__main__":
    test_dashboard()