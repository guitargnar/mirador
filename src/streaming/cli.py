#!/usr/bin/env python3
"""Command-line interface for Mirador streaming"""

import asyncio
import sys
import argparse
from typing import Optional
from .orchestrator import StreamingOrchestrator

# ANSI color codes
COLORS = {
    "GRAY": "\033[90m",
    "RED": "\033[91m",
    "GREEN": "\033[92m",
    "YELLOW": "\033[93m",
    "BLUE": "\033[94m",
    "MAGENTA": "\033[95m",
    "CYAN": "\033[96m",
    "WHITE": "\033[97m",
    "RESET": "\033[0m"
}

def get_color_for_confidence(confidence: float) -> str:
    """Get color based on confidence level"""
    if confidence < 0.3:
        return COLORS["GRAY"]
    elif confidence < 0.7:
        return COLORS["WHITE"]
    elif confidence < 0.9:
        return COLORS["CYAN"]
    else:
        return COLORS["GREEN"]

async def stream_response(orchestrator: StreamingOrchestrator, query: str, no_color: bool = False):
    """Stream a response using the given orchestrator"""
    try:
        async for token in orchestrator.process(query):
            if no_color:
                print(token.content, end="", flush=True)
            else:
                color = get_color_for_confidence(token.confidence)
                print(f"{color}{token.content}{COLORS['RESET']}", end="", flush=True)
    
    except KeyboardInterrupt:
        print(f"\n{COLORS['YELLOW']}Interrupted by user{COLORS['RESET']}")
    except Exception as e:
        print(f"\n{COLORS['RED']}Error: {e}{COLORS['RESET']}")

async def stream_query(query: str, no_color: bool = False):
    """Stream a query through the orchestrator"""
    orchestrator = StreamingOrchestrator()
    await stream_response(orchestrator, query, no_color)

def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(
        description="Mirador Streaming - Real-time AI responses",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  mirador-stream "What should I focus on today?"
  mirador-stream "Analyze the benefits of meditation"
  mirador-stream --no-color "Explain quantum computing"
        """
    )
    
    parser.add_argument(
        "query",
        nargs="*",
        help="Your query to process"
    )
    
    parser.add_argument(
        "--no-color",
        action="store_true",
        help="Disable colored output"
    )
    
    args = parser.parse_args()
    
    if not args.query:
        parser.print_help()
        sys.exit(1)
    
    query = " ".join(args.query)
    
    # Run the async function
    asyncio.run(stream_query(query, args.no_color))

if __name__ == "__main__":
    main()