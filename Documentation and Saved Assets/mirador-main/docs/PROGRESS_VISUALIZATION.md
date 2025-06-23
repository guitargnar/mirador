# Mirador Progress Visualization

This document explains the Progress Visualization feature in Mirador, which allows you to visualize how specialists transform outputs as they work through a chain.

## Overview

Progress Visualization provides real-time feedback on:

1. How each specialist is transforming the solution
2. The differences between each step in the chain
3. Time metrics for processing and overall execution
4. Contribution analysis showing what each specialist adds

## Features

### Terminal Visualization

When running chains in the terminal, you'll see:

- A progress bar showing overall chain completion
- Specialist transition animations showing hand-off between models
- "Thinking" animations showing when specialists are processing
- Diff visualizations highlighting changes between steps
- Timing information showing how long each specialist takes

### Summary Visualization

In the output summary files, you'll find:

- A "Chain Transformation Visualization" section
- Progress path showing the sequence of specialists
- Contribution analysis table with metrics for each specialist
- Word count and timing statistics

## Configuration

Visualization settings can be configured in the `config/config.json` file:

```json
"ui": {
  "visualization_enabled": true,
  "show_progress_bar": true,
  "show_transitions": true,
  "show_diff": true,
  "show_elapsed_time": true,
  "verbose_output": true
}
```

You can toggle these settings to customize your visualization experience:

- `visualization_enabled`: Master toggle for all visualization features
- `show_progress_bar`: Shows the progress bar during chain execution
- `show_transitions`: Shows animations between specialist transitions
- `show_diff`: Shows the differences between stages
- `show_elapsed_time`: Shows timing information
- `verbose_output`: Shows detailed specialist information

## Using Visualization in Python

When using the Python interface, you can toggle visualization:

```python
# Enable visualization
result = run_chain(prompt, models, visualize=True)

# Disable visualization
result = run_chain(prompt, models, visualize=False)
```

## Using Visualization in Bash

The bash scripts check your config settings automatically. You can also temporarily disable visualization by modifying the config file or setting:

```bash
# Temporarily disable visualization
export MIRADOR_VISUALIZATION=false
./src/chains/run_chain.sh "Your prompt" model1 model2
```

## Understanding the Visualization

### Progress Bar

The progress bar shows the current step in relation to the total chain length:

```
Progress: [==================        ] 60%
```

### Specialist Transition

When transitioning between specialists, you'll see which models are handing off work:

```
Transition: model1 → model2
○○○○ → ●●●●
```

### Diff Visualization

The diff visualization shows how each specialist transforms the output:

```
Contributions from model2:
- Added 245 words, removed 30 words
```

### Contribution Analysis

The summary includes a contribution analysis table:

| Step | Specialist | Content Length | Processing Time | Key Contribution |
|------|------------|----------------|-----------------|------------------|
| 0 | Initial Prompt | 15 words | - | Starting point |
| 1 | model1 | 250 words | 00:12 | Initial analysis |
| 2 | model2 | 420 words | 00:18 | Refinement and expansion |
| 3 | model3 | 650 words | 00:22 | Final integration |

## Tips for Using Visualizations

1. Use visualizations to understand which specialists contribute most to your solution
2. Compare timing information to optimize your chains
3. Study the diffs to see how each specialist transforms the content
4. Use the contribution analysis to identify which specialists are most valuable for specific tasks