#!/bin/bash
# Mirador Branded Terminal Header
# Source this file to display branded headers in scripts

# Colors
DEEP_FOREST='\033[38;2;27;58;51m'
SAGE='\033[38;2;123;158;137m'
TERRACOTTA='\033[38;2;209;122;71m'
SAND='\033[38;2;232;220;198m'
NC='\033[0m' # No Color

# Function to display full header
mirador_header() {
    echo -e "${SAGE}"
    echo "    __  __ ___ ____      _    ____   ___  ____  "
    echo "   |  \\/  |_ _|  _ \\    / \\  |  _ \\ / _ \\|  _ \\ "
    echo "   | |\\/| || || |_) |  / _ \\ | | | | | | | |_) |"
    echo "   | |  | || ||  _ <  / ___ \\| |_| | |_| |  _ < "
    echo "   |_|  |_|___|_| \\_\\/_/   \\_\\____/ \\___/|_| \\_\\"
    echo -e "${NC}"
    echo -e "${TERRACOTTA}        Observe. Adapt. Remain.${NC}"
    echo ""
}

# Function to display minimal header
mirador_header_mini() {
    echo -e "${SAGE}MIRADOR${NC} - ${TERRACOTTA}Observe. Adapt. Remain.${NC}"
    echo ""
}

# Function to display separator
mirador_separator() {
    echo -e "${SAGE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Function to display status message
mirador_status() {
    local status=$1
    local message=$2
    
    case $status in
        "success")
            echo -e "${SAGE}✓${NC} $message"
            ;;
        "error")
            echo -e "${TERRACOTTA}✗${NC} $message"
            ;;
        "info")
            echo -e "${DEEP_FOREST}ℹ${NC} $message"
            ;;
        "observe")
            echo -e "${SAGE}👁${NC}  $message"
            ;;
        "adapt")
            echo -e "${TERRACOTTA}↻${NC} $message"
            ;;
        "remain")
            echo -e "${DEEP_FOREST}▣${NC} $message"
            ;;
    esac
}