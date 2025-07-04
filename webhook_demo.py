#!/usr/bin/env python3
"""
Webhook demo script for Mirador AI Framework

This script demonstrates setting up and testing webhooks with the Mirador framework.
It includes examples of registering webhooks and running a chain to generate webhook events.
"""

import requests
import json
import time
import argparse
import sys

# API base URL
API_BASE = "http://localhost:5001"

def check_api_health():
    """Check if the Mirador API is running"""
    try:
        response = requests.get(f"{API_BASE}/api/health", timeout=5)
        if response.status_code == 200:
            print("✅ API is running")
            return True
        else:
            print(f"❌ API returned status code {response.status_code}")
            return False
    except requests.exceptions.ConnectionError:
        print(f"❌ API not running at {API_BASE}")
        return False

def register_test_webhook(name, url, events):
    """Register a webhook with the Mirador API"""
    data = {
        "name": name,
        "url": url,
        "events": events,
        "headers": {
            "X-Webhook-Source": "webhook-demo"
        },
        "max_retries": 3,
        "active": True
    }
    
    print(f"Registering webhook '{name}' for events: {', '.join(events)}")
    response = requests.post(f"{API_BASE}/api/webhooks", json=data)
    
    if response.status_code == 201:
        result = response.json()
        webhook_id = result["webhook"]["id"]
        print(f"✅ Webhook registered with ID: {webhook_id}")
        return webhook_id
    else:
        print(f"❌ Failed to register webhook: {response.text}")
        return None

def list_webhooks():
    """List all registered webhooks"""
    response = requests.get(f"{API_BASE}/api/webhooks")
    
    if response.status_code == 200:
        webhooks = response.json().get("webhooks", [])
        
        if not webhooks:
            print("No webhooks registered")
            return []
            
        print(f"Found {len(webhooks)} webhooks:")
        for webhook in webhooks:
            print(f"- {webhook['name']} (ID: {webhook['id']})")
            print(f"  URL: {webhook['url']}")
            print(f"  Events: {', '.join(webhook['events'])}")
            print(f"  Active: {webhook['active']}")
            print()
            
        return webhooks
    else:
        print(f"❌ Failed to list webhooks: {response.text}")
        return []

def delete_webhook(webhook_id):
    """Delete a registered webhook"""
    response = requests.delete(f"{API_BASE}/api/webhooks/{webhook_id}")
    
    if response.status_code == 200:
        print(f"✅ Webhook {webhook_id} deleted")
        return True
    else:
        print(f"❌ Failed to delete webhook: {response.text}")
        return False

def test_webhook(webhook_id, event_type="test_event"):
    """Send a test event to a webhook"""
    data = {
        "webhook_id": webhook_id,
        "event_type": event_type
    }
    
    print(f"Testing webhook {webhook_id} with event: {event_type}")
    response = requests.post(f"{API_BASE}/api/webhooks/test", json=data)
    
    if response.status_code == 200:
        result = response.json()
        if result.get("success", False):
            print(f"✅ Test webhook sent successfully (status: {result.get('status_code')})")
        else:
            print(f"❌ Test webhook failed: {result.get('error', 'Unknown error')}")
        return result
    else:
        print(f"❌ Failed to test webhook: {response.text}")
        return None

def run_chain(prompt):
    """Run a Mirador chain to generate webhook events"""
    data = {
        "input": prompt,
        "skip_optional": True
    }
    
    print(f"Running chain with prompt: {prompt}")
    print("This will generate 'persona_completed' and 'chain_completed' webhook events")
    
    response = requests.post(f"{API_BASE}/api/run", json=data)
    
    if response.status_code == 200:
        result = response.json()
        print(f"✅ Chain completed successfully (session: {result.get('session_id')})")
        return result
    else:
        print(f"❌ Failed to run chain: {response.text}")
        return None

def run_persona(persona_id, prompt):
    """Run a single persona to generate webhook events"""
    data = {
        "input": prompt
    }
    
    print(f"Running persona {persona_id} with prompt: {prompt}")
    print("This will generate a 'persona_completed' webhook event")
    
    response = requests.post(f"{API_BASE}/api/run/{persona_id}", json=data)
    
    if response.status_code == 200:
        result = response.json()
        print(f"✅ Persona completed successfully (session: {result.get('session_id')})")
        return result
    else:
        print(f"❌ Failed to run persona: {response.text}")
        return None

def demo_workflow(webhook_url):
    """Run a complete webhook demo workflow"""
    # Step 1: Check API health
    if not check_api_health():
        return
        
    print("\n=== STEP 1: List existing webhooks ===")
    existing_webhooks = list_webhooks()
    
    # Step 2: Register webhooks
    print("\n=== STEP 2: Register webhooks ===")
    chain_webhook_id = register_test_webhook(
        "Chain Completed Demo", 
        webhook_url, 
        ["chain_completed"]
    )
    
    persona_webhook_id = register_test_webhook(
        "Persona Completed Demo", 
        webhook_url, 
        ["persona_completed"]
    )
    
    error_webhook_id = register_test_webhook(
        "Error Events Demo", 
        webhook_url, 
        ["persona_error"]
    )
    
    # Step 3: Test webhooks
    print("\n=== STEP 3: Test webhooks ===")
    if chain_webhook_id:
        test_webhook(chain_webhook_id, "test_chain_event")
        time.sleep(1)  # Small delay between tests
        
    if persona_webhook_id:
        test_webhook(persona_webhook_id, "test_persona_event")
        time.sleep(1)  # Small delay between tests
        
    if error_webhook_id:
        test_webhook(error_webhook_id, "test_error_event")
    
    # Step 4: Run demo chain
    print("\n=== STEP 4: Run a persona to generate webhook events ===")
    run_persona("master_coder", "Create a simple function to calculate factorial in Python")
    
    # Step 5: Run full chain
    print("\n=== STEP 5: Run a full chain to generate webhook events ===")
    run_chain("Create a Python function to check if a string is a palindrome")
    
    print("\nDemo complete! Check the webhook receiver for events.")

def main():
    parser = argparse.ArgumentParser(description="Mirador webhook demo")
    parser.add_argument("--list", action="store_true", help="List registered webhooks")
    parser.add_argument("--delete", help="Delete a webhook by ID")
    parser.add_argument("--test", help="Test a webhook by ID")
    parser.add_argument("--demo", action="store_true", help="Run the full demo workflow")
    parser.add_argument("--url", default="http://localhost:8000", help="Webhook receiver URL")
    
    args = parser.parse_args()
    
    if args.list:
        check_api_health()
        list_webhooks()
        
    elif args.delete:
        check_api_health()
        delete_webhook(args.delete)
        
    elif args.test:
        check_api_health()
        test_webhook(args.test)
        
    elif args.demo:
        demo_workflow(args.url)
        
    else:
        parser.print_help()

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nOperation cancelled by user")
        sys.exit(0)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)