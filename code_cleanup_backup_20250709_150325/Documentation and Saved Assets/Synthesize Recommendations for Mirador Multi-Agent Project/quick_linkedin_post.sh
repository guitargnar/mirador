


TOPIC="$1"
if [ -z "$TOPIC" ]; then
    echo "Usage: ./quick_linkedin_post.sh \"[topic]\""
    exit 1
fi

echo "🚀 Generating LinkedIn post about: $TOPIC"
echo "==========================================="

mirador-ez chain \
    "Create an engaging LinkedIn post about $TOPIC. Include a hook, 3 key insights, and a call-to-action. Optimize for engagement and professional value." \
    mirador_system_specialist \
    enhanced_agent_fast_v7 \
    decision_enhancer

echo ""
echo "✅ LinkedIn post generated! Don't forget to:"
echo "   - Add relevant hashtags"
echo "   - Tag relevant connections"
echo "   - Post at optimal time (Tue-Thu, 8-10am)"
