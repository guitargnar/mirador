#!/usr/bin/env python3
"""
Enhanced Mirador Framework
Integrates metrics, quality assurance, automation, and memory systems
"""

import os
import json
import asyncio
import time
from datetime import datetime
from typing import Dict, Any, List, Optional, Callable
from concurrent.futures import ThreadPoolExecutor, as_completed
import logging
import hashlib

# Import our new components
from metrics_tracker import MetricsTracker, ExecutionTracker
from quality_assurance import QualityAssurance
from memory_system import MemorySystem
from automation_engine import AutomationEngine

# Import existing framework components
try:
    from framework import Framework
    from mirador import ROLES, CHAINS
except ImportError:
    # Fallback if original files don't exist
    Framework = None
    ROLES = {}
    CHAINS = {}

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class EnhancedMirador:
    """Enhanced Mirador with real metrics, automation, and learning"""
    
    def __init__(self, config_path: str = None):
        # Initialize configuration
        if config_path is None:
            config_path = os.path.expanduser("~/.mirador/config.json")
            
        self.config = self._load_config(config_path)
        
        # Initialize components
        self.metrics = MetricsTracker()
        self.qa = QualityAssurance()
        self.memory = MemorySystem()
        self.automation = AutomationEngine()
        
        # Initialize framework if available
        if Framework:
            self.framework = Framework()
        else:
            self.framework = None
            
        # Thread pool for parallel operations
        self.executor = ThreadPoolExecutor(max_workers=4)
        
        # Session management
        self.active_sessions = {}
        
    def _load_config(self, config_path: str) -> Dict:
        """Load or create configuration"""
        if os.path.exists(config_path):
            with open(config_path, 'r') as f:
                return json.load(f)
        else:
            # Default configuration
            config = {
                'max_concurrent_chains': 3,
                'default_timeout': 300,
                'quality_threshold': 80,
                'enable_automation': True,
                'enable_learning': True,
                'manual_time_estimates': {
                    'analysis': 2.0,
                    'report': 4.0,
                    'decision': 1.0,
                    'research': 3.0
                }
            }
            
            os.makedirs(os.path.dirname(config_path), exist_ok=True)
            with open(config_path, 'w') as f:
                json.dump(config, f, indent=2)
                
            return config
            
    def generate_session_id(self) -> str:
        """Generate unique session ID"""
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        random_hash = hashlib.md5(f"{timestamp}_{time.time()}".encode()).hexdigest()[:8]
        return f"{timestamp}_{random_hash}"
        
    async def run_enhanced_chain(self, prompt: str, chain_type: str = None,
                               models: List[str] = None, context: Dict = None) -> Dict:
        """Run chain with full enhancements"""
        session_id = self.generate_session_id()
        
        # Store session info
        self.active_sessions[session_id] = {
            'start_time': datetime.now(),
            'prompt': prompt,
            'chain_type': chain_type,
            'status': 'running'
        }
        
        try:
            # Get memory context and suggestions
            memory_context = await self._get_memory_context(prompt, session_id)
            suggestions = self.memory.get_suggestions(prompt, context)
            
            # Determine models if not specified
            if not models and chain_type:
                models = CHAINS.get(chain_type, ['enhanced_agent_enforcer'])
            elif not models:
                models = self._auto_select_models(prompt)
                
            # Estimate manual time for this task
            task_type = self._classify_task(prompt)
            manual_estimate = self.config['manual_time_estimates'].get(task_type, 2.0)
            
            # Start metrics tracking
            with self.metrics.start_execution(
                session_id, prompt, models, task_type, manual_estimate
            ) as tracker:
                
                # Run the chain with enhancements
                result = await self._run_chain_with_enhancements(
                    prompt, models, session_id, tracker, memory_context, suggestions
                )
                
                # Quality assurance
                qa_result = self.qa.analyze_output(
                    result['final_output'],
                    output_type=task_type
                )
                
                # Store quality metrics
                tracker.log_quality_metrics(qa_result['scores'])
                
                # If quality is low, attempt to improve
                if not qa_result['passed']:
                    logger.info(f"Quality below threshold, attempting improvement...")
                    result = await self._improve_output(result, qa_result, tracker)
                    
                # Store in memory for future learning
                self.memory.remember(
                    session_id,
                    result['final_output'],
                    memory_type='execution',
                    metadata={
                        'chain_type': chain_type,
                        'task_type': task_type,
                        'quality_score': qa_result['scores']['overall_quality'],
                        'models_used': models
                    }
                )
                
                # Trigger any automation rules
                if self.config['enable_automation']:
                    await self._trigger_automation(result, context)
                    
                # Update session status
                self.active_sessions[session_id]['status'] = 'completed'
                
                return {
                    'session_id': session_id,
                    'result': result,
                    'quality': qa_result,
                    'suggestions_used': suggestions,
                    'memory_context': memory_context,
                    'metrics': {
                        'duration': tracker.duration if hasattr(tracker, 'duration') else 0,
                        'tokens': tracker.tokens_input + tracker.tokens_output,
                        'quality_score': qa_result['scores']['overall_quality']
                    }
                }
                
        except Exception as e:
            logger.error(f"Chain execution failed: {e}")
            self.active_sessions[session_id]['status'] = 'failed'
            
            # Log error in metrics
            if 'tracker' in locals():
                tracker.log_error('execution_error', str(e))
                
            raise
            
    async def _get_memory_context(self, prompt: str, session_id: str) -> Dict:
        """Get relevant context from memory"""
        # Search for similar past executions
        similar_memories = self.memory.recall(prompt, limit=3)
        
        # Get user preferences
        user_id = os.getenv('USER', 'default')
        preferences = self.memory._get_user_preferences(user_id)
        
        # Get patterns
        patterns = self.memory._get_relevant_patterns(prompt)
        
        return {
            'similar_executions': similar_memories,
            'user_preferences': preferences,
            'patterns': patterns,
            'session_id': session_id
        }
        
    def _auto_select_models(self, prompt: str) -> List[str]:
        """Automatically select models based on prompt analysis"""
        prompt_lower = prompt.lower()
        
        # Simple keyword-based selection
        if any(word in prompt_lower for word in ['financial', 'budget', 'cost', 'money']):
            return ['matthew_context_provider_v3', 'financial_planning_expert_v8', 'decision_simplifier_v3']
        elif any(word in prompt_lower for word in ['risk', 'threat', 'vulnerability']):
            return ['risk_analyzer', 'compliance_checker', 'enhanced_agent_enforcer']
        elif any(word in prompt_lower for word in ['code', 'programming', 'debug', 'error']):
            return ['code_expert', 'debug_assistant', 'decision_simplifier_v3']
        else:
            return ['matthew_context_provider_v3', 'enhanced_agent_enforcer', 'decision_simplifier_v3']
            
    def _classify_task(self, prompt: str) -> str:
        """Classify task type from prompt"""
        prompt_lower = prompt.lower()
        
        if any(word in prompt_lower for word in ['analyze', 'review', 'assess']):
            return 'analysis'
        elif any(word in prompt_lower for word in ['report', 'summary', 'document']):
            return 'report'
        elif any(word in prompt_lower for word in ['decide', 'choose', 'recommend']):
            return 'decision'
        elif any(word in prompt_lower for word in ['research', 'find', 'investigate']):
            return 'research'
        else:
            return 'general'
            
    async def _run_chain_with_enhancements(self, prompt: str, models: List[str],
                                          session_id: str, tracker: ExecutionTracker,
                                          memory_context: Dict,
                                          suggestions: List[Dict]) -> Dict:
        """Run the chain with all enhancements"""
        outputs = []
        current_input = prompt
        
        # Add memory context to initial prompt if relevant
        if memory_context['similar_executions']:
            context_addition = "\n\nRelevant context from past interactions:\n"
            for mem in memory_context['similar_executions'][:2]:
                context_addition += f"- {mem['content'][:100]}...\n"
            current_input = prompt + context_addition
            
        # Run models in sequence with parallel capability
        for i, model in enumerate(models):
            start_time = time.time()
            
            # Check if we can run in parallel with next model
            can_parallel = self._can_run_parallel(model, models[i+1] if i+1 < len(models) else None)
            
            if can_parallel and i+1 < len(models):
                # Run two models in parallel
                future1 = self.executor.submit(self._call_model, model, current_input)
                future2 = self.executor.submit(self._call_model, models[i+1], current_input)
                
                output1 = future1.result()
                output2 = future2.result()
                
                # Combine outputs
                combined_output = self._combine_outputs(output1, output2)
                
                outputs.append({
                    'models': [model, models[i+1]],
                    'input': current_input,
                    'output': combined_output,
                    'duration': time.time() - start_time
                })
                
                current_input = combined_output
                i += 1  # Skip next model since we ran it
                
            else:
                # Run single model
                output = self._call_model(model, current_input)
                
                outputs.append({
                    'model': model,
                    'input': current_input,
                    'output': output,
                    'duration': time.time() - start_time
                })
                
                current_input = output
                
            # Track tokens (estimate)
            tracker.log_tokens(
                input_tokens=len(current_input.split()),
                output_tokens=len(output.split()) if 'output' in locals() else len(combined_output.split())
            )
            
        # Save outputs
        self._save_outputs(session_id, outputs)
        
        return {
            'outputs': outputs,
            'final_output': outputs[-1]['output'],
            'total_duration': sum(o['duration'] for o in outputs)
        }
        
    def _can_run_parallel(self, model1: str, model2: str) -> bool:
        """Determine if two models can run in parallel"""
        # Models that can run in parallel (don't depend on each other's output)
        parallel_compatible = {
            ('risk_analyzer', 'compliance_checker'),
            ('code_analyzer', 'security_scanner'),
            ('grammar_checker', 'fact_checker')
        }
        
        return (model1, model2) in parallel_compatible or (model2, model1) in parallel_compatible
        
    def _combine_outputs(self, output1: str, output2: str) -> str:
        """Intelligently combine outputs from parallel models"""
        return f"""
## Combined Analysis

### Analysis 1:
{output1}

### Analysis 2:
{output2}

### Synthesis:
Both analyses have been considered to provide comprehensive insights.
"""
        
    def _call_model(self, model: str, input_text: str) -> str:
        """Call a model (uses ollama or framework)"""
        try:
            # Try using the framework if available
            if self.framework and hasattr(self.framework, 'query_ollama'):
                response = self.framework.query_ollama(input_text, model)
                return response.get('response', '')
            else:
                # Fallback to direct ollama call
                import subprocess
                result = subprocess.run(
                    ['ollama', 'run', model],
                    input=input_text,
                    capture_output=True,
                    text=True,
                    timeout=120
                )
                return result.stdout
                
        except Exception as e:
            logger.error(f"Model call failed for {model}: {e}")
            return f"Error calling model {model}: {str(e)}"
            
    async def _improve_output(self, result: Dict, qa_result: Dict,
                            tracker: ExecutionTracker) -> Dict:
        """Attempt to improve low-quality output"""
        # Create improvement prompt
        improvement_prompt = f"""
The following output did not meet quality standards:

{result['final_output']}

Quality Issues:
{json.dumps(qa_result['errors'], indent=2)}

Recommendations:
{json.dumps(qa_result['recommendations'], indent=2)}

Please improve this output by addressing the identified issues.
"""
        
        # Run through quality improvement model
        improved_output = self._call_model('enhanced_agent_enforcer', improvement_prompt)
        
        # Update result
        result['final_output'] = improved_output
        result['quality_improved'] = True
        
        # Log improvement attempt
        tracker.log_tokens(
            input_tokens=len(improvement_prompt.split()),
            output_tokens=len(improved_output.split())
        )
        
        return result
        
    async def _trigger_automation(self, result: Dict, context: Dict):
        """Trigger automation based on results"""
        # Check for automation triggers in the output
        output_lower = result['final_output'].lower()
        
        # Email trigger
        if context and context.get('send_email') and 'email' in output_lower:
            # Queue email task
            logger.info("Email automation triggered")
            
        # Slack trigger
        if context and context.get('send_slack') and any(word in output_lower for word in ['urgent', 'critical', 'immediate']):
            # Queue Slack notification
            logger.info("Slack notification triggered")
            
    def _save_outputs(self, session_id: str, outputs: List[Dict]):
        """Save outputs to disk"""
        output_dir = os.path.expanduser(f"~/.mirador/outputs/{session_id}")
        os.makedirs(output_dir, exist_ok=True)
        
        # Save each output
        for i, output in enumerate(outputs):
            filename = f"step_{i+1}_{output.get('model', 'combined')}.md"
            filepath = os.path.join(output_dir, filename)
            
            with open(filepath, 'w') as f:
                f.write(f"# Step {i+1}\n\n")
                f.write(f"**Model(s)**: {output.get('model', output.get('models', 'unknown'))}\n\n")
                f.write(f"**Duration**: {output['duration']:.2f}s\n\n")
                f.write("## Input\n\n")
                f.write(output['input'][:500] + "..." if len(output['input']) > 500 else output['input'])
                f.write("\n\n## Output\n\n")
                f.write(output['output'])
                
        # Save final output
        with open(os.path.join(output_dir, 'final_output.md'), 'w') as f:
            f.write(outputs[-1]['output'])
            
        # Save metadata
        metadata = {
            'session_id': session_id,
            'timestamp': datetime.now().isoformat(),
            'models': [o.get('model', o.get('models')) for o in outputs],
            'total_duration': sum(o['duration'] for o in outputs),
            'step_count': len(outputs)
        }
        
        with open(os.path.join(output_dir, 'metadata.json'), 'w') as f:
            json.dump(metadata, f, indent=2)
            
    def record_feedback(self, session_id: str, rating: int, 
                       feedback_text: str = None, time_saved_hours: float = None):
        """Record user feedback for a session"""
        # Update metrics
        self.metrics.record_feedback(session_id, rating, feedback_text, time_saved_hours)
        
        # Update memory system
        memory_id = f"execution_{session_id}_{datetime.now().timestamp()}"
        self.memory.learn_from_feedback(memory_id, rating, feedback_text)
        
        # If positive feedback, reinforce the models used
        if rating >= 4:
            session_info = self.active_sessions.get(session_id, {})
            if session_info and self.config['enable_learning']:
                # Future: Adjust model selection preferences
                pass
                
    def get_dashboard_data(self) -> Dict:
        """Get data for dashboard display"""
        # Get metrics
        metrics_7d = self.metrics.get_aggregate_metrics(days=7)
        metrics_30d = self.metrics.get_aggregate_metrics(days=30)
        
        # Get recent executions
        recent = self.metrics.get_execution_history(limit=10)
        
        # Get automation status
        automation_tasks = self.automation.get_task_status()
        
        # Get memory stats
        memory_stats = self.memory.conn.execute("""
            SELECT 
                COUNT(*) as total_memories,
                COUNT(DISTINCT session_id) as unique_sessions
            FROM memories
        """).fetchone()
        
        return {
            'metrics': {
                '7_days': metrics_7d,
                '30_days': metrics_30d
            },
            'recent_executions': recent,
            'automation_tasks': automation_tasks,
            'memory_stats': dict(memory_stats),
            'active_sessions': len(self.active_sessions),
            'quality_threshold': self.config['quality_threshold']
        }


# Convenience functions for backward compatibility
def run_enhanced_chain(prompt: str, chain_type: str = None, 
                      models: List[str] = None, context: Dict = None) -> Dict:
    """Synchronous wrapper for enhanced chain execution"""
    mirador = EnhancedMirador()
    
    # Run async function in sync context
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    
    try:
        result = loop.run_until_complete(
            mirador.run_enhanced_chain(prompt, chain_type, models, context)
        )
        return result
    finally:
        loop.close()


# CLI interface
if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Enhanced Mirador Framework")
    parser.add_argument('command', choices=['run', 'dashboard', 'feedback'],
                       help='Command to execute')
    parser.add_argument('--prompt', help='Prompt for run command')
    parser.add_argument('--chain', help='Chain type')
    parser.add_argument('--session', help='Session ID for feedback')
    parser.add_argument('--rating', type=int, help='Rating (1-5)')
    
    args = parser.parse_args()
    
    if args.command == 'run':
        if not args.prompt:
            print("Please provide a prompt with --prompt")
        else:
            print("Running enhanced Mirador chain...")
            result = run_enhanced_chain(args.prompt, chain_type=args.chain)
            
            print(f"\n=== Session: {result['session_id']} ===")
            print(f"Quality Score: {result['quality']['scores']['overall_quality']:.1f}/100")
            print(f"Duration: {result['metrics']['duration']:.1f}s")
            print(f"\nOutput:\n{result['result']['final_output']}")
            
    elif args.command == 'dashboard':
        mirador = EnhancedMirador()
        data = mirador.get_dashboard_data()
        
        print("\n=== Mirador Dashboard ===\n")
        print("7-Day Metrics:")
        print(f"  Executions: {data['metrics']['7_days']['total_executions']}")
        print(f"  Success Rate: {data['metrics']['7_days']['success_rate']:.1f}%")
        print(f"  Hours Saved: {data['metrics']['7_days']['total_hours_saved']:.1f}")
        print(f"  ROI: {data['metrics']['7_days']['roi_multiplier']:.1f}x")
        
        print("\nAutomation Tasks:")
        for task in data['automation_tasks']:
            print(f"  {task['name']}: {task['last_status'] or 'Not run'}")
            
    elif args.command == 'feedback':
        if not all([args.session, args.rating]):
            print("Please provide --session and --rating")
        else:
            mirador = EnhancedMirador()
            mirador.record_feedback(args.session, args.rating)
            print(f"Feedback recorded for session {args.session}")