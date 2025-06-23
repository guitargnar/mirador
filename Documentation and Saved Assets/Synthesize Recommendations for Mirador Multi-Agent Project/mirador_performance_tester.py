#!/usr/bin/env python3
"""
Mirador Model Performance Tester
Tests model performance and reliability for consolidation decisions
"""

import asyncio
import json
import time
import subprocess
import statistics
from pathlib import Path
from typing import Dict, List, Tuple
from dataclasses import dataclass
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@dataclass
class PerformanceResult:
    model_name: str
    test_type: str
    response_time: float
    success: bool
    response_quality: float
    error_message: str = ""

class MiradorModelTester:
    """Tests Mirador models for performance and reliability"""
    
    def __init__(self, output_dir: str = "./performance_results"):
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        
        # Test scenarios for different model types
        self.test_scenarios = {
            'financial_planning': [
                "Create a budget plan for someone earning $75,000 annually with $2,000 monthly expenses",
                "Analyze investment options for a 35-year-old with $50,000 to invest",
                "Compare mortgage vs rent for a $300,000 home purchase"
            ],
            'context_provider': [
                "Provide context about Matthew's financial goals and current situation",
                "What are Matthew's key priorities for career development?",
                "Summarize Matthew's personal preferences and constraints"
            ],
            'decision_support': [
                "Should I take a job offer with 20% salary increase but longer commute?",
                "Evaluate pros and cons of starting a side business",
                "Help me decide between saving for house vs investing in retirement"
            ],
            'local_expert': [
                "What are the best neighborhoods in Louisville for young professionals?",
                "Recommend local networking events for tech professionals in Louisville",
                "Compare Louisville cost of living to national averages"
            ],
            'enhanced_agent': [
                "Review this financial plan for accuracy and completeness",
                "Validate the logic in this career development strategy",
                "Check this investment analysis for potential risks"
            ]
        }

    async def test_model_performance(self, model_name: str, category: str) -> List[PerformanceResult]:
        """Test a single model's performance across relevant scenarios"""
        results = []
        
        if category not in self.test_scenarios:
            logger.warning(f"No test scenarios for category: {category}")
            return results
        
        for i, scenario in enumerate(self.test_scenarios[category]):
            logger.info(f"Testing {model_name} - Scenario {i+1}/{len(self.test_scenarios[category])}")
            
            try:
                start_time = time.time()
                
                # Execute model query
                response = await self._execute_model_query(model_name, scenario)
                
                end_time = time.time()
                response_time = end_time - start_time
                
                # Evaluate response quality
                quality_score = self._evaluate_response_quality(response, category)
                
                results.append(PerformanceResult(
                    model_name=model_name,
                    test_type=f"scenario_{i+1}",
                    response_time=response_time,
                    success=True,
                    response_quality=quality_score
                ))
                
            except Exception as e:
                logger.error(f"Error testing {model_name}: {e}")
                results.append(PerformanceResult(
                    model_name=model_name,
                    test_type=f"scenario_{i+1}",
                    response_time=0.0,
                    success=False,
                    response_quality=0.0,
                    error_message=str(e)
                ))
        
        return results

    async def _execute_model_query(self, model_name: str, query: str) -> str:
        """Execute a query against a specific model"""
        try:
            # Use Ollama to query the model
            process = await asyncio.create_subprocess_exec(
                'ollama', 'run', model_name, query,
                stdout=asyncio.subprocess.PIPE,
                stderr=asyncio.subprocess.PIPE
            )
            
            stdout, stderr = await asyncio.wait_for(process.communicate(), timeout=60.0)
            
            if process.returncode != 0:
                raise Exception(f"Model execution failed: {stderr.decode()}")
            
            return stdout.decode().strip()
            
        except asyncio.TimeoutError:
            raise Exception("Model query timed out after 60 seconds")
        except Exception as e:
            raise Exception(f"Model execution error: {e}")

    def _evaluate_response_quality(self, response: str, category: str) -> float:
        """Evaluate response quality based on category-specific criteria"""
        if not response or len(response) < 50:
            return 0.0
        
        score = 0.0
        
        # Base quality indicators
        if len(response) > 100:
            score += 0.2
        if len(response.split()) > 50:
            score += 0.2
        
        # Category-specific quality indicators
        if category == 'financial_planning':
            financial_keywords = ['budget', 'investment', 'savings', 'debt', 'income', 'expense', '$', '%']
            keyword_score = sum(1 for keyword in financial_keywords if keyword.lower() in response.lower())
            score += min(keyword_score * 0.1, 0.3)
            
        elif category == 'decision_support':
            decision_keywords = ['pros', 'cons', 'recommend', 'consider', 'option', 'decision', 'choice']
            keyword_score = sum(1 for keyword in decision_keywords if keyword.lower() in response.lower())
            score += min(keyword_score * 0.1, 0.3)
            
        elif category == 'local_expert':
            local_keywords = ['louisville', 'kentucky', 'local', 'area', 'neighborhood', 'community']
            keyword_score = sum(1 for keyword in local_keywords if keyword.lower() in response.lower())
            score += min(keyword_score * 0.1, 0.3)
        
        # Structure and formatting
        if any(marker in response for marker in ['1.', '2.', '-', '*']):
            score += 0.1  # Structured response
        
        if len(response.split('\n')) > 3:
            score += 0.1  # Multi-paragraph response
        
        return min(score, 1.0)

    async def run_comprehensive_test(self, models_to_test: Dict[str, str]) -> Dict:
        """Run comprehensive performance tests on specified models"""
        all_results = []
        
        for model_name, category in models_to_test.items():
            logger.info(f"Testing model: {model_name} (category: {category})")
            
            try:
                model_results = await self.test_model_performance(model_name, category)
                all_results.extend(model_results)
            except Exception as e:
                logger.error(f"Failed to test {model_name}: {e}")
        
        # Analyze results
        analysis = self._analyze_results(all_results)
        
        # Generate reports
        self._generate_performance_report(all_results, analysis)
        
        return analysis

    def _analyze_results(self, results: List[PerformanceResult]) -> Dict:
        """Analyze performance test results"""
        analysis = {
            'summary': {},
            'by_model': {},
            'recommendations': []
        }
        
        # Group results by model
        by_model = {}
        for result in results:
            if result.model_name not in by_model:
                by_model[result.model_name] = []
            by_model[result.model_name].append(result)
        
        # Analyze each model
        for model_name, model_results in by_model.items():
            successful_results = [r for r in model_results if r.success]
            
            if successful_results:
                avg_response_time = statistics.mean([r.response_time for r in successful_results])
                avg_quality = statistics.mean([r.response_quality for r in successful_results])
                success_rate = len(successful_results) / len(model_results)
            else:
                avg_response_time = 0.0
                avg_quality = 0.0
                success_rate = 0.0
            
            model_analysis = {
                'total_tests': len(model_results),
                'successful_tests': len(successful_results),
                'success_rate': success_rate,
                'avg_response_time': avg_response_time,
                'avg_quality_score': avg_quality,
                'overall_score': (success_rate * 0.4 + (1 - min(avg_response_time/30, 1)) * 0.3 + avg_quality * 0.3)
            }
            
            analysis['by_model'][model_name] = model_analysis
            
            # Generate recommendations
            if success_rate < 0.8:
                analysis['recommendations'].append(f"⚠️  {model_name}: Low success rate ({success_rate:.1%}) - consider retirement")
            elif avg_response_time > 30:
                analysis['recommendations'].append(f"🐌 {model_name}: Slow response time ({avg_response_time:.1f}s) - consider optimization")
            elif avg_quality < 0.5:
                analysis['recommendations'].append(f"📉 {model_name}: Low quality score ({avg_quality:.2f}) - review model configuration")
            elif model_analysis['overall_score'] > 0.8:
                analysis['recommendations'].append(f"✅ {model_name}: Excellent performance - recommended for retention")
        
        # Overall summary
        all_successful = [r for r in results if r.success]
        analysis['summary'] = {
            'total_tests': len(results),
            'successful_tests': len(all_successful),
            'overall_success_rate': len(all_successful) / len(results) if results else 0,
            'avg_response_time': statistics.mean([r.response_time for r in all_successful]) if all_successful else 0,
            'avg_quality_score': statistics.mean([r.response_quality for r in all_successful]) if all_successful else 0
        }
        
        return analysis

    def _generate_performance_report(self, results: List[PerformanceResult], analysis: Dict):
        """Generate comprehensive performance report"""
        report_path = self.output_dir / "performance_report.md"
        
        with open(report_path, 'w') as f:
            f.write("# Mirador Model Performance Test Report\n\n")
            f.write(f"**Generated:** {time.strftime('%Y-%m-%d %H:%M:%S')}\n\n")
            
            # Executive Summary
            f.write("## Executive Summary\n\n")
            summary = analysis['summary']
            f.write(f"- **Total Tests:** {summary['total_tests']}\n")
            f.write(f"- **Success Rate:** {summary['overall_success_rate']:.1%}\n")
            f.write(f"- **Average Response Time:** {summary['avg_response_time']:.2f} seconds\n")
            f.write(f"- **Average Quality Score:** {summary['avg_quality_score']:.2f}/1.0\n\n")
            
            # Recommendations
            f.write("## Key Recommendations\n\n")
            for recommendation in analysis['recommendations']:
                f.write(f"- {recommendation}\n")
            f.write("\n")
            
            # Model Performance Details
            f.write("## Model Performance Details\n\n")
            f.write("| Model | Tests | Success Rate | Avg Response Time | Quality Score | Overall Score |\n")
            f.write("|-------|-------|--------------|-------------------|---------------|---------------|\n")
            
            for model_name, model_analysis in analysis['by_model'].items():
                f.write(f"| {model_name} | {model_analysis['total_tests']} | "
                       f"{model_analysis['success_rate']:.1%} | "
                       f"{model_analysis['avg_response_time']:.2f}s | "
                       f"{model_analysis['avg_quality_score']:.2f} | "
                       f"{model_analysis['overall_score']:.2f} |\n")
            f.write("\n")
            
            # Detailed Test Results
            f.write("## Detailed Test Results\n\n")
            current_model = None
            for result in sorted(results, key=lambda x: x.model_name):
                if result.model_name != current_model:
                    current_model = result.model_name
                    f.write(f"### {current_model}\n\n")
                
                status = "✅ Success" if result.success else "❌ Failed"
                f.write(f"- **{result.test_type}:** {status}")
                if result.success:
                    f.write(f" ({result.response_time:.2f}s, quality: {result.response_quality:.2f})")
                else:
                    f.write(f" - {result.error_message}")
                f.write("\n")
            
        logger.info(f"Performance report generated: {report_path}")
        
        # Also generate JSON data for programmatic use
        json_path = self.output_dir / "performance_data.json"
        with open(json_path, 'w') as f:
            json.dump({
                'results': [
                    {
                        'model_name': r.model_name,
                        'test_type': r.test_type,
                        'response_time': r.response_time,
                        'success': r.success,
                        'response_quality': r.response_quality,
                        'error_message': r.error_message
                    } for r in results
                ],
                'analysis': analysis
            }, f, indent=2)

async def main():
    """Main execution function"""
    print("🧪 Mirador Model Performance Tester")
    print("=" * 40)
    
    # Define models to test (you'll need to update this based on your actual models)
    models_to_test = {
        'financial_planning_expert_v6': 'financial_planning',
        'financial_planning_expert_v5': 'financial_planning',
        'matthew_context_provider_v2': 'context_provider',
        'matthew_context_provider_v1': 'context_provider',
        'decision_simplifier_v2': 'decision_support',
        'decision_simplifier_v1': 'decision_support',
        'louisville_expert_v3': 'local_expert',
        'louisville_expert_v2': 'local_expert',
        'enhanced_agent_enforcer_v2': 'enhanced_agent',
        'enhanced_agent_fast_v6': 'enhanced_agent'
    }
    
    tester = MiradorModelTester()
    
    print(f"🎯 Testing {len(models_to_test)} models...")
    analysis = await tester.run_comprehensive_test(models_to_test)
    
    print("\n✅ Performance testing complete!")
    print(f"📊 Overall success rate: {analysis['summary']['overall_success_rate']:.1%}")
    print(f"⏱️  Average response time: {analysis['summary']['avg_response_time']:.2f}s")
    print(f"📈 Average quality score: {analysis['summary']['avg_quality_score']:.2f}/1.0")
    print(f"📁 Results saved to: {tester.output_dir}")

if __name__ == "__main__":
    asyncio.run(main())

