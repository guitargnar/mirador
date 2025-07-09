#!/usr/bin/env python3
"""
Quality Assurance System for Mirador
Validates AI outputs for accuracy, completeness, and actionability
"""

import re
import json
from typing import List, Dict, Tuple, Optional
from datetime import datetime
import difflib

class QualityAssurance:
    """Comprehensive quality analysis and validation for AI outputs"""
    
    def __init__(self):
        self.validation_rules = self._load_validation_rules()
        self.fact_patterns = self._load_fact_patterns()
        
    def _load_validation_rules(self) -> Dict:
        """Load validation rules for different output types"""
        return {
            'action_items': {
                'required_sections': ['immediate_actions', 'short_term', 'long_term'],
                'min_items_per_section': 1,
                'max_items_per_section': 5,
                'item_pattern': r'^\d+\.\s+\[.*?\]\s+-\s+.+$'  # Format: "1. [Category] - Action"
            },
            'analysis': {
                'required_sections': ['summary', 'findings', 'recommendations'],
                'min_word_count': 100,
                'max_word_count': 2000
            },
            'risk_assessment': {
                'required_sections': ['risks', 'impact', 'mitigation'],
                'risk_levels': ['low', 'medium', 'high', 'critical'],
                'requires_metrics': True
            }
        }
        
    def _load_fact_patterns(self) -> Dict:
        """Load patterns for fact checking"""
        return {
            'dates': {
                'pattern': r'\b(19|20)\d{2}(-\d{2}-\d{2})?\b',
                'validator': self._validate_date
            },
            'percentages': {
                'pattern': r'\b\d{1,3}(?:\.\d{1,2})?%\b',
                'validator': self._validate_percentage
            },
            'dollars': {
                'pattern': r'\$[\d,]+(?:\.\d{2})?[MKB]?\b',
                'validator': self._validate_currency
            },
            'time_estimates': {
                'pattern': r'\b\d+\s*(hours?|days?|weeks?|months?)\b',
                'validator': self._validate_time_estimate
            }
        }
        
    def analyze_output(self, text: str, output_type: str = 'general', 
                      context: Dict = None) -> Dict:
        """Comprehensive quality analysis of AI output"""
        scores = {}
        errors = []
        warnings = []
        
        # 1. Structure validation
        structure_result = self._validate_structure(text, output_type)
        scores['structure_score'] = structure_result['score']
        errors.extend(structure_result['errors'])
        
        # 2. Content quality
        content_result = self._assess_content_quality(text)
        scores['content_score'] = content_result['score']
        warnings.extend(content_result['warnings'])
        
        # 3. Actionability check
        actionability_result = self._check_actionability(text)
        scores['actionability_score'] = actionability_result['score']
        
        # 4. Fact verification
        fact_result = self._verify_facts(text, context)
        scores['factual_accuracy'] = fact_result['score']
        errors.extend(fact_result['errors'])
        
        # 5. Consistency check
        consistency_result = self._check_consistency(text)
        scores['consistency_score'] = consistency_result['score']
        warnings.extend(consistency_result['warnings'])
        
        # 6. Completeness check
        completeness_result = self._check_completeness(text, output_type)
        scores['completeness_score'] = completeness_result['score']
        errors.extend(completeness_result['errors'])
        
        # Calculate overall quality score
        scores['overall_quality'] = sum(scores.values()) / len(scores) if scores else 0
        
        # Determine if output passes quality threshold
        passed = (scores['overall_quality'] >= 80 and 
                 len([e for e in errors if e['severity'] == 'critical']) == 0)
        
        return {
            'scores': scores,
            'errors': errors,
            'warnings': warnings,
            'passed': passed,
            'recommendations': self._generate_recommendations(scores, errors)
        }
        
    def _validate_structure(self, text: str, output_type: str) -> Dict:
        """Validate output structure based on type"""
        errors = []
        score = 100
        
        if output_type in self.validation_rules:
            rules = self.validation_rules[output_type]
            
            # Check required sections
            if 'required_sections' in rules:
                for section in rules['required_sections']:
                    section_pattern = rf'#*\s*{section}.*?:?\s*\n'
                    if not re.search(section_pattern, text, re.IGNORECASE):
                        errors.append({
                            'type': 'missing_section',
                            'message': f"Missing required section: {section}",
                            'severity': 'high'
                        })
                        score -= 20
                        
            # Check word count
            word_count = len(text.split())
            if 'min_word_count' in rules and word_count < rules['min_word_count']:
                errors.append({
                    'type': 'insufficient_content',
                    'message': f"Content too short: {word_count} words (minimum: {rules['min_word_count']})",
                    'severity': 'medium'
                })
                score -= 15
                
        return {'score': max(0, score), 'errors': errors}
        
    def _assess_content_quality(self, text: str) -> Dict:
        """Assess the quality of content"""
        warnings = []
        score = 100
        
        # Check for vague language
        vague_phrases = [
            'might be', 'could be', 'possibly', 'maybe', 'perhaps',
            'somewhat', 'kind of', 'sort of', 'probably'
        ]
        
        vague_count = sum(1 for phrase in vague_phrases if phrase in text.lower())
        if vague_count > 3:
            warnings.append({
                'type': 'vague_language',
                'message': f"Too much vague language detected ({vague_count} instances)",
                'severity': 'low'
            })
            score -= vague_count * 2
            
        # Check for actionable language
        action_verbs = [
            'create', 'implement', 'develop', 'analyze', 'review',
            'update', 'configure', 'deploy', 'test', 'validate'
        ]
        
        action_count = sum(1 for verb in action_verbs if verb in text.lower())
        if action_count < 3:
            warnings.append({
                'type': 'low_actionability',
                'message': "Output lacks actionable language",
                'severity': 'medium'
            })
            score -= 10
            
        # Check for specificity
        specific_indicators = [
            r'\d+\s*(hours?|days?|weeks?)',  # Time estimates
            r'\d+%',  # Percentages
            r'\$\d+',  # Dollar amounts
            r'step\s+\d+',  # Numbered steps
            r'\d{4}-\d{2}-\d{2}'  # Dates
        ]
        
        specificity_count = sum(1 for pattern in specific_indicators 
                               if re.search(pattern, text))
        if specificity_count < 2:
            warnings.append({
                'type': 'lack_of_specificity',
                'message': "Output lacks specific metrics or timeframes",
                'severity': 'medium'
            })
            score -= 15
            
        return {'score': max(0, score), 'warnings': warnings}
        
    def _check_actionability(self, text: str) -> Dict:
        """Check if output contains actionable items"""
        score = 100
        
        # Look for action item patterns
        action_patterns = [
            r'^\s*[-•]\s+.+',  # Bullet points
            r'^\s*\d+\.\s+.+',  # Numbered lists
            r'^\s*\[.+\]\s*-\s*.+',  # Bracketed categories
            r'Action:\s*.+',  # Explicit actions
            r'Next\s+[Ss]teps?:\s*.+'  # Next steps section
        ]
        
        action_items = []
        lines = text.split('\n')
        
        for line in lines:
            for pattern in action_patterns:
                if re.match(pattern, line):
                    action_items.append(line.strip())
                    break
                    
        if len(action_items) == 0:
            score = 0
        elif len(action_items) < 3:
            score = 50
            
        return {
            'score': score,
            'action_items': action_items,
            'count': len(action_items)
        }
        
    def _verify_facts(self, text: str, context: Dict = None) -> Dict:
        """Verify factual claims in the output"""
        errors = []
        score = 100
        
        for fact_type, checker in self.fact_patterns.items():
            pattern = checker['pattern']
            validator = checker['validator']
            
            matches = re.findall(pattern, text)
            for match in matches:
                if not validator(match, context):
                    errors.append({
                        'type': f'invalid_{fact_type}',
                        'message': f"Suspicious {fact_type}: {match}",
                        'severity': 'high'
                    })
                    score -= 10
                    
        return {'score': max(0, score), 'errors': errors}
        
    def _validate_date(self, date_str: str, context: Dict = None) -> bool:
        """Validate date is reasonable"""
        try:
            year = int(date_str[:4])
            current_year = datetime.now().year
            
            # Allow dates from 1900 to 5 years in future
            return 1900 <= year <= current_year + 5
        except:
            return False
            
    def _validate_percentage(self, percentage_str: str, context: Dict = None) -> bool:
        """Validate percentage is within valid range"""
        try:
            value = float(percentage_str.rstrip('%'))
            return 0 <= value <= 100
        except:
            return False
            
    def _validate_currency(self, currency_str: str, context: Dict = None) -> bool:
        """Validate currency amounts are reasonable"""
        try:
            # Remove $ and suffixes
            value_str = currency_str.lstrip('$').rstrip('MKB')
            value = float(value_str.replace(',', ''))
            
            # Check for multipliers
            if currency_str.endswith('K'):
                value *= 1000
            elif currency_str.endswith('M'):
                value *= 1000000
            elif currency_str.endswith('B'):
                value *= 1000000000
                
            # Reasonable bounds for business context
            return 0 < value < 1000000000000  # Less than 1 trillion
        except:
            return False
            
    def _validate_time_estimate(self, time_str: str, context: Dict = None) -> bool:
        """Validate time estimates are reasonable"""
        try:
            match = re.match(r'(\d+)\s*(\w+)', time_str)
            if match:
                value = int(match.group(1))
                unit = match.group(2).lower()
                
                # Reasonable bounds
                bounds = {
                    'hour': (1, 168),  # 1 hour to 1 week
                    'day': (1, 365),   # 1 day to 1 year
                    'week': (1, 52),   # 1 week to 1 year
                    'month': (1, 36)   # 1 month to 3 years
                }
                
                for key, (min_val, max_val) in bounds.items():
                    if unit.startswith(key):
                        return min_val <= value <= max_val
                        
            return False
        except:
            return False
            
    def _check_consistency(self, text: str) -> Dict:
        """Check for internal consistency"""
        warnings = []
        score = 100
        
        # Check for contradictions
        lines = text.split('\n')
        
        # Simple contradiction detection
        for i, line1 in enumerate(lines):
            for j, line2 in enumerate(lines[i+1:], i+1):
                similarity = difflib.SequenceMatcher(None, line1, line2).ratio()
                
                # If lines are similar but contain opposite terms
                if 0.5 < similarity < 0.9:
                    if any(word in line1.lower() and opposite in line2.lower() 
                          for word, opposite in [
                              ('increase', 'decrease'),
                              ('high', 'low'),
                              ('success', 'failure'),
                              ('positive', 'negative')
                          ]):
                        warnings.append({
                            'type': 'potential_contradiction',
                            'message': f"Potential contradiction between lines {i+1} and {j+1}",
                            'severity': 'medium'
                        })
                        score -= 10
                        
        return {'score': max(0, score), 'warnings': warnings}
        
    def _check_completeness(self, text: str, output_type: str) -> Dict:
        """Check if output is complete"""
        errors = []
        score = 100
        
        # Check for incomplete sentences
        sentences = re.split(r'[.!?]\s+', text)
        for i, sentence in enumerate(sentences):
            if sentence and not re.search(r'[.!?]$', sentence.strip()):
                if i < len(sentences) - 1:  # Not the last sentence
                    errors.append({
                        'type': 'incomplete_sentence',
                        'message': f"Incomplete sentence detected: '{sentence[:50]}...'",
                        'severity': 'low'
                    })
                    score -= 5
                    
        # Check for TODO or TBD markers
        if re.search(r'\b(TODO|TBD|TBA|FIXME)\b', text, re.IGNORECASE):
            errors.append({
                'type': 'incomplete_content',
                'message': "Output contains TODO/TBD markers",
                'severity': 'high'
            })
            score -= 20
            
        return {'score': max(0, score), 'errors': errors}
        
    def _generate_recommendations(self, scores: Dict, errors: List[Dict]) -> List[str]:
        """Generate recommendations for improvement"""
        recommendations = []
        
        if scores.get('structure_score', 100) < 80:
            recommendations.append("Improve output structure by including all required sections")
            
        if scores.get('actionability_score', 100) < 80:
            recommendations.append("Add more specific, actionable items with clear next steps")
            
        if scores.get('factual_accuracy', 100) < 90:
            recommendations.append("Verify all facts and figures for accuracy")
            
        if scores.get('consistency_score', 100) < 90:
            recommendations.append("Review output for internal consistency and contradictions")
            
        if any(e['type'] == 'vague_language' for e in errors):
            recommendations.append("Replace vague language with specific, measurable terms")
            
        return recommendations
        
    def validate_chain_output(self, outputs: List[Dict], expected_flow: List[str]) -> Dict:
        """Validate the entire chain of outputs"""
        chain_score = 100
        chain_errors = []
        
        # Check if all expected models were used
        actual_models = [output.get('model') for output in outputs]
        if actual_models != expected_flow:
            chain_errors.append({
                'type': 'chain_mismatch',
                'message': f"Expected models {expected_flow}, got {actual_models}",
                'severity': 'high'
            })
            chain_score -= 30
            
        # Check if outputs are properly connected
        for i in range(1, len(outputs)):
            prev_output = outputs[i-1].get('output', '')
            curr_input = outputs[i].get('input', '')
            
            # The current input should reference the previous output
            if prev_output and curr_input and prev_output[:50] not in curr_input:
                chain_errors.append({
                    'type': 'chain_disconnect',
                    'message': f"Output from {actual_models[i-1]} not properly passed to {actual_models[i]}",
                    'severity': 'medium'
                })
                chain_score -= 20
                
        return {
            'chain_score': max(0, chain_score),
            'chain_errors': chain_errors,
            'individual_scores': [
                self.analyze_output(output.get('output', ''), 
                                  output_type=self._infer_output_type(output.get('model', '')))
                for output in outputs
            ]
        }
        
    def _infer_output_type(self, model_name: str) -> str:
        """Infer output type from model name"""
        if 'decision' in model_name or 'action' in model_name:
            return 'action_items'
        elif 'risk' in model_name:
            return 'risk_assessment'
        elif 'analysis' in model_name or 'analyze' in model_name:
            return 'analysis'
        else:
            return 'general'


# CLI interface for quality testing
if __name__ == "__main__":
    import sys
    
    qa = QualityAssurance()
    
    # Test with sample output
    sample_output = """
    # Risk Assessment Summary
    
    ## Immediate Actions (Today)
    1. [Security] - Review and update access controls for sensitive data
    2. [Compliance] - Complete quarterly audit documentation by 5 PM
    
    ## Short-term Goals (This Week)
    1. [Process] - Implement automated testing for risk detection algorithms
    2. [Training] - Schedule team training on new compliance requirements
    
    ## Long-term Initiatives (This Month)
    1. [Strategy] - Develop comprehensive risk mitigation framework
    2. [Technology] - Evaluate AI-powered risk monitoring solutions
    
    ## Key Metrics
    - Current risk score: 3.2/10 (Low)
    - Compliance rate: 97.5%
    - Estimated time savings: 15 hours/week
    - ROI projection: $125,000 annually
    
    ## Next Steps
    - Schedule review meeting for Tuesday 2024-03-15
    - Prepare detailed implementation plan
    - Assign team responsibilities
    """
    
    result = qa.analyze_output(sample_output, output_type='risk_assessment')
    
    print("=== Quality Analysis Results ===\n")
    print(f"Overall Quality Score: {result['scores']['overall_quality']:.1f}/100")
    print(f"Passed: {'Yes' if result['passed'] else 'No'}\n")
    
    print("Detailed Scores:")
    for metric, score in result['scores'].items():
        if metric != 'overall_quality':
            print(f"  {metric}: {score:.1f}")
            
    if result['errors']:
        print("\nErrors Found:")
        for error in result['errors']:
            print(f"  [{error['severity']}] {error['type']}: {error['message']}")
            
    if result['warnings']:
        print("\nWarnings:")
        for warning in result['warnings']:
            print(f"  [{warning['severity']}] {warning['type']}: {warning['message']}")
            
    if result['recommendations']:
        print("\nRecommendations:")
        for rec in result['recommendations']:
            print(f"  - {rec}")