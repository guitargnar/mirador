#!/usr/bin/env bash
# Run all model tests and generate report

TEST_DIR=~/ai_framework_git/tests
RESULTS_DIR=$TEST_DIR/results
REPORT_FILE=$RESULTS_DIR/test_report_$(date +%Y%m%d_%H%M%S).md

mkdir -p $RESULTS_DIR

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
  
  # Run the test
  $test
  
  # Find the most recent result directory for this model
  result_dir=$(find $RESULTS_DIR -name "${model_name}_*" -type d | sort | tail -1)
  
  if [ -n "$result_dir" ]; then
    response_size=$(grep "Response size:" "$result_dir/metadata.txt" | cut -d: -f2-)
    response_time=$(grep "Response time:" "$result_dir/metadata.txt" | cut -d: -f2-)
    
    # Add to report
    echo "### $model_name" >> $REPORT_FILE
    echo "- Response size:$response_size" >> $REPORT_FILE
    echo "- Response time:$response_time" >> $REPORT_FILE
    echo "" >> $REPORT_FILE
    echo "#### Sample Output" >> $REPORT_FILE
    echo '```' >> $REPORT_FILE
    head -n 15 "$result_dir/output.txt" 2>/dev/null >> $REPORT_FILE
    echo '...' >> $REPORT_FILE
    echo '```' >> $REPORT_FILE
    echo "" >> $REPORT_FILE
  fi
done

echo "## Chain Tests" >> $REPORT_FILE
echo "" >> $REPORT_FILE
echo "Chain tests assess how well two or more models work together in sequence." >> $REPORT_FILE
echo "" >> $REPORT_FILE

# Create basic chain test directories
mkdir -p $TEST_DIR/chains

echo "Test complete! Report generated at $REPORT_FILE"
echo "View the report with: less $REPORT_FILE"