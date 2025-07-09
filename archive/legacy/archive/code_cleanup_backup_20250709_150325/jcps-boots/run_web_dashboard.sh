#!/bin/bash
# School Transfer Web Dashboard Runner

echo "🎯 Starting School Transfer Web Dashboard..."
echo "================================"

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
source venv/bin/activate

# Install dependencies
echo "Installing dependencies..."
pip install -r requirements_web.txt

# Run the Streamlit app
echo "Launching web dashboard..."
streamlit run school_transfer_dashboard.py --server.port 8501 --server.address localhost

# Deactivate virtual environment on exit
deactivate