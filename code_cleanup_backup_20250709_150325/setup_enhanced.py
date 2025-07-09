#!/usr/bin/env python3
"""
Setup script for Enhanced Mirador
Initializes all components and creates necessary directories
"""

import os
import sys
import json
import subprocess
from pathlib import Path

def setup_directories():
    """Create necessary directories"""
    directories = [
        "~/.mirador",
        "~/.mirador/memory",
        "~/.mirador/memory/chroma",
        "~/.mirador/outputs",
        "~/.mirador/logs",
        "~/mirador_automation",
        "~/mirador_automation/input",
        "~/mirador_automation/output",
        "~/mirador_automation/processed",
        "~/mirador_automation/summaries"
    ]
    
    for dir_path in directories:
        path = os.path.expanduser(dir_path)
        os.makedirs(path, exist_ok=True)
        print(f"✅ Created directory: {path}")

def check_dependencies():
    """Check and install Python dependencies"""
    required_packages = [
        "requests",
        "pyyaml",
        "numpy",
        "sqlite3",  # Built-in
        "schedule"
    ]
    
    optional_packages = [
        ("chromadb", "vector memory storage"),
        ("sentence-transformers", "semantic search"),
        ("watchdog", "file monitoring"),
        ("PyPDF2", "PDF processing"),
        ("slack-sdk", "Slack integration"),
        ("office365-rest-python-client", "SharePoint integration")
    ]
    
    print("\n📦 Checking dependencies...")
    
    # Check required packages
    missing_required = []
    for package in required_packages:
        if package == "sqlite3":
            continue  # Built-in
        try:
            __import__(package.replace("-", "_"))
            print(f"✅ {package} installed")
        except ImportError:
            missing_required.append(package)
            print(f"❌ {package} missing")
    
    # Check optional packages
    missing_optional = []
    for package, description in optional_packages:
        try:
            __import__(package.replace("-", "_"))
            print(f"✅ {package} installed ({description})")
        except ImportError:
            missing_optional.append((package, description))
            print(f"⚠️  {package} not installed ({description})")
    
    # Install missing required packages
    if missing_required:
        print("\n📥 Installing required packages...")
        for package in missing_required:
            subprocess.run([sys.executable, "-m", "pip", "install", package])
    
    # Ask about optional packages
    if missing_optional:
        print("\n❓ Would you like to install optional packages for enhanced features?")
        for package, description in missing_optional:
            response = input(f"Install {package} for {description}? (y/N): ").strip().lower()
            if response == 'y':
                subprocess.run([sys.executable, "-m", "pip", "install", package])

def create_default_configs():
    """Create default configuration files"""
    # Main config
    main_config = {
        "max_concurrent_chains": 3,
        "default_timeout": 300,
        "quality_threshold": 80,
        "enable_automation": True,
        "enable_learning": True,
        "manual_time_estimates": {
            "analysis": 2.0,
            "report": 4.0,
            "decision": 1.0,
            "research": 3.0,
            "general": 2.0
        },
        "integrations": {
            "slack": {
                "enabled": False,
                "token": "YOUR_SLACK_TOKEN",
                "default_channel": "#mirador-notifications"
            },
            "email": {
                "enabled": False,
                "smtp_server": "smtp.gmail.com",
                "smtp_port": 587
            }
        }
    }
    
    config_path = os.path.expanduser("~/.mirador/config.json")
    if not os.path.exists(config_path):
        with open(config_path, 'w') as f:
            json.dump(main_config, f, indent=2)
        print(f"✅ Created main config: {config_path}")
    
    # Automation config
    automation_config = {
        "watch_directories": [
            os.path.expanduser("~/mirador_automation/input")
        ],
        "output_directory": os.path.expanduser("~/mirador_automation/output"),
        "max_concurrent_tasks": 3,
        "task_timeout": 300,
        "notification_webhook": None,
        "scheduled_tasks": [
            {
                "name": "daily_summary",
                "schedule": "daily@09:00",
                "enabled": False
            },
            {
                "name": "quality_monitor",
                "schedule": "interval@60",
                "enabled": False
            }
        ]
    }
    
    automation_config_path = os.path.expanduser("~/.mirador/automation_config.yaml")
    if not os.path.exists(automation_config_path):
        import yaml
        with open(automation_config_path, 'w') as f:
            yaml.dump(automation_config, f, default_flow_style=False)
        print(f"✅ Created automation config: {automation_config_path}")

def create_launcher_scripts():
    """Create convenient launcher scripts"""
    # Enhanced Mirador launcher
    launcher_content = """#!/bin/bash
# Enhanced Mirador Launcher

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$1" == "metrics" ]; then
    python3 "$SCRIPT_DIR/metrics_tracker.py" summary --days "${2:-7}"
elif [ "$1" == "dashboard" ]; then
    python3 "$SCRIPT_DIR/mirador_v2.py" dashboard
elif [ "$1" == "automate" ]; then
    python3 "$SCRIPT_DIR/automation_engine.py" start
elif [ "$1" == "quality" ]; then
    python3 "$SCRIPT_DIR/quality_assurance.py"
elif [ "$1" == "memory" ]; then
    python3 "$SCRIPT_DIR/memory_system.py" "${@:2}"
else
    python3 "$SCRIPT_DIR/mirador_v2.py" "$@"
fi
"""
    
    launcher_path = "mirador-enhanced"
    with open(launcher_path, 'w') as f:
        f.write(launcher_content)
    os.chmod(launcher_path, 0o755)
    print(f"✅ Created launcher: {launcher_path}")
    
    # Quick run script
    quick_run_content = """#!/bin/bash
# Quick Mirador Run

if [ -z "$1" ]; then
    echo "Usage: mirador-run <prompt>"
    exit 1
fi

python3 "$(dirname "$0")/mirador_v2.py" run --prompt "$*"
"""
    
    quick_run_path = "mirador-run"
    with open(quick_run_path, 'w') as f:
        f.write(quick_run_content)
    os.chmod(quick_run_path, 0o755)
    print(f"✅ Created quick run script: {quick_run_path}")

def test_components():
    """Test that all components are working"""
    print("\n🧪 Testing components...")
    
    components = [
        ("Metrics Tracker", "from metrics_tracker import MetricsTracker; MetricsTracker()"),
        ("Quality Assurance", "from quality_assurance import QualityAssurance; QualityAssurance()"),
        ("Memory System", "from memory_system import MemorySystem; MemorySystem()"),
        ("Automation Engine", "from automation_engine import AutomationEngine; AutomationEngine()"),
        ("Enhanced Mirador", "from enhanced_mirador import EnhancedMirador; EnhancedMirador()")
    ]
    
    for name, test_code in components:
        try:
            exec(test_code)
            print(f"✅ {name} initialized successfully")
        except Exception as e:
            print(f"❌ {name} failed: {e}")

def print_next_steps():
    """Print next steps for the user"""
    print("\n" + "="*60)
    print("🎉 Enhanced Mirador Setup Complete!")
    print("="*60)
    print("\n📚 Quick Start Guide:\n")
    print("1. Run interactively:")
    print("   ./mirador-enhanced")
    print("\n2. Quick execution:")
    print("   ./mirador-run 'Your prompt here'")
    print("\n3. View metrics:")
    print("   ./mirador-enhanced metrics")
    print("\n4. Start automation:")
    print("   ./mirador-enhanced automate")
    print("\n5. Check quality:")
    print("   python3 quality_assurance.py")
    print("\n📖 Features Now Available:")
    print("  • Real metrics tracking (97% efficiency is measurable)")
    print("  • Task automation (actually executes tasks)")
    print("  • Quality assurance (validates outputs)")
    print("  • Memory system (learns from usage)")
    print("  • Performance dashboard (see real ROI)")
    print("\n🚀 Try this first:")
    print("  ./mirador-run 'Create a plan to improve my team productivity'")
    print("\n" + "="*60)

def main():
    """Main setup function"""
    print("🔧 Setting up Enhanced Mirador...\n")
    
    # Create directories
    setup_directories()
    
    # Check dependencies
    check_dependencies()
    
    # Create configs
    create_default_configs()
    
    # Create launcher scripts
    create_launcher_scripts()
    
    # Test components
    test_components()
    
    # Print next steps
    print_next_steps()

if __name__ == "__main__":
    main()