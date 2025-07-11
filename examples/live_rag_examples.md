# Mirador RAG: Live Runnable Examples

These are actual commands you can run right now to test Mirador's RAG capabilities.

## 🚀 Quick Start RAG Demo

```bash
# 1. Create a sample business document
cat << 'EOF' > sample_business_plan.txt
TechStartup Inc. Business Plan 2024

Current Status:
- 10 employees, $500K ARR
- B2B SaaS platform for inventory management
- 50 active customers, 85% retention rate

Challenges:
- High customer acquisition cost ($5,000)
- Limited marketing budget ($10K/month)
- Competing with established players

Opportunities:
- AI-powered demand forecasting feature
- Untapped SMB market segment
- Partnership with major logistics providers

Financial Projections:
- Q1: $150K revenue, 15 new customers
- Q2: $200K revenue, 25 new customers
- Q3: $300K revenue, 40 new customers
- Q4: $450K revenue, 60 new customers
EOF

# 2. Analyze with Mirador's smart routing
./mirador-smart-v2 "Analyze sample_business_plan.txt and provide a growth strategy with specific action items"
```

## 📊 Financial Analysis Example

```bash
# Create financial data
cat << 'EOF' > quarterly_metrics.txt
Q3 2024 Performance Metrics

Revenue by Segment:
- Enterprise: $1.2M (45% of total)
- Mid-Market: $800K (30% of total)
- SMB: $667K (25% of total)

Cost Structure:
- Engineering: 40% of revenue
- Sales & Marketing: 35% of revenue
- Operations: 15% of revenue
- G&A: 10% of revenue

Key Performance Indicators:
- Gross Margin: 75%
- EBITDA Margin: 15%
- Cash Burn: $200K/month
- Runway: 18 months
- LTV/CAC Ratio: 3.2x
EOF

# Analyze for investment readiness
./mirador_universal_runner_v2.sh business_acceleration "Review quarterly_metrics.txt and assess our Series A readiness with specific areas to improve" detailed
```

## 💻 Code Analysis Example

```bash
# Create a Python module to analyze
cat << 'EOF' > user_service.py
from typing import Optional, Dict, List
from datetime import datetime
import bcrypt

class UserService:
    def __init__(self, db_connection):
        self.db = db_connection
        self.cache = {}
    
    def create_user(self, email: str, password: str, role: str = "user") -> Dict:
        """Create a new user with encrypted password"""
        hashed = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
        user = {
            "email": email,
            "password": hashed,
            "role": role,
            "created_at": datetime.utcnow(),
            "is_active": True
        }
        user_id = self.db.users.insert_one(user).inserted_id
        return {"id": str(user_id), "email": email, "role": role}
    
    def authenticate(self, email: str, password: str) -> Optional[Dict]:
        """Authenticate user and return user data if valid"""
        user = self.db.users.find_one({"email": email})
        if user and bcrypt.checkpw(password.encode('utf-8'), user['password']):
            return {"id": str(user['_id']), "email": email, "role": user['role']}
        return None
    
    def get_user_permissions(self, user_id: str, resource: str) -> List[str]:
        """Get user permissions for a specific resource"""
        # Check cache first
        cache_key = f"{user_id}:{resource}"
        if cache_key in self.cache:
            return self.cache[cache_key]
        
        # Fetch from database
        user = self.db.users.find_one({"_id": user_id})
        role = user.get('role', 'user')
        
        permissions = {
            "admin": ["read", "write", "delete", "admin"],
            "editor": ["read", "write"],
            "user": ["read"]
        }
        
        user_perms = permissions.get(role, [])
        self.cache[cache_key] = user_perms
        return user_perms
EOF

# Generate comprehensive documentation
./mirador_universal_runner_v2.sh technical_mastery "Analyze user_service.py and create: 1) API documentation with examples, 2) Security assessment, 3) Performance optimization suggestions" detailed
```

## 📝 Log Analysis Example

```bash
# Create sample application logs
cat << 'EOF' > app_logs.log
2024-01-11 09:15:23 INFO [server] Application started on port 8080
2024-01-11 09:16:45 INFO [auth] User login successful: user123@example.com
2024-01-11 09:17:02 ERROR [db] Connection pool exhausted, queuing requests
2024-01-11 09:17:03 ERROR [db] Connection pool exhausted, queuing requests
2024-01-11 09:17:05 WARN [api] Response time exceeded threshold: /api/reports (3.2s)
2024-01-11 09:18:12 ERROR [payment] Stripe webhook failed: invalid signature
2024-01-11 09:18:13 ERROR [payment] Stripe webhook failed: invalid signature
2024-01-11 09:18:14 ERROR [payment] Stripe webhook failed: invalid signature
2024-01-11 09:19:45 ERROR [storage] S3 upload failed: RequestTimeout
2024-01-11 09:20:01 INFO [db] Connection pool recovered, processing queued requests
2024-01-11 09:21:33 ERROR [auth] JWT token validation failed: token expired
2024-01-11 09:21:34 ERROR [auth] JWT token validation failed: token expired
2024-01-11 09:25:00 WARN [memory] Memory usage at 85%, triggering garbage collection
2024-01-11 09:30:15 ERROR [api] Unhandled exception in /api/analytics: NullPointerException
EOF

# Analyze for critical issues and remediation
./mirador-smart-v2 "Analyze app_logs.log to identify critical issues, their root causes, and provide specific fixes with code examples"
```

## 📧 Email Analysis Example

```bash
# Create customer feedback email
cat << 'EOF' > customer_feedback.txt
From: john.smith@bigcorp.com
To: support@ourproduct.com
Date: Jan 11, 2024
Subject: Issues with Enterprise Deployment

Hi Support Team,

We've been using your product for 3 months now and while the core features are great, we're facing several challenges:

1. Performance Issues:
   - Dashboard takes 10+ seconds to load with our 50K records
   - Export function times out for reports > 10K rows
   - API rate limits are too restrictive (100 calls/min)

2. Integration Gaps:
   - No native Salesforce integration as promised
   - Webhook events don't include all data fields
   - Can't bulk import via CSV (only API)

3. User Experience:
   - Mobile app is basically unusable on tablets
   - No dark mode (our developers work at night)
   - Can't customize dashboard layouts per team

We're evaluating whether to renew our $100K annual contract. Your competitor DataFlow Pro addresses most of these issues. What's your roadmap for fixing these problems?

Also, we need SOC2 compliance documentation ASAP for our audit.

Best regards,
John Smith
CTO, BigCorp
EOF

# Analyze and create response strategy
./mirador_universal_runner_v2.sh relationship_harmony "Analyze customer_feedback.txt and create: 1) Prioritized action plan, 2) Response email draft, 3) Retention strategy" detailed
```

## 🔬 Research Synthesis Example

```bash
# Create multiple research notes
cat << 'EOF' > ai_trend_1.txt
AI in Healthcare 2024: Key Findings
- 78% of hospitals now use AI for diagnostic imaging
- FDA approved 523 AI medical devices (up 45% from 2023)
- Average diagnosis accuracy improved by 23% with AI assistance
- Main barriers: data privacy concerns and integration costs
EOF

cat << 'EOF' > ai_trend_2.txt
Enterprise AI Adoption Report:
- 91% of Fortune 500 companies have active AI initiatives
- Average ROI on AI projects: 3.5x within 18 months
- Top use cases: customer service (45%), process automation (38%), predictive analytics (35%)
- 67% report skills gap as primary challenge
EOF

cat << 'EOF' > ai_trend_3.txt
AI Market Analysis Q3 2024:
- Global AI market size: $387B (projected $1.3T by 2029)
- Fastest growing segments: Generative AI (+215% YoY), Edge AI (+187% YoY)
- Investment trends: $42B in VC funding, focus shifting to vertical AI solutions
- Regulatory landscape: EU AI Act implementation driving compliance costs up 30%
EOF

# Synthesize into strategic insights
./mirador_universal_runner_v3_optimized.sh deep_analysis "Synthesize insights from ai_trend_1.txt, ai_trend_2.txt, and ai_trend_3.txt to identify the top 3 business opportunities for a B2B SaaS startup"
```

## 🏢 Contract Analysis Example

```bash
# Create a sample contract section
cat << 'EOF' > service_agreement.txt
SERVICE LEVEL AGREEMENT

4. Performance Standards
4.1 System Availability: Provider guarantees 99.9% uptime measured monthly
4.2 Response Times: 
    - Critical issues: 1 hour response, 4 hour resolution
    - High priority: 4 hour response, 24 hour resolution  
    - Normal: 24 hour response, 72 hour resolution
4.3 Penalties: For each 0.1% below 99.9% uptime, 5% service credit

5. Data Security
5.1 Encryption: All data encrypted at rest (AES-256) and in transit (TLS 1.3)
5.2 Backups: Daily automated backups retained for 30 days
5.3 Compliance: SOC2 Type II, GDPR, CCPA compliant
5.4 Breach Notification: Within 24 hours of discovery

6. Termination
6.1 Client may terminate with 30 days written notice
6.2 Provider requires 90 days notice for termination
6.3 Data export provided within 60 days of termination
6.4 Early termination penalty: 50% of remaining contract value

7. Liability
7.1 Provider liability capped at 12 months of service fees
7.2 No liability for indirect or consequential damages
7.3 Client indemnifies provider for third-party claims
EOF

# Extract key obligations and risks
./mirador-smart-v2 "Review service_agreement.txt and create a summary of: 1) Our obligations with deadlines, 2) Financial risks, 3) Areas needing negotiation"
```

## 💡 Advanced RAG Patterns

### Comparative Analysis
```bash
# Compare two versions of a proposal
./mirador-smart-v2 "Compare the original proposal in proposal_v1.txt with the revised version in proposal_v2.txt, highlighting what changed and why it matters"
```

### Multi-Step RAG Pipeline
```bash
# Step 1: Extract data
./mirador-smart-v2 "Extract all numerical metrics from report.pdf" > metrics.txt

# Step 2: Analyze trends
./mirador_universal_runner_v2.sh business_acceleration "Analyze the metrics in metrics.txt and identify trends" > trends.txt

# Step 3: Generate recommendations
./mirador_universal_runner_v3_optimized.sh strategic_synthesis "Based on trends.txt, create actionable 90-day plan"
```

### Context-Aware Generation
```bash
# Use previous outputs as context
./mirador-ez chain "Using the analysis from output/session_123/summary.txt as context, create a presentation outline for the board meeting" strategic_communicator presentation_designer decision_simplifier
```

## 🛠️ Tips for Effective RAG with Mirador

1. **Structure Your Prompts**
   - Be specific about the document location
   - Clearly state the desired output format
   - Include context about your use case

2. **Choose the Right Chain**
   - `technical_mastery` for code analysis
   - `business_acceleration` for strategic planning
   - `deep_analysis` for research synthesis
   - `relationship_harmony` for communication analysis

3. **Optimize Performance**
   - Use `quick` mode for rapid insights
   - Use `detailed` mode for comprehensive analysis
   - Batch related documents together

4. **Validate Results**
   - Cross-reference important findings
   - Use multiple chains for different perspectives
   - Rate outputs to improve future responses