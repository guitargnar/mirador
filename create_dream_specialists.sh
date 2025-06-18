#!/bin/bash

echo "=== Creating Your Dream Team of Mirador Specialists ==="

specialists=(
    "master_guitar_instructor"
    "music_industry_networker"
    "touring_readiness_coach"
    "linkedin_voice_architect"
    "mirador_self_reflection_guardian"
    "audio_production_strategist"
    "digital_asset_curator"
    "father_daughter_wisdom_guide"
)

for specialist in "${specialists[@]}"; do
    if [ -f "${specialist}.modelfile" ]; then
        echo "Creating $specialist..."
        ollama create $specialist -f ${specialist}.modelfile
        echo "✓ $specialist created"
    fi
done

echo ""
echo "Your touring guitarist dream team is ready!"
echo "Time to make it happen! 🎸"
