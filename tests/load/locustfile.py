"""
Load testing scenarios for Mirador API using Locust.
"""
import json
import random
import time
from locust import HttpUser, task, between, events
from locust.env import Environment
from locust.stats import stats_printer, stats_history
import gevent


class MiradorAPIUser(HttpUser):
    """Simulates a user interacting with the Mirador API."""
    
    wait_time = between(1, 3)  # Wait 1-3 seconds between tasks
    
    def on_start(self):
        """Called when a user starts."""
        # Create an API key for this user
        response = self.client.post(
            "/api/v5/auth/api-keys",
            json={
                "name": f"Load Test User {self.environment.runner.user_count}",
                "scopes": ["read", "write"]
            },
            headers={"X-API-Key": self.environment.parsed_options.admin_key}
        )
        
        if response.status_code == 201:
            self.api_key = response.json()["key"]
            self.client.headers.update({"X-API-Key": self.api_key})
        else:
            raise Exception(f"Failed to create API key: {response.status_code}")
    
    @task(3)
    def list_chains(self):
        """List available chains."""
        with self.client.get(
            "/api/v5/chains",
            catch_response=True
        ) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Got status code {response.status_code}")
    
    @task(2)
    def list_models(self):
        """List available models."""
        with self.client.get(
            "/api/v5/models",
            catch_response=True
        ) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Got status code {response.status_code}")
    
    @task(1)
    def get_model_info(self):
        """Get information about a specific model."""
        models = [
            "matthew_context_provider_v5",
            "universal_strategy_architect",
            "creative_catalyst",
            "practical_implementer"
        ]
        model = random.choice(models)
        
        with self.client.get(
            f"/api/v5/models/{model}",
            catch_response=True
        ) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Got status code {response.status_code}")
    
    @task(5)
    def execute_chain(self):
        """Execute a chain."""
        chain_types = [
            "life_optimization",
            "business_acceleration",
            "creative_breakthrough",
            "relationship_harmony",
            "technical_mastery"
        ]
        
        prompts = [
            "How can I improve my productivity?",
            "What strategies should I use for my business?",
            "Help me think creatively about this problem.",
            "How can I communicate better?",
            "Explain this technical concept simply."
        ]
        
        chain_type = random.choice(chain_types)
        prompt = random.choice(prompts)
        
        with self.client.post(
            "/api/v5/chains/execute",
            json={
                "chain_type": chain_type,
                "prompt": prompt,
                "parameters": {
                    "temperature": random.uniform(0.5, 0.9),
                    "max_tokens": random.randint(500, 2000)
                }
            },
            catch_response=True
        ) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Got status code {response.status_code}")
    
    @task(4)
    def model_inference(self):
        """Direct model inference."""
        models = [
            "matthew_context_provider_v5",
            "universal_strategy_architect",
            "creative_catalyst"
        ]
        
        prompts = [
            "What are your thoughts on this?",
            "Can you analyze this situation?",
            "Provide insights on this topic.",
            "What would you recommend?"
        ]
        
        model = random.choice(models)
        prompt = random.choice(prompts)
        
        with self.client.post(
            "/api/v5/models/inference",
            json={
                "model": model,
                "prompt": prompt,
                "stream": False
            },
            catch_response=True
        ) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Got status code {response.status_code}")
    
    @task(1)
    def health_check(self):
        """Check API health."""
        with self.client.get(
            "/api/v5/health",
            catch_response=True
        ) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Got status code {response.status_code}")


class StreamingUser(HttpUser):
    """User that tests streaming endpoints."""
    
    wait_time = between(2, 5)
    
    def on_start(self):
        """Called when a user starts."""
        # Create an API key for this user
        response = self.client.post(
            "/api/v5/auth/api-keys",
            json={
                "name": f"Streaming User {self.environment.runner.user_count}",
                "scopes": ["read", "write"]
            },
            headers={"X-API-Key": self.environment.parsed_options.admin_key}
        )
        
        if response.status_code == 201:
            self.api_key = response.json()["key"]
            self.client.headers.update({"X-API-Key": self.api_key})
        else:
            raise Exception(f"Failed to create API key: {response.status_code}")
    
    @task
    def streaming_chain_execution(self):
        """Test streaming chain execution."""
        chain_types = ["life_optimization", "creative_breakthrough"]
        prompts = ["Stream me some insights", "Generate ideas continuously"]
        
        chain_type = random.choice(chain_types)
        prompt = random.choice(prompts)
        
        start_time = time.time()
        
        with self.client.post(
            "/api/v5/chains/execute",
            json={
                "chain_type": chain_type,
                "prompt": prompt,
                "stream": True
            },
            stream=True,
            catch_response=True
        ) as response:
            if response.status_code == 200:
                chunks = 0
                for line in response.iter_lines():
                    if line and line.startswith(b"data: "):
                        chunks += 1
                
                total_time = int((time.time() - start_time) * 1000)
                events.request.fire(
                    request_type="SSE",
                    name="/api/v5/chains/execute (streaming)",
                    response_time=total_time,
                    response_length=chunks,
                    exception=None,
                    context={}
                )
                response.success()
            else:
                response.failure(f"Got status code {response.status_code}")
    
    @task
    def streaming_model_inference(self):
        """Test streaming model inference."""
        models = ["matthew_context_provider_v5", "creative_catalyst"]
        prompts = ["Stream your thoughts", "Generate content continuously"]
        
        model = random.choice(models)
        prompt = random.choice(prompts)
        
        start_time = time.time()
        
        with self.client.post(
            "/api/v5/models/inference",
            json={
                "model": model,
                "prompt": prompt,
                "stream": True
            },
            stream=True,
            catch_response=True
        ) as response:
            if response.status_code == 200:
                chunks = 0
                for line in response.iter_lines():
                    if line and line.startswith(b"data: "):
                        chunks += 1
                
                total_time = int((time.time() - start_time) * 1000)
                events.request.fire(
                    request_type="SSE",
                    name="/api/v5/models/inference (streaming)",
                    response_time=total_time,
                    response_length=chunks,
                    exception=None,
                    context={}
                )
                response.success()
            else:
                response.failure(f"Got status code {response.status_code}")


class GraphQLUser(HttpUser):
    """User that tests GraphQL endpoints."""
    
    wait_time = between(1, 3)
    
    def on_start(self):
        """Called when a user starts."""
        # Create an API key for this user
        response = self.client.post(
            "/api/v5/auth/api-keys",
            json={
                "name": f"GraphQL User {self.environment.runner.user_count}",
                "scopes": ["read", "write"]
            },
            headers={"X-API-Key": self.environment.parsed_options.admin_key}
        )
        
        if response.status_code == 201:
            self.api_key = response.json()["key"]
            self.client.headers.update({"X-API-Key": self.api_key})
        else:
            raise Exception(f"Failed to create API key: {response.status_code}")
    
    @task(3)
    def graphql_query_chains(self):
        """Query chains via GraphQL."""
        query = """
        query {
            chains {
                name
                description
                models
            }
        }
        """
        
        with self.client.post(
            "/api/v5/graphql",
            json={"query": query},
            catch_response=True
        ) as response:
            if response.status_code == 200:
                data = response.json()
                if "errors" not in data:
                    response.success()
                else:
                    response.failure(f"GraphQL errors: {data['errors']}")
            else:
                response.failure(f"Got status code {response.status_code}")
    
    @task(2)
    def graphql_query_models(self):
        """Query models via GraphQL."""
        query = """
        query {
            models {
                name
                description
                parameters {
                    temperature
                    contextLength
                }
            }
        }
        """
        
        with self.client.post(
            "/api/v5/graphql",
            json={"query": query},
            catch_response=True
        ) as response:
            if response.status_code == 200:
                data = response.json()
                if "errors" not in data:
                    response.success()
                else:
                    response.failure(f"GraphQL errors: {data['errors']}")
            else:
                response.failure(f"Got status code {response.status_code}")
    
    @task(1)
    def graphql_mutation_execute_chain(self):
        """Execute chain via GraphQL mutation."""
        chain_types = ["life_optimization", "business_acceleration"]
        prompts = ["GraphQL test prompt", "Another test via GraphQL"]
        
        chain_type = random.choice(chain_types)
        prompt = random.choice(prompts)
        
        mutation = """
        mutation ExecuteChain($input: ChainExecutionInput!) {
            executeChain(input: $input) {
                sessionId
                chainType
                status
                results
            }
        }
        """
        
        variables = {
            "input": {
                "chainType": chain_type,
                "prompt": prompt,
                "parameters": {
                    "temperature": 0.7
                }
            }
        }
        
        with self.client.post(
            "/api/v5/graphql",
            json={"query": mutation, "variables": variables},
            catch_response=True
        ) as response:
            if response.status_code == 200:
                data = response.json()
                if "errors" not in data:
                    response.success()
                else:
                    response.failure(f"GraphQL errors: {data['errors']}")
            else:
                response.failure(f"Got status code {response.status_code}")


class AdminUser(HttpUser):
    """Admin user that tests administrative endpoints."""
    
    wait_time = between(5, 10)
    
    def on_start(self):
        """Called when a user starts."""
        self.client.headers.update({"X-API-Key": self.environment.parsed_options.admin_key})
    
    @task
    def list_api_keys(self):
        """List all API keys."""
        with self.client.get(
            "/api/v5/auth/api-keys",
            catch_response=True
        ) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Got status code {response.status_code}")
    
    @task
    def metrics_endpoint(self):
        """Get metrics."""
        with self.client.get(
            "/api/v5/metrics",
            catch_response=True
        ) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Got status code {response.status_code}")
    
    @task
    def detailed_health_check(self):
        """Get detailed health check."""
        with self.client.get(
            "/api/v5/health?detailed=true",
            catch_response=True
        ) as response:
            if response.status_code == 200:
                response.success()
            else:
                response.failure(f"Got status code {response.status_code}")


# Custom command line arguments
@events.init_command_line_parser.add_listener
def init_parser(parser):
    parser.add_argument(
        "--admin-key",
        type=str,
        required=True,
        help="Admin API key for creating test users"
    )