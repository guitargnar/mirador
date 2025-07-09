#!/usr/bin/env python3
"""
Mirador Integration Test for User Intervention

This script tests the integration between InterventionManager and MessageBus
to verify that user intervention points work correctly with the bidirectional
communication system.
"""

import os
import sys
import json
import time
import logging
from typing import Dict, Any, Optional
from datetime import datetime
import threading

# Add parent directory to path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# Import required modules
from core.message_bus import MessageBus
from core.intervention_manager import InterventionManager

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger("mirador-integration-test")

class InterventionTesterThread(threading.Thread):
    """Thread class to test interventions without blocking the main thread."""
    
    def __init__(self, manager: InterventionManager, message: Dict[str, Any]):
        """
        Initialize the tester thread.
        
        Args:
            manager: The intervention manager to test
            message: The test message to use
        """
        super().__init__()
        self.manager = manager
        self.message = message
        self.result = None
        
    def run(self):
        """Run the test."""
        # Use programmatic intervention handling
        pending = self.manager.get_pending_interventions()
        if pending:
            intervention_id = pending[0]["id"]
            
            # Simulate user approved
            time.sleep(1)  # Delay to simulate user thinking
            self.manager.handle_intervention(intervention_id, "approve")
            
            logger.info(f"Successfully handled intervention {intervention_id}")

def test_intervention_integration():
    """
    Test the integration between InterventionManager and MessageBus
    using programmatic intervention.
    """
    logger.info("Starting intervention integration test")
    
    # Create message bus
    bus = MessageBus(session_id="integration_test")
    
    # Create intervention manager with CLI mode disabled
    manager = InterventionManager(bus, cli_mode=False)
    
    # Create a test message
    test_message = {
        "message_id": "test-id-" + str(int(time.time())),
        "message_type": "query", 
        "source_specialist": "test_specialist",
        "target_specialist": "security_expert",
        "content": {
            "query_type": "clarification",
            "query": "Is this password hashing secure?",
            "context": "Testing intervention integration"
        },
        "metadata": {
            "priority": 1,
            "timestamp": datetime.now().isoformat(),
            "session_id": "integration_test"
        }
    }
    
    # Configure intervention to always require intervention for security_expert
    manager.config = {
        "enabled": True,
        "intervention_types": {
            "query": {
                "enabled": True,
                "priority_threshold": 3,
                "auto_approve_specialists": [],
                "always_intervene_specialists": ["security_expert"]
            }
        }
    }
    
    # Start handler thread
    handler = InterventionTesterThread(manager, test_message)
    handler.start()
    
    # Route the message (this will be intercepted)
    message_id = bus.route_message(test_message)
    
    # Wait for handler to complete
    handler.join(timeout=5)
    
    # Verify message was routed after intervention
    assert message_id is not None, "Message should have been routed after intervention"
    logger.info(f"Message {message_id} was successfully routed after intervention")
    
    # Test intervention rejection
    # Configure a new interceptor that always rejects
    bus.interceptors.clear()
    
    def rejection_interceptor(message: Dict[str, Any]) -> Optional[Dict[str, Any]]:
        """Test interceptor that always rejects messages."""
        if message["target_specialist"] == "security_expert":
            logger.info(f"Rejection interceptor rejecting message to {message['target_specialist']}")
            return None
        return message
    
    # Register the new interceptor
    bus.register_interceptor(rejection_interceptor)
    
    # Try to route another message
    another_message = test_message.copy()
    another_message["message_id"] = "test-id-" + str(int(time.time()))
    
    # This should be rejected
    rejected_id = bus.route_message(another_message)
    
    # Verify message was rejected
    assert rejected_id is None, "Message should have been rejected by interceptor"
    logger.info("Message was successfully rejected by interceptor")
    
    # Test message modification
    bus.interceptors.clear()
    
    def modification_interceptor(message: Dict[str, Any]) -> Dict[str, Any]:
        """Test interceptor that modifies messages."""
        if message["message_type"] == "query":
            # Add a flag to the content
            message["content"]["modified_by_interceptor"] = True
            logger.info(f"Modification interceptor modifying message {message['message_id']}")
        return message
    
    # Register the new interceptor
    bus.register_interceptor(modification_interceptor)
    
    # Route another message
    modified_message = test_message.copy()
    modified_message["message_id"] = "test-id-" + str(int(time.time()))
    
    # This should be modified
    modified_id = bus.route_message(modified_message)
    
    # Verify message was modified
    assert modified_id is not None, "Message should have been routed"
    
    # Get the message and check if it was modified
    stored_message = bus.get_message(modified_id)
    assert stored_message is not None, "Message should be stored"
    assert stored_message["content"].get("modified_by_interceptor") is True, "Message should have been modified"
    
    logger.info("Message was successfully modified by interceptor")
    logger.info("All integration tests passed!")

if __name__ == "__main__":
    test_intervention_integration()