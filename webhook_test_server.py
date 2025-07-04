#!/usr/bin/env python3
"""
Simple webhook test server for Mirador

This script creates a simple HTTP server that logs webhook events received
from the Mirador AI Framework. It's useful for testing webhook configurations
before connecting to production systems.

Usage:
  python3 webhook_test_server.py [port]
"""

import http.server
import socketserver
import json
import sys
import time
from datetime import datetime

DEFAULT_PORT = 8000
received_webhooks = []

class WebhookHandler(http.server.BaseHTTPRequestHandler):
    def _set_headers(self, status_code=200):
        self.send_response(status_code)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        
    def do_GET(self):
        """Handle GET requests to show received webhooks"""
        if self.path == '/':
            self._set_headers()
            
            # Create HTML response
            html = """
            <!DOCTYPE html>
            <html>
            <head>
                <title>Mirador Webhook Test Server</title>
                <style>
                    body { font-family: Arial, sans-serif; margin: 20px; }
                    h1 { color: #333; }
                    .webhook { 
                        border: 1px solid #ddd; 
                        padding: 15px; 
                        margin-bottom: 10px; 
                        border-radius: 5px;
                        background-color: #f9f9f9;
                    }
                    .webhook-header {
                        font-weight: bold;
                        margin-bottom: 10px;
                        display: flex;
                        justify-content: space-between;
                    }
                    .event-type {
                        color: #0066cc;
                        font-size: 1.1em;
                    }
                    .timestamp {
                        color: #666;
                        font-size: 0.9em;
                    }
                    pre {
                        background-color: #eee;
                        padding: 10px;
                        border-radius: 3px;
                        overflow-x: auto;
                    }
                    .refresh {
                        margin-bottom: 20px;
                    }
                </style>
                <script>
                    function refreshPage() {
                        location.reload();
                    }
                    
                    // Auto refresh every 5 seconds
                    setTimeout(refreshPage, 5000);
                </script>
            </head>
            <body>
                <h1>Mirador Webhook Test Server</h1>
                <div class="refresh">
                    <button onclick="refreshPage()">Refresh</button>
                    <span>(Auto-refreshes every 5 seconds)</span>
                </div>
                <h2>Received Webhooks</h2>
            """
            
            if not received_webhooks:
                html += "<p>No webhooks received yet.</p>"
            else:
                for i, webhook in enumerate(reversed(received_webhooks)):
                    event_type = webhook.get("data", {}).get("event_type", "unknown")
                    timestamp = webhook.get("timestamp", "unknown")
                    
                    html += f"""
                    <div class="webhook">
                        <div class="webhook-header">
                            <span class="event-type">{event_type}</span>
                            <span class="timestamp">{timestamp}</span>
                        </div>
                        <pre>{json.dumps(webhook.get("data", {}), indent=2)}</pre>
                    </div>
                    """
            
            html += """
            </body>
            </html>
            """
            
            self.wfile.write(html.encode())
        elif self.path == '/list':
            self._set_headers()
            self.wfile.write(json.dumps(received_webhooks).encode())
        else:
            self._set_headers(404)
            self.wfile.write(json.dumps({"error": "Not found"}).encode())
    
    def do_POST(self):
        """Handle POST requests (webhook events)"""
        content_length = int(self.headers.get('Content-Length', 0))
        raw_data = self.rfile.read(content_length)
        
        # Try to parse JSON
        try:
            data = json.loads(raw_data)
            
            # Log webhook
            print(f"\n=== Webhook Received at {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} ===")
            print(f"Event Type: {data.get('event_type', 'unknown')}")
            print(f"Data: {json.dumps(data, indent=2)}")
            
            # Store webhook
            received_webhooks.append({
                "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                "data": data,
                "headers": dict(self.headers)
            })
            
            # Success response
            self._set_headers(200)
            self.wfile.write(json.dumps({
                "success": True,
                "message": "Webhook received successfully"
            }).encode())
            
        except json.JSONDecodeError:
            print(f"\n=== Invalid JSON Received at {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} ===")
            print(f"Raw Data: {raw_data.decode('utf-8', errors='replace')}")
            
            self._set_headers(400)
            self.wfile.write(json.dumps({
                "success": False,
                "error": "Invalid JSON"
            }).encode())

def run_server(port=DEFAULT_PORT):
    """Run the webhook test server"""
    try:
        with socketserver.TCPServer(("", port), WebhookHandler) as httpd:
            print(f"Starting webhook test server on port {port}")
            print(f"View received webhooks at http://localhost:{port}/")
            print("Press Ctrl+C to stop")
            httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nShutting down server")
        sys.exit(0)
    except OSError as e:
        if e.errno == 98:  # Address already in use
            print(f"Error: Port {port} is already in use.")
            sys.exit(1)
        else:
            raise

if __name__ == "__main__":
    # Get port from command line or use default
    port = DEFAULT_PORT
    if len(sys.argv) > 1:
        try:
            port = int(sys.argv[1])
        except ValueError:
            print(f"Invalid port number: {sys.argv[1]}")
            sys.exit(1)
    
    run_server(port)