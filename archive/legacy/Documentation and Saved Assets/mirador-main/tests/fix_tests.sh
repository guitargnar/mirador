#!/usr/bin/env bash
# Fix test script issues and run tests again

# Set error handling
set -e

echo "🔧 Fixing test script issues..."

# Fix permissions on all test scripts
chmod +x ~/ai_framework_git/tests/models/*.sh ~/ai_framework_git/tests/chains/*.sh

# Create a report directory
REPORT_DIR=~/ai_framework_git/tests/reports
mkdir -p $REPORT_DIR

# Fix code_reviewer_fix test
cat > ~/ai_framework_git/tests/models/test_code_reviewer_fix.sh << 'EOF'
#!/usr/bin/env bash
# Test for code_reviewer_fix

echo "Testing code_reviewer_fix..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/code_reviewer_fix_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Simplified prompt without backticks or complex code
PROMPT="Review and improve this code, focusing on security, performance, and best practices: function getUserData(userId) { const query = 'SELECT * FROM users WHERE id = ' + userId; return db.query(query); } function authenticateUser(username, password) { return getUserData(username).then(user => { if (user && user.password === password) { return true; } else { return false; } }); } function createToken(username) { return 'token_' + username + '_' + (new Date()).getTime(); }"

# Run test with appropriate prompt for this model type
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"code_reviewer_fix\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/response.json"

# Extract response safely
cat "$OUTPUT_DIR/response.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/output.txt"

# Log test metadata
echo "Model: code_reviewer_fix" > "$OUTPUT_DIR/metadata.txt"
echo "Timestamp: $(date)" >> "$OUTPUT_DIR/metadata.txt"
echo "Prompt: $PROMPT" >> "$OUTPUT_DIR/metadata.txt"
echo "Response size: $(wc -c < $OUTPUT_DIR/output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
DURATION=$(cat "$OUTPUT_DIR/response.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
echo "Response time: $DURATION nanoseconds" >> "$OUTPUT_DIR/metadata.txt"

echo "Test completed. Results in $OUTPUT_DIR"
EOF

# Fix file_reviewer test
cat > ~/ai_framework_git/tests/models/test_file_reviewer.sh << 'EOF'
#!/usr/bin/env bash
# Test for file_reviewer

echo "Testing file_reviewer..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/file_reviewer_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Simplified prompt
PROMPT="Create documentation for a user authentication API with these endpoints: register, login, and refresh-token. Include overview, endpoint details, authentication flow, security considerations, and usage examples."

# Run test with appropriate prompt for this model type
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"file_reviewer\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/response.json"

# Extract response safely
cat "$OUTPUT_DIR/response.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/output.txt"

# Log test metadata
echo "Model: file_reviewer" > "$OUTPUT_DIR/metadata.txt"
echo "Timestamp: $(date)" >> "$OUTPUT_DIR/metadata.txt"
echo "Prompt: $PROMPT" >> "$OUTPUT_DIR/metadata.txt"
echo "Response size: $(wc -c < $OUTPUT_DIR/output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
DURATION=$(cat "$OUTPUT_DIR/response.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
echo "Response time: $DURATION nanoseconds" >> "$OUTPUT_DIR/metadata.txt"

echo "Test completed. Results in $OUTPUT_DIR"
EOF

# Update run_all_tests to use test reporting
cat > ~/ai_framework_git/tests/run_all_tests.sh << 'EOF'
#!/usr/bin/env bash
# Run all model tests and generate report

TEST_DIR=~/ai_framework_git/tests
RESULTS_DIR=$TEST_DIR/results
REPORT_DIR=$TEST_DIR/reports
REPORT_FILE=$REPORT_DIR/test_report_$(date +%Y%m%d_%H%M%S).md

mkdir -p $RESULTS_DIR $REPORT_DIR

echo "# Mirador Model Test Report" > $REPORT_FILE
echo "Generated: $(date)" >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "## Model Tests" >> $REPORT_FILE
echo "" >> $REPORT_FILE

# Make all test scripts executable
chmod +x $TEST_DIR/models/test_*.sh

# Run each model test
for test in $TEST_DIR/models/test_*.sh; do
  model_name=$(basename "$test" .sh | sed 's/test_//')
  echo "Testing $model_name..."
  
  # Run the test and capture output
  $test > $REPORT_DIR/${model_name}_output.txt 2>&1
  test_status=$?
  
  # Find the most recent result directory for this model
  result_dir=$(find $RESULTS_DIR -name "${model_name}_*" -type d | sort | tail -1)
  
  # Add to report
  echo "### $model_name" >> $REPORT_FILE
  if [ $test_status -eq 0 ] && [ -n "$result_dir" ]; then
    response_size=$(grep "Response size:" "$result_dir/metadata.txt" | cut -d: -f2- 2>/dev/null || echo "Unknown")
    response_time=$(grep "Response time:" "$result_dir/metadata.txt" | cut -d: -f2- 2>/dev/null || echo "Unknown")
    
    echo "- Status: ✅ Success" >> $REPORT_FILE
    echo "- Response size:$response_size" >> $REPORT_FILE
    echo "- Response time:$response_time" >> $REPORT_FILE
    echo "" >> $REPORT_FILE
    echo "#### Sample Output" >> $REPORT_FILE
    echo '```' >> $REPORT_FILE
    head -n 15 "$result_dir/output.txt" 2>/dev/null >> $REPORT_FILE || echo "No output available" >> $REPORT_FILE
    echo '...' >> $REPORT_FILE
    echo '```' >> $REPORT_FILE
  else
    echo "- Status: ❌ Failed" >> $REPORT_FILE
    echo "" >> $REPORT_FILE
    echo "#### Error Output" >> $REPORT_FILE
    echo '```' >> $REPORT_FILE
    cat $REPORT_DIR/${model_name}_output.txt >> $REPORT_FILE
    echo '```' >> $REPORT_FILE
  fi
  echo "" >> $REPORT_FILE
done

echo "## Chain Tests" >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "Chain tests assess how well two or more models work together in sequence." >> $REPORT_FILE
echo "" >> $REPORT_FILE

# Make chain test scripts executable
chmod +x $TEST_DIR/chains/test_*.sh

# Run each chain test
for test in $TEST_DIR/chains/test_*.sh; do
  chain_name=$(basename "$test" .sh | sed 's/test_//')
  echo "Testing $chain_name chain..."
  
  # Run the test and capture output
  $test > $REPORT_DIR/${chain_name}_chain_output.txt 2>&1
  test_status=$?
  
  # Find the most recent result directory for this chain
  result_dir=$(find $RESULTS_DIR -name "chain_${chain_name}_*" -type d | sort | tail -1)
  
  # Add to report
  echo "### $chain_name Chain" >> $REPORT_FILE
  if [ $test_status -eq 0 ] && [ -n "$result_dir" ]; then
    echo "- Status: ✅ Success" >> $REPORT_FILE
    echo "- Directory: $result_dir" >> $REPORT_FILE
    echo "" >> $REPORT_FILE
    echo "Review the chain results in the specified directory for detailed output." >> $REPORT_FILE
  else
    echo "- Status: ❌ Failed" >> $REPORT_FILE
    echo "" >> $REPORT_FILE
    echo "#### Error Output" >> $REPORT_FILE
    echo '```' >> $REPORT_FILE
    cat $REPORT_DIR/${chain_name}_chain_output.txt >> $REPORT_FILE
    echo '```' >> $REPORT_FILE
  fi
  echo "" >> $REPORT_FILE
done

echo "Test complete! Report generated at $REPORT_FILE"
echo "View the report with: less $REPORT_FILE"
EOF

# Make the fix script executable
chmod +x ~/ai_framework_git/tests/fix_tests.sh ~/ai_framework_git/tests/run_all_tests.sh

echo "✅ Test fixes complete!"
echo ""
echo "To run tests, use:"
echo "  ~/ai_framework_git/tests/run_all_tests.sh    # Run all tests"
echo "  ~/ai_framework_git/tests/models/test_guitar_expert_precise.sh    # Test a specific model"
echo "  ~/ai_framework_git/tests/chains/test_guitar_chain.sh    # Test a specific chain"