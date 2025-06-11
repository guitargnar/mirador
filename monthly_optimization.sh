#!/bin/bash

echo "=== MONTHLY LIFE OPTIMIZATION SCAN ==="
echo "Date: $(date)"
echo ""

# Financial optimization scan
echo "1. FINANCIAL OPTIMIZATION SCAN"
mirador-ez chain "Review and identify financial optimization opportunities based on last 30 days" financial_planning_expert_v5 enhanced_agent_fast_v3 > ~/ai_framework_git/monthly_reports/financial_$(date +%Y_%m).md

# Professional development scan  
echo "2. PROFESSIONAL DEVELOPMENT SCAN"
mirador-ez chain "Identify professional growth and business development opportunities" personal_brand_architect sales_content_creator enhanced_agent_fast_v3 > ~/ai_framework_git/monthly_reports/professional_$(date +%Y_%m).md

# Health and productivity scan
echo "3. HEALTH & PRODUCTIVITY SCAN"  
mirador-ez chain "Review health habits, productivity systems, and optimization opportunities" health_wellness_optimizer productivity_optimizer enhanced_agent_fast_v3 > ~/ai_framework_git/monthly_reports/wellness_$(date +%Y_%m).md

# Local opportunities scan
echo "4. LOCAL OPPORTUNITIES SCAN"
mirador-ez chain "Identify new Louisville resources, opportunities, and community connections" louisville_expert_v2 enhanced_agent_fast_v3 > ~/ai_framework_git/monthly_reports/local_$(date +%Y_%m).md

echo "Monthly optimization scan complete. Reports saved to ~/ai_framework_git/monthly_reports/"
