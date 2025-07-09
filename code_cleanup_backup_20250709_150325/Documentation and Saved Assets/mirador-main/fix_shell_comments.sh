
echo "🔧 Fixing shell comment syntax for zsh compatibility..."


sed -i '' 's/\s*


cat > test_models_fixed.sh << 'INNER_EOF'

echo "🧪 Testing model performance..."


MODELS=$(ollama list | grep -v NAME | awk '{print $1}')

for model in $MODELS; do
    echo "Testing $model performance..."
    
    
done

echo "✅ Model testing complete"
INNER_EOF

chmod +x test_models_fixed.sh
echo "✅ Shell syntax fixes complete"
