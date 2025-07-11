"""
Specific load testing scenarios for Mirador API.
"""
import json
import random
import time
from typing import Dict, List
from locust import HttpUser, task, between, SequentialTaskSet, TaskSet
from locust.contrib.fasthttp import FastHttpUser


class MiradorScenarios:
    """Common scenarios and data for load testing."""
    
    LIFE_OPTIMIZATION_PROMPTS = [
        "How can I achieve better work-life balance?",
        "What habits should I develop for long-term success?",
        "How do I overcome procrastination?",
        "What's the best way to manage my energy levels?",
        "How can I improve my morning routine?"
    ]
    
    BUSINESS_ACCELERATION_PROMPTS = [
        "How should I scale my startup?",
        "What's the best strategy for customer acquisition?",
        "How can I improve team productivity?",
        "What metrics should I track for growth?",
        "How do I build a strong company culture?"
    ]
    
    CREATIVE_BREAKTHROUGH_PROMPTS = [
        "Help me think outside the box for this project",
        "How can I overcome creative block?",
        "What are innovative approaches to problem-solving?",
        "How do I foster creativity in my team?",
        "Generate unique ideas for product development"
    ]
    
    TECHNICAL_MASTERY_PROMPTS = [
        "Explain microservices architecture",
        "What are best practices for API design?",
        "How do I optimize database performance?",
        "What's the difference between various ML algorithms?",
        "How should I structure a scalable application?"
    ]
    
    MODELS = [
        "matthew_context_provider_v5",
        "matthew_context_provider_v6",
        "universal_strategy_architect",
        "creative_catalyst",
        "practical_implementer",
        "technical_advisor",
        "domain_expert"
    ]


class TypicalUserJourney(SequentialTaskSet):
    """Simulates a typical user journey through the API."""
    
    def on_start(self):
        """Initialize user session."""
        self.chain_results = []
        self.selected_models = []
    
    @task
    def check_health(self):
        """First, check if API is healthy."""
        response = self.client.get("/api/v5/health")
        if response.status_code != 200:
            self.interrupt()
    
    @task
    def list_available_chains(self):
        """Browse available chains."""
        response = self.client.get("/api/v5/chains")
        if response.status_code == 200:
            chains = response.json()
            self.available_chains = [c["name"] for c in chains]
    
    @task
    def list_available_models(self):
        """Browse available models."""
        response = self.client.get("/api/v5/models")
        if response.status_code == 200:
            models = response.json()
            self.selected_models = random.sample(
                [m["name"] for m in models], 
                min(3, len(models))
            )
    
    @task
    def execute_primary_chain(self):
        """Execute main chain request."""
        chain_type = "life_optimization"
        prompt = random.choice(MiradorScenarios.LIFE_OPTIMIZATION_PROMPTS)
        
        response = self.client.post(
            "/api/v5/chains/execute",
            json={
                "chain_type": chain_type,
                "prompt": prompt,
                "parameters": {
                    "temperature": 0.7,
                    "max_tokens": 1500
                }
            }
        )
        
        if response.status_code == 200:
            result = response.json()
            self.chain_results.append(result)
            self.session_id = result.get("session_id")
    
    @task
    def follow_up_question(self):
        """Ask a follow-up question using direct model inference."""
        if not self.selected_models or not self.chain_results:
            return
        
        model = random.choice(self.selected_models)
        follow_up = "Based on the previous advice, what specific steps should I take this week?"
        
        self.client.post(
            "/api/v5/models/inference",
            json={
                "model": model,
                "prompt": follow_up,
                "context": self.chain_results[-1].get("results", ""),
                "stream": False
            }
        )
    
    @task
    def execute_secondary_chain(self):
        """Execute a related chain."""
        chain_type = "business_acceleration"
        prompt = "How can I apply these personal improvements to my business?"
        
        response = self.client.post(
            "/api/v5/chains/execute",
            json={
                "chain_type": chain_type,
                "prompt": prompt,
                "context": self.chain_results[-1].get("results", "") if self.chain_results else "",
                "parameters": {
                    "temperature": 0.8,
                    "max_tokens": 2000
                }
            }
        )
        
        if response.status_code == 200:
            self.chain_results.append(response.json())


class HeavyAnalyticsUser(TaskSet):
    """User focused on analytics and data queries."""
    
    @task(3)
    def query_chain_analytics(self):
        """Query chain execution analytics via GraphQL."""
        query = """
        query GetChainAnalytics($timeRange: TimeRange!) {
            chainAnalytics(timeRange: $timeRange) {
                totalExecutions
                averageResponseTime
                successRate
                popularChains {
                    chainType
                    executionCount
                    averageTokens
                }
            }
        }
        """
        
        variables = {
            "timeRange": {
                "start": "2024-01-01T00:00:00Z",
                "end": "2024-12-31T23:59:59Z"
            }
        }
        
        self.client.post(
            "/api/v5/graphql",
            json={"query": query, "variables": variables}
        )
    
    @task(2)
    def query_model_performance(self):
        """Query model performance metrics."""
        query = """
        query GetModelPerformance {
            modelPerformance {
                model
                requestCount
                averageLatency
                errorRate
                tokenUsage {
                    input
                    output
                    total
                }
            }
        }
        """
        
        self.client.post(
            "/api/v5/graphql",
            json={"query": query}
        )
    
    @task(1)
    def export_metrics(self):
        """Export Prometheus metrics."""
        self.client.get("/api/v5/metrics")
    
    @task(2)
    def detailed_health_check(self):
        """Get detailed health information."""
        self.client.get("/api/v5/health?detailed=true")


class StreamingPowerUser(FastHttpUser):
    """Power user that heavily uses streaming features."""
    
    wait_time = between(0.5, 2)
    
    def on_start(self):
        """Initialize with API key."""
        response = self.client.post(
            "/api/v5/auth/api-keys",
            json={
                "name": f"Streaming Power User {self.environment.runner.user_count}",
                "scopes": ["read", "write", "stream"]
            },
            headers={"X-API-Key": self.environment.parsed_options.admin_key}
        )
        
        if response.status_code == 201:
            self.api_key = response.json()["key"]
            self.client.headers.update({"X-API-Key": self.api_key})
    
    @task(3)
    def streaming_chain_execution(self):
        """Execute chains with streaming."""
        chain_type = random.choice([
            "creative_breakthrough",
            "technical_mastery"
        ])
        
        prompts_map = {
            "creative_breakthrough": MiradorScenarios.CREATIVE_BREAKTHROUGH_PROMPTS,
            "technical_mastery": MiradorScenarios.TECHNICAL_MASTERY_PROMPTS
        }
        
        prompt = random.choice(prompts_map[chain_type])
        
        start_time = time.time()
        chunks_received = 0
        
        with self.client.post(
            "/api/v5/chains/execute",
            json={
                "chain_type": chain_type,
                "prompt": prompt,
                "stream": True,
                "parameters": {
                    "temperature": 0.9,
                    "max_tokens": 3000
                }
            },
            stream=True,
            catch_response=True
        ) as response:
            if response.status_code == 200:
                for line in response.iter_lines():
                    if line and line.startswith(b"data: "):
                        chunks_received += 1
                        # Simulate processing delay
                        time.sleep(0.01)
                
                response.success()
                # Record custom metrics
                total_time = time.time() - start_time
                self.environment.stats.log_request(
                    "CUSTOM",
                    f"streaming_chunks_{chain_type}",
                    total_time * 1000,
                    chunks_received
                )
            else:
                response.failure(f"Streaming failed: {response.status_code}")
    
    @task(2)
    def streaming_model_inference(self):
        """Direct model streaming."""
        model = random.choice(MiradorScenarios.MODELS)
        prompt = "Generate a detailed analysis with streaming output"
        
        start_time = time.time()
        chunks_received = 0
        
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
                for line in response.iter_lines():
                    if line and line.startswith(b"data: "):
                        chunks_received += 1
                
                response.success()
            else:
                response.failure(f"Model streaming failed: {response.status_code}")
    
    @task(1)
    def websocket_chat_session(self):
        """Simulate WebSocket chat session."""
        # Note: Locust doesn't natively support WebSocket, 
        # so we simulate with multiple HTTP requests
        session_id = f"ws_session_{random.randint(1000, 9999)}"
        
        # Simulate chat messages
        messages = [
            "Hello, I need help with a complex problem",
            "Can you break it down into steps?",
            "What about implementation details?",
            "Thank you, that's helpful!"
        ]
        
        for message in messages:
            self.client.post(
                f"/api/v5/chat/{session_id}",
                json={
                    "message": message,
                    "model": random.choice(MiradorScenarios.MODELS)
                }
            )
            # Simulate reading delay
            time.sleep(random.uniform(0.5, 2))


class StressTestUser(FastHttpUser):
    """User designed to stress test the system."""
    
    wait_time = between(0.1, 0.5)  # Very aggressive
    
    def on_start(self):
        """Initialize with API key."""
        response = self.client.post(
            "/api/v5/auth/api-keys",
            json={
                "name": f"Stress Test User {self.environment.runner.user_count}",
                "scopes": ["read", "write"]
            },
            headers={"X-API-Key": self.environment.parsed_options.admin_key}
        )
        
        if response.status_code == 201:
            self.api_key = response.json()["key"]
            self.client.headers.update({"X-API-Key": self.api_key})
    
    @task(5)
    def rapid_fire_requests(self):
        """Send rapid requests to test rate limiting."""
        endpoints = [
            "/api/v5/chains",
            "/api/v5/models",
            "/api/v5/health",
            f"/api/v5/models/{random.choice(MiradorScenarios.MODELS)}"
        ]
        
        endpoint = random.choice(endpoints)
        response = self.client.get(endpoint)
        
        # Check for rate limiting
        if response.status_code == 429:
            self.environment.stats.log_request(
                "RATE_LIMITED",
                endpoint,
                0,
                0
            )
    
    @task(3)
    def large_payload_requests(self):
        """Send requests with large payloads."""
        # Create a large prompt
        base_prompt = "Analyze this data: "
        large_data = "x" * 10000  # 10KB of data
        
        self.client.post(
            "/api/v5/models/inference",
            json={
                "model": random.choice(MiradorScenarios.MODELS),
                "prompt": base_prompt + large_data,
                "stream": False
            }
        )
    
    @task(2)
    def concurrent_chain_executions(self):
        """Execute multiple chains concurrently."""
        chain_types = ["life_optimization", "business_acceleration", "creative_breakthrough"]
        
        # Note: In real scenario, these would be concurrent
        for chain_type in chain_types:
            self.client.post(
                "/api/v5/chains/execute",
                json={
                    "chain_type": chain_type,
                    "prompt": f"Quick test for {chain_type}",
                    "parameters": {
                        "temperature": 0.5,
                        "max_tokens": 500
                    }
                },
                name=f"/api/v5/chains/execute_{chain_type}"
            )
    
    @task(1)
    def cache_buster_requests(self):
        """Make requests designed to bypass cache."""
        # Add random query parameters to bypass cache
        random_param = random.randint(1000, 9999)
        self.client.get(f"/api/v5/chains?cache_buster={random_param}")


class MobileAppUser(HttpUser):
    """Simulates mobile app usage patterns."""
    
    wait_time = between(3, 8)  # Mobile users typically have longer pauses
    
    def on_start(self):
        """Initialize mobile session."""
        # Simulate mobile app authentication
        response = self.client.post(
            "/api/v5/auth/mobile",
            json={
                "device_id": f"mobile_{random.randint(10000, 99999)}",
                "app_version": "2.1.0"
            },
            headers={"X-API-Key": self.environment.parsed_options.admin_key}
        )
        
        if response.status_code in [200, 201]:
            auth_data = response.json()
            self.api_key = auth_data.get("key", self.environment.parsed_options.admin_key)
            self.client.headers.update({
                "X-API-Key": self.api_key,
                "User-Agent": "MiradorMobile/2.1.0"
            })
    
    @task(4)
    def quick_advice_request(self):
        """Quick advice - common mobile use case."""
        prompts = [
            "Quick tip for productivity",
            "One thing to improve today",
            "Simple habit to start",
            "Quick motivation boost"
        ]
        
        self.client.post(
            "/api/v5/models/inference",
            json={
                "model": "matthew_context_provider_v5",
                "prompt": random.choice(prompts),
                "stream": False,
                "max_tokens": 200  # Shorter responses for mobile
            },
            timeout=30
        )
    
    @task(2)
    def voice_to_text_simulation(self):
        """Simulate voice input (longer prompts)."""
        voice_prompts = [
            "So I've been thinking about my career and I'm wondering what steps "
            "I should take to advance to the next level and maybe switch to a "
            "leadership role what do you think would be the best approach",
            
            "I'm feeling stuck with my current project and need some creative "
            "ideas to make it more engaging can you help me brainstorm some "
            "innovative approaches that would really make it stand out"
        ]
        
        self.client.post(
            "/api/v5/chains/execute",
            json={
                "chain_type": "life_optimization",
                "prompt": random.choice(voice_prompts),
                "parameters": {
                    "temperature": 0.8,
                    "max_tokens": 1000
                }
            },
            timeout=60
        )
    
    @task(1)
    def save_favorite(self):
        """Save response as favorite (mobile feature)."""
        # Simulate saving a favorite
        self.client.post(
            "/api/v5/favorites",
            json={
                "session_id": f"session_{random.randint(1000, 9999)}",
                "title": "Great advice on productivity",
                "tags": ["productivity", "motivation", "daily"]
            }
        )
    
    @task(3)
    def check_notifications(self):
        """Check for new content/notifications."""
        self.client.get("/api/v5/notifications")
        
    def on_stop(self):
        """Clean up mobile session."""
        self.client.post("/api/v5/auth/logout")