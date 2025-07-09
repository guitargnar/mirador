#!/usr/bin/env python3
"""
Mirador Integration Bridge
Connects productivity tools with Mirador AI orchestration framework
"""

import sys
import os
import json
from typing import Dict, Any, Optional

# Add Mirador to path if available
MIRADOR_PATH = os.path.expanduser("~/Projects/mirador")
if os.path.exists(MIRADOR_PATH):
    sys.path.insert(0, MIRADOR_PATH)
    MIRADOR_AVAILABLE = True
    try:
        from enhanced_mirador import run_enhanced_chain
        from mirador import query_model
    except ImportError:
        MIRADOR_AVAILABLE = False
else:
    MIRADOR_AVAILABLE = False

class ProductivityMiradorBridge:
    """Bridge between productivity tools and Mirador AI framework"""
    
    def __init__(self):
        self.mirador_available = MIRADOR_AVAILABLE
        
    def enhance_meeting_notes(self, formatted_notes: Dict[str, str]) -> Dict[str, Any]:
        """Add AI insights to formatted meeting notes"""
        if not self.mirador_available:
            return {"error": "Mirador not available", "notes": formatted_notes}
        
        try:
            # Extract key insights
            insights = run_enhanced_chain(
                f"Analyze these meeting notes and provide: "
                f"1) Key strategic insights "
                f"2) Hidden risks or opportunities "
                f"3) Recommended follow-up actions\n\n"
                f"{formatted_notes['executive_summary']}",
                chain_type="business"
            )
            
            return {
                "original": formatted_notes,
                "ai_insights": insights,
                "enhanced": True
            }
        except Exception as e:
            return {"error": str(e), "notes": formatted_notes}
    
    def prioritize_email_actions(self, actions: list) -> Dict[str, Any]:
        """Use AI to prioritize and analyze email actions"""
        if not self.mirador_available:
            return {"error": "Mirador not available", "actions": actions}
        
        try:
            result = run_enhanced_chain(
                f"Prioritize these actions by impact and urgency. "
                f"Identify dependencies and suggest optimal execution order:\n"
                f"{json.dumps(actions, indent=2)}",
                models=["decision_simplifier_v3"]
            )
            
            return {
                "original_actions": actions,
                "prioritized": result,
                "enhanced": True
            }
        except Exception as e:
            return {"error": str(e), "actions": actions}
    
    def analyze_compliance_impact(self, requirements: list) -> Dict[str, Any]:
        """Get AI analysis of compliance requirements"""
        if not self.mirador_available:
            return {"error": "Mirador not available", "requirements": requirements}
        
        try:
            analysis = run_enhanced_chain(
                f"Analyze these CMS compliance requirements:\n"
                f"1) Identify implementation complexity\n"
                f"2) Suggest resource requirements\n"
                f"3) Recommend prioritization\n"
                f"4) Flag potential risks\n\n"
                f"{json.dumps(requirements[:10], indent=2)}",  # First 10
                chain_type="solution"
            )
            
            return {
                "requirements": requirements,
                "ai_analysis": analysis,
                "enhanced": True
            }
        except Exception as e:
            return {"error": str(e), "requirements": requirements}
    
    def generate_accomplishment_insights(self, accomplishments: list) -> Dict[str, Any]:
        """Generate performance review insights from accomplishments"""
        if not self.mirador_available:
            return {"error": "Mirador not available", "accomplishments": accomplishments}
        
        try:
            insights = run_enhanced_chain(
                f"Analyze these accomplishments and provide:\n"
                f"1) Key themes and patterns\n"
                f"2) Quantified impact statements\n"
                f"3) Growth areas demonstrated\n"
                f"4) Performance review bullets\n\n"
                f"{json.dumps(accomplishments, indent=2)}",
                models=["matthew_context_provider_v3", "enhanced_agent_enforcer"]
            )
            
            return {
                "accomplishments": accomplishments,
                "performance_insights": insights,
                "enhanced": True
            }
        except Exception as e:
            return {"error": str(e), "accomplishments": accomplishments}
    
    def predict_star_ratings_trends(self, ratings_data: Dict) -> Dict[str, Any]:
        """Use AI to predict star ratings trends and recommendations"""
        if not self.mirador_available:
            return {"error": "Mirador not available", "data": ratings_data}
        
        try:
            predictions = run_enhanced_chain(
                f"Analyze star ratings data and provide:\n"
                f"1) Trend predictions for next quarter\n"
                f"2) Risk areas requiring attention\n"
                f"3) Specific improvement recommendations\n"
                f"4) Resource allocation suggestions\n\n"
                f"Current data: {json.dumps(ratings_data, indent=2)}",
                chain_type="solution"
            )
            
            return {
                "current_data": ratings_data,
                "ai_predictions": predictions,
                "enhanced": True
            }
        except Exception as e:
            return {"error": str(e), "data": ratings_data}
    
    def create_unified_dashboard(self, all_tool_data: Dict) -> str:
        """Create unified AI-enhanced productivity dashboard"""
        if not self.mirador_available:
            return "Mirador not available - showing standard dashboard"
        
        try:
            dashboard = run_enhanced_chain(
                f"Create an executive dashboard summary from this productivity data:\n"
                f"{json.dumps(all_tool_data, indent=2)}",
                models=["enhanced_agent_enforcer"]
            )
            
            return dashboard
        except Exception as e:
            return f"Dashboard generation failed: {str(e)}"

# Integration helper functions
def check_mirador_integration():
    """Check if Mirador is available and properly configured"""
    bridge = ProductivityMiradorBridge()
    
    print("🔍 Checking Mirador Integration Status...")
    print("-" * 40)
    
    if bridge.mirador_available:
        print("✅ Mirador framework detected!")
        print(f"📁 Location: {MIRADOR_PATH}")
        print("🚀 AI enhancement features available")
        
        # Test basic functionality
        try:
            test_result = query_model("test", "Hello", max_length=10)
            print("✅ API connection successful")
        except:
            print("⚠️  API connection failed - check Ollama")
    else:
        print("❌ Mirador not found")
        print("📝 To enable AI features:")
        print(f"   1. Clone Mirador to: {MIRADOR_PATH}")
        print("   2. Install Ollama and required models")
        print("   3. Run this check again")
    
    return bridge.mirador_available

# Example usage in productivity tools
def enhance_with_ai(tool_name: str, data: Any) -> Dict[str, Any]:
    """Generic enhancement function for any productivity tool"""
    bridge = ProductivityMiradorBridge()
    
    if not bridge.mirador_available:
        return {"enhanced": False, "data": data}
    
    enhancement_map = {
        "meeting_notes": bridge.enhance_meeting_notes,
        "email_actions": bridge.prioritize_email_actions,
        "cms_compliance": bridge.analyze_compliance_impact,
        "accomplishments": bridge.generate_accomplishment_insights,
        "star_ratings": bridge.predict_star_ratings_trends
    }
    
    enhancer = enhancement_map.get(tool_name)
    if enhancer:
        return enhancer(data)
    
    return {"enhanced": False, "data": data}

if __name__ == "__main__":
    # Check integration status
    if check_mirador_integration():
        print("\n🎯 Testing AI Enhancement...")
        
        # Test meeting notes enhancement
        test_notes = {
            "executive_summary": "Discussed Q4 targets and budget concerns. "
                               "Decision made to postpone launch to January."
        }
        
        bridge = ProductivityMiradorBridge()
        result = bridge.enhance_meeting_notes(test_notes)
        
        if result.get("enhanced"):
            print("\n✨ AI Enhancement successful!")
            print("Original:", test_notes["executive_summary"])
            print("\nAI Insights:", result.get("ai_insights", "No insights"))
        else:
            print("\n❌ Enhancement failed:", result.get("error"))