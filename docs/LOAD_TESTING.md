# Load Testing Guide for Mirador API

This guide explains how to run load tests against the Mirador API using Locust.

## Prerequisites

1. Install Locust:
```bash
pip install locust
```

2. Ensure the Mirador API is running:
```bash
docker-compose up -d
```

3. Create an admin API key:
```bash
curl -X POST http://localhost/api/v5/auth/api-keys \
  -H "Content-Type: application/json" \
  -H "X-API-Key: your-initial-admin-key" \
  -d '{"name": "Load Test Admin", "scopes": ["admin"]}'
```

## Running Load Tests

### Basic Load Test

Run the default load test scenarios:

```bash
cd tests/load
locust -f locustfile.py --host=http://localhost --admin-key=YOUR_ADMIN_KEY
```

Then open http://localhost:8089 in your browser to access the Locust web UI.

### Command Line Mode

Run without web UI:

```bash
locust -f locustfile.py \
  --headless \
  --users 100 \
  --spawn-rate 10 \
  --run-time 5m \
  --host=http://localhost \
  --admin-key=YOUR_ADMIN_KEY
```

### Specific User Types

Test with specific user behavior patterns:

```bash
# Standard API users
locust -f locustfile.py -u 50 -r 5 --host=http://localhost --admin-key=YOUR_KEY

# Streaming-heavy users
locust -f test_scenarios.py --class-picker -u 20 -r 2 --host=http://localhost --admin-key=YOUR_KEY

# Stress testing
locust -f test_scenarios.py:StressTestUser -u 200 -r 20 --host=http://localhost --admin-key=YOUR_KEY
```

## Load Test Scenarios

### 1. MiradorAPIUser (Default)
- Standard API usage patterns
- Balanced mix of read/write operations
- Tests chains, models, and basic endpoints

### 2. StreamingUser
- Heavy streaming endpoint usage
- Tests SSE and streaming responses
- Higher bandwidth consumption

### 3. GraphQLUser
- GraphQL-specific queries and mutations
- Complex data fetching patterns
- Tests GraphQL performance

### 4. AdminUser
- Administrative operations
- Metrics and monitoring endpoints
- Lower frequency, higher privilege

### 5. TypicalUserJourney
- Sequential user flow
- Simulates real user behavior
- Tests session persistence

### 6. HeavyAnalyticsUser
- Analytics and reporting queries
- Complex aggregations
- Tests database performance

### 7. StreamingPowerUser
- Aggressive streaming usage
- Multiple concurrent streams
- Tests streaming scalability

### 8. StressTestUser
- Rapid-fire requests
- Large payloads
- Tests rate limiting and resilience

### 9. MobileAppUser
- Mobile usage patterns
- Shorter sessions
- Quick responses

## Performance Targets

Based on the system design, aim for these performance targets:

| Metric | Target | Critical |
|--------|--------|----------|
| Response Time (p95) | < 2s | < 5s |
| Response Time (p99) | < 5s | < 10s |
| Requests/sec | > 100 | > 50 |
| Error Rate | < 1% | < 5% |
| Streaming Latency | < 100ms | < 500ms |

## Analyzing Results

### Key Metrics to Monitor

1. **Response Times**
   - Average, median, 95th, and 99th percentiles
   - Look for degradation under load

2. **Throughput**
   - Requests per second
   - Total data transferred

3. **Error Rates**
   - HTTP errors (5xx, 4xx)
   - Timeout errors
   - Connection errors

4. **Resource Usage**
   - CPU utilization
   - Memory consumption
   - Database connections
   - Redis memory

### Using Monitoring Stack

Monitor real-time metrics during load tests:

1. **Prometheus Metrics**: http://localhost:9090
   - Query: `rate(http_requests_total[1m])`
   - Query: `histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[1m]))`

2. **Grafana Dashboards**: http://localhost:3000
   - Import the provided dashboard
   - Monitor during load tests

3. **Application Logs**:
   ```bash
   docker-compose logs -f mirador-api
   ```

## Load Test Scenarios

### Scenario 1: Gradual Ramp-up
```bash
locust -f locustfile.py \
  --headless \
  --users 100 \
  --spawn-rate 1 \
  --run-time 10m \
  --host=http://localhost \
  --admin-key=YOUR_KEY
```

### Scenario 2: Spike Test
```bash
locust -f locustfile.py \
  --headless \
  --users 500 \
  --spawn-rate 50 \
  --run-time 5m \
  --host=http://localhost \
  --admin-key=YOUR_KEY
```

### Scenario 3: Endurance Test
```bash
locust -f locustfile.py \
  --headless \
  --users 50 \
  --spawn-rate 5 \
  --run-time 1h \
  --host=http://localhost \
  --admin-key=YOUR_KEY
```

### Scenario 4: Streaming Load Test
```bash
locust -f test_scenarios.py:StreamingPowerUser \
  --headless \
  --users 25 \
  --spawn-rate 2 \
  --run-time 15m \
  --host=http://localhost \
  --admin-key=YOUR_KEY
```

## Troubleshooting

### Common Issues

1. **Connection Refused**
   - Ensure API is running: `docker-compose ps`
   - Check host URL matches your setup

2. **Authentication Errors**
   - Verify admin key is correct
   - Check API key has admin scope

3. **Rate Limiting**
   - Expected behavior under heavy load
   - Monitor X-RateLimit headers
   - Adjust rate limits if needed

4. **Memory Issues**
   - Monitor container resources: `docker stats`
   - Increase memory limits in docker-compose.yml
   - Check for memory leaks in long-running tests

### Debug Mode

Run with verbose logging:

```bash
locust -f locustfile.py \
  --loglevel DEBUG \
  --host=http://localhost \
  --admin-key=YOUR_KEY
```

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Load Tests
on:
  schedule:
    - cron: '0 2 * * *'  # Daily at 2 AM
  workflow_dispatch:

jobs:
  load-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Start services
        run: docker-compose up -d
        
      - name: Wait for API
        run: |
          timeout 60 bash -c 'until curl -f http://localhost/api/v5/health; do sleep 2; done'
      
      - name: Run load tests
        run: |
          pip install locust
          cd tests/load
          locust -f locustfile.py \
            --headless \
            --users 50 \
            --spawn-rate 5 \
            --run-time 5m \
            --host=http://localhost \
            --admin-key=${{ secrets.LOAD_TEST_ADMIN_KEY }} \
            --html report.html
      
      - name: Upload results
        uses: actions/upload-artifact@v3
        with:
          name: load-test-report
          path: tests/load/report.html
```

## Best Practices

1. **Warm-up Period**
   - Allow 30-60 seconds for system warm-up
   - Discard initial results if needed

2. **Realistic Scenarios**
   - Match production usage patterns
   - Include think time between requests
   - Vary request parameters

3. **Progressive Testing**
   - Start with small loads
   - Gradually increase users
   - Identify breaking points

4. **Environment Isolation**
   - Use dedicated test environment
   - Reset data between tests
   - Monitor all components

5. **Result Documentation**
   - Save test reports
   - Document configuration
   - Track performance over time

## Reporting

Generate HTML reports:

```bash
locust -f locustfile.py \
  --headless \
  --users 100 \
  --spawn-rate 10 \
  --run-time 10m \
  --host=http://localhost \
  --admin-key=YOUR_KEY \
  --html=report-$(date +%Y%m%d-%H%M%S).html
```

Export raw data:

```bash
locust -f locustfile.py \
  --headless \
  --users 100 \
  --spawn-rate 10 \
  --run-time 10m \
  --host=http://localhost \
  --admin-key=YOUR_KEY \
  --csv=results
```

This will create:
- `results_stats.csv` - Request statistics
- `results_stats_history.csv` - Statistics over time
- `results_failures.csv` - Failure details