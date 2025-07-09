# 🧪 Mirador Test Execution Guide

## 📋 Overview

This guide provides comprehensive instructions for executing the Mirador AI Framework test suite in a separate terminal window. The test suite validates all components including Python modules, shell scripts, Ollama models, chains, and performance metrics.

## 🚀 Quick Start

Open a new terminal window and run:

```bash
cd /Users/matthewscott/Projects/mirador
./tests/run_tests.sh
```

## 📁 Test Files Created

All test files are located in `/Users/matthewscott/Projects/mirador/tests/`:

1. **`run_tests.sh`** - Master test runner with interactive menu
2. **`mirador_test_suite.py`** - Comprehensive system tests
3. **`test_chains.py`** - Chain runner functionality tests
4. **`test_models.py`** - Ollama model availability tests
5. **`test_performance.py`** - Performance and resource usage tests
6. **`TEST_EXECUTION_GUIDE.md`** - This documentation file

## 🛠️ Prerequisites

Before running tests, ensure:

1. **Python 3.x** is installed
   ```bash
   python3 --version
   ```

2. **Ollama** is running
   ```bash
   ollama serve  # In a separate terminal
   ```

3. **Required Python packages**
   ```bash
   pip3 install psutil
   ```

## 📊 Test Categories

### 1. System Tests (`mirador_test_suite.py`)
- Python module imports
- Shell script syntax validation
- Configuration file validity
- Productivity tools functionality
- Memory system operations
- System resource checks

### 2. Chain Tests (`test_chains.py`)
- Company chain runners
- Robust chain runners
- Role-based chains
- Chain execution timing
- Error handling

### 3. Model Tests (`test_models.py`)
- Ollama connectivity
- Model availability
- Model response times
- Missing model detection

### 4. Performance Tests (`test_performance.py`)
- Execution speed benchmarks
- Memory usage profiling
- Concurrent execution tests
- Resource utilization
- Startup time measurements

## 🎯 Test Execution Options

### Option 1: Quick Tests (5 minutes)
```bash
./tests/run_tests.sh
# Select option 1
```
- Basic system validation
- Import checks
- Configuration validation

### Option 2: Standard Tests (15 minutes)
```bash
./tests/run_tests.sh
# Select option 2
```
- System tests
- Chain functionality tests
- Basic performance checks

### Option 3: Comprehensive Tests (30+ minutes)
```bash
./tests/run_tests.sh
# Select option 3
```
- All system tests
- All chain tests
- All model tests
- Full performance suite

### Option 4: Custom Selection
```bash
./tests/run_tests.sh
# Select option 4
# Then choose specific tests (e.g., 'abc' for first three)
```

## 🔍 Individual Test Execution

Run specific test categories directly:

```bash
# System tests only
python3 tests/mirador_test_suite.py

# Chain tests only
python3 tests/test_chains.py

# Model tests only
python3 tests/test_models.py

# Performance tests only
python3 tests/test_performance.py
```

## 📈 Test Options and Flags

### System Test Suite Options
```bash
python3 tests/mirador_test_suite.py --help
  --verbose, -v      # Verbose output
  --fail-fast, -f    # Stop on first failure
  --parallel, -p     # Run tests in parallel
  --timeout, -t      # Set timeout per test category (seconds)
```

Example:
```bash
python3 tests/mirador_test_suite.py --verbose --fail-fast --timeout 120
```

## 📄 Test Output and Logs

All test results are saved to `/Users/matthewscott/Projects/mirador/test_logs/`:

- **Test Reports**: `test_report_YYYYMMDD_HHMMSS.txt`
- **Chain Results**: `chain_test_results_YYYYMMDD_HHMMSS.json`
- **Model Results**: `model_test_results_YYYYMMDD_HHMMSS.json`
- **Performance Results**: `performance_test_YYYYMMDD_HHMMSS.json`
- **Test Logs**: `test_run_YYYYMMDD_HHMMSS.log`

## 🎨 Understanding Test Output

### Success Indicators
- ✅ Green checkmarks indicate passed tests
- 📊 Blue text shows informational messages
- ⚡ Performance metrics in seconds

### Failure Indicators
- ❌ Red X marks indicate failed tests
- ⚠️  Yellow warnings for non-critical issues
- ⏱️  Timeout indicators for slow operations

## 🔧 Troubleshooting

### Common Issues and Solutions

1. **"Ollama not running" error**
   ```bash
   # Start Ollama in a separate terminal
   ollama serve
   ```

2. **"Module not found" errors**
   ```bash
   # Ensure you're in the project root
   cd /Users/matthewscott/Projects/mirador
   ```

3. **"Permission denied" errors**
   ```bash
   # Make scripts executable
   chmod +x tests/*.sh tests/*.py
   ```

4. **Timeout errors**
   ```bash
   # Run with extended timeout
   python3 tests/mirador_test_suite.py --timeout 600
   ```

## 📊 Interpreting Results

### System Test Results
- **Import Tests**: Verify all Python modules load correctly
- **Config Tests**: Ensure JSON files are valid
- **Resource Tests**: Check CPU/memory availability

### Chain Test Results
- **Success Rate**: Percentage of chains executing without errors
- **Average Time**: Typical execution duration
- **Timeout Rate**: Chains taking too long

### Model Test Results
- **Installed Models**: Count of available Ollama models
- **Missing Models**: Required models not installed
- **Response Times**: Model inference speed

### Performance Results
- **CPU Usage**: Average and peak CPU utilization
- **Memory Usage**: RAM consumption patterns
- **Concurrent Performance**: Multi-chain execution efficiency

## 🚦 Next Steps After Testing

1. **Review Failed Tests**
   - Check test logs for detailed error messages
   - Address configuration issues
   - Install missing dependencies

2. **Optimize Performance**
   - Identify slow chains from performance tests
   - Review memory usage patterns
   - Consider model optimization

3. **Install Missing Models**
   ```bash
   # Install a missing model
   ollama pull model_name
   ```

4. **Fix Configuration Issues**
   - Validate JSON syntax
   - Update file paths
   - Check permissions

## 🔄 Continuous Testing

For ongoing development, run tests:
- Before major changes
- After installing new models
- When updating configurations
- Before production deployment

## 📞 Support

If tests reveal issues:
1. Check test logs in `/test_logs/`
2. Review error messages carefully
3. Ensure all prerequisites are met
4. Verify Ollama is running
5. Check system resources

---

*Generated by Claude Code for the Mirador AI Framework*