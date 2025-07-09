#!/usr/bin/env python3
"""
Automation Engine for Mirador
Enables scheduled and triggered task execution with real automation capabilities
"""

import os
import json
import time
import threading
import subprocess
import schedule
from datetime import datetime, timedelta
from typing import Dict, Any, List, Callable, Optional
import logging
from pathlib import Path
import hashlib
import shutil
import yaml

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class AutomationEngine:
    """Task automation engine with scheduling and event triggers"""
    
    def __init__(self, config_path: str = None):
        if config_path is None:
            config_path = os.path.expanduser("~/.mirador/automation_config.yaml")
            
        self.config_path = config_path
        self.tasks = {}
        self.running = False
        self.thread = None
        self.observers = []
        
        # Load configuration
        self._load_config()
        
        # Initialize task history
        self.history_file = os.path.expanduser("~/.mirador/automation_history.json")
        self.task_history = self._load_history()
        
    def _load_config(self):
        """Load automation configuration"""
        if os.path.exists(self.config_path):
            with open(self.config_path, 'r') as f:
                self.config = yaml.safe_load(f) or {}
        else:
            self.config = {
                'watch_directories': [],
                'output_directory': os.path.expanduser("~/mirador_automation"),
                'max_concurrent_tasks': 3,
                'task_timeout': 300,  # 5 minutes
                'notification_webhook': None
            }
            self._save_config()
            
    def _save_config(self):
        """Save automation configuration"""
        os.makedirs(os.path.dirname(self.config_path), exist_ok=True)
        with open(self.config_path, 'w') as f:
            yaml.dump(self.config, f, default_flow_style=False)
            
    def _load_history(self) -> List[Dict]:
        """Load task execution history"""
        if os.path.exists(self.history_file):
            with open(self.history_file, 'r') as f:
                return json.load(f)
        return []
        
    def _save_history(self):
        """Save task execution history"""
        os.makedirs(os.path.dirname(self.history_file), exist_ok=True)
        with open(self.history_file, 'w') as f:
            json.dump(self.task_history[-1000:], f, indent=2)  # Keep last 1000 entries
            
    def register_task(self, name: str, func: Callable, triggers: Dict[str, Any], 
                     description: str = None):
        """Register an automated task with triggers"""
        self.tasks[name] = {
            'function': func,
            'triggers': triggers,
            'description': description,
            'last_run': None,
            'run_count': 0,
            'last_status': None
        }
        
        # Set up scheduled triggers
        if 'schedule' in triggers:
            self._setup_schedule(name, triggers['schedule'])
            
        # Set up file watchers
        if 'file_watch' in triggers:
            self._setup_file_watcher(name, triggers['file_watch'])
            
        # Set up time-based triggers
        if 'interval' in triggers:
            self._setup_interval(name, triggers['interval'])
            
        logger.info(f"Registered task: {name}")
        
    def _setup_schedule(self, task_name: str, schedule_config: Dict):
        """Set up scheduled task execution"""
        if schedule_config['type'] == 'daily':
            schedule.every().day.at(schedule_config['time']).do(
                self._run_task_safe, task_name)
        elif schedule_config['type'] == 'weekly':
            day = schedule_config.get('day', 'monday')
            getattr(schedule.every(), day.lower()).at(
                schedule_config['time']).do(self._run_task_safe, task_name)
        elif schedule_config['type'] == 'hourly':
            schedule.every().hour.at(schedule_config.get('minute', ':00')).do(
                self._run_task_safe, task_name)
                
    def _setup_interval(self, task_name: str, interval_config: Dict):
        """Set up interval-based task execution"""
        minutes = interval_config.get('minutes', 60)
        schedule.every(minutes).minutes.do(self._run_task_safe, task_name)
        
    def _setup_file_watcher(self, task_name: str, watch_config: Dict):
        """Set up file system watcher for triggers"""
        try:
            from watchdog.observers import Observer
            from watchdog.events import FileSystemEventHandler
            
            class TaskTriggerHandler(FileSystemEventHandler):
                def __init__(self, engine, task_name, patterns):
                    self.engine = engine
                    self.task_name = task_name
                    self.patterns = patterns
                    self.last_trigger = {}
                    
                def should_trigger(self, path: str) -> bool:
                    """Check if file matches patterns and hasn't been triggered recently"""
                    # Check patterns
                    if self.patterns:
                        filename = os.path.basename(path)
                        if not any(self._match_pattern(filename, p) for p in self.patterns):
                            return False
                            
                    # Debounce - don't trigger same file within 5 seconds
                    now = time.time()
                    if path in self.last_trigger:
                        if now - self.last_trigger[path] < 5:
                            return False
                            
                    self.last_trigger[path] = now
                    return True
                    
                def _match_pattern(self, filename: str, pattern: str) -> bool:
                    """Simple pattern matching"""
                    import fnmatch
                    return fnmatch.fnmatch(filename, pattern)
                    
                def on_created(self, event):
                    if not event.is_directory and self.should_trigger(event.src_path):
                        logger.info(f"File created: {event.src_path}, triggering {self.task_name}")
                        self.engine._run_task_safe(self.task_name, trigger_file=event.src_path)
                        
                def on_modified(self, event):
                    if not event.is_directory and watch_config.get('on_modify', False):
                        if self.should_trigger(event.src_path):
                            logger.info(f"File modified: {event.src_path}, triggering {self.task_name}")
                            self.engine._run_task_safe(self.task_name, trigger_file=event.src_path)
                            
            observer = Observer()
            handler = TaskTriggerHandler(
                self, task_name, 
                watch_config.get('patterns', ['*'])
            )
            
            observer.schedule(
                handler,
                watch_config['path'],
                recursive=watch_config.get('recursive', False)
            )
            
            self.observers.append(observer)
            observer.start()
            
        except ImportError:
            logger.warning("watchdog not installed, file watching disabled")
            
    def _run_task_safe(self, task_name: str, **kwargs):
        """Safely run a task with error handling"""
        try:
            self._run_task(task_name, **kwargs)
        except Exception as e:
            logger.error(f"Error running task {task_name}: {e}")
            self._record_execution(task_name, False, error=str(e))
            
    def _run_task(self, task_name: str, **kwargs):
        """Execute a registered task"""
        if task_name not in self.tasks:
            logger.error(f"Unknown task: {task_name}")
            return
            
        task = self.tasks[task_name]
        start_time = datetime.now()
        
        logger.info(f"Starting task: {task_name}")
        
        try:
            # Run the task function
            result = task['function'](**kwargs)
            
            # Update task info
            task['last_run'] = start_time
            task['run_count'] += 1
            task['last_status'] = 'success'
            
            # Record successful execution
            self._record_execution(task_name, True, result=result, 
                                 duration=(datetime.now() - start_time).total_seconds())
            
            logger.info(f"Task completed successfully: {task_name}")
            
            # Trigger dependent tasks
            if 'triggers_next' in task['triggers']:
                for next_task in task['triggers']['next_tasks']:
                    logger.info(f"Triggering dependent task: {next_task}")
                    self._run_task_safe(next_task, parent_task=task_name)
                    
            # Send notification if configured
            if result and self.config.get('notification_webhook'):
                self._send_notification(task_name, True, result)
                
        except Exception as e:
            task['last_status'] = 'failed'
            logger.error(f"Task failed: {task_name} - {e}")
            raise
            
    def _record_execution(self, task_name: str, success: bool, 
                         result: Any = None, error: str = None, duration: float = None):
        """Record task execution in history"""
        execution = {
            'task_name': task_name,
            'timestamp': datetime.now().isoformat(),
            'success': success,
            'duration_seconds': duration,
            'result_summary': str(result)[:200] if result else None,
            'error': error
        }
        
        self.task_history.append(execution)
        self._save_history()
        
    def _send_notification(self, task_name: str, success: bool, result: Any = None):
        """Send notification about task completion"""
        try:
            import requests
            
            webhook_url = self.config['notification_webhook']
            
            message = {
                'text': f"Task '{task_name}' {'completed successfully' if success else 'failed'}",
                'attachments': [{
                    'color': 'good' if success else 'danger',
                    'fields': [
                        {'title': 'Task', 'value': task_name, 'short': True},
                        {'title': 'Status', 'value': 'Success' if success else 'Failed', 'short': True},
                        {'title': 'Time', 'value': datetime.now().strftime('%Y-%m-%d %H:%M:%S'), 'short': True},
                        {'title': 'Result', 'value': str(result)[:500] if result else 'N/A', 'short': False}
                    ]
                }]
            }
            
            requests.post(webhook_url, json=message, timeout=5)
            
        except Exception as e:
            logger.error(f"Failed to send notification: {e}")
            
    def start(self):
        """Start the automation engine"""
        if self.running:
            logger.warning("Automation engine already running")
            return
            
        self.running = True
        
        # Start scheduler in background thread
        def run_scheduler():
            while self.running:
                schedule.run_pending()
                time.sleep(1)
                
        self.thread = threading.Thread(target=run_scheduler, daemon=True)
        self.thread.start()
        
        logger.info("Automation engine started")
        
    def stop(self):
        """Stop the automation engine"""
        self.running = False
        
        # Stop file observers
        for observer in self.observers:
            observer.stop()
            observer.join()
            
        # Wait for scheduler thread
        if self.thread:
            self.thread.join(timeout=5)
            
        logger.info("Automation engine stopped")
        
    def get_task_status(self) -> List[Dict]:
        """Get status of all registered tasks"""
        status = []
        
        for name, task in self.tasks.items():
            status.append({
                'name': name,
                'description': task.get('description', ''),
                'last_run': task['last_run'].isoformat() if task['last_run'] else None,
                'run_count': task['run_count'],
                'last_status': task['last_status'],
                'triggers': list(task['triggers'].keys())
            })
            
        return status
        
    def get_recent_executions(self, limit: int = 10) -> List[Dict]:
        """Get recent task executions"""
        return self.task_history[-limit:]


# Built-in automation tasks
def automated_report_processor(trigger_file: str = None, **kwargs):
    """Process reports automatically when they arrive"""
    import PyPDF2
    from framework import run_framework_chain
    
    results = []
    
    # Find files to process
    if trigger_file:
        files = [trigger_file]
    else:
        # Look for unprocessed files
        input_dir = os.path.expanduser("~/mirador_automation/input")
        files = [f for f in os.listdir(input_dir) if f.endswith('.pdf')]
        
    for file_path in files:
        try:
            # Extract text from PDF
            with open(file_path, 'rb') as f:
                reader = PyPDF2.PdfReader(f)
                text = ""
                for page in reader.pages:
                    text += page.extract_text()
                    
            # Run through Mirador chain
            result = run_framework_chain(
                f"Analyze this report and extract key findings:\n\n{text[:2000]}",
                models=['enhanced_agent_enforcer', 'decision_simplifier_v3']
            )
            
            # Save processed result
            output_dir = os.path.expanduser("~/mirador_automation/output")
            os.makedirs(output_dir, exist_ok=True)
            
            output_file = os.path.join(
                output_dir, 
                f"analyzed_{os.path.basename(file_path)}.md"
            )
            
            with open(output_file, 'w') as f:
                f.write(result['final_output'])
                
            # Move processed file
            processed_dir = os.path.expanduser("~/mirador_automation/processed")
            os.makedirs(processed_dir, exist_ok=True)
            shutil.move(file_path, os.path.join(processed_dir, os.path.basename(file_path)))
            
            results.append({
                'file': os.path.basename(file_path),
                'output': output_file,
                'status': 'success'
            })
            
        except Exception as e:
            logger.error(f"Failed to process {file_path}: {e}")
            results.append({
                'file': os.path.basename(file_path),
                'error': str(e),
                'status': 'failed'
            })
            
    return {'processed': len(results), 'results': results}


def automated_daily_summary(**kwargs):
    """Generate daily summary of activities"""
    from metrics_tracker import MetricsTracker
    from framework import run_framework_chain
    
    # Get today's metrics
    tracker = MetricsTracker()
    metrics = tracker.get_aggregate_metrics(days=1)
    
    # Get recent executions
    recent = tracker.get_execution_history(limit=10)
    
    # Generate summary using AI
    prompt = f"""
    Generate an executive summary for today's Mirador activities:
    
    Metrics:
    - Total Executions: {metrics['total_executions']}
    - Success Rate: {metrics['success_rate']:.1f}%
    - Hours Saved: {metrics['total_hours_saved']:.1f}
    - Average Quality: {metrics['avg_quality_score']:.1f}/100
    
    Recent Activities:
    {chr(10).join([f"- {exec['task_type'] or 'General'}: {exec['prompt'][:50]}..." 
                   for exec in recent[:5]])}
    
    Create a brief, actionable summary with key insights and recommendations.
    """
    
    result = run_framework_chain(
        prompt,
        models=['matthew_context_provider_v3', 'enhanced_agent_enforcer', 'decision_simplifier_v3']
    )
    
    # Save summary
    summary_dir = os.path.expanduser("~/mirador_automation/summaries")
    os.makedirs(summary_dir, exist_ok=True)
    
    summary_file = os.path.join(
        summary_dir,
        f"daily_summary_{datetime.now().strftime('%Y%m%d')}.md"
    )
    
    with open(summary_file, 'w') as f:
        f.write(f"# Mirador Daily Summary - {datetime.now().strftime('%Y-%m-%d')}\n\n")
        f.write(result['final_output'])
        
    return {
        'summary_file': summary_file,
        'metrics': metrics,
        'execution_count': metrics['total_executions']
    }


def automated_quality_monitor(**kwargs):
    """Monitor quality of recent outputs and alert on issues"""
    from metrics_tracker import MetricsTracker
    from quality_assurance import QualityAssurance
    
    tracker = MetricsTracker()
    qa = QualityAssurance()
    
    # Get recent executions
    recent = tracker.get_execution_history(limit=20)
    
    issues = []
    
    for exec in recent:
        if exec['success'] and not exec.get('overall_quality'):
            # Quality not yet assessed, check it
            session_dir = os.path.expanduser(
                f"~/ai_framework_git/outputs/{exec['session_id']}"
            )
            
            final_output_file = os.path.join(session_dir, "final_output.md")
            
            if os.path.exists(final_output_file):
                with open(final_output_file, 'r') as f:
                    output_text = f.read()
                    
                # Analyze quality
                quality_result = qa.analyze_output(output_text)
                
                if not quality_result['passed']:
                    issues.append({
                        'session_id': exec['session_id'],
                        'quality_score': quality_result['scores']['overall_quality'],
                        'errors': quality_result['errors'],
                        'recommendations': quality_result['recommendations']
                    })
                    
    return {
        'checked': len(recent),
        'issues_found': len(issues),
        'issues': issues
    }


# CLI interface
if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Mirador Automation Engine")
    parser.add_argument('command', choices=['start', 'stop', 'status', 'history', 'register'],
                       help='Command to execute')
    parser.add_argument('--task', help='Task name (for register command)')
    parser.add_argument('--schedule', help='Schedule (e.g., "daily@09:00")')
    parser.add_argument('--watch', help='Directory to watch')
    
    args = parser.parse_args()
    
    engine = AutomationEngine()
    
    if args.command == 'start':
        # Register built-in tasks
        engine.register_task(
            'daily_summary',
            automated_daily_summary,
            {'schedule': {'type': 'daily', 'time': '09:00'}},
            description="Generate daily activity summary"
        )
        
        engine.register_task(
            'report_processor',
            automated_report_processor,
            {'file_watch': {
                'path': os.path.expanduser('~/mirador_automation/input'),
                'patterns': ['*.pdf', '*.docx'],
                'recursive': False
            }},
            description="Process incoming reports automatically"
        )
        
        engine.register_task(
            'quality_monitor',
            automated_quality_monitor,
            {'interval': {'minutes': 60}},
            description="Monitor output quality hourly"
        )
        
        # Start engine
        engine.start()
        print("Automation engine started. Press Ctrl+C to stop.")
        
        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            engine.stop()
            print("\nAutomation engine stopped.")
            
    elif args.command == 'status':
        status = engine.get_task_status()
        print("\n=== Automation Task Status ===\n")
        
        for task in status:
            print(f"Task: {task['name']}")
            print(f"  Description: {task['description']}")
            print(f"  Triggers: {', '.join(task['triggers'])}")
            print(f"  Last Run: {task['last_run'] or 'Never'}")
            print(f"  Run Count: {task['run_count']}")
            print(f"  Status: {task['last_status'] or 'Not run'}")
            print()
            
    elif args.command == 'history':
        history = engine.get_recent_executions(limit=10)
        print("\n=== Recent Task Executions ===\n")
        
        for exec in history:
            print(f"Task: {exec['task_name']}")
            print(f"  Time: {exec['timestamp']}")
            print(f"  Success: {'Yes' if exec['success'] else 'No'}")
            if exec['error']:
                print(f"  Error: {exec['error']}")
            print()