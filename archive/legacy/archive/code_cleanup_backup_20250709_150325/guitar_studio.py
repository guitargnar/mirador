#!/usr/bin/env python3
import argparse
import json
import os
import sys
import time
from pathlib import Path

# Add parent directory to path so we can import from framework.py
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from ai_framework.framework import AIFramework

class GuitarStudio:
    def __init__(self):
        self.framework = AIFramework()
        self.practice_history = {}
        self.history_file = "ai_framework/knowledge_base/guitar_practice_history.json"
        
        # Load practice history if exists
        os.makedirs(os.path.dirname(self.history_file), exist_ok=True)
        if os.path.exists(self.history_file):
            with open(self.history_file, 'r') as f:
                self.practice_history = json.load(f)
    
    def _save_history(self):
        """Save practice history to JSON file"""
        with open(self.history_file, 'w') as f:
            json.dump(self.practice_history, f, indent=2)
    
    def generate_exercise(self, technique, difficulty, tuning="standard"):
        """Generate a practice exercise for a specific technique"""
        # Check history for progression
        history_context = ""
        if technique in self.practice_history:
            history_context = f"""
Practice History for {technique}:
Last difficulty: {self.practice_history[technique].get('last_difficulty', 'N/A')}
Exercises completed: {self.practice_history[technique].get('completed', 0)}
Areas for improvement: {self.practice_history[technique].get('improvement_areas', 'N/A')}
"""
        
        prompt = f"""Create a guitar practice exercise for technical death metal:

Technique: {technique}
Difficulty: {difficulty}/10
Tuning: {tuning}
{history_context}

Include:
1. Complete tablature in ASCII format
2. Explanation of the theoretical concepts involved
3. Practice tips and common mistakes to avoid
4. Suggested metronome speeds for practice progression
5. How this builds on previous exercises (if applicable)
"""
        
        result = self.framework.run_persona("guitar-expert", prompt)
        
        # Update practice history
        if technique not in self.practice_history:
            self.practice_history[technique] = {
                "completed": 0,
                "last_difficulty": difficulty,
                "improvement_areas": "",
                "exercises": []
            }
        
        # Add this exercise to history
        exercise_summary = f"Exercise at difficulty {difficulty} on {time.strftime('%Y-%m-%d')}"
        self.practice_history[technique]["exercises"].append(exercise_summary)
        self.practice_history[technique]["completed"] += 1
        self.practice_history[technique]["last_difficulty"] = difficulty
        self._save_history()
        
        return result
    
    def analyze_playing(self, description, recording_notes=None):
        """Analyze playing and identify theoretical concepts"""
        prompt = f"""Analyze this guitar playing and identify theoretical concepts:

Playing Description: {description}
Recording Notes: {recording_notes or "N/A"}

Please provide:
1. Scales, modes, or tonal centers being used
2. Theoretical names for the techniques employed
3. Related guitar techniques that build on this style
4. Suggestions for theoretical concepts to explore next
5. Example tablature showing how to expand on this style
"""
        return self.framework.run_persona("guitar-expert", prompt)
    
    def generate_riff(self, style, length, tuning="standard"):
        """Generate a guitar riff in a specific style"""
        prompt = f"""Create a {length}-bar guitar riff in {style} style:

Tuning: {tuning}

Include:
1. Complete tablature in ASCII format
2. Brief explanation of the riff's structure
3. Key and scale information
4. Technique tips for performing the riff
5. Suggested backing rhythm/drums feel
"""
        return self.framework.run_persona("guitar-expert", prompt)
    
    def explain_technique(self, technique_name):
        """Get detailed explanation of a technique"""
        prompt = f"""Provide a detailed explanation of the {technique_name} guitar technique:

Include:
1. What the technique is and how it's performed
2. Common applications in technical death metal
3. Step-by-step practice guide with example exercises
4. Notable guitarists who use this technique effectively
5. Example tablature demonstrating the technique
"""
        return self.framework.run_persona("guitar-expert", prompt)

    def analyze_progression(self, chords, key=None):
        """Analyze a chord progression"""
        prompt = f"""Analyze this chord progression: {chords}
{"Key: " + key if key else ""}

Include:
1. Roman numeral analysis
2. Functional harmony explanation
3. Common genres where this progression is used
4. Suggestions for lead playing over this progression
5. Potential variations or extensions of this progression
"""
        return self.framework.run_persona("guitar-expert", prompt)
    
    def show_history(self, technique=None):
        """Display practice history for a technique or all techniques"""
        if not self.practice_history:
            print("No practice history found.")
            return
            
        if technique:
            if technique in self.practice_history:
                print(f"\nPractice History for {technique}:")
                print(f"Exercises completed: {self.practice_history[technique]['completed']}")
                print(f"Last difficulty: {self.practice_history[technique]['last_difficulty']}")
                print(f"Areas for improvement: {self.practice_history[technique].get('improvement_areas', 'N/A')}")
                print("\nExercise History:")
                for ex in self.practice_history[technique].get('exercises', []):
                    print(f"- {ex}")
            else:
                print(f"No history found for {technique}")
        else:
            print("\nAll Practice History:")
            for tech, data in self.practice_history.items():
                print(f"\n{tech}:")
                print(f"Exercises completed: {data['completed']}")
                print(f"Last difficulty: {data['last_difficulty']}")

def main():
    parser = argparse.ArgumentParser(description="Guitar Practice Studio")
    subparsers = parser.add_subparsers(dest='command', help='Command to run')
    
    # Exercise command
    exercise_parser = subparsers.add_parser('exercise', help='Generate practice exercise')
    exercise_parser.add_argument('--technique', '-t', required=True, help='Guitar technique to practice')
    exercise_parser.add_argument('--difficulty', '-d', type=int, default=7, help='Difficulty level (1-10)')
    exercise_parser.add_argument('--tuning', default='standard', help='Guitar tuning')
    
    # Analyze command
    analyze_parser = subparsers.add_parser('analyze', help='Analyze playing style')
    analyze_parser.add_argument('--description', '-d', required=True, help='Description of playing to analyze')
    analyze_parser.add_argument('--notes', '-n', help='Additional notes or details')
    
    # Riff command
    riff_parser = subparsers.add_parser('riff', help='Generate a guitar riff')
    riff_parser.add_argument('--style', '-s', required=True, help='Style of music')
    riff_parser.add_argument('--length', '-l', type=int, default=4, help='Length of riff in bars')
    riff_parser.add_argument('--tuning', '-t', default='standard', help='Guitar tuning')
    
    # Technique command
    technique_parser = subparsers.add_parser('technique', help='Explain a guitar technique')
    technique_parser.add_argument('--name', '-n', required=True, help='Name of technique')
    
    # Progression command
    progression_parser = subparsers.add_parser('progression', help='Analyze chord progression')
    progression_parser.add_argument('--chords', '-c', required=True, help='Chord progression (space separated)')
    progression_parser.add_argument('--key', '-k', help='Key of progression')
    
    # History command
    history_parser = subparsers.add_parser('history', help='Show practice history')
    history_parser.add_argument('--technique', '-t', help='Specific technique to show history for')
    
    args = parser.parse_args()
    studio = GuitarStudio()
    
    if args.command == 'exercise':
        studio.generate_exercise(args.technique, args.difficulty, args.tuning)
    elif args.command == 'analyze':
        studio.analyze_playing(args.description, args.notes)
    elif args.command == 'riff':
        studio.generate_riff(args.style, args.length, args.tuning)
    elif args.command == 'technique':
        studio.explain_technique(args.name)
    elif args.command == 'progression':
        studio.analyze_progression(args.chords, args.key)
    elif args.command == 'history':
        studio.show_history(args.technique)
    else:
        print("No command specified. Use --help for usage information")
        
if __name__ == "__main__":
    main()
