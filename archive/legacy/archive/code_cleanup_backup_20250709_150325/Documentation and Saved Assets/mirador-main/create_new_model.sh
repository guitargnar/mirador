

if [ $
    echo "Usage: $0 <model_name> <base_model> [description]"
    echo "Example: $0 parenting_expert llama3.2_balanced 'JCPS and child development specialist'"
    exit 1
fi

MODEL_NAME="$1"
BASE_MODEL="$2"
DESCRIPTION="${3:-New Mirador specialist model}"

echo "=== Creating New Mirador Model ==="
echo "Model Name: $MODEL_NAME"
echo "Base Model: $BASE_MODEL"
echo "Description: $DESCRIPTION"


cat > "${MODEL_NAME}.modelfile" << MODELEOF
FROM $BASE_MODEL

PARAMETER temperature 0.3
PARAMETER top_p 0.8
PARAMETER num_predict 1500
PARAMETER repeat_penalty 1.1

SYSTEM """You are a specialized expert for the Mirador personal life automation framework.

CORE MISSION: [Define the specific domain expertise and mission]

MIRADOR INTEGRATION:
- Provide actionable, specific recommendations
- Include Louisville/Kentucky context when relevant
- Structure responses for chain collaboration
- Focus on practical implementation guidance

RESPONSE STRUCTURE:
1. [Define appropriate response structure]
2. [Include relevant sections]
3. [End with clear next steps]

EXPERTISE AREAS:
- [List specific areas of expertise]
- [Include local knowledge integration]
- [Define scope and limitations]

You excel at [specific capabilities] while maintaining focus on practical personal life automation."""
MODELEOF

echo "Model file created: ${MODEL_NAME}.modelfile"
echo "Next steps:"
echo "1. Edit the model file to add specific expertise"
echo "2. Create the model: ollama create $MODEL_NAME -f ${MODEL_NAME}.modelfile"
echo "3. Test the model: mirador-ez ask $MODEL_NAME 'test query'"
echo "4. Add to git: git add ${MODEL_NAME}.modelfile && git commit -m 'Add $MODEL_NAME specialist'"
