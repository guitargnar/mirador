

echo "============================================="
echo "🎨 CREATING BRAND & SALES SPECIALISTS"
echo "============================================="
echo ""


echo "Creating personal_brand_architect..."
ollama create personal_brand_architect -f personal_brand_architect.modelfile
echo "✅ Personal Brand Architect created"
echo ""


echo "Creating engagement_optimizer..."
ollama create engagement_optimizer -f engagement_optimizer.modelfile
echo "✅ Engagement Optimizer created"
echo ""


echo "Creating sales_content_creator..."
ollama create sales_content_creator -f sales_content_creator.modelfile
echo "✅ Sales Content Creator created"
echo ""

echo "============================================="
echo "✅ ALL SPECIALISTS CREATED SUCCESSFULLY!"
echo "============================================="
echo ""
echo "Test your new specialists with these commands:"
echo ""
echo "1. Brand Development:"
echo '   mirador-ez chain "Create unique positioning for Louisville cloud consultant" personal_brand_architect linkedin_content_expert'
echo ""
echo "2. Engagement Strategy:"
echo '   mirador-ez chain "Optimize LinkedIn post for maximum engagement" linkedin_content_expert engagement_optimizer'
echo ""
echo "3. Sales Content:"
echo '   mirador-ez chain "Convert case study into sales proposal template" digital_storyteller sales_content_creator'
echo ""
