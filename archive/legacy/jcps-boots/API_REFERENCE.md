# API Reference

## VisualSchoolTracker Class

### Constructor

```python
VisualSchoolTracker(data_file="transfer_data.json")
```

Creates a new instance of the school transfer tracker.

**Parameters:**
- `data_file` (str): Path to JSON data file. Defaults to "transfer_data.json"

**Example:**
```python
tracker = VisualSchoolTracker()
# or with custom data file
tracker = VisualSchoolTracker(data_file="my_data.json")
```

### Core Methods

#### load_data()
```python
def load_data() -> Dict
```
Loads existing data from JSON file or creates new data structure.

**Returns:**
- Dict: Complete data structure

**Raises:**
- JSONDecodeError: If data file is corrupted

---

#### save_data()
```python
def save_data() -> None
```
Persists current data to JSON file.

**Side Effects:**
- Writes to data_file

---

#### initialize_context()
```python
def initialize_context() -> None
```
Sets up default schools, contacts, and action items if not present.

**Side Effects:**
- Modifies self.data
- Calls save_data()

### UI Generation Methods

#### create_header()
```python
def create_header() -> Panel
```
Creates the top header panel with date and countdown.

**Returns:**
- Panel: Rich panel object with header content

**Display includes:**
- Current date
- Days until school starts
- Daily streak counter

---

#### create_schools_table()
```python
def create_schools_table() -> Table
```
Generates the main schools status table.

**Returns:**
- Table: Rich table with columns for School, Phone, Status, Priority, Last Contact, Action

**Features:**
- Color-coded priorities
- Status emojis
- Phone numbers
- Last contact tracking

---

#### create_progress_panel()
```python
def create_progress_panel() -> Panel
```
Creates progress tracking panel with metrics.

**Returns:**
- Panel: Progress information including completion percentage and key metrics

---

#### create_actions_panel()
```python
def create_actions_panel() -> Panel
```
Generates today's priorities and time-sensitive alerts.

**Returns:**
- Panel: Action items and alerts

### Feature Methods

#### update_school_status()
```python
def update_school_status() -> None
```
Interactive interface for updating school transfer status.

**User Flow:**
1. Display current schools
2. Select school to update
3. Choose new status
4. Add optional notes
5. Save changes

**Side Effects:**
- Updates school status in data
- Records timestamp
- Adds to activity log

---

#### show_resources()
```python
def show_resources() -> None
```
Displays comprehensive resources menu with browser integration.

**Menu Options:**
1. Official JCPS Transfer Portal
2. School Rating Sites
3. Parent Facebook Groups
4. Quick Phone Directory
5. Free Tutoring Resources
6. Private School Options
7. Homeschool Information

**Features:**
- Direct browser opening
- Detailed resource information
- Contact details

---

#### show_contacts()
```python
def show_contacts() -> None
```
Contact management interface.

**Features:**
- Display contacts table
- Add new contacts
- Log interactions (placeholder)

---

#### add_contact()
```python
def add_contact() -> None
```
Prompts for and adds a new contact.

**Required Fields:**
- Name
- Phone
- Role (parent/staff/admin/other)

**Optional Fields:**
- Notes

### Utility Methods

#### get_status_emoji()
```python
def get_status_emoji(status: str) -> str
```
Maps school status to corresponding emoji.

**Parameters:**
- `status` (str): School status string

**Returns:**
- str: Emoji character

**Status Mapping:**
- "monitoring" → "👀"
- "contacted" → "📞"
- "waitlisted" → "⏳"
- "opening_possible" → "🎯"
- "accepted" → "✅"
- "declined" → "❌"
- default → "❓"

---

#### get_priority_color()
```python
def get_priority_color(priority: str) -> str
```
Maps priority level to Rich color name.

**Parameters:**
- `priority` (str): Priority level

**Returns:**
- str: Color name for Rich styling

**Priority Mapping:**
- "high" → "red"
- "medium" → "yellow"
- "low" → "green"
- default → "white"

### Quick Action Methods

#### quick_call_school()
```python
def quick_call_school() -> None
```
Displays schools with phone numbers and calling tips.

**Shows:**
- Numbered list of schools with phone numbers
- Calling script suggestion
- Transfer status reminder

---

#### quick_complete_task()
```python
def quick_complete_task() -> None
```
Interface for marking tasks as complete.

**Flow:**
1. Show incomplete tasks
2. Select task to complete
3. Update data
4. Show confirmation

---

#### show_phone_directory()
```python
def show_phone_directory() -> None
```
Displays comprehensive phone directory.

**Includes:**
- Critical JCPS numbers
- Target school contacts
- Call script template

### Main Application Loop

#### run()
```python
def run() -> None
```
Main application entry point with event loop.

**Features:**
- Welcome animation
- Dashboard display
- Command processing
- Graceful exit

**Commands:**
- d: Dashboard (default)
- s: Update school status
- c: Manage contacts
- r: Show resources
- a: Quick actions
- q: Quit

## Usage Examples

### Basic Usage
```python
# Create tracker instance
tracker = VisualSchoolTracker()

# Run the application
tracker.run()
```

### Programmatic Usage
```python
# Create tracker
tracker = VisualSchoolTracker()

# Add a school programmatically
tracker.data["target_schools"]["New School"] = {
    "priority": "high",
    "contact_info": "(502) 555-1234",
    "status": "monitoring",
    "last_contacted": None,
    "notes": "Recommended by friend"
}

# Save changes
tracker.save_data()

# Generate UI components
table = tracker.create_schools_table()
console = Console()
console.print(table)
```

### Testing Usage
```python
# Create with test data file
test_tracker = VisualSchoolTracker(data_file="test_data.json")

# Verify initialization
assert "Greathouse/Shryock Traditional" in test_tracker.data["target_schools"]

# Test status emoji
assert test_tracker.get_status_emoji("accepted") == "✅"
```

## Error Handling

The application handles common errors gracefully:

- **Missing data file**: Creates new file with defaults
- **Corrupted JSON**: Falls back to empty data structure
- **Invalid user input**: Prompts for valid input
- **Browser errors**: Continues without opening

## Thread Safety

The current implementation is single-threaded and not thread-safe. For multi-threaded usage, implement locking around data access:

```python
import threading

class ThreadSafeTracker(VisualSchoolTracker):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.lock = threading.Lock()
    
    def save_data(self):
        with self.lock:
            super().save_data()
```