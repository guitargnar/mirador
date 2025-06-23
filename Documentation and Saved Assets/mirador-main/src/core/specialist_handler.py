#!/usr/bin/env python3
"""
Mirador Specialist Handler

This module provides the interface for specialists to communicate bidirectionally.
It handles query generation, response processing, and integration with the message bus.
"""

import os
import json
import time
import logging
import requests
from typing import Dict, List, Optional, Any, Tuple
import re

# Import message bus
from message_bus import MessageBus

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger("mirador-specialist-handler")

class SpecialistHandler:
    """
    Handles interaction with specialists, including bidirectional communication.
    
    The SpecialistHandler is responsible for:
    - Sending prompts to specialists
    - Extracting queries from responses
    - Routing queries and responses via the message bus
    - Presenting a clean interface for chain execution
    """
    
    def __init__(
        self, 
        message_bus: MessageBus,
        specialist_info: Dict[str, Dict[str, Any]] = None,
        api_url: str = "http://localhost:11434/api/generate"
    ):
        """
        Initialize the specialist handler.
        
        Args:
            message_bus: The message bus to use for communication
            specialist_info: Dictionary of specialist information
            api_url: URL of the Ollama API
        """
        self.message_bus = message_bus
        self.api_url = api_url
        
        # Load specialist information if not provided
        if specialist_info is None:
            self.specialist_info = self._load_specialist_info()
        else:
            self.specialist_info = specialist_info
            
        logger.info(f"SpecialistHandler initialized with {len(self.specialist_info)} specialists")
    
    def _load_specialist_info(self) -> Dict[str, Dict[str, Any]]:
        """
        Load specialist information from configuration.
        
        Returns:
            Dictionary of specialist information
        """
        # Look for config files in standard locations
        config_paths = [
            os.path.expanduser("~/ai_framework_git/config/specialists.json"),
            os.path.expanduser("~/ai_framework_git/config/config.json")
        ]
        
        for path in config_paths:
            if os.path.exists(path):
                try:
                    with open(path, "r") as f:
                        config = json.load(f)
                        
                    # Check if it's the specialists.json format
                    if "specialists" in config:
                        return config["specialists"]
                    
                    # Check if it's the config.json format with models
                    if "models" in config:
                        return config["models"]
                        
                except Exception as e:
                    logger.error(f"Error loading specialist info from {path}: {e}")
        
        # Default specialists if no config is found
        logger.warning("No specialist config found, using defaults")
        return {
            "master_coder": {
                "description": "Code generation specialist",
                "temperature": 0.4
            },
            "code_reviewer_fix": {
                "description": "Code review and security specialist",
                "temperature": 0.3
            },
            "creative_entrepreneur": {
                "description": "Business application specialist",
                "temperature": 0.7
            },
            "llama3.2_balanced": {
                "description": "General purpose specialist",
                "temperature": 0.6
            },
            "enhanced_agent": {
                "description": "Comprehensive analysis specialist",
                "temperature": 0.7
            }
        }
    
    def get_bidirectional_prompt_wrapper(self, specialist: str) -> str:
        """
        Get the prompt wrapper for enabling bidirectional communication.
        
        Args:
            specialist: The specialist name
            
        Returns:
            Prompt wrapper text to enable bidirectional communication
        """
        # Get available specialists excluding this one
        available_specialists = [s for s in self.specialist_info.keys() if s != specialist]
        available_str = ", ".join(available_specialists)
        
        # Create wrapper text
        wrapper = f"""
You are working as part of a collaborative AI system with multiple specialists.
You can ask questions to other specialists by formatting your response using the query tags.

Available specialists: {available_str}

To ask a question to another specialist, include a section like this in your response:

<query specialist="specialist_name">
Your specific question here
</query>

You can ask multiple questions to different specialists if needed.
Continue with your normal response outside of these query sections.

For example:
"I need to implement authentication but I'm not sure about the best practices.

<query specialist="security_expert">
What are the current best practices for secure password storage in 2023?
</query>

Based on the other information, I recommend..."

Keep your queries focused and specific. Only ask for information that would actually help you provide a better response.
"""
        return wrapper
    
    def enhance_prompt_for_bidirectional(self, specialist: str, prompt: str) -> str:
        """
        Enhance a prompt to support bidirectional communication.
        
        Args:
            specialist: The specialist name
            prompt: The original prompt
            
        Returns:
            Enhanced prompt with bidirectional capabilities
        """
        wrapper = self.get_bidirectional_prompt_wrapper(specialist)
        return f"{wrapper}\n\n{prompt}"
    
    def query_specialist(
        self, 
        specialist: str, 
        prompt: str,
        enable_queries: bool = True,
        temperature: Optional[float] = None,
        max_tokens: int = 1024,
        process_queries: bool = True
    ) -> Tuple[str, List[Dict[str, Any]]]:
        """
        Query a specialist model and process any generated queries.
        
        Args:
            specialist: The specialist name
            prompt: The prompt to send
            enable_queries: Whether to enable query generation
            temperature: Override the specialist's default temperature
            max_tokens: Maximum tokens to generate
            process_queries: Whether to process and route any queries
            
        Returns:
            Tuple of (cleaned response, list of routed queries)
        """
        # Enhance prompt if queries are enabled
        if enable_queries:
            enhanced_prompt = self.enhance_prompt_for_bidirectional(specialist, prompt)
        else:
            enhanced_prompt = prompt
        
        # Get specialist temperature if not overridden
        if temperature is None and specialist in self.specialist_info:
            temperature = self.specialist_info[specialist].get("temperature", 0.7)
        elif temperature is None:
            temperature = 0.7
        
        # Prepare API request
        payload = {
            "model": specialist,
            "prompt": enhanced_prompt,
            "stream": False,
            "temperature": temperature,
            "num_predict": max_tokens
        }
        
        logger.info(f"Querying specialist: {specialist}")
        start_time = time.time()
        
        try:
            # Call the API
            response = requests.post(self.api_url, json=payload)
            response.raise_for_status()
            response_data = response.json()
            
            # Extract the response text
            if "response" in response_data:
                raw_response = response_data["response"]
            else:
                logger.error(f"Unexpected API response format: {response_data}")
                raw_response = f"[Error: Unexpected response format from {specialist}]"
                
            logger.info(f"Received response from {specialist} in {time.time() - start_time:.2f}s")
            
            # Process queries if enabled
            if enable_queries and process_queries:
                cleaned_response, queries = self.message_bus.process_specialist_output(
                    specialist, raw_response
                )
                return cleaned_response, queries
            else:
                return raw_response, []
                
        except Exception as e:
            logger.error(f"Error querying specialist {specialist}: {e}")
            return f"[Error: {str(e)}]", []
    
    def handle_pending_messages(self, specialist: str) -> List[Dict[str, Any]]:
        """
        Handle all pending messages for a specialist.
        
        Args:
            specialist: The specialist name
            
        Returns:
            List of processed messages
        """
        # Get pending messages
        pending_messages = self.message_bus.get_pending_messages(specialist)
        processed_messages = []
        
        for message in pending_messages:
            message_id = message["message_id"]
            source = message["source_specialist"]
            
            # Handle based on message type
            if message["message_type"] == "query":
                # Process query
                query_text = message["content"]["query"]
                context = message["content"].get("context", "")
                
                # Create prompt for query
                query_prompt = f"""
The specialist '{source}' has asked you the following question:

{query_text}

"""
                if context:
                    query_prompt += f"""
Additional context provided:
{context}

"""
                query_prompt += """
Please provide a clear and concise response to help them with their specific question.
"""
                
                # Query specialist for response
                response_text, _ = self.query_specialist(
                    specialist=specialist,
                    prompt=query_prompt,
                    enable_queries=False,  # Disable nested queries to prevent loops
                    process_queries=False
                )
                
                # Send response back
                self.message_bus.send_response(
                    source_specialist=specialist,
                    target_specialist=source,
                    query_message_id=message_id,
                    response=response_text
                )
                
                # Mark message as processed
                self.message_bus.mark_message_processed(message_id)
                processed_messages.append(message)
                
            elif message["message_type"] == "response":
                # Just mark responses as processed
                self.message_bus.mark_message_processed(message_id)
                processed_messages.append(message)
                
            elif message["message_type"] == "notification":
                # Just mark notifications as processed
                self.message_bus.mark_message_processed(message_id)
                processed_messages.append(message)
        
        return processed_messages
    
    def run_with_collaboration(
        self,
        prompt: str,
        specialists: List[str],
        handle_messages: bool = True,
        max_iterations: int = 5
    ) -> Dict[str, Any]:
        """
        Run a collaborative chain with bidirectional communication.
        
        Args:
            prompt: The initial prompt
            specialists: List of specialists to use
            handle_messages: Whether to handle pending messages
            max_iterations: Maximum number of iterations to prevent infinite loops
            
        Returns:
            Dictionary with execution results
        """
        if not specialists:
            logger.error("No specialists provided")
            return {"error": "No specialists provided", "output": ""}
        
        results = {
            "prompt": prompt,
            "specialists": specialists,
            "steps": [],
            "queries": [],
            "communication_graph": []
        }
        
        current_prompt = prompt
        iteration = 0
        
        while iteration < max_iterations:
            iteration += 1
            progress = {}
            
            for i, specialist in enumerate(specialists):
                logger.info(f"Running specialist {specialist} (iteration {iteration}, position {i+1}/{len(specialists)})")
                
                # Handle any pending messages first
                if handle_messages:
                    processed = self.handle_pending_messages(specialist)
                    if processed:
                        logger.info(f"Processed {len(processed)} pending messages for {specialist}")
                
                # Create step-specific prompt
                if i == 0 and iteration == 1:
                    # First specialist in first iteration gets original prompt
                    step_prompt = current_prompt
                else:
                    # Others get current state plus history
                    step_prompt = self._create_chain_prompt(specialist, current_prompt, results)
                
                # Query the specialist
                start_time = time.time()
                response, queries = self.query_specialist(specialist, step_prompt)
                elapsed = time.time() - start_time
                
                # Record step results
                step_result = {
                    "specialist": specialist,
                    "iteration": iteration,
                    "position": i + 1,
                    "prompt": step_prompt,
                    "response": response,
                    "queries": queries,
                    "time": elapsed
                }
                results["steps"].append(step_result)
                
                # Track all queries for visualization
                if queries:
                    for query in queries:
                        results["queries"].append(query)
                        results["communication_graph"].append({
                            "from": specialist,
                            "to": query["target_specialist"],
                            "type": "query",
                            "content": query["content"]["query"]
                        })
                
                # Update current prompt for next specialist
                current_prompt = response
                
                # Process any responses received
                if handle_messages:
                    responses = self._get_responses_for_specialist(specialist)
                    for resp in responses:
                        source = resp["source_specialist"]
                        results["communication_graph"].append({
                            "from": source,
                            "to": specialist,
                            "type": "response",
                            "content": resp["content"]["response"]
                        })
            
            # Check if we need another iteration
            if not self._needs_another_iteration(results):
                break
        
        # Add final message graph
        results["message_graph"] = self.message_bus.get_session_graph()
        
        return results
    
    def _create_chain_prompt(
        self, 
        specialist: str, 
        current_prompt: str, 
        results: Dict[str, Any]
    ) -> str:
        """
        Create a prompt for a specialist in the chain.
        
        Args:
            specialist: The specialist to create a prompt for
            current_prompt: The current state of the prompt
            results: Results dictionary with history
            
        Returns:
            Prompt text for this specialist
        """
        # Get previous steps to provide context
        previous_steps = [s for s in results["steps"] if s["specialist"] != specialist]
        
        # If no previous steps, just use the current prompt
        if not previous_steps:
            return current_prompt
        
        # Create prompt with context from previous steps
        prompt = f"""I need your assistance with the following task:

{results['prompt']}

Previous specialists have contributed the following:

"""
        
        # Add the most recent contribution from each specialist (excluding current one)
        seen_specialists = set()
        for step in reversed(previous_steps):
            step_specialist = step["specialist"]
            if step_specialist not in seen_specialists:
                prompt += f"\n## {step_specialist}:\n{step['response']}\n"
                seen_specialists.add(step_specialist)
        
        prompt += f"""
Based on the above context and previous contributions, please provide your expertise as the {specialist} specialist.
Focus on adding unique value based on your specific capabilities.

Current task state:
{current_prompt}
"""
        
        return prompt
    
    def _get_responses_for_specialist(self, specialist: str) -> List[Dict[str, Any]]:
        """
        Get responses to queries sent by this specialist.
        
        Args:
            specialist: The specialist name
            
        Returns:
            List of response messages
        """
        responses = []
        
        # Get all messages targeting this specialist
        pending = self.message_bus.get_pending_messages(specialist)
        
        # Filter for responses
        for message in pending:
            if message["message_type"] == "response":
                responses.append(message)
                # Mark as processed
                self.message_bus.mark_message_processed(message["message_id"])
        
        return responses
    
    def _needs_another_iteration(self, results: Dict[str, Any]) -> bool:
        """
        Determine if another iteration is needed.
        
        Args:
            results: Results dictionary
            
        Returns:
            True if another iteration is needed, False otherwise
        """
        # For now, just run one iteration
        # TODO: Implement more sophisticated iteration determination
        return False


# Test the specialist handler
if __name__ == "__main__":
    import tempfile
    import shutil
    
    # Create a temporary directory for testing
    test_dir = tempfile.mkdtemp()
    
    try:
        # Initialize message bus
        bus = MessageBus(session_id="test_session", session_dir=test_dir)
        
        # Initialize specialist handler
        handler = SpecialistHandler(bus)
        
        # Test enhanced prompt
        enhanced = handler.enhance_prompt_for_bidirectional(
            "master_coder", 
            "Create a secure authentication system in Python"
        )
        assert "You can ask questions to other specialists" in enhanced
        assert "Create a secure authentication system in Python" in enhanced
        
        # Test mock query processing (without actual API calls)
        mock_response = """Here's a basic authentication system:

```python
def authenticate(username, password):
    # Hash the password before comparing
    hashed = hash_password(password)
    return check_credentials(username, hashed)
```

But I'm not sure about the best hashing algorithm.

<query specialist="security_expert">
What's the recommended password hashing algorithm for Python in 2023?
</query>

I'll continue with the implementation.
"""
        
        # Create a mock version of the query_specialist method for testing
        def mock_query(specialist, prompt, **kwargs):
            return mock_response, []
            
        # Replace the real method with mock for testing
        handler.query_specialist = mock_query
        
        # Test run_with_collaboration using the mock
        results = handler.run_with_collaboration(
            "Create a secure authentication system",
            ["master_coder", "code_reviewer_fix"],
            handle_messages=False,  # Don't try to handle messages since we're mocking
            max_iterations=1
        )
        
        # Verify results
        assert len(results["steps"]) > 0
        assert "master_coder" in [s["specialist"] for s in results["steps"]]
        
        print("All tests passed!")
        
    finally:
        # Clean up
        shutil.rmtree(test_dir)