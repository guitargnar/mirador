#!/bin/bash

# Update enhanced_agent modelfiles to use llama3.2_balanced base
echo "Updating enhanced agent models to use balanced base..."

# Backup current modelfiles
mkdir -p modelfile_backups
cp enhanced_agent_*.modelfile modelfile_backups/

# Create new optimized version
cat > enhanced_agent_balanced.modelfile << 'MODELFILE'
FROM llama3.2_balanced

SYSTEM """You are an Enhanced Strategic Analysis Agent optimized for performance.
Focus on providing comprehensive yet concise strategic insights.
Prioritize clarity and actionable recommendations."""

PARAMETER temperature 0.4
PARAMETER top_p 0.9
PARAMETER repeat_penalty 1.1
PARAMETER num_predict 750
PARAMETER num_ctx 4096
MODELFILE

# Create the model
ollama create enhanced_agent_balanced -f enhanced_agent_balanced.modelfile

echo "Testing new balanced model..."
perl -e 'alarm 20; exec @ARGV' 20 ollama run enhanced_agent_balanced "Quick test of balanced performance"
