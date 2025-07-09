#!/usr/bin/env python3
"""
CMS Web Compliance Analyzer
Extracts website-specific requirements from Final Rules and Medicare Marketing Guidelines
Built for Risk Management compliance review
"""

import re
import datetime
from typing import List, Tuple

# Keywords that indicate web-related content
WEB_KEYWORDS = [
    'website', 'web site', 'web page', 'webpage', 'online', 'portal', 'digital',
    'internet', 'url', 'link', 'hyperlink', 'electronic', 'e-signature',
    'browser', 'mobile app', 'application', 'user interface', 'ui', 'ux',
    'accessibility', 'ada', 'wcag', '508 compliance', 'screen reader',
    'medicare.gov', 'member portal', 'provider portal',
    'enrollment online', 'web enrollment', 'digital enrollment',
    'download', 'upload', 'pdf', 'form online', 'submit online',
    'click', 'button', 'navigation', 'menu', 'landing page',
    'search function', 'filter', 'sort', 'display', 'show', 'hide',
    'responsive', 'mobile-friendly', 'tablet', 'desktop',
    'cookie', 'privacy policy', 'terms of use', 'disclaimer',
    # CMS-specific terms added for CY2026 Final Rule
    'provider directory', 'formulary search', 'plan finder', 
    'enrollment application', 'electronic delivery', 'digital communications',
    'member website', 'Plan Benefit Package', 'Evidence of Coverage',
    'web-based', 'internet-based', 'electronically available',
    'machine readable', 'downloadable format', 'PDF download',
    'member self-service', 'digital ID card', 'telehealth platform'
]

# Compliance-specific terms that often relate to web
COMPLIANCE_KEYWORDS = [
    'must display', 'must include', 'must provide', 'shall display',
    'required to show', 'prominently display', 'clearly visible',
    'font size', 'contrast ratio', 'color contrast',
    'within clicks', 'accessible from', 'available on',
    'electronic delivery', 'digital format', 'electronic format'
]

# Regulatory terms specific to CMS Final Rules
REGULATORY_TERMS = [
    'Final Rule', 'Medicare Marketing Guidelines', 'CMS guidance',
    'regulatory requirement', 'must be available online',
    'website requirement', 'electronic access', 'digital requirement',
    'we are finalizing', 'plans must', 'beginning january',
    'effective date', 'compliance date', 'implementation deadline'
]

# Medicare plan-specific keywords
MEDICARE_PLAN_KEYWORDS = [
    'plan website', 'medicare.gov redirect',
    'provider search tool', 'pharmacy lookup', 'drug pricing tool',
    'Prior Authorization', 'PA lookup', 'formulary exceptions',
    'SB/Annual Notice', 'ANOC', 'EOC', 'plan documents',
    'member login', 'member authentication', 'Find a Doctor',
    'drug cost estimator', 'coverage determination', 'appeals process',
    'Star Ratings display', 'quality ratings', 'plan ratings'
]

# Compliance categories for Risk Management tracking
COMPLIANCE_CATEGORIES = {
    'URGENT': 'Must be implemented by [DATE]',
    'WEBSITE_FUNCTION': 'Requires new/updated web functionality',
    'CONTENT_UPDATE': 'Static content changes needed',
    'TOOL_ENHANCEMENT': 'Interactive tool updates required',
    'ACCESSIBILITY': 'WCAG/508 compliance items'
}

# Section headers that often contain web requirements
IMPORTANT_SECTIONS = [
    'electronic', 'digital', 'online', 'web', 'internet',
    'technology', 'systems', 'communication', 'accessibility',
    'member experience', 'user experience', 'enrollment'
]

def extract_web_impacts(text: str) -> List[Tuple[str, str, int]]:
    """
    Extract sentences that likely contain web-related impacts
    Returns: List of (sentence, reason, priority)
    """
    # Split into sentences (handling common abbreviations)
    text = text.replace('U.S.', 'US').replace('i.e.', 'ie').replace('e.g.', 'eg')
    sentences = re.split(r'[.!?]+', text)
    
    web_impacts = []
    
    for i, sentence in enumerate(sentences):
        if len(sentence.strip()) < 20:  # Skip very short sentences
            continue
            
        sentence_lower = sentence.lower()
        
        # Check for plan-specific requirements FIRST (highest priority)
        plan_specific_found = False
        for keyword in MEDICARE_PLAN_KEYWORDS:
            if keyword.lower() in sentence_lower:
                reason = f"Medicare plan requirement: '{keyword}'"
                web_impacts.append((sentence.strip(), reason, 0))  # Priority 0 = URGENT
                plan_specific_found = True
                break
        
        if plan_specific_found:
            continue
            
        # Priority 1: Direct web requirements
        priority_1_found = False
        for keyword in WEB_KEYWORDS[:20]:  # Check primary web keywords
            if keyword in sentence_lower:
                reason = f"Contains '{keyword}'"
                web_impacts.append((sentence.strip(), reason, 1))
                priority_1_found = True
                break
        
        if priority_1_found:
            continue
            
        # Priority 2: Compliance requirements that affect web
        priority_2_found = False
        for keyword in COMPLIANCE_KEYWORDS:
            if keyword in sentence_lower:
                # Check if it's in context of web/digital
                for web_word in ['online', 'web', 'digital', 'electronic']:
                    if web_word in sentence_lower:
                        reason = f"Compliance requirement with '{keyword}'"
                        web_impacts.append((sentence.strip(), reason, 2))
                        priority_2_found = True
                        break
                if priority_2_found:
                    break
        
        if priority_2_found:
            continue
            
        # Priority 3: Might be web-related (contains secondary keywords)
        for keyword in WEB_KEYWORDS[20:]:  # Check secondary keywords
            if keyword in sentence_lower:
                reason = f"Possible web impact - mentions '{keyword}'"
                web_impacts.append((sentence.strip(), reason, 3))
                break
    
    # Sort by priority
    web_impacts.sort(key=lambda x: x[2])
    
    return web_impacts

def extract_from_federal_register(text: str) -> List[Tuple[str, str]]:
    """
    Extract requirements from Federal Register format
    Looks for patterns like:
    - "We are finalizing that..."
    - "Plans must..."
    - "Beginning January 1, 2026..."
    - "website must display..."
    """
    federal_requirements = []
    sentences = re.split(r'[.!?]+', text)
    
    federal_patterns = [
        r'we are finalizing',
        r'plans? must',
        r'beginning (?:january|july) \d+,? \d{4}',
        r'effective (?:date|january|july)',
        r'must be (?:available|displayed|provided)',
        r'requirement to (?:display|provide|make available)',
        r'shall (?:display|provide|include)',
        r'required to (?:post|display|maintain)'
    ]
    
    for sentence in sentences:
        sentence_lower = sentence.lower()
        for pattern in federal_patterns:
            if re.search(pattern, sentence_lower):
                # Check if it mentions web/digital/electronic
                if any(web_term in sentence_lower for web_term in 
                       ['website', 'online', 'electronic', 'digital', 'web', 'internet',
                        'member portal', 'provider directory']):
                    reason = f"Federal Register requirement: {pattern}"
                    federal_requirements.append((sentence.strip(), reason))
                    break
    
    return federal_requirements

def format_for_risk_management(web_impacts: List[Tuple[str, str, int]], doc_name: str = "CMS Document") -> str:
    """Format specifically for Risk Management compliance tracking"""
    
    # Separate by priority
    urgent_items = [item for item in web_impacts if item[2] == 0]  # Plan-specific
    functional_changes = [item for item in web_impacts if item[2] == 1 and 
                         any(term in item[0].lower() for term in ['tool', 'search', 'calculator', 'portal'])]
    content_updates = [item for item in web_impacts if item[2] == 1 and 
                      any(term in item[0].lower() for term in ['display', 'show', 'provide', 'include'])]
    
    date = datetime.datetime.now().strftime("%Y-%m-%d")
    
    output = f"""
CMS WEB COMPLIANCE REQUIREMENTS
Document: {doc_name}
Review Date: {date}
Reviewer: Risk Management

============================================================
IMMEDIATE ACTIONS REQUIRED (Plan-specific):
============================================================
"""
    
    if urgent_items:
        for item, reason, _ in urgent_items[:10]:  # Top 10 urgent
            output += f"\n• {item}\n  [{reason}]\n"
    else:
        output += "\nNo plan-specific requirements identified.\n"
    
    output += """
============================================================
WEBSITE FUNCTIONALITY CHANGES:
============================================================
"""
    
    if functional_changes:
        for item, reason, _ in functional_changes[:10]:
            output += f"\n• {item}\n  [Impact: {reason}]\n"
    else:
        output += "\nNo functional changes required.\n"
        
    output += """
============================================================
CONTENT UPDATES REQUIRED:
============================================================
"""
    
    if content_updates:
        for item, reason, _ in content_updates[:10]:
            output += f"\n• {item}\n  [Update needed: {reason}]\n"
    else:
        output += "\nNo content updates identified.\n"
    
    output += """
============================================================
COMPLIANCE TRACKING:
============================================================
[ ] Shared with Web Dev Team (date: __________)
[ ] Added to Compliance Matrix (date: __________)
[ ] Risk Assessment Complete (date: __________)
[ ] Stakeholder Notification Sent (date: __________)
[ ] Implementation Plan Created (date: __________)
[ ] Testing/Validation Scheduled (date: __________)

NOTES:
_____________________________________________________________
_____________________________________________________________
_____________________________________________________________
"""
    
    return output

def main():
    print("CMS Web Compliance Analyzer")
    print("Risk Management Tool for Final Rules and Medicare Marketing Guidelines")
    print("=" * 60)
    print("Paste your CMS guidance text below (press Enter twice when done):")
    print("Tip: Copy from Federal Register, Final Rules, or Medicare Marketing Guidelines")
    print("Example: https://www.federalregister.gov/documents/2025/04/15/2025-06008/")
    print("=" * 60)
    
    # Collect multi-line input
    lines = []
    empty_count = 0
    while True:
        try:
            line = input()
            if line == "":
                empty_count += 1
                if empty_count >= 2:
                    break
            else:
                empty_count = 0
                lines.append(line)
        except EOFError:
            break
    
    text = "\n".join(lines)
    
    if len(text) < 50:
        print("\n❌ Text too short. Please paste the CMS guidance document.")
        return
    
    # Analyze the text
    print("\n🔍 Analyzing document for web impacts...")
    web_impacts = extract_web_impacts(text)
    
    # Generate output
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
    output_file = f"cms_web_impacts_{datetime.datetime.now().strftime('%Y%m%d_%H%M%S')}.txt"
    
    # Extract Federal Register patterns if present
    federal_reqs = extract_from_federal_register(text)
    if federal_reqs:
        # Add Federal Register requirements as priority 0
        for req, reason in federal_reqs:
            web_impacts.append((req, reason, 0))
    
    # Re-sort after adding federal requirements
    web_impacts.sort(key=lambda x: x[2])
    
    with open(output_file, 'w') as f:
        # First, write the Risk Management format
        risk_format = format_for_risk_management(web_impacts, "CMS Final Rule/Guidance")
        f.write(risk_format)
        f.write("\n\n" + "="*80 + "\n")
        f.write("DETAILED ANALYSIS\n")
        f.write("="*80 + "\n\n")
        
        # Urgent Priority (Plan-specific)
        urgent_priority = [imp for imp in web_impacts if imp[2] == 0]
        if urgent_priority:
            f.write("🚨 URGENT - Medicare Plan Website Requirements:\n")
            f.write("-" * 80 + "\n")
            for impact, reason, _ in urgent_priority:
                f.write(f"\n• {impact}\n")
                f.write(f"  [Reason: {reason}]\n")
            f.write("\n")
        
        # High Priority (Direct Web Requirements)
        high_priority = [imp for imp in web_impacts if imp[2] == 1]
        if high_priority:
            f.write("🔴 HIGH PRIORITY - Direct Web Requirements:\n")
            f.write("-" * 80 + "\n")
            for impact, reason, _ in high_priority:
                f.write(f"\n• {impact}\n")
                f.write(f"  [Reason: {reason}]\n")
            f.write("\n")
        
        # Medium Priority (Compliance affecting web)
        medium_priority = [imp for imp in web_impacts if imp[2] == 2]
        if medium_priority:
            f.write("\n🟡 MEDIUM PRIORITY - Compliance Requirements Affecting Web:\n")
            f.write("-" * 80 + "\n")
            for impact, reason, _ in medium_priority:
                f.write(f"\n• {impact}\n")
                f.write(f"  [Reason: {reason}]\n")
            f.write("\n")
        
        # Low Priority (Possible web impacts)
        low_priority = [imp for imp in web_impacts if imp[2] == 3]
        if low_priority and len(low_priority) <= 10:  # Only show if not too many
            f.write("\n🟢 POSSIBLE Web Impacts (Review for relevance):\n")
            f.write("-" * 80 + "\n")
            for impact, reason, _ in low_priority:
                f.write(f"\n• {impact}\n")
                f.write(f"  [Reason: {reason}]\n")
        
        # Summary for email
        f.write("\n\n" + "=" * 80 + "\n")
        f.write("SUMMARY FOR EMAIL/TEAMS:\n")
        f.write("=" * 80 + "\n")
        f.write(f"Reviewed CMS guidance ({timestamp})\n\n")
        f.write(f"Web Impact Summary:\n")
        f.write(f"• {len(high_priority)} direct web requirements identified\n")
        f.write(f"• {len(medium_priority)} compliance items affecting web display\n")
        f.write(f"• {len(low_priority)} items need further review\n\n")
        f.write("Key Requirements:\n")
        for impact, _, _ in high_priority[:5]:  # Top 5 only
            f.write(f"• {impact[:100]}...\n")
    
    # Print summary to console
    print("\n" + "=" * 60)
    print("✅ RISK MANAGEMENT COMPLIANCE ANALYSIS COMPLETE")
    print("=" * 60)
    
    # Count plan-specific requirements
    urgent_count = len([imp for imp in web_impacts if imp[2] == 0])
    
    print(f"\n📊 Medicare Website Impact Summary:")
    print(f"   • URGENT Plan-specific: {urgent_count}")
    print(f"   • Website functionality changes: {len(high_priority)}")
    print(f"   • Content updates needed: {len(medium_priority)}")
    print(f"   • Total web requirements: {len(web_impacts)}")
    
    print(f"\n📄 Risk Management report saved to: {output_file}")
    
    if urgent_count > 0:
        print("\n🚨 URGENT MEDICARE PLAN REQUIREMENTS FOUND:")
        urgent_items = [imp for imp in web_impacts if imp[2] == 0]
        for impact, _, _ in urgent_items[:3]:
            print(f"\n• {impact[:120]}...")
    elif high_priority:
        print("\n🔴 TOP WEB REQUIREMENTS FOUND:")
        for impact, _, _ in high_priority[:3]:
            print(f"\n• {impact[:120]}...")
    
    print("\n🎯 RISK MANAGEMENT ACTION ITEMS:")
    print("   1. Review compliance tracking checklist in report")
    print("   2. Share with Web Dev Team immediately")
    print("   3. Update Compliance Matrix")
    print("   4. Schedule stakeholder briefing")
    print("   5. Document in Risk Assessment system")
    
    print("\n💡 This tool is optimized for:")
    print("   • CY2026 Final Rule analysis")
    print("   • Medicare Marketing Guidelines reviews")
    print("   • Quarterly compliance audits")
    print("   • Risk Management documentation")

if __name__ == "__main__":
    main()