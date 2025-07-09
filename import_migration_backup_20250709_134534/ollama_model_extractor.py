#!/usr/bin/env python3
"""
Ollama Model Extractor
Systematically extracts detailed information from all available Ollama models including
system prompts, parameters, base models, and configuration details.
"""

import subprocess
import json
import re
import sys
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional, Any
import argparse
from dataclasses import dataclass, field
from collections import defaultdict

@dataclass
class ModelInfo:
    """Comprehensive model information"""
    name: str
    base_model: str = ""
    system_prompt: str = ""
    template: str = ""
    parameters: Dict[str, Any] = field(default_factory=dict)
    size: str = ""
    digest: str = ""
    modified: str = ""
    format: str = ""
    family: str = ""
    families: List[str] = field(default_factory=list)
    parameter_size: str = ""
    quantization_level: str = ""
    license: str = ""
    modelfile: str = ""
    raw_output: str = ""
    error: str = ""

class OllamaModelExtractor:
    def __init__(self):
        self.models: Dict[str, ModelInfo] = {}
        self.available_models: List[str] = []
        self.extraction_errors: List[str] = []
        
    def get_available_models(self) -> List[str]:
        """Get list of available Ollama models"""
        try:
            result = subprocess.run(['ollama', 'list'], capture_output=True, text=True, check=True)
            lines = result.stdout.strip().split('\n')[1:]  # Skip header
            models = []
            
            for line in lines:
                if line.strip():
                    # Extract model name (first column)
                    parts = line.split()
                    if parts:
                        model_name = parts[0]
                        models.append(model_name)
            
            return models
        except (subprocess.CalledProcessError, FileNotFoundError) as e:
            print(f"❌ Error getting model list: {e}")
            return []
    
    def extract_model_info(self, model_name: str) -> ModelInfo:
        """Extract comprehensive information for a specific model"""
        model_info = ModelInfo(name=model_name)
        
        try:
            # Get detailed model information
            result = subprocess.run(['ollama', 'show', model_name], 
                                  capture_output=True, text=True, check=True)
            
            raw_output = result.stdout
            model_info.raw_output = raw_output
            
            # Parse the output
            self._parse_model_output(model_info, raw_output)
            
        except subprocess.CalledProcessError as e:
            error_msg = f"Failed to get info for {model_name}: {e.stderr if e.stderr else str(e)}"
            model_info.error = error_msg
            self.extraction_errors.append(error_msg)
            print(f"⚠️  {error_msg}")
        
        return model_info
    
    def _parse_model_output(self, model_info: ModelInfo, output: str) -> None:
        """Parse the ollama show output to extract structured information"""
        lines = output.split('\n')
        current_section = None
        
        for line in lines:
            line = line.strip()
            
            # Skip empty lines
            if not line:
                continue
            
            # Detect sections
            if line.startswith('Modelfile:'):
                current_section = 'modelfile'
                continue
            elif line.startswith('Parameters:'):
                current_section = 'parameters'
                continue
            elif line.startswith('Template:'):
                current_section = 'template'
                continue
            elif line.startswith('System:'):
                current_section = 'system'
                continue
            
            # Parse based on current section
            if current_section == 'modelfile':
                model_info.modelfile += line + '\n'
            elif current_section == 'template':
                model_info.template += line + '\n'
            elif current_section == 'system':
                model_info.system_prompt += line + '\n'
            elif current_section == 'parameters':
                # Parse parameter lines
                if ':' in line:
                    key, value = line.split(':', 1)
                    key = key.strip()
                    value = value.strip()
                    
                    # Try to convert to appropriate type
                    try:
                        if value.lower() in ['true', 'false']:
                            value = value.lower() == 'true'
                        elif '.' in value:
                            value = float(value)
                        elif value.isdigit():
                            value = int(value)
                    except ValueError:
                        pass  # Keep as string
                    
                    model_info.parameters[key] = value
            else:
                # Parse general information
                if ':' in line:
                    key, value = line.split(':', 1)
                    key = key.strip().lower()
                    value = value.strip()
                    
                    if key == 'size':
                        model_info.size = value
                    elif key == 'digest':
                        model_info.digest = value
                    elif key == 'modified':
                        model_info.modified = value
                    elif key == 'format':
                        model_info.format = value
                    elif key == 'family':
                        model_info.family = value
                    elif key == 'families':
                        model_info.families = [f.strip() for f in value.split(',')]
                    elif key == 'parameter size':
                        model_info.parameter_size = value
                    elif key == 'quantization level':
                        model_info.quantization_level = value
                    elif key == 'license':
                        model_info.license = value
        
        # Extract base model from modelfile
        if model_info.modelfile:
            from_match = re.search(r'FROM\s+(\S+)', model_info.modelfile, re.IGNORECASE)
            if from_match:
                model_info.base_model = from_match.group(1)
        
        # Clean up extracted text
        model_info.system_prompt = model_info.system_prompt.strip()
        model_info.template = model_info.template.strip()
        model_info.modelfile = model_info.modelfile.strip()
    
    def categorize_models(self) -> Dict[str, List[str]]:
        """Categorize models by their apparent purpose"""
        categories = defaultdict(list)
        
        for model_name in self.models.keys():
            name_lower = model_name.lower()
            
            # Categorize based on name patterns
            if any(keyword in name_lower for keyword in ['financial', 'planning', 'expert']):
                categories['Financial Planning'].append(model_name)
            elif any(keyword in name_lower for keyword in ['music', 'guitar', 'performance']):
                categories['Music & Performance'].append(model_name)
            elif any(keyword in name_lower for keyword in ['matthew', 'advisor', 'context']):
                categories['Personal Advisory'].append(model_name)
            elif any(keyword in name_lower for keyword in ['linkedin', 'content', 'social']):
                categories['Content & Social Media'].append(model_name)
            elif any(keyword in name_lower for keyword in ['agent', 'enforcer', 'optimizer']):
                categories['AI Agents & Optimization'].append(model_name)
            elif any(keyword in name_lower for keyword in ['business', 'strategy', 'opportunity']):
                categories['Business Strategy'].append(model_name)
            elif any(keyword in name_lower for keyword in ['code', 'coder', 'developer']):
                categories['Development & Coding'].append(model_name)
            elif any(keyword in name_lower for keyword in ['health', 'wellness', 'productivity']):
                categories['Health & Productivity'].append(model_name)
            elif any(keyword in name_lower for keyword in ['father', 'daughter', 'parenting']):
                categories['Family & Parenting'].append(model_name)
            elif any(keyword in name_lower for keyword in ['real_estate', 'louisville']):
                categories['Real Estate & Location'].append(model_name)
            elif any(keyword in name_lower for keyword in ['llama', 'mistral', 'deepseek']):
                categories['Base Models'].append(model_name)
            else:
                categories['Other/Specialized'].append(model_name)
        
        return dict(categories)
    
    def analyze_system_prompts(self) -> Dict[str, Any]:
        """Analyze system prompts for patterns and insights"""
        analysis = {
            'total_models_with_prompts': 0,
            'avg_prompt_length': 0,
            'common_keywords': defaultdict(int),
            'prompt_patterns': defaultdict(list),
            'role_definitions': defaultdict(list)
        }
        
        prompt_lengths = []
        all_prompts = []
        
        for model_name, model_info in self.models.items():
            if model_info.system_prompt:
                analysis['total_models_with_prompts'] += 1
                prompt_length = len(model_info.system_prompt)
                prompt_lengths.append(prompt_length)
                all_prompts.append(model_info.system_prompt)
                
                # Extract keywords
                words = re.findall(r'\b\w+\b', model_info.system_prompt.lower())
                for word in words:
                    if len(word) > 3:  # Skip short words
                        analysis['common_keywords'][word] += 1
                
                # Identify role patterns
                if 'you are' in model_info.system_prompt.lower():
                    role_match = re.search(r'you are ([^.]+)', model_info.system_prompt.lower())
                    if role_match:
                        role = role_match.group(1).strip()
                        analysis['role_definitions'][role].append(model_name)
                
                # Identify prompt patterns
                if 'expert' in model_info.system_prompt.lower():
                    analysis['prompt_patterns']['Expert Role'].append(model_name)
                if 'analyze' in model_info.system_prompt.lower():
                    analysis['prompt_patterns']['Analysis Focus'].append(model_name)
                if 'provide' in model_info.system_prompt.lower():
                    analysis['prompt_patterns']['Provider Role'].append(model_name)
                if 'help' in model_info.system_prompt.lower():
                    analysis['prompt_patterns']['Helper Role'].append(model_name)
        
        if prompt_lengths:
            analysis['avg_prompt_length'] = sum(prompt_lengths) / len(prompt_lengths)
        
        # Get top keywords
        analysis['top_keywords'] = dict(sorted(analysis['common_keywords'].items(), 
                                             key=lambda x: x[1], reverse=True)[:20])
        
        return analysis
    
    def analyze_parameters(self) -> Dict[str, Any]:
        """Analyze parameter patterns across models"""
        analysis = {
            'parameter_distribution': defaultdict(list),
            'common_parameters': defaultdict(int),
            'parameter_ranges': {},
            'unique_parameters': set()
        }
        
        for model_name, model_info in self.models.items():
            for param, value in model_info.parameters.items():
                analysis['common_parameters'][param] += 1
                analysis['parameter_distribution'][param].append((model_name, value))
                analysis['unique_parameters'].add(param)
        
        # Calculate ranges for numeric parameters
        for param, values in analysis['parameter_distribution'].items():
            numeric_values = []
            for model_name, value in values:
                if isinstance(value, (int, float)):
                    numeric_values.append(value)
            
            if numeric_values:
                analysis['parameter_ranges'][param] = {
                    'min': min(numeric_values),
                    'max': max(numeric_values),
                    'avg': sum(numeric_values) / len(numeric_values),
                    'count': len(numeric_values)
                }
        
        return analysis
    
    def extract_all_models(self, model_list: Optional[List[str]] = None) -> None:
        """Extract information from all available models"""
        if model_list is None:
            print("🔍 Discovering available Ollama models...")
            self.available_models = self.get_available_models()
        else:
            self.available_models = model_list
        
        if not self.available_models:
            print("❌ No models found!")
            return
        
        print(f"📊 Found {len(self.available_models)} models to analyze")
        
        # Extract information for each model
        for i, model_name in enumerate(self.available_models, 1):
            print(f"🔄 Analyzing {model_name} ({i}/{len(self.available_models)})...")
            model_info = self.extract_model_info(model_name)
            self.models[model_name] = model_info
        
        print(f"✅ Analysis complete! Processed {len(self.models)} models")
        if self.extraction_errors:
            print(f"⚠️  {len(self.extraction_errors)} models had extraction errors")
    
    def generate_comprehensive_report(self) -> str:
        """Generate a comprehensive analysis report"""
        report = []
        report.append("# Comprehensive Ollama Model Analysis Report")
        report.append(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        report.append(f"Total Models Analyzed: {len(self.models)}")
        report.append("")
        
        # Executive Summary
        successful_extractions = len([m for m in self.models.values() if not m.error])
        models_with_prompts = len([m for m in self.models.values() if m.system_prompt])
        models_with_params = len([m for m in self.models.values() if m.parameters])
        
        report.append("## Executive Summary")
        report.append(f"- **Total Models:** {len(self.models)}")
        report.append(f"- **Successful Extractions:** {successful_extractions}")
        report.append(f"- **Models with System Prompts:** {models_with_prompts}")
        report.append(f"- **Models with Parameters:** {models_with_params}")
        report.append(f"- **Extraction Errors:** {len(self.extraction_errors)}")
        report.append("")
        
        # Model Categories
        categories = self.categorize_models()
        report.append("## Model Categories")
        for category, models in categories.items():
            report.append(f"### {category} ({len(models)} models)")
            for model in sorted(models):
                report.append(f"- {model}")
            report.append("")
        
        # System Prompt Analysis
        prompt_analysis = self.analyze_system_prompts()
        report.append("## System Prompt Analysis")
        report.append(f"- **Models with System Prompts:** {prompt_analysis['total_models_with_prompts']}")
        report.append(f"- **Average Prompt Length:** {prompt_analysis['avg_prompt_length']:.0f} characters")
        
        if prompt_analysis['top_keywords']:
            report.append("\n**Most Common Keywords in System Prompts:**")
            for keyword, count in list(prompt_analysis['top_keywords'].items())[:10]:
                report.append(f"- {keyword}: {count} occurrences")
        
        if prompt_analysis['prompt_patterns']:
            report.append("\n**Prompt Patterns:**")
            for pattern, models in prompt_analysis['prompt_patterns'].items():
                report.append(f"- **{pattern}:** {len(models)} models")
        
        report.append("")
        
        # Parameter Analysis
        param_analysis = self.analyze_parameters()
        report.append("## Parameter Analysis")
        report.append(f"- **Unique Parameters Found:** {len(param_analysis['unique_parameters'])}")
        
        if param_analysis['common_parameters']:
            report.append("\n**Most Common Parameters:**")
            for param, count in sorted(param_analysis['common_parameters'].items(), 
                                     key=lambda x: x[1], reverse=True)[:10]:
                report.append(f"- {param}: {count} models")
        
        if param_analysis['parameter_ranges']:
            report.append("\n**Parameter Ranges:**")
            for param, ranges in param_analysis['parameter_ranges'].items():
                report.append(f"- **{param}:** {ranges['min']:.3f} - {ranges['max']:.3f} (avg: {ranges['avg']:.3f})")
        
        report.append("")
        
        # Detailed Model Information
        report.append("## Detailed Model Information")
        
        for model_name in sorted(self.models.keys()):
            model_info = self.models[model_name]
            
            report.append(f"### {model_name}")
            
            if model_info.error:
                report.append(f"**❌ Error:** {model_info.error}")
                report.append("")
                continue
            
            # Basic information
            if model_info.base_model:
                report.append(f"**Base Model:** {model_info.base_model}")
            if model_info.size:
                report.append(f"**Size:** {model_info.size}")
            if model_info.parameter_size:
                report.append(f"**Parameter Size:** {model_info.parameter_size}")
            if model_info.format:
                report.append(f"**Format:** {model_info.format}")
            if model_info.family:
                report.append(f"**Family:** {model_info.family}")
            
            # Parameters
            if model_info.parameters:
                report.append("\n**Parameters:**")
                for param, value in sorted(model_info.parameters.items()):
                    report.append(f"- {param}: {value}")
            
            # System prompt
            if model_info.system_prompt:
                report.append("\n**System Prompt:**")
                report.append("```")
                report.append(model_info.system_prompt)
                report.append("```")
            
            # Modelfile
            if model_info.modelfile:
                report.append("\n**Modelfile:**")
                report.append("```dockerfile")
                report.append(model_info.modelfile)
                report.append("```")
            
            # Template
            if model_info.template:
                report.append("\n**Template:**")
                report.append("```")
                report.append(model_info.template)
                report.append("```")
            
            report.append("")
            report.append("---")
            report.append("")
        
        # Extraction Errors
        if self.extraction_errors:
            report.append("## Extraction Errors")
            for error in self.extraction_errors:
                report.append(f"- {error}")
            report.append("")
        
        return "\n".join(report)
    
    def save_report(self, filename: str = None) -> str:
        """Save the comprehensive report to a file"""
        if filename is None:
            timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
            filename = f"ollama_model_analysis_{timestamp}.md"
        
        report_content = self.generate_comprehensive_report()
        
        with open(filename, 'w', encoding='utf-8') as f:
            f.write(report_content)
        
        return filename
    
    def save_json_export(self, filename: str = None) -> str:
        """Save model data as JSON for programmatic access"""
        if filename is None:
            timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
            filename = f"ollama_models_{timestamp}.json"
        
        # Convert dataclasses to dictionaries
        json_data = {}
        for model_name, model_info in self.models.items():
            json_data[model_name] = {
                'name': model_info.name,
                'base_model': model_info.base_model,
                'system_prompt': model_info.system_prompt,
                'template': model_info.template,
                'parameters': model_info.parameters,
                'size': model_info.size,
                'digest': model_info.digest,
                'modified': model_info.modified,
                'format': model_info.format,
                'family': model_info.family,
                'families': model_info.families,
                'parameter_size': model_info.parameter_size,
                'quantization_level': model_info.quantization_level,
                'license': model_info.license,
                'modelfile': model_info.modelfile,
                'error': model_info.error
            }
        
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(json_data, f, indent=2, ensure_ascii=False)
        
        return filename
    
    def print_summary(self) -> None:
        """Print a quick summary to console"""
        print("\n" + "="*80)
        print("🤖 OLLAMA MODEL EXTRACTION SUMMARY")
        print("="*80)
        
        successful = len([m for m in self.models.values() if not m.error])
        with_prompts = len([m for m in self.models.values() if m.system_prompt])
        with_params = len([m for m in self.models.values() if m.parameters])
        
        print(f"📊 Total Models: {len(self.models)}")
        print(f"✅ Successful Extractions: {successful}")
        print(f"💬 Models with System Prompts: {with_prompts}")
        print(f"⚙️  Models with Parameters: {with_params}")
        
        if self.extraction_errors:
            print(f"❌ Extraction Errors: {len(self.extraction_errors)}")
        
        # Show categories
        categories = self.categorize_models()
        print(f"\n📂 Model Categories:")
        for category, models in categories.items():
            print(f"  {category}: {len(models)} models")
        
        print("="*80)

def main():
    parser = argparse.ArgumentParser(description="Extract comprehensive information from Ollama models")
    parser.add_argument("--models", "-m", nargs='+', 
                       help="Specific models to analyze (default: all available)")
    parser.add_argument("--save-report", "-r", metavar="FILENAME", 
                       help="Save detailed report to markdown file")
    parser.add_argument("--save-json", "-j", metavar="FILENAME", 
                       help="Save model data to JSON file")
    parser.add_argument("--summary", "-s", action="store_true", default=True,
                       help="Show summary (default)")
    
    args = parser.parse_args()
    
    # Create extractor
    extractor = OllamaModelExtractor()
    
    # Extract model information
    extractor.extract_all_models(args.models)
    
    # Generate outputs
    if args.save_report:
        filename = extractor.save_report(args.save_report)
        print(f"📄 Detailed report saved to: {filename}")
    
    if args.save_json:
        filename = extractor.save_json_export(args.save_json)
        print(f"📊 JSON data saved to: {filename}")
    
    # Show summary
    if args.summary:
        extractor.print_summary()

if __name__ == "__main__":
    main()

