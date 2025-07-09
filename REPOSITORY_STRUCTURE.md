# Mirador Repository Structure

## Root Directory (Essential Files Only)
```
├── README.md                    # Main project documentation
├── LICENSE                      # MIT License
├── requirements.txt             # Python dependencies
├── setup_mirador.sh            # Installation script
├── .gitignore                  # Security-enhanced ignore rules
├── mirador_universal_runner_v2.sh  # Main chain execution script
├── mirador-smart-v2            # Smart routing script
└── mirador.py                  # Core Python interface
```

## Directory Structure
```
├── models/                     # AI Model Definitions
│   ├── core/                  # Core context and base models
│   ├── domain/                # Domain-specific models
│   ├── personal/              # Personal context models
│   └── experimental/          # Test and development models
│
├── src/                       # Python Source Code
│   ├── core/                  # Core framework modules
│   ├── dashboard/             # Web and terminal dashboards
│   ├── utils/                 # Utility modules
│   └── misc/                  # Additional scripts
│
├── scripts/                   # Shell Scripts
│   ├── chains/                # Chain execution scripts
│   ├── analysis/              # Analysis and reporting
│   ├── utilities/             # Testing and maintenance
│   └── misc/                  # Other utility scripts
│
├── docs/                      # Documentation
│   ├── technical/             # Technical documentation
│   ├── guides/                # User guides
│   └── personal/              # Personal story and context
│
├── data/                      # Configuration Files
│   └── *.json                 # JSON configs and templates
│
├── outputs/                   # Chain Execution Results
│   └── universal_*_[timestamp]/
│
├── chain_results_archive/     # Historical Results
│   └── [YYYY]/[MM]/
│
├── tests/                     # Test Suite
│   └── test_*.py
│
├── ai_memory/                 # SQLite Memory System
│   └── mirador_memory.db
│
└── archive/                   # Archived Files
    ├── old_outputs/
    └── conversation_logs/
```

## Key Files

### Execution Scripts
- `mirador_universal_runner_v2.sh` - Main chain execution with 6 universal types
- `mirador-smart-v2` - Intelligent routing based on query analysis
- `setup_mirador.sh` - One-command setup script

### Core Modules
- `mirador.py` - Python interface for programmatic access
- `src/dashboard/mirador_unified_dashboard.py` - Terminal UI
- `src/dashboard/mirador_web_dashboard.py` - Streamlit web interface

### Configuration
- `requirements.txt` - Python dependencies
- `.gitignore` - Comprehensive security rules
- `data/*.json` - Chain templates and configurations

## Usage

1. **Setup**: `./setup_mirador.sh`
2. **Run Chain**: `./mirador_universal_runner_v2.sh <chain_type> "Your prompt"`
3. **Dashboard**: `python mirador_unified_dashboard.py`

## Privacy & Security

- All processing happens locally via Ollama
- No data leaves your machine
- Comprehensive .gitignore prevents sensitive data exposure
- Financial and company data has been removed