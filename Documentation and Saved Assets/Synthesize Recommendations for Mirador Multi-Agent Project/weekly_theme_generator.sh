

echo "=== WEEKLY THEME GENERATOR ==="
echo "Generating personalized weekly theme based on your current situation..."

mirador-ez chain "Based on my personality profile and current opportunities, what should be my focus theme for this week? Provide 3 specific actions." \
matthew_context_provider_v2 mirador_system_specialist_v2 decision_simplifier

echo -e "\nTheme saved to: weekly_themes/$(date +%Y%m%d).md"
mkdir -p weekly_themes
cp outputs/latest/summary.md "weekly_themes/$(date +%Y%m%d).md"
