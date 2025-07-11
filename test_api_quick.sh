#!/bin/bash
echo "Testing Mirador API..."

# Check if API is running
if curl -f -s http://localhost:8000/api/v5/health > /dev/null 2>&1; then
    echo "✓ API is healthy"
    # Try to get health details
    echo "Health response:"
    curl -s http://localhost:8000/api/v5/health | python3 -m json.tool || echo "Could not parse JSON"
else
    echo "✗ API is not running at http://localhost:8000"
    echo "Checking alternative ports..."
    curl -f -s http://localhost:8080/api/v5/health > /dev/null 2>&1 && echo "Found API on port 8080"
    curl -f -s http://localhost:3000/api/v5/health > /dev/null 2>&1 && echo "Found API on port 3000"
fi

# Check for .env file
if [ -f .env ]; then
    echo "✓ .env file exists"
else
    echo "✗ .env file not found"
fi