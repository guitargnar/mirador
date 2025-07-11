#!/usr/bin/env python3
"""Initial benchmark test for Claude Code Interpreter"""

import time

# Run the performance test
start = time.time()
result = sum(i**2 for i in range(1000000))
end = time.time()

execution_time = end - start

print(f"Time: {execution_time:.3f}s, Result: {result}")

# Additional performance metrics
print(f"\nDetailed Performance Metrics:")
print(f"- Total execution time: {execution_time:.6f} seconds")
print(f"- Operations per second: {1000000/execution_time:,.0f}")
print(f"- Result verification: {result}")
print(f"- Result is correct: {result == 333332833333500000}")

# Save results for analysis
import json
import os
from datetime import datetime

results = {
    "test_name": "sum_of_squares_1M",
    "execution_time": execution_time,
    "result": result,
    "operations": 1000000,
    "ops_per_second": 1000000/execution_time,
    "timestamp": datetime.now().isoformat(),
    "platform": "local_python"
}

# Create results directory if needed
os.makedirs("test_results", exist_ok=True)

# Save results
with open("test_results/benchmark_result.json", "w") as f:
    json.dump(results, f, indent=2)

print(f"\nResults saved to test_results/benchmark_result.json")