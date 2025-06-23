# Mirador Architecture Diagrams

## 1. High-Level System Architecture (ASCII)

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                              MIRADOR AI ORCHESTRATION                            │
├─────────────────────────────────────────────────────────────────────────────────┤
│                                                                                  │
│  User Layer                                                                      │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐        │
│  │ Terminal │  │  Scripts │  │ Prompts  │  │   Web    │  │   API    │        │
│  │   CLI    │  │  (bash)  │  │ Library  │  │ Interface│  │ Endpoints│        │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘        │
│       │              │              │              │              │              │
│       └──────────────┴──────────────┴──────────────┴──────────────┘             │
│                                     │                                            │
│  ┌──────────────────────────────────▼──────────────────────────────────┐       │
│  │                         Query Processing Layer                        │       │
│  │  ┌────────────┐  ┌─────────────┐  ┌──────────────┐  ┌────────────┐ │       │
│  │  │   Query    │  │   Intent    │  │   Context    │  │   Chain    │ │       │
│  │  │  Parser    │─▶│  Analyzer   │─▶│  Enrichment  │─▶│  Planner   │ │       │
│  │  └────────────┘  └─────────────┘  └──────────────┘  └────────────┘ │       │
│  └──────────────────────────────────────────────────────────────────────┘       │
│                                     │                                            │
│  ┌──────────────────────────────────▼──────────────────────────────────┐       │
│  │                        Orchestration Engine                          │       │
│  │  ┌────────────┐  ┌─────────────┐  ┌──────────────┐  ┌────────────┐ │       │
│  │  │   Model    │  │   Chain     │  │   Context    │  │  Response  │ │       │
│  │  │  Selector  │  │  Executor   │  │ Propagator   │  │ Synthesizer│ │       │
│  │  └─────┬──────┘  └──────┬──────┘  └──────┬───────┘  └─────┬──────┘ │       │
│  │        │                 │                 │                 │        │       │
│  │  ┌─────▼─────────────────▼─────────────────▼─────────────────▼──────┐│       │
│  │  │                    Execution Pipeline                             ││       │
│  │  │  [Model 1] ──▶ [Context] ──▶ [Model 2] ──▶ [Context] ──▶ [Model N]││       │
│  │  └───────────────────────────────────────────────────────────────────┘│       │
│  └──────────────────────────────────────────────────────────────────────┘       │
│                                     │                                            │
│  ┌──────────────────────────────────▼──────────────────────────────────┐       │
│  │                         Model Repository                             │       │
│  │  ┌─────────────────────────┐  ┌─────────────────────────┐          │       │
│  │  │   Context Providers (5)  │  │   Domain Experts (28)   │          │       │
│  │  ├─────────────────────────┤  ├─────────────────────────┤          │       │
│  │  │ • matthew_context_v3     │  │ • financial_expert_v6   │          │       │
│  │  │ • personality_provider   │  │ • guitar_tone_architect │          │       │
│  │  │ • louisville_context     │  │ • music_industry_network│          │       │
│  │  │ • family_context         │  │ • career_transition_spec│          │       │
│  │  │ • goal_context           │  │ • tax_optimization_exp  │          │       │
│  │  └─────────────────────────┘  └─────────────────────────┘          │       │
│  │                                                                      │       │
│  │  ┌─────────────────────────┐  ┌─────────────────────────┐          │       │
│  │  │    Synthesizers (12)    │  │  Decision Makers (8)    │          │       │
│  │  ├─────────────────────────┤  ├─────────────────────────┤          │       │
│  │  │ • cross_model_synth      │  │ • decision_simplifier_v3│          │       │
│  │  │ • insight_aggregator     │  │ • action_prioritizer    │          │       │
│  │  │ • pattern_recognizer     │  │ • risk_assessor         │          │       │
│  │  │ • opportunity_mapper     │  │ • timeline_optimizer    │          │       │
│  │  └─────────────────────────┘  └─────────────────────────┘          │       │
│  └──────────────────────────────────────────────────────────────────────┘       │
│                                     │                                            │
│  ┌──────────────────────────────────▼──────────────────────────────────┐       │
│  │                       Infrastructure Layer                           │       │
│  │  ┌─────────────┐  ┌──────────────┐  ┌──────────────┐  ┌──────────┐│       │
│  │  │   Ollama    │  │   SQLite     │  │   Vector     │  │  Cache   ││       │
│  │  │  Inference  │  │   Memory     │  │   Store      │  │  Layer   ││       │
│  │  │   Engine    │  │   (22MB)     │  │ (Embeddings) │  │  (Redis) ││       │
│  │  └─────────────┘  └──────────────┘  └──────────────┘  └──────────┘│       │
│  │                                                                      │       │
│  │  ┌────────────────────────────────────────────────────────────────┐│       │
│  │  │                     Hardware Layer                              ││       │
│  │  │  Apple Silicon M3 Max - 48GB Unified Memory - 16 GPU Cores     ││       │
│  │  └────────────────────────────────────────────────────────────────┘│       │
│  └──────────────────────────────────────────────────────────────────────┘       │
└─────────────────────────────────────────────────────────────────────────────────┘
```

## 2. Chain Execution Flow (Mermaid)

```mermaid
graph TD
    A[User Query] --> B{Query Analyzer}
    B --> C[Intent Classification]
    B --> D[Complexity Assessment]
    B --> E[Domain Detection]
    
    C --> F[Chain Selector]
    D --> F
    E --> F
    
    F --> G{Chain Type}
    
    G -->|Simple| H[2-Model Chain]
    G -->|Complex| I[3-4 Model Chain]
    G -->|Expert| J[Domain-Specific Chain]
    
    H --> K[Context Provider]
    K --> L[Decision Maker]
    L --> Z[Response]
    
    I --> M[Context Provider]
    M --> N[Domain Expert 1]
    N --> O[Domain Expert 2]
    O --> P[Synthesizer]
    P --> Z
    
    J --> Q[Specialized Context]
    Q --> R[Expert Model]
    R --> S[Validator]
    S --> Z
    
    Z --> T{Quality Check}
    T -->|Pass| U[Format Output]
    T -->|Fail| V[Retry with Alt Chain]
    
    U --> W[User Response]
    V --> F
    
    style A fill:#2E86AB
    style W fill:#A23B72
    style F fill:#F18F01
    style Z fill:#C73E1D
```

## 3. Context Propagation Mechanism (ASCII)

```
┌─────────────────────────────────────────────────────────────────────┐
│                    CONTEXT PROPAGATION FLOW                          │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  Model 1 Output                                                      │
│  ┌─────────────────────────────────────────────────────────┐       │
│  │ Based on Matthew's context as a Risk Management         │       │
│  │ Professional earning $85k with a 7-year-old daughter... │       │
│  │                                                          │       │
│  │ Key Insights:                                            │       │
│  │ • Financial stability important for family              │       │
│  │ • Limited time due to parenting responsibilities        │       │
│  │ • Music career requires 3-year transition plan          │       │
│  └───────────────────┬─────────────────────────────────────┘       │
│                      │                                              │
│                      ▼                                              │
│  ┌─────────────────────────────────────────────────────────┐       │
│  │              SEMANTIC EXTRACTOR                          │       │
│  │  ┌─────────────┐  ┌──────────────┐  ┌───────────────┐  │       │
│  │  │   Entity    │  │   Concept    │  │    Priority   │  │       │
│  │  │ Recognition │  │  Extraction  │  │   Detection   │  │       │
│  │  └──────┬──────┘  └──────┬───────┘  └───────┬───────┘  │       │
│  │         │                 │                   │          │       │
│  │         ▼                 ▼                   ▼          │       │
│  │    [Matthew]        [Transition]         [3 years]      │       │
│  │    [$85k]          [Stability]          [Family]        │       │
│  │    [Aurora]        [Music Career]       [Limited Time]  │       │
│  └─────────────────────────┬───────────────────────────────┘       │
│                            │                                        │
│                            ▼                                        │
│  ┌─────────────────────────────────────────────────────────┐       │
│  │            CONTEXT BUILDER FOR MODEL 2                   │       │
│  │                                                          │       │
│  │  Previous Analysis Summary:                              │       │
│  │  ├─ Financial: $85k income, family obligations          │       │
│  │  ├─ Timeline: 3-year music transition goal              │       │
│  │  ├─ Constraints: Limited time, stability needs          │       │
│  │  └─ Priorities: Family first, gradual transition        │       │
│  │                                                          │       │
│  │  Model 2 Instructions:                                   │       │
│  │  "Building on the above context, analyze specific       │       │
│  │   financial strategies that maintain stability while     │       │
│  │   enabling music career development..."                  │       │
│  └─────────────────────────┬───────────────────────────────┘       │
│                            │                                        │
│                            ▼                                        │
│  Model 2 Input (with propagated context)                           │
│  ┌─────────────────────────────────────────────────────────┐       │
│  │ [System Prompt] + [Propagated Context] + [User Query]   │       │
│  └─────────────────────────────────────────────────────────┘       │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

## 4. Model Selection Algorithm (Mermaid)

```mermaid
flowchart TB
    subgraph Input
        Q[Query Text]
        H[Historical Performance]
        C[Current Context]
    end
    
    subgraph Embedding
        Q --> QE[Query Embedding]
        QE --> VS[Vector Store]
    end
    
    subgraph Scoring
        VS --> S1[Similarity Score]
        H --> S2[Performance Score]
        C --> S3[Context Score]
        
        S1 --> WS[Weighted Score]
        S2 --> WS
        S3 --> WS
    end
    
    subgraph Graph Building
        WS --> DG[Dependency Graph]
        DG --> N1[Node: Context Provider]
        DG --> N2[Node: Financial Expert]
        DG --> N3[Node: Decision Maker]
        DG --> N4[Node: Synthesizer]
        
        N1 --> E1[Edge: 0.8 probability]
        E1 --> N2
        N2 --> E2[Edge: 0.7 probability]
        E2 --> N3
        N3 --> E3[Edge: 0.9 probability]
        E3 --> N4
    end
    
    subgraph Path Finding
        DG --> D[Dijkstra's Algorithm]
        D --> P1[Path 1: CP→FE→DM]
        D --> P2[Path 2: CP→FE→SY→DM]
        D --> P3[Path 3: CP→DM]
        
        P1 --> TC[Time Constraint Check]
        P2 --> TC
        P3 --> TC
        
        TC --> OP[Optimal Path]
    end
    
    OP --> Output[Selected Chain]
    
    style Q fill:#2E86AB
    style Output fill:#A23B72
    style WS fill:#F18F01
    style OP fill:#C73E1D
```

## 5. Performance Architecture (ASCII)

```
┌─────────────────────────────────────────────────────────────────────┐
│                     PERFORMANCE OPTIMIZATION                         │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  Request Pipeline                                                    │
│  ┌─────────────┐     ┌─────────────┐     ┌─────────────┐          │
│  │   Incoming  │     │   Cache     │     │   Cache     │          │
│  │    Query    │────▶│   Check     │────▶│    Hit?     │          │
│  └─────────────┘     └─────────────┘     └──────┬──────┘          │
│                                                  │                  │
│                              ┌───────────────────┴──────┐           │
│                              │                          │           │
│                              ▼                          ▼           │
│                        ┌───────────┐            ┌──────────────┐   │
│                        │  Return   │            │  Execute     │   │
│                        │  Cached   │            │  Fresh       │   │
│                        │  Result   │            │  Chain       │   │
│                        └───────────┘            └──────┬───────┘   │
│                                                        │           │
│  Model Loading Strategy                                │           │
│  ┌─────────────────────────────────────────────────────▼──────┐   │
│  │                                                             │   │
│  │  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐ │   │
│  │  │ Preload      │    │ Lazy Load    │    │ Parallel     │ │   │
│  │  │ Common       │    │ Rare         │    │ Load         │ │   │
│  │  │ Models       │    │ Models       │    │ Independent  │ │   │
│  │  └──────────────┘    └──────────────┘    └──────────────┘ │   │
│  │                                                             │   │
│  │  Memory Pool: 18.4GB                                        │   │
│  │  ├─ Model 1: 3.2GB  (Always Loaded)                        │   │
│  │  ├─ Model 2: 3.2GB  (Always Loaded)                        │   │
│  │  ├─ Model 3: 3.2GB  (Lazy Load)                            │   │
│  │  └─ Available: 8.8GB                                        │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  Execution Timeline                                                  │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │                                                               │   │
│  │  0s     10s    20s    30s    40s    50s    60s              │   │
│  │  │───────│──────│──────│──────│──────│──────│               │   │
│  │  │                                                           │   │
│  │  │▓▓▓▓│ Query Analysis (3s)                                 │   │
│  │  │    │▓▓▓▓▓▓▓▓│ Model Loading (8s)                        │   │
│  │  │              │▓▓▓▓▓▓▓▓▓▓▓▓│ Model 1 Inference (12s)     │   │
│  │  │                           │▓▓│ Context Prop (2s)         │   │
│  │  │                              │▓▓▓▓▓▓▓▓▓▓│ Model 2 (10s) │   │
│  │  │                                         │▓│ Synthesis(2s)│   │
│  │  │                                                           │   │
│  │  Total: 37s                                                  │   │
│  └─────────────────────────────────────────────────────────────┘   │
│                                                                      │
│  Optimization Opportunities                                          │
│  ┌─────────────────────────────────────────────────────────────┐   │
│  │                                                               │   │
│  │  1. Parallel Execution:    -40% time (22s total)            │   │
│  │  2. Model Quantization:    -50% memory, -20% time            │   │
│  │  3. Semantic Caching:      -60% for repeated patterns        │   │
│  │  4. Batch Processing:      -30% for multiple queries         │   │
│  │                                                               │   │
│  └─────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────┘
```

## 6. Security Architecture (Mermaid)

```mermaid
graph TB
    subgraph "External Boundary"
        U[User Input]
        R[Response Output]
    end
    
    subgraph "Security Layer"
        U --> IV[Input Validation]
        IV --> SP[Sensitive Pattern Detection]
        SP --> E1[Encryption Layer]
        
        E1 --> PG[Privacy Guard]
        PG --> AL[Audit Logger]
    end
    
    subgraph "Processing Core"
        AL --> QP[Query Processor]
        QP --> ME[Model Execution]
        ME --> CS[Context Storage]
        
        CS --> E2[Encrypted SQLite]
        E2 --> VE[Vector Embeddings]
    end
    
    subgraph "Output Sanitization"
        ME --> OS[Output Scanner]
        OS --> RD[Redaction Engine]
        RD --> VL[Validation Layer]
        VL --> R
    end
    
    subgraph "Monitoring"
        AL --> AM[Audit Monitor]
        AM --> IV2[Integrity Verification]
        AM --> AA[Anomaly Detection]
        AA --> ALERT[Security Alerts]
    end
    
    style U fill:#FF6B6B
    style R fill:#4ECDC4
    style PG fill:#45B7D1
    style E2 fill:#96CEB4
```

## 7. Data Flow Diagram (ASCII)

```
┌─────────────────────────────────────────────────────────────────────┐
│                         DATA FLOW ARCHITECTURE                       │
├─────────────────────────────────────────────────────────────────────┤
│                                                                      │
│  Input Stage                                                         │
│  ┌──────────┐      ┌──────────┐      ┌──────────┐                 │
│  │  Query   │      │ Context  │      │ History  │                 │
│  │  String  │      │  State   │      │  Cache   │                 │
│  └────┬─────┘      └────┬─────┘      └────┬─────┘                 │
│       │                  │                  │                       │
│       └──────────────────┴──────────────────┘                       │
│                          │                                          │
│                          ▼                                          │
│  ┌─────────────────────────────────────────────────────────┐       │
│  │                  Data Transformation                      │       │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐        │       │
│  │  │ Tokenizer  │  │ Embedder   │  │ Normalizer │        │       │
│  │  └─────┬──────┘  └─────┬──────┘  └─────┬──────┘        │       │
│  │        │                │                │               │       │
│  │        ▼                ▼                ▼               │       │
│  │   [Tokens]         [Vectors]        [Metadata]          │       │
│  └──────────────────────┬──────────────────────────────────┘       │
│                         │                                           │
│                         ▼                                           │
│  ┌─────────────────────────────────────────────────────────┐       │
│  │                   Model Processing                       │       │
│  │                                                          │       │
│  │  ┌─────────┐    ┌─────────┐    ┌─────────┐            │       │
│  │  │ Model 1 │───▶│ Model 2 │───▶│ Model N │            │       │
│  │  └────┬────┘    └────┬────┘    └────┬────┘            │       │
│  │       │               │               │                 │       │
│  │       ▼               ▼               ▼                 │       │
│  │  [Output 1]      [Output 2]      [Output N]            │       │
│  └───────────────────────┬─────────────────────────────────┘       │
│                          │                                          │
│                          ▼                                          │
│  ┌─────────────────────────────────────────────────────────┐       │
│  │                    Data Storage                          │       │
│  │                                                          │       │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │       │
│  │  │   SQLite     │  │   Vector     │  │   Cache      │ │       │
│  │  │   Tables     │  │   Index      │  │   Store      │ │       │
│  │  ├──────────────┤  ├──────────────┤  ├──────────────┤ │       │
│  │  │ • chains     │  │ • embeddings │  │ • results    │ │       │
│  │  │ • outputs    │  │ • similarity │  │ • patterns   │ │       │
│  │  │ • metrics    │  │ • clusters   │  │ • frequent   │ │       │
│  │  │ • audit_log  │  │              │  │              │ │       │
│  │  └──────────────┘  └──────────────┘  └──────────────┘ │       │
│  └─────────────────────────────────────────────────────────┘       │
│                                                                      │
│  Output Stage                                                        │
│  ┌──────────┐      ┌──────────┐      ┌──────────┐                 │
│  │ Response │      │ Metrics  │      │  Audit   │                 │
│  │ Synthesis│      │  Update  │      │   Log    │                 │
│  └──────────┘      └──────────┘      └──────────┘                 │
│                                                                      │
└─────────────────────────────────────────────────────────────────────┘
```

These diagrams provide comprehensive visualization of:
- System architecture and component relationships
- Chain execution flow and decision logic
- Context propagation between models
- Model selection algorithm
- Performance optimization strategies
- Security implementation
- Complete data flow through the system

Each diagram offers a different perspective on Mirador's sophisticated orchestration capabilities while maintaining clarity for technical audiences.