# Cross-Domain Prompt Library

This library contains optimized prompts for cross-domain chains, showing how to effectively combine multiple domain expertise.

## Guitar Teacher Empire

### Complete Business System
```
Create a comprehensive business and curriculum plan for a guitar teaching business focusing on [LEVEL/STYLE], including curriculum structure, lesson formats, business model, pricing strategy, marketing approach, and scaling plan.
```

### Specialized Teaching Business
```
Design a specialized guitar teaching business focused exclusively on [TECHNIQUE/STYLE], including curriculum development, expertise positioning, business model, premium pricing strategy, and authority-building content plan.
```

### Online Guitar Education
```
Create a complete system for an online guitar education business specializing in [NICHE], including course structure, technology requirements, membership model, marketing strategy, and community building approach.
```

## Creator Financial Freedom

### Content Creator Independence
```
Create a comprehensive plan for a content creator in [NICHE] to achieve financial independence through content and digital products, including content strategy, audience building, monetization methods, and wealth-building systems.
```

### Expert to Wealthy Creator
```
Design a 3-year plan for a [PROFESSION] expert to build a content-based business that generates financial freedom, including authority positioning, audience building, product ecosystem, and investment strategy.
```

### Monetized Creative Practice
```
Create a strategy for a [CREATIVE PROFESSION] to build financial independence through their creative work, including portfolio development, audience building, multiple revenue streams, and investment approach.
```

## Lifestyle Design System

### Digital Nomad Blueprint
```
Design a comprehensive lifestyle system for a [PROFESSION] that enables location independence, including remote work structure, time management, income strategy, expense optimization, and geographic transition plan.
```

### Freedom-Centered Lifestyle
```
Create an integrated lifestyle design system that prioritizes freedom and autonomy for a [PROFESSION], including time optimization, location flexibility, income strategies, and wealth building approach.
```

### Work-Optional Lifestyle
```
Design a comprehensive system for a [PROFESSION] to achieve a work-optional lifestyle within [TIMEFRAME], including income restructuring, expense optimization, investment strategy, and time reclamation tactics.
```

## Multi-Step Execution Process

For complex cross-domain projects, follow this process:

1. **First Domain Focus**: Run the first specialized chain to establish foundational elements
   ```
   mirador chain [first_domain_personas] "[first_domain_prompt]"
   ```

2. **Save Output**: Store the results in a file for reference
   ```
   mirador session XXXXXXXX-XXXXXX > domain1_output.md
   ```

3. **Second Domain Integration**: Run the second chain incorporating first domain insights
   ```
   mirador chain [second_domain_personas] "[second_domain_prompt referencing first output]"
   ```

4. **Iterative Refinement**: Continue this process across domains until the complete system is designed

This approach ensures each specialized domain builds upon previous work while maintaining cohesion across the entire system.