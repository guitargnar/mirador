#!/usr/bin/env python3
"""
Mirador AI Framework API

This module provides a RESTful API interface to the Mirador framework,
allowing remote access to chain execution and session management.
"""
import os
import json
import logging
import time
from typing import Dict, Optional, List, Any, Union
from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS

# Import the AIFramework
from ai_framework.framework import AIFramework

# Configure logging
# Ensure log directory exists
os.makedirs(os.path.join(os.path.dirname(__file__), "logs"), exist_ok=True)

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler(os.path.join(os.path.dirname(__file__), "logs", "api.log"))
    ]
)
logger = logging.getLogger("mirador-api")

# Create Flask app
app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Initialize AIFramework
framework = None

# Initialize the framework with a function that will be called before first request
def initialize_framework():
    """Initialize the AI framework"""
    global framework
    if framework is None:
        default_config = os.path.join(os.path.dirname(__file__), "config.json")
        config_path = os.environ.get("MIRADOR_CONFIG", default_config)
        try:
            framework = AIFramework(config_path=config_path)
            logger.info(f"AIFramework initialized with config: {config_path}")
        except Exception as e:
            logger.error(f"Failed to initialize AIFramework: {e}", exc_info=True)
            
# Initialize the framework at startup
initialize_framework()
        

@app.route('/api/health', methods=['GET'])
def health_check():
    """API health check endpoint"""
    if not framework:
        return jsonify({
            "status": "error",
            "message": "Framework not initialized"
        }), 500
        
    return jsonify({
        "status": "ok",
        "config": os.path.abspath(os.path.join(os.path.dirname(__file__), "config.json"))
    })


@app.route('/api/personas', methods=['GET'])
def list_personas():
    """Get all available personas"""
    if not framework:
        return jsonify({"error": "Framework not initialized"}), 500
        
    return jsonify({
        "personas": framework.config["personas"],
        "chain_order": framework.config["chain_order"],
        "optional_nodes": framework.config["optional_nodes"]
    })


@app.route('/api/sessions', methods=['GET'])
def list_sessions():
    """List all available sessions"""
    if not framework:
        return jsonify({"error": "Framework not initialized"}), 500
        
    sessions = framework.list_sessions()
    return jsonify({"sessions": sessions})


@app.route('/api/sessions/<session_id>', methods=['GET'])
def get_session_info(session_id):
    """Get information about a specific session"""
    if not framework:
        return jsonify({"error": "Framework not initialized"}), 500
        
    info = framework.get_session_info(session_id)
    if "error" in info:
        return jsonify({"error": info["error"]}), 404
        
    return jsonify(info)


@app.route('/api/sessions/<session_id>/outputs/<persona_id>', methods=['GET'])
def get_persona_output(session_id, persona_id):
    """Get a specific persona's output from a session"""
    if not framework:
        return jsonify({"error": "Framework not initialized"}), 500
        
    # Initialize framework with the session ID
    temp_framework = AIFramework(session_id=session_id)
    
    if persona_id not in temp_framework.outputs:
        return jsonify({
            "error": f"Persona '{persona_id}' output not found in session {session_id}"
        }), 404
        
    return jsonify({
        "session_id": session_id,
        "persona_id": persona_id,
        "input": temp_framework.outputs[persona_id]["input"],
        "output": temp_framework.outputs[persona_id]["output"],
        "elapsed": temp_framework.outputs[persona_id]["elapsed"]
    })


@app.route('/api/run', methods=['POST'])
def run_chain():
    """Run a chain with the provided input and options"""
    if not framework:
        return jsonify({"error": "Framework not initialized"}), 500
        
    data = request.json
    if not data:
        return jsonify({"error": "No JSON data provided"}), 400
        
    # Extract parameters
    input_text = data.get('input')
    if not input_text:
        return jsonify({"error": "Input text is required"}), 400
        
    start_at = data.get('start_at')
    end_at = data.get('end_at')
    session_id = data.get('session_id')
    persona_parameters = data.get('parameters')
    skip_optional = data.get('skip_optional', False)
    continue_on_error = data.get('continue_on_error', False)
    
    # Create a new framework instance if a session ID is provided
    current_framework = framework
    if session_id:
        try:
            current_framework = AIFramework(session_id=session_id)
        except Exception as e:
            return jsonify({
                "error": f"Failed to load session {session_id}: {str(e)}"
            }), 400
    
    try:
        # Run the chain in non-interactive mode
        result = current_framework.run_chain(
            input_text,
            start_at=start_at,
            end_at=end_at,
            interactive=False,
            persona_parameters=persona_parameters,
            skip_optional=skip_optional,
            continue_on_error=continue_on_error
        )
        
        return jsonify(result)
        
    except Exception as e:
        logger.error(f"Error running chain: {e}", exc_info=True)
        return jsonify({
            "error": f"Failed to run chain: {str(e)}"
        }), 500


@app.route('/api/run/<persona_id>', methods=['POST'])
def run_persona(persona_id):
    """Run a single persona with the provided input"""
    if not framework:
        return jsonify({"error": "Framework not initialized"}), 500
        
    data = request.json
    if not data:
        return jsonify({"error": "No JSON data provided"}), 400
        
    # Extract parameters
    input_text = data.get('input')
    if not input_text:
        return jsonify({"error": "Input text is required"}), 400
        
    parameters = data.get('parameters')
    
    try:
        # Run the persona in non-interactive mode
        output = framework.run_persona(
            persona_id,
            input_text,
            interactive=False,
            parameters=parameters
        )
        
        return jsonify({
            "session_id": framework.session_id,
            "persona_id": persona_id,
            "output": output,
            "elapsed": framework.outputs[persona_id]["elapsed"] if persona_id in framework.outputs else 0
        })
        
    except ValueError as e:
        return jsonify({"error": str(e)}), 404
    except Exception as e:
        logger.error(f"Error running persona {persona_id}: {e}", exc_info=True)
        return jsonify({
            "error": f"Failed to run persona: {str(e)}"
        }), 500


@app.route('/api/files/<path:filename>', methods=['GET'])
def get_file(filename):
    """Serve a file from the outputs directory"""
    outputs_dir = os.path.join(os.path.dirname(__file__), "outputs")
    return send_from_directory(outputs_dir, filename)


# ======== Webhook Management API ========

@app.route('/api/webhooks', methods=['GET'])
def list_webhooks():
    """List all configured webhooks"""
    if not framework:
        return jsonify({"error": "Framework not initialized"}), 500
        
    webhooks = framework.webhook_handler.get_webhooks()
    return jsonify({"webhooks": webhooks})


@app.route('/api/webhooks', methods=['POST'])
def create_webhook():
    """Create a new webhook"""
    if not framework:
        return jsonify({"error": "Framework not initialized"}), 500
        
    data = request.json
    if not data:
        return jsonify({"error": "No JSON data provided"}), 400
        
    # Required fields
    name = data.get('name')
    url = data.get('url')
    events = data.get('events')
    
    if not name or not url or not events:
        return jsonify({
            "error": "Missing required fields (name, url, events)"
        }), 400
        
    # Optional fields with defaults
    headers = data.get('headers')
    max_retries = data.get('max_retries', 3)
    active = data.get('active', True)
    
    try:
        webhook = framework.webhook_handler.add_webhook(
            name=name,
            url=url,
            events=events,
            headers=headers,
            max_retries=max_retries,
            active=active
        )
        
        return jsonify({"webhook": webhook}), 201
    except Exception as e:
        logger.error(f"Error creating webhook: {e}", exc_info=True)
        return jsonify({"error": f"Failed to create webhook: {str(e)}"}), 500


@app.route('/api/webhooks/<webhook_id>', methods=['GET'])
def get_webhook(webhook_id):
    """Get a specific webhook"""
    if not framework:
        return jsonify({"error": "Framework not initialized"}), 500
        
    webhook = framework.webhook_handler.get_webhook(webhook_id)
    if not webhook:
        return jsonify({"error": f"Webhook '{webhook_id}' not found"}), 404
        
    return jsonify({"webhook": webhook})


@app.route('/api/webhooks/<webhook_id>', methods=['PUT'])
def update_webhook(webhook_id):
    """Update a webhook"""
    if not framework:
        return jsonify({"error": "Framework not initialized"}), 500
        
    data = request.json
    if not data:
        return jsonify({"error": "No JSON data provided"}), 400
        
    try:
        webhook = framework.webhook_handler.update_webhook(webhook_id, **data)
        return jsonify({"webhook": webhook})
    except ValueError as e:
        return jsonify({"error": str(e)}), 404
    except Exception as e:
        logger.error(f"Error updating webhook: {e}", exc_info=True)
        return jsonify({"error": f"Failed to update webhook: {str(e)}"}), 500


@app.route('/api/webhooks/<webhook_id>', methods=['DELETE'])
def delete_webhook(webhook_id):
    """Delete a webhook"""
    if not framework:
        return jsonify({"error": "Framework not initialized"}), 500
        
    result = framework.webhook_handler.delete_webhook(webhook_id)
    if not result:
        return jsonify({"error": f"Webhook '{webhook_id}' not found"}), 404
        
    return jsonify({"success": True})


@app.route('/api/webhooks/test', methods=['POST'])
def test_webhook():
    """Send a test event to a webhook"""
    if not framework:
        return jsonify({"error": "Framework not initialized"}), 500
        
    data = request.json
    if not data:
        return jsonify({"error": "No JSON data provided"}), 400
        
    webhook_id = data.get('webhook_id')
    event_type = data.get('event_type', 'test_event')
    
    if not webhook_id:
        return jsonify({"error": "webhook_id is required"}), 400
        
    # Get the webhook configuration
    webhook = framework.webhook_handler.get_webhook(webhook_id)
    if not webhook:
        return jsonify({"error": f"Webhook '{webhook_id}' not found"}), 404
        
    # Create test payload
    payload = {
        "session_id": "test-session",
        "timestamp": time.strftime("%Y-%m-%d %H:%M:%S"),
        "event_type": event_type,
        "message": "This is a test event"
    }
    
    # Send the test event
    result = framework.webhook_handler._send_webhook(webhook, payload)
    
    return jsonify({
        "success": result.get("success", False),
        "status_code": result.get("status_code"),
        "error": result.get("error"),
        "webhook_id": webhook_id,
        "event_type": event_type
    })


if __name__ == '__main__':
    import os
    # Get port from environment or use default
    port = int(os.environ.get('PORT', 5001))  # Changed to port 5001
    
    # Initialize the framework
    default_config = os.path.join(os.path.dirname(__file__), "config.json")
    config_path = os.environ.get("MIRADOR_CONFIG", default_config)
    try:
        framework = AIFramework(config_path=config_path)
        logger.info(f"AIFramework initialized with config: {config_path}")
    except Exception as e:
        logger.error(f"Failed to initialize AIFramework: {e}", exc_info=True)
    
    # Run the app
    app.run(host='0.0.0.0', port=port, debug=True)