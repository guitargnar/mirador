#!/bin/bash

# Quick RAG Test - Runnable Demo
# This script demonstrates Mirador's RAG capabilities with actual examples

echo "🚀 Mirador RAG Quick Test"
echo "========================="
echo ""

# Test 1: Create and analyze a business document
echo "📊 Test 1: Business Document Analysis"
echo "Creating sample data..."

cat << 'EOF' > /tmp/startup_metrics.txt
StartupCo 2024 Metrics Dashboard

Monthly Recurring Revenue (MRR):
- January: $45,000
- February: $52,000
- March: $61,000
- Growth Rate: 35% quarter-over-quarter

Customer Metrics:
- Total Customers: 127
- Enterprise: 12 (avg $3,500/mo)
- SMB: 115 (avg $175/mo)
- Churn Rate: 3.2% monthly
- NPS Score: 67

Burn Rate: $85,000/month
Runway: 14 months
LTV:CAC Ratio: 2.8:1

Key Challenges:
- High CAC in enterprise segment
- Feature gaps vs competitors
- Need to improve onboarding
EOF

echo "Analyzing with Mirador..."
echo "Command: ./mirador-smart-v2 \"Analyze /tmp/startup_metrics.txt and provide 3 specific growth recommendations\""
echo ""
echo "Expected output: Growth strategy with actionable recommendations"
echo ""

# Test 2: Code analysis
echo "💻 Test 2: Code Documentation Generation"
echo "Creating sample code..."

cat << 'EOF' > /tmp/api_service.py
class PaymentService:
    def process_payment(self, amount, currency, card_token):
        """Process a payment transaction"""
        # Validate inputs
        if amount <= 0:
            raise ValueError("Amount must be positive")
        
        # Process with payment provider
        result = stripe.charge.create(
            amount=int(amount * 100),
            currency=currency,
            source=card_token
        )
        
        return {
            "transaction_id": result.id,
            "status": result.status,
            "amount": amount
        }
    
    def refund_payment(self, transaction_id, amount=None):
        """Issue a full or partial refund"""
        # Implementation here
        pass
EOF

echo "Command: ./mirador_universal_runner_v2.sh technical_mastery \"Generate API documentation for /tmp/api_service.py with curl examples\""
echo ""

# Test 3: Log analysis
echo "📝 Test 3: Security Log Analysis"
echo "Creating sample logs..."

cat << 'EOF' > /tmp/security.log
2024-01-11 10:15:23 WARN [auth] Failed login: admin@company.com - IP: 192.168.1.100
2024-01-11 10:15:45 WARN [auth] Failed login: admin@company.com - IP: 192.168.1.100
2024-01-11 10:16:02 WARN [auth] Failed login: admin@company.com - IP: 45.33.22.11
2024-01-11 10:16:15 ERROR [auth] Account locked: admin@company.com - Multiple failed attempts
2024-01-11 10:18:34 WARN [api] Suspicious API activity: 500 requests/min from IP: 45.33.22.11
2024-01-11 10:19:01 ERROR [firewall] Blocked IP: 45.33.22.11 - Rate limit exceeded
EOF

echo "Command: ./mirador-smart-v2 \"Analyze /tmp/security.log for security threats and recommend mitigations\""
echo ""

# Test 4: Quick synthesis
echo "🔍 Test 4: Multi-Document Synthesis"
echo "Creating multiple documents..."

cat << 'EOF' > /tmp/competitor1.txt
CompetitorA: $50M revenue, 500 customers, main strength is UI/UX, weakness is pricing
EOF

cat << 'EOF' > /tmp/competitor2.txt
CompetitorB: $30M revenue, 300 customers, main strength is integrations, weakness is performance
EOF

cat << 'EOF' > /tmp/our_position.txt
Our Company: $15M revenue, 200 customers, strength is AI features, weakness is marketing
EOF

echo "Command: ./mirador_universal_runner_v3_optimized.sh strategic_synthesis \"Compare /tmp/competitor1.txt, /tmp/competitor2.txt, and /tmp/our_position.txt to identify our competitive advantage\""
echo ""

echo "✅ Setup Complete!"
echo ""
echo "📚 All test files created in /tmp/"
echo "🎯 Run any of the commands above to see RAG in action"
echo ""
echo "💡 Pro tip: Use 'detailed' format for comprehensive analysis:"
echo "   ./mirador-smart-v2 \"Your prompt\" detailed"
echo ""

# Show created files
echo "📁 Created test files:"
ls -la /tmp/*.txt /tmp/*.py /tmp/*.log 2>/dev/null | grep -E "(startup_metrics|api_service|security|competitor|our_position)"