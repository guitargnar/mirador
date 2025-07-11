#!/usr/bin/env python3
"""
Command-line interface for Mirador SDK
"""
import os
import sys
import json
import asyncio
import argparse
from typing import Optional, Dict, Any
from pathlib import Path

from .client import MiradorClient
from .async_client import AsyncMiradorClient
from .exceptions import MiradorError, AuthenticationError, RateLimitError
from .models import OutputFormat


# Configuration file path
CONFIG_DIR = Path.home() / ".mirador"
CONFIG_FILE = CONFIG_DIR / "config.json"


def load_config() -> Dict[str, Any]:
    """Load configuration from file"""
    if CONFIG_FILE.exists():
        with open(CONFIG_FILE, "r") as f:
            return json.load(f)
    return {}


def save_config(config: Dict[str, Any]):
    """Save configuration to file"""
    CONFIG_DIR.mkdir(exist_ok=True)
    with open(CONFIG_FILE, "w") as f:
        json.dump(config, f, indent=2)
    # Set permissions to user-only
    CONFIG_FILE.chmod(0o600)


def configure_cmd(args):
    """Configure Mirador credentials"""
    config = load_config()
    
    print("Mirador CLI Configuration")
    print("=" * 50)
    
    # API Key
    current_key = config.get("api_key", "")
    if current_key:
        print(f"Current API Key: {current_key[:8]}..." + "*" * 20)
    
    api_key = input("Enter API Key (leave empty to keep current): ").strip()
    if api_key:
        config["api_key"] = api_key
    
    # Base URL
    current_url = config.get("base_url", "http://localhost:5000")
    print(f"Current Base URL: {current_url}")
    
    base_url = input("Enter Base URL (leave empty to keep current): ").strip()
    if base_url:
        config["base_url"] = base_url
    
    # Save configuration
    save_config(config)
    print("\nConfiguration saved successfully!")


def query_cmd(args):
    """Execute a query"""
    config = load_config()
    
    if not config.get("api_key") and not args.api_key:
        print("Error: No API key configured. Run 'mirador configure' first.")
        sys.exit(1)
    
    try:
        client = MiradorClient(
            api_key=args.api_key or config.get("api_key"),
            base_url=args.base_url or config.get("base_url", "http://localhost:5000")
        )
        
        response = client.query(
            prompt=args.prompt,
            chain_type=args.chain,
            format=args.format or OutputFormat.DETAILED,
            session_id=args.session
        )
        
        if args.json:
            print(json.dumps(response.model_dump(), indent=2))
        else:
            print(response.content)
            if args.verbose:
                print(f"\nSession ID: {response.session_id}")
                print(f"Execution time: {response.execution_time:.2f}s")
                if response.models_used:
                    print(f"Models used: {', '.join(response.models_used)}")
                    
    except AuthenticationError:
        print("Error: Authentication failed. Check your API key.")
        sys.exit(1)
    except RateLimitError as e:
        print(f"Error: Rate limit exceeded. Retry after {e.retry_after} seconds.")
        sys.exit(1)
    except MiradorError as e:
        print(f"Error: {e.message}")
        sys.exit(1)


def chain_cmd(args):
    """Run a specific chain"""
    config = load_config()
    
    if not config.get("api_key") and not args.api_key:
        print("Error: No API key configured. Run 'mirador configure' first.")
        sys.exit(1)
    
    try:
        client = MiradorClient(
            api_key=args.api_key or config.get("api_key"),
            base_url=args.base_url or config.get("base_url", "http://localhost:5000")
        )
        
        if args.list:
            # List available chains
            chains = client.chains.list()
            print("Available chains:")
            for chain in chains:
                print(f"  - {chain.type}: {chain.description}")
        else:
            # Run chain
            response = client.chains.run(
                chain_type=args.chain_type,
                prompt=args.prompt,
                format=args.format or OutputFormat.DETAILED,
                session_id=args.session
            )
            
            if args.json:
                print(json.dumps(response.model_dump(), indent=2))
            else:
                if response.summary:
                    print(response.summary)
                else:
                    for result in response.results:
                        print(f"\n[{result.get('model', 'Unknown')}]")
                        print(result.get('output', ''))
                        
    except MiradorError as e:
        print(f"Error: {e.message}")
        sys.exit(1)


async def stream_async(args):
    """Stream a response asynchronously"""
    config = load_config()
    
    async with AsyncMiradorClient(
        api_key=args.api_key or config.get("api_key"),
        base_url=args.base_url or config.get("base_url", "http://localhost:5000")
    ) as client:
        try:
            print("Streaming response...\n")
            
            async for token in client.stream(
                prompt=args.prompt,
                chain_type=args.chain,
                session_id=args.session
            ):
                print(token.content, end="", flush=True)
                
            print("\n\nStream completed.")
            
        except KeyboardInterrupt:
            print("\n\nStream interrupted.")
        except MiradorError as e:
            print(f"\nError: {e.message}")
            sys.exit(1)


def stream_cmd(args):
    """Stream a response"""
    asyncio.run(stream_async(args))


def models_cmd(args):
    """Manage models"""
    config = load_config()
    
    if not config.get("api_key") and not args.api_key:
        print("Error: No API key configured. Run 'mirador configure' first.")
        sys.exit(1)
    
    try:
        client = MiradorClient(
            api_key=args.api_key or config.get("api_key"),
            base_url=args.base_url or config.get("base_url", "http://localhost:5000")
        )
        
        if args.action == "list":
            models = client.models.list()
            print("Available models:")
            for model in models:
                print(f"  - {model.name}")
                if args.verbose:
                    print(f"    Type: {model.type}")
                    print(f"    Version: {model.version}")
                    if model.description:
                        print(f"    Description: {model.description}")
                    print()
        
        elif args.action == "info":
            model = client.models.get(args.model_name)
            print(f"Model: {model.name}")
            print(f"Type: {model.type}")
            print(f"Version: {model.version}")
            if model.description:
                print(f"Description: {model.description}")
            if model.parameters:
                print("Parameters:")
                for key, value in model.parameters.items():
                    print(f"  - {key}: {value}")
        
        elif args.action == "test":
            result = client.models.test(
                model_name=args.model_name,
                prompt=args.prompt
            )
            print(result.get("output", ""))
            
    except MiradorError as e:
        print(f"Error: {e.message}")
        sys.exit(1)


def sessions_cmd(args):
    """Manage sessions"""
    config = load_config()
    
    if not config.get("api_key") and not args.api_key:
        print("Error: No API key configured. Run 'mirador configure' first.")
        sys.exit(1)
    
    try:
        client = MiradorClient(
            api_key=args.api_key or config.get("api_key"),
            base_url=args.base_url or config.get("base_url", "http://localhost:5000")
        )
        
        if args.action == "list":
            sessions = client.sessions.list(limit=args.limit)
            print(f"Recent sessions (showing {len(sessions)}):")
            for session in sessions:
                print(f"  - {session.id}")
                if session.name:
                    print(f"    Name: {session.name}")
                print(f"    Created: {session.created_at}")
                print(f"    Queries: {session.query_count}")
                print()
        
        elif args.action == "create":
            session = client.sessions.create(name=args.name)
            print(f"Created session: {session.id}")
            if session.name:
                print(f"Name: {session.name}")
        
        elif args.action == "history":
            history = client.sessions.get_history(args.session_id)
            print(f"Session history ({len(history)} entries):")
            for entry in history:
                print(f"\n[{entry.get('timestamp')}]")
                print(f"Query: {entry.get('query')}")
                print(f"Response: {entry.get('response', '')[:200]}...")
                
    except MiradorError as e:
        print(f"Error: {e.message}")
        sys.exit(1)


def webhooks_cmd(args):
    """Manage webhooks"""
    config = load_config()
    
    if not config.get("api_key") and not args.api_key:
        print("Error: No API key configured. Run 'mirador configure' first.")
        sys.exit(1)
    
    try:
        client = MiradorClient(
            api_key=args.api_key or config.get("api_key"),
            base_url=args.base_url or config.get("base_url", "http://localhost:5000")
        )
        
        if args.action == "list":
            webhooks = client.webhooks.list()
            print("Configured webhooks:")
            for webhook in webhooks:
                status = "Active" if webhook.active else "Inactive"
                print(f"  - {webhook.name} ({webhook.id}) - {status}")
                print(f"    URL: {webhook.url}")
                print(f"    Events: {', '.join(webhook.events)}")
                if webhook.transformer:
                    print(f"    Transformer: {webhook.transformer}")
                print()
        
        elif args.action == "create":
            events = args.events.split(",")
            webhook = client.webhooks.create(
                name=args.name,
                url=args.url,
                events=events,
                transformer=args.transformer
            )
            print(f"Created webhook: {webhook.id}")
        
        elif args.action == "delete":
            client.webhooks.delete(args.webhook_id)
            print(f"Deleted webhook: {args.webhook_id}")
        
        elif args.action == "test":
            result = client.webhooks.test(args.webhook_id)
            if result.get("success"):
                print("Webhook test successful!")
            else:
                print(f"Webhook test failed: {result.get('error')}")
                
    except MiradorError as e:
        print(f"Error: {e.message}")
        sys.exit(1)


def main():
    """Main CLI entry point"""
    parser = argparse.ArgumentParser(
        description="Mirador AI Orchestration Platform CLI"
    )
    
    # Global options
    parser.add_argument(
        "--api-key",
        help="API key (overrides config file)"
    )
    parser.add_argument(
        "--base-url",
        help="API base URL (overrides config file)"
    )
    
    subparsers = parser.add_subparsers(dest="command", help="Available commands")
    
    # Configure command
    configure_parser = subparsers.add_parser("configure", help="Configure credentials")
    configure_parser.set_defaults(func=configure_cmd)
    
    # Query command
    query_parser = subparsers.add_parser("query", help="Execute a query")
    query_parser.add_argument("prompt", help="Query prompt")
    query_parser.add_argument("--chain", help="Chain type to use")
    query_parser.add_argument("--format", choices=["quick", "summary", "detailed", "export"])
    query_parser.add_argument("--session", help="Session ID to continue")
    query_parser.add_argument("--json", action="store_true", help="Output as JSON")
    query_parser.add_argument("--verbose", "-v", action="store_true", help="Verbose output")
    query_parser.set_defaults(func=query_cmd)
    
    # Chain command
    chain_parser = subparsers.add_parser("chain", help="Run a specific chain")
    chain_parser.add_argument("chain_type", nargs="?", help="Chain type")
    chain_parser.add_argument("prompt", nargs="?", help="Query prompt")
    chain_parser.add_argument("--list", action="store_true", help="List available chains")
    chain_parser.add_argument("--format", choices=["quick", "summary", "detailed", "export"])
    chain_parser.add_argument("--session", help="Session ID")
    chain_parser.add_argument("--json", action="store_true", help="Output as JSON")
    chain_parser.set_defaults(func=chain_cmd)
    
    # Stream command
    stream_parser = subparsers.add_parser("stream", help="Stream a response")
    stream_parser.add_argument("prompt", help="Query prompt")
    stream_parser.add_argument("--chain", help="Chain type to use")
    stream_parser.add_argument("--session", help="Session ID")
    stream_parser.set_defaults(func=stream_cmd)
    
    # Models command
    models_parser = subparsers.add_parser("models", help="Manage models")
    models_subparsers = models_parser.add_subparsers(dest="action")
    
    # models list
    models_list = models_subparsers.add_parser("list", help="List models")
    models_list.add_argument("--verbose", "-v", action="store_true")
    
    # models info
    models_info = models_subparsers.add_parser("info", help="Get model info")
    models_info.add_argument("model_name", help="Model name")
    
    # models test
    models_test = models_subparsers.add_parser("test", help="Test a model")
    models_test.add_argument("model_name", help="Model name")
    models_test.add_argument("prompt", help="Test prompt")
    
    models_parser.set_defaults(func=models_cmd)
    
    # Sessions command
    sessions_parser = subparsers.add_parser("sessions", help="Manage sessions")
    sessions_subparsers = sessions_parser.add_subparsers(dest="action")
    
    # sessions list
    sessions_list = sessions_subparsers.add_parser("list", help="List sessions")
    sessions_list.add_argument("--limit", type=int, default=10, help="Number to show")
    
    # sessions create
    sessions_create = sessions_subparsers.add_parser("create", help="Create session")
    sessions_create.add_argument("--name", help="Session name")
    
    # sessions history
    sessions_history = sessions_subparsers.add_parser("history", help="Get session history")
    sessions_history.add_argument("session_id", help="Session ID")
    
    sessions_parser.set_defaults(func=sessions_cmd)
    
    # Webhooks command
    webhooks_parser = subparsers.add_parser("webhooks", help="Manage webhooks")
    webhooks_subparsers = webhooks_parser.add_subparsers(dest="action")
    
    # webhooks list
    webhooks_list = webhooks_subparsers.add_parser("list", help="List webhooks")
    
    # webhooks create
    webhooks_create = webhooks_subparsers.add_parser("create", help="Create webhook")
    webhooks_create.add_argument("name", help="Webhook name")
    webhooks_create.add_argument("url", help="Webhook URL")
    webhooks_create.add_argument("events", help="Comma-separated event types")
    webhooks_create.add_argument("--transformer", help="Transformer type")
    
    # webhooks delete
    webhooks_delete = webhooks_subparsers.add_parser("delete", help="Delete webhook")
    webhooks_delete.add_argument("webhook_id", help="Webhook ID")
    
    # webhooks test
    webhooks_test = webhooks_subparsers.add_parser("test", help="Test webhook")
    webhooks_test.add_argument("webhook_id", help="Webhook ID")
    
    webhooks_parser.set_defaults(func=webhooks_cmd)
    
    # Parse arguments
    args = parser.parse_args()
    
    # Execute command
    if hasattr(args, "func"):
        args.func(args)
    else:
        parser.print_help()


if __name__ == "__main__":
    main()