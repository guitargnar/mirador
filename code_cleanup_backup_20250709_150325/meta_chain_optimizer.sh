


echo "=== MIRADOR META-CHAIN OPTIMIZER ==="
echo "Enter your goal or question:"
read -r user_prompt

echo -e "\nAnalyzing prompt..."
mirador-ez chain "Given this prompt: '$user_prompt', what is the optimal model chain sequence and why?" \
mirador_system_specialist_v2 decision_simplifier

echo -e "\nWould you like to run the suggested chain? (y/n)"
read -r response
if [[ $response == "y" ]]; then
    echo "Please enter the suggested chain command:"
    read -r chain_command
    eval "$chain_command"
fi
