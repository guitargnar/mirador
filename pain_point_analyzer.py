#!/usr/bin/env python3
"""
Pain Point Analyzer for Humana Advocates Program
Analyzes patterns, tracks evidence, and identifies systemic issues
"""

import os
import json
import re
from datetime import datetime, timedelta
from typing import Dict, List, Tuple, Optional
from collections import defaultdict, Counter
import sqlite3

from advocates_program import AdvocatesProgram
from enhanced_mirador import run_enhanced_chain


class PainPointAnalyzer:
    """
    Advanced analysis of pain points to identify patterns and root causes
    """
    
    def __init__(self):
        self.advocates = AdvocatesProgram()
        self.analysis_cache = {}
        
        # Pain point patterns from documentation
        self.known_patterns = {
            "tool_restriction_workaround": {
                "indicators": ["personal device", "shadow it", "workaround", "restriction"],
                "root_cause": "Excessive security controls without considering productivity",
                "impact": "Forces associates to find unsafe alternatives"
            },
            "communication_breakdown": {
                "indicators": ["unclear", "confusing", "diluted", "don't understand"],
                "root_cause": "Multiple layers of management filtering messages",
                "impact": "Associates don't know what's actually expected"
            },
            "innovation_suppression": {
                "indicators": ["can't innovate", "not allowed", "blocked", "restricted"],
                "root_cause": "Risk-averse culture prioritizing control over trust",
                "impact": "Associates build solutions in secret or leave"
            },
            "bureaucratic_paralysis": {
                "indicators": ["approval", "process", "slow", "bureaucratic"],
                "root_cause": "Processes designed for control, not efficiency",
                "impact": "Simple tasks take weeks, innovation dies"
            },
            "recognition_gap": {
                "indicators": ["not recognized", "no credit", "invisible", "undervalued"],
                "root_cause": "Performance systems that reward visibility over value",
                "impact": "High performers leave or disengage"
            }
        }
        
    def analyze_pain_points(self, timeframe_days: int = 90) -> Dict:
        """
        Comprehensive analysis of pain points to identify systemic issues
        """
        threshold = datetime.now() - timedelta(days=timeframe_days)
        
        # Get all pain points
        pain_points = self.advocates.conn.execute("""
            SELECT * FROM pain_points
            WHERE created_at > ?
            ORDER BY upvotes DESC, impact_level DESC
        """, [threshold]).fetchall()
        
        analysis = {
            "total_reports": len(pain_points),
            "patterns_detected": {},
            "root_causes": defaultdict(list),
            "department_analysis": defaultdict(lambda: {"count": 0, "categories": []}),
            "impact_distribution": Counter(),
            "evidence_strength": {},
            "recommendations": []
        }
        
        # Analyze each pain point
        for point in pain_points:
            point_dict = dict(point)
            
            # Pattern detection
            patterns = self._detect_patterns(point_dict['description'])
            for pattern_name, pattern_data in patterns.items():
                if pattern_name not in analysis["patterns_detected"]:
                    analysis["patterns_detected"][pattern_name] = {
                        "count": 0,
                        "examples": [],
                        "root_cause": pattern_data["root_cause"],
                        "impact": pattern_data["impact"]
                    }
                analysis["patterns_detected"][pattern_name]["count"] += 1
                analysis["patterns_detected"][pattern_name]["examples"].append(
                    point_dict['description'][:100] + "..."
                )
                
            # Department analysis
            dept = point_dict['department'] or 'unknown'
            analysis["department_analysis"][dept]["count"] += 1
            analysis["department_analysis"][dept]["categories"].append(point_dict['category'])
            
            # Impact distribution
            analysis["impact_distribution"][point_dict['impact_level']] += 1
            
            # Check evidence strength
            evidence_count = self.advocates.conn.execute("""
                SELECT COUNT(*) as count FROM evidence
                WHERE pain_point_id = ?
            """, [point_dict['id']]).fetchone()['count']
            
            if evidence_count > 0:
                analysis["evidence_strength"][point_dict['id']] = {
                    "description": point_dict['description'][:100],
                    "evidence_count": evidence_count,
                    "strength": "strong" if evidence_count >= 3 else "moderate"
                }
                
        # Generate recommendations
        analysis["recommendations"] = self._generate_recommendations(analysis)
        
        return analysis
        
    def _detect_patterns(self, description: str) -> Dict:
        """Detect known patterns in pain point descriptions"""
        description_lower = description.lower()
        detected = {}
        
        for pattern_name, pattern_data in self.known_patterns.items():
            if any(indicator in description_lower for indicator in pattern_data["indicators"]):
                detected[pattern_name] = pattern_data
                
        return detected
        
    def _generate_recommendations(self, analysis: Dict) -> List[Dict]:
        """Generate actionable recommendations based on analysis"""
        recommendations = []
        
        # Check for tool restriction pattern
        if "tool_restriction_workaround" in analysis["patterns_detected"]:
            count = analysis["patterns_detected"]["tool_restriction_workaround"]["count"]
            recommendations.append({
                "priority": "high",
                "category": "technology",
                "recommendation": f"Create 'Innovation Zones' with relaxed restrictions",
                "rationale": f"{count} reports show associates working around restrictions",
                "evidence": "Mirador proves associates innovate responsibly when trusted",
                "quick_win": "Pilot with 50 high performers for 90 days"
            })
            
        # Check for communication breakdown
        if "communication_breakdown" in analysis["patterns_detected"]:
            recommendations.append({
                "priority": "high",
                "category": "communication",
                "recommendation": "Implement direct leader-to-associate channels",
                "rationale": "Messages lose meaning through management layers",
                "evidence": "Associates report confusion about actual priorities",
                "quick_win": "Monthly skip-level sessions with clear action items"
            })
            
        # Check for high-impact unaddressed issues
        critical_unaddressed = self.advocates.conn.execute("""
            SELECT COUNT(*) as count FROM pain_points
            WHERE impact_level = 'critical' 
            AND status = 'reported'
            AND id NOT IN (SELECT pain_point_id FROM solutions WHERE pain_point_id IS NOT NULL)
        """).fetchone()['count']
        
        if critical_unaddressed > 0:
            recommendations.append({
                "priority": "critical",
                "category": "process",
                "recommendation": "Fast-track critical pain point resolution",
                "rationale": f"{critical_unaddressed} critical issues remain unaddressed",
                "evidence": "High-impact problems persist without solutions",
                "quick_win": "Create rapid response team for critical issues"
            })
            
        return recommendations
        
    def track_evidence(self, pain_point_id: int, evidence_type: str, 
                      data: Dict, auto_analyze: bool = True) -> Dict:
        """
        Track evidence with automatic analysis
        """
        # Store the evidence
        evidence_id = self.advocates.add_evidence(
            pain_point_id,
            evidence_type,
            data.get('description', 'Auto-generated evidence'),
            data,
            data.get('file_path')
        )
        
        result = {
            "evidence_id": evidence_id,
            "pain_point_id": pain_point_id,
            "type": evidence_type
        }
        
        # Auto-analyze if requested
        if auto_analyze:
            analysis = self._analyze_evidence_impact(pain_point_id)
            result["impact_analysis"] = analysis
            
        return result
        
    def _analyze_evidence_impact(self, pain_point_id: int) -> Dict:
        """Analyze the impact of evidence for a pain point"""
        # Get all evidence
        evidence = self.advocates.conn.execute("""
            SELECT * FROM evidence
            WHERE pain_point_id = ?
        """, [pain_point_id]).fetchall()
        
        impact = {
            "evidence_count": len(evidence),
            "evidence_types": Counter(),
            "strength_score": 0,
            "credibility": "low"
        }
        
        for e in evidence:
            impact["evidence_types"][e['evidence_type']] += 1
            
            # Score different evidence types
            if e['evidence_type'] == 'metric':
                impact["strength_score"] += 3
            elif e['evidence_type'] == 'example':
                impact["strength_score"] += 2
            elif e['evidence_type'] == 'testimony':
                impact["strength_score"] += 1
                
        # Determine credibility
        if impact["strength_score"] >= 10:
            impact["credibility"] = "very_high"
        elif impact["strength_score"] >= 7:
            impact["credibility"] = "high"
        elif impact["strength_score"] >= 4:
            impact["credibility"] = "moderate"
            
        return impact
        
    def find_systemic_issues(self) -> List[Dict]:
        """
        Identify systemic issues across multiple pain points
        """
        # Look for pain points with similar descriptions
        all_points = self.advocates.conn.execute("""
            SELECT id, description, category, impact_level, upvotes
            FROM pain_points
            WHERE status != 'resolved'
            ORDER BY created_at DESC
            LIMIT 1000
        """).fetchall()
        
        # Group by similarity
        clusters = self._cluster_similar_issues(all_points)
        
        systemic_issues = []
        for cluster in clusters:
            if len(cluster) >= 3:  # At least 3 similar reports
                # This is likely systemic
                total_upvotes = sum(p['upvotes'] for p in cluster)
                
                systemic_issues.append({
                    "issue_type": "systemic_pattern",
                    "affected_count": len(cluster),
                    "total_upvotes": total_upvotes,
                    "categories": list(set(p['category'] for p in cluster)),
                    "sample_descriptions": [p['description'][:100] for p in cluster[:3]],
                    "recommendation": self._generate_systemic_recommendation(cluster)
                })
                
        return systemic_issues
        
    def _cluster_similar_issues(self, pain_points: List[sqlite3.Row]) -> List[List[Dict]]:
        """Cluster similar pain points"""
        clusters = []
        processed = set()
        
        for i, point1 in enumerate(pain_points):
            if i in processed:
                continue
                
            cluster = [dict(point1)]
            processed.add(i)
            
            # Find similar points
            for j, point2 in enumerate(pain_points[i+1:], i+1):
                if j in processed:
                    continue
                    
                similarity = self._calculate_similarity(
                    point1['description'], 
                    point2['description']
                )
                
                if similarity > 0.6:  # 60% similarity threshold
                    cluster.append(dict(point2))
                    processed.add(j)
                    
            if len(cluster) > 1:
                clusters.append(cluster)
                
        return clusters
        
    def _calculate_similarity(self, text1: str, text2: str) -> float:
        """Simple similarity calculation"""
        words1 = set(text1.lower().split())
        words2 = set(text2.lower().split())
        
        intersection = words1 & words2
        union = words1 | words2
        
        return len(intersection) / len(union) if union else 0
        
    def _generate_systemic_recommendation(self, cluster: List[Dict]) -> str:
        """Generate recommendation for systemic issue"""
        categories = [p['category'] for p in cluster]
        most_common_category = Counter(categories).most_common(1)[0][0]
        
        recommendations = {
            "technology_access": "Implement technology governance board with associate representation",
            "communication": "Redesign communication cascade with direct channels",
            "operational": "Create process improvement team with frontline authority",
            "culture": "Launch trust-based pilot programs with measurable outcomes",
            "innovation": "Establish innovation labs with reduced restrictions"
        }
        
        return recommendations.get(most_common_category, 
                                  "Conduct root cause analysis with affected associates")
        
    def generate_evidence_report(self, output_format: str = "markdown") -> str:
        """Generate comprehensive evidence report"""
        analysis = self.analyze_pain_points()
        systemic = self.find_systemic_issues()
        
        if output_format == "markdown":
            report = f"""# Pain Point Evidence Report
Generated: {datetime.now().strftime('%Y-%m-%d %H:%M')}

## Executive Summary

- **Total Pain Points Reported**: {analysis['total_reports']}
- **Systemic Issues Identified**: {len(systemic)}
- **Patterns Detected**: {len(analysis['patterns_detected'])}
- **Critical Recommendations**: {len([r for r in analysis['recommendations'] if r['priority'] == 'critical'])}

## Impact Distribution

"""
            for impact, count in analysis['impact_distribution'].items():
                percentage = (count / analysis['total_reports']) * 100
                report += f"- **{impact.title()}**: {count} ({percentage:.1f}%)\n"
                
            report += "\n## Detected Patterns\n\n"
            
            for pattern_name, pattern_data in analysis['patterns_detected'].items():
                report += f"### {pattern_name.replace('_', ' ').title()}\n"
                report += f"- **Occurrences**: {pattern_data['count']}\n"
                report += f"- **Root Cause**: {pattern_data['root_cause']}\n"
                report += f"- **Impact**: {pattern_data['impact']}\n"
                report += f"- **Example**: {pattern_data['examples'][0]}\n\n"
                
            report += "## Systemic Issues\n\n"
            
            for issue in systemic[:5]:  # Top 5 systemic issues
                report += f"### Pattern Affecting {issue['affected_count']} Associates\n"
                report += f"- **Total Upvotes**: {issue['total_upvotes']}\n"
                report += f"- **Categories**: {', '.join(issue['categories'])}\n"
                report += f"- **Recommendation**: {issue['recommendation']}\n\n"
                
            report += "## Priority Recommendations\n\n"
            
            for rec in sorted(analysis['recommendations'], 
                            key=lambda x: {'critical': 0, 'high': 1, 'medium': 2}[x['priority']]):
                report += f"### {rec['priority'].upper()}: {rec['recommendation']}\n"
                report += f"- **Rationale**: {rec['rationale']}\n"
                report += f"- **Evidence**: {rec['evidence']}\n"
                report += f"- **Quick Win**: {rec['quick_win']}\n\n"
                
            # Add Mirador as proof
            report += """## Proof of Concept: Mirador

Mirador demonstrates what happens when associates are trusted:

- **Problem**: Tool restrictions limiting productivity
- **Solution**: Associate-built AI orchestration framework
- **Result**: 30+ hours/week saved, zero security incidents
- **Lesson**: Trust + Tools = Innovation

This is not an isolated case. Given the opportunity, associates will solve their own problems better than any vendor.
"""
            
            return report
            
        else:
            return json.dumps({
                "analysis": analysis,
                "systemic_issues": systemic,
                "generated_at": datetime.now().isoformat()
            }, indent=2)
            
    def track_solution_impact(self, solution_id: int, metrics: Dict) -> Dict:
        """Track the real impact of implemented solutions"""
        # Get the solution
        solution = self.advocates.conn.execute("""
            SELECT * FROM solutions WHERE id = ?
        """, [solution_id]).fetchone()
        
        if not solution:
            return {"error": "Solution not found"}
            
        # Update metrics
        self.advocates.conn.execute("""
            UPDATE solutions
            SET time_saved_hours = ?,
                cost_saved = ?,
                adoption_count = ?
            WHERE id = ?
        """, [
            metrics.get('hours_saved', solution['time_saved_hours']),
            metrics.get('cost_saved', solution['cost_saved']),
            metrics.get('adoption_count', solution['adoption_count']),
            solution_id
        ])
        self.advocates.conn.commit()
        
        # Add as evidence if significant
        if metrics.get('hours_saved', 0) > 10:
            self.track_evidence(
                solution['pain_point_id'],
                'solution_impact',
                {
                    'description': f"Solution '{solution['title']}' proven impact",
                    'hours_saved': metrics['hours_saved'],
                    'cost_saved': metrics.get('cost_saved', 0),
                    'adoption': metrics.get('adoption_count', 0)
                }
            )
            
        return {
            "solution_id": solution_id,
            "impact_tracked": True,
            "significant_impact": metrics.get('hours_saved', 0) > 10
        }


# Real-world evidence collection functions
def collect_mirador_evidence(analyzer: PainPointAnalyzer):
    """Collect evidence from Mirador usage"""
    from metrics_tracker import MetricsTracker
    
    tracker = MetricsTracker()
    metrics = tracker.get_aggregate_metrics(days=30)
    
    # Find or create pain point for tool restrictions
    pain_points = analyzer.advocates.search_similar_pain_points(
        "tool restrictions limit productivity"
    )
    
    if pain_points:
        pain_id = pain_points[0]['id']
    else:
        pain_id = analyzer.advocates.report_pain_point(
            "Tool restrictions force associates to use personal devices and time for innovation",
            category="technology_access",
            impact="high",
            frequency="constant"
        )
        
    # Add Mirador metrics as evidence
    analyzer.track_evidence(
        pain_id,
        'metric',
        {
            'description': 'Mirador usage metrics prove productivity gains',
            'total_executions': metrics['total_executions'],
            'hours_saved': metrics['total_hours_saved'],
            'success_rate': metrics['success_rate'],
            'roi_multiplier': metrics['roi_multiplier']
        }
    )
    
    # Add specific example
    analyzer.track_evidence(
        pain_id,
        'example',
        {
            'description': 'Associate built Mirador on personal time to work around restrictions',
            'time_to_build': '6 months personal time',
            'cost': '$0',
            'value_created': f"${metrics.get('estimated_cost_savings', 0):,.2f}"
        }
    )
    
    print(f"✅ Collected Mirador evidence for pain point {pain_id}")


# CLI interface
if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Pain Point Analyzer")
    parser.add_argument('command', choices=['analyze', 'evidence', 'systemic', 'report', 'collect'],
                       help='Command to execute')
    parser.add_argument('--days', type=int, default=90, help='Timeframe for analysis')
    parser.add_argument('--format', choices=['markdown', 'json'], default='markdown')
    
    args = parser.parse_args()
    
    analyzer = PainPointAnalyzer()
    
    if args.command == 'analyze':
        analysis = analyzer.analyze_pain_points(timeframe_days=args.days)
        
        print(f"\n📊 Pain Point Analysis (Last {args.days} Days)\n")
        print(f"Total Reports: {analysis['total_reports']}")
        print(f"Patterns Detected: {len(analysis['patterns_detected'])}")
        
        print("\nTop Patterns:")
        for pattern, data in list(analysis['patterns_detected'].items())[:3]:
            print(f"  - {pattern}: {data['count']} occurrences")
            print(f"    Root Cause: {data['root_cause']}")
            
    elif args.command == 'systemic':
        issues = analyzer.find_systemic_issues()
        
        print(f"\n🔍 Systemic Issues Identified: {len(issues)}\n")
        
        for i, issue in enumerate(issues[:5], 1):
            print(f"{i}. Pattern affecting {issue['affected_count']} associates")
            print(f"   Total upvotes: {issue['total_upvotes']}")
            print(f"   Recommendation: {issue['recommendation']}")
            print()
            
    elif args.command == 'report':
        report = analyzer.generate_evidence_report(output_format=args.format)
        
        filename = f"pain_point_report_{datetime.now().strftime('%Y%m%d_%H%M%S')}.{args.format}"
        with open(filename, 'w') as f:
            f.write(report)
            
        print(f"✅ Report generated: {filename}")
        
    elif args.command == 'collect':
        # Collect evidence from various sources
        print("🔄 Collecting evidence...")
        
        # Collect Mirador evidence
        collect_mirador_evidence(analyzer)
        
        print("\n✅ Evidence collection complete")
        
    elif args.command == 'evidence':
        # Interactive evidence collection
        pain_id = int(input("Pain point ID: "))
        evidence_type = input("Evidence type (metric/example/testimony): ")
        description = input("Description: ")
        
        # Collect additional data based on type
        data = {'description': description}
        
        if evidence_type == 'metric':
            value = input("Metric value: ")
            unit = input("Unit (hours/dollars/percent): ")
            data['value'] = value
            data['unit'] = unit
            
        result = analyzer.track_evidence(pain_id, evidence_type, data)
        print(f"\n✅ Evidence tracked: {result}")