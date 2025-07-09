# Technical Documentation

## Architecture Overview

The JCPS School Transfer Tracker is built with a modular architecture that supports both CLI and visual interfaces.

### Core Components

```
┌─────────────────────────────────────────────────────────┐
│                    User Interface Layer                  │
├─────────────────────┬───────────────────────────────────┤
│   Standard CLI      │        Visual UI (Rich)           │
│ (school_transfer_   │    (school_transfer_visual.py)    │
│    tracker.py)      │                                   │
├─────────────────────┴───────────────────────────────────┤
│                    Data Layer                            │
│              (JSON file: transfer_data.json)             │
└─────────────────────────────────────────────────────────┘
```

## Class Structure

### VisualSchoolTracker

Main application class that handles all functionality.

#### Key Methods

```python
class VisualSchoolTracker:
    def __init__(self, data_file="transfer_data.json")
        """Initialize tracker with data file"""
    
    def load_data() -> Dict
        """Load data from JSON file or create new structure"""
    
    def save_data()
        """Persist data to JSON file"""
    
    def initialize_context()
        """Set up default schools and action items"""
    
    # UI Generation Methods
    def create_header() -> Panel
        """Generate header with date and countdown"""
    
    def create_schools_table() -> Table
        """Create schools status table with phone numbers"""
    
    def create_progress_panel() -> Panel
        """Generate progress tracking panel"""
    
    def create_actions_panel() -> Panel
        """Create today's priorities panel"""
    
    def create_dashboard_layout() -> Layout
        """Compose full dashboard layout"""
    
    # Feature Methods
    def update_school_status()
        """Interactive school status update"""
    
    def show_resources()
        """Display resources menu with browser integration"""
    
    def show_contacts()
        """Contact management interface"""
    
    def show_quick_actions()
        """Quick actions menu"""
    
    # Utility Methods
    def get_status_emoji(status: str) -> str
        """Map status to emoji"""
    
    def get_priority_color(priority: str) -> str
        """Map priority to color"""
```

## Data Schema

### transfer_data.json Structure

```json
{
  "current_school": {
    "name": "string",
    "grade": "string",
    "concerns": ["string"],
    "transfer_status": "string"
  },
  "target_schools": {
    "School Name": {
      "priority": "high|medium|low",
      "contact_info": "string (phone)",
      "status": "monitoring|contacted|waitlisted|opening_possible|accepted|declined",
      "last_contacted": "ISO datetime string or null",
      "notes": "string"
    }
  },
  "contacts": {
    "Contact Name": {
      "phone": "string",
      "email": "string",
      "affiliation": "string",
      "role": "parent|staff|admin|other",
      "notes": "string",
      "interactions": [
        {
          "date": "ISO datetime",
          "type": "call|email|text|meeting",
          "summary": "string",
          "learned": "string",
          "follow_up": "string"
        }
      ]
    }
  },
  "action_items": [
    {
      "task": "string",
      "priority": "high|medium|low",
      "completed": "boolean",
      "daily": "boolean (optional)"
    }
  ],
  "activity_log": [
    {
      "date": "ISO datetime",
      "type": "contact_interaction|status_update",
      "details": "object"
    }
  ],
  "daily_streak": "integer",
  "last_check_date": "ISO datetime or null",
  "achievements": ["string"]
}
```

## Dependencies

### Python Libraries

- **rich** (>=13.7.0): Terminal UI rendering
  - Console: Main output interface
  - Table: Structured data display
  - Panel: Bordered content sections
  - Layout: Dashboard composition
  - Progress: Visual progress bars
  - Prompt/Confirm: User input handling

- **click** (>=8.1.0): CLI framework (future use)
- **requests** (>=2.31.0): HTTP requests (future API integration)
- **python-dateutil** (>=2.8.2): Date manipulation

### Standard Library
- **json**: Data persistence
- **os**: File system operations
- **datetime**: Date/time handling
- **webbrowser**: Browser integration
- **tempfile**: Test file generation
- **unittest**: Testing framework

## UI Color Scheme

### Status Colors
- **Monitoring** (👀): Default white
- **Contacted** (📞): Yellow
- **Waitlisted** (⏳): Yellow
- **Opening Possible** (🎯): Green
- **Accepted** (✅): Green
- **Declined** (❌): Red

### Priority Colors
- **High**: Red
- **Medium**: Yellow  
- **Low**: Green

### UI Elements
- **Headers**: Bold cyan on dark blue background
- **Panels**: Rounded/double borders
- **Action items**: Color-coded by priority
- **Phone numbers**: Cyan for emphasis

## Browser Integration

The application uses Python's `webbrowser` module to open URLs:

```python
import webbrowser

# Opens in default browser
webbrowser.open("https://example.com")
```

Supported resources:
- JCPS Transfer Portal
- GreatSchools.org
- Niche.com
- Facebook Groups
- JCPS Official Sites

## Testing Strategy

### Unit Tests
- Data persistence
- Status/priority mappings
- Table generation
- Progress calculations

### Integration Tests
- Full workflow scenarios
- Multi-component interactions
- Data consistency

### Test Execution
```bash
# Run all tests
python3 test_school_tracker.py -v

# Run specific test class
python3 test_school_tracker.py TestVisualSchoolTracker -v

# Run single test
python3 test_school_tracker.py TestVisualSchoolTracker.test_browser_opening -v
```

## Performance Considerations

- JSON file loaded once at startup
- Saves triggered only on data changes
- Minimal UI refresh (only on command execution)
- Efficient table rendering with Rich
- No background processes or timers

## Future Enhancements

1. **API Integration**
   - Direct JCPS portal checking
   - Automated school rating updates
   - Real-time seat availability

2. **Notifications**
   - Desktop alerts for time-sensitive tasks
   - Email summaries
   - SMS reminders

3. **Data Analytics**
   - Success rate tracking
   - Time investment analysis
   - Predictive modeling

4. **Multi-User Support**
   - Cloud sync
   - Family sharing
   - Anonymous community data

5. **Mobile Companion**
   - Progressive Web App
   - Native mobile apps
   - Offline support