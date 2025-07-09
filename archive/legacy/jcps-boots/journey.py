#!/usr/bin/env python3
"""
The Journey: A visual representation of the school transfer process
"""

import time
from rich.console import Console
from rich.panel import Panel
from rich.text import Text
from rich.align import Align
from rich.columns import Columns

console = Console()

def show_journey():
    """Display the journey from crisis to solution"""
    
    # Clear screen
    console.clear()
    
    # Title
    title = Text("THE SCHOOL TRANSFER JOURNEY", style="bold cyan")
    console.print(Panel(Align.center(title), box_characters="═"))
    console.print()
    
    # Stage 1: The Crisis
    crisis = Panel(
        "[red]SHELBY ACADEMY[/red]\n\n"
        "📊 6% Math Proficiency\n"
        "📉 28% Enrollment Decline\n"
        "😰 Ranked #1158/1230\n\n"
        "[dim]'What do I do?'[/dim]",
        title="[red]1. THE CRISIS[/red]",
        width=30
    )
    
    # Stage 2: The Search
    search = Panel(
        "[yellow]SEARCHING...[/yellow]\n\n"
        "🔍 School ratings\n"
        "📞 Endless calls\n"
        "📝 Scattered notes\n\n"
        "[dim]'There must be a way'[/dim]",
        title="[yellow]2. THE SEARCH[/yellow]",
        width=30
    )
    
    # Stage 3: The Solution
    solution = Panel(
        "[green]TRACKER BUILT[/green]\n\n"
        "📱 All info organized\n"
        "✅ Clear action steps\n"
        "🎯 Daily progress\n\n"
        "[dim]'Now I have a plan'[/dim]",
        title="[green]3. THE SOLUTION[/green]",
        width=30
    )
    
    # Stage 4: The Success
    success = Panel(
        "[bold green]TRANSFER APPROVED![/bold green]\n\n"
        "🎉 Better school found\n"
        "👨‍👩‍👧 Family relieved\n"
        "🤝 Helping others\n\n"
        "[dim]'We did it together'[/dim]",
        title="[bold green]4. THE SUCCESS[/bold green]",
        width=30
    )
    
    # Display stages
    stages = Columns([crisis, search, solution, success], equal=True, expand=True)
    console.print(stages)
    
    # Progress animation
    console.print("\n")
    with console.status("[cyan]Your journey begins...[/cyan]") as status:
        time.sleep(1)
        status.update("[yellow]Gathering resources...[/yellow]")
        time.sleep(1)
        status.update("[green]Building momentum...[/green]")
        time.sleep(1)
        status.update("[bold green]Success within reach![/bold green]")
        time.sleep(1)
    
    # Crossroads ASCII
    console.print("\n")
    crossroads = """
                           ║   ║
                     ╔═════╬═══╬═════╗
                     ║  BETTER FUTURE ║
                     ╚═════╬═══╬═════╝
                           ║   ║
                    ← OLD  ╫   ╫  NEW →
                     PATH  ║   ║  PATH
                           ╨   ╨
                          [YOU]
    """
    
    console.print(Panel(
        Align.center(crossroads),
        title="[cyan]THE CROSSROADS[/cyan]",
        subtitle="[dim]Choose your path[/dim]"
    ))
    
    # Final message
    console.print("\n")
    message = Text.from_markup(
        "[bold cyan]From one parent's crisis to a community solution.[/bold cyan]\n\n"
        "[green]Ready to start your journey?[/green]\n"
        "[yellow]Run: ./school_transfer_visual.py[/yellow]"
    )
    console.print(Panel(Align.center(message), box_characters="═"))

if __name__ == "__main__":
    show_journey()