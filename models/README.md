# Mirador Model Library

This directory contains specialized AI models for the Mirador framework.

## Model Categories

### Core Models
- Context providers for maintaining conversation state
- Base models with framework-specific prompts

### Domain Models  
- Business and career planning
- Creative and artistic projects
- Technical problem solving
- Health and wellness optimization
- Financial planning
- Relationship dynamics

### Personal Context Models
- User-specific context models (customize for your needs)
- Example templates provided

## Creating Personal Models

To create models with your personal context:

1. Copy a template from `models/templates/`
2. Replace generic placeholders with your information
3. Create the model: `ollama create your_model -f your_modelfile`

## Privacy Note

The models in this repository are generic templates. Personal information should be added only to your local copies, never committed to version control.
