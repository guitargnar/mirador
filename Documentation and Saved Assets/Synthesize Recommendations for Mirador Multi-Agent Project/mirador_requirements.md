# Mirador AI Orchestration System - Requirements & Dependencies 🎸⚙️

**Complete dependency specification for Mirador deployment and operation**

---

## 🖥️ System Requirements

### Hardware Requirements

#### **Minimum Configuration**
- **CPU:** Apple M3 or Intel i7 8th gen (8 cores)
- **RAM:** 16GB unified memory
- **Storage:** 50GB available space
- **Network:** Stable internet for initial setup only

#### **Recommended Configuration** 
- **CPU:** Apple M3 Max or Intel i9 12th gen (16+ cores)
- **RAM:** 32GB unified memory
- **Storage:** 100GB+ SSD with fast I/O
- **Network:** High-speed for model downloads

#### **Optimal Configuration (Power User)**
- **CPU:** Apple M3 Ultra or Intel i9 13th gen (24+ cores)
- **RAM:** 64GB unified memory
- **Storage:** 500GB+ NVMe SSD
- **Network:** Gigabit ethernet for rapid updates

### Operating System Support

#### **Primary Platform (Tested & Optimized)**
```bash
# macOS Sequoia 15.5+
sw_vers
# ProductName:		macOS
# ProductVersion:	15.5
# BuildVersion:		24F5027e
```

#### **Secondary Platforms (Compatible)**
```bash
# Ubuntu 22.04 LTS+
lsb_release -a
# Distributor ID: Ubuntu
# Description:    Ubuntu 22.04.3 LTS
# Release:        22.04
# Codename:       jammy

# Arch Linux (rolling release)
uname -r
# 6.5.0-arch1-1

# Fedora 38+
cat /etc/fedora-release
# Fedora release 38 (Thirty Eight)
```

---

## 🔧 Core Dependencies

### **Ollama AI Runtime**
```bash
# Version: 0.5.0+
# Installation methods:

# macOS/Linux - Automated installer
curl -fsSL https://ollama.ai/install.sh | sh

# macOS - Homebrew
brew install ollama

# Linux - Manual installation
# Download from: https://github.com/ollama/ollama/releases
```

### **Python Environment**
```python
# Python 3.9.0+
python3 --version
# Python 3.11.6

# Required for workflow automation and system integration
```

### **Shell Environment**
```bash
# Bash 5.0+ (macOS default: zsh, Linux: bash)
bash --version
# GNU bash, version 5.2.15(1)-release

# Zsh 5.8+ (macOS default)
zsh --version  
# zsh 5.9 (x86_64-apple-darwin23.0)
```

### **Git Version Control**
```bash
# Git 2.30.0+
git --version
# git version 2.42.0
```

---

## 🐍 Python Dependencies

### **Core Python Requirements**
```python
# requirements.txt for Python components

# Standard library modules (included with Python 3.9+)
# - json (JSON processing)
# - os (Operating system interface)
# - subprocess (Process management)
# - datetime (Date and time handling)
# - pathlib (Path manipulation)
# - logging (Logging facility)
# - argparse (Command-line parsing)

# External packages (if needed for extensions)
requests==2.31.0          # HTTP library for API calls
beautifulsoup4==4.12.2    # Web scraping (if adding web integration)
python-dotenv==1.0.0      # Environment variable management
psutil==5.9.5             # System monitoring
click==8.1.7              # CLI framework (for future enhancements)
rich==13.6.0              # Terminal formatting (for enhanced output)
```

### **Optional Analytics Dependencies**
```python
# For advanced system analytics and monitoring
pandas==2.1.1             # Data analysis
matplotlib==3.7.2         # Plotting and visualization
seaborn==0.12.2           # Statistical visualization
numpy==1.24.3             # Numerical computing
```

### **Development Dependencies**
```python
# For system development and testing
pytest==7.4.2            # Testing framework
black==23.9.1             # Code formatting
flake8==6.1.0             # Linting
mypy==1.5.1               # Type checking
```

---

## 🛠️ System Tools & Utilities

### **Essential Command Line Tools**

#### **Text Processing**
```bash
# Pre-installed on most systems
grep    # Pattern searching
sed     # Stream editor
awk     # Text processing
cut     # Column extraction
sort    # Sorting
uniq    # Duplicate removal
```

#### **File Operations**
```bash
# Standard Unix tools
find    # File searching
tar     # Archive creation
gzip    # Compression
rsync   # File synchronization
chmod   # Permission management
```

#### **Process Management**
```bash
# System monitoring
ps      # Process status
top     # Real-time process viewer
htop    # Enhanced process viewer (optional)
kill    # Process termination
pgrep   # Process grep
```

### **macOS-Specific Tools**
```bash
# Included with macOS
open    # File/URL opening
say     # Text-to-speech
pbcopy  # Clipboard copy
pbpaste # Clipboard paste
purge   # Memory purge
```

### **Linux-Specific Tools**
```bash
# Usually pre-installed
xclip   # Clipboard management
notify-send  # Desktop notifications
systemctl    # Service management
journalctl   # Log viewing
```

---

## 📦 Installation Script

### **Automated Setup**
```bash
#!/bin/bash
# install_mirador_dependencies.sh

set -e  # Exit on any error

echo "=== Mirador AI Orchestration System - Dependency Installation ==="

# Check operating system
OS="$(uname -s)"
case "${OS}" in
    Darwin*)    PLATFORM=macOS;;
    Linux*)     PLATFORM=Linux;;
    *)          echo "Unsupported OS: ${OS}"; exit 1;;
esac

echo "Detected platform: $PLATFORM"

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check and install Ollama
if ! command_exists ollama; then
    echo "Installing Ollama..."
    curl -fsSL https://ollama.ai/install.sh | sh
else
    echo "✓ Ollama already installed: $(ollama --version)"
fi

# Check Python
if ! command_exists python3; then
    echo "❌ Python 3.9+ required but not found"
    echo "Please install Python 3.9+ and rerun this script"
    exit 1
else
    PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
    echo "✓ Python detected: $PYTHON_VERSION"
fi

# Check Git
if ! command_exists git; then
    echo "❌ Git required but not found"
    if [ "$PLATFORM" = "macOS" ]; then
        echo "Install Xcode Command Line Tools: xcode-select --install"
    else
        echo "Install git: sudo apt install git (Ubuntu) or sudo dnf install git (Fedora)"
    fi
    exit 1
else
    echo "✓ Git detected: $(git --version)"
fi

# Install Python packages if requirements.txt exists
if [ -f "requirements.txt" ]; then
    echo "Installing Python dependencies..."
    python3 -m pip install --user -r requirements.txt
fi

# Platform-specific installations
if [ "$PLATFORM" = "macOS" ]; then
    # Check for Homebrew (optional)
    if command_exists brew; then
        echo "✓ Homebrew detected"
        # Install optional tools
        brew list htop >/dev/null 2>&1 || brew install htop
    fi
elif [ "$PLATFORM" = "Linux" ]; then
    # Install common tools if missing
    if command_exists apt; then
        sudo apt update
        sudo apt install -y curl wget htop
    elif command_exists dnf; then
        sudo dnf install -y curl wget htop
    fi
fi

# Verify installation
echo ""
echo "=== Verification ==="

if command_exists ollama; then
    echo "✓ Ollama: $(ollama --version)"
else
    echo "❌ Ollama installation failed"
fi

echo "✓ Python: $(python3 --version)"
echo "✓ Git: $(git --version)"
echo "✓ Shell: $SHELL"

# Check available disk space
if [ "$PLATFORM" = "macOS" ]; then
    AVAILABLE_SPACE=$(df -h . | tail -1 | awk '{print $4}')
else
    AVAILABLE_SPACE=$(df -h . | tail -1 | awk '{print $4}')
fi
echo "✓ Available disk space: $AVAILABLE_SPACE"

echo ""
echo "=== Dependency Installation Complete ==="
echo "Next steps:"
echo "1. Clone Mirador repository"
echo "2. Run ./install_all_specialists.sh"
echo "3. Execute ./system_health_check.sh"
echo ""
```

---

## 🔌 Optional Integrations

### **Enhanced Terminal Experience**
```bash
# Oh My Zsh (macOS/Linux)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Starship prompt
curl -sS https://starship.rs/install.sh | sh

# Terminal multiplexer
brew install tmux         # macOS
sudo apt install tmux     # Ubuntu
```

### **Development Tools**
```bash
# Visual Studio Code with extensions
code --install-extension ms-python.python
code --install-extension ms-vscode.vscode-json
code --install-extension yzhang.markdown-all-in-one

# Vim/Neovim for terminal editing
brew install neovim       # macOS
sudo apt install neovim   # Ubuntu
```

### **System Monitoring**
```bash
# Activity monitoring tools
brew install btop         # macOS - Enhanced system monitor  
sudo apt install btop     # Ubuntu

# Disk usage analysis
brew install ncdu         # macOS
sudo apt install ncdu     # Ubuntu

# Network monitoring
brew install bandwhich    # macOS
sudo apt install bandwhich # Ubuntu
```

---

## 🚀 Performance Optimization Dependencies

### **Memory Optimization**
```bash
# macOS - Memory pressure management
sudo purge                # Force memory cleanup

# Linux - Memory management tools
sudo apt install preload  # Ubuntu - Adaptive readahead daemon
sudo systemctl enable preload
```

### **Storage Optimization**
```bash
# macOS - Storage optimization
sudo tmutil thinlocalsnapshots / 99999999999 2>/dev/null

# Linux - Filesystem optimization
sudo apt install bleachbit  # Ubuntu - System cleaner
```

### **CPU Optimization**
```bash
# macOS - CPU performance
sudo pmset -a standby 0
sudo pmset -a hibernatemode 0

# Linux - CPU frequency scaling
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

---

## 🛡️ Security Dependencies

### **Encryption Tools**
```bash
# GPG for data encryption
brew install gnupg        # macOS
sudo apt install gnupg    # Ubuntu

# SSH for secure communications
# (Usually pre-installed)
ssh-keygen -t ed25519 -C "mirador@localhost"
```

### **Firewall Configuration**
```bash
# macOS - Application firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Ubuntu - UFW firewall
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

---

## 🧪 Testing Dependencies

### **Model Testing**
```bash
# Test model availability
ollama list

# Test basic functionality
ollama run llama3.2 "Hello, world!"

# Benchmark performance
time ollama run llama3.2 "Write a short poem about AI"
```

### **System Testing**
```python
# test_system.py
import subprocess
import sys
import os

def test_dependencies():
    """Test all required dependencies"""
    tests = [
        ("ollama", ["ollama", "--version"]),
        ("python3", ["python3", "--version"]),
        ("git", ["git", "--version"]),
        ("mirador-ez", ["./mirador-ez", "models"]),
    ]
    
    results = []
    for name, cmd in tests:
        try:
            result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
            if result.returncode == 0:
                results.append(f"✓ {name}: OK")
            else:
                results.append(f"❌ {name}: FAILED - {result.stderr}")
        except Exception as e:
            results.append(f"❌ {name}: ERROR - {str(e)}")
    
    return results

if __name__ == "__main__":
    print("=== Mirador Dependency Test ===")
    for result in test_dependencies():
        print(result)
```

---

## 📋 Dependency Checklist

### **Pre-Installation Checklist**
- [ ] **Hardware Requirements Met**
  - [ ] 16GB+ RAM available
  - [ ] 50GB+ storage space
  - [ ] Compatible CPU architecture
  
- [ ] **Operating System Ready**
  - [ ] macOS 15.5+ or Linux equivalent
  - [ ] Admin/sudo access available
  - [ ] Terminal access configured

### **Core Dependencies Checklist**
- [ ] **Ollama Runtime**
  - [ ] Ollama 0.5.0+ installed
  - [ ] Models can be downloaded
  - [ ] Basic functionality tested
  
- [ ] **Development Environment**
  - [ ] Python 3.9+ installed
  - [ ] Git 2.30+ installed
  - [ ] Bash/Zsh shell available

### **System Integration Checklist**
- [ ] **File System Access**
  - [ ] Read/write permissions in home directory
  - [ ] Ability to create ~/projects/mirador/
  - [ ] Access to ~/ai_framework_git/outputs/
  
- [ ] **Process Management**
  - [ ] Can execute shell scripts
  - [ ] Background process execution
  - [ ] Resource monitoring available

### **Optional Enhancements Checklist**
- [ ] **Enhanced Tooling**
  - [ ] Advanced terminal (Oh My Zsh, Starship)
  - [ ] System monitoring tools
  - [ ] Development environment setup
  
- [ ] **Security Configuration**
  - [ ] GPG encryption setup
  - [ ] Firewall configuration
  - [ ] SSH key generation

---

## 🔄 Maintenance & Updates

### **Regular Update Schedule**
```bash
# Weekly updates (automated via cron)
0 2 * * 1 ~/projects/mirador/scripts/weekly_update.sh

# Monthly dependency updates
0 3 1 * * ~/projects/mirador/scripts/monthly_maintenance.sh
```

### **Update Scripts**
```bash
#!/bin/bash
# weekly_update.sh

echo "=== Weekly Mirador Maintenance ==="

# Update Ollama
ollama update

# Update Python packages
python3 -m pip install --user --upgrade pip
if [ -f "requirements.txt" ]; then
    python3 -m pip install --user --upgrade -r requirements.txt
fi

# Clean old outputs
find ~/ai_framework_git/outputs/ -type d -name "chain_*" -mtime +30 -exec rm -rf {} \;

# System health check
./system_health_check.sh

echo "=== Maintenance Complete ==="
```

---

**This requirements specification ensures optimal Mirador performance across all supported platforms while maintaining the privacy-first, local-execution architecture that makes the system uniquely powerful for personal AI orchestration.** 🎸🚀