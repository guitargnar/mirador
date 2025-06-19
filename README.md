Mirador: An intelligent multi-model AI orchestration framework that chains specialized language models to provide personalized, actionable insights aligned with your unique personality, goals, and context.

🌟 Overview
Mirador transforms complex decisions into clear actions by orchestrating multiple AI specialists that understand YOU. Built on Ollama and enhanced with Big Five personality integration, Mirador delivers comprehensive analysis in under 60 seconds.
Key Features

🧠 Personality-Aware Intelligence: Integrated Big Five (OCEAN) profile for personalized recommendations
🔗 Multi-Model Orchestration: Chains up to 6 specialized models for comprehensive analysis
💾 Memory System: SQLite-based context retention and pattern learning
🎯 Smart Chain Selection: Automatically selects optimal model combinations based on query type
📍 Location-Aware: Deep integration with Louisville, KY resources and opportunities
⚡ High Performance: 5-25 second response times with 100% completion rate
🔒 Privacy-First: 100% local execution, no external API calls

🚀 Quick Start
bash# Daily opportunity scan (5 minutes)
./quick_opportunity.sh

# Smart financial planning
./mirador-smart-v2 "How can I optimize my 75000 income?"

# Music career development  
./mirador-smart-v2 "Create 90-day plan to become touring guitarist"

# System health check
./daily_check_enhanced.sh
📋 Requirements

Hardware: MacBook M3 Max or equivalent (16GB+ RAM recommended)
OS: macOS Sequoia 15.5+ (tested) or Linux
Software:

Ollama 2.0+
Python 3.13+
50GB+ available storage
Homebrew (for macOS dependencies)



🛠️ Installation

Clone the repository
bashgit clone https://github.com/yourusername/mirador.git
cd mirador

Install dependencies
bash# Install Ollama
brew install ollama

# Install Python packages
pip3 install -r requirements.txt

# Install coreutils for timeout functionality
brew install coreutils

Pull base models
bashollama pull llama3.2
ollama pull llama3.2_balanced

Create specialized models
bash./deploy_production_mirador.sh

Verify installation
bash./daily_check_enhanced.sh


🏗️ Architecture
System Overview
┌─────────────────────────────────────────────────────────┐
│                  User Interface Layer                    │
│          (mirador-smart-v2, mirador-ez, CLI)           │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────┴───────────────────────────────┐
│              Orchestration & Chain Logic                 │
│        (Smart routing, Chain execution, Caching)        │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────┴───────────────────────────────┐
│                 Specialized AI Models                    │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐       │
│  │  Matthew    │ │  Financial  │ │ Louisville  │       │
│  │  Context    │ │   Expert    │ │   Expert    │       │
│  │    (v3)     │ │    (v8)     │ │    (v3)     │       │
│  └─────────────┘ └─────────────┘ └─────────────┘       │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐       │
│  │  Enhanced   │ │  Decision   │ │   System    │       │
│  │   Agent     │ │ Simplifier  │ │ Specialist  │       │
│  │    (v1)     │ │    (v3)     │ │    (v2)     │       │
│  └─────────────┘ └─────────────┘ └─────────────┘       │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────┴───────────────────────────────┐
│              Foundation Layer (Ollama)                   │
│          (Model management, Inference engine)            │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────┴───────────────────────────────┐
│                  Storage & Memory                        │
│        (SQLite DB, Output files, Model cache)          │
└─────────────────────────────────────────────────────────┘
Core Models
ModelPurposeSpecialtymatthew_context_provider_v3Personal context & personalityBig Five profile, goals, valuesfinancial_planning_expert_v8Financial analysis & planningLouisville-specific, $75k optimizationlouisville_expert_v3Local knowledge & resourcesVenues, networks, opportunitiesenhanced_agent_enforcerStrategic synthesisCross-domain analysisdecision_simplifier_v3Action generationTimeline-based recommendationsmirador_system_specialist_v2Meta-optimizationSystem improvement
📊 Performance Metrics

Response Times:

Individual models: 5-25 seconds
3-model chains: 45-60 seconds
Memory queries: <1 second


Success Rate: 100% completion rate across 450+ analyses
Output Quality: Average 390 words of actionable content per chain
Storage Efficiency: 22MB for 447 complete analyses

💡 Usage Examples
Financial Optimization
bash./mirador-smart-v2 "Create comprehensive budget for 75000 income with savings strategy"
./mirador-smart-v2 "Investment opportunities for musicians in Louisville"
./mirador-smart-v2 "Tax optimization strategies for creative professionals in Kentucky"
Music Career Development
bash./mirador-smart-v2 "90-day roadmap to join Cody Ash touring band"
./mirador-smart-v2 "Build guitar skills for country/rock touring"
./mirador-smart-v2 "Network with Nashville music industry from Louisville"
Strategic Planning
bash./mirador-smart-v2 "Balance family life with touring musician ambitions"
./mirador-smart-v2 "Leverage high openness personality for creative success"
./mirador-smart-v2 "Build multiple income streams as Louisville musician"
🔧 Advanced Configuration
Custom Chains
Create specialized chains for repeated workflows:
bash# Add to mirador-smart-v2
elif [[ "$QUERY" =~ (your|custom|pattern) ]]; then
    echo "🎯 Custom chain detected"
    mirador-ez chain "$QUERY" model1 model2 model3
Memory System
The SQLite database tracks:

Query history and patterns
Model performance metrics
Opportunity implementation results
Success patterns for reuse

Daily Automation
bash# Add to crontab
0 8 * * * cd ~/mirador && ./daily_mirador_workflow.sh
0 9 * * 0 cd ~/mirador && ./weekly_personality_optimization.sh
📚 Documentation

Technical Documentation - Architecture details
Usage Instructions - Comprehensive guide
Prompt Library - Optimized prompts
API Reference - Model specifications

🤝 Contributing
While Mirador is a personal project, suggestions and improvements are welcome:

Fork the repository
Create your feature branch (git checkout -b feature/AmazingFeature)
Commit changes (git commit -m 'Add AmazingFeature')
Push to branch (git push origin feature/AmazingFeature)
Open a Pull Request

📄 License
This project is for personal use. See LICENSE for details.
🙏 Acknowledgments

Ollama Team - Local LLM infrastructure
Anthropic Claude - Development collaboration
llama3.2 - Base model foundation
Louisville Tech Community - Inspiration and support

📈 Project Stats

Version: 1.1-personality-integrated
Total Analyses: 450+
Success Rate: 100%
Active Since: May 2024
Last Updated: June 18, 2025
