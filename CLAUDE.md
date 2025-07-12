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
- ✅ Smart query routing with intent detection (regex-based, priority for technical queries)
- ✅ 9 chain types for different use cases
- ✅ Progressive enhancement streaming (<1s first token)
- ✅ Context accumulation across model chain (verified: `CONTEXT="$CONTEXT $RESPONSE"`)
- ✅ Personal context injection (user profile, time-of-day awareness)
- ✅ Constraint validation system (time, budget, energy limits)
- ✅ Production-ready REST API with Flask
- ✅ GraphQL interface with subscriptions
- ✅ WebSocket support for real-time streaming
- ✅ JWT authentication and rate limiting
- ✅ Redis caching layer
- ✅ Docker containerization
- ✅ Comprehensive test suite
- ✅ Python SDK/client library
- ✅ Session memory with SQLite persistence
- ✅ Feedback logging system (routing_feedback.log)

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
- Intent detection visualization (show which patterns matched)
- Query history with search
- Suggested prompts based on common patterns
- Format selection (quick/summary/detailed/export)
- Export capabilities (JSON, Markdown, PDF)
- Real-time display of which model is currently processing
- Token count and performance metrics display

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
- A/B testing interface for comparing chain outputs
- Custom dashboard layouts
- Collaborative sessions (multi-model dialogue)
- Voice input/output
- Keyboard shortcuts
- REPL-style interactive mode for conversations
- Custom constraint editor (time, budget, resources)
- Model performance comparison tools

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
--success: #10B981;      /* Green - for successful operations */
--warning: #F59E0B;      /* Amber - for warnings */
--error: #EF4444;        /* Red - for errors */
--info: #3B82F6;         /* Blue - for information */
```

### Visual Identity
- **Progress Indicators**: Show each model's contribution with color-coded sections
- **Model Cards**: Display base LLM, temperature, context window, specialty
- **Chain Visualization**: Animated flow showing data movement between models
- **Trust Indicators**: Local processing badge, privacy shield icon

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
- Model chain execution: 10-20s (3-4 models), 30-45s (5-6 models)
- 99.9% uptime
- Zero critical security issues
- Hardware utilization > 80% during processing

### User Metrics
- 10x increase in user adoption
- 80% feature discovery rate
- 5-star user satisfaction
- <5% error rate
- Average 5+ queries per session
- 70% of users customize constraints

### Business Metrics
- 100+ integrations
- 1000+ daily active users
- 50% conversion to paid tier
- 90% retention rate
- Enterprise adoption in regulated industries (healthcare, finance)
- Cost savings vs cloud AI: 90% reduction at scale

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
- Electron desktop app for non-technical users
- Dynamic model selection based on query embeddings
- Parallel model execution for independent steps

### Long Term (6-12 months)
- Multi-language support
- White-label solution
- Marketplace for chains and custom models
- Community model sharing
- Enterprise features (SSO, audit logs, compliance reports)
- Automatic feedback-based routing optimization
- Integration with internal knowledge bases (enterprise wikis, documents)
- On-premise deployment guide for enterprises

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

## 🏢 Enterprise Considerations

### Healthcare/Insurance Focus (e.g., Humana)
- **Compliance**: HIPAA-compliant local processing
- **Custom Models**: Domain-specific models for policy, claims, medical terminology
- **Integration**: Connect to internal systems while maintaining data locality
- **Audit Trail**: Complete logging of all queries and responses for compliance
- **Role-Based Access**: Different model chains for different employee roles

### Hardware Requirements
- **Minimum**: 16GB RAM, 100GB storage
- **Recommended**: 32GB RAM, 200GB SSD, Apple Silicon or NVIDIA GPU
- **Enterprise**: Dedicated server with 64GB+ RAM, multiple GPUs
- **Scaling**: Support for Ollama cluster deployment

### Change Management
- **Training Materials**: Interactive tutorials for non-technical users
- **Success Stories**: Document ROI and efficiency gains
- **Champions Program**: Identify and train power users
- **Gradual Rollout**: Start with pilot teams, expand based on success

---

Remember: The goal is to democratize AI orchestration while maintaining the power and flexibility that makes Mirador unique. Every decision should balance developer experience, user accessibility, and system performance. As noted by external analysis, Mirador represents "a paradigm shift in how one can leverage AI" by turning your desktop into "a mini AI department."