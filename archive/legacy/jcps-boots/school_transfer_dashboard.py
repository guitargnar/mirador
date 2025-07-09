#!/usr/bin/env python3
"""
School Transfer Dashboard - Streamlit Web Interface
Enhanced web version of the School Transfer Tracker with interactive visualizations
"""

import streamlit as st
import json
import os
from datetime import datetime, timedelta
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from typing import Dict, List, Optional
import webbrowser

# Page configuration
st.set_page_config(
    page_title="School Transfer Mission Control",
    page_icon="🎯",
    layout="wide",
    initial_sidebar_state="expanded"
)

# Custom CSS for better styling
st.markdown("""
    <style>
    .main {
        padding-top: 2rem;
    }
    .stButton>button {
        width: 100%;
        margin-top: 0.5rem;
    }
    .metric-card {
        background-color: #f0f2f6;
        padding: 1rem;
        border-radius: 0.5rem;
        margin-bottom: 1rem;
    }
    .priority-high {
        color: #ff4b4b;
        font-weight: bold;
    }
    .priority-medium {
        color: #ffa500;
    }
    .priority-low {
        color: #0068c9;
    }
    .status-badge {
        padding: 0.2rem 0.6rem;
        border-radius: 1rem;
        font-size: 0.9rem;
        font-weight: 500;
    }
    </style>
""", unsafe_allow_html=True)

class SchoolTransferDashboard:
    def __init__(self):
        self.data_file = "transfer_data.json"
        self.initialize_session_state()
        self.load_data()
        
    def initialize_session_state(self):
        """Initialize Streamlit session state"""
        if 'page' not in st.session_state:
            st.session_state.page = 'dashboard'
        if 'show_add_school' not in st.session_state:
            st.session_state.show_add_school = False
        if 'show_add_contact' not in st.session_state:
            st.session_state.show_add_contact = False
        if 'refresh_data' not in st.session_state:
            st.session_state.refresh_data = False
    
    def load_data(self) -> Dict:
        """Load existing data or create new structure"""
        if os.path.exists(self.data_file):
            with open(self.data_file, 'r') as f:
                self.data = json.load(f)
        else:
            self.data = {
                "current_school": {
                    "name": "Shelby Academy Elementary",
                    "grade": "2nd Grade",
                    "concerns": [
                        "Math proficiency: 6-9% (vs 30% state average)",
                        "Reading proficiency: 15-19% (vs 42% state average)",
                        "28% enrollment decline over 5 years",
                        "30% teacher loss over 5 years",
                        "Ranked #1158 out of 1,230 schools in KY"
                    ],
                    "transfer_status": "Active - can transfer anytime a seat opens"
                },
                "target_schools": {},
                "contacts": {},
                "resources": {},
                "activity_log": [],
                "reminders": [],
                "action_items": []
            }
            self.initialize_default_data()
    
    def initialize_default_data(self):
        """Initialize with default data"""
        # Add target schools
        self.data["target_schools"] = {
            "Greathouse/Shryock Traditional": {
                "priority": "high",
                "contact_info": "(502) 485-8295",
                "notes": "Parents praise academic rigor and caring staff. 'Best experience ever' per parent review.",
                "last_contacted": None,
                "status": "monitoring"
            },
            "Norton Commons Elementary": {
                "priority": "high",
                "contact_info": "(502) 485-8388",
                "notes": "4.5/5 GreatSchools rating. 'Couldn't be happier' per parent review.",
                "last_contacted": None,
                "status": "monitoring"
            },
            "Goshen Elementary": {
                "priority": "high",
                "contact_info": "(502) 485-8322",
                "notes": "Strong parent satisfaction for individualized learning. 'We love it' - parent of 3-year student.",
                "last_contacted": None,
                "status": "monitoring"
            },
            "Anchorage Independent": {
                "priority": "medium",
                "contact_info": "(502) 245-1463",
                "notes": "Top-rated but check district boundaries. A rating on Niche.",
                "last_contacted": None,
                "status": "monitoring"
            }
        }
        
        # Add action items
        self.data["action_items"] = [
            {"task": "Monitor JCPS portal daily at 7am for seat openings", "priority": "high", "completed": False},
            {"task": "Join JCPS Parents Facebook group", "priority": "high", "completed": False},
            {"task": "Schedule meeting with Shelby principal (week of July 15)", "priority": "high", "completed": False},
            {"task": "Hire math tutor immediately", "priority": "high", "completed": False},
            {"task": "Get daughter assessed at Sylvan Learning for documentation", "priority": "medium", "completed": False},
            {"task": "Research and tour 2-3 private schools as backup", "priority": "medium", "completed": False},
            {"task": "Call Office of School Choice weekly", "priority": "high", "completed": False},
            {"task": "Document any anxiety about starting at Shelby", "priority": "medium", "completed": False}
        ]
        
        # Add key contact
        self.data["contacts"]["JCPS School Choice Office"] = {
            "phone": "(502) 485-6250",
            "email": "jcpsschoolchoice@jefferson.kyschools.us",
            "affiliation": "JCPS",
            "role": "admin",
            "notes": "Primary contact for all transfer questions. Office at 4309 Bishop Lane.",
            "interactions": []
        }
        
        self.save_data()
    
    def save_data(self):
        """Save data to file"""
        with open(self.data_file, 'w') as f:
            json.dump(self.data, f, indent=2)
        st.success("✅ Data saved successfully!", icon="✅")
    
    def render_sidebar(self):
        """Render sidebar navigation"""
        with st.sidebar:
            st.image("https://via.placeholder.com/150x50?text=Transfer+Tracker", width=150)
            st.markdown("---")
            
            # Navigation
            st.subheader("Navigation")
            if st.button("📊 Dashboard", use_container_width=True):
                st.session_state.page = 'dashboard'
            if st.button("🎯 Action Items", use_container_width=True):
                st.session_state.page = 'actions'
            if st.button("🏫 Target Schools", use_container_width=True):
                st.session_state.page = 'schools'
            if st.button("👥 Contacts", use_container_width=True):
                st.session_state.page = 'contacts'
            if st.button("📚 Resources", use_container_width=True):
                st.session_state.page = 'resources'
            if st.button("📈 Analytics", use_container_width=True):
                st.session_state.page = 'analytics'
            
            st.markdown("---")
            
            # Quick Stats
            st.subheader("Quick Stats")
            days_until_school = (datetime(2025, 8, 15) - datetime.now()).days
            st.metric("Days Until School", days_until_school)
            
            active_schools = sum(1 for s in self.data["target_schools"].values() 
                               if s["status"] not in ["declined", "accepted"])
            st.metric("Active Target Schools", active_schools)
            
            completed_actions = sum(1 for a in self.data["action_items"] if a["completed"])
            total_actions = len(self.data["action_items"])
            st.metric("Actions Completed", f"{completed_actions}/{total_actions}")
    
    def render_dashboard(self):
        """Render main dashboard"""
        st.title("🎯 School Transfer Mission Control")
        st.markdown(f"**Current Date:** {datetime.now().strftime('%B %d, %Y')}")
        
        # Alert banner
        col1, col2 = st.columns([3, 1])
        with col1:
            st.error(f"⚠️ **Current School:** {self.data['current_school']['name']} - {self.data['current_school']['transfer_status']}")
        with col2:
            if st.button("🔄 Refresh Data"):
                st.rerun()
        
        # Key metrics
        st.subheader("📊 Key Metrics")
        col1, col2, col3, col4 = st.columns(4)
        
        with col1:
            days_until_school = (datetime(2025, 8, 15) - datetime.now()).days
            st.metric(
                "Days Until School Starts",
                days_until_school,
                f"-{7}" if days_until_school < 40 else "0",
                delta_color="inverse"
            )
        
        with col2:
            active_schools = sum(1 for s in self.data["target_schools"].values() 
                               if s["status"] not in ["declined", "accepted"])
            total_schools = len(self.data["target_schools"])
            st.metric("Active Target Schools", f"{active_schools}/{total_schools}")
        
        with col3:
            completed_actions = sum(1 for a in self.data["action_items"] if a["completed"])
            total_actions = len(self.data["action_items"])
            completion_rate = (completed_actions / total_actions * 100) if total_actions > 0 else 0
            st.metric("Action Items", f"{completed_actions}/{total_actions}", f"{completion_rate:.0f}%")
        
        with col4:
            total_interactions = sum(len(c["interactions"]) for c in self.data["contacts"].values())
            st.metric("Total Interactions", total_interactions)
        
        # Current concerns
        st.subheader("⚠️ Current School Concerns")
        concern_cols = st.columns(2)
        for i, concern in enumerate(self.data['current_school']['concerns']):
            with concern_cols[i % 2]:
                st.warning(f"• {concern}")
        
        # Target schools overview
        st.subheader("🏫 Target Schools Status")
        if self.data["target_schools"]:
            schools_df = []
            for school, info in self.data["target_schools"].items():
                schools_df.append({
                    "School": school,
                    "Priority": info["priority"],
                    "Status": info["status"],
                    "Phone": info["contact_info"],
                    "Last Contact": info["last_contacted"][:10] if info["last_contacted"] else "Never"
                })
            
            df = pd.DataFrame(schools_df)
            
            # Create status emoji mapping
            status_emoji = {
                "monitoring": "👀",
                "contacted": "📞",
                "waitlisted": "⏳",
                "opening_possible": "🎯",
                "accepted": "✅",
                "declined": "❌"
            }
            
            # Style the dataframe
            def style_priority(val):
                if val == "high":
                    return "color: red; font-weight: bold"
                elif val == "medium":
                    return "color: orange"
                return "color: blue"
            
            styled_df = df.style.applymap(style_priority, subset=['Priority'])
            st.dataframe(styled_df, use_container_width=True)
        
        # Recent activity
        st.subheader("📋 Recent Activity")
        if self.data["activity_log"]:
            recent_activities = sorted(self.data["activity_log"], 
                                     key=lambda x: x["date"], 
                                     reverse=True)[:5]
            for activity in recent_activities:
                date = datetime.fromisoformat(activity["date"]).strftime("%m/%d %I:%M %p")
                st.info(f"**{date}** - {activity['type']}: {activity.get('details', activity.get('school', ''))}")
        else:
            st.info("No recent activity logged")
    
    def render_action_items(self):
        """Render action items management"""
        st.title("📋 Action Items Management")
        
        # Add new action item
        with st.expander("➕ Add New Action Item"):
            col1, col2 = st.columns([3, 1])
            with col1:
                new_task = st.text_input("Task description")
            with col2:
                new_priority = st.selectbox("Priority", ["high", "medium", "low"])
            
            if st.button("Add Action Item"):
                if new_task:
                    self.data["action_items"].append({
                        "task": new_task,
                        "priority": new_priority,
                        "completed": False
                    })
                    self.save_data()
                    st.rerun()
        
        # Filter options
        col1, col2 = st.columns(2)
        with col1:
            filter_status = st.selectbox("Filter by status", ["All", "Incomplete", "Completed"])
        with col2:
            filter_priority = st.selectbox("Filter by priority", ["All", "high", "medium", "low"])
        
        # Display action items
        st.subheader("Current Action Items")
        
        filtered_items = []
        for i, item in enumerate(self.data["action_items"]):
            # Apply filters
            if filter_status == "Incomplete" and item["completed"]:
                continue
            if filter_status == "Completed" and not item["completed"]:
                continue
            if filter_priority != "All" and item["priority"] != filter_priority:
                continue
            
            filtered_items.append((i, item))
        
        if filtered_items:
            for idx, (i, item) in enumerate(filtered_items):
                col1, col2, col3 = st.columns([0.5, 4, 1])
                
                with col1:
                    # Checkbox for completion
                    completed = st.checkbox("", value=item["completed"], key=f"complete_{i}")
                    if completed != item["completed"]:
                        self.data["action_items"][i]["completed"] = completed
                        self.save_data()
                        st.rerun()
                
                with col2:
                    # Task with priority styling
                    priority_class = f"priority-{item['priority']}"
                    st.markdown(f"<span class='{priority_class}'>{item['task']}</span>", 
                              unsafe_allow_html=True)
                
                with col3:
                    # Delete button
                    if st.button("🗑️", key=f"delete_{i}"):
                        self.data["action_items"].pop(i)
                        self.save_data()
                        st.rerun()
        else:
            st.info("No action items match the selected filters")
        
        # Summary metrics
        st.markdown("---")
        col1, col2, col3 = st.columns(3)
        
        total = len(self.data["action_items"])
        completed = sum(1 for item in self.data["action_items"] if item["completed"])
        high_priority = sum(1 for item in self.data["action_items"] 
                           if item["priority"] == "high" and not item["completed"])
        
        with col1:
            st.metric("Total Tasks", total)
        with col2:
            st.metric("Completed", f"{completed}/{total}")
        with col3:
            st.metric("High Priority Remaining", high_priority)
    
    def render_schools(self):
        """Render target schools management"""
        st.title("🏫 Target Schools Management")
        
        # Add new school
        if st.button("➕ Add New School"):
            st.session_state.show_add_school = True
        
        if st.session_state.show_add_school:
            with st.form("add_school_form"):
                st.subheader("Add New Target School")
                
                col1, col2 = st.columns(2)
                with col1:
                    school_name = st.text_input("School Name*")
                    phone = st.text_input("Phone Number*")
                    priority = st.selectbox("Priority", ["high", "medium", "low"])
                
                with col2:
                    address = st.text_input("Address (optional)")
                    website = st.text_input("Website (optional)")
                    status = st.selectbox("Initial Status", ["monitoring", "contacted", "waitlisted"])
                
                notes = st.text_area("Initial Notes")
                
                col1, col2 = st.columns(2)
                with col1:
                    if st.form_submit_button("Add School"):
                        if school_name and phone:
                            self.data["target_schools"][school_name] = {
                                "priority": priority,
                                "contact_info": phone,
                                "address": address,
                                "website": website,
                                "notes": notes,
                                "last_contacted": None,
                                "status": status
                            }
                            self.save_data()
                            st.session_state.show_add_school = False
                            st.rerun()
                
                with col2:
                    if st.form_submit_button("Cancel"):
                        st.session_state.show_add_school = False
                        st.rerun()
        
        # Display schools
        for school_name, info in self.data["target_schools"].items():
            with st.expander(f"{school_name} - {info['status'].upper()}"):
                col1, col2, col3 = st.columns([2, 2, 1])
                
                with col1:
                    st.write(f"**Priority:** {info['priority'].upper()}")
                    st.write(f"**Phone:** {info['contact_info']}")
                    if info.get('address'):
                        st.write(f"**Address:** {info['address']}")
                    if info.get('website'):
                        st.write(f"**Website:** {info['website']}")
                
                with col2:
                    # Update status
                    new_status = st.selectbox(
                        "Update Status",
                        ["monitoring", "contacted", "waitlisted", "opening_possible", "accepted", "declined"],
                        index=["monitoring", "contacted", "waitlisted", "opening_possible", "accepted", "declined"].index(info["status"]),
                        key=f"status_{school_name}"
                    )
                    
                    if new_status != info["status"]:
                        info["status"] = new_status
                        info["last_contacted"] = datetime.now().isoformat()
                        
                        # Log activity
                        self.data["activity_log"].append({
                            "date": datetime.now().isoformat(),
                            "type": "status_update",
                            "school": school_name,
                            "details": f"Status changed to {new_status}"
                        })
                        self.save_data()
                
                with col3:
                    if st.button("📞 Log Contact", key=f"contact_{school_name}"):
                        info["last_contacted"] = datetime.now().isoformat()
                        self.save_data()
                        st.success(f"Contact logged for {school_name}")
                
                # Notes section
                st.text_area("Notes", value=info["notes"], key=f"notes_{school_name}", height=100)
                
                # Add new note
                new_note = st.text_input("Add note", key=f"new_note_{school_name}")
                if st.button("Add Note", key=f"add_note_{school_name}"):
                    if new_note:
                        date_str = datetime.now().strftime("%Y-%m-%d %I:%M %p")
                        info["notes"] += f"\n[{date_str}] {new_note}"
                        self.save_data()
                        st.rerun()
    
    def render_contacts(self):
        """Render contacts management"""
        st.title("👥 Contacts Management")
        
        # Add new contact
        if st.button("➕ Add New Contact"):
            st.session_state.show_add_contact = True
        
        if st.session_state.show_add_contact:
            with st.form("add_contact_form"):
                st.subheader("Add New Contact")
                
                col1, col2 = st.columns(2)
                with col1:
                    contact_name = st.text_input("Name*")
                    phone = st.text_input("Phone")
                    email = st.text_input("Email")
                
                with col2:
                    affiliation = st.text_input("School/Organization*")
                    role = st.selectbox("Role", ["parent", "staff", "admin", "other"])
                
                notes = st.text_area("Initial Notes")
                
                col1, col2 = st.columns(2)
                with col1:
                    if st.form_submit_button("Add Contact"):
                        if contact_name and affiliation:
                            self.data["contacts"][contact_name] = {
                                "phone": phone,
                                "email": email,
                                "affiliation": affiliation,
                                "role": role,
                                "notes": notes,
                                "interactions": []
                            }
                            self.save_data()
                            st.session_state.show_add_contact = False
                            st.rerun()
                
                with col2:
                    if st.form_submit_button("Cancel"):
                        st.session_state.show_add_contact = False
                        st.rerun()
        
        # Display contacts
        for contact_name, info in self.data["contacts"].items():
            with st.expander(f"{contact_name} - {info['affiliation']}"):
                col1, col2 = st.columns(2)
                
                with col1:
                    st.write(f"**Role:** {info['role']}")
                    st.write(f"**Phone:** {info['phone']}")
                    st.write(f"**Email:** {info['email']}")
                
                with col2:
                    # Log interaction
                    st.subheader("Log Interaction")
                    interaction_type = st.selectbox(
                        "Type",
                        ["call", "email", "text", "meeting"],
                        key=f"int_type_{contact_name}"
                    )
                    
                    summary = st.text_area("Summary", key=f"summary_{contact_name}", height=100)
                    
                    if st.button("Log Interaction", key=f"log_{contact_name}"):
                        if summary:
                            interaction = {
                                "date": datetime.now().isoformat(),
                                "type": interaction_type,
                                "summary": summary
                            }
                            info["interactions"].append(interaction)
                            
                            # Also add to activity log
                            self.data["activity_log"].append({
                                "date": interaction["date"],
                                "type": "contact_interaction",
                                "contact": contact_name,
                                "details": summary
                            })
                            
                            self.save_data()
                            st.success("Interaction logged!")
                            st.rerun()
                
                # Previous interactions
                if info["interactions"]:
                    st.subheader("Previous Interactions")
                    for interaction in reversed(info["interactions"][-5:]):
                        date = datetime.fromisoformat(interaction["date"]).strftime("%m/%d %I:%M %p")
                        st.info(f"**{date} - {interaction['type']}:** {interaction['summary']}")
    
    def render_resources(self):
        """Render resources page"""
        st.title("📚 JCPS Transfer Resources")
        
        # Resource categories as tabs
        tab1, tab2, tab3, tab4, tab5 = st.tabs([
            "🏫 Official JCPS",
            "📊 School Ratings",
            "👥 Parent Groups",
            "📚 Tutoring",
            "🏠 Alternatives"
        ])
        
        with tab1:
            st.subheader("Official JCPS Transfer Resources")
            
            col1, col2 = st.columns(2)
            with col1:
                st.markdown("""
                **📋 Online Application Portal**
                - [Transfer Application](https://apps.jefferson.kyschools.us/studentassignment/transferonlineapplication/)
                
                **📞 Office of School Choice**
                - Phone: (502) 485-6250
                - Email: jcpsschoolchoice@jefferson.kyschools.us
                - Address: 4309 Bishop Lane, Louisville, KY 40218
                """)
            
            with col2:
                st.markdown("""
                **⏰ 2025-26 Transfer Window**
                - Opens: May 5, 2025
                - Closes: March 6, 2026
                
                **⚠️ Key Points**
                - Transfers based solely on available seats
                - No transportation provided
                - Must renew annually
                - Cannot use for magnet schools
                """)
            
            if st.button("🌐 Open Transfer Portal"):
                webbrowser.open("https://apps.jefferson.kyschools.us/studentassignment/transferonlineapplication/")
        
        with tab2:
            st.subheader("School Rating & Review Sites")
            
            col1, col2 = st.columns(2)
            with col1:
                st.markdown("""
                **🏫 GreatSchools.org**
                - [Louisville Schools](https://www.greatschools.org/kentucky/louisville/)
                - Ratings based on academics and equity
                
                **📊 JCPS School Profiles**
                - [Official Data](https://www.jefferson.kyschools.us/departments/data-management-research/school-profiles)
                - Test scores, demographics, attendance
                """)
            
            with col2:
                st.markdown("""
                **⭐ Niche.com**
                - [Best Elementary Schools](https://www.niche.com/k12/search/best-public-elementary-schools/m/louisville-metro-area/)
                - User reviews and rankings
                
                **📈 State Report Cards**
                - Kentucky Department of Education
                - Annual performance metrics
                """)
        
        with tab3:
            st.subheader("Parent Support Groups")
            
            st.markdown("""
            **📱 Facebook Groups**
            - [JCPS Parents](https://www.facebook.com/groups/337907878132865/)
            - [Official JCPS Page](https://www.facebook.com/JCPSKY/)
            
            **🏛️ Organizations**
            - 15th District PTA - Advocates for Jefferson County children
            - Family Resource Centers (FRYSCs) - Support services
            
            **💡 Networking Tips**
            - Post about needing transfer spots
            - Ask about specific teacher recommendations
            - Network with parents leaving schools
            - Join school-specific parent groups
            """)
        
        with tab4:
            st.subheader("Tutoring & Supplemental Education")
            
            col1, col2 = st.columns(2)
            with col1:
                st.markdown("""
                **🆓 FREE JCPS Resources**
                - FEV Tutor: 24/7 online tutoring via Clever
                - [Homework Help](https://www.jefferson.kyschools.us/student-support/homework-help)
                - Covers 200+ courses including test prep
                
                **📍 Elev8 Learning Centers**
                - West End: 2500 West Broadway
                - Hours: 2:30-7:30 PM school days
                - Free with transportation!
                """)
            
            with col2:
                st.markdown("""
                **💰 Paid Options**
                - Sylvan Learning Center
                - Kumon Math & Reading
                - Mathnasium
                - Private tutors ($25-60/hour)
                
                **🎯 Assessment Centers**
                - Get formal learning assessments
                - Document academic needs
                - Support transfer applications
                """)
        
        with tab5:
            st.subheader("Alternative Education Options")
            
            # Private schools
            st.markdown("### 🏫 Private Schools")
            col1, col2 = st.columns(2)
            with col1:
                st.markdown("""
                **Top Schools**
                - Louisville Collegiate School
                - Kentucky Country Day School
                - Francis Parker School
                - Highlands Latin School
                """)
            
            with col2:
                st.markdown("""
                **💰 Financial Info**
                - Average tuition: $12,966/year
                - 30-40% of families receive aid
                - FACTS Financial Aid system
                - Early decision: December 18
                """)
            
            # Homeschooling
            st.markdown("### 🏠 Homeschooling")
            st.markdown("""
            **📋 Kentucky Requirements**
            - Notify superintendent within 10 days
            - 170 instructional days minimum
            - 1,062 instructional hours annually
            - Keep attendance records
            - NO standardized testing required!
            
            **📚 Resources**
            - [KY Dept of Education](https://www.education.ky.gov/federal/fed/Pages/Home-School.aspx)
            - [HSLDA Kentucky](https://hslda.org/legal/kentucky)
            - Local homeschool co-ops and support groups
            """)
    
    def render_analytics(self):
        """Render analytics and insights"""
        st.title("📈 Analytics & Insights")
        
        # Timeline visualization
        st.subheader("📅 Transfer Timeline")
        
        # Create timeline data
        timeline_events = []
        
        # Add key dates
        timeline_events.append({
            "Date": datetime.now(),
            "Event": "Today",
            "Type": "Current"
        })
        
        timeline_events.append({
            "Date": datetime(2025, 8, 15),
            "Event": "School Starts",
            "Type": "Deadline"
        })
        
        # Add activity log events
        for activity in self.data["activity_log"][-10:]:
            timeline_events.append({
                "Date": datetime.fromisoformat(activity["date"]),
                "Event": activity.get("details", activity["type"]),
                "Type": "Activity"
            })
        
        if timeline_events:
            df_timeline = pd.DataFrame(timeline_events)
            
            fig = px.scatter(df_timeline, 
                           x="Date", 
                           y="Type",
                           text="Event",
                           color="Type",
                           title="Activity Timeline",
                           height=300)
            
            fig.update_traces(textposition="top center")
            st.plotly_chart(fig, use_container_width=True)
        
        # School status distribution
        col1, col2 = st.columns(2)
        
        with col1:
            st.subheader("🏫 School Status Distribution")
            if self.data["target_schools"]:
                status_counts = {}
                for school in self.data["target_schools"].values():
                    status = school["status"]
                    status_counts[status] = status_counts.get(status, 0) + 1
                
                fig = px.pie(values=list(status_counts.values()),
                           names=list(status_counts.keys()),
                           title="Target Schools by Status")
                st.plotly_chart(fig, use_container_width=True)
        
        with col2:
            st.subheader("📋 Action Items Progress")
            if self.data["action_items"]:
                completed = sum(1 for item in self.data["action_items"] if item["completed"])
                incomplete = len(self.data["action_items"]) - completed
                
                fig = go.Figure(data=[
                    go.Bar(name='Completed', x=['Actions'], y=[completed], marker_color='green'),
                    go.Bar(name='Remaining', x=['Actions'], y=[incomplete], marker_color='orange')
                ])
                fig.update_layout(barmode='stack', title="Action Items Status")
                st.plotly_chart(fig, use_container_width=True)
        
        # Priority analysis
        st.subheader("🎯 Priority Analysis")
        
        priority_data = {
            "high": {"schools": 0, "actions": 0},
            "medium": {"schools": 0, "actions": 0},
            "low": {"schools": 0, "actions": 0}
        }
        
        for school in self.data["target_schools"].values():
            priority_data[school["priority"]]["schools"] += 1
        
        for action in self.data["action_items"]:
            if not action["completed"]:
                priority_data[action["priority"]]["actions"] += 1
        
        col1, col2, col3 = st.columns(3)
        
        with col1:
            st.metric("🔴 High Priority",
                     f"{priority_data['high']['schools']} schools, {priority_data['high']['actions']} actions")
        
        with col2:
            st.metric("🟡 Medium Priority",
                     f"{priority_data['medium']['schools']} schools, {priority_data['medium']['actions']} actions")
        
        with col3:
            st.metric("🔵 Low Priority",
                     f"{priority_data['low']['schools']} schools, {priority_data['low']['actions']} actions")
        
        # Contact frequency
        st.subheader("📞 Contact Frequency")
        if self.data["contacts"]:
            contact_freq = []
            for contact, info in self.data["contacts"].items():
                contact_freq.append({
                    "Contact": contact,
                    "Interactions": len(info["interactions"]),
                    "Role": info["role"]
                })
            
            df_contacts = pd.DataFrame(contact_freq)
            if not df_contacts.empty:
                fig = px.bar(df_contacts, 
                           x="Contact", 
                           y="Interactions",
                           color="Role",
                           title="Interaction Count by Contact")
                st.plotly_chart(fig, use_container_width=True)
    
    def run(self):
        """Main app runner"""
        # Render sidebar
        self.render_sidebar()
        
        # Render selected page
        if st.session_state.page == 'dashboard':
            self.render_dashboard()
        elif st.session_state.page == 'actions':
            self.render_action_items()
        elif st.session_state.page == 'schools':
            self.render_schools()
        elif st.session_state.page == 'contacts':
            self.render_contacts()
        elif st.session_state.page == 'resources':
            self.render_resources()
        elif st.session_state.page == 'analytics':
            self.render_analytics()
        
        # Footer
        st.markdown("---")
        st.markdown(
            """
            <div style='text-align: center; color: #666;'>
            🎯 School Transfer Mission Control | 
            Stay organized, stay persistent | 
            Good luck! 💪
            </div>
            """,
            unsafe_allow_html=True
        )

if __name__ == "__main__":
    app = SchoolTransferDashboard()
    app.run()