

echo "=== Creating Content Creation Specialists ==="
echo ""


echo "Creating linkedin_content_expert..."
ollama create linkedin_content_expert -f linkedin_content_expert.modelfile


echo "Creating digital_storyteller..."
ollama create digital_storyteller -f digital_storyteller.modelfile


echo "Creating content_strategist_pro..."
ollama create content_strategist_pro.modelfile

echo ""
echo "✅ Content specialists created successfully!"
echo ""
echo "Test with:"
echo 'mirador-ez chain "Convert technical insight into LinkedIn post" enhanced_agent_fast_v6 linkedin_content_expert'
