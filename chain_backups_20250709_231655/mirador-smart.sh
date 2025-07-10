


PROMPT="$1"
PRIORITY="${2:-balanced}"


if [[ "$PROMPT" =~ (financial|investment|money|income|salary) ]]; then
    DOMAIN="financial"
elif [[ "$PROMPT" =~ (Louisville|local|real estate|neighborhood) ]]; then
    DOMAIN="local"
elif [[ "$PROMPT" =~ (career|consulting|Medicare|compliance) ]]; then
    DOMAIN="career"
else
    DOMAIN="general"
fi


case "$PRIORITY" in
    speed)
        case "$DOMAIN" in
            financial)
                mirador-ez ask financial_planning_expert_fast "$PROMPT"
                ;;
            local)
                mirador-ez ask louisville_expert_v3 "$PROMPT"
                ;;
            career)
                mirador-ez ask matthew_context_provider "$PROMPT"
                ;;
            *)
                mirador-ez ask decision_enhancer "$PROMPT"
                ;;
        esac
        ;;
    quality)
        case "$DOMAIN" in
            financial)
                mirador-ez chain "$PROMPT" \
                    financial_planning_expert_v6 \
                    opportunity_validator_v2 \
                    enhanced_agent_enforcer \
                    decision_enhancer
                ;;
            local)
                mirador-ez chain "$PROMPT" \
                    louisville_expert_v3 \
                    financial_planning_expert_v6 \
                    opportunity_validator_v2 \
                    decision_enhancer
                ;;
            career)
                mirador-ez chain "$PROMPT" \
                    matthew_context_provider \
                    enhanced_agent_enforcer \
                    opportunity_validator_v2 \
                    decision_enhancer
                ;;
            *)
                mirador-ez chain "$PROMPT" \
                    mirador_system_specialist \
                    enhanced_agent_enforcer \
                    decision_enhancer
                ;;
        esac
        ;;
    balanced|*)
        case "$DOMAIN" in
            financial)
                mirador-ez chain "$PROMPT" \
                    financial_planning_expert_v6 \
                    decision_enhancer
                ;;
            local)
                mirador-ez chain "$PROMPT" \
                    louisville_expert_v3 \
                    opportunity_validator_v2
                ;;
            career)
                mirador-ez chain "$PROMPT" \
                    matthew_context_provider \
                    decision_enhancer
                ;;
            *)
                mirador-ez chain "$PROMPT" \
                    mirador_system_specialist \
                    decision_enhancer
                ;;
        esac
        ;;
esac
