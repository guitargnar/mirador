# Setup Guide

## System Requirements

### Minimum Requirements
- **Operating System**: Windows 10+, macOS 10.14+, Linux (any modern distribution)
- **Python**: 3.7 or higher
- **Terminal**: Any terminal that supports UTF-8 and 256 colors
- **Storage**: 10 MB free space
- **Internet**: Required for opening web resources

### Recommended Requirements
- **Python**: 3.9 or higher
- **Terminal**: 
  - macOS: iTerm2 or Terminal.app
  - Windows: Windows Terminal
  - Linux: GNOME Terminal, Konsole, or similar
- **Browser**: Chrome, Firefox, Safari, or Edge (for resource links)

## Installation Steps

### 1. Install Python

#### macOS
```bash
# Using Homebrew (recommended)
brew install python3

# Or download from python.org
# https://www.python.org/downloads/
```

#### Windows
1. Download Python from [python.org](https://www.python.org/downloads/)
2. Run installer
3. **Important**: Check "Add Python to PATH"

#### Linux
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3 python3-pip

# Fedora
sudo dnf install python3 python3-pip

# Arch
sudo pacman -S python python-pip
```

### 2. Clone the Repository

```bash
# Using git
git clone https://github.com/guitargnar/jcps-boots.git
cd jcps-boots

# Or download ZIP from GitHub
# https://github.com/guitargnar/jcps-boots/archive/refs/heads/main.zip
```

### 3. Set Up Virtual Environment (Recommended)

```bash
# Create virtual environment
python3 -m venv venv

# Activate virtual environment
# macOS/Linux:
source venv/bin/activate

# Windows:
venv\Scripts\activate

# You should see (venv) in your prompt
```

### 4. Install Dependencies

```bash
# Install required packages
pip install -r requirements.txt

# Verify installation
pip list
# Should show: rich, click, requests, python-dateutil
```

### 5. Make Scripts Executable

```bash
# macOS/Linux
chmod +x school_transfer_tracker.py
chmod +x school_transfer_visual.py
chmod +x test_school_tracker.py

# Windows - no action needed
```

## First Run

### Visual UI (Recommended)
```bash
./school_transfer_visual.py

# Windows:
python school_transfer_visual.py
```

You should see:
1. Welcome animation
2. Colorful dashboard with school listings
3. Phone numbers for each school
4. Action items on the right

### Standard CLI
```bash
./school_transfer_tracker.py

# Windows:
python school_transfer_tracker.py
```

## Configuration

### Initial Data Setup

On first run, the tracker automatically creates:
- 3 target schools (Greathouse/Shryock, Norton Commons, Goshen)
- 4 action items (portal check, Facebook group, etc.)
- JCPS School Choice contact

### Customizing Schools

To add your own schools:
1. Run the tracker
2. Choose option 4 (Add/Update Schools) or S (Schools) in visual mode
3. Enter school information

### Data Backup

Your data is stored in `transfer_data.json`. To backup:

```bash
# Create backup
cp transfer_data.json transfer_data_backup_$(date +%Y%m%d).json

# Restore from backup
cp transfer_data_backup_20250708.json transfer_data.json
```

## Troubleshooting

### Common Issues

#### "python3: command not found"
- Python not installed or not in PATH
- Solution: Install Python or use full path

#### "ModuleNotFoundError: No module named 'rich'"
- Dependencies not installed
- Solution: Run `pip install -r requirements.txt`

#### Characters appear as boxes or questions marks
- Terminal doesn't support UTF-8
- Solution: 
  - Set terminal encoding to UTF-8
  - Or use `export LANG=en_US.UTF-8`

#### Colors not showing correctly
- Terminal doesn't support 256 colors
- Solution:
  - Use a modern terminal
  - Or set `export TERM=xterm-256color`

#### Browser doesn't open
- Default browser not configured
- Solution: Manually copy URLs and open

### Getting Help

1. Check error messages carefully
2. Run tests: `python3 test_school_tracker.py`
3. Create an issue on GitHub
4. Include:
   - Python version: `python3 --version`
   - OS version
   - Error message
   - Steps to reproduce

## Advanced Setup

### Running Tests
```bash
# Run all tests
python3 test_school_tracker.py -v

# Check specific functionality
python3 -c "from school_transfer_visual import VisualSchoolTracker; print('Import successful')"
```

### Development Setup
```bash
# Install development dependencies
pip install pytest black flake8

# Format code
black *.py

# Check code style
flake8 *.py

# Run tests with pytest
pytest test_school_tracker.py -v
```

### Docker Setup (Optional)
```dockerfile
# Dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY *.py .
CMD ["python", "school_transfer_visual.py"]
```

```bash
# Build and run
docker build -t jcps-tracker .
docker run -it jcps-tracker
```

## Security Considerations

- Data is stored locally (no cloud sync)
- No passwords or sensitive data in code
- Phone numbers are stored in plain text
- Backup your data regularly
- Don't share `transfer_data.json` publicly

## Performance Tips

- Close other applications for best visual experience
- Use a fast terminal emulator
- Keep data file under 1MB
- Archive old activity logs periodically

## Next Steps

1. Run the visual tracker
2. Review pre-loaded schools
3. Add any additional target schools
4. Set up daily routine:
   - Check JCPS portal at 7am
   - Update school statuses
   - Complete action items
   - Log interactions

Good luck with your school transfer journey! 🍀