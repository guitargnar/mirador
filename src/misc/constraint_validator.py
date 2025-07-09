#!/usr/bin/env python3
"""
Constraint Validation System for Mirador
Validates time, energy, and financial allocations in recommendations
"""

import re
import json
from typing import Dict, List, Tuple, Optional, Any
from dataclasses import dataclass
from datetime import datetime, timedelta

@dataclass
class TimeAllocation:
    """Represents a time allocation recommendation"""
    activity: str
    hours: float
    priority: str = "medium"
    frequency: str = "daily"  # daily, weekly, monthly
    flexibility: str = "fixed"  # fixed, flexible, optional

@dataclass
class FinancialConstraint:
    """Represents financial constraints"""
    monthly_income: float = 1650.0  # User's take-home
    equity_value: float = 91000.0
    emergency_reserve: float = 500.0
    discretionary_spending: float = 200.0

@dataclass
class EnergyBudget:
    """Represents energy allocation constraints"""
    total_daily_capacity: float = 10.0  # 1-10 scale
    morning_peak: float = 8.0
    afternoon_moderate: float = 6.0
    evening_low: float = 4.0
    high_energy_activities: List[str] = None
    
    def __post_init__(self):
        if self.high_energy_activities is None:
            self.high_energy_activities = [
                "work", "coursework", "innovation", "ai development", 
                "technical learning", "problem solving"
            ]

@dataclass
class ValidationResult:
    """Results of constraint validation"""
    is_valid: bool
    warnings: List[str]
    errors: List[str]
    suggestions: List[str]
    total_time_allocated: float
    energy_score: float
    financial_impact: float

class ConstraintValidator:
    """Validates recommendations against real-world constraints"""
    
    def __init__(self, 
                 financial_constraints: FinancialConstraint = None,
                 energy_budget: EnergyBudget = None,
                 work_hours: float = 8.0,
                 sleep_hours: float = 7.0):
        
        self.financial = financial_constraints or FinancialConstraint()
        self.energy = energy_budget or EnergyBudget()
        self.work_hours = work_hours
        self.sleep_hours = sleep_hours
        self.available_personal_hours = 24 - work_hours - sleep_hours  # 9 hours typical
        
    def extract_time_allocations(self, text: str) -> List[TimeAllocation]:
        """Extract time allocations from recommendation text"""
        allocations = []
        
        # Patterns to match time allocations
        patterns = [
            # "2 hours for coursework"
            r'(\d+(?:\.\d+)?)\s*hours?\s+(?:for|on|to|with)\s+([^,\n.]+)',
            # "allocate 1.5 hours to study"
            r'allocate\s+(\d+(?:\.\d+)?)\s*hours?\s+(?:for|to|on)\s+([^,\n.]+)',
            # "spend 30 minutes on planning"
            r'spend\s+(\d+(?:\.\d+)?)\s*(?:minutes?|mins?)\s+(?:on|with)\s+([^,\n.]+)',
            # "dedicate 2-3 hours daily to"
            r'dedicate\s+(\d+(?:\.\d+)?(?:-\d+(?:\.\d+)?)?)\s*hours?\s+(?:daily|weekly)?\s+(?:to|for)\s+([^,\n.]+)',
            # "X hours per day for Y"
            r'(\d+(?:\.\d+)?)\s*hours?\s+per\s+day\s+(?:for|on|to)\s+([^,\n.]+)'
        ]
        
        for pattern in patterns:
            matches = re.findall(pattern, text, re.IGNORECASE)
            for time_str, activity in matches:
                try:
                    # Handle ranges like "2-3 hours"
                    if '-' in time_str:
                        time_parts = time_str.split('-')
                        hours = float(time_parts[0])  # Use lower bound
                    else:
                        hours = float(time_str)
                    
                    # Convert minutes to hours if needed
                    if 'minute' in pattern or 'mins' in pattern:
                        hours = hours / 60.0
                    
                    # Clean activity name
                    activity_clean = re.sub(r'[^\w\s]', ' ', activity.strip())
                    activity_clean = re.sub(r'\s+', ' ', activity_clean).strip()
                    
                    # Determine frequency
                    frequency = "daily"
                    if "weekly" in text.lower() or "week" in activity.lower():
                        frequency = "weekly"
                    elif "monthly" in text.lower() or "month" in activity.lower():
                        frequency = "monthly"
                    
                    # Determine priority based on keywords
                    priority = "medium"
                    if any(word in activity.lower() for word in ["sage", "family", "emergency", "critical"]):
                        priority = "high"
                    elif any(word in activity.lower() for word in ["optional", "if time", "when possible"]):
                        priority = "low"
                    
                    allocations.append(TimeAllocation(
                        activity=activity_clean,
                        hours=hours,
                        priority=priority,
                        frequency=frequency
                    ))
                    
                except (ValueError, IndexError):
                    continue
        
        return allocations
    
    def extract_financial_mentions(self, text: str) -> List[float]:
        """Extract financial amounts mentioned in text"""
        amounts = []
        
        # Patterns for financial amounts
        patterns = [
            r'\$(\d{1,3}(?:,\d{3})*(?:\.\d{2})?)',  # modest income.00
            r'(\d{1,3}(?:,\d{3})*)\s*dollars?',     # 1650 dollars
            r'budget\s+of\s+\$?(\d{1,3}(?:,\d{3})*)', # budget of $500
        ]
        
        for pattern in patterns:
            matches = re.findall(pattern, text, re.IGNORECASE)
            for match in matches:
                try:
                    amount = float(match.replace(',', ''))
                    amounts.append(amount)
                except ValueError:
                    continue
        
        return amounts
    
    def calculate_energy_requirements(self, allocations: List[TimeAllocation]) -> float:
        """Calculate total energy requirements for allocations"""
        total_energy = 0.0
        
        for allocation in allocations:
            # Determine energy requirement based on activity type
            energy_per_hour = 3.0  # Default moderate energy
            
            activity_lower = allocation.activity.lower()
            
            # High energy activities
            if any(keyword in activity_lower for keyword in self.energy.high_energy_activities):
                energy_per_hour = 7.0
            # Low energy activities
            elif any(keyword in activity_lower for keyword in ["relax", "watch", "listen", "rest", "casual"]):
                energy_per_hour = 2.0
            # Medium energy activities
            elif any(keyword in activity_lower for keyword in ["meeting", "call", "review", "planning"]):
                energy_per_hour = 4.0
            
            total_energy += allocation.hours * energy_per_hour
        
        return total_energy
    
    def validate_recommendations(self, text: str) -> ValidationResult:
        """Validate a recommendation text against constraints"""
        allocations = self.extract_time_allocations(text)
        financial_mentions = self.extract_financial_mentions(text)
        
        warnings = []
        errors = []
        suggestions = []
        
        # Calculate totals
        daily_allocations = [a for a in allocations if a.frequency == "daily"]
        total_daily_hours = sum(a.hours for a in daily_allocations)
        
        weekly_allocations = [a for a in allocations if a.frequency == "weekly"]
        total_weekly_hours = sum(a.hours for a in weekly_allocations)
        effective_daily_from_weekly = total_weekly_hours / 7.0
        
        total_effective_daily = total_daily_hours + effective_daily_from_weekly
        
        # Time validation
        if total_effective_daily > self.available_personal_hours:
            errors.append(
                f"Time allocation exceeds available hours: {total_effective_daily:.1f}h "
                f"allocated vs {self.available_personal_hours:.1f}h available daily"
            )
            suggestions.append(
                "Consider reducing time allocations or making some activities weekly instead of daily"
            )
        elif total_effective_daily > self.available_personal_hours * 0.8:
            warnings.append(
                f"High time utilization: {total_effective_daily:.1f}h/{self.available_personal_hours:.1f}h "
                f"({(total_effective_daily/self.available_personal_hours)*100:.0f}%)"
            )
            suggestions.append("Build in buffer time for unexpected events and transitions")
        
        # Energy validation
        energy_required = self.calculate_energy_requirements(daily_allocations)
        max_sustainable_energy = self.energy.total_daily_capacity * 0.8  # 80% of max capacity
        
        if energy_required > max_sustainable_energy:
            errors.append(
                f"Energy requirements too high: {energy_required:.1f} vs sustainable {max_sustainable_energy:.1f}"
            )
            suggestions.append("Move some high-energy activities to your peak energy times (mornings)")
        elif energy_required > max_sustainable_energy * 0.7:
            warnings.append(f"High energy utilization: {energy_required:.1f}/{max_sustainable_energy:.1f}")
        
        # Financial validation
        total_financial_impact = sum(financial_mentions)
        if total_financial_impact > self.financial.discretionary_spending:
            if total_financial_impact > self.financial.monthly_income * 0.1:  # More than 10% of income
                errors.append(
                    f"Financial impact too high: ${total_financial_impact:.0f} vs "
                    f"${self.financial.discretionary_spending:.0f} discretionary budget"
                )
            else:
                warnings.append(f"Above discretionary budget: ${total_financial_impact:.0f}")
        
        # Relationship balance check
        relationship_time = sum(
            a.hours for a in daily_allocations 
            if any(keyword in a.activity.lower() for keyword in ["sage", "katie", "family", "relationship"])
        )
        
        work_adjacent_time = sum(
            a.hours for a in daily_allocations
            if any(keyword in a.activity.lower() for keyword in ["course", "study", "ai", "innovation", "work"])
        )
        
        if work_adjacent_time > 0 and relationship_time / (work_adjacent_time + 0.1) < 0.3:
            warnings.append("Low relationship time relative to work/study activities")
            suggestions.append("Consider integrating family time with other activities or scheduling dedicated relationship time")
        
        # High priority activity check
        high_priority_time = sum(a.hours for a in daily_allocations if a.priority == "high")
        if high_priority_time < 2.0:
            warnings.append("Limited time allocated to high-priority activities")
        
        # Generate overall assessment
        is_valid = len(errors) == 0
        energy_score = min(10.0, max(0.0, 10.0 - (energy_required / max_sustainable_energy) * 5.0))
        financial_impact = total_financial_impact
        
        # Add positive suggestions if things look good
        if is_valid and len(warnings) <= 1:
            suggestions.append("Schedule looks balanced and achievable")
            if total_effective_daily < self.available_personal_hours * 0.6:
                suggestions.append("You have extra capacity - consider adding a growth activity")
        
        return ValidationResult(
            is_valid=is_valid,
            warnings=warnings,
            errors=errors,
            suggestions=suggestions,
            total_time_allocated=total_effective_daily,
            energy_score=energy_score,
            financial_impact=financial_impact
        )
    
    def generate_constraint_summary(self) -> Dict[str, Any]:
        """Generate a summary of current constraints for context"""
        return {
            "time_constraints": {
                "available_personal_hours": self.available_personal_hours,
                "work_hours": self.work_hours,
                "sleep_hours": self.sleep_hours
            },
            "financial_constraints": {
                "monthly_income": self.financial.monthly_income,
                "discretionary_budget": self.financial.discretionary_spending,
                "equity_available": self.financial.equity_value
            },
            "energy_profile": {
                "daily_capacity": self.energy.total_daily_capacity,
                "peak_hours": "morning",
                "high_energy_activities": self.energy.high_energy_activities
            },
            "relationship_priorities": ["sage", "katie"],
            "current_focus": ["degree_completion", "ai_innovation", "relationship_building"]
        }

def validate_text_file(file_path: str) -> ValidationResult:
    """Validate recommendations from a text file"""
    validator = ConstraintValidator()
    
    try:
        with open(file_path, 'r') as f:
            content = f.read()
        return validator.validate_recommendations(content)
    except FileNotFoundError:
        return ValidationResult(
            is_valid=False,
            warnings=[],
            errors=[f"File not found: {file_path}"],
            suggestions=[],
            total_time_allocated=0.0,
            energy_score=0.0,
            financial_impact=0.0
        )

def main():
    """CLI interface for constraint validator"""
    import sys
    
    if len(sys.argv) < 2:
        print("Usage: python3 constraint_validator.py <command> [args]")
        print("Commands:")
        print("  validate <file>    - Validate recommendations in file")
        print("  summary           - Show constraint summary")
        print("  test             - Run test validation")
        return
    
    command = sys.argv[1]
    validator = ConstraintValidator()
    
    if command == "validate" and len(sys.argv) > 2:
        file_path = sys.argv[2]
        result = validate_text_file(file_path)
        
        print(f"Validation Result: {'✓ VALID' if result.is_valid else '✗ INVALID'}")
        print(f"Time Allocated: {result.total_time_allocated:.1f}h/day")
        print(f"Energy Score: {result.energy_score:.1f}/10.0")
        print(f"Financial Impact: ${result.financial_impact:.0f}")
        
        if result.errors:
            print("\nERRORS:")
            for error in result.errors:
                print(f"  ✗ {error}")
        
        if result.warnings:
            print("\nWARNINGS:")
            for warning in result.warnings:
                print(f"  ⚠ {warning}")
        
        if result.suggestions:
            print("\nSUGGESTIONS:")
            for suggestion in result.suggestions:
                print(f"  💡 {suggestion}")
    
    elif command == "summary":
        summary = validator.generate_constraint_summary()
        print(json.dumps(summary, indent=2))
    
    elif command == "test":
        test_text = """
        Allocate 2 hours per day for coursework completion.
        Spend 1.5 hours daily with Child for quality time.
        Dedicate 1 hour to Partner for relationship building.
        Schedule 2 hours for AI innovation work.
        Plan 30 minutes for exercise and self-care.
        Budget $150 for educational resources.
        """
        
        result = validator.validate_recommendations(test_text)
        print(f"Test Result: {'✓ VALID' if result.is_valid else '✗ INVALID'}")
        print(f"Total Time: {result.total_time_allocated:.1f}h")
        print(f"Energy Score: {result.energy_score:.1f}/10")
        
        for warning in result.warnings:
            print(f"Warning: {warning}")
        for error in result.errors:
            print(f"Error: {error}")

if __name__ == "__main__":
    main()