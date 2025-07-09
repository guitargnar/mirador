# Mirador Chain Catalog

This catalog documents specialized chain configurations across different domains. Each entry includes the chain name, description, personas involved, and example commands.

## Business Domain Chains

| Chain Name | Description | Personas | Example Command |
|------------|-------------|----------|----------------|
| Business Builder | Create comprehensive business strategy | creative_entrepreneur, content_creator | `mirador chain creative_entrepreneur content_creator "Create a business plan for an online coaching business"` |
| Market Analysis | Analyze market opportunities and competition | creative_entrepreneur, data_scientist | `mirador chain creative_entrepreneur data_scientist "Analyze the market for productivity software"` |
| Monetization Strategy | Develop revenue streams and pricing models | creative_entrepreneur, creative_entrepreneur | `mirador chain creative_entrepreneur creative_entrepreneur "Create monetization strategy for a guitar teaching business"` |
| Product Development | Design and develop new products | master_coder, creative_entrepreneur | `mirador chain master_coder creative_entrepreneur "Design a subscription-based learning platform"` |

## Content Domain Chains

| Chain Name | Description | Personas | Example Command |
|------------|-------------|----------|----------------|
| Content Empire | Content creation strategy and system | creative_entrepreneur, content_creator | `mirador chain creative_entrepreneur content_creator "Create a content strategy for a technical blog"` |
| Audience Growth | Strategies for audience building | creative_entrepreneur, content_creator | `mirador chain creative_entrepreneur content_creator "Create a strategy to grow an audience from zero to 10,000 followers"` |
| Content Calendar | Create structured content schedules | content_creator, task_planner | `mirador chain content_creator task_planner "Create a 90-day content calendar for a fitness influencer"` |

## Finance Domain Chains

| Chain Name | Description | Personas | Example Command |
|------------|-------------|----------|----------------|
| Wealth Acceleration | Strategies for wealth building | creative_entrepreneur, task_planner | `mirador chain creative_entrepreneur task_planner "Create a wealth-building plan for a tech professional"` |
| Investment Strategy | Develop investment frameworks | data_scientist, creative_entrepreneur | `mirador chain data_scientist creative_entrepreneur "Create an investment strategy for passive income"` |
| Financial Freedom | Path to financial independence | creative_entrepreneur, task_planner | `mirador chain creative_entrepreneur task_planner "Design a 5-year plan for financial freedom"` |

## Music Domain Chains

| Chain Name | Description | Personas | Example Command |
|------------|-------------|----------|----------------|
| Guitar Curriculum | Comprehensive guitar learning paths | guitar_expert, content_creator | `mirador chain guitar_expert content_creator "Create a progressive 12-week curriculum for advanced guitar techniques"` |
| Performance Training | Prepare for live performances | guitar_expert, task_planner | `mirador chain guitar_expert task_planner "Create a 30-day practice regimen for recording an album"` |
| Music Theory | Apply theoretical concepts to composition | guitar_expert, content_creator | `mirador chain guitar_expert content_creator "Create a practical guide for applying advanced harmony concepts"` |

## Productivity Domain Chains

| Chain Name | Description | Personas | Example Command |
|------------|-------------|----------|----------------|
| Time Liberation | Systems for maximizing productivity | task_planner, content_creator | `mirador chain task_planner content_creator "Create a comprehensive time management system"` |
| Automation System | Automate recurring workflows | master_coder, task_planner | `mirador chain master_coder task_planner "Design an automation system for a content creator"` |
| Focus Framework | Strategies for deep focus and flow | content_creator, task_planner | `mirador chain content_creator task_planner "Design a framework for achieving deep focus every day"` |

## Cross-Domain Chains

| Chain Name | Description | Domains | Implementation |
|------------|-------------|---------|---------------|
| Guitar Teacher Empire | Complete business system for guitar teachers | Music + Business | Run music domain chain for curriculum, then business domain chain for monetization |
| Creator Financial Freedom | Path to financial independence for creators | Content + Finance | Run content domain chain for strategy, then finance domain chain for monetization |
| Lifestyle Design System | Holistic system for ideal lifestyle | Productivity + Finance | Run productivity chain for time system, then finance chain for wealth building |

## Using This Catalog

To run any chain, simply copy the example command and customize the prompt for your specific needs:

```bash
mirador chain creative_entrepreneur content_creator "Your custom prompt here"
```

For cross-domain chains, run the component chains sequentially, using output from one as input to the next.

## Custom Chain Creation

You can create custom chains by combining any personas in the config.json file:

```bash
mirador chain <starting_persona> <ending_persona> "Your prompt here"
```

Experiment with different combinations to find the optimal chain for your specific use case.