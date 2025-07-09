#!/usr/bin/env bash
# Test for code_reviewer_fix

echo "Testing code_reviewer_fix..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/code_reviewer_fix_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Appropriate prompt for code review model - escape newlines and quotes
PROMPT="Review and improve the following code, focusing on security, performance, and best practices: function getUserData(userId) { const query = 'SELECT * FROM users WHERE id = ' + userId; return db.query(query).then(results => { if (results.length > 0) { return results[0]; } else { return null; } }).catch(err => { console.log('Database error: ' + err); }); } function authenticateUser(username, password) { return getUserData(username).then(user => { if (user && user.password === password) { const token = createToken(username); return {success: true, token: token}; } else { return {success: false, message: 'Invalid credentials'}; } }); } function createToken(username) { return 'token_' + username + '_' + (new Date()).getTime(); }"

# Run test with appropriate prompt for this model type
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"code_reviewer_fix\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/response.json"

# Extract response
cat "$OUTPUT_DIR/response.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/output.txt"

# Log test metadata
echo "Model: code_reviewer_fix" > "$OUTPUT_DIR/metadata.txt"
echo "Timestamp: $(date)" >> "$OUTPUT_DIR/metadata.txt"
echo "Prompt: $PROMPT" >> "$OUTPUT_DIR/metadata.txt"
echo "Response size: $(wc -c < $OUTPUT_DIR/output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
DURATION=$(cat "$OUTPUT_DIR/response.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
echo "Response time: $DURATION nanoseconds" >> "$OUTPUT_DIR/metadata.txt"

echo "Test completed. Results in $OUTPUT_DIR"