# Portfolio Consolidation & Unified Dashboard Plan

## Executive Summary
This plan outlines the consolidation of Matthew Scott's project ecosystem into a unified portfolio and dashboard system, reducing code duplication by ~60% while preserving all functionality.

## Current State Analysis

### Project Inventory
1. **Mirador AI Framework** - Core AI orchestration system (80+ models)
2. **JCPS-Boots** - School transfer tracking system
3. **Productivity Tools** - Work optimization suite
4. **Advocates Dashboard** - Humana innovation tracking
5. **Job Tools** - Career optimization (JobCraft, portfolio)
6. **FretVision** - Guitar education platform
7. **Security/Web Tools** - Various utilities

### Identified Redundancies
- 3+ error handler implementations
- 4+ dashboard frameworks (Streamlit, Flask, Rich, custom)
- Multiple config management patterns
- Duplicate utility functions across projects
- Scattered documentation and assets

## Consolidation Architecture

### Phase 1: Core Infrastructure (Week 1)

#### 1.1 Unified Core Library
```
mirador-core/
├── __init__.py
├── setup.py
├── core/
│   ├── error_handling/
│   │   ├── circuit_breaker.py      # From /src/error_handler.py
│   │   ├── fallback_manager.py     # Consolidated fallback patterns
│   │   └── sanitizers.py           # Input/output sanitization
│   ├── config/
│   │   ├── manager.py              # Unified config management
│   │   ├── validators.py           # Config validation
│   │   └── templates/              # Default configs
│   └── persistence/
│       ├── session_manager.py      # From context_manager.py
│       ├── output_formatter.py     # Standardized outputs
│       └── memory_system.py        # From ai_memory/
```

#### 1.2 Shared Components
```
mirador-core/
├── dashboards/
│   ├── base.py                     # Abstract dashboard class
│   ├── terminal/
│   │   ├── rich_dashboard.py       # Rich-based UI
│   │   └── simple_dashboard.py     # Basic terminal UI
│   ├── web/
│   │   ├── streamlit_base.py       # Streamlit foundation
│   │   └── flask_base.py           # Flask foundation
│   └── exporters/
│       ├── pdf_exporter.py         # PDF generation
│       ├── html_exporter.py        # Static HTML
│       └── json_exporter.py        # Data export
├── integrations/
│   ├── ollama_client.py            # Unified Ollama interface
│   ├── browser_launcher.py         # Cross-platform browser
│   └── notification_system.py      # Alerts and notifications
└── utils/
    ├── validators.py               # Input validation
    ├── formatters.py               # Output formatting
    └── performance.py              # Metrics tracking
```

### Phase 2: Unified Dashboard Framework (Week 2)

#### 2.1 Master Dashboard Architecture
```python
# mirador_portfolio/dashboard.py
class MiradorPortfolioDashboard:
    """Unified dashboard aggregating all tools"""
    
    def __init__(self):
        self.modules = {
            'ai_orchestration': MiradorAIModule(),
            'school_tracker': JCPSTrackerModule(),
            'productivity': ProductivityModule(),
            'advocates': AdvocatesModule(),
            'career': CareerToolsModule(),
            'music': MusicToolsModule()
        }
        
    def render_portfolio_home(self):
        """Main portfolio overview"""
        return {
            'metrics': self._aggregate_metrics(),
            'recent_activity': self._get_recent_activity(),
            'quick_actions': self._get_quick_actions(),
            'project_cards': self._generate_project_cards()
        }
```

#### 2.2 Module Integration Pattern
```python
# Base module class for all project integrations
class PortfolioModule:
    """Abstract base for portfolio modules"""
    
    @abstractmethod
    def get_summary_metrics(self):
        """Return key metrics for dashboard display"""
        pass
        
    @abstractmethod
    def get_quick_actions(self):
        """Return available quick actions"""
        pass
        
    @abstractmethod
    def render_detail_view(self):
        """Render detailed module view"""
        pass
```

### Phase 3: Project Migration (Week 3)

#### 3.1 Migration Strategy
1. **Maintain Backward Compatibility**
   - Keep existing entry points with deprecation warnings
   - Redirect to new unified system
   - Preserve all command-line interfaces

2. **Incremental Updates**
   ```python
   # Example: Migrating mirador-smart-v2
   #!/bin/bash
   # Legacy entry point with deprecation notice
   echo "Note: This command will be deprecated. Use 'mirador ai' instead."
   exec mirador ai smart "$@"
   ```

3. **Data Migration**
   - Consolidate output directories
   - Standardize session tracking
   - Unified analytics database

#### 3.2 Unified CLI Interface
```bash
# New unified command structure
mirador --help                      # Show all available commands
mirador portfolio                   # Launch portfolio dashboard
mirador ai <chain> "prompt"         # AI orchestration
mirador school-tracker              # JCPS tracking
mirador productivity                # Productivity suite
mirador advocates                   # Humana dashboard
mirador career                      # Job tools
mirador music                       # Music tools

# Global options
mirador --dashboard                 # Web dashboard for all tools
mirador --export pdf                # Export portfolio to PDF
mirador --metrics                   # Show aggregated metrics
```

### Phase 4: Portfolio Showcase (Week 4)

#### 4.1 Web Portfolio Structure
```
portfolio-web/
├── index.html                      # Landing page
├── assets/
│   ├── css/
│   │   └── portfolio.css          # Unified styling
│   ├── js/
│   │   ├── dashboard.js           # Interactive elements
│   │   └── analytics.js           # Metrics visualization
│   └── img/
│       ├── project-screenshots/    # UI demonstrations
│       └── architecture-diagrams/  # Technical diagrams
├── projects/
│   ├── mirador-ai.html            # Project deep-dive
│   ├── jcps-tracker.html
│   ├── productivity-suite.html
│   └── [other projects].html
└── data/
    ├── metrics.json               # Performance data
    └── testimonials.json          # Success stories
```

#### 4.2 Portfolio Features
- **Interactive Project Cards**: Hover for quick stats, click for details
- **Live Metrics Dashboard**: Real-time performance indicators
- **Code Samples**: Syntax-highlighted examples
- **Video Demos**: Screen recordings of tools in action
- **Download Center**: Packaged tools for easy installation

## Implementation Timeline

### Week 1: Foundation
- [ ] Create mirador-core package structure
- [ ] Consolidate error handling implementations
- [ ] Extract common utilities and validators
- [ ] Set up unified configuration system

### Week 2: Dashboard Framework
- [ ] Build base dashboard classes
- [ ] Create terminal and web UI adapters
- [ ] Implement module integration pattern
- [ ] Develop unified metrics system

### Week 3: Migration
- [ ] Update mirador project to use core
- [ ] Migrate JCPS-boots to new structure
- [ ] Integrate productivity tools
- [ ] Update all documentation

### Week 4: Portfolio Polish
- [ ] Create web portfolio interface
- [ ] Generate project showcases
- [ ] Add interactive demonstrations
- [ ] Deploy to GitHub Pages

## Success Metrics

1. **Code Reduction**: Target 60% reduction in duplicate code
2. **Performance**: Maintain or improve current performance
3. **Usability**: Single entry point for all tools
4. **Portfolio Impact**: Professional showcase ready for VP presentations

## Risk Mitigation

1. **Backward Compatibility**: Maintain all existing interfaces
2. **Testing**: Comprehensive test suite before migration
3. **Documentation**: Update all docs during migration
4. **Rollback Plan**: Git tags at each phase for easy reversion

## Next Steps

1. Review and approve this plan
2. Create feature branch: `feature/portfolio-consolidation`
3. Begin Phase 1 implementation
4. Weekly progress reviews

This consolidation will transform your impressive but scattered toolkit into a cohesive, professional portfolio that demonstrates enterprise-grade thinking while maintaining the personal touch that makes your work unique.