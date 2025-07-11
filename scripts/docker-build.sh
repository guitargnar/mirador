#!/bin/bash

# Docker Build Script for Mirador API
# Usage: ./scripts/docker-build.sh [dev|prod] [version]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
ENV=${1:-dev}
VERSION=${2:-latest}
REGISTRY=""

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker is not running. Please start Docker and try again."
    exit 1
fi

# Build based on environment
if [ "$ENV" = "dev" ]; then
    print_status "Building development environment..."
    
    # Build with docker-compose
    docker-compose build
    
    print_status "Development build complete!"
    print_status "Run 'docker-compose up' to start the services"
    
elif [ "$ENV" = "prod" ]; then
    print_status "Building production image..."
    
    # Build production image
    docker build -t mirador-api:${VERSION} -t mirador-api:latest .
    
    # Tag for registry if specified
    if [ -n "$REGISTRY" ]; then
        docker tag mirador-api:${VERSION} ${REGISTRY}/mirador-api:${VERSION}
        docker tag mirador-api:latest ${REGISTRY}/mirador-api:latest
        print_status "Tagged images for registry: ${REGISTRY}"
    fi
    
    # Show image info
    print_status "Production build complete!"
    docker images | grep mirador-api
    
    # Optionally push to registry
    if [ -n "$REGISTRY" ]; then
        read -p "Push to registry? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            docker push ${REGISTRY}/mirador-api:${VERSION}
            docker push ${REGISTRY}/mirador-api:latest
            print_status "Pushed to registry successfully!"
        fi
    fi
    
else
    print_error "Unknown environment: $ENV"
    print_status "Usage: $0 [dev|prod] [version]"
    exit 1
fi

# Run security scan
print_status "Running security scan..."
if command -v trivy &> /dev/null; then
    trivy image --severity HIGH,CRITICAL mirador-api:latest
else
    print_warning "Trivy not installed. Skipping security scan."
    print_warning "Install with: brew install aquasecurity/trivy/trivy"
fi

# Show resource usage
print_status "Image size information:"
docker images mirador-api:latest --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"