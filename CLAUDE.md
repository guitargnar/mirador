# CLAUDE.md - Mirador AI Framework Vision & Architecture

This file provides comprehensive guidance to Claude Code (claude.ai/code) for the Mirador AI Framework project.

## 🎯 Project Vision

Mirador is evolving from a powerful local AI orchestration CLI tool into a comprehensive AI platform with three core interfaces:
1. **CLI** - Command-line interface for developers and power users
2. **API** - RESTful/GraphQL/WebSocket APIs for integration and scalability  
3. **Web Dashboard** - Visual interface for broader accessibility and collaboration

### Core Philosophy
"Keep the CLI's power, add the API's scalability, and the web's accessibility."

## 🏗️ Current State (v5.0)

### Completed Features
- ✅ 80+ specialized Ollama models with diverse base LLMs
- ✅ Smart query routing with intent detection
- ✅ 9 chain types for different use cases
- ✅ Progressive enhancement streaming (<1s first token)
- ✅ Production-ready REST API with Flask
- ✅ GraphQL interface with subscriptions
- ✅ WebSocket support for real-time streaming
- ✅ JWT authentication and rate limiting
- ✅ Redis caching layer
- ✅ Docker containerization
- ✅ Comprehensive test suite
- ✅ Python SDK/client library

### Repository Structure
```
mirador/
├── bin/                    # CLI scripts (mirador-smart-v2, runners)
├── src/
│   ├── api/               # API implementation (Flask, GraphQL)
│   ├── streaming/         # Streaming orchestration
│   ├── ai_framework/      # Core AI logic
│   └── memory/            # Context management
├── models/                # Modelfiles for Ollama
├── tests/                 # Test suite
├── examples/              # Usage examples
├── docs/                  # Documentation
└── assets/               # Branding and visuals
```

## 🚀 Next Phase: Web Dashboard Implementation

### Phase 1: Foundation (Weeks 1-2)
**Goal**: Establish base web application structure

**Technical Stack**:
- Frontend: React 18+ with TypeScript
- Framework: Next.js 14 (SSR/SSG)
- State: TanStack Query + Zustand
- Styling: Tailwind CSS + Framer Motion
- Build: Vite/Turbopack

**Key Tasks**:
1. Create `web/` directory structure
2. Set up Next.js with TypeScript
3. Configure development environment
4. Implement design system (colors, typography, spacing)
5. Create base layout components
6. Set up routing structure

### Phase 2: Core UI Components (Weeks 3-4)
**Goal**: Build reusable component library

**Components**:
- QueryInput (smart search with intent preview)
- StreamingResponse (real-time updates)
- ChainVisualizer (flow diagrams)
- ModelCard (performance metrics)
- SessionHistory (conversation browser)
- ProgressIndicator (multi-stage)

**Architecture**:
- Atomic Design methodology
- Storybook for component development
- Accessibility-first (WCAG 2.1 AA)
- Responsive design (mobile-first)

### Phase 3: Query Interface (Weeks 5-6)
**Goal**: Implement core query functionality

**Features**:
- Smart search bar with autocomplete
- Intent detection visualization
- Query history with search
- Suggested prompts
- Format selection (quick/summary/detailed)
- Export capabilities

**Integration**:
- Connect to existing API endpoints
- WebSocket for streaming responses
- Progressive enhancement display
- Error handling and retry logic

### Phase 4: Visualization Suite (Weeks 7-8)
**Goal**: Create interactive visualizations

**Visualizations**:
1. **Chain Flow Diagram**
   - D3.js-based interactive graph
   - Real-time progress indicators
   - Model performance metrics
   - Clickable nodes for details

2. **Model Ecosystem Map**
   - Network graph of model relationships
   - Performance heatmaps
   - Usage statistics
   - Filtering and search

3. **Analytics Dashboard**
   - Usage patterns over time
   - Cost/performance optimization
   - Popular chains and queries
   - User engagement metrics

### Phase 5: Advanced Features (Weeks 9-10)
**Goal**: Add power-user features

**Features**:
- Visual chain builder (drag-and-drop)
- A/B testing interface
- Custom dashboard layouts
- Collaborative sessions
- Voice input/output
- Keyboard shortcuts

**Technical Challenges**:
- Real-time collaboration (CRDT/OT)
- Complex state management
- Performance optimization
- Cross-browser compatibility

### Phase 6: Production Readiness (Weeks 11-12)
**Goal**: Prepare for deployment

**Tasks**:
- Performance optimization
- Security audit
- Load testing
- Documentation
- CI/CD pipeline
- Monitoring setup

## 📐 Architecture Decisions

### Frontend Architecture
```
web/
├── app/                    # Next.js 14 app directory
│   ├── (auth)/            # Auth-protected routes
│   ├── api/               # API routes (BFF pattern)
│   ├── dashboard/         # Main dashboard
│   └── query/             # Query interface
├── components/            # Reusable components
│   ├── ui/               # Base UI components
│   ├── features/         # Feature-specific components
│   └── layouts/          # Layout components
├── lib/                   # Utilities and helpers
│   ├── api/              # API client
│   ├── hooks/            # Custom React hooks
│   └── stores/           # State management
├── styles/               # Global styles
└── public/               # Static assets
```

### State Management Strategy
```typescript
// Server State (TanStack Query)
- API responses
- Session data
- Model configurations
- Analytics data

// Client State (Zustand)
- UI preferences
- Active query
- Selected chain
- View modes

// Real-time State (WebSocket)
- Streaming responses
- Progress updates
- Collaborative cursors
```

### Component Patterns
1. **Compound Components** for complex UI
2. **Render Props** for flexible rendering
3. **Custom Hooks** for logic reuse
4. **Portal Pattern** for modals/tooltips
5. **Observer Pattern** for real-time updates

## 🔧 Development Guidelines

### Code Style
- **TypeScript**: Strict mode enabled
- **React**: Functional components with hooks
- **Styling**: Tailwind utility classes + CSS modules for complex styles
- **Testing**: Jest + React Testing Library + Playwright
- **Linting**: ESLint + Prettier

### Performance Standards
- First Contentful Paint < 1.5s
- Time to Interactive < 3s
- Lighthouse score > 90
- 60fps animations
- Bundle size < 200KB (initial)

### Accessibility Requirements
- WCAG 2.1 AA compliance
- Keyboard navigation
- Screen reader support
- High contrast mode
- Reduced motion support

### Security Considerations
- Content Security Policy
- XSS prevention
- CSRF protection
- Secure WebSocket connections
- Input sanitization

## 🎨 Design System

### Brand Colors
```css
--primary: #3B82F6;      /* Blue */
--secondary: #10B981;    /* Green */
--accent: #F59E0B;       /* Amber */
--background: #0F172A;   /* Dark blue */
--surface: #1E293B;      /* Lighter dark */
--text: #E2E8F0;        /* Light gray */
```

### Typography
- Headers: Inter or system-ui
- Body: Inter or system-ui
- Code: JetBrains Mono or monospace

### Spacing Scale
- 4px base unit
- Consistent 8-point grid
- Responsive spacing tokens

## 🔄 Integration Points

### API Communication
```typescript
// Query execution
POST /api/v5/query
WebSocket /api/v5/ws

// Chain management
GET /api/v5/chains
POST /api/v5/chains/{type}/run

// Model information
GET /api/v5/models
GET /api/v5/models/{name}

// Sessions
GET /api/v5/sessions
POST /api/v5/sessions
```

### Real-time Features
- WebSocket for streaming responses
- Server-Sent Events for progress
- GraphQL subscriptions for updates
- Optimistic UI updates

## 📈 Success Metrics

### Technical Metrics
- Page load time < 2s
- API response time < 100ms (cached)
- 99.9% uptime
- Zero critical security issues

### User Metrics
- 10x increase in user adoption
- 80% feature discovery rate
- 5-star user satisfaction
- <5% error rate

### Business Metrics
- 100+ integrations
- 1000+ daily active users
- 50% conversion to paid tier
- 90% retention rate

## 🚢 Deployment Strategy

### Development
```bash
npm run dev          # Start development server
npm run storybook    # Component development
npm run test        # Run tests
npm run build       # Production build
```

### Production
- Vercel/Netlify for frontend
- Docker Swarm/K8s for API
- Redis cluster for caching
- PostgreSQL for persistence
- CDN for static assets

## 📝 Version Control Best Practices

### Branch Strategy
- `main` - Production-ready code
- `develop` - Integration branch
- `feature/*` - New features
- `fix/*` - Bug fixes
- `chore/*` - Maintenance

### Commit Convention
```
type(scope): description

feat(web): add chain visualization component
fix(api): resolve WebSocket memory leak
docs(readme): update installation guide
```

### Pull Request Process
1. Create feature branch
2. Implement with tests
3. Update documentation
4. Request review
5. Merge after approval

## 🎯 Immediate Next Steps

1. **Set up web project structure**
   ```bash
   npx create-next-app@latest web --typescript --tailwind --app
   ```

2. **Install core dependencies**
   ```bash
   npm install @tanstack/react-query zustand framer-motion
   npm install -D @types/react @types/node jest @testing-library/react
   ```

3. **Create initial components**
   - Layout shell
   - Query input
   - Response display
   - Loading states

4. **Connect to API**
   - Set up API client
   - Test WebSocket connection
   - Implement auth flow

5. **Deploy preview**
   - Set up CI/CD
   - Deploy to Vercel
   - Share with team

## 🤝 Collaboration Guidelines

### For Contributors
- Read existing code before writing new code
- Follow established patterns
- Write tests for new features
- Update documentation
- Request reviews early

### For Reviewers
- Check for accessibility
- Verify responsive design
- Test error scenarios
- Ensure consistent styling
- Validate performance

## 🔮 Future Enhancements

### Short Term (3-6 months)
- Mobile app (React Native)
- Browser extension
- VS Code plugin
- Slack/Teams integration

### Long Term (6-12 months)
- Multi-language support
- White-label solution
- Marketplace for chains
- Community model sharing
- Enterprise features

## 📚 Resources

### Documentation
- [API Architecture](./API_ARCHITECTURE_ANALYSIS.md)
- [Model Ecosystem](./model_ecosystem_insights.md)
- [Testing Guide](./tests/TEST_EXECUTION_GUIDE.md)

### External Resources
- [Ollama Documentation](https://ollama.ai/docs)
- [React Documentation](https://react.dev)
- [Next.js Documentation](https://nextjs.org/docs)
- [WebSocket API](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket)

---

Remember: The goal is to democratize AI orchestration while maintaining the power and flexibility that makes Mirador unique. Every decision should balance developer experience, user accessibility, and system performance.