# Mirador Framework Requirements

## System Requirements

### Hardware Requirements

#### Minimum Requirements
- **CPU**: Intel i5 or Apple M1 (4 cores minimum)
- **RAM**: 16GB (8GB available for models)
- **Storage**: 50GB free space
- **Network**: Internet connection for initial setup

#### Recommended Requirements
- **CPU**: Intel i7/i9 or Apple M1 Pro/Max (8+ cores)
- **RAM**: 32GB (16GB+ available for models)
- **Storage**: 100GB+ SSD free space
- **Network**: High-speed internet for model downloads

#### Optimal Requirements
- **CPU**: Apple M2/M3 or Intel i9 (12+ cores)
- **RAM**: 64GB (32GB+ available for models)
- **Storage**: 200GB+ NVMe SSD
- **Network**: Gigabit internet connection

### Software Requirements

#### Operating System
- **Primary**: macOS 12.0+ (Monterey or later)
- **Alternative**: Linux (Ubuntu 20.04+ or equivalent)
- **Not Supported**: Windows (Ollama compatibility issues)

#### Core Dependencies
- **Ollama**: 0.7.1 or later
- **Python**: 3.11.0 or later
- **Git**: 2.30.0 or later
- **Homebrew**: Latest version (macOS)

#### Python Dependencies
```
beautifulsoup4>=4.12.0
fastapi>=0.100.0
flask>=2.3.0
fpdf2>=2.7.0
markdown>=3.4.0
matplotlib>=3.7.0
numpy>=1.24.0
openpyxl>=3.1.0
pandas>=2.0.0
pdf2image>=1.16.0
pillow>=10.0.0
plotly>=5.15.0
reportlab>=4.0.0
requests>=2.31.0
seaborn>=0.12.0
tabulate>=0.9.0
uvicorn>=0.23.0
weasyprint>=59.0
xhtml2pdf>=0.2.11
```

#### Node.js Dependencies (Optional)
- **Node.js**: 20.18.0 or later
- **npm**: Latest version
- **pnpm**: Latest version
- **yarn**: Latest version

## Installation Requirements

### Pre-Installation Checklist

#### System Preparation
- [ ] Verify macOS version (12.0+)
- [ ] Install Xcode Command Line Tools
- [ ] Install Homebrew package manager
- [ ] Ensure sufficient disk space (50GB+)
- [ ] Verify internet connectivity

#### Account Requirements
- [ ] Administrator access on local machine
- [ ] Git account for version control
- [ ] Sufficient privileges for software installation

### Installation Dependencies

#### Homebrew Packages
```bash
brew install ollama
brew install python@3.11
brew install git
brew install curl
brew install wget
```

#### Python Virtual Environment
```bash
python3.11 -m venv google-env
source google-env/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

#### Ollama Models
```bash
ollama pull llama3.2_balanced
ollama pull llama3.2:latest
```

## Performance Requirements

### Model Performance Specifications

#### Core Models (Required)
- **llama3.2_balanced**: 2GB, optimized for speed and reliability
- **decision_simplifier**: 2GB, synthesis and decision-making
- **enhanced_agent_enforcer**: 2GB, strategic analysis
- **mirador_system_specialist**: 2GB, system optimization

#### Specialist Models (Recommended)
- **financial_planning_expert_v6**: 2GB, financial analysis
- **matthews_linkedin_voice**: 2GB, content creation
- **opportunity_validator_v2**: 2GB, opportunity assessment
- **matthew_context_provider**: 2GB, personal context

#### Performance Targets
- **Single Query Response**: 10-30 seconds
- **Chain Execution**: 45-120 seconds
- **Model Loading**: 2-5 seconds
- **System Startup**: 30-60 seconds

### Resource Utilization

#### Memory Usage
- **Base System**: 4-6GB RAM
- **Active Models**: 2-4GB per model
- **Chain Execution**: 8-12GB peak usage
- **Background Processes**: 1-2GB

#### Storage Usage
- **Base Installation**: 10GB
- **Model Storage**: 2GB per model (50+ models = 100GB)
- **Output Storage**: 1-5GB (grows over time)
- **Backup Storage**: 20-50GB recommended

#### CPU Usage
- **Idle State**: 1-5% CPU usage
- **Model Loading**: 20-40% CPU usage
- **Chain Execution**: 60-90% CPU usage
- **Background Tasks**: 5-15% CPU usage

## Network Requirements

### Initial Setup
- **Model Downloads**: 100GB+ total download
- **System Updates**: 1-5GB periodic updates
- **Documentation**: 100MB+ reference materials

### Ongoing Usage
- **Model Updates**: 2-10GB monthly
- **System Maintenance**: 100MB-1GB monthly
- **Backup Sync**: Variable (if using cloud backup)

### Bandwidth Recommendations
- **Minimum**: 10 Mbps download
- **Recommended**: 50 Mbps download
- **Optimal**: 100+ Mbps download

## Security Requirements

### System Security
- **Firewall**: Enabled with appropriate rules
- **Antivirus**: Compatible with AI model execution
- **Encryption**: FileVault or equivalent disk encryption
- **Access Control**: User account with appropriate permissions

### Data Protection
- **Local Storage**: Encrypted storage recommended
- **Backup Security**: Encrypted backup solutions
- **Network Security**: Secure network connections
- **Privacy**: No external data transmission

### Model Security
- **Model Integrity**: Checksum verification
- **Version Control**: Git-based model management
- **Access Control**: Restricted model modification
- **Audit Trail**: Change tracking and logging

## Compatibility Requirements

### Tested Configurations

#### macOS Compatibility
- **macOS 14 Sonoma**: Fully tested and supported
- **macOS 13 Ventura**: Tested and supported
- **macOS 12 Monterey**: Minimum supported version
- **macOS 11 Big Sur**: Limited testing, may work

#### Hardware Compatibility
- **Apple Silicon (M1/M2/M3)**: Optimal performance
- **Intel Mac (2019+)**: Good performance
- **Intel Mac (2017-2018)**: Acceptable performance
- **Intel Mac (pre-2017)**: Not recommended

#### Python Version Compatibility
- **Python 3.13**: Tested and supported
- **Python 3.12**: Tested and supported
- **Python 3.11**: Minimum required version
- **Python 3.10**: Not supported

### Known Incompatibilities

#### Software Conflicts
- **Docker Desktop**: May conflict with Ollama
- **VMware/VirtualBox**: Resource competition
- **Heavy IDEs**: May impact performance during execution
- **Resource-intensive applications**: Background processing conflicts

#### Hardware Limitations
- **Intel Macs with 8GB RAM**: Performance limitations
- **External GPU**: Not supported by Ollama
- **Network storage**: Performance impact on model loading
- **Slow storage (HDD)**: Significant performance impact

## Development Requirements

### Development Environment
- **IDE**: VS Code, PyCharm, or equivalent
- **Terminal**: iTerm2 or Terminal.app
- **Git Client**: Command line or GUI client
- **Text Editor**: For configuration file editing

### Testing Requirements
- **Test Framework**: Built-in validation scripts
- **Performance Testing**: Automated benchmark tools
- **Quality Assurance**: Output validation systems
- **Monitoring**: Performance and health monitoring

### Deployment Requirements
- **Version Control**: Git repository management
- **Backup System**: Automated backup procedures
- **Documentation**: Comprehensive documentation maintenance
- **Monitoring**: System health and performance monitoring

## Maintenance Requirements

### Regular Maintenance
- **Daily**: System health checks
- **Weekly**: Performance optimization
- **Monthly**: Comprehensive system review
- **Quarterly**: Major updates and improvements

### Update Requirements
- **Ollama Updates**: Monthly or as needed
- **Model Updates**: As new versions become available
- **System Updates**: macOS and dependency updates
- **Security Updates**: Immediate application of security patches

### Backup Requirements
- **Model Backup**: Weekly full backup
- **Configuration Backup**: Daily incremental backup
- **Output Backup**: Continuous or daily backup
- **System Backup**: Weekly full system backup

## Support Requirements

### Documentation Access
- **Technical Documentation**: Comprehensive system documentation
- **User Guides**: Step-by-step usage instructions
- **Troubleshooting Guides**: Common issue resolution
- **API Documentation**: Model and system API references

### Monitoring and Logging
- **System Logs**: Comprehensive logging system
- **Performance Metrics**: Real-time performance monitoring
- **Error Tracking**: Automated error detection and reporting
- **Usage Analytics**: System usage and optimization insights

### Community and Support
- **Documentation**: Comprehensive self-service documentation
- **Best Practices**: Proven usage patterns and optimization techniques
- **Troubleshooting**: Common issue resolution procedures
- **Updates**: Regular system and model updates

