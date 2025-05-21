#!/usr/bin/env python3
"""
Mirador Message Bus

This module implements the core messaging infrastructure for bidirectional
communication between specialists in the Mirador AI Framework.
"""

import os
import json
import uuid
import time
import logging
from typing import Dict, List, Optional, Any, Set, Tuple, Callable
from datetime import datetime
from collections import defaultdict
import threading

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger("mirador-message-bus")

class MessageBus:
    """
    Central component that manages communication between specialists.
    
    The MessageBus handles routing, tracking, and coordination of messages
    between specialists in the Mirador framework, enabling bidirectional
    communication.
    """
    
    def __init__(self, session_id: str = None, session_dir: str = None):
        """
        Initialize the message bus.
        
        Args:
            session_id: Unique identifier for this session. If None, one will be generated.
            session_dir: Directory to store session data. If None, uses default location.
        """
        self.session_id = session_id or str(uuid.uuid4())
        self.session_dir = session_dir or os.path.join(
            os.path.expanduser("~/ai_framework_git/outputs/sessions"), 
            f"session_{self.session_id}"
        )
        
        # Create session directory structure
        os.makedirs(self.session_dir, exist_ok=True)
        os.makedirs(os.path.join(self.session_dir, "messages"), exist_ok=True)
        os.makedirs(os.path.join(self.session_dir, "queue"), exist_ok=True)
        
        # Initialize state
        self.messages: List[Dict[str, Any]] = []
        self.message_graph: Dict[str, Dict[str, List[str]]] = defaultdict(lambda: defaultdict(list))
        self.query_cache: Dict[str, Dict[str, Any]] = {}
        
        # Circular dependency detection
        self.active_queries: Dict[str, Set[Tuple[str, str]]] = defaultdict(set)
        
        # Message interceptors for user intervention
        self.interceptors: List[Callable[[Dict[str, Any]], Optional[Dict[str, Any]]]] = []
        
        # Threading lock for thread safety
        self.lock = threading.Lock()
        
        logger.info(f"MessageBus initialized with session ID: {self.session_id}")
        logger.info(f"Session directory: {self.session_dir}")
    
    def register_interceptor(
        self, 
        interceptor: Callable[[Dict[str, Any]], Optional[Dict[str, Any]]]
    ) -> None:
        """
        Register a message interceptor function.
        
        Args:
            interceptor: Function that takes a message and returns a modified message
                         or None to reject the message
        """
        self.interceptors.append(interceptor)
        logger.info(f"Registered message interceptor: {interceptor.__qualname__}")
    
    def create_message(
        self, 
        message_type: str,
        source_specialist: str,
        target_specialist: str,
        content: Dict[str, Any],
        priority: int = 3,
        timeout_ms: int = 30000,
        parent_message_id: Optional[str] = None
    ) -> Dict[str, Any]:
        """
        Create a properly formatted message.
        
        Args:
            message_type: Type of message (query, response, notification)
            source_specialist: Specialist sending the message
            target_specialist: Specialist receiving the message
            content: Message content with query type, text, and context
            priority: Message priority (1-5, with 1 being highest)
            timeout_ms: Timeout in milliseconds
            parent_message_id: ID of the parent message, if this is a response
            
        Returns:
            Complete message dictionary
        """
        message_id = str(uuid.uuid4())
        timestamp = datetime.now().isoformat()
        
        message = {
            "message_id": message_id,
            "message_type": message_type,
            "source_specialist": source_specialist,
            "target_specialist": target_specialist,
            "content": content,
            "metadata": {
                "timestamp": timestamp,
                "priority": priority,
                "timeout_ms": timeout_ms,
                "session_id": self.session_id
            }
        }
        
        if parent_message_id:
            message["metadata"]["parent_message_id"] = parent_message_id
            
        return message
    
    def route_message(self, message: Dict[str, Any]) -> Optional[str]:
        """
        Route a message between specialists.
        
        Args:
            message: Complete message dictionary to route
            
        Returns:
            Message ID of the routed message, or None if message was rejected by an interceptor
        """
        with self.lock:
            # Process through interceptors first
            modified_message = message
            for interceptor in self.interceptors:
                try:
                    result = interceptor(modified_message)
                    if result is None:
                        # Message rejected by interceptor
                        logger.info(f"Message {modified_message['message_id']} rejected by interceptor {interceptor.__qualname__}")
                        return None
                    modified_message = result
                except Exception as e:
                    logger.error(f"Error in interceptor {interceptor.__qualname__}: {e}")
                    # Continue processing with unmodified message in case of interceptor error
            
            # Proceed with the potentially modified message
            message = modified_message
            
            # Store message in memory
            self.messages.append(message)
            
            # Update message graph
            source = message["source_specialist"]
            target = message["target_specialist"]
            message_id = message["message_id"]
            self.message_graph[source][target].append(message_id)
            
            # Store message on disk
            message_path = os.path.join(
                self.session_dir, 
                "messages", 
                f"{message_id}.json"
            )
            with open(message_path, "w") as f:
                json.dump(message, f, indent=2)
            
            # Queue message for processing
            queue_path = os.path.join(
                self.session_dir,
                "queue",
                f"{target}_{message_id}.json"
            )
            with open(queue_path, "w") as f:
                json.dump(message, f, indent=2)
            
            # Add to active queries if this is a query
            if message["message_type"] == "query":
                query_pair = (source, target)
                query_text = message["content"].get("query", "")
                query_key = f"{source}:{target}:{query_text}"
                self.active_queries[query_key].add(query_pair)
                
                # Check for circular dependencies
                if self._check_circular_dependency(source, target):
                    logger.warning(f"Circular dependency detected: {source} → {target}")
                    # Create a notification about the circular dependency
                    self._create_circular_dependency_notification(message)
            
            logger.info(f"Routed message: {message_id} from {source} to {target}")
            return message_id
    
    def get_pending_messages(self, specialist: str) -> List[Dict[str, Any]]:
        """
        Get all pending messages for a specialist.
        
        Args:
            specialist: Name of the specialist to get messages for
            
        Returns:
            List of pending messages
        """
        with self.lock:
            # Read from queue directory
            queue_dir = os.path.join(self.session_dir, "queue")
            specialist_messages = []
            
            for filename in os.listdir(queue_dir):
                if filename.startswith(f"{specialist}_"):
                    message_path = os.path.join(queue_dir, filename)
                    try:
                        with open(message_path, "r") as f:
                            message = json.load(f)
                            specialist_messages.append(message)
                    except Exception as e:
                        logger.error(f"Error reading message {filename}: {e}")
            
            # Sort by priority
            specialist_messages.sort(key=lambda m: m["metadata"].get("priority", 3))
            
            return specialist_messages
    
    def mark_message_processed(self, message_id: str) -> None:
        """
        Mark a message as processed and remove it from the queue.
        
        Args:
            message_id: ID of the message to mark as processed
        """
        with self.lock:
            # Find the message
            message = None
            for m in self.messages:
                if m["message_id"] == message_id:
                    message = m
                    break
            
            if not message:
                logger.warning(f"Message {message_id} not found")
                return
            
            # Remove from queue
            target = message["target_specialist"]
            queue_path = os.path.join(
                self.session_dir,
                "queue",
                f"{target}_{message_id}.json"
            )
            
            if os.path.exists(queue_path):
                os.remove(queue_path)
                logger.info(f"Removed {message_id} from queue")
            
            # Update metadata to mark as processed
            message["metadata"]["processed"] = True
            message["metadata"]["processed_timestamp"] = datetime.now().isoformat()
            
            # Update message on disk
            message_path = os.path.join(
                self.session_dir, 
                "messages", 
                f"{message_id}.json"
            )
            with open(message_path, "w") as f:
                json.dump(message, f, indent=2)
    
    def send_query(
        self,
        source_specialist: str,
        target_specialist: str,
        query: str,
        query_type: str = "clarification",
        context: Optional[str] = None,
        priority: int = 3
    ) -> Optional[Dict[str, Any]]:
        """
        Send a query from one specialist to another.
        
        Args:
            source_specialist: Specialist sending the query
            target_specialist: Specialist receiving the query
            query: The actual question or request
            query_type: Type of query (clarification, elaboration, collaboration)
            context: Additional context for the query
            priority: Query priority (1-5, with 1 being highest)
            
        Returns:
            The created and routed message, or None if message was rejected by an interceptor
        """
        # Create content
        content = {
            "query_type": query_type,
            "query": query
        }
        
        if context:
            content["context"] = context
        
        # Create and route message
        message = self.create_message(
            message_type="query",
            source_specialist=source_specialist,
            target_specialist=target_specialist,
            content=content,
            priority=priority
        )
        
        message_id = self.route_message(message)
        if message_id is None:
            # Message was rejected by an interceptor
            return None
            
        return message
    
    def send_response(
        self,
        source_specialist: str,
        target_specialist: str,
        query_message_id: str,
        response: str,
        priority: int = 2
    ) -> Optional[Dict[str, Any]]:
        """
        Send a response to a query.
        
        Args:
            source_specialist: Specialist sending the response
            target_specialist: Specialist receiving the response
            query_message_id: ID of the query being responded to
            response: The actual response text
            priority: Response priority (1-5, with 1 being highest)
            
        Returns:
            The created and routed message, or None if message was rejected by an interceptor
        """
        # Create content
        content = {
            "response": response
        }
        
        # Create and route message
        message = self.create_message(
            message_type="response",
            source_specialist=source_specialist,
            target_specialist=target_specialist,
            content=content,
            priority=priority,
            parent_message_id=query_message_id
        )
        
        message_id = self.route_message(message)
        if message_id is None:
            # Message was rejected by an interceptor
            return None
        
        # Update query cache
        query_message = self.get_message(query_message_id)
        if query_message:
            query_text = query_message["content"].get("query", "")
            cache_key = f"{query_message['source_specialist']}:{query_text}"
            self.query_cache[cache_key] = message
            
            # Remove from active queries
            query_key = f"{target_specialist}:{source_specialist}:{query_text}"
            if query_key in self.active_queries:
                query_pair = (target_specialist, source_specialist)
                self.active_queries[query_key].discard(query_pair)
        
        return message
    
    def extract_queries_from_text(self, specialist: str, text: str) -> List[Dict[str, Any]]:
        """
        Extract queries from specialist output text.
        
        Args:
            specialist: The specialist who generated the text
            text: Text to extract queries from
            
        Returns:
            List of extracted query dictionaries
        """
        queries = []
        
        # Look for query tags in the format:
        # <query specialist="name">query text</query>
        import re
        query_pattern = r'<query\s+specialist=["\']([^"\']+)["\']>(.*?)</query>'
        matches = re.finditer(query_pattern, text, re.DOTALL)
        
        for match in matches:
            target = match.group(1).strip()
            query_text = match.group(2).strip()
            
            # Create a query message
            query = {
                "target_specialist": target,
                "query": query_text,
                "source_specialist": specialist
            }
            queries.append(query)
        
        return queries
    
    def process_specialist_output(
        self, 
        specialist: str, 
        output: str
    ) -> Tuple[str, List[Dict[str, Any]]]:
        """
        Process specialist output, extracting and routing any queries.
        
        Args:
            specialist: The specialist who generated the output
            output: The raw output text
            
        Returns:
            Tuple of (cleaned output, list of routed queries)
        """
        # Extract queries
        extracted_queries = self.extract_queries_from_text(specialist, output)
        
        # Route each query
        routed_queries = []
        for query in extracted_queries:
            message = self.send_query(
                source_specialist=specialist,
                target_specialist=query["target_specialist"],
                query=query["query"]
            )
            if message is not None:  # Only add if not rejected by an interceptor
                routed_queries.append(message)
        
        # Clean output by removing query tags
        cleaned_output = output
        if extracted_queries:
            import re
            query_pattern = r'<query\s+specialist=["\']([^"\']+)["\']>(.*?)</query>'
            cleaned_output = re.sub(query_pattern, '', cleaned_output, flags=re.DOTALL)
            # Clean up any double newlines
            cleaned_output = re.sub(r'\n\s*\n\s*\n', '\n\n', cleaned_output)
        
        return cleaned_output, routed_queries
    
    def get_message(self, message_id: str) -> Optional[Dict[str, Any]]:
        """
        Get a message by ID.
        
        Args:
            message_id: ID of the message to retrieve
            
        Returns:
            The message dictionary, or None if not found
        """
        # Check in-memory cache first
        for message in self.messages:
            if message["message_id"] == message_id:
                return message
        
        # If not in memory, try to load from disk
        message_path = os.path.join(
            self.session_dir, 
            "messages", 
            f"{message_id}.json"
        )
        
        if os.path.exists(message_path):
            try:
                with open(message_path, "r") as f:
                    return json.load(f)
            except Exception as e:
                logger.error(f"Error reading message {message_id}: {e}")
                
        return None
    
    def get_session_graph(self) -> Dict[str, Any]:
        """
        Get a complete graph of the session's message flow.
        
        Returns:
            Dictionary with session graph data
        """
        nodes = set()
        edges = []
        
        # Add all specialists as nodes
        for source in self.message_graph:
            nodes.add(source)
            for target in self.message_graph[source]:
                nodes.add(target)
                # Add edges for all messages
                for message_id in self.message_graph[source][target]:
                    message = self.get_message(message_id)
                    if message:
                        edges.append({
                            "source": source,
                            "target": target,
                            "message_id": message_id,
                            "message_type": message["message_type"],
                            "timestamp": message["metadata"]["timestamp"]
                        })
        
        # Create graph
        graph = {
            "session_id": self.session_id,
            "nodes": list(nodes),
            "edges": edges,
            "timestamp": datetime.now().isoformat()
        }
        
        return graph
    
    def save_session_graph(self) -> str:
        """
        Save the session graph to disk.
        
        Returns:
            Path to the saved graph file
        """
        graph = self.get_session_graph()
        graph_path = os.path.join(self.session_dir, "session_graph.json")
        
        with open(graph_path, "w") as f:
            json.dump(graph, f, indent=2)
            
        logger.info(f"Saved session graph to {graph_path}")
        return graph_path
    
    def _check_circular_dependency(self, source: str, target: str) -> bool:
        """
        Check if adding a query from source to target would create a circular dependency.
        
        Args:
            source: Source specialist
            target: Target specialist
            
        Returns:
            True if circular dependency would be created, False otherwise
        """
        # Simple check for direct circular dependency
        if target in self.message_graph and source in self.message_graph[target]:
            active_targets = set()
            for key, pairs in self.active_queries.items():
                for s, t in pairs:
                    if s == target:
                        active_targets.add(t)
            
            if source in active_targets:
                return True
        
        # TODO: Implement deeper circular dependency checking
        return False
    
    def _create_circular_dependency_notification(self, message: Dict[str, Any]) -> None:
        """
        Create a notification for a circular dependency.
        
        Args:
            message: The message that would create a circular dependency
        """
        source = message["source_specialist"]
        target = message["target_specialist"]
        
        # Create notification message
        notification = self.create_message(
            message_type="notification",
            source_specialist="message_bus",
            target_specialist=source,
            content={
                "notification_type": "circular_dependency",
                "message": f"Circular dependency detected between {source} and {target}",
                "original_query": message["content"].get("query", ""),
                "recommendation": "Try reformulating your query or requesting information from a different specialist"
            },
            priority=1
        )
        
        self.route_message(notification)


# Unit tests
if __name__ == "__main__":
    import shutil
    import tempfile
    
    # Create a temporary directory for testing
    test_dir = tempfile.mkdtemp()
    
    try:
        # Initialize message bus
        bus = MessageBus(session_id="test_session", session_dir=test_dir)
        
        # Test query and response flow
        query = bus.send_query(
            source_specialist="code_reviewer_fix",
            target_specialist="master_coder",
            query="What's the best way to implement authentication in Python?",
            query_type="collaboration"
        )
        
        # Check that the query was created
        assert query is not None
        assert query["message_type"] == "query"
        assert query["source_specialist"] == "code_reviewer_fix"
        assert query["target_specialist"] == "master_coder"
        
        # Get pending messages
        pending = bus.get_pending_messages("master_coder")
        assert len(pending) == 1
        assert pending[0]["message_id"] == query["message_id"]
        
        # Send response
        response = bus.send_response(
            source_specialist="master_coder",
            target_specialist="code_reviewer_fix",
            query_message_id=query["message_id"],
            response="I recommend using JWT tokens with proper expiration and refresh mechanism."
        )
        
        # Check that the response was created
        assert response is not None
        assert response["message_type"] == "response"
        assert response["source_specialist"] == "master_coder"
        assert response["target_specialist"] == "code_reviewer_fix"
        
        # Test interceptors
        class TestInterceptorState:
            def __init__(self):
                self.intercepted = False
                
        interceptor_state = TestInterceptorState()
        
        def test_interceptor(message):
            # For testing purposes, we'll reject any message to the security_expert
            if message["target_specialist"] == "security_expert":
                interceptor_state.intercepted = True
                return None  # Reject message
            return message  # Allow message to proceed
        
        # Register interceptor
        bus.register_interceptor(test_interceptor)
        
        # Test query extraction
        text = """Here's my initial review of the code:

The authentication function seems weak. 

<query specialist="security_expert">
What are the best practices for secure password storage?
</query>

I think we should also consider rate limiting.

<query specialist="master_coder">
Can you provide an example of rate limiting in Python?
</query>

Overall, the code needs significant security improvements."""

        cleaned, queries = bus.process_specialist_output("code_reviewer_fix", text)
        
        # Check that the queries were extracted and intercepted correctly
        assert len(queries) == 1  # Only one query should have passed through
        assert queries[0]["target_specialist"] == "master_coder"
        assert interceptor_state.intercepted == True  # Security query should have been intercepted
        
        # Check that the cleaned output doesn't contain query tags
        assert "<query" not in cleaned
        assert "</query>" not in cleaned
        
        # Test interceptor that modifies messages
        bus.interceptors.clear()  # Clear existing interceptors
        
        def modifying_interceptor(message):
            if message["message_type"] == "query":
                # Add a flag to the content
                message["content"]["intercepted"] = True
            return message
        
        bus.register_interceptor(modifying_interceptor)
        
        modified_query = bus.send_query(
            source_specialist="security_expert",
            target_specialist="master_coder",
            query="Is this code secure?"
        )
        
        # Check that the interceptor modified the message
        assert modified_query is not None
        assert modified_query["content"].get("intercepted") == True
        
        # Mark messages as processed
        bus.mark_message_processed(query["message_id"])
        
        # Save session graph
        graph_path = bus.save_session_graph()
        assert os.path.exists(graph_path)
        
        print("All tests passed!")
        
    finally:
        # Clean up
        shutil.rmtree(test_dir)