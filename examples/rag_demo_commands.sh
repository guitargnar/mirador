#!/bin/bash

# Mirador RAG (Retrieval-Augmented Generation) Demo Commands
# These commands demonstrate how Mirador can analyze documents, retrieve information,
# and generate insights using its 80+ specialized models

echo "🔍 Mirador RAG Capabilities Demo"
echo "================================"
echo ""

# 1. Document Analysis with Context
echo "📄 Example 1: Analyze a business document with financial context"
echo "Command:"
echo './mirador-smart-v2 "Analyze the Q3 financial report at ./documents/q3_report.pdf and provide investment recommendations"'
echo ""

# 2. Code Repository Understanding
echo "💻 Example 2: Understand and document a codebase"
echo "Command:"
echo './mirador_universal_runner_v2.sh technical_mastery "Analyze the Python files in ./src/ and create comprehensive API documentation with examples"'
echo ""

# 3. Research Paper Synthesis
echo "📚 Example 3: Synthesize multiple research papers"
echo "Command:"
echo './mirador-smart-v2 "Review the AI papers in ./research/2024/ and summarize the key breakthroughs in large language models"'
echo ""

# 4. Legal Document Analysis
echo "⚖️ Example 4: Extract key terms from legal documents"
echo "Command:"
echo './mirador_universal_runner_v2.sh strategic_synthesis "Extract and summarize all obligations and deadlines from the contract at ./legal/service_agreement.pdf"'
echo ""

# 5. Meeting Transcription Analysis
echo "🎤 Example 5: Analyze meeting transcript for action items"
echo "Command:"
echo './mirador-ez chain "Extract action items, decisions, and follow-ups from ./meetings/team_standup_transcript.txt" matthew_context_provider_v5 business_analyst_expert decision_simplifier'
echo ""

# 6. Knowledge Base Query
echo "🧠 Example 6: Query internal knowledge base"
echo "Command:"
echo './mirador_universal_runner_v3_optimized.sh deep_analysis "Search our knowledge base for all mentions of cloud migration strategies and create a best practices guide"'
echo ""

# 7. Multi-Document Comparison
echo "📊 Example 7: Compare multiple versions of a document"
echo "Command:"
echo './mirador-smart-v2 "Compare ./proposals/v1/project.md with ./proposals/v2/project.md and highlight the key changes and their implications"'
echo ""

# 8. Email Thread Analysis
echo "📧 Example 8: Analyze email threads for context"
echo "Command:"
echo './mirador_universal_runner_v2.sh relationship_harmony "Analyze the email thread in ./emails/client_discussion.mbox and summarize the key concerns and proposed solutions"'
echo ""

# 9. Log File Analysis
echo "📝 Example 9: Analyze system logs for patterns"
echo "Command:"
echo './mirador-smart-v2 "Analyze ./logs/system.log for error patterns and provide debugging recommendations with root cause analysis"'
echo ""

# 10. API Documentation Generation
echo "🔧 Example 10: Generate API docs from code"
echo "Command:"
echo './mirador_universal_runner_v2.sh technical_mastery "Read all REST endpoints in ./src/api/ and generate OpenAPI 3.0 documentation with curl examples"'
echo ""

echo "💡 Pro Tips for RAG with Mirador:"
echo "- Use 'detailed' format for comprehensive analysis"
echo "- Combine multiple models for deeper insights"
echo "- Leverage domain-specific chains for better results"
echo "- Save outputs for future reference and comparison"
echo ""

# Actual runnable example with sample data
echo "🚀 Try this working example:"
echo ""
echo "# Create a sample document"
echo 'echo "Q3 2024 Financial Summary
Revenue: $2.3M (+15% YoY)
Expenses: $1.8M (+10% YoY)
Key Wins: 3 enterprise clients
Challenges: Rising cloud costs
Opportunities: AI integration services
Risks: Market competition" > sample_financial.txt'
echo ""
echo "# Analyze it with Mirador"
echo './mirador-smart-v2 "Analyze sample_financial.txt and provide strategic recommendations for Q4"'