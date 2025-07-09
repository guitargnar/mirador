#!/usr/bin/env python3
"""
Enhanced Mirador Model Configuration Analyzer
Analyzes highest quality runs and extracts model configuration insights even without direct Ollama access.
Focuses on identifying patterns in successful model chains and configurations.
"""

import os
import re
import json
import subprocess
import sys
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Tuple, Optional, Set
import argparse
from dataclasses import dataclass, field
from collections import defaultdict, Counter
import statistics

@dataclass
class ModelUsagePattern:
    """Pattern of model usage in successful chains"""
    model_name: str
    usage_count: int
    avg_quality_score: float
    typical_position: str  # "first", "middle", "last", "solo"
    common_partners: List[str]
    success_rate: float
    temperature_hints: List[float] = field(default_factory=list)

@dataclass
class ChainPattern:
    """Pattern of successful model chains"""
    pattern: str
    frequency: int
    avg_quality: float
    avg_word_count: int
    success_examples: List[str]

@dataclass
class QualityInsight:
    """Insight about what drives quality"""
    factor: str
    correlation: float
    description: str
    examples: List[str]

class EnhancedMiradorAnalyzer:
    def __init__(self, quality_report_path: str, outputs_dir: str = "~/ai_framework_git/outputs/"):
        self.quality_report_path = Path(quality_report_path)
        self.outputs_dir = Path(outputs_dir).expanduser()
        self.high_quality_threshold = 85.0
        
        # Analysis results
        self.chains_data = []
        self.model_patterns = {}
        self.chain_patterns = []
        self.quality_insights = []
        
    def extract_comprehensive_chain_data(self) -> List[Dict]:
        """Extract comprehensive data from quality report"""
        if not self.quality_report_path.exists():
            print(f"❌ Quality report not found: {self.quality_report_path}")
            return []
        
        with open(self.quality_report_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        chains = []
        
        # Extract all chain sections
        chain_sections = re.findall(r'### (chain_\d{8}_\d{6})(.*?)(?=### |$)', content, re.DOTALL)
        
        for chain_id, section_content in chain_sections:
            chain_data = {
                'chain_id': chain_id,
                'quality_score': 0.0,
                'word_count': 0,
                'metrics': {},
                'models': [],
                'temperature_settings': [],
                'key_insights': [],
                'has_structure': False,
                'has_actions': False,
                'timestamp': self._extract_timestamp(chain_id)
            }
            
            # Extract quality score
            score_match = re.search(r'Overall Quality:\*\* ([\d.]+)/100', section_content)
            if score_match:
                chain_data['quality_score'] = float(score_match.group(1))
            
            # Extract word count
            word_match = re.search(r'Word Count: (\d+)', section_content)
            if word_match:
                chain_data['word_count'] = int(word_match.group(1))
            
            # Extract individual metrics
            metrics = {}
            metric_patterns = [
                (r'Readability: ([\d.]+)/100', 'readability'),
                (r'Coherence: ([\d.]+)/100', 'coherence'),
                (r'Completeness: ([\d.]+)/100', 'completeness'),
                (r'Actionability: ([\d.]+)/100', 'actionability'),
                (r'Specificity: ([\d.]+)/100', 'specificity')
            ]
            
            for pattern, metric_name in metric_patterns:
                match = re.search(pattern, section_content)
                if match:
                    metrics[metric_name] = float(match.group(1))
            
            chain_data['metrics'] = metrics
            
            # Extract model information
            models = []
            temperature_settings = []
            
            # Look for model names with version numbers
            model_patterns = [
                r'(\w+_context_provider_v\d+)',
                r'(\w+_expert_v\d+)',
                r'(\w+_enforcer)',
                r'(\w+_simplifier_v\d+)',
                r'(\w+_networker)',
                r'(\w+_instructor)',
                r'(financial_planning_expert_v\d+)',
                r'(louisville_expert_v\d+)',
                r'(music_industry_networker)',
                r'(master_guitar_instructor)',
                r'(decision_simplifier_v\d+)',
                r'(enhanced_agent_enforcer)'
            ]
            
            for pattern in model_patterns:
                matches = re.findall(pattern, section_content, re.IGNORECASE)
                models.extend(matches)
            
            # Look for temperature settings
            temp_matches = re.findall(r'temp=([\d.]+)', section_content)
            temperature_settings.extend([float(t) for t in temp_matches])
            
            chain_data['models'] = list(set(models))  # Remove duplicates
            chain_data['temperature_settings'] = temperature_settings
            
            # Extract key insights
            insights = []
            insight_patterns = [
                r'\*([^*]+)\*\*',  # Bold text
                r'- ([^-\n]+)',    # Bullet points
                r'\d+\. ([^\n]+)' # Numbered lists
            ]
            
            for pattern in insight_patterns:
                matches = re.findall(pattern, section_content)
                insights.extend(matches[:3])  # Limit to avoid noise
            
            chain_data['key_insights'] = insights
            
            # Analyze content characteristics
            chain_data['has_structure'] = bool(re.search(r'\*\*[^*]+\*\*', section_content))
            chain_data['has_actions'] = bool(re.search(r'(action|implement|execute|create|develop)', section_content, re.IGNORECASE))
            
            chains.append(chain_data)
        
        return chains
    
    def _extract_timestamp(self, chain_id: str) -> str:
        """Extract timestamp from chain ID"""
        match = re.search(r'chain_(\d{8}_\d{6})', chain_id)
        return match.group(1) if match else "unknown"
    
    def analyze_model_patterns(self, chains: List[Dict]) -> Dict[str, ModelUsagePattern]:
        """Analyze patterns in model usage"""
        high_quality_chains = [c for c in chains if c['quality_score'] >= self.high_quality_threshold]
        
        model_stats = defaultdict(lambda: {
            'usage_count': 0,
            'quality_scores': [],
            'positions': [],
            'partners': [],
            'temperatures': []
        })
        
        # Collect statistics for each model
        for chain in high_quality_chains:
            models = chain['models']
            quality = chain['quality_score']
            temps = chain['temperature_settings']
            
            for i, model in enumerate(models):
                stats = model_stats[model]
                stats['usage_count'] += 1
                stats['quality_scores'].append(quality)
                stats['temperatures'].extend(temps)
                
                # Determine position
                if len(models) == 1:
                    position = "solo"
                elif i == 0:
                    position = "first"
                elif i == len(models) - 1:
                    position = "last"
                else:
                    position = "middle"
                
                stats['positions'].append(position)
                
                # Track partners (other models in same chain)
                partners = [m for m in models if m != model]
                stats['partners'].extend(partners)
        
        # Create ModelUsagePattern objects
        patterns = {}
        for model, stats in model_stats.items():
            if stats['usage_count'] > 0:
                avg_quality = statistics.mean(stats['quality_scores'])
                typical_position = Counter(stats['positions']).most_common(1)[0][0]
                common_partners = [p[0] for p in Counter(stats['partners']).most_common(3)]
                success_rate = len([q for q in stats['quality_scores'] if q >= self.high_quality_threshold]) / len(stats['quality_scores'])
                
                patterns[model] = ModelUsagePattern(
                    model_name=model,
                    usage_count=stats['usage_count'],
                    avg_quality_score=avg_quality,
                    typical_position=typical_position,
                    common_partners=common_partners,
                    success_rate=success_rate,
                    temperature_hints=stats['temperatures']
                )
        
        return patterns
    
    def analyze_chain_patterns(self, chains: List[Dict]) -> List[ChainPattern]:
        """Analyze successful chain patterns"""
        high_quality_chains = [c for c in chains if c['quality_score'] >= self.high_quality_threshold]
        
        # Group chains by model sequence
        pattern_stats = defaultdict(lambda: {
            'quality_scores': [],
            'word_counts': [],
            'examples': []
        })
        
        for chain in high_quality_chains:
            if chain['models']:
                pattern = ' -> '.join(sorted(chain['models']))
                stats = pattern_stats[pattern]
                stats['quality_scores'].append(chain['quality_score'])
                stats['word_counts'].append(chain['word_count'])
                stats['examples'].append(chain['chain_id'])
        
        # Create ChainPattern objects
        patterns = []
        for pattern, stats in pattern_stats.items():
            if len(stats['examples']) >= 2:  # Only patterns used multiple times
                patterns.append(ChainPattern(
                    pattern=pattern,
                    frequency=len(stats['examples']),
                    avg_quality=statistics.mean(stats['quality_scores']),
                    avg_word_count=int(statistics.mean(stats['word_counts'])),
                    success_examples=stats['examples'][:5]  # Top 5 examples
                ))
        
        return sorted(patterns, key=lambda x: x.frequency, reverse=True)
    
    def analyze_quality_drivers(self, chains: List[Dict]) -> List[QualityInsight]:
        """Analyze what factors drive quality"""
        insights = []
        
        # Analyze correlation between metrics and overall quality
        metric_correlations = {}
        for metric in ['readability', 'coherence', 'completeness', 'actionability', 'specificity']:
            qualities = []
            metric_values = []
            
            for chain in chains:
                if chain['quality_score'] > 0 and metric in chain['metrics']:
                    qualities.append(chain['quality_score'])
                    metric_values.append(chain['metrics'][metric])
            
            if len(qualities) > 10:  # Need sufficient data
                correlation = self._calculate_correlation(qualities, metric_values)
                metric_correlations[metric] = correlation
        
        # Create insights based on correlations
        for metric, correlation in sorted(metric_correlations.items(), key=lambda x: abs(x[1]), reverse=True):
            if abs(correlation) > 0.3:  # Significant correlation
                high_metric_chains = [c for c in chains if c['metrics'].get(metric, 0) > 80]
                examples = [c['chain_id'] for c in high_metric_chains[:3]]
                
                insights.append(QualityInsight(
                    factor=metric.title(),
                    correlation=correlation,
                    description=f"{metric.title()} shows {'strong positive' if correlation > 0.5 else 'moderate positive' if correlation > 0.3 else 'moderate negative'} correlation with overall quality",
                    examples=examples
                ))
        
        # Analyze word count impact
        word_counts = [c['word_count'] for c in chains if c['word_count'] > 0]
        qualities = [c['quality_score'] for c in chains if c['word_count'] > 0]
        
        if len(word_counts) > 10:
            word_correlation = self._calculate_correlation(qualities, word_counts)
            if abs(word_correlation) > 0.2:
                insights.append(QualityInsight(
                    factor="Word Count",
                    correlation=word_correlation,
                    description=f"Word count shows {'positive' if word_correlation > 0 else 'negative'} correlation with quality",
                    examples=[]
                ))
        
        return insights
    
    def _calculate_correlation(self, x: List[float], y: List[float]) -> float:
        """Calculate Pearson correlation coefficient"""
        if len(x) != len(y) or len(x) < 2:
            return 0.0
        
        n = len(x)
        sum_x = sum(x)
        sum_y = sum(y)
        sum_xy = sum(x[i] * y[i] for i in range(n))
        sum_x2 = sum(x[i] ** 2 for i in range(n))
        sum_y2 = sum(y[i] ** 2 for i in range(n))
        
        numerator = n * sum_xy - sum_x * sum_y
        denominator = ((n * sum_x2 - sum_x ** 2) * (n * sum_y2 - sum_y ** 2)) ** 0.5
        
        if denominator == 0:
            return 0.0
        
        return numerator / denominator
    
    def generate_ollama_modelfile_recommendations(self) -> Dict[str, str]:
        """Generate recommended Ollama Modelfile configurations based on successful patterns"""
        recommendations = {}
        
        for model_name, pattern in self.model_patterns.items():
            if pattern.usage_count >= 3:  # Only for frequently used models
                # Determine optimal temperature
                if pattern.temperature_hints:
                    optimal_temp = statistics.median(pattern.temperature_hints)
                else:
                    optimal_temp = 0.7  # Default
                
                # Generate Modelfile content
                modelfile = f"""# Optimized Modelfile for {model_name}
# Based on analysis of {pattern.usage_count} successful runs
# Average quality score: {pattern.avg_quality_score:.1f}/100

FROM llama2  # Replace with your base model

# Optimal parameters based on successful runs
PARAMETER temperature {optimal_temp}
PARAMETER top_p 0.9
PARAMETER top_k 40
PARAMETER repeat_penalty 1.1

# System prompt optimized for {pattern.typical_position} position in chain
SYSTEM \"\"\"You are {model_name}, a specialized AI model optimized for high-quality output generation.

Your role: {self._get_role_description(model_name)}
Position in chain: Typically used in {pattern.typical_position} position
Success rate: {pattern.success_rate:.1%}

Key success factors:
- Focus on {self._get_success_factors(model_name)}
- Maintain high coherence and structure
- Provide actionable insights
- Use specific details and examples

Common partners: {', '.join(pattern.common_partners[:2]) if pattern.common_partners else 'Works well solo'}
\"\"\"
"""
                recommendations[model_name] = modelfile
        
        return recommendations
    
    def _get_role_description(self, model_name: str) -> str:
        """Get role description based on model name"""
        if 'context_provider' in model_name:
            return "providing comprehensive context and background information"
        elif 'expert' in model_name:
            return "providing expert-level analysis and recommendations"
        elif 'enforcer' in model_name:
            return "ensuring quality standards and implementation details"
        elif 'simplifier' in model_name:
            return "simplifying complex information and making decisions clear"
        elif 'networker' in model_name:
            return "identifying networking opportunities and relationship strategies"
        elif 'instructor' in model_name:
            return "providing detailed instruction and skill development guidance"
        else:
            return "specialized analysis and strategic thinking"
    
    def _get_success_factors(self, model_name: str) -> str:
        """Get success factors based on model name"""
        if 'financial' in model_name:
            return "financial accuracy, risk assessment, and practical implementation"
        elif 'music' in model_name:
            return "industry insights, practical advice, and networking opportunities"
        elif 'louisville' in model_name:
            return "local market knowledge, geographic advantages, and community connections"
        elif 'context' in model_name:
            return "comprehensive background, relevant details, and situational awareness"
        else:
            return "clarity, actionability, and specific recommendations"
    
    def run_analysis(self) -> None:
        """Run comprehensive analysis"""
        print("🔍 Running enhanced Mirador model analysis...")
        
        # Extract chain data
        print("📊 Extracting comprehensive chain data...")
        self.chains_data = self.extract_comprehensive_chain_data()
        high_quality_count = len([c for c in self.chains_data if c['quality_score'] >= self.high_quality_threshold])
        
        print(f"✅ Analyzed {len(self.chains_data)} chains, {high_quality_count} high-quality")
        
        # Analyze patterns
        print("🔍 Analyzing model usage patterns...")
        self.model_patterns = self.analyze_model_patterns(self.chains_data)
        
        print("🔗 Analyzing chain patterns...")
        self.chain_patterns = self.analyze_chain_patterns(self.chains_data)
        
        print("💡 Analyzing quality drivers...")
        self.quality_insights = self.analyze_quality_drivers(self.chains_data)
        
        print("✅ Analysis complete!")
    
    def generate_comprehensive_report(self) -> str:
        """Generate comprehensive analysis report"""
        report = []
        report.append("# Enhanced Mirador Model Configuration Analysis")
        report.append(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        report.append(f"Analysis Threshold: {self.high_quality_threshold}/100")
        report.append("")
        
        # Executive Summary
        high_quality_chains = [c for c in self.chains_data if c['quality_score'] >= self.high_quality_threshold]
        if high_quality_chains:
            avg_quality = statistics.mean([c['quality_score'] for c in high_quality_chains])
            avg_words = statistics.mean([c['word_count'] for c in high_quality_chains])
            
            report.append("## Executive Summary")
            report.append(f"- **Total Chains Analyzed:** {len(self.chains_data)}")
            report.append(f"- **High-Quality Chains:** {len(high_quality_chains)} ({len(high_quality_chains)/len(self.chains_data)*100:.1f}%)")
            report.append(f"- **Average Quality Score:** {avg_quality:.1f}/100")
            report.append(f"- **Average Word Count:** {avg_words:.0f}")
            report.append(f"- **Unique Models Identified:** {len(self.model_patterns)}")
            report.append(f"- **Successful Chain Patterns:** {len(self.chain_patterns)}")
            report.append("")
        
        # Model Success Analysis
        report.append("## Model Success Analysis")
        
        top_models = sorted(self.model_patterns.values(), key=lambda x: x.avg_quality_score, reverse=True)
        
        for model in top_models[:10]:
            report.append(f"### {model.model_name}")
            report.append(f"- **Usage Count:** {model.usage_count} chains")
            report.append(f"- **Average Quality:** {model.avg_quality_score:.1f}/100")
            report.append(f"- **Success Rate:** {model.success_rate:.1%}")
            report.append(f"- **Typical Position:** {model.typical_position}")
            
            if model.common_partners:
                report.append(f"- **Common Partners:** {', '.join(model.common_partners)}")
            
            if model.temperature_hints:
                avg_temp = statistics.mean(model.temperature_hints)
                report.append(f"- **Optimal Temperature:** {avg_temp:.2f}")
            
            report.append("")
        
        # Chain Pattern Analysis
        report.append("## Successful Chain Patterns")
        
        for pattern in self.chain_patterns[:10]:
            report.append(f"### {pattern.pattern}")
            report.append(f"- **Frequency:** {pattern.frequency} uses")
            report.append(f"- **Average Quality:** {pattern.avg_quality:.1f}/100")
            report.append(f"- **Average Word Count:** {pattern.avg_word_count}")
            report.append(f"- **Examples:** {', '.join(pattern.success_examples[:3])}")
            report.append("")
        
        # Quality Driver Analysis
        report.append("## Quality Driver Analysis")
        
        for insight in self.quality_insights:
            report.append(f"### {insight.factor}")
            report.append(f"- **Correlation:** {insight.correlation:.3f}")
            report.append(f"- **Impact:** {insight.description}")
            if insight.examples:
                report.append(f"- **Examples:** {', '.join(insight.examples)}")
            report.append("")
        
        # Ollama Configuration Recommendations
        report.append("## Ollama Modelfile Recommendations")
        
        modelfile_recommendations = self.generate_ollama_modelfile_recommendations()
        
        for model_name, modelfile in modelfile_recommendations.items():
            report.append(f"### {model_name}")
            report.append("```dockerfile")
            report.append(modelfile)
            report.append("```")
            report.append("")
        
        # Actionable Insights
        report.append("## Actionable Insights & Recommendations")
        
        if top_models:
            best_model = top_models[0]
            report.append(f"1. **Prioritize {best_model.model_name}** - Highest average quality ({best_model.avg_quality_score:.1f}/100)")
        
        if self.chain_patterns:
            best_pattern = self.chain_patterns[0]
            report.append(f"2. **Use pattern: {best_pattern.pattern}** - Most successful combination ({best_pattern.frequency} uses)")
        
        # Temperature recommendations
        all_temps = []
        for model in self.model_patterns.values():
            all_temps.extend(model.temperature_hints)
        
        if all_temps:
            optimal_temp = statistics.median(all_temps)
            report.append(f"3. **Optimal Temperature Setting: {optimal_temp:.2f}** - Based on successful runs")
        
        # Quality factor recommendations
        top_quality_factor = max(self.quality_insights, key=lambda x: abs(x.correlation)) if self.quality_insights else None
        if top_quality_factor:
            report.append(f"4. **Focus on {top_quality_factor.factor}** - Strongest correlation with quality ({top_quality_factor.correlation:.3f})")
        
        report.append("")
        report.append("## Implementation Guide")
        report.append("1. **Model Selection:** Use the highest-performing models identified above")
        report.append("2. **Chain Configuration:** Implement the most successful chain patterns")
        report.append("3. **Parameter Tuning:** Apply the recommended temperature and parameter settings")
        report.append("4. **Quality Focus:** Prioritize the quality factors with highest correlation")
        report.append("5. **Monitoring:** Track performance against these benchmarks")
        
        return "\n".join(report)
    
    def save_report(self, filename: str = None) -> str:
        """Save analysis report"""
        if filename is None:
            timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
            filename = f"enhanced_model_analysis_{timestamp}.md"
        
        report_content = self.generate_comprehensive_report()
        
        with open(filename, 'w', encoding='utf-8') as f:
            f.write(report_content)
        
        return filename
    
    def print_summary(self) -> None:
        """Print executive summary"""
        print("\n" + "="*80)
        print("🚀 ENHANCED MIRADOR MODEL ANALYSIS SUMMARY")
        print("="*80)
        
        high_quality_chains = [c for c in self.chains_data if c['quality_score'] >= self.high_quality_threshold]
        
        if high_quality_chains:
            avg_quality = statistics.mean([c['quality_score'] for c in high_quality_chains])
            print(f"📊 High-Quality Chains: {len(high_quality_chains)}/{len(self.chains_data)} ({len(high_quality_chains)/len(self.chains_data)*100:.1f}%)")
            print(f"📈 Average Quality: {avg_quality:.1f}/100")
        
        # Top performing model
        if self.model_patterns:
            top_model = max(self.model_patterns.values(), key=lambda x: x.avg_quality_score)
            print(f"🏆 Top Model: {top_model.model_name} ({top_model.avg_quality_score:.1f}/100, {top_model.usage_count} uses)")
        
        # Most successful pattern
        if self.chain_patterns:
            top_pattern = self.chain_patterns[0]
            print(f"🔗 Best Pattern: {top_pattern.pattern} ({top_pattern.frequency} uses, {top_pattern.avg_quality:.1f}/100)")
        
        # Key insight
        if self.quality_insights:
            top_insight = max(self.quality_insights, key=lambda x: abs(x.correlation))
            print(f"💡 Key Insight: {top_insight.factor} has strongest correlation ({top_insight.correlation:.3f})")
        
        print(f"⚙️  Models Analyzed: {len(self.model_patterns)}")
        print(f"🔍 Chain Patterns Found: {len(self.chain_patterns)}")
        print("="*80)

def main():
    parser = argparse.ArgumentParser(description="Enhanced Mirador model configuration analysis")
    parser.add_argument("quality_report", help="Path to quality report markdown file")
    parser.add_argument("--outputs-dir", "-d", default="~/ai_framework_git/outputs/", 
                       help="Path to Mirador outputs directory")
    parser.add_argument("--threshold", "-t", type=float, default=85.0,
                       help="Quality threshold for analysis (default: 85.0)")
    parser.add_argument("--save-report", "-s", metavar="FILENAME", 
                       help="Save detailed report to file")
    parser.add_argument("--summary", action="store_true", default=True,
                       help="Show summary (default)")
    
    args = parser.parse_args()
    
    # Create analyzer
    analyzer = EnhancedMiradorAnalyzer(args.quality_report, args.outputs_dir)
    analyzer.high_quality_threshold = args.threshold
    
    # Run analysis
    analyzer.run_analysis()
    
    # Generate report if requested
    if args.save_report:
        filename = analyzer.save_report(args.save_report)
        print(f"📄 Enhanced analysis report saved to: {filename}")
    
    # Show summary
    if args.summary:
        analyzer.print_summary()

if __name__ == "__main__":
    main()

