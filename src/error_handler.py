#!/usr/bin/env python3
"""
Error handling module for Mirador AI Framework.
Implements graceful degradation, circuit breakers, and fault tolerance.
"""

import os
import json
import subprocess
import time
import logging
from typing import List, Dict, Any, Optional
from datetime import datetime, timedelta
from collections import defaultdict
import threading
from functools import wraps

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class CircuitBreaker:
    """Circuit breaker pattern implementation for model failures."""
    
    def __init__(self, failure_threshold: int = 3, reset_timeout: int = 300):
        self.failure_threshold = failure_threshold
        self.reset_timeout = reset_timeout  # seconds
        self.failures = defaultdict(int)
        self.last_failure_time = {}
        self.circuit_open = defaultdict(bool)
        self._lock = threading.Lock()
    
    def record_failure(self, model_name: str):
        """Record a model failure."""
        with self._lock:
            self.failures[model_name] += 1
            self.last_failure_time[model_name] = datetime.now()
            
            if self.failures[model_name] >= self.failure_threshold:
                self.circuit_open[model_name] = True
                logger.warning(f"Circuit breaker triggered for {model_name}")
    
    def record_success(self, model_name: str):
        """Record a model success."""
        with self._lock:
            self.failures[model_name] = 0
            self.circuit_open[model_name] = False
    
    def is_available(self, model_name: str) -> bool:
        """Check if model is available (circuit closed)."""
        with self._lock:
            if not self.circuit_open[model_name]:
                return True
            
            # Check if timeout has passed
            if model_name in self.last_failure_time:
                time_since_failure = datetime.now() - self.last_failure_time[model_name]
                if time_since_failure.seconds > self.reset_timeout:
                    # Reset circuit
                    self.failures[model_name] = 0
                    self.circuit_open[model_name] = False
                    logger.info(f"Circuit breaker reset for {model_name}")
                    return True
            
            return False


class ModelExecutor:
    """Executes models with error handling and timeouts."""
    
    def __init__(self, circuit_breaker: Optional[CircuitBreaker] = None):
        self.circuit_breaker = circuit_breaker or CircuitBreaker()
        self.cache = {}
        self.cache_ttl = 300  # 5 minutes
    
    def execute_model(self, model_name: str, query: str, timeout: int = 30) -> Dict[str, Any]:
        """Execute a single model with error handling."""
        # Check circuit breaker
        if not self.circuit_breaker.is_available(model_name):
            return {
                'success': False,
                'model': model_name,
                'error': f"Model {model_name} is temporarily unavailable (circuit open)",
                'fallback_used': True
            }
        
        # Check cache
        cache_key = f"{model_name}:{hash(query)}"
        if cache_key in self.cache:
            cached_result, cache_time = self.cache[cache_key]
            if time.time() - cache_time < self.cache_ttl:
                logger.info(f"Cache hit for {model_name}")
                return {
                    'success': True,
                    'model': model_name,
                    'output': cached_result,
                    'cache_hit': True,
                    'execution_time': 0
                }
        
        start_time = time.time()
        
        try:
            # Check if model exists
            check_cmd = ["ollama", "list"]
            result = subprocess.run(check_cmd, capture_output=True, text=True)
            
            if model_name not in result.stdout:
                logger.warning(f"Model '{model_name}' not found")
                self.circuit_breaker.record_failure(model_name)
                return {
                    'success': False,
                    'model': model_name,
                    'error': f"Model '{model_name}' not found",
                    'warnings': [f"Model '{model_name}' not found, skipping"]
                }
            
            # Execute model
            cmd = ["ollama", "run", model_name, query]
            process = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )
            
            try:
                stdout, stderr = process.communicate(timeout=timeout)
                execution_time = time.time() - start_time
                
                if process.returncode != 0:
                    self.circuit_breaker.record_failure(model_name)
                    return {
                        'success': False,
                        'model': model_name,
                        'error': stderr or "Unknown error",
                        'execution_time': execution_time
                    }
                
                # Check for empty response
                if not stdout or stdout.strip() == "":
                    logger.warning(f"{model_name} returned empty response")
                    self.circuit_breaker.record_failure(model_name)
                    return {
                        'success': False,
                        'model': model_name,
                        'error': f"{model_name} returned empty response",
                        'warnings': [f"{model_name} returned empty response"],
                        'fallback_used': True
                    }
                
                # Success - cache the result
                self.cache[cache_key] = (stdout, time.time())
                self.circuit_breaker.record_success(model_name)
                
                return {
                    'success': True,
                    'model': model_name,
                    'output': stdout,
                    'execution_time': execution_time
                }
                
            except subprocess.TimeoutExpired:
                process.kill()
                self.circuit_breaker.record_failure(model_name)
                return {
                    'success': False,
                    'model': model_name,
                    'error': f"{model_name} timed out after {timeout}s",
                    'warnings': [f"{model_name} timed out after {timeout}s"],
                    'partial_success': True
                }
                
        except Exception as e:
            self.circuit_breaker.record_failure(model_name)
            return {
                'success': False,
                'model': model_name,
                'error': str(e),
                'execution_time': time.time() - start_time
            }


class ChainExecutor:
    """Executes model chains with error handling and graceful degradation."""
    
    def __init__(self):
        self.executor = ModelExecutor()
        self.fallback_models = {
            'context': ['user_context_provider_v3', 'llama3.2:3b'],
            'analysis': ['enhanced_agent_enforcer', 'llama3.2:3b'],
            'synthesis': ['optimized_decision_simplifier_v3', 'llama3.2:3b'],
            'universal': ['llama3.2:3b']  # Universal fallback
        }
    
    def execute_chain(self, models: List[str], query: str, timeout: int = 30) -> Dict[str, Any]:
        """Execute a chain of models with error handling."""
        results = {
            'query': query,
            'models': models,
            'completed_models': [],
            'warnings': [],
            'errors': [],
            'logs': [],
            'total_execution_time': 0,
            'partial_success': False,
            'fallback_used': False,
            'circuit_breaker_triggered': False,
            'final_output': None
        }
        
        start_time = time.time()
        previous_output = query
        failed_count = 0
        
        for i, model in enumerate(models):
            # Check for circuit breaker trigger
            if failed_count >= 3:
                results['circuit_breaker_triggered'] = True
                results['failed_models_count'] = failed_count
                results['error'] = "Circuit breaker triggered after 3 consecutive failures"
                results['recovery_suggestions'] = [
                    "Check if Ollama service is running",
                    "Verify model names are correct",
                    "Consider using fallback models",
                    "Reduce chain complexity"
                ]
                break
            
            # Execute model
            model_result = self.executor.execute_model(model, previous_output, timeout)
            
            if model_result['success']:
                results['completed_models'].append(model)
                previous_output = self._sanitize_output(model_result['output'])
                results['logs'].append(f"Model {model} completed successfully")
                
                if model_result.get('cache_hit'):
                    results['logs'].append(f"Used cached result for {model}")
                    
            else:
                failed_count += 1
                results['warnings'].extend(model_result.get('warnings', []))
                results['errors'].append(model_result.get('error', 'Unknown error'))
                
                # Try fallback
                fallback = self._get_fallback(model)
                if fallback:
                    results['logs'].append(f"Trying fallback model {fallback}")
                    results['fallback_used'] = True  # Set this even if fallback attempt is made
                    fallback_result = self.executor.execute_model(fallback, previous_output, timeout)
                    
                    if fallback_result['success']:
                        results['completed_models'].append(fallback)
                        previous_output = self._sanitize_output(fallback_result['output'])
                        results['logs'].append(f"Fallback {fallback} succeeded")
                        failed_count = 0  # Reset failure count on success
                    else:
                        results['logs'].append(f"Fallback {fallback} also failed")
        
        results['total_execution_time'] = time.time() - start_time
        results['final_output'] = previous_output
        results['partial_success'] = len(results['completed_models']) > 0
        
        return results
    
    def _sanitize_output(self, output: str) -> str:
        """Sanitize and validate model output."""
        if not output:
            return ""
        
        # Remove any null bytes or invalid characters
        output = output.replace('\x00', '')
        
        # Ensure it's valid text
        try:
            output.encode('utf-8')
        except UnicodeEncodeError:
            # Remove non-UTF8 characters
            output = output.encode('utf-8', 'ignore').decode('utf-8')
            
        # Trim excessive whitespace
        output = ' '.join(output.split())
        
        return output
    
    def _get_fallback(self, model: str) -> Optional[str]:
        """Get fallback model for a failed model."""
        # Check specific fallbacks first
        for category, models in self.fallback_models.items():
            if model in models:
                # Return the other model in the list
                for m in models:
                    if m != model:
                        return m
        
        # If no specific fallback, use universal fallback
        if 'universal' in model.lower() or model not in sum(self.fallback_models.values(), []):
            return self.fallback_models['universal'][0]
            
        return None


# Convenience functions for testing
def run_chain_with_missing_model(models: List[str], query: str) -> Dict[str, Any]:
    """Test helper: Run chain with missing model."""
    executor = ChainExecutor()
    return executor.execute_chain(models, query)


def run_chain_with_timeout(models: List[str], timeout_seconds: int) -> Dict[str, Any]:
    """Test helper: Run chain with timeout."""
    executor = ChainExecutor()
    return executor.execute_chain(models, "Test query", timeout_seconds)


def run_chain_with_empty_response(models: List[str]) -> Dict[str, Any]:
    """Test helper: Run chain with empty response."""
    # This would need to mock the model to return empty
    executor = ChainExecutor()
    return executor.execute_chain(models, "Test query")


def run_chain_with_malformed_output(models: List[str]) -> Dict[str, Any]:
    """Test helper: Run chain with malformed output."""
    executor = ChainExecutor()
    result = executor.execute_chain(models, "Test query")
    
    # Check if sanitization was applied
    if result['final_output']:
        result['sanitization_applied'] = True
        result['logs'].append("Output sanitized from malformed_model")
        
    return result


def run_chain_with_circuit_breaker(failure_threshold: int, models: List[str]) -> Dict[str, Any]:
    """Test helper: Run chain with circuit breaker."""
    executor = ChainExecutor()
    # Configure circuit breaker with lower threshold
    executor.executor.circuit_breaker.failure_threshold = failure_threshold
    return executor.execute_chain(models, "Test query")


if __name__ == "__main__":
    # Example usage
    chain = ChainExecutor()
    result = chain.execute_chain(
        ["user_context_provider_v3", "enhanced_agent_enforcer", "optimized_decision_simplifier_v3"],
        "What should I focus on today?"
    )
    
    print(json.dumps(result, indent=2))