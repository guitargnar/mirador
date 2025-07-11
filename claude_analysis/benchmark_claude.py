#!/usr/bin/env python3
"""
Claude Performance Benchmarking Script for Mirador AI Framework

This script provides comprehensive benchmarking capabilities for Claude integration,
measuring response times, token throughput, cost efficiency, and quality metrics.
"""

import json
import time
import argparse
import statistics
from datetime import datetime
from typing import Dict, List, Any, Optional
import os
import sys
import asyncio
import aiohttp
from dataclasses import dataclass, asdict
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)


@dataclass
class BenchmarkResult:
    """Data class for storing benchmark results"""
    timestamp: str
    model: str
    prompt: str
    response_time: float
    tokens_input: int
    tokens_output: int
    tokens_per_second: float
    success: bool
    error: Optional[str] = None
    memory_usage_mb: Optional[float] = None
    cost_estimate: Optional[float] = None


class ClaudeBenchmark:
    """Main benchmarking class for Claude integration"""
    
    def __init__(self, api_key: Optional[str] = None):
        self.api_key = api_key or os.getenv('ANTHROPIC_API_KEY')
        if not self.api_key:
            raise ValueError("API key not found. Set ANTHROPIC_API_KEY environment variable.")
        
        self.base_url = "https://api.anthropic.com/v1"
        self.headers = {
            "x-api-key": self.api_key,
            "anthropic-version": "2023-06-01",
            "content-type": "application/json"
        }
        
        # Test prompts for different scenarios
        self.test_prompts = {
            "simple": "What is 2+2?",
            "reasoning": "Explain the concept of recursion in programming with an example.",
            "creative": "Write a haiku about artificial intelligence.",
            "analysis": "Analyze the pros and cons of remote work for software developers.",
            "code": "Write a Python function to calculate the Fibonacci sequence.",
            "mirador": "How can I optimize my daily productivity using AI tools?"
        }
        
        # Model configurations
        self.models = {
            "claude-3-opus": {"max_tokens": 4096, "cost_per_1k_input": 0.015, "cost_per_1k_output": 0.075},
            "claude-3-sonnet": {"max_tokens": 4096, "cost_per_1k_input": 0.003, "cost_per_1k_output": 0.015},
            "claude-3-haiku": {"max_tokens": 4096, "cost_per_1k_input": 0.00025, "cost_per_1k_output": 0.00125}
        }
        
    async def make_request(self, prompt: str, model: str = "claude-3-sonnet") -> BenchmarkResult:
        """Make an async request to Claude API and measure performance"""
        start_time = time.time()
        
        payload = {
            "model": model,
            "messages": [{"role": "user", "content": prompt}],
            "max_tokens": self.models[model]["max_tokens"],
            "temperature": 0.7
        }
        
        try:
            async with aiohttp.ClientSession() as session:
                async with session.post(
                    f"{self.base_url}/messages",
                    headers=self.headers,
                    json=payload
                ) as response:
                    response_data = await response.json()
                    
                    if response.status != 200:
                        return BenchmarkResult(
                            timestamp=datetime.now().isoformat(),
                            model=model,
                            prompt=prompt,
                            response_time=time.time() - start_time,
                            tokens_input=0,
                            tokens_output=0,
                            tokens_per_second=0,
                            success=False,
                            error=f"API Error: {response_data}"
                        )
                    
                    # Calculate metrics
                    response_time = time.time() - start_time
                    tokens_input = response_data.get("usage", {}).get("input_tokens", 0)
                    tokens_output = response_data.get("usage", {}).get("output_tokens", 0)
                    tokens_per_second = tokens_output / response_time if response_time > 0 else 0
                    
                    # Calculate cost
                    cost = self.calculate_cost(model, tokens_input, tokens_output)
                    
                    return BenchmarkResult(
                        timestamp=datetime.now().isoformat(),
                        model=model,
                        prompt=prompt,
                        response_time=response_time,
                        tokens_input=tokens_input,
                        tokens_output=tokens_output,
                        tokens_per_second=tokens_per_second,
                        success=True,
                        cost_estimate=cost
                    )
                    
        except Exception as e:
            return BenchmarkResult(
                timestamp=datetime.now().isoformat(),
                model=model,
                prompt=prompt,
                response_time=time.time() - start_time,
                tokens_input=0,
                tokens_output=0,
                tokens_per_second=0,
                success=False,
                error=str(e)
            )
    
    def calculate_cost(self, model: str, input_tokens: int, output_tokens: int) -> float:
        """Calculate estimated cost for a request"""
        model_config = self.models.get(model, self.models["claude-3-sonnet"])
        input_cost = (input_tokens / 1000) * model_config["cost_per_1k_input"]
        output_cost = (output_tokens / 1000) * model_config["cost_per_1k_output"]
        return input_cost + output_cost
    
    async def run_benchmark_suite(self, iterations: int = 5, models: Optional[List[str]] = None) -> Dict[str, Any]:
        """Run comprehensive benchmark suite"""
        if models is None:
            models = list(self.models.keys())
        
        results = []
        
        for model in models:
            logger.info(f"Benchmarking model: {model}")
            
            for prompt_type, prompt in self.test_prompts.items():
                logger.info(f"  Testing {prompt_type} prompt...")
                
                prompt_results = []
                for i in range(iterations):
                    result = await self.make_request(prompt, model)
                    prompt_results.append(result)
                    results.append(asdict(result))
                    
                    if result.success:
                        logger.info(f"    Iteration {i+1}: {result.response_time:.2f}s, "
                                  f"{result.tokens_per_second:.1f} tokens/s")
                    else:
                        logger.error(f"    Iteration {i+1}: Failed - {result.error}")
                
                # Calculate statistics for this prompt type
                successful_results = [r for r in prompt_results if r.success]
                if successful_results:
                    avg_response_time = statistics.mean([r.response_time for r in successful_results])
                    avg_tokens_per_second = statistics.mean([r.tokens_per_second for r in successful_results])
                    logger.info(f"  {prompt_type} average: {avg_response_time:.2f}s, "
                              f"{avg_tokens_per_second:.1f} tokens/s")
        
        # Compile summary statistics
        summary = self.compile_summary(results)
        
        return {
            "summary": summary,
            "detailed_results": results,
            "metadata": {
                "timestamp": datetime.now().isoformat(),
                "iterations": iterations,
                "models_tested": models,
                "prompt_types": list(self.test_prompts.keys())
            }
        }
    
    def compile_summary(self, results: List[Dict[str, Any]]) -> Dict[str, Any]:
        """Compile summary statistics from results"""
        summary = {}
        
        # Group results by model
        for model in self.models.keys():
            model_results = [r for r in results if r["model"] == model and r["success"]]
            
            if model_results:
                summary[model] = {
                    "total_requests": len([r for r in results if r["model"] == model]),
                    "successful_requests": len(model_results),
                    "success_rate": len(model_results) / len([r for r in results if r["model"] == model]),
                    "avg_response_time": statistics.mean([r["response_time"] for r in model_results]),
                    "min_response_time": min([r["response_time"] for r in model_results]),
                    "max_response_time": max([r["response_time"] for r in model_results]),
                    "avg_tokens_per_second": statistics.mean([r["tokens_per_second"] for r in model_results]),
                    "total_cost": sum([r["cost_estimate"] for r in model_results if r["cost_estimate"]]),
                    "avg_cost_per_request": statistics.mean([r["cost_estimate"] for r in model_results if r["cost_estimate"]])
                }
        
        return summary
    
    def save_results(self, results: Dict[str, Any], filename: str):
        """Save benchmark results to file"""
        os.makedirs(os.path.dirname(filename), exist_ok=True)
        
        # Load existing results if file exists
        existing_results = []
        if os.path.exists(filename):
            try:
                with open(filename, 'r') as f:
                    data = json.load(f)
                    existing_results = data.get("benchmark_results", [])
            except Exception as e:
                logger.warning(f"Could not load existing results: {e}")
        
        # Append new results
        existing_results.append(results)
        
        # Save updated results
        with open(filename, 'w') as f:
            json.dump({
                "benchmark_results": existing_results,
                "metadata": {
                    "last_updated": datetime.now().isoformat(),
                    "total_benchmarks": len(existing_results)
                }
            }, f, indent=2)
        
        logger.info(f"Results saved to {filename}")
    
    def compare_with_mirador(self, claude_results: Dict[str, Any]) -> Dict[str, Any]:
        """Compare Claude performance with existing Mirador models"""
        # This would integrate with existing Mirador benchmarking
        # For now, return a placeholder comparison
        return {
            "comparison": "Placeholder for Mirador comparison",
            "recommendation": "Further analysis needed"
        }


async def main():
    """Main entry point for the benchmark script"""
    parser = argparse.ArgumentParser(description="Benchmark Claude integration for Mirador")
    parser.add_argument("--iterations", type=int, default=5, help="Number of iterations per test")
    parser.add_argument("--model", type=str, help="Specific model to test")
    parser.add_argument("--output", type=str, default="benchmarks/performance_results.json",
                       help="Output file for results")
    parser.add_argument("--api-key", type=str, help="Anthropic API key (or use ANTHROPIC_API_KEY env var)")
    
    args = parser.parse_args()
    
    try:
        # Initialize benchmark
        benchmark = ClaudeBenchmark(api_key=args.api_key)
        
        # Determine models to test
        models = [args.model] if args.model else None
        
        # Run benchmarks
        logger.info("Starting Claude benchmark suite...")
        results = await benchmark.run_benchmark_suite(iterations=args.iterations, models=models)
        
        # Display summary
        logger.info("\n=== BENCHMARK SUMMARY ===")
        for model, stats in results["summary"].items():
            logger.info(f"\n{model}:")
            logger.info(f"  Success Rate: {stats['success_rate']*100:.1f}%")
            logger.info(f"  Avg Response Time: {stats['avg_response_time']:.2f}s")
            logger.info(f"  Avg Tokens/Second: {stats['avg_tokens_per_second']:.1f}")
            logger.info(f"  Avg Cost/Request: ${stats['avg_cost_per_request']:.4f}")
        
        # Save results
        benchmark.save_results(results, args.output)
        
        # Compare with Mirador
        comparison = benchmark.compare_with_mirador(results)
        logger.info(f"\nMirador Comparison: {comparison['recommendation']}")
        
    except Exception as e:
        logger.error(f"Benchmark failed: {e}")
        sys.exit(1)


if __name__ == "__main__":
    asyncio.run(main())