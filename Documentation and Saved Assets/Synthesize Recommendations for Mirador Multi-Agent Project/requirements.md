# Mirador System Requirements

## Hardware Requirements

### Minimum Specifications
- **Processor**: Apple Silicon M1 or newer (M1/M2/M3 series)
- **Memory**: 16GB unified memory
- **Storage**: 50GB free disk space
- **OS**: macOS Monterey 12.0 or newer

### Recommended Specifications
- **Processor**: Apple Silicon M3 Max
- **Memory**: 32GB+ unified memory  
- **Storage**: 100GB+ free disk space
- **OS**: macOS Sequoia 15.5

### Performance Considerations
- Each model requires ~2-4GB memory when loaded
- Chain execution may load 3-7 models simultaneously
- Disk I/O speed impacts output writing performance
- CPU performance affects inference speed

## Software Requirements

### Core Dependencies

#### Operating System
- macOS 12.0+ (Monterey or newer)
- Terminal.app or iTerm2
- Bash 5.0+ or Zsh

#### Python Environment
```bash
# Required
Python 3.9+ 

# Python packages
- subprocess (built-in)
- os (built-in)
- sys (built-in)
- datetime (built-in)
- json (built-in)
- re (built-in)
- shutil (built-in)
- time (built-in)
```

#### Ollama Installation
```bash
# Via Homebrew (recommended)
brew install ollama

# Or direct download from
https://ollama.ai/download
```

#### Git (for version control)
```bash
# Check if installed
git --version

# Install if needed
xcode-select --install
```

### Model Requirements

#### Base Models (via Ollama)
```bash
# Essential models
ollama pull llama3.2
ollama pull llama3.2:latest

# Optional enhanced models
ollama pull mistral
ollama pull codellama
```

#### Disk Space per Model
- Base models: ~4-5GB each
- Custom models: ~2GB each (using base model layers)
- Total for full system: ~30-40GB

## Installation Dependencies

### System Utilities
```bash
# Required commands
- chmod (for permissions)
- mkdir (for directory creation)
- cp/mv (for file operations)
- grep/awk/sed (for text processing)
- date (for timestamps)
- wc (for counting)
- find (for file searching)
```

### Development Tools
```bash
# For customization
- Text editor (vim/nano/VSCode)
- Python debugger (pdb)
- Performance monitor (top/htop)
```

## Network Requirements

### Offline Operation
- Mirador runs 100% locally
- No internet required for operation
- No API keys needed
- No external services

### Online Requirements (Setup Only)
- Initial Ollama installation
- Base model downloads
- Git repository cloning
- Documentation access

## File System Requirements

### Directory Structure
```
$HOME/
├── ai_framework_git/        # Main project (5GB)
│   ├── outputs/            # Analysis results (grows over time)
│   ├── *.modelfile         # Model configurations
│   └── *.py *.sh          # Scripts and engines
├── .ollama/               # Ollama models (30-40GB)
└── /usr/local/bin/        # Global commands
```

### Permissions
- Read/write access to home directory
- Execute permissions for scripts
- Write access to /usr/local/bin (for global command)

## Performance Benchmarks

### Expected Performance by Hardware

#### M1 MacBook Air (8GB)
- Model load time: 3-5 seconds
- Single query: 15-20 seconds
- 3-model chain: 90-120 seconds
- Limitations: Memory constraints with long chains

#### M2 MacBook Pro (16GB)
- Model load time: 2-3 seconds
- Single query: 8-12 seconds
- 3-model chain: 45-70 seconds
- Suitable for: Daily use, most chains

#### M3 Max MacBook Pro (32GB+)
- Model load time: 1-2 seconds
- Single query: 5-8 seconds
- 3-model chain: 30-50 seconds
- Optimal for: Heavy use, complex chains

## Compatibility Matrix

| Component | Version | Status | Notes |
|-----------|---------|--------|-------|
| macOS Monterey | 12.x | ✅ Supported | Minimum version |
| macOS Ventura | 13.x | ✅ Supported | Recommended |
| macOS Sonoma | 14.x | ✅ Supported | Tested |
| macOS Sequoia | 15.x | ✅ Supported | Optimal |
| Python | 3.9+ | ✅ Required | Built-in sufficient |
| Ollama | 0.1.32+ | ✅ Required | Latest recommended |
| Bash | 5.0+ | ✅ Required | macOS default |

## Resource Utilization

### Memory Usage Profile
```
Idle: ~100MB
Single model loaded: ~2-4GB
Active chain (3 models): ~8-12GB
Complex chain (5 models): ~15-20GB
```

### CPU Usage Profile
```
Idle: <1%
Model inference: 40-80% (single core)
Chain execution: 60-100% (multi-core)
```

### Disk I/O Profile
```
Output writing: ~1-5MB per analysis
Log files: ~10MB per week
Model storage: ~40GB static
```

## Optimization Recommendations

### For 16GB Systems
1. Limit chains to 3-4 models
2. Close other applications during use
3. Use decision_simplifier to reduce output size
4. Run garbage collection between chains

### For 32GB+ Systems  
1. Run multiple chains in parallel
2. Keep frequently used models loaded
3. Enable comprehensive logging
4. Use enhanced output modes

## Troubleshooting Requirements

### Diagnostic Tools
```bash
# System info
system_profiler SPSoftwareDataType
sysctl hw.memsize
df -h

# Process monitoring
top -l 1
ps aux | grep ollama

# Log analysis  
tail -f ~/ai_framework_git/logs/mirador.log
```

### Common Requirement Issues

**Insufficient Memory**
- Symptom: Models fail to load
- Solution: Upgrade RAM or reduce chain length

**Disk Space Low**
- Symptom: Output write failures
- Solution: Clear old outputs or expand storage

**Ollama Not Found**
- Symptom: Command not found errors
- Solution: Reinstall Ollama via Homebrew

---

*System not meeting requirements? Consider cloud alternatives or hardware upgrades for optimal performance.*