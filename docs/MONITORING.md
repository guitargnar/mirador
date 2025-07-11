# Monitoring and Metrics Guide

This guide covers the monitoring and metrics capabilities of the Mirador API.

## Overview

The Mirador API provides comprehensive monitoring through:
- Health check endpoints for service status
- Prometheus-compatible metrics
- Custom metric collection
- Component-specific monitors
- Real-time system resource tracking

## Health Checks

### Comprehensive Health Check

```bash
GET /api/v5/health
```

Returns overall system health with component status:

```json
{
  "status": "healthy",
  "timestamp": "2024-01-15T10:30:00Z",
  "version": "5.0.0",
  "uptime_seconds": 3600,
  "components": [
    {
      "name": "api",
      "status": "healthy",
      "response_time_ms": 0.5
    },
    {
      "name": "database",
      "status": "healthy",
      "response_time_ms": 2.3
    },
    {
      "name": "redis",
      "status": "healthy",
      "response_time_ms": 0.8,
      "details": {
        "version": "7.0.5",
        "connected_clients": 5,
        "used_memory_human": "10.5M"
      }
    },
    {
      "name": "models",
      "status": "healthy",
      "details": {
        "available_count": 15,
        "models": ["matthew_context_provider_v5", "universal_strategy_architect_v4"]
      }
    }
  ]
}
```

### Kubernetes Probes

#### Liveness Probe
```bash
GET /api/v5/health/live
```

Returns 200 if service is alive, 503 if dead.

#### Readiness Probe
```bash
GET /api/v5/health/ready
```

Returns 200 if ready to serve traffic, 503 if not ready.

## Prometheus Metrics

### Metrics Endpoint

```bash
GET /api/v5/metrics
```

Exposes metrics in Prometheus format:

```
# HELP mirador_api_requests_total Total number of API requests
# TYPE mirador_api_requests_total counter
mirador_api_requests_total{method="POST",endpoint="/api/v5/query",status="success"} 1234

# HELP mirador_api_request_duration_seconds Request duration in seconds
# TYPE mirador_api_request_duration_seconds histogram
mirador_api_request_duration_seconds_bucket{method="POST",endpoint="/api/v5/query",le="0.5"} 950
```

### Available Metrics

#### Request Metrics
- `mirador_api_requests_total`: Total API requests (labels: method, endpoint, status)
- `mirador_api_request_duration_seconds`: Request latency histogram
- `mirador_api_request_size_bytes`: Request size summary
- `mirador_api_response_size_bytes`: Response size summary

#### Model Metrics
- `mirador_model_requests_total`: Model invocation count (labels: model, chain_type)
- `mirador_model_latency_seconds`: Model inference latency
- `mirador_model_errors_total`: Model error count (labels: model, error_type)

#### Cache Metrics
- `mirador_cache_hits_total`: Cache hit count
- `mirador_cache_misses_total`: Cache miss count

#### System Metrics
- `mirador_cpu_usage_percent`: CPU usage percentage
- `mirador_memory_usage_bytes`: Memory usage in bytes
- `mirador_disk_usage_percent`: Disk usage percentage

#### Database Metrics
- `mirador_db_connections`: Database connection count (labels: state)
- `mirador_db_query_duration_seconds`: Query latency histogram

### Prometheus Configuration

Add to `prometheus.yml`:

```yaml
scrape_configs:
  - job_name: 'mirador_api'
    scrape_interval: 15s
    static_configs:
      - targets: ['localhost:5000']
    metrics_path: '/api/v5/metrics'
```

## Custom Metrics

### Recording Custom Metrics

```bash
POST /api/v5/metrics/custom
{
  "metric_name": "custom_event_count",
  "value": 42,
  "labels": {
    "event_type": "user_action",
    "category": "engagement"
  }
}
```

### Retrieving Custom Metrics

```bash
GET /api/v5/metrics/custom?metric_name=custom_event_count&start_time=2024-01-15T00:00:00Z
```

Response:
```json
{
  "custom_event_count": [
    {
      "value": 42,
      "labels": {"event_type": "user_action", "category": "engagement"},
      "timestamp": "2024-01-15T10:30:00Z"
    }
  ]
}
```

## Metrics Summary

Get a high-level summary of key metrics:

```bash
GET /api/v5/metrics/summary
```

Response:
```json
{
  "timestamp": "2024-01-15T10:30:00Z",
  "period": "24h",
  "requests": {
    "total": 10000,
    "avg_latency_ms": 125.5,
    "unique_users": 250,
    "total_sessions": 500,
    "error_rate": 0.5
  },
  "models": {
    "matthew_context_provider_v5": 3500,
    "universal_strategy_architect_v4": 2800,
    "creative_catalyst_v4": 2000
  },
  "system": {
    "cpu_percent": 45.2,
    "memory": {
      "used_gb": 6.5,
      "total_gb": 16.0,
      "percent": 40.6
    },
    "disk": {
      "used_gb": 120.5,
      "total_gb": 500.0,
      "percent": 24.1
    }
  }
}
```

## Component Monitors

The API includes specialized monitors for different components:

### System Monitor
- Tracks CPU, memory, and disk usage
- Configurable warning/critical thresholds
- Reports load average and resource trends

### Model Monitor
- Verifies Ollama model availability
- Checks required models are present
- Tracks model loading times

### Database Monitor
- Monitors connection pool usage
- Tracks slow queries
- Reports table sizes and growth

### Redis Monitor
- Monitors memory usage
- Tracks cache hit rates
- Alerts on key evictions

## Grafana Dashboard

Import the provided dashboard for visualization:

1. Open Grafana
2. Go to Dashboards → Import
3. Upload `grafana-dashboard.json`
4. Select Prometheus data source

Key dashboard panels:
- Request rate and latency
- Model usage distribution
- Error rates and alerts
- System resource usage
- Cache performance
- Database query performance

## Alerting Rules

Example Prometheus alerting rules:

```yaml
groups:
  - name: mirador_alerts
    rules:
      - alert: HighErrorRate
        expr: rate(mirador_api_requests_total{status="error"}[5m]) > 0.05
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High error rate detected"
          description: "Error rate is {{ $value }} errors per second"
      
      - alert: HighMemoryUsage
        expr: mirador_memory_usage_bytes / (1024*1024*1024) > 14
        for: 10m
        labels:
          severity: critical
        annotations:
          summary: "High memory usage"
          description: "Memory usage is {{ $value }}GB"
      
      - alert: ModelUnavailable
        expr: mirador_model_requests_total{status="error"} > 10
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "Model {{ $labels.model }} unavailable"
```

## Performance Optimization

### Metric Collection Best Practices

1. **Use labels wisely**: Too many label combinations create high cardinality
2. **Set appropriate retention**: Configure Prometheus retention based on needs
3. **Use recording rules**: Pre-compute expensive queries
4. **Sample appropriately**: Not all requests need to be tracked

### Recording Rules Example

```yaml
groups:
  - name: mirador_recording_rules
    interval: 30s
    rules:
      - record: instance:mirador_request_rate
        expr: rate(mirador_api_requests_total[5m])
      
      - record: instance:mirador_error_rate
        expr: rate(mirador_api_requests_total{status="error"}[5m])
```

## Debugging with Metrics

### Finding Slow Endpoints

```promql
# Top 5 slowest endpoints
topk(5, 
  histogram_quantile(0.95, 
    rate(mirador_api_request_duration_seconds_bucket[5m])
  )
) by (endpoint)
```

### Identifying Model Bottlenecks

```promql
# Models with highest latency
sort_desc(
  avg_over_time(
    mirador_model_latency_seconds[10m]
  ) by (model)
)
```

### Cache Performance Analysis

```promql
# Cache hit rate
sum(rate(mirador_cache_hits_total[5m])) / 
(sum(rate(mirador_cache_hits_total[5m])) + sum(rate(mirador_cache_misses_total[5m])))
```

## Integration with APM Tools

The monitoring system can integrate with:

- **New Relic**: Export metrics via Prometheus integration
- **Datadog**: Use OpenMetrics check
- **AWS CloudWatch**: Use CloudWatch agent with Prometheus support
- **Google Cloud Monitoring**: Use Prometheus sidecar

Example Datadog configuration:

```yaml
init_config:

instances:
  - prometheus_url: http://localhost:5000/api/v5/metrics
    namespace: mirador
    metrics:
      - mirador_api_requests_total
      - mirador_api_request_duration_seconds
      - mirador_model_latency_seconds
```

## Troubleshooting

### High Memory Usage

1. Check metric: `mirador_memory_usage_bytes`
2. Identify memory consumers:
   - Model cache size
   - Redis memory usage
   - Database connection pool
3. Adjust configurations in environment variables

### Slow Response Times

1. Check histogram: `mirador_api_request_duration_seconds`
2. Identify slow components:
   - Model latency
   - Database query time
   - Cache miss rate
3. Enable detailed timing logs

### Missing Metrics

1. Verify Prometheus is scraping: Check targets page
2. Check metric names: Use `/api/v5/metrics` directly
3. Verify metric registration in code
4. Check for errors in application logs