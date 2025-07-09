# CLAUDE.md

This file provides guidance to Claude Code when working with the Productivity Tools + Mirador Integration project.

## Project Context

This is a strategic enterprise productivity platform disguised as simple Python scripts. The tools solve immediate pain points while positioning for larger organizational transformation through AI integration.

## Build/Test Commands

### Productivity Tools (Standalone)
```bash
# Basic tool execution
python3 meeting_notes_formatter.py
python3 email_action_parser.py
python3 cms_guidance_analyzer.py
python3 weekly_accomplishments_tracker.py
python3 star_ratings_analyzer.py
python3 productivity_suite.py

# Analytics and feedback
python3 analytics_tracker.py
python3 feedback_collector.py

# Integration check
python3 mirador_integration.py
```

### Mirador Integration
```bash
# Check Mirador availability
python3 mirador_integration.py

# Run enhanced tools (if Mirador available)
python3 productivity_suite.py --ai-enhanced

# Test specific integrations
python3 -c "from mirador_integration import check_mirador_integration; check_mirador_integration()"
```

## Code Style Guidelines

### Python Standards
- **No external dependencies** for core tools (critical for enterprise deployment)
- Use only Python 3.x standard library
- Clear function names that describe business value
- Comprehensive docstrings with examples
- Error handling that degrades gracefully

### Integration Patterns
- Always check for Mirador availability before enhancement
- Fail silently if AI features unavailable
- Maintain core functionality without AI
- Return both original and enhanced results

## Architecture Principles

1. **Simplicity First**: Tools must work immediately with zero setup
2. **Hidden Power**: Advanced features discovered through use
3. **Enterprise Ready**: Security, compliance, audit trails built-in
4. **Value Focused**: Every feature must save measurable time

## Strategic Considerations

When modifying these tools, consider:
- **Adoption Strategy**: Will this change make tools easier or harder to adopt?
- **Political Positioning**: Does this support the "accidental discovery" narrative?
- **Integration Path**: How does this prepare for future AI enhancement?
- **Risk Management**: Could this trigger security/compliance concerns?

## Testing Focus

### Core Functionality Tests
- Each tool processes sample data correctly
- Error handling for malformed input
- Output formats match business needs

### Integration Tests
- Tools work with and without Mirador
- Enhancement adds value without breaking base functionality
- Performance remains acceptable with AI processing

### User Journey Tests
- New user can run any tool in < 2 minutes
- Power user can chain tools together
- Analytics accurately track time savings

## Security & Compliance

- **No data transmission**: All processing stays local
- **No external dependencies**: Reduces attack surface
- **Audit trails**: Track usage without storing sensitive data
- **Generic implementations**: No organization-specific code in public repo

## Communication Style

When generating output or documentation:
- Be direct and value-focused
- Emphasize time savings and ROI
- Use concrete examples from real scenarios
- Avoid technical jargon unless necessary
- Support the "productivity transformation" narrative

## Hidden Features to Preserve

1. **Integration Discovery**: Option 6 in productivity_suite.py
2. **AI Readiness**: All tools structured for future enhancement
3. **Analytics Foundation**: Usage tracking for ROI demonstration
4. **Feedback Loop**: Continuous improvement mechanism

## Future Development Guidelines

### Phase 1 (Current): Individual Productivity
- Focus on immediate time savings
- Build user testimonials
- Track concrete metrics

### Phase 2: Team Adoption
- Add collaboration features
- Create shared templates
- Enable workflow automation

### Phase 3: AI Enhancement
- Integrate Mirador capabilities
- Add predictive features
- Build learning systems

### Phase 4: Platform Evolution
- Natural language interface
- Voice control
- Full enterprise integration

## Key Success Metrics

Track and optimize for:
1. Time to first value (< 2 minutes)
2. Daily time saved (3-4 hours)
3. User retention (weekly active use)
4. Organic sharing (viral coefficient)
5. ROI documentation ($ value created)

## Important: Maintain Strategic Positioning

These tools are positioned as:
- Personal productivity helpers (not enterprise software)
- Time-saving utilities (not AI platforms)
- Individual solutions (not organizational change)
- Simple Python scripts (not complex frameworks)

This positioning enables organic adoption while preparing for larger transformation.