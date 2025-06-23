#!/usr/bin/env python3
"""
Mirador Actionable Instruction System
Daily High-Value Action Generator with Fact Validation
"""

import argparse
import json
import requests
import sys
import time
from datetime import datetime, timedelta
from pathlib import Path
import subprocess
import sqlite3
import hashlib

class MiradorActionableSystem:
    def __init__(self):
        self.ollama_url = "http://localhost:11434"
        self.base_dir = Path.home() / "ai_framework_git"
        self.output_dir = self.base_dir / "outputs"
        self.actions_dir = self.base_dir / "daily_actions"
        self.db_path = self.base_dir / "mirador_actions.db"
        self.timeout = 120
        
        # Create directories
        self.actions_dir.mkdir(parents=True, exist_ok=True)
        self.output_dir.mkdir(parents=True, exist_ok=True)
        
        # Initialize database
        self.init_database()
        
    def init_database(self):
        """Initialize SQLite database for action tracking"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS daily_actions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                date TEXT NOT NULL,
                action_title TEXT NOT NULL,
                action_content TEXT NOT NULL,
                predicted_value TEXT,
                execution_time_estimate INTEGER,
                status TEXT DEFAULT 'generated',
                actual_execution_time INTEGER,
                outcome_notes TEXT,
                value_realized TEXT,
                created_timestamp TEXT,
                completed_timestamp TEXT,
                verification_status TEXT,
                source_chain_id TEXT
            )
        ''')
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS fact_validations (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                action_id INTEGER,
                fact_claim TEXT NOT NULL,
                verification_source TEXT,
                verification_status TEXT,
                verification_timestamp TEXT,
                confidence_level TEXT,
                FOREIGN KEY (action_id) REFERENCES daily_actions (id)
            )
        ''')
        
        conn.commit()
        conn.close()
        
    def query_model(self, model_name, prompt, context="", max_retries=3):
        """Query a single model with retry logic and validation"""
        full_prompt = f"{context}\n\n{prompt}" if context else prompt
        
        for attempt in range(max_retries):
            try:
                payload = {
                    "model": model_name,
                    "prompt": full_prompt,
                    "stream": False
                }
                
                print(f"Querying {model_name}... (attempt {attempt + 1})")
                start_time = time.time()
                
                response = requests.post(
                    f"{self.ollama_url}/api/generate",
                    json=payload,
                    timeout=self.timeout
                )
                
                end_time = time.time()
                duration = end_time - start_time
                
                if response.status_code == 200:
                    result = response.json()
                    response_text = result.get('response', '')
                    if len(response_text.strip()) > 50:
                        print(f"✓ {model_name} completed ({duration:.0f}s)")
                        return response_text
                    else:
                        print(f"⚠ {model_name} returned short response, retrying...")
                        continue
                else:
                    print(f"⚠ HTTP {response.status_code}, retrying...")
                    continue
                    
            except requests.exceptions.Timeout:
                print(f"⚠ {model_name} timeout (attempt {attempt + 1}), retrying...")
                continue
            except Exception as e:
                print(f"⚠ Error with {model_name}: {e}")
                if attempt == max_retries - 1:
                    return f"Error: Failed to get response from {model_name} after {max_retries} attempts"
                continue
        
        return f"Error: {model_name} failed after {max_retries} attempts"
    
    def generate_daily_action(self, context_override=None):
        """Generate today's high-value action instruction"""
        today = datetime.now().strftime("%Y-%m-%d")
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        
        print(f"🎯 Generating daily action for {today}")
        print("=" * 50)
        
        # Step 1: Opportunity Identification
        print("\n📊 Step 1: Identifying opportunities...")
        
        if context_override:
            opportunity_prompt = f"Context: {context_override}\n\nIdentify the highest-value opportunity available today that can be acted upon immediately."
        else:
            opportunity_prompt = """Analyze Matthew's current situation for immediate opportunities:
            
            Current Context:
            - Location: Louisville, Jefferson County, Kentucky
            - Combined household income: ~$145,000
            - Mortgage remaining: ~$49,000
            - Monthly take-home: ~$6,200
            - Goals: Financial optimization, local resource utilization, professional development
            
            Identify the single highest-value opportunity available today that can be converted into immediate action."""
        
        opportunity_analysis = self.query_model("opportunity_identification_specialist", opportunity_prompt)
        
        if "Error:" in opportunity_analysis:
            print(f"❌ Opportunity identification failed: {opportunity_analysis}")
            return None
            
        # Step 2: Local Context Enhancement
        print("\n🏙️ Step 2: Adding Louisville-specific context...")
        
        local_context_prompt = f"""Enhance this opportunity with Louisville/Jefferson County specific information:
        
        Identified Opportunity:
        {opportunity_analysis}
        
        Add specific Louisville resources, contacts, locations, and local considerations that make this opportunity more actionable and valuable."""
        
        local_enhancement = self.query_model("louisville_expert_v2", local_context_prompt)
        
        # Step 3: Financial Analysis
        print("\n💰 Step 3: Financial impact analysis...")
        
        financial_prompt = f"""Analyze the financial implications of this opportunity:
        
        Enhanced Opportunity:
        {local_enhancement}
        
        Provide specific financial analysis including costs, potential savings, ROI, and budget impact for Matthew's situation."""
        
        financial_analysis = self.query_model("financial_planning_expert_v5", financial_prompt)
        
        # Step 4: Instruction Generation
        print("\n📋 Step 4: Converting to executable instruction...")
        
        instruction_prompt = f"""Convert this analyzed opportunity into a specific, executable instruction:
        
        Opportunity Analysis:
        {opportunity_analysis}
        
        Local Context:
        {local_enhancement}
        
        Financial Analysis:
        {financial_analysis}
        
        Create a clear, step-by-step instruction that can be executed today with confidence."""
        
        instruction = self.query_model("instruction_generation_specialist", instruction_prompt)
        
        # Step 5: Fact Validation
        print("\n✅ Step 5: Validating factual accuracy...")
        
        validation_prompt = f"""Validate all factual claims in this instruction:
        
        Generated Instruction:
        {instruction}
        
        Verify all contact information, business hours, program requirements, financial data, and other factual claims. Flag any information that needs verification or updating."""
        
        validation_result = self.query_model("fact_validation_specialist", validation_prompt)
        
        # Step 6: Save and Track
        print("\n💾 Step 6: Saving action and creating tracking record...")
        
        action_data = {
            'opportunity_analysis': opportunity_analysis,
            'local_enhancement': local_enhancement,
            'financial_analysis': financial_analysis,
            'instruction': instruction,
            'validation': validation_result,
            'generated_timestamp': datetime.now().isoformat(),
            'date': today
        }
        
        # Save to file
        action_file = self.actions_dir / f"action_{timestamp}.json"
        with open(action_file, 'w') as f:
            json.dump(action_data, f, indent=2)
            
        # Save formatted instruction
        formatted_file = self.actions_dir / f"daily_action_{today}.md"
        formatted_content = f"""# Daily High-Value Action - {today}

## 🎯 Today's Instruction
{instruction}

## ✅ Fact Validation
{validation_result}

## 📊 Supporting Analysis

### Opportunity Identification
{opportunity_analysis}

### Louisville Context
{local_enhancement}

### Financial Impact
{financial_analysis}

---
*Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}*
*Chain ID: {timestamp}*
"""
        
        with open(formatted_file, 'w') as f:
            f.write(formatted_content)
            
        # Save to database
        self.save_action_to_db(action_data, timestamp)
        
        print(f"\n🎉 Daily action generated successfully!")
        print(f"📁 Saved to: {formatted_file}")
        print(f"🔗 Chain ID: {timestamp}")
        
        return {
            'file_path': formatted_file,
            'chain_id': timestamp,
            'action_data': action_data
        }
    
    def save_action_to_db(self, action_data, chain_id):
        """Save action to database for tracking"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Extract action title from instruction
        instruction_lines = action_data['instruction'].split('\n')
        action_title = "Daily Action"
        for line in instruction_lines:
            if line.strip() and not line.startswith('**') and len(line.strip()) > 10:
                action_title = line.strip()[:100]
                break
        
        cursor.execute('''
            INSERT INTO daily_actions 
            (date, action_title, action_content, created_timestamp, verification_status, source_chain_id)
            VALUES (?, ?, ?, ?, ?, ?)
        ''', (
            action_data['date'],
            action_title,
            action_data['instruction'],
            action_data['generated_timestamp'],
            'pending',
            chain_id
        ))
        
        conn.commit()
        conn.close()
    
    def mark_action_completed(self, date, execution_time=None, outcome_notes="", value_realized=""):
        """Mark an action as completed with outcome tracking"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            UPDATE daily_actions 
            SET status = 'completed', 
                completed_timestamp = ?,
                actual_execution_time = ?,
                outcome_notes = ?,
                value_realized = ?
            WHERE date = ?
        ''', (
            datetime.now().isoformat(),
            execution_time,
            outcome_notes,
            value_realized,
            date
        ))
        
        conn.commit()
        conn.close()
        print(f"✅ Action for {date} marked as completed")
    
    def get_action_history(self, days=7):
        """Get recent action history"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            SELECT date, action_title, status, value_realized, outcome_notes
            FROM daily_actions 
            ORDER BY date DESC 
            LIMIT ?
        ''', (days,))
        
        results = cursor.fetchall()
        conn.close()
        
        return results
    
    def show_today_action(self):
        """Display today's action if it exists"""
        today = datetime.now().strftime("%Y-%m-%d")
        action_file = self.actions_dir / f"daily_action_{today}.md"
        
        if action_file.exists():
            print(f"📋 Today's Action ({today}):")
            print("=" * 50)
            with open(action_file, 'r') as f:
                content = f.read()
                # Show just the instruction part
                lines = content.split('\n')
                in_instruction = False
                for line in lines:
                    if line.startswith('## 🎯 Today\'s Instruction'):
                        in_instruction = True
                        continue
                    elif line.startswith('## ✅ Fact Validation'):
                        break
                    elif in_instruction:
                        print(line)
        else:
            print(f"❌ No action generated for {today}")
            print("Run: mirador-action generate")

def main():
    parser = argparse.ArgumentParser(description="Mirador Actionable Instruction System")
    subparsers = parser.add_subparsers(dest='command', help='Available commands')
    
    # Generate command
    generate_parser = subparsers.add_parser('generate', help='Generate today\'s action')
    generate_parser.add_argument('--context', help='Override context for opportunity identification')
    
    # Show command
    show_parser = subparsers.add_parser('show', help='Show today\'s action')
    
    # Complete command
    complete_parser = subparsers.add_parser('complete', help='Mark action as completed')
    complete_parser.add_argument('date', help='Date of action (YYYY-MM-DD)')
    complete_parser.add_argument('--time', type=int, help='Execution time in minutes')
    complete_parser.add_argument('--outcome', help='Outcome notes')
    complete_parser.add_argument('--value', help='Value realized')
    
    # History command
    history_parser = subparsers.add_parser('history', help='Show action history')
    history_parser.add_argument('--days', type=int, default=7, help='Number of days to show')
    
    args = parser.parse_args()
    
    system = MiradorActionableSystem()
    
    if args.command == 'generate':
        result = system.generate_daily_action(args.context)
        if result:
            print(f"\n📖 To view: mirador-action show")
            print(f"✅ To complete: mirador-action complete {datetime.now().strftime('%Y-%m-%d')} --time [minutes] --outcome '[notes]' --value '[value]'")
    
    elif args.command == 'show':
        system.show_today_action()
    
    elif args.command == 'complete':
        system.mark_action_completed(
            args.date, 
            args.time, 
            args.outcome or "", 
            args.value or ""
        )
    
    elif args.command == 'history':
        history = system.get_action_history(args.days)
        print(f"📊 Action History (Last {args.days} days):")
        print("=" * 60)
        for date, title, status, value, outcome in history:
            status_icon = "✅" if status == "completed" else "⏳"
            print(f"{status_icon} {date}: {title[:50]}...")
            if value:
                print(f"   💰 Value: {value}")
            if outcome:
                print(f"   📝 Outcome: {outcome[:100]}...")
            print()
    
    else:
        parser.print_help()

if __name__ == "__main__":
    main()

