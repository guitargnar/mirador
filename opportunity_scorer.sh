

echo "=== MIRADOR OPPORTUNITY SCORER ==="
echo "This tool evaluates opportunities against your personality profile"
echo
echo "Enter opportunity description:"
read -r opportunity


mirador-ez chain "Score this opportunity from 1-10 on: 1) Alignment with servant leadership, 2) Creative expression potential, 3) Family/financial sustainability, 4) Community impact, 5) Personal growth potential. Opportunity: $opportunity" \
matthew_context_provider_v2 mirador_system_specialist_v2 enhanced_agent_enforcer decision_simplifier


echo -e "\n\n
echo "Description: $opportunity" >> opportunity_scores.md
echo "See latest output for scores" >> opportunity_scores.md
