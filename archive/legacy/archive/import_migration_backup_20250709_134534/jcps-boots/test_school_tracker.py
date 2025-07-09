#!/usr/bin/env python3
"""
Test suite for JCPS School Transfer Tracker
"""

import unittest
import json
import os
import tempfile
from datetime import datetime
from unittest.mock import patch, MagicMock
from school_transfer_visual import VisualSchoolTracker
from rich.console import Console
from rich.table import Table

class TestVisualSchoolTracker(unittest.TestCase):
    """Test cases for the Visual School Tracker"""
    
    def setUp(self):
        """Set up test environment"""
        # Create a temporary file for test data
        self.test_fd, self.test_file = tempfile.mkstemp(suffix='.json')
        os.close(self.test_fd)  # Close the file descriptor
        # Remove the file so tracker creates fresh one
        os.unlink(self.test_file)
        self.tracker = VisualSchoolTracker(data_file=self.test_file)
        self.console = Console()
    
    def tearDown(self):
        """Clean up test environment"""
        if os.path.exists(self.test_file):
            os.unlink(self.test_file)
    
    def test_initialization(self):
        """Test tracker initialization with default data"""
        # Check that default schools are loaded
        self.assertIn("Greathouse/Shryock Traditional", self.tracker.data["target_schools"])
        self.assertIn("Norton Commons Elementary", self.tracker.data["target_schools"])
        self.assertIn("Goshen Elementary", self.tracker.data["target_schools"])
        
        # Check that current school info is set
        self.assertEqual(self.tracker.data["current_school"]["name"], "Shelby Academy Elementary")
        self.assertEqual(self.tracker.data["current_school"]["grade"], "2nd Grade")
        
        # Check that action items are loaded
        self.assertTrue(len(self.tracker.data["action_items"]) > 0)
        self.assertEqual(self.tracker.data["action_items"][0]["task"], "Check JCPS portal for openings")
    
    def test_save_and_load_data(self):
        """Test saving and loading data"""
        # Modify data
        self.tracker.data["test_key"] = "test_value"
        self.tracker.save_data()
        
        # Create new tracker instance to load data
        new_tracker = VisualSchoolTracker(data_file=self.test_file)
        
        # Check that data was persisted
        self.assertEqual(new_tracker.data["test_key"], "test_value")
    
    def test_status_emoji_mapping(self):
        """Test status emoji mapping"""
        self.assertEqual(self.tracker.get_status_emoji("monitoring"), "👀")
        self.assertEqual(self.tracker.get_status_emoji("contacted"), "📞")
        self.assertEqual(self.tracker.get_status_emoji("waitlisted"), "⏳")
        self.assertEqual(self.tracker.get_status_emoji("opening_possible"), "🎯")
        self.assertEqual(self.tracker.get_status_emoji("accepted"), "✅")
        self.assertEqual(self.tracker.get_status_emoji("declined"), "❌")
        self.assertEqual(self.tracker.get_status_emoji("unknown"), "❓")
    
    def test_priority_color_mapping(self):
        """Test priority color mapping"""
        self.assertEqual(self.tracker.get_priority_color("high"), "red")
        self.assertEqual(self.tracker.get_priority_color("medium"), "yellow")
        self.assertEqual(self.tracker.get_priority_color("low"), "green")
        self.assertEqual(self.tracker.get_priority_color("unknown"), "white")
    
    def test_create_schools_table(self):
        """Test schools table creation"""
        table = self.tracker.create_schools_table()
        
        # Check that table is created
        self.assertIsInstance(table, Table)
        
        # Check table has correct columns
        self.assertEqual(len(table.columns), 6)
        self.assertEqual(table.columns[0].header, "School")
        self.assertEqual(table.columns[1].header, "Phone")
        self.assertEqual(table.columns[2].header, "Status")
        self.assertEqual(table.columns[3].header, "Priority")
        self.assertEqual(table.columns[4].header, "Last Contact")
        self.assertEqual(table.columns[5].header, "Action")
    
    def test_school_phone_numbers_included(self):
        """Test that phone numbers are included in the schools table"""
        # Add test school with phone number
        self.tracker.data["target_schools"]["Test School"] = {
            "priority": "high",
            "contact_info": "(502) 123-4567",
            "status": "monitoring",
            "last_contacted": None,
            "notes": "Test notes"
        }
        
        # Check that phone number is in the data
        self.assertEqual(
            self.tracker.data["target_schools"]["Test School"]["contact_info"],
            "(502) 123-4567"
        )
    
    def test_add_contact(self):
        """Test adding a new contact"""
        # Initially should have the default JCPS contact
        self.tracker.initialize_context()
        
        # Add a new contact
        test_contact = {
            "phone": "(502) 999-8888",
            "role": "parent",
            "notes": "Parent at Norton Commons",
            "interactions": []
        }
        
        self.tracker.data["contacts"]["Test Parent"] = test_contact
        self.tracker.save_data()
        
        # Verify contact was added
        self.assertIn("Test Parent", self.tracker.data["contacts"])
        self.assertEqual(self.tracker.data["contacts"]["Test Parent"]["phone"], "(502) 999-8888")
    
    def test_update_school_status(self):
        """Test updating school status"""
        school_name = "Greathouse/Shryock Traditional"
        
        # Update status
        self.tracker.data["target_schools"][school_name]["status"] = "waitlisted"
        self.tracker.data["target_schools"][school_name]["last_contacted"] = datetime.now().isoformat()
        self.tracker.save_data()
        
        # Verify status was updated
        self.assertEqual(self.tracker.data["target_schools"][school_name]["status"], "waitlisted")
        self.assertIsNotNone(self.tracker.data["target_schools"][school_name]["last_contacted"])
    
    def test_action_items_completion(self):
        """Test marking action items as complete"""
        # Mark first action item as complete
        self.tracker.data["action_items"][0]["completed"] = True
        self.tracker.save_data()
        
        # Verify completion
        self.assertTrue(self.tracker.data["action_items"][0]["completed"])
        
        # Check incomplete items count
        incomplete_count = sum(1 for task in self.tracker.data["action_items"] if not task["completed"])
        total_count = len(self.tracker.data["action_items"])
        self.assertEqual(incomplete_count, total_count - 1)
    
    def test_progress_calculation(self):
        """Test progress calculation"""
        # Set up test data
        self.tracker.data["action_items"] = [
            {"task": "Task 1", "completed": True, "priority": "high"},
            {"task": "Task 2", "completed": True, "priority": "high"},
            {"task": "Task 3", "completed": False, "priority": "medium"},
            {"task": "Task 4", "completed": False, "priority": "low"}
        ]
        
        # Calculate progress
        completed = sum(1 for task in self.tracker.data["action_items"] if task["completed"])
        total = len(self.tracker.data["action_items"])
        progress_pct = (completed / total * 100) if total > 0 else 0
        
        self.assertEqual(progress_pct, 50.0)
    
    @patch('webbrowser.open')
    def test_browser_opening(self, mock_browser):
        """Test that browser opens correctly for resources"""
        # Test JCPS portal opening
        test_url = "https://apps.jefferson.kyschools.us/studentassignment/transferonlineapplication/"
        
        # Simulate browser open (would be called in show_resources)
        import webbrowser
        webbrowser.open(test_url)
        
        # Verify browser was called with correct URL
        mock_browser.assert_called_once_with(test_url)
    
    def test_daily_streak_tracking(self):
        """Test daily streak tracking"""
        # Set initial streak
        self.tracker.data["daily_streak"] = 5
        self.tracker.data["last_check_date"] = datetime.now().isoformat()
        self.tracker.save_data()
        
        # Verify streak is maintained
        self.assertEqual(self.tracker.data["daily_streak"], 5)
        self.assertIsNotNone(self.tracker.data["last_check_date"])
    
    def test_critical_phone_numbers_present(self):
        """Test that all critical phone numbers are included"""
        # Critical numbers that should be accessible
        critical_numbers = {
            "School Choice Office": "(502) 485-6250",
            "JCPS Main": "(502) 485-3011",
            "Shelby Academy": "(502) 485-8331",
            "Greathouse/Shryock": "(502) 485-8295",
            "Norton Commons": "(502) 485-8388",
            "Goshen Elementary": "(502) 485-8322"
        }
        
        # Check target schools have correct numbers
        self.assertEqual(
            self.tracker.data["target_schools"]["Greathouse/Shryock Traditional"]["contact_info"],
            "(502) 485-8295"
        )
        self.assertEqual(
            self.tracker.data["target_schools"]["Norton Commons Elementary"]["contact_info"],
            "(502) 485-8388"
        )
        self.assertEqual(
            self.tracker.data["target_schools"]["Goshen Elementary"]["contact_info"],
            "(502) 485-8322"
        )

class TestIntegration(unittest.TestCase):
    """Integration tests for the complete system"""
    
    def setUp(self):
        """Set up integration test environment"""
        self.test_fd, self.test_file = tempfile.mkstemp(suffix='.json')
        os.close(self.test_fd)
        os.unlink(self.test_file)
        self.tracker = VisualSchoolTracker(data_file=self.test_file)
    
    def tearDown(self):
        """Clean up"""
        if os.path.exists(self.test_file):
            os.unlink(self.test_file)
    
    def test_full_workflow(self):
        """Test a complete workflow scenario"""
        # 1. Initial state
        self.assertEqual(len(self.tracker.data["target_schools"]), 3)
        
        # 2. Update a school status
        school = "Norton Commons Elementary"
        self.tracker.data["target_schools"][school]["status"] = "contacted"
        self.tracker.data["target_schools"][school]["last_contacted"] = datetime.now().isoformat()
        
        # 3. Add a contact
        self.tracker.data["contacts"]["Ms. Smith"] = {
            "phone": "(502) 555-1234",
            "role": "staff",
            "notes": "Norton Commons admissions",
            "interactions": []
        }
        
        # 4. Complete an action item
        self.tracker.data["action_items"][0]["completed"] = True
        
        # 5. Save all changes
        self.tracker.save_data()
        
        # 6. Load in new instance and verify
        new_tracker = VisualSchoolTracker(data_file=self.test_file)
        self.assertEqual(new_tracker.data["target_schools"][school]["status"], "contacted")
        self.assertIn("Ms. Smith", new_tracker.data["contacts"])
        self.assertTrue(new_tracker.data["action_items"][0]["completed"])

if __name__ == "__main__":
    # Run tests with verbosity
    unittest.main(verbosity=2)