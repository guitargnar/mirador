# Mirador Domain-Specific Chains

This directory contains domain configurations for specialized chain executions across various domains.

## Quick Start

To access domain documentation and tools:

```bash
# View domain categories
~/mirador domains

# View domain configurations in a category
~/mirador domains music

# View a specific domain configuration
~/mirador domain music advanced_guitar_curriculum
```

## Domain Catalog

For a comprehensive list of all available chains across domains, see:
```bash
cat ~/ai_framework/domains/chain_catalog.md
```

## Domain Categories

- **Business**: Business strategy, market analysis, monetization, product development
- **Content**: Content creation, audience building, marketing strategies
- **Finance**: Wealth building, investment strategies, financial independence
- **Music**: Guitar techniques, music theory, performance training
- **Productivity**: Time management, focus systems, automation
- **Cross-Domain**: Multi-domain chains that combine expertise from multiple areas

## Using Domains

Domain configurations document proven chain combinations for specific use cases. Each configuration includes:

```json
{
  "name": "chain_name",
  "description": "What this chain does",
  "command": "The exact command to run this chain",
  "personas": ["persona1", "persona2"],
  "notes": "Usage tips and context"
}
```

To use a domain configuration, copy the command from its JSON file.

## Cross-Domain Chains

Cross-domain configurations represent multi-step processes that combine multiple specialized chains:

```json
{
  "name": "cross_domain_chain",
  "description": "Multi-domain process",
  "steps": [
    {
      "name": "step1",
      "domain": "domain1",
      "command": "command for first step",
      "personas": ["persona1", "persona2"]
    },
    {
      "name": "step2",
      "domain": "domain2",
      "command": "command for second step",
      "personas": ["persona3", "persona4"]
    }
  ]
}
```

Run each step sequentially, using output from one step as input to the next.

## Prompt Library

For specialized prompts by domain, see the `prompts` directory:

```bash
cat ~/ai_framework/domains/prompts/business.md
cat ~/ai_framework/domains/prompts/content.md
cat ~/ai_framework/domains/prompts/finance.md
cat ~/ai_framework/domains/prompts/music.md
cat ~/ai_framework/domains/prompts/productivity.md
cat ~/ai_framework/domains/prompts/cross_domain.md
```

## Custom Domain Chains

You can create custom chains by combining any personas in the config.json file:

```bash
~/mirador chain <starting_persona> <ending_persona> "Your prompt here"
```

After testing, document your custom chains in the appropriate domain directory.