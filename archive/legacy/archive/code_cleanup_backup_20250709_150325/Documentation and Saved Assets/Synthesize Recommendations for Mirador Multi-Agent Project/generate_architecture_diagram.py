#!/usr/bin/env python3
"""
Mirador Architecture Diagram Generator
Generates ASCII architecture diagram for the Mirador AI orchestration system
"""

def generate_architecture_diagram():
    diagram = """
╔══════════════════════════════════════════════════════════════════════════════╗
║                           MIRADOR AI ORCHESTRATION FRAMEWORK                 ║
║                          Personal Intelligence Amplification                 ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │                        COMMAND INTERFACE LAYER                         │ ║
║  │                                                                         │ ║
║  │  mirador-ez ──┬── models (list available models)                       │ ║
║  │               ├── ask [model] "[query]" (single model)                 │ ║
║  │               ├── auto "[query]" (intelligent routing)                 │ ║
║  │               └── chain "[task]" model1 model2... (custom)             │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                    │                                        ║
║                                    ▼                                        ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │                      ORCHESTRATION ENGINE (mirador.py)                 │ ║
║  │                                                                         │ ║
║  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────┐ │ ║
║  │  │ Query Analysis  │  │ Chain Selection │  │ Context Management      │ │ ║
║  │  │ • Regex patterns│  │ • Domain routing│  │ • Progressive building  │ │ ║
║  │  │ • Intent detect │  │ • Model sequence│  │ • Output integration    │ │ ║
║  │  └─────────────────┘  └─────────────────┘  └─────────────────────────┘ │ ║
║  │                                                                         │ ║
║  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────┐ │ ║
║  │  │ Error Handling  │  │ Timeout Mgmt    │  │ Output Organization     │ │ ║
║  │  │ • Graceful fail │  │ • 120s default  │  │ • Timestamped dirs      │ │ ║
║  │  │ • Chain continue│  │ • Model skip    │  │ • Individual files      │ │ ║
║  │  └─────────────────┘  └─────────────────┘  └─────────────────────────┘ │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                    │                                        ║
║                                    ▼                                        ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │                         MODEL ECOSYSTEM (65+ Models)                   │ ║
║  │                                                                         │ ║
║  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────┐ │ ║
║  │  │ CORE CONTEXT    │  │ DOMAIN EXPERTS  │  │ MUSIC CAREER FOCUS      │ │ ║
║  │  │                 │  │                 │  │                         │ │ ║
║  │  │ matthew_context │  │ financial_v6    │  │ master_guitar_instructor│ │ ║
║  │  │ decision_v2     │  │ louisville_v3   │  │ music_industry_networker│ │ ║
║  │  │ enhanced_agent  │  │ health_wellness │  │ linkedin_voice_architect│ │ ║
║  │  │                 │  │ real_estate     │  │ touring_readiness_coach │ │ ║
║  │  └─────────────────┘  └─────────────────┘  └─────────────────────────┘ │ ║
║  │                                                                         │ ║
║  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────┐ │ ║
║  │  │ PROFESSIONAL    │  │ CONTENT CREATION│  │ SYSTEM MANAGEMENT       │ │ ║
║  │  │                 │  │                 │  │                         │ │ ║
║  │  │ resume_crafter  │  │ content_strategist│ │ mirador_self_reflection │ │ ║
║  │  │ communication   │  │ digital_storyteller│ │ macbook_organizer      │ │ ║
║  │  │ lead_generator  │  │ engagement_optimizer│ │ feedback_optimizer     │ │ ║
║  │  │ resource_gather │  │ brand_architect   │  │ opportunity_validator   │ │ ║
║  │  └─────────────────┘  └─────────────────┘  └─────────────────────────┘ │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                    │                                        ║
║                                    ▼                                        ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │                         AUTOMATION SUITE (80+ Scripts)                 │ ║
║  │                                                                         │ ║
║  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────┐ │ ║
║  │  │ DAILY WORKFLOWS │  │ WEEKLY PLANNING │  │ SPECIALIZED FUNCTIONS   │ │ ║
║  │  │                 │  │                 │  │                         │ │ ║
║  │  │ morning_brief   │  │ strategic_dive  │  │ quick_linkedin_post     │ │ ║
║  │  │ evening_review  │  │ optimization    │  │ health_check            │ │ ║
║  │  │ quick_optimize  │  │ theme_generator │  │ system_validation       │ │ ║
║  │  │                 │  │                 │  │ opportunity_dashboard   │ │ ║
║  │  └─────────────────┘  └─────────────────┘  └─────────────────────────┘ │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                    │                                        ║
║                                    ▼                                        ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │                           OUTPUT MANAGEMENT                             │ ║
║  │                                                                         │ ║
║  │  outputs/                                                               │ ║
║  │  ├── chain_YYYYMMDD_HHMMSS/                                            │ ║
║  │  │   ├── 01_model1_output.md                                           │ ║
║  │  │   ├── 02_model2_output.md                                           │ ║
║  │  │   ├── ...                                                           │ ║
║  │  │   └── summary.md                                                    │ ║
║  │  ├── high_value_insights/                                              │ ║
║  │  ├── monthly_reports/                                                  │ ║
║  │  └── project_documentation/                                            │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                                                              ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │                              OLLAMA LAYER                              │ ║
║  │                                                                         │ ║
║  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────────────┐ │ ║
║  │  │ Model Storage   │  │ Inference Engine│  │ Resource Management     │ │ ║
║  │  │ • llama3.2 base │  │ • Local execution│ │ • Memory optimization   │ │ ║
║  │  │ • 65+ specialists│  │ • No external API│ │ • Model loading/unload  │ │ ║
║  │  │ • .modelfile defs│  │ • Privacy focused│ │ • Performance tuning    │ │ ║
║  │  └─────────────────┘  └─────────────────┘  └─────────────────────────┘ │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                                                              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                DATA FLOW                                    ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║  User Query → Pattern Analysis → Chain Selection → Model Execution →         ║
║  Context Building → Progressive Enhancement → Output Generation →             ║
║  File Organization → Summary Creation → User Delivery                        ║
║                                                                              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                              GOAL ALIGNMENT                                 ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                              ║
║  🎸 PRIMARY GOAL: Become touring guitarist with established band             ║
║  💼 PROFESSIONAL: Excel in healthcare compliance and AI innovation           ║
║  👨‍👧 FAMILY: Support 8-year-old daughter's development and success           ║
║  📈 PERSONAL: Continuous learning and life optimization                      ║
║                                                                              ║
║  Every component serves these interconnected objectives through:             ║
║  • Skill development and practice optimization                              ║
║  • Industry networking and opportunity identification                       ║
║  • Professional content creation and thought leadership                     ║
║  • Work-life balance and family priority integration                        ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝
"""
    return diagram

if __name__ == "__main__":
    print(generate_architecture_diagram())

