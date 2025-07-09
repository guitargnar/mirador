#!/usr/bin/env python3
"""
Analytics Integration Module
Add this to any tool to automatically track usage
"""

import os
import sys

def track_tool_usage(tool_name: str, user_id: str = None):
    """
    Silently track tool usage without interrupting workflow
    
    Args:
        tool_name: Name of the tool being used
        user_id: Optional user identifier
    """
    try:
        # Import the tracker module if available
        current_dir = os.path.dirname(os.path.abspath(__file__))
        sys.path.insert(0, current_dir)
        
        from analytics_tracker import track_usage
        
        # Get user from environment or use anonymous
        if not user_id:
            user_id = os.environ.get('USER', 'anonymous')
        
        # Track usage silently
        track_usage(tool_name, user_id)
        
    except:
        # Fail silently - don't interrupt the tool if analytics fails
        pass

# Integration snippets for each tool:
INTEGRATION_GUIDE = """
# HOW TO ADD ANALYTICS TO EACH TOOL

## Step 1: Add import at the top of the file
```python
try:
    from analytics_integration import track_tool_usage
    ANALYTICS_ENABLED = True
except:
    ANALYTICS_ENABLED = False
```

## Step 2: Add tracking call after successful operation

### For meeting_notes_formatter.py:
```python
# After generating all formats:
if ANALYTICS_ENABLED:
    track_tool_usage("meeting_notes")
```

### For cms_guidance_analyzer.py:
```python
# After saving the output file:
if ANALYTICS_ENABLED:
    track_tool_usage("cms_analyzer")
```

### For email_action_parser.py:
```python
# After parsing actions:
if ANALYTICS_ENABLED:
    track_tool_usage("email_parser")
```

### For weekly_accomplishments_tracker.py:
```python
# After any add/view/generate operation:
if ANALYTICS_ENABLED:
    track_tool_usage("weekly_tracker")
```

### For star_ratings_analyzer.py:
```python
# After generating report:
if ANALYTICS_ENABLED:
    track_tool_usage("star_ratings")
```

## Step 3: Test Integration
Run the tool normally - analytics will track silently in the background.
Check analytics with: python3 analytics_tracker.py

## Privacy Note
- Only tracks tool name and timestamp
- No personal data or content is tracked
- User ID defaults to system username (can be anonymized)
- All data stays local in productivity_analytics.json
"""

if __name__ == "__main__":
    print(INTEGRATION_GUIDE)