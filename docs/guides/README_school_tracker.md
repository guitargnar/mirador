# School Transfer Tracker

A comprehensive tool to help manage the school transfer process from Shelby Academy Elementary to better-performing schools in the JCPS district. Available in both command-line (TUI) and web dashboard versions.

## Quick Start

### Command-Line Version (TUI)
```bash
# Make the script executable
chmod +x school_transfer_tracker_v2.py

# Run the tracker
./school_transfer_tracker_v2.py
```

### Web Dashboard Version
```bash
# Make the run script executable
chmod +x run_web_dashboard.sh

# Launch the web dashboard
./run_web_dashboard.sh

# Or run directly with:
streamlit run school_transfer_dashboard.py
```

The web dashboard will open in your browser at http://localhost:8501

## Features

### 🌐 Web Dashboard (NEW!)
- **Interactive visualizations** with charts and graphs
- **Real-time updates** with automatic data refresh
- **Mobile-responsive** design for on-the-go access
- **Analytics page** with timeline views and priority analysis
- **Enhanced UI** with modern, intuitive interface

### 📊 Dashboard View (Both Versions)
- See all target schools with current status
- View key contacts and interaction history  
- Recent activity log
- Quick statistics
- Days until school countdown
- Action item tracking

### 🏫 School Management
- Add target schools with priority levels
- Track status: monitoring → contacted → waitlisted → opening_possible → accepted/declined
- Log notes and updates for each school

### 👥 Contact Management
- Store parent contacts, school staff, and other helpful people
- Log interactions (calls, emails, meetings)
- Track what you learned from each conversation
- Set follow-up reminders

### 📝 Resources
- Save helpful websites, documents, and groups
- Keep everything organized in one place

### 🔍 Search Function
- Search through all your notes and interactions
- Find specific information quickly

### 📱 Quick Phone List
- One-click access to all important numbers
- Organized by priority

### 📚 Enhanced JCPS Resources (v2 & Web)
- Comprehensive resource hub with official JCPS links
- School rating sites and parent groups
- Tutoring and educational support options
- Private school and homeschool information
- Quick contact directory with call scripts

### 📈 Analytics & Insights (Web Version)
- Activity timeline visualization
- School status distribution charts
- Action item progress tracking
- Contact frequency analysis
- Priority distribution overview

## Version Comparison

| Feature | TUI (v2) | Web Dashboard |
|---------|----------|---------------|
| Dashboard View | ✅ Text-based | ✅ Visual with charts |
| School Management | ✅ Full features | ✅ Full features + visual status |
| Contact Tracking | ✅ Full features | ✅ Full features + interaction timeline |
| Action Items | ✅ Checklist | ✅ Interactive with filters |
| Resources | ✅ Menu-based | ✅ Tabbed interface |
| Analytics | ❌ | ✅ Full analytics page |
| Mobile Access | ❌ | ✅ Responsive design |
| Real-time Updates | Manual refresh | Auto-refresh available |

## Usage Examples

### First Time Setup
1. Run `./school_transfer_tracker.py`
2. Choose option 2 to add target schools:
   - Greathouse/Shryock Traditional
   - Norton Commons Elementary
   - Goshen Elementary
3. Choose option 3 to add contacts you know
4. Choose option 6 to add resources like:
   - JCPS Parent Facebook groups
   - School review websites
   - Transfer policy documents

### Daily Workflow
1. Start with option 1 (Dashboard) to see current status
2. After checking JCPS portal, use option 5 to update school statuses
3. After phone calls, use option 4 to log interactions
4. Use option 8 for quick access to phone numbers

### Data Storage
All data is saved in `transfer_data.json` in the same directory. Back this up regularly!

## Installation

### Requirements
- Python 3.7 or higher
- For web version: pip (Python package manager)

### Web Dashboard Setup
```bash
# Install dependencies
pip install -r requirements_web.txt

# Or use the provided script which handles everything:
./run_web_dashboard.sh
```

## Deployment Options

### Local Deployment
Both versions run locally on your computer by default.

### Cloud Deployment (Web Version)
The Streamlit web dashboard can be deployed to:
- **Streamlit Community Cloud** (free tier available)
- **Heroku** (with Procfile)
- **AWS/GCP/Azure** (containerized deployment)
- **Raspberry Pi** (for home network access)

### Example Streamlit Cloud Deployment
1. Push code to GitHub
2. Connect repo to Streamlit Cloud
3. Deploy with one click
4. Access from anywhere with internet

## Tips
- Log every interaction - you never know what detail might be important
- Update school status immediately when you learn something new
- Use the search function to find patterns in your notes
- Check the dashboard daily to stay on top of your efforts
- Set up the web version for mobile access during school visits
- Use analytics to identify which schools to focus on
- Export data regularly for backup

## Data Compatibility
Both versions use the same `transfer_data.json` file, so you can switch between TUI and web versions seamlessly.

Good luck with your transfer search! 🍀