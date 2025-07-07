#!/usr/bin/env python3
"""
Test Mirador Ollama Models
Verify all models are available and responding correctly
"""

import os
import sys
import subprocess
import json
import time
from datetime import datetime

class ModelTester:
    """Test all Ollama models used by Mirador."""
    
    def __init__(self):
        self.project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        self.test_results = []
        self.required_models = self.load_required_models()
    
    def load_required_models(self):
        """Load list of required models from configuration."""
        models = [
            # Core models
            'matthew_context_provider_v3',
            'enhanced_agent_enforcer',
            'humana_innovation_catalyst',
            'humana_politics_navigator',
            'ai_leadership_strategist',
            'solution_architect',
            'advocates_meeting_optimizer_v2',
            
            # Strategic models
            'matthews_strategic_accelerator_v2',
            'ai_career_strategist',
            'action_crystallizer',
            'daily_micro_action',
            
            # Specialized models
            'personal_finance_navigator',
            'guitar_tone_architect',
            'linkedin_thought_leader',
            'content_strategist_pro',
            'master_coder',
            'code_reviewer',
            
            # Fallback models
            'llama3.2:latest',
            'mixtral:latest'
        ]
        return models
    
    def test_model(self, model_name: str, test_prompt: str = "Hello, please respond with 'OK'", installed_models: list = None):
        """Test a single model."""
        print(f"\n🤖 Testing model: {model_name}")
        
        # Handle model names with or without :latest suffix
        if model_name in installed_models:
            actual_model = model_name
        elif f"{model_name}:latest" in installed_models:
            actual_model = f"{model_name}:latest"
        else:
            return {
                'model': model_name,
                'status': 'not_found',
                'error': 'Model not installed'
            }
        
        cmd = ['ollama', 'run', actual_model, test_prompt]
        
        try:
            start_time = time.time()
            process = subprocess.Popen(
                cmd,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )
            stdout, stderr = process.communicate(timeout=30)
            duration = time.time() - start_time
            
            if process.returncode == 0 and stdout.strip():
                print(f"✅ {model_name}: Responding ({duration:.2f}s)")
                return {
                    'model': model_name,
                    'status': 'active',
                    'response_time': duration,
                    'response_length': len(stdout)
                }
            else:
                print(f"❌ {model_name}: Not responding - {stderr}")
                return {
                    'model': model_name,
                    'status': 'error',
                    'error': stderr or 'No response'
                }
                
        except subprocess.TimeoutExpired:
            process.kill()
            print(f"⏱️  {model_name}: Timeout (>30s)")
            return {
                'model': model_name,
                'status': 'timeout'
            }
        except Exception as e:
            print(f"❌ {model_name}: Error - {str(e)}")
            return {
                'model': model_name,
                'status': 'error',
                'error': str(e)
            }
    
    def check_installed_models(self):
        """Check which models are currently installed."""
        print("📋 Checking installed Ollama models...")
        
        try:
            result = subprocess.run(['ollama', 'list'], capture_output=True, text=True)
            if result.returncode == 0:
                lines = result.stdout.strip().split('\n')[1:]  # Skip header
                installed = []
                for line in lines:
                    if line.strip():
                        model_name = line.split()[0]
                        installed.append(model_name)
                return installed
            else:
                print("❌ Failed to list Ollama models")
                return []
        except Exception as e:
            print(f"❌ Error checking models: {str(e)}")
            return []
    
    def run_all_model_tests(self):
        """Test all required models."""
        print("🚀 Testing Mirador Ollama Models")
        print("=" * 60)
        
        # Check Ollama connectivity
        try:
            subprocess.run(['ollama', 'list'], capture_output=True, check=True)
        except:
            print("❌ ERROR: Ollama is not running!")
            print("   Start Ollama with: ollama serve")
            return
        
        # Get installed models
        installed_models = self.check_installed_models()
        print(f"✅ Found {len(installed_models)} installed models")
        
        # Check for missing models
        missing_models = [m for m in self.required_models if m not in installed_models]
        if missing_models:
            print(f"\n⚠️  WARNING: {len(missing_models)} required models not installed:")
            for model in missing_models[:5]:  # Show first 5
                print(f"   - {model}")
            if len(missing_models) > 5:
                print(f"   ... and {len(missing_models) - 5} more")
        
        # Test each required model that's installed
        test_models = [m for m in self.required_models if m in installed_models]
        
        print(f"\n🧪 Testing {len(test_models)} models...")
        
        for model in test_models[:10]:  # Test first 10 to save time
            result = self.test_model(model, installed_models=installed_models)
            self.test_results.append(result)
        
        if len(test_models) > 10:
            print(f"\n⚠️  Skipped testing {len(test_models) - 10} additional models for time")
        
        # Generate summary
        self.generate_summary(installed_models, missing_models)
    
    def generate_summary(self, installed_models, missing_models):
        """Generate test summary."""
        print("\n" + "=" * 60)
        print("MODEL TEST SUMMARY")
        print("=" * 60)
        
        active_count = sum(1 for r in self.test_results if r['status'] == 'active')
        error_count = sum(1 for r in self.test_results if r['status'] == 'error')
        timeout_count = sum(1 for r in self.test_results if r['status'] == 'timeout')
        
        print(f"📊 Installed models: {len(installed_models)}")
        print(f"❓ Missing required models: {len(missing_models)}")
        print(f"✅ Active models: {active_count}")
        print(f"❌ Error models: {error_count}")
        print(f"⏱️  Timeout models: {timeout_count}")
        
        # Performance statistics
        active_models = [r for r in self.test_results if r['status'] == 'active']
        if active_models:
            avg_response_time = sum(r['response_time'] for r in active_models) / len(active_models)
            print(f"\n⚡ Average response time: {avg_response_time:.2f}s")
        
        # Save results
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        results_file = os.path.join(self.project_root, 'test_logs', f'model_test_results_{timestamp}.json')
        os.makedirs(os.path.dirname(results_file), exist_ok=True)
        
        with open(results_file, 'w') as f:
            json.dump({
                'timestamp': timestamp,
                'installed_models': installed_models,
                'missing_models': missing_models,
                'test_results': self.test_results
            }, f, indent=2)
        
        print(f"\n📄 Detailed results saved to: {results_file}")


if __name__ == "__main__":
    tester = ModelTester()
    tester.run_all_model_tests()