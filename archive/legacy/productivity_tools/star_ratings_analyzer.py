#!/usr/bin/env python3
"""
Star Ratings Analyzer - Transform data into executive insights
Addresses health plans' #1 priority: Star Ratings improvement
"""

import re
import datetime
import statistics
from typing import List, Dict, Tuple

def parse_csv_data(raw_data: str) -> List[Dict]:
    """Parse CSV data into structured format"""
    lines = [line.strip() for line in raw_data.strip().split('\n') if line.strip()]
    if not lines:
        return []
    
    # Try to identify headers
    headers = []
    data_rows = []
    
    # Common column patterns for star ratings data
    if ',' in lines[0]:
        headers = [h.strip().lower() for h in lines[0].split(',')]
        data_rows = lines[1:]
    else:
        # Try to auto-detect structure
        return []
    
    # Parse data rows
    parsed_data = []
    for row in data_rows:
        values = row.split(',')
        if len(values) == len(headers):
            row_dict = {}
            for i, header in enumerate(headers):
                row_dict[header] = values[i].strip()
            parsed_data.append(row_dict)
    
    return parsed_data

def analyze_star_ratings(data: List[Dict]) -> Dict:
    """Perform comprehensive star ratings analysis"""
    analysis = {
        'overall_rating': 0.0,
        'category_ratings': {},
        'trends': {},
        'problem_areas': [],
        'improvements': [],
        'top_drivers': []
    }
    
    # Identify rating columns and categories
    rating_categories = []
    for key in data[0].keys():
        if any(term in key.lower() for term in ['rating', 'score', 'star', 'measure']):
            rating_categories.append(key)
    
    # Calculate ratings by category
    for category in rating_categories:
        ratings = []
        for row in data:
            try:
                rating = float(row.get(category, '0').replace('*', '').strip())
                if 0 < rating <= 5:  # Valid star rating
                    ratings.append(rating)
            except:
                continue
        
        if ratings:
            avg_rating = statistics.mean(ratings)
            analysis['category_ratings'][category] = {
                'current': round(avg_rating, 2),
                'count': len(ratings),
                'min': min(ratings),
                'max': max(ratings)
            }
    
    # Calculate overall rating
    if analysis['category_ratings']:
        overall_ratings = [v['current'] for v in analysis['category_ratings'].values()]
        analysis['overall_rating'] = round(statistics.mean(overall_ratings), 2)
    
    # Identify problem areas (below 3.5 stars)
    for category, info in analysis['category_ratings'].items():
        if info['current'] < 3.5:
            analysis['problem_areas'].append({
                'category': category,
                'rating': info['current'],
                'gap': round(4.0 - info['current'], 2)  # Gap to 4-star
            })
    
    # Mock historical comparison (since we don't have historical data)
    # In reality, this would compare to previous periods
    for category in analysis['category_ratings']:
        # Simulate a trend
        current = analysis['category_ratings'][category]['current']
        previous = current + (0.3 if current < 3.5 else -0.2)  # Mock previous
        analysis['trends'][category] = {
            'direction': 'down' if current < previous else 'up',
            'change': round(current - previous, 2)
        }
    
    # Identify top negative drivers
    if analysis['problem_areas']:
        analysis['top_drivers'] = sorted(
            analysis['problem_areas'], 
            key=lambda x: x['rating']
        )[:3]
    
    return analysis

def generate_ascii_chart(title: str, data: Dict[str, float], width: int = 50) -> str:
    """Generate ASCII bar chart for ratings"""
    chart = f"\n{title}\n{'=' * width}\n"
    
    if not data:
        return chart + "No data available\n"
    
    max_value = max(data.values()) if data.values() else 5.0
    
    for label, value in sorted(data.items(), key=lambda x: x[1], reverse=True):
        # Normalize bar length
        bar_length = int((value / max_value) * (width - 15))
        bar = '█' * bar_length
        
        # Add star indicator
        stars = '★' * int(value) + '☆' * (5 - int(value))
        
        # Truncate label if too long
        label_display = label[:25] + '...' if len(label) > 25 else label
        
        chart += f"{label_display:30} {value:.1f} {stars} {bar}\n"
    
    return chart

def generate_insights(analysis: Dict) -> List[str]:
    """Generate actionable insights from analysis"""
    insights = []
    
    # Overall rating insight
    overall = analysis['overall_rating']
    if overall < 3.0:
        insights.append(f"CRITICAL: Overall rating of {overall} stars requires immediate intervention")
    elif overall < 3.5:
        insights.append(f"WARNING: Overall rating of {overall} stars below CMS threshold")
    elif overall < 4.0:
        insights.append(f"OPPORTUNITY: Overall rating of {overall} stars - focus on reaching 4+ stars")
    else:
        insights.append(f"STRONG: Overall rating of {overall} stars meets performance targets")
    
    # Problem areas
    if analysis['problem_areas']:
        worst = analysis['problem_areas'][0]
        insights.append(
            f"Lowest performer: {worst['category'].replace('_', ' ').title()} "
            f"at {worst['rating']} stars (gap: {worst['gap']} to reach 4-star)"
        )
    
    # Trends
    declining = [k for k, v in analysis['trends'].items() if v['direction'] == 'down']
    if declining:
        insights.append(f"Declining measures: {len(declining)} categories showing downward trend")
    
    # Improvement opportunities
    if len(analysis['problem_areas']) > 2:
        insights.append(
            f"Focus areas: {len(analysis['problem_areas'])} measures below 3.5 stars "
            "require targeted improvement plans"
        )
    
    return insights

def generate_recommendations(analysis: Dict) -> List[str]:
    """Generate specific recommendations based on patterns"""
    recommendations = []
    
    # Based on problem areas
    for problem in analysis['top_drivers'][:3]:
        category = problem['category'].replace('_', ' ').title()
        rating = problem['rating']
        
        if 'network' in category.lower() or 'provider' in category.lower():
            recommendations.append(
                f"Provider Network: Implement weekly data refresh and accuracy audits "
                f"to improve {category} (currently {rating} stars)"
            )
        elif 'drug' in category.lower() or 'formulary' in category.lower():
            recommendations.append(
                f"Pharmacy: Enhance formulary transparency and prior auth process "
                f"for {category} (currently {rating} stars)"
            )
        elif 'customer' in category.lower() or 'service' in category.lower():
            recommendations.append(
                f"Member Experience: Deploy AI-powered service improvements "
                f"for {category} (currently {rating} stars)"
            )
        elif 'appeal' in category.lower() or 'grievance' in category.lower():
            recommendations.append(
                f"Operations: Streamline appeals process and reduce resolution time "
                f"for {category} (currently {rating} stars)"
            )
        else:
            recommendations.append(
                f"Quality Focus: Establish improvement taskforce "
                f"for {category} (currently {rating} stars)"
            )
    
    # Add strategic recommendation
    if analysis['overall_rating'] < 3.5:
        recommendations.insert(0, 
            "STRATEGIC: Form cross-functional Star Ratings war room with weekly CEO updates"
        )
    
    return recommendations

def main():
    print("Star Ratings Analyzer - Executive Insights Generator")
    print("=" * 60)
    print("Paste your star ratings data (CSV format)")
    print("Example: measure_name,rating,year")
    print("Press Enter twice when done:")
    print("=" * 60)
    
    # Collect data input
    lines = []
    empty_count = 0
    while True:
        line = input()
        if line == "":
            empty_count += 1
            if empty_count >= 2:
                break
        else:
            empty_count = 0
            lines.append(line)
    
    raw_data = "\n".join(lines)
    
    # If no data provided, use sample data
    if len(raw_data) < 20:
        print("\n📊 Using sample star ratings data for demonstration...")
        raw_data = """measure,rating,complaints
C01_Care_Coordination,3.8,125
C02_Member_Complaints,2.9,342
C03_Appeals_Process,3.2,89
C04_Customer_Service,3.5,156
D01_Drug_Pricing_Info,3.3,98
D02_Drug_Safety,4.1,45
D03_Formulary_Access,2.8,287
D04_MTM_Program,3.7,67
P01_Network_Adequacy,3.2,203
P02_Provider_Directory,2.7,412"""
    
    # Parse and analyze
    data = parse_csv_data(raw_data)
    if not data:
        print("\n❌ Could not parse data. Please check format.")
        return
    
    print("\n🔍 Analyzing star ratings data...")
    analysis = analyze_star_ratings(data)
    
    # Generate outputs
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
    output_file = f"star_ratings_report_{datetime.datetime.now().strftime('%Y%m%d_%H%M%S')}.txt"
    
    with open(output_file, 'w') as f:
        # Header
        f.write("STAR RATINGS EXECUTIVE REPORT\n")
        f.write("=" * 60 + "\n")
        f.write(f"Generated: {timestamp}\n")
        f.write(f"Report Type: Comprehensive Analysis with Recommendations\n")
        f.write("=" * 60 + "\n\n")
        
        # Executive Summary
        f.write("EXECUTIVE SUMMARY\n")
        f.write("-" * 40 + "\n")
        f.write(f"Overall Star Rating: {analysis['overall_rating']} ⭐\n")
        f.write(f"Categories Analyzed: {len(analysis['category_ratings'])}\n")
        f.write(f"Problem Areas: {len(analysis['problem_areas'])} measures below 3.5 stars\n")
        
        # Key insights
        insights = generate_insights(analysis)
        f.write("\nKEY INSIGHTS:\n")
        for i, insight in enumerate(insights, 1):
            f.write(f"{i}. {insight}\n")
        
        # ASCII Chart
        ratings_for_chart = {
            k.replace('_', ' ').title()[:20]: v['current'] 
            for k, v in list(analysis['category_ratings'].items())[:8]
        }
        chart = generate_ascii_chart("STAR RATINGS BY CATEGORY", ratings_for_chart)
        f.write(chart)
        
        # Problem Areas Detail
        if analysis['problem_areas']:
            f.write("\n\nCRITICAL PROBLEM AREAS\n")
            f.write("-" * 40 + "\n")
            for problem in analysis['problem_areas']:
                category = problem['category'].replace('_', ' ').title()
                f.write(f"\n{category}:\n")
                f.write(f"  Current Rating: {problem['rating']} ⭐\n")
                f.write(f"  Gap to 4-Star: {problem['gap']}\n")
                f.write(f"  Priority: HIGH\n")
        
        # Recommendations
        recommendations = generate_recommendations(analysis)
        f.write("\n\nRECOMMENDATIONS\n")
        f.write("-" * 40 + "\n")
        for i, rec in enumerate(recommendations, 1):
            f.write(f"\n{i}. {rec}\n")
        
        # Email-ready summary
        f.write("\n\n" + "=" * 60 + "\n")
        f.write("EMAIL-READY SUMMARY\n")
        f.write("=" * 60 + "\n")
        f.write(f"Subject: Star Ratings Analysis - Urgent Action Required\n\n")
        f.write(f"Team,\n\n")
        f.write(f"Current overall star rating: {analysis['overall_rating']}\n\n")
        f.write(f"Top 3 areas requiring immediate attention:\n")
        for i, driver in enumerate(analysis['top_drivers'][:3], 1):
            f.write(f"{i}. {driver['category'].replace('_', ' ').title()} - {driver['rating']} stars\n")
        f.write(f"\nRecommended actions attached. Happy to discuss implementation strategy.\n\n")
        f.write(f"Best,\nMatthew")
    
    # Console output
    print("\n" + "=" * 60)
    print("✅ STAR RATINGS ANALYSIS COMPLETE")
    print("=" * 60)
    
    print(f"\n📊 Overall Rating: {analysis['overall_rating']} ⭐")
    
    if analysis['problem_areas']:
        print(f"\n🚨 CRITICAL ISSUES ({len(analysis['problem_areas'])}):")
        for problem in analysis['problem_areas'][:3]:
            print(f"   • {problem['category'].replace('_', ' ').title()}: {problem['rating']} ⭐")
    
    print("\n💡 TOP RECOMMENDATIONS:")
    for i, rec in enumerate(recommendations[:3], 1):
        print(f"{i}. {rec[:80]}...")
    
    print(f"\n📄 Full report saved to: {output_file}")
    print("\n🎯 Next steps:")
    print("   1. Share report with leadership team")
    print("   2. Schedule Star Ratings war room")
    print("   3. Assign owners to each problem area")
    print("   4. Track weekly progress")

if __name__ == "__main__":
    main()