# Docker Deployment Guide

This guide covers how to build, run, and deploy the Mirador API using Docker.

## Prerequisites

- Docker 20.10+
- Docker Compose 1.29+
- 4GB+ RAM available for Docker
- 10GB+ disk space

## Quick Start

### Development Environment

1. Copy environment variables:
```bash
cp .env.example .env
```

2. Build and start services:
```bash
docker-compose up --build
```

3. Access the API:
- API: http://localhost:5000
- Health check: http://localhost:5000/api/v5/health
- GraphQL Playground: http://localhost:5000/api/v5/graphql/playground

### Production Environment

1. Build the production image:
```bash
docker build -t mirador-api:latest .
```

2. Create production environment file:
```bash
cp .env.example .env.production
# Edit .env.production with production values
```

3. Deploy with production compose:
```bash
docker-compose -f docker-compose.prod.yml up -d
```

## Container Architecture

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│    Nginx    │────▶│ Mirador API │────▶│    Redis    │
│   (proxy)   │     │  (Python)   │     │   (cache)   │
└─────────────┘     └─────────────┘     └─────────────┘
                            │
                            ▼
                    ┌─────────────┐
                    │  PostgreSQL │
                    │    (DB)     │
                    └─────────────┘
```

## Configuration

### Environment Variables

Key environment variables for the API container:

```bash
# API Configuration
MIRADOR_ENV=production
API_KEY_PREFIX=mirador_sk_
API_BASE_URL=https://api.mirador.ai
CORS_ORIGINS=https://app.mirador.ai,https://mirador.ai

# Database
DATABASE_URL=postgresql://user:pass@postgres:5432/mirador

# Redis
REDIS_URL=redis://redis:6379/0

# Security
SECRET_KEY=your-secret-key-here
JWT_SECRET_KEY=your-jwt-secret-here

# Performance
WORKERS=4
WORKER_CLASS=gevent
WORKER_CONNECTIONS=1000
TIMEOUT=120
```

### Volume Mounts

The following directories are mounted as volumes:

- `/app/logs`: Application logs
- `/app/data`: Persistent data storage
- `/app/uploads`: User uploads

### Networking

Services communicate on the `mirador-network` bridge network:
- API: `mirador-api:5000`
- Redis: `redis:6379`
- PostgreSQL: `postgres:5432`

## Building Images

### Multi-stage Build

The Dockerfile uses a multi-stage build for optimization:

1. **Builder stage**: Installs dependencies
2. **Production stage**: Copies only necessary files

```bash
# Build with specific tag
docker build -t mirador-api:v1.0.0 .

# Build with build args
docker build --build-arg PYTHON_VERSION=3.11 -t mirador-api:latest .
```

### Image Size Optimization

- Base image: `python:3.11-slim`
- No development dependencies
- Compiled Python files excluded
- Multi-stage build reduces final size

## Deployment

### Docker Swarm

Deploy as a stack:

```bash
# Initialize swarm
docker swarm init

# Deploy stack
docker stack deploy -c docker-compose.prod.yml mirador
```

### Kubernetes

See `k8s/` directory for Kubernetes manifests:

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secrets.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

### Health Checks

All containers include health checks:

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:5000/api/v5/health"]
  interval: 30s
  timeout: 10s
  retries: 3
```

## Monitoring

### Logs

View container logs:
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f mirador-api

# Last 100 lines
docker-compose logs --tail=100 mirador-api
```

### Metrics

Access monitoring dashboards:
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000

### Resource Usage

Monitor container resources:
```bash
docker stats

# Or for specific container
docker stats mirador-api
```

## Maintenance

### Backup

Backup volumes:
```bash
# Database
docker exec mirador-postgres pg_dump -U mirador mirador > backup.sql

# Redis
docker exec mirador-redis redis-cli BGSAVE
```

### Updates

Rolling update process:
```bash
# Build new image
docker build -t mirador-api:new .

# Update service
docker service update --image mirador-api:new mirador_mirador-api
```

### Scaling

Scale services:
```bash
# Docker Compose
docker-compose up --scale mirador-api=3

# Docker Swarm
docker service scale mirador_mirador-api=3
```

## Security

### Best Practices

1. **Non-root user**: Containers run as non-root user `app`
2. **Read-only filesystem**: Consider adding `read_only: true`
3. **Security scanning**: Scan images for vulnerabilities
4. **Network isolation**: Services on internal network
5. **Secret management**: Use Docker secrets in production

### SSL/TLS

Nginx handles SSL termination:
- Certificates in `/etc/nginx/ssl/`
- Modern TLS configuration
- HSTS enabled

## Troubleshooting

### Common Issues

1. **Container won't start**
   ```bash
   docker-compose logs mirador-api
   docker exec -it mirador-api sh
   ```

2. **Database connection errors**
   ```bash
   docker exec -it mirador-postgres psql -U mirador
   ```

3. **Redis connection errors**
   ```bash
   docker exec -it mirador-redis redis-cli ping
   ```

4. **Permission errors**
   ```bash
   # Fix volume permissions
   docker exec -it mirador-api chown -R app:app /app
   ```

### Debug Mode

Run container with debug tools:
```bash
docker run -it --rm \
  --entrypoint /bin/bash \
  -e MIRADOR_ENV=development \
  mirador-api:latest
```

## Performance Tuning

### API Container

- Workers: 2-4 per CPU core
- Worker class: `gevent` for I/O bound
- Connection pool: Match database connections
- Memory limit: 512MB-2GB per worker

### Redis

- Max memory: Set based on cache needs
- Eviction policy: `allkeys-lru` for cache
- Persistence: AOF for durability

### PostgreSQL

- Shared buffers: 25% of available RAM
- Effective cache size: 50-75% of RAM
- Max connections: Workers × connections per worker

## Development Workflow

### Local Development

```bash
# Start services
docker-compose up

# Run tests
docker-compose exec mirador-api pytest

# Access shell
docker-compose exec mirador-api bash

# View logs
docker-compose logs -f
```

### Hot Reload

For development, mount source code:
```yaml
volumes:
  - ./src:/app/src
```

### Database Migrations

```bash
# Run migrations
docker-compose exec mirador-api alembic upgrade head

# Create migration
docker-compose exec mirador-api alembic revision --autogenerate -m "description"
```