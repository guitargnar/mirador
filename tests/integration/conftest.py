"""
Pytest configuration for integration tests.
"""
import asyncio
import os
import sys
from typing import AsyncGenerator, Generator

import pytest
import pytest_asyncio
from httpx import AsyncClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from testcontainers.postgres import PostgresContainer
from testcontainers.redis import RedisContainer

# Add parent directory to path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(__file__))))

from src.api.app import app
from src.api.database import Base, get_db
from src.api.config import settings
from src.api.auth import create_api_key


@pytest.fixture(scope="session")
def event_loop():
    """Create an instance of the default event loop for the test session."""
    loop = asyncio.get_event_loop_policy().new_event_loop()
    yield loop
    loop.close()


@pytest.fixture(scope="session")
def postgres_container():
    """Start PostgreSQL container for testing."""
    with PostgresContainer("postgres:15-alpine") as postgres:
        yield postgres


@pytest.fixture(scope="session")
def redis_container():
    """Start Redis container for testing."""
    with RedisContainer("redis:7-alpine") as redis:
        yield redis


@pytest.fixture(scope="session")
def database_url(postgres_container):
    """Get database URL from container."""
    return postgres_container.get_connection_url()


@pytest.fixture(scope="session")
def redis_url(redis_container):
    """Get Redis URL from container."""
    return f"redis://{redis_container.get_container_host_ip()}:{redis_container.get_exposed_port(6379)}"


@pytest.fixture(scope="session")
def engine(database_url):
    """Create database engine."""
    return create_engine(database_url)


@pytest.fixture(scope="session")
def tables(engine):
    """Create database tables."""
    Base.metadata.create_all(bind=engine)
    yield
    Base.metadata.drop_all(bind=engine)


@pytest.fixture
def db_session(engine, tables):
    """Create database session."""
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    session = SessionLocal()
    yield session
    session.close()


@pytest.fixture
def override_settings(database_url, redis_url):
    """Override settings for testing."""
    settings.DATABASE_URL = database_url
    settings.REDIS_URL = redis_url
    settings.JWT_SECRET_KEY = "test-secret-key"
    settings.DEBUG = True


@pytest.fixture
async def test_api_key(db_session):
    """Create test API key."""
    api_key = await create_api_key(
        db_session,
        name="Test API Key",
        scopes=["read", "write", "admin"]
    )
    yield api_key.key
    # Cleanup
    db_session.delete(api_key)
    db_session.commit()


@pytest_asyncio.fixture
async def async_client(override_settings) -> AsyncGenerator[AsyncClient, None]:
    """Create async HTTP client for testing."""
    async with AsyncClient(app=app, base_url="http://test") as client:
        yield client


@pytest_asyncio.fixture
async def authenticated_client(async_client: AsyncClient, test_api_key: str) -> AsyncClient:
    """Create authenticated async HTTP client."""
    async_client.headers["X-API-Key"] = test_api_key
    return async_client


@pytest.fixture
def sample_chain_request():
    """Sample chain execution request."""
    return {
        "chain_type": "life_optimization",
        "prompt": "How can I improve my productivity?",
        "parameters": {
            "temperature": 0.7,
            "max_tokens": 1000
        }
    }


@pytest.fixture
def sample_model_request():
    """Sample model inference request."""
    return {
        "model": "matthew_context_provider_v5",
        "prompt": "What are your thoughts on productivity?",
        "stream": False
    }


@pytest.fixture
def mock_ollama_response(monkeypatch):
    """Mock Ollama API responses."""
    async def mock_generate(*args, **kwargs):
        return {
            "model": kwargs.get("model", "test-model"),
            "response": "This is a test response from the model.",
            "done": True,
            "context": [1, 2, 3],
            "total_duration": 1000000000,
            "load_duration": 100000000,
            "prompt_eval_duration": 200000000,
            "eval_duration": 700000000,
            "eval_count": 50
        }
    
    async def mock_stream(*args, **kwargs):
        responses = [
            {"response": "This ", "done": False},
            {"response": "is ", "done": False},
            {"response": "a ", "done": False},
            {"response": "test.", "done": True}
        ]
        for response in responses:
            yield response
    
    # Patch the ollama client methods
    monkeypatch.setattr("ollama.AsyncClient.generate", mock_generate)
    monkeypatch.setattr("ollama.AsyncClient.generate_stream", mock_stream)