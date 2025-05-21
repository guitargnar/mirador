#!/usr/bin/env python3
"""
Mirador Intervention Manager

This module implements user intervention capabilities for the bidirectional
communication system, allowing users to guide and control specialist interactions.
"""

import os
import json
import time
import logging
import threading
import queue
from typing import Dict, List, Optional, Any, Callable, Tuple, Set
from datetime import datetime
import signal

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger("mirador-intervention-manager")

# ANSI colors for terminal output
GREEN = '\033[0;32m'
BLUE = '\033[0;34m'
YELLOW = '\033[1;33m'
RED = '\033[0;31m'
MAGENTA = '\033[0;35m'
CYAN = '\033[0;36m'
BOLD = '\033[1m'
RESET = '\033[0m'


class InterventionManager:
    """
    Manages user interventions in the bidirectional communication system.
    
    The InterventionManager intercepts messages between specialists,
    determines when user intervention is needed, and provides interfaces
    for users to approve, modify, or reject messages.
    """
    
    def __init__(
        self, 
        message_bus: Any, 
        config: Optional[Dict[str, Any]] = None,
        cli_mode: bool = True
    ):
        """
        Initialize the intervention manager.
        
        Args:
            message_bus: The message bus to intercept messages from
            config: Configuration dictionary for intervention rules
            cli_mode: Whether to use CLI interface (vs. programmatic)
        """
        self.message_bus = message_bus
        self.config = config or self._load_default_config()
        self.cli_mode = cli_mode
        
        # Internal state
        self.intervention_history: List[Dict[str, Any]] = []
        self.pending_interventions: queue.Queue = queue.Queue()
        self.intervention_active = False
        self.intervention_thread = None
        
        # Register with message bus if it supports interceptors
        if hasattr(message_bus, "register_interceptor"):
            self.message_bus.register_interceptor(self._message_interceptor)
        else:
            # Otherwise monkey patch the route_message method
            self._original_route_message = message_bus.route_message
            message_bus.route_message = self._patched_route_message
            
        logger.info("InterventionManager initialized")
    
    def _load_default_config(self) -> Dict[str, Any]:
        """
        Load default configuration for interventions.
        
        Returns:
            Default configuration dictionary
        """
        # Check for config file
        config_path = os.path.expanduser("~/ai_framework_git/config/intervention.json")
        if os.path.exists(config_path):
            try:
                with open(config_path, "r") as f:
                    return json.load(f)
            except Exception as e:
                logger.error(f"Error loading intervention config: {e}")
                
        # Default configuration
        return {
            "enabled": True,
            "intervention_types": {
                "query": {
                    "enabled": True,
                    "priority_threshold": 3,  # Intervene on priorities 1-3 (higher priority = lower number)
                    "auto_approve_specialists": [],
                    "always_intervene_specialists": ["security_expert"]
                },
                "response": {
                    "enabled": True,
                    "priority_threshold": 2,  # Only intervene on high priority responses
                    "auto_approve_specialists": ["enhanced_agent"],
                    "always_intervene_specialists": []
                },
                "notification": {
                    "enabled": False  # Don't intervene on notifications by default
                }
            },
            "timeout_seconds": 300,  # 5 minute default timeout
            "default_action": "approve",  # What to do when timeout is reached
            "watch_mode": False,  # Whether to show all messages (even auto-approved ones)
            "learning": {
                "enabled": True,  # Learn from past interventions
                "min_examples": 5  # Minimum examples before applying learning
            }
        }
    
    def _patched_route_message(self, message: Dict[str, Any]) -> str:
        """
        Patched version of message_bus.route_message that adds intervention.
        
        Args:
            message: The message to route
            
        Returns:
            Message ID of the routed message
        """
        # Check if intervention is needed
        if self._should_intervene(message):
            modified_message = self._handle_intervention(message)
            # If message was rejected, return None
            if modified_message is None:
                return None
            # Otherwise route the modified message
            return self._original_route_message(modified_message)
        else:
            # Just route the original message
            return self._original_route_message(message)
    
    def _message_interceptor(self, message: Dict[str, Any]) -> Optional[Dict[str, Any]]:
        """
        Intercept messages and decide whether intervention is needed.
        
        Args:
            message: The message being routed
            
        Returns:
            Modified message after intervention, or None if rejected
        """
        # Check if intervention is needed
        if self._should_intervene(message):
            return self._handle_intervention(message)
        # Watch mode shows all messages without intervention
        elif self.config.get("watch_mode", False):
            self._display_message(message, auto_approved=True)
            
        return message
    
    def _should_intervene(self, message: Dict[str, Any]) -> bool:
        """
        Determine whether user intervention is needed for a message.
        
        Args:
            message: The message to check
            
        Returns:
            True if intervention is needed, False otherwise
        """
        # Check if interventions are globally disabled
        if not self.config.get("enabled", True):
            return False
            
        # Get message details
        message_type = message.get("message_type", "")
        source = message.get("source_specialist", "")
        target = message.get("target_specialist", "")
        priority = message.get("metadata", {}).get("priority", 3)
        
        # Check type-specific settings
        type_config = self.config.get("intervention_types", {}).get(message_type, {})
        
        # Check if this type is disabled
        if not type_config.get("enabled", True):
            return False
            
        # Check if source or target is in auto-approve list
        auto_approve = type_config.get("auto_approve_specialists", [])
        if source in auto_approve or target in auto_approve:
            return False
            
        # Check if source or target is in always-intervene list
        always_intervene = type_config.get("always_intervene_specialists", [])
        if source in always_intervene or target in always_intervene:
            return True
            
        # Check priority threshold
        priority_threshold = type_config.get("priority_threshold", 999)
        if priority <= priority_threshold:
            return True
            
        # Use learning model if enabled
        if self.config.get("learning", {}).get("enabled", False):
            return self._learning_should_intervene(message)
            
        # Default to no intervention
        return False
    
    def _learning_should_intervene(self, message: Dict[str, Any]) -> bool:
        """
        Use past intervention history to decide if intervention is needed.
        
        Args:
            message: The message to check
            
        Returns:
            True if intervention is likely needed based on past data
        """
        # Implement a simple learning model based on past interventions
        # For now, just return False (no intervention)
        # TODO: Implement a more sophisticated learning model
        return False
    
    def _handle_intervention(self, message: Dict[str, Any]) -> Optional[Dict[str, Any]]:
        """
        Handle user intervention for a message.
        
        Args:
            message: The message needing intervention
            
        Returns:
            Modified message after intervention, or None if rejected
        """
        # If we're in CLI mode, handle the intervention directly
        if self.cli_mode:
            return self._cli_intervention(message)
            
        # Otherwise, add to pending interventions queue for programmatic handling
        intervention_id = str(len(self.intervention_history) + 1)
        intervention = {
            "id": intervention_id,
            "message": message,
            "timestamp": datetime.now().isoformat(),
            "status": "pending"
        }
        self.intervention_history.append(intervention)
        self.pending_interventions.put(intervention)
        
        # Wait for intervention to be handled
        while True:
            # Check if intervention was handled
            if intervention["status"] != "pending":
                if intervention["status"] == "approved":
                    return intervention.get("modified_message", message)
                elif intervention["status"] == "rejected":
                    return None
                    
            # Check for timeout
            timeout = self.config.get("timeout_seconds", 300)
            intervention_time = datetime.fromisoformat(intervention["timestamp"])
            elapsed = (datetime.now() - intervention_time).total_seconds()
            if elapsed > timeout:
                # Apply default action
                default_action = self.config.get("default_action", "approve")
                if default_action == "approve":
                    intervention["status"] = "approved"
                    intervention["action"] = "timeout_approve"
                    return message
                else:
                    intervention["status"] = "rejected"
                    intervention["action"] = "timeout_reject"
                    return None
                    
            time.sleep(0.5)
    
    def _cli_intervention(self, message: Dict[str, Any]) -> Optional[Dict[str, Any]]:
        """
        Handle user intervention via command-line interface.
        
        Args:
            message: The message needing intervention
            
        Returns:
            Modified message after intervention, or None if rejected
        """
        self.intervention_active = True
        
        # Set up signal handler for timeout
        original_handler = None
        if hasattr(signal, 'SIGALRM'):
            original_handler = signal.getsignal(signal.SIGALRM)
            timeout = self.config.get("timeout_seconds", 300)
            signal.signal(signal.SIGALRM, self._timeout_handler)
            signal.alarm(timeout)
        
        try:
            # Display the message
            self._display_message(message)
            
            # Get user input
            while True:
                print(f"\n{BLUE}{BOLD}Intervention Options:{RESET}")
                print(f"  {YELLOW}(a){RESET} Approve - Send message as is")
                print(f"  {YELLOW}(m){RESET} Modify - Edit message content")
                print(f"  {YELLOW}(r){RESET} Reject - Prevent message from being sent")
                print(f"  {YELLOW}(i){RESET} Info - Show more details about the message")
                print(f"  {YELLOW}(s){RESET} Settings - Adjust intervention settings for this type")
                
                choice = input(f"\n{GREEN}Enter choice:{RESET} ").strip().lower()
                
                if choice == 'a':
                    # Approve message
                    self._record_intervention(message, "approved", message)
                    print(f"{GREEN}Message approved{RESET}")
                    return message
                    
                elif choice == 'm':
                    # Modify message
                    modified_message = self._modify_message(message)
                    self._record_intervention(message, "modified", modified_message)
                    print(f"{GREEN}Message modified and approved{RESET}")
                    return modified_message
                    
                elif choice == 'r':
                    # Reject message
                    self._record_intervention(message, "rejected", None)
                    print(f"{RED}Message rejected{RESET}")
                    return None
                    
                elif choice == 'i':
                    # Show more info
                    self._display_message_details(message)
                    
                elif choice == 's':
                    # Adjust settings
                    self._adjust_settings(message)
                    
                else:
                    print(f"{RED}Invalid choice. Please try again.{RESET}")
        finally:
            # Restore original signal handler
            self.intervention_active = False
            if hasattr(signal, 'SIGALRM') and original_handler:
                signal.signal(signal.SIGALRM, original_handler)
                signal.alarm(0)
    
    def _timeout_handler(self, signum, frame):
        """Handle timeout signal."""
        if not self.intervention_active:
            return
            
        print(f"\n{YELLOW}Intervention timeout reached. Applying default action.{RESET}")
        
        # Apply default action
        default_action = self.config.get("default_action", "approve")
        if default_action == "approve":
            print(f"{GREEN}Message automatically approved due to timeout{RESET}")
        else:
            print(f"{RED}Message automatically rejected due to timeout{RESET}")
            
        # Reset intervention state
        self.intervention_active = False
        
        # Exit the input loop
        raise KeyboardInterrupt()
    
    def _display_message(self, message: Dict[str, Any], auto_approved: bool = False) -> None:
        """
        Display a message for intervention.
        
        Args:
            message: The message to display
            auto_approved: Whether the message was auto-approved
        """
        message_type = message.get("message_type", "")
        source = message.get("source_specialist", "")
        target = message.get("target_specialist", "")
        
        # Format header based on message type
        if message_type == "query":
            header = f"{YELLOW}{BOLD}Query requiring intervention:{RESET}"
            if auto_approved:
                header = f"{YELLOW}{BOLD}Auto-approved query:{RESET}"
        elif message_type == "response":
            header = f"{GREEN}{BOLD}Response requiring intervention:{RESET}"
            if auto_approved:
                header = f"{GREEN}{BOLD}Auto-approved response:{RESET}"
        else:
            header = f"{BLUE}{BOLD}Message requiring intervention:{RESET}"
            if auto_approved:
                header = f"{BLUE}{BOLD}Auto-approved message:{RESET}"
        
        print("\n" + "=" * 60)
        print(header)
        print(f"{BLUE}From:{RESET} {source}")
        print(f"{BLUE}To:{RESET} {target}")
        print(f"{BLUE}Type:{RESET} {message_type}")
        
        # Display content based on message type
        if message_type == "query":
            content = message.get("content", {})
            query_type = content.get("query_type", "")
            query_text = content.get("query", "")
            context = content.get("context", "")
            
            print(f"{BLUE}Query Type:{RESET} {query_type}")
            print(f"{BLUE}Query:{RESET}")
            print(f"{CYAN}{query_text}{RESET}")
            
            if context:
                print(f"{BLUE}Context:{RESET}")
                print(f"{CYAN}{context}{RESET}")
                
        elif message_type == "response":
            response_text = message.get("content", {}).get("response", "")
            
            print(f"{BLUE}Response:{RESET}")
            print(f"{GREEN}{response_text}{RESET}")
            
        else:
            # Generic content display
            content = message.get("content", {})
            print(f"{BLUE}Content:{RESET}")
            print(json.dumps(content, indent=2))
        
        print("=" * 60)
    
    def _display_message_details(self, message: Dict[str, Any]) -> None:
        """
        Display detailed information about a message.
        
        Args:
            message: The message to display details for
        """
        print("\n" + "=" * 60)
        print(f"{BLUE}{BOLD}Message Details:{RESET}")
        
        # Display general info
        print(f"{BLUE}Message ID:{RESET} {message.get('message_id', 'Unknown')}")
        print(f"{BLUE}From:{RESET} {message.get('source_specialist', 'Unknown')}")
        print(f"{BLUE}To:{RESET} {message.get('target_specialist', 'Unknown')}")
        print(f"{BLUE}Type:{RESET} {message.get('message_type', 'Unknown')}")
        
        # Display metadata
        metadata = message.get("metadata", {})
        print(f"{BLUE}Metadata:{RESET}")
        for key, value in metadata.items():
            print(f"  {key}: {value}")
        
        # Display full message as JSON
        print(f"\n{BLUE}Full Message:{RESET}")
        print(json.dumps(message, indent=2))
        
        print("=" * 60)
        input(f"{YELLOW}Press Enter to continue...{RESET}")
    
    def _modify_message(self, message: Dict[str, Any]) -> Dict[str, Any]:
        """
        Allow user to modify a message.
        
        Args:
            message: The message to modify
            
        Returns:
            Modified message
        """
        modified_message = message.copy()
        message_type = message.get("message_type", "")
        
        print(f"\n{BLUE}{BOLD}Modifying Message:{RESET}")
        
        if message_type == "query":
            # Modify query content
            content = modified_message.get("content", {}).copy()
            
            # Edit query text
            query_text = content.get("query", "")
            print(f"{BLUE}Current Query:{RESET}")
            print(query_text)
            print(f"\n{YELLOW}Enter modified query (or press Enter to keep current):{RESET}")
            new_query = self._get_multiline_input()
            if new_query.strip():
                content["query"] = new_query
                
            # Edit context if present
            if "context" in content:
                context = content.get("context", "")
                print(f"\n{BLUE}Current Context:{RESET}")
                print(context)
                print(f"\n{YELLOW}Enter modified context (or press Enter to keep current):{RESET}")
                new_context = self._get_multiline_input()
                if new_context.strip():
                    content["context"] = new_context
            
            # Update content
            modified_message["content"] = content
            
        elif message_type == "response":
            # Modify response content
            content = modified_message.get("content", {}).copy()
            
            # Edit response text
            response_text = content.get("response", "")
            print(f"{BLUE}Current Response:{RESET}")
            print(response_text)
            print(f"\n{YELLOW}Enter modified response (or press Enter to keep current):{RESET}")
            new_response = self._get_multiline_input()
            if new_response.strip():
                content["response"] = new_response
                
            # Update content
            modified_message["content"] = content
            
        else:
            # For other message types, just edit the raw content
            content = modified_message.get("content", {})
            print(f"{BLUE}Current Content:{RESET}")
            print(json.dumps(content, indent=2))
            print(f"\n{YELLOW}Enter modified content as JSON (or press Enter to keep current):{RESET}")
            new_content = self._get_multiline_input()
            if new_content.strip():
                try:
                    modified_message["content"] = json.loads(new_content)
                except json.JSONDecodeError:
                    print(f"{RED}Invalid JSON. Using original content.{RESET}")
        
        return modified_message
    
    def _get_multiline_input(self) -> str:
        """
        Get multiline input from the user.
        
        Returns:
            Multiline string input
        """
        print(f"{YELLOW}(Type your text, then press Ctrl+D to finish){RESET}")
        lines = []
        
        try:
            while True:
                line = input()
                lines.append(line)
        except EOFError:
            print()  # Add a newline after EOF
            
        return "\n".join(lines)
    
    def _adjust_settings(self, message: Dict[str, Any]) -> None:
        """
        Adjust intervention settings based on the current message.
        
        Args:
            message: The message that triggered intervention
        """
        message_type = message.get("message_type", "")
        source = message.get("source_specialist", "")
        target = message.get("target_specialist", "")
        
        print(f"\n{BLUE}{BOLD}Adjust Intervention Settings:{RESET}")
        print(f"{YELLOW}Current message: {message_type} from {source} to {target}{RESET}")
        
        print(f"\n{BLUE}Options:{RESET}")
        print(f"  {YELLOW}(1){RESET} Auto-approve all messages of this type")
        print(f"  {YELLOW}(2){RESET} Auto-approve all messages from {source}")
        print(f"  {YELLOW}(3){RESET} Auto-approve all messages to {target}")
        print(f"  {YELLOW}(4){RESET} Always intervene on messages from {source}")
        print(f"  {YELLOW}(5){RESET} Always intervene on messages to {target}")
        print(f"  {YELLOW}(6){RESET} Return to intervention")
        
        choice = input(f"\n{GREEN}Enter choice:{RESET} ").strip()
        
        # Get type-specific settings
        if message_type not in self.config.get("intervention_types", {}):
            self.config.setdefault("intervention_types", {})[message_type] = {
                "enabled": True,
                "priority_threshold": 3,
                "auto_approve_specialists": [],
                "always_intervene_specialists": []
            }
            
        type_config = self.config["intervention_types"][message_type]
        
        if choice == "1":
            # Disable interventions for this type
            type_config["enabled"] = False
            print(f"{GREEN}Auto-approving all {message_type} messages{RESET}")
            
        elif choice == "2":
            # Auto-approve messages from source
            if source not in type_config.get("auto_approve_specialists", []):
                type_config.setdefault("auto_approve_specialists", []).append(source)
            print(f"{GREEN}Auto-approving all messages from {source}{RESET}")
            
        elif choice == "3":
            # Auto-approve messages to target
            if target not in type_config.get("auto_approve_specialists", []):
                type_config.setdefault("auto_approve_specialists", []).append(target)
            print(f"{GREEN}Auto-approving all messages to {target}{RESET}")
            
        elif choice == "4":
            # Always intervene on messages from source
            if source not in type_config.get("always_intervene_specialists", []):
                type_config.setdefault("always_intervene_specialists", []).append(source)
            print(f"{GREEN}Always intervening on messages from {source}{RESET}")
            
        elif choice == "5":
            # Always intervene on messages to target
            if target not in type_config.get("always_intervene_specialists", []):
                type_config.setdefault("always_intervene_specialists", []).append(target)
            print(f"{GREEN}Always intervening on messages to {target}{RESET}")
            
        elif choice == "6":
            # Just return to intervention
            return
            
        else:
            print(f"{RED}Invalid choice.{RESET}")
            
        # Save settings
        self._save_config()
    
    def _save_config(self) -> None:
        """Save the current configuration to disk."""
        config_path = os.path.expanduser("~/ai_framework_git/config/intervention.json")
        
        # Create directory if it doesn't exist
        os.makedirs(os.path.dirname(config_path), exist_ok=True)
        
        try:
            with open(config_path, "w") as f:
                json.dump(self.config, f, indent=2)
            logger.info(f"Saved intervention configuration to {config_path}")
        except Exception as e:
            logger.error(f"Error saving intervention configuration: {e}")
    
    def _record_intervention(
        self, 
        message: Dict[str, Any], 
        action: str, 
        result: Optional[Dict[str, Any]]
    ) -> None:
        """
        Record an intervention for learning.
        
        Args:
            message: The original message
            action: The action taken (approved, modified, rejected)
            result: The resulting message (or None if rejected)
        """
        # Create intervention record
        record = {
            "message_id": message.get("message_id"),
            "message_type": message.get("message_type"),
            "source_specialist": message.get("source_specialist"),
            "target_specialist": message.get("target_specialist"),
            "timestamp": datetime.now().isoformat(),
            "action": action,
            "modified": (action == "modified")
        }
        
        # Add to history
        self.intervention_history.append(record)
        
        # Save to disk for learning
        if self.config.get("learning", {}).get("enabled", False):
            history_path = os.path.expanduser("~/ai_framework_git/logs/intervention_history.jsonl")
            
            try:
                # Create directory if it doesn't exist
                os.makedirs(os.path.dirname(history_path), exist_ok=True)
                
                # Append to history file
                with open(history_path, "a") as f:
                    f.write(json.dumps(record) + "\n")
            except Exception as e:
                logger.error(f"Error saving intervention history: {e}")
    
    def start_watch_mode(self) -> None:
        """Start watch mode to monitor all messages without intervening."""
        self.config["watch_mode"] = True
        logger.info("Starting watch mode")
        
        # Save settings
        self._save_config()
        
        if self.cli_mode:
            print(f"{GREEN}{BOLD}Watch mode started.{RESET}")
            print(f"{YELLOW}All messages will be displayed, but only those requiring intervention will pause execution.{RESET}")
            print(f"{YELLOW}Press Ctrl+C to exit watch mode.{RESET}")
    
    def stop_watch_mode(self) -> None:
        """Stop watch mode."""
        self.config["watch_mode"] = False
        logger.info("Stopping watch mode")
        
        # Save settings
        self._save_config()
        
        if self.cli_mode:
            print(f"{GREEN}{BOLD}Watch mode stopped.{RESET}")
    
    def get_pending_interventions(self) -> List[Dict[str, Any]]:
        """
        Get all pending interventions.
        
        Returns:
            List of pending intervention dictionaries
        """
        # Convert queue to list without removing items
        pending = []
        with self.pending_interventions.mutex:
            for item in list(self.pending_interventions.queue):
                if item["status"] == "pending":
                    pending.append(item)
        return pending
    
    def handle_intervention(
        self, 
        intervention_id: str, 
        action: str, 
        modified_message: Optional[Dict[str, Any]] = None
    ) -> bool:
        """
        Handle an intervention programmatically.
        
        Args:
            intervention_id: ID of the intervention to handle
            action: Action to take (approve, modify, reject)
            modified_message: Modified message if action is "modify"
            
        Returns:
            True if intervention was handled successfully, False otherwise
        """
        # Find the intervention
        intervention = None
        for item in self.intervention_history:
            if item.get("id") == intervention_id:
                intervention = item
                break
                
        if not intervention:
            logger.error(f"Intervention {intervention_id} not found")
            return False
            
        # Check if already handled
        if intervention["status"] != "pending":
            logger.warning(f"Intervention {intervention_id} already handled")
            return False
            
        # Handle the intervention
        if action == "approve":
            intervention["status"] = "approved"
            intervention["action"] = "approved"
            intervention["timestamp_handled"] = datetime.now().isoformat()
            
        elif action == "modify":
            if not modified_message:
                logger.error("Modified message required for modify action")
                return False
                
            intervention["status"] = "approved"
            intervention["action"] = "modified"
            intervention["modified_message"] = modified_message
            intervention["timestamp_handled"] = datetime.now().isoformat()
            
        elif action == "reject":
            intervention["status"] = "rejected"
            intervention["action"] = "rejected"
            intervention["timestamp_handled"] = datetime.now().isoformat()
            
        else:
            logger.error(f"Unknown action: {action}")
            return False
            
        logger.info(f"Handled intervention {intervention_id} with action {action}")
        return True


# Unit tests
if __name__ == "__main__":
    import tempfile
    import shutil
    from message_bus import MessageBus
    
    # Create a temporary directory for testing
    test_dir = tempfile.mkdtemp()
    
    try:
        # Initialize message bus
        bus = MessageBus(session_id="test_session", session_dir=test_dir)
        
        # Test standard intervention manager with CLI disabled
        manager = InterventionManager(bus, cli_mode=False)
        
        # Test configuration loading
        assert "enabled" in manager.config
        assert "intervention_types" in manager.config
        
        # Mock a message that would require intervention
        test_message = {
            "message_id": "test-id",
            "message_type": "query",
            "source_specialist": "master_coder",
            "target_specialist": "security_expert",
            "content": {
                "query_type": "clarification",
                "query": "What's the best password hashing algorithm?",
                "context": "Building an authentication system"
            },
            "metadata": {
                "priority": 1,
                "timestamp": datetime.now().isoformat(),
                "session_id": "test_session"
            }
        }
        
        # Test should_intervene
        config_with_intervention = {
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
        
        manager.config = config_with_intervention
        assert manager._should_intervene(test_message)
        
        # Test intervention disabling
        config_without_intervention = {
            "enabled": False
        }
        
        manager.config = config_without_intervention
        assert not manager._should_intervene(test_message)
        
        # Test auto-approval
        config_with_auto_approve = {
            "enabled": True,
            "intervention_types": {
                "query": {
                    "enabled": True,
                    "priority_threshold": 3,
                    "auto_approve_specialists": ["master_coder"],
                    "always_intervene_specialists": []
                }
            }
        }
        
        manager.config = config_with_auto_approve
        assert not manager._should_intervene(test_message)
        
        print("All tests passed!")
        
    finally:
        # Clean up
        shutil.rmtree(test_dir)