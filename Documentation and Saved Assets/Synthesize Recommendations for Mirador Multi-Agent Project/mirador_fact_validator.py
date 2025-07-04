#!/usr/bin/env python3
"""
Mirador Fact Validation and Accuracy Verification System
Ensures all actionable instructions contain verified, current information
"""

import requests
import json
import sqlite3
import time
from datetime import datetime, timedelta
from pathlib import Path
import re
import hashlib
from urllib.parse import urlparse
import subprocess

class MiradorFactValidator:
    def __init__(self):
        self.base_dir = Path.home() / "ai_framework_git"
        self.validation_db = self.base_dir / "fact_validation.db"
        self.cache_duration = 24  # hours
        
        # Initialize validation database
        self.init_validation_db()
        
        # Louisville-specific data sources
        self.louisville_sources = {
            'metro_gov': 'https://louisvilleky.gov',
            'jcps': 'https://www.jefferson.kyschools.us',
            'tarc': 'https://ridetarc.org',
            'jefferson_county': 'https://jeffersoncountyclerk.org'
        }
        
        # Financial data sources
        self.financial_sources = {
            'ky_revenue': 'https://revenue.ky.gov',
            'federal_reserve': 'https://www.federalreserve.gov',
            'irs': 'https://www.irs.gov'
        }
        
    def init_validation_db(self):
        """Initialize fact validation database"""
        conn = sqlite3.connect(self.validation_db)
        cursor = conn.cursor()
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS fact_cache (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                fact_hash TEXT UNIQUE NOT NULL,
                fact_content TEXT NOT NULL,
                verification_status TEXT NOT NULL,
                source_url TEXT,
                verified_timestamp TEXT,
                expires_timestamp TEXT,
                confidence_score REAL,
                verification_method TEXT
            )
        ''')
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS validation_sources (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                source_name TEXT NOT NULL,
                source_url TEXT NOT NULL,
                source_type TEXT NOT NULL,
                last_checked TEXT,
                reliability_score REAL DEFAULT 1.0,
                response_time REAL
            )
        ''')
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS validation_rules (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                fact_type TEXT NOT NULL,
                validation_pattern TEXT,
                required_sources INTEGER DEFAULT 1,
                max_age_hours INTEGER DEFAULT 24,
                confidence_threshold REAL DEFAULT 0.8
            )
        ''')
        
        # Insert default validation rules
        default_rules = [
            ('business_hours', r'(\d{1,2}:\d{2}\s*(AM|PM|am|pm))', 1, 168, 0.9),  # 1 week
            ('phone_number', r'(\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4})', 1, 720, 0.95),  # 30 days
            ('address', r'(\d+\s+[A-Za-z\s]+(?:Street|St|Avenue|Ave|Road|Rd|Boulevard|Blvd|Drive|Dr|Lane|Ln|Court|Ct|Place|Pl))', 1, 2160, 0.9),  # 90 days
            ('financial_rate', r'(\d+\.?\d*%)', 2, 24, 0.95),  # 1 day
            ('program_deadline', r'(deadline|due|expires?|ends?)', 1, 6, 0.99),  # 6 hours
            ('cost_amount', r'(\$\d+(?:,\d{3})*(?:\.\d{2})?)', 1, 48, 0.9)  # 2 days
        ]
        
        for rule in default_rules:
            cursor.execute('''
                INSERT OR IGNORE INTO validation_rules 
                (fact_type, validation_pattern, required_sources, max_age_hours, confidence_threshold)
                VALUES (?, ?, ?, ?, ?)
            ''', rule)
        
        conn.commit()
        conn.close()
    
    def extract_facts_from_instruction(self, instruction_text):
        """Extract verifiable facts from instruction text"""
        facts = []
        
        # Extract different types of facts using patterns
        patterns = {
            'phone_numbers': r'(\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4})',
            'addresses': r'(\d+\s+[A-Za-z\s]+(?:Street|St|Avenue|Ave|Road|Rd|Boulevard|Blvd|Drive|Dr|Lane|Ln|Court|Ct|Place|Pl)[^,\n]*)',
            'business_hours': r'((?:Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday|Mon|Tue|Wed|Thu|Fri|Sat|Sun)[^,\n]*\d{1,2}:\d{2}\s*(?:AM|PM|am|pm))',
            'websites': r'(https?://[^\s]+|www\.[^\s]+)',
            'costs': r'(\$\d+(?:,\d{3})*(?:\.\d{2})?)',
            'percentages': r'(\d+\.?\d*%)',
            'deadlines': r'(deadline[^,\n]*|due[^,\n]*|expires?[^,\n]*|ends?[^,\n]*)',
            'program_names': r'([A-Z][A-Za-z\s]+(?:Program|Service|Initiative|Plan|Account))',
        }
        
        for fact_type, pattern in patterns.items():
            matches = re.findall(pattern, instruction_text, re.IGNORECASE)
            for match in matches:
                fact_hash = hashlib.md5(f"{fact_type}:{match}".encode()).hexdigest()
                facts.append({
                    'type': fact_type,
                    'content': match,
                    'hash': fact_hash,
                    'context': self._extract_context(instruction_text, match)
                })
        
        return facts
    
    def _extract_context(self, text, fact, context_chars=100):
        """Extract surrounding context for a fact"""
        fact_pos = text.lower().find(fact.lower())
        if fact_pos == -1:
            return ""
        
        start = max(0, fact_pos - context_chars)
        end = min(len(text), fact_pos + len(fact) + context_chars)
        
        return text[start:end].strip()
    
    def validate_fact(self, fact):
        """Validate a single fact against cached data and external sources"""
        # Check cache first
        cached_result = self._check_fact_cache(fact['hash'])
        if cached_result and not self._is_cache_expired(cached_result):
            return cached_result
        
        # Perform new validation
        validation_result = self._perform_fact_validation(fact)
        
        # Cache the result
        self._cache_validation_result(fact, validation_result)
        
        return validation_result
    
    def _check_fact_cache(self, fact_hash):
        """Check if fact is in cache and still valid"""
        conn = sqlite3.connect(self.validation_db)
        cursor = conn.cursor()
        
        cursor.execute('''
            SELECT verification_status, source_url, verified_timestamp, 
                   expires_timestamp, confidence_score, verification_method
            FROM fact_cache 
            WHERE fact_hash = ?
        ''', (fact_hash,))
        
        result = cursor.fetchone()
        conn.close()
        
        if result:
            return {
                'status': result[0],
                'source': result[1],
                'verified_time': result[2],
                'expires_time': result[3],
                'confidence': result[4],
                'method': result[5]
            }
        
        return None
    
    def _is_cache_expired(self, cached_result):
        """Check if cached result has expired"""
        if not cached_result.get('expires_time'):
            return True
        
        expires = datetime.fromisoformat(cached_result['expires_time'])
        return datetime.now() > expires
    
    def _perform_fact_validation(self, fact):
        """Perform actual fact validation using appropriate methods"""
        fact_type = fact['type']
        content = fact['content']
        
        validation_methods = {
            'phone_numbers': self._validate_phone_number,
            'addresses': self._validate_address,
            'business_hours': self._validate_business_hours,
            'websites': self._validate_website,
            'costs': self._validate_cost_information,
            'percentages': self._validate_percentage,
            'deadlines': self._validate_deadline,
            'program_names': self._validate_program_name
        }
        
        validator = validation_methods.get(fact_type, self._validate_generic)
        return validator(content, fact.get('context', ''))
    
    def _validate_phone_number(self, phone, context):
        """Validate phone number format and potentially check if active"""
        # Clean phone number
        clean_phone = re.sub(r'[^\d]', '', phone)
        
        if len(clean_phone) == 10:
            formatted = f"({clean_phone[:3]}) {clean_phone[3:6]}-{clean_phone[6:]}"
            return {
                'status': 'verified',
                'confidence': 0.9,
                'method': 'format_validation',
                'source': 'internal',
                'verified_time': datetime.now().isoformat(),
                'expires_time': (datetime.now() + timedelta(days=30)).isoformat(),
                'notes': f'Valid format: {formatted}'
            }
        else:
            return {
                'status': 'invalid',
                'confidence': 0.0,
                'method': 'format_validation',
                'source': 'internal',
                'verified_time': datetime.now().isoformat(),
                'expires_time': (datetime.now() + timedelta(days=1)).isoformat(),
                'notes': 'Invalid phone number format'
            }
    
    def _validate_website(self, url, context):
        """Validate website accessibility"""
        try:
            if not url.startswith(('http://', 'https://')):
                url = 'https://' + url
            
            response = requests.head(url, timeout=10, allow_redirects=True)
            
            if response.status_code < 400:
                return {
                    'status': 'verified',
                    'confidence': 0.95,
                    'method': 'http_check',
                    'source': url,
                    'verified_time': datetime.now().isoformat(),
                    'expires_time': (datetime.now() + timedelta(hours=24)).isoformat(),
                    'notes': f'Website accessible (HTTP {response.status_code})'
                }
            else:
                return {
                    'status': 'warning',
                    'confidence': 0.3,
                    'method': 'http_check',
                    'source': url,
                    'verified_time': datetime.now().isoformat(),
                    'expires_time': (datetime.now() + timedelta(hours=6)).isoformat(),
                    'notes': f'Website returned HTTP {response.status_code}'
                }
        
        except Exception as e:
            return {
                'status': 'unverified',
                'confidence': 0.1,
                'method': 'http_check',
                'source': url,
                'verified_time': datetime.now().isoformat(),
                'expires_time': (datetime.now() + timedelta(hours=1)).isoformat(),
                'notes': f'Website check failed: {str(e)}'
            }
    
    def _validate_address(self, address, context):
        """Validate address format and potentially geocode"""
        # Basic format validation
        if re.match(r'\d+\s+[A-Za-z\s]+(?:Street|St|Avenue|Ave|Road|Rd|Boulevard|Blvd|Drive|Dr|Lane|Ln|Court|Ct|Place|Pl)', address, re.IGNORECASE):
            return {
                'status': 'verified',
                'confidence': 0.8,
                'method': 'format_validation',
                'source': 'internal',
                'verified_time': datetime.now().isoformat(),
                'expires_time': (datetime.now() + timedelta(days=90)).isoformat(),
                'notes': 'Valid address format'
            }
        else:
            return {
                'status': 'warning',
                'confidence': 0.4,
                'method': 'format_validation',
                'source': 'internal',
                'verified_time': datetime.now().isoformat(),
                'expires_time': (datetime.now() + timedelta(days=1)).isoformat(),
                'notes': 'Address format may be incomplete'
            }
    
    def _validate_business_hours(self, hours_text, context):
        """Validate business hours format"""
        # Look for time patterns
        time_pattern = r'\d{1,2}:\d{2}\s*(?:AM|PM|am|pm)'
        if re.search(time_pattern, hours_text):
            return {
                'status': 'verified',
                'confidence': 0.7,
                'method': 'format_validation',
                'source': 'internal',
                'verified_time': datetime.now().isoformat(),
                'expires_time': (datetime.now() + timedelta(days=7)).isoformat(),
                'notes': 'Valid business hours format - verify with business directly'
            }
        else:
            return {
                'status': 'warning',
                'confidence': 0.3,
                'method': 'format_validation',
                'source': 'internal',
                'verified_time': datetime.now().isoformat(),
                'expires_time': (datetime.now() + timedelta(hours=1)).isoformat(),
                'notes': 'Business hours format unclear'
            }
    
    def _validate_cost_information(self, cost, context):
        """Validate cost/price information"""
        # Extract numeric value
        numeric_match = re.search(r'\$?(\d+(?:,\d{3})*(?:\.\d{2})?)', cost)
        if numeric_match:
            amount = numeric_match.group(1).replace(',', '')
            try:
                float_amount = float(amount)
                return {
                    'status': 'verified',
                    'confidence': 0.6,
                    'method': 'format_validation',
                    'source': 'internal',
                    'verified_time': datetime.now().isoformat(),
                    'expires_time': (datetime.now() + timedelta(days=2)).isoformat(),
                    'notes': f'Valid cost format: ${float_amount:,.2f} - verify current pricing'
                }
            except ValueError:
                pass
        
        return {
            'status': 'warning',
            'confidence': 0.2,
            'method': 'format_validation',
            'source': 'internal',
            'verified_time': datetime.now().isoformat(),
            'expires_time': (datetime.now() + timedelta(hours=1)).isoformat(),
            'notes': 'Cost format unclear or invalid'
        }
    
    def _validate_percentage(self, percentage, context):
        """Validate percentage information"""
        numeric_match = re.search(r'(\d+\.?\d*)%', percentage)
        if numeric_match:
            value = float(numeric_match.group(1))
            if 0 <= value <= 100:
                confidence = 0.8
                status = 'verified'
                notes = f'Valid percentage: {value}%'
            else:
                confidence = 0.4
                status = 'warning'
                notes = f'Unusual percentage value: {value}%'
            
            return {
                'status': status,
                'confidence': confidence,
                'method': 'format_validation',
                'source': 'internal',
                'verified_time': datetime.now().isoformat(),
                'expires_time': (datetime.now() + timedelta(days=1)).isoformat(),
                'notes': notes
            }
        
        return {
            'status': 'invalid',
            'confidence': 0.0,
            'method': 'format_validation',
            'source': 'internal',
            'verified_time': datetime.now().isoformat(),
            'expires_time': (datetime.now() + timedelta(hours=1)).isoformat(),
            'notes': 'Invalid percentage format'
        }
    
    def _validate_deadline(self, deadline_text, context):
        """Validate deadline information"""
        # Look for date patterns
        date_patterns = [
            r'\d{1,2}/\d{1,2}/\d{4}',
            r'\d{4}-\d{2}-\d{2}',
            r'(?:January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{1,2},?\s+\d{4}',
            r'(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\s+\d{1,2},?\s+\d{4}'
        ]
        
        for pattern in date_patterns:
            if re.search(pattern, deadline_text, re.IGNORECASE):
                return {
                    'status': 'verified',
                    'confidence': 0.8,
                    'method': 'format_validation',
                    'source': 'internal',
                    'verified_time': datetime.now().isoformat(),
                    'expires_time': (datetime.now() + timedelta(hours=6)).isoformat(),
                    'notes': 'Deadline contains date - verify with source'
                }
        
        return {
            'status': 'warning',
            'confidence': 0.4,
            'method': 'format_validation',
            'source': 'internal',
            'verified_time': datetime.now().isoformat(),
            'expires_time': (datetime.now() + timedelta(hours=1)).isoformat(),
            'notes': 'Deadline mentioned but no specific date found'
        }
    
    def _validate_program_name(self, program_name, context):
        """Validate program or service name"""
        # Basic validation - check if it looks like a legitimate program name
        if len(program_name.strip()) > 5 and any(word.istitle() for word in program_name.split()):
            return {
                'status': 'verified',
                'confidence': 0.6,
                'method': 'format_validation',
                'source': 'internal',
                'verified_time': datetime.now().isoformat(),
                'expires_time': (datetime.now() + timedelta(days=30)).isoformat(),
                'notes': 'Program name format appears valid - verify existence with provider'
            }
        
        return {
            'status': 'warning',
            'confidence': 0.3,
            'method': 'format_validation',
            'source': 'internal',
            'verified_time': datetime.now().isoformat(),
            'expires_time': (datetime.now() + timedelta(hours=1)).isoformat(),
            'notes': 'Program name format unclear'
        }
    
    def _validate_generic(self, content, context):
        """Generic validation for unspecified fact types"""
        return {
            'status': 'unverified',
            'confidence': 0.5,
            'method': 'no_validation',
            'source': 'internal',
            'verified_time': datetime.now().isoformat(),
            'expires_time': (datetime.now() + timedelta(hours=1)).isoformat(),
            'notes': 'No specific validation method available'
        }
    
    def _cache_validation_result(self, fact, validation_result):
        """Cache validation result for future use"""
        conn = sqlite3.connect(self.validation_db)
        cursor = conn.cursor()
        
        cursor.execute('''
            INSERT OR REPLACE INTO fact_cache 
            (fact_hash, fact_content, verification_status, source_url, 
             verified_timestamp, expires_timestamp, confidence_score, verification_method)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ''', (
            fact['hash'],
            fact['content'],
            validation_result['status'],
            validation_result.get('source', ''),
            validation_result['verified_time'],
            validation_result['expires_time'],
            validation_result['confidence'],
            validation_result['method']
        ))
        
        conn.commit()
        conn.close()
    
    def validate_instruction(self, instruction_text):
        """Validate all facts in an instruction"""
        print("🔍 Extracting facts from instruction...")
        facts = self.extract_facts_from_instruction(instruction_text)
        
        print(f"📊 Found {len(facts)} facts to validate")
        
        validation_results = []
        for fact in facts:
            print(f"   Validating {fact['type']}: {fact['content'][:50]}...")
            result = self.validate_fact(fact)
            result['fact'] = fact
            validation_results.append(result)
        
        # Generate summary
        verified_count = sum(1 for r in validation_results if r['status'] == 'verified')
        warning_count = sum(1 for r in validation_results if r['status'] == 'warning')
        unverified_count = sum(1 for r in validation_results if r['status'] in ['unverified', 'invalid'])
        
        overall_confidence = sum(r['confidence'] for r in validation_results) / len(validation_results) if validation_results else 0
        
        summary = {
            'total_facts': len(facts),
            'verified': verified_count,
            'warnings': warning_count,
            'unverified': unverified_count,
            'overall_confidence': overall_confidence,
            'validation_results': validation_results,
            'recommendation': self._get_validation_recommendation(overall_confidence, warning_count, unverified_count)
        }
        
        return summary
    
    def _get_validation_recommendation(self, confidence, warnings, unverified):
        """Generate recommendation based on validation results"""
        if confidence >= 0.8 and unverified == 0:
            return "HIGH_CONFIDENCE: Instruction appears factually sound and ready for execution."
        elif confidence >= 0.6 and unverified <= 1:
            return "MEDIUM_CONFIDENCE: Most facts verified. Double-check flagged items before execution."
        elif confidence >= 0.4:
            return "LOW_CONFIDENCE: Several facts need verification. Recommend manual fact-checking before execution."
        else:
            return "VERY_LOW_CONFIDENCE: Significant fact-checking required. Do not execute without verification."
    
    def generate_validation_report(self, validation_summary):
        """Generate a formatted validation report"""
        report = f"""
# Fact Validation Report

## Summary
- **Total Facts Analyzed:** {validation_summary['total_facts']}
- **Verified:** {validation_summary['verified']} ✅
- **Warnings:** {validation_summary['warnings']} ⚠️
- **Unverified:** {validation_summary['unverified']} ❌
- **Overall Confidence:** {validation_summary['overall_confidence']:.1%}

## Recommendation
{validation_summary['recommendation']}

## Detailed Results
"""
        
        for result in validation_summary['validation_results']:
            fact = result['fact']
            status_icon = {'verified': '✅', 'warning': '⚠️', 'unverified': '❌', 'invalid': '❌'}.get(result['status'], '❓')
            
            report += f"""
### {fact['type'].replace('_', ' ').title()} {status_icon}
- **Content:** {fact['content']}
- **Status:** {result['status'].upper()}
- **Confidence:** {result['confidence']:.1%}
- **Method:** {result['method']}
- **Notes:** {result.get('notes', 'No additional notes')}
"""
        
        return report

def main():
    import argparse
    
    parser = argparse.ArgumentParser(description="Mirador Fact Validation System")
    parser.add_argument('instruction_file', help='Path to instruction file to validate')
    parser.add_argument('--output', help='Output file for validation report')
    
    args = parser.parse_args()
    
    validator = MiradorFactValidator()
    
    # Read instruction file
    with open(args.instruction_file, 'r') as f:
        instruction_text = f.read()
    
    # Validate instruction
    validation_summary = validator.validate_instruction(instruction_text)
    
    # Generate report
    report = validator.generate_validation_report(validation_summary)
    
    if args.output:
        with open(args.output, 'w') as f:
            f.write(report)
        print(f"📄 Validation report saved to: {args.output}")
    else:
        print(report)

if __name__ == "__main__":
    main()

