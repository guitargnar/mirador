# Mirador API Testing Suite

This directory contains the comprehensive testing suite for the Mirador API, including unit tests, integration tests, and load tests.

## Test Structure

```
tests/
├── __init__.py
├── unit/               # Unit tests (to be implemented)
├── integration/        # Integration tests
│   ├── __init__.py
│   ├── conftest.py     # Test fixtures and configuration
│   └── test_api_endpoints.py  # API endpoint tests
├── load/              # Load and performance tests
│   ├── __init__.py
│   ├── locustfile.py   # Main load test scenarios
│   ├── test_scenarios.py  # Specialized test scenarios
│   ├── run_load_tests.sh  # Script to run load tests
│   └── *.html          # Generated test reports
└── README.md          # This file
```

## Running Tests

### Prerequisites

Install test dependencies:
```bash
pip install -r requirements.txt
```

### Unit Tests

```bash
# Run all unit tests
pytest tests/unit/

# Run with coverage
pytest tests/unit/ --cov=src/api --cov-report=html
```

### Integration Tests

Integration tests use test containers for PostgreSQL and Redis:

```bash
# Run all integration tests
pytest tests/integration/

# Run specific test class
pytest tests/integration/test_api_endpoints.py::TestHealthEndpoints

# Run with verbose output
pytest tests/integration/ -v
```

### Load Tests

Load tests use Locust to simulate user traffic:

```bash
# Run with web UI
cd tests/load
./run_load_tests.sh -k YOUR_ADMIN_KEY

# Run headless
./run_load_tests.sh -k YOUR_ADMIN_KEY --headless

# Run specific scenario
./run_load_tests.sh -k YOUR_ADMIN_KEY -s streaming --headless --report
```

## Test Categories

### Integration Tests

1. **Health Endpoints**: Basic health checks and readiness probes
2. **Authentication**: API key creation, validation, and management
3. **Chain Execution**: Synchronous and streaming chain execution
4. **Model Inference**: Direct model calls with streaming support
5. **WebSocket**: Real-time bidirectional communication
6. **GraphQL**: Query and mutation testing
7. **Rate Limiting**: Verify rate limit enforcement
8. **Caching**: Test cache headers and invalidation

### Load Test Scenarios

1. **MiradorAPIUser**: Standard API usage patterns
2. **StreamingUser**: Heavy streaming endpoint usage
3. **GraphQLUser**: GraphQL-specific operations
4. **AdminUser**: Administrative operations
5. **TypicalUserJourney**: Sequential user flow
6. **HeavyAnalyticsUser**: Analytics and reporting
7. **StreamingPowerUser**: Aggressive streaming
8. **StressTestUser**: Stress testing and rate limiting
9. **MobileAppUser**: Mobile usage patterns

## Writing New Tests

### Integration Test Example

```python
@pytest.mark.asyncio
async def test_new_endpoint(authenticated_client: AsyncClient):
    """Test description."""
    response = await authenticated_client.get("/api/v5/new-endpoint")
    assert response.status_code == 200
    data = response.json()
    assert "expected_field" in data
```

### Load Test Example

```python
class NewUserType(HttpUser):
    wait_time = between(1, 3)
    
    @task
    def new_behavior(self):
        """Test new behavior."""
        self.client.get("/api/v5/endpoint")
```

## CI/CD Integration

### GitHub Actions

```yaml
name: Run Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      - name: Install dependencies
        run: pip install -r requirements.txt
      - name: Run tests
        run: |
          pytest tests/unit/
          pytest tests/integration/
```

## Test Data

- Test fixtures are defined in `conftest.py`
- Mock responses for external services
- Test database is created/destroyed for each session
- Redis test container for caching tests

## Performance Targets

| Test Type | Target | Timeout |
|-----------|--------|---------|
| Unit Tests | < 1s per test | 5s |
| Integration Tests | < 5s per test | 30s |
| Load Tests | Varies by scenario | 5-60m |

## Troubleshooting

### Common Issues

1. **Container startup failures**
   - Ensure Docker is running
   - Check port availability
   - Verify resource limits

2. **Authentication errors**
   - Verify admin API key
   - Check test fixtures

3. **Flaky tests**
   - Add appropriate waits
   - Check for race conditions
   - Verify test isolation

### Debug Mode

Run tests with debug output:
```bash
pytest -vv --log-cli-level=DEBUG
```

## Contributing

1. Write tests for new features
2. Ensure all tests pass locally
3. Add appropriate markers (`@pytest.mark.asyncio`, etc.)
4. Update this README for new test categories
5. Include tests in pull requests

## Resources

- [Pytest Documentation](https://docs.pytest.org/)
- [Locust Documentation](https://docs.locust.io/)
- [Testcontainers Documentation](https://testcontainers-python.readthedocs.io/)