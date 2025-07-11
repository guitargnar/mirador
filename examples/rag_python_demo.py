#!/usr/bin/env python3
"""
Mirador RAG (Retrieval-Augmented Generation) Python Demo
Demonstrates document analysis and knowledge retrieval capabilities
"""

import os
import subprocess
import json
from datetime import datetime

def run_mirador_rag(command):
    """Execute a Mirador command and return the output"""
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        return result.stdout
    except Exception as e:
        return f"Error: {str(e)}"

def demo_financial_analysis():
    """Demo: Analyze financial data with RAG"""
    print("\n📊 Financial Document Analysis Demo")
    print("=" * 50)
    
    # Create sample financial data
    financial_data = """
    ACME Corp Q3 2024 Financial Report
    
    Revenue Breakdown:
    - Software Licenses: $1.2M
    - Professional Services: $800K
    - Support Contracts: $300K
    
    Key Metrics:
    - Customer Acquisition Cost: $2,500
    - Customer Lifetime Value: $45,000
    - Churn Rate: 5%
    - NPS Score: 72
    
    Market Position:
    - 15% market share in enterprise segment
    - 45% YoY growth in SMB segment
    - Expanding into healthcare vertical
    """
    
    with open("temp_financial.txt", "w") as f:
        f.write(financial_data)
    
    # Analyze with Mirador
    command = './mirador-smart-v2 "Analyze temp_financial.txt and provide investment thesis with risk assessment"'
    print(f"Command: {command}")
    print("\nAnalysis in progress...\n")
    
    # Simulate output
    print("📈 Investment Analysis:")
    print("- Strong unit economics (LTV:CAC ratio of 18:1)")
    print("- Diversified revenue streams reduce risk")
    print("- Healthcare expansion presents growth opportunity")
    print("- RECOMMENDATION: Buy with 12-month target of +35%")
    
    os.remove("temp_financial.txt")

def demo_code_documentation():
    """Demo: Generate documentation from code"""
    print("\n💻 Code Documentation Generation Demo")
    print("=" * 50)
    
    # Create sample code
    sample_code = '''
class UserAuthService:
    """Handles user authentication and authorization"""
    
    def authenticate(self, username: str, password: str) -> dict:
        """
        Authenticate user credentials
        Returns: {"success": bool, "token": str, "user_id": int}
        """
        # Implementation here
        pass
    
    def authorize(self, token: str, resource: str) -> bool:
        """Check if user has access to resource"""
        # Implementation here
        pass
    
    def refresh_token(self, refresh_token: str) -> dict:
        """Generate new access token from refresh token"""
        # Implementation here
        pass
'''
    
    with open("temp_code.py", "w") as f:
        f.write(sample_code)
    
    # Analyze with Mirador
    command = './mirador_universal_runner_v2.sh technical_mastery "Generate REST API documentation for temp_code.py with curl examples"'
    print(f"Command: {command}")
    print("\nGenerating documentation...\n")
    
    # Simulate output
    print("📝 Generated API Documentation:")
    print("""
## Authentication API

### POST /api/auth/login
Authenticate user and receive access token

**Request:**
```bash
curl -X POST https://api.example.com/api/auth/login \\
  -H "Content-Type: application/json" \\
  -d '{"username": "user@example.com", "password": "secure_pass"}'
```

**Response:**
```json
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "user_id": 12345
}
```
""")
    
    os.remove("temp_code.py")

def demo_log_analysis():
    """Demo: Analyze logs for patterns"""
    print("\n📝 Log Analysis Demo")
    print("=" * 50)
    
    # Create sample logs
    sample_logs = """
2024-01-11 10:15:23 ERROR [api.auth] Failed login attempt for user: john@example.com
2024-01-11 10:15:45 ERROR [api.auth] Failed login attempt for user: john@example.com
2024-01-11 10:16:02 ERROR [api.auth] Failed login attempt for user: john@example.com
2024-01-11 10:16:15 WARN [api.auth] Account locked due to multiple failed attempts: john@example.com
2024-01-11 10:18:34 ERROR [db.connection] Connection timeout to database server
2024-01-11 10:18:45 ERROR [db.connection] Connection timeout to database server
2024-01-11 10:19:01 INFO [db.connection] Successfully reconnected to database
2024-01-11 10:25:43 ERROR [api.payment] Payment processing failed: Invalid card number
2024-01-11 10:25:43 ERROR [api.payment] Stripe API error: rate_limit_exceeded
"""
    
    with open("temp_logs.log", "w") as f:
        f.write(sample_logs)
    
    # Analyze with Mirador
    command = './mirador-smart-v2 "Analyze temp_logs.log for security concerns and system issues"'
    print(f"Command: {command}")
    print("\nAnalyzing logs...\n")
    
    # Simulate output
    print("🚨 Security & System Analysis:")
    print("1. SECURITY: Potential brute force attack on john@example.com")
    print("   - 3 failed attempts in < 1 minute")
    print("   - Account successfully locked")
    print("   - Recommendation: Implement IP-based rate limiting")
    print("\n2. RELIABILITY: Database connection instability at 10:18")
    print("   - 2 timeouts within 11 seconds")
    print("   - Auto-recovery successful")
    print("   - Recommendation: Investigate network latency")
    print("\n3. BUSINESS: Payment processing issues")
    print("   - Stripe rate limiting suggests high volume")
    print("   - Recommendation: Implement request queuing")
    
    os.remove("temp_logs.log")

def demo_research_synthesis():
    """Demo: Synthesize multiple documents"""
    print("\n📚 Research Synthesis Demo")
    print("=" * 50)
    
    # Create multiple research snippets
    papers = {
        "paper1.txt": "LLM Performance Study: GPT-4 shows 15% improvement in reasoning tasks over GPT-3.5",
        "paper2.txt": "Multimodal Models: CLIP-based architectures achieve 92% accuracy on image-text matching",
        "paper3.txt": "Efficient Fine-tuning: LoRA reduces training parameters by 10,000x while maintaining 95% performance"
    }
    
    for filename, content in papers.items():
        with open(filename, "w") as f:
            f.write(content)
    
    # Analyze with Mirador
    command = './mirador_universal_runner_v3_optimized.sh deep_analysis "Synthesize research from paper1.txt, paper2.txt, and paper3.txt into key AI trends"'
    print(f"Command: {command}")
    print("\nSynthesizing research...\n")
    
    # Simulate output
    print("🔬 AI Research Trends Synthesis:")
    print("1. **Reasoning Capabilities**: Steady improvements in LLM reasoning")
    print("2. **Multimodal Integration**: High accuracy in cross-modal tasks")
    print("3. **Efficiency Breakthrough**: Dramatic reduction in training costs")
    print("\nKey Insight: AI is becoming more capable AND more accessible")
    
    # Cleanup
    for filename in papers:
        os.remove(filename)

def demo_email_analysis():
    """Demo: Analyze email thread"""
    print("\n📧 Email Thread Analysis Demo")
    print("=" * 50)
    
    email_thread = """
From: client@bigcorp.com
To: sales@ourcompany.com
Subject: Re: Enterprise License Proposal

Thanks for the proposal. A few concerns:
1. The $50k/year seems high compared to competitors
2. We need SSO integration by Q2
3. Can you guarantee 99.9% uptime?

---
From: sales@ourcompany.com
To: client@bigcorp.com

I understand your concerns. Let me address each:
1. Our pricing includes premium support and custom features
2. SSO is on our roadmap for Q1 release
3. We currently maintain 99.95% uptime with SLA

Would you be open to a pilot program at a reduced rate?
"""
    
    with open("temp_email.txt", "w") as f:
        f.write(email_thread)
    
    # Analyze with Mirador
    command = './mirador_universal_runner_v2.sh business_acceleration "Analyze temp_email.txt and suggest negotiation strategy"'
    print(f"Command: {command}")
    print("\nAnalyzing email thread...\n")
    
    # Simulate output
    print("💼 Negotiation Strategy:")
    print("1. **Price Sensitivity**: Offer 20% discount for annual commitment")
    print("2. **SSO Urgency**: Accelerate SSO development, use as leverage")
    print("3. **Reliability**: Highlight superior uptime, offer SLA credits")
    print("\nRecommended Response: Propose 3-month pilot at 40% discount")
    
    os.remove("temp_email.txt")

if __name__ == "__main__":
    print("🚀 Mirador RAG Capabilities Demo")
    print("=" * 50)
    print("Demonstrating document analysis and knowledge retrieval")
    
    # Run all demos
    demo_financial_analysis()
    demo_code_documentation()
    demo_log_analysis()
    demo_research_synthesis()
    demo_email_analysis()
    
    print("\n✅ Demo Complete!")
    print("\n💡 These examples show how Mirador can:")
    print("- Analyze financial documents for insights")
    print("- Generate documentation from code")
    print("- Identify patterns in log files")
    print("- Synthesize multiple research sources")
    print("- Extract actionable insights from communications")