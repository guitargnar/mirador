#!/bin/bash
# Install diverse base LLMs for Mirador

echo "🌐 Installing Diverse Base LLMs for Mirador"
echo "=========================================="
echo ""
echo "This will download and install:"
echo "  - Gemma 2 (Google's efficient model)"
echo "  - Qwen 2.5 (Alibaba's multilingual model)"
echo "  - Phi-3 (Microsoft's ultra-efficient model)"
echo ""
echo "Estimated download size: ~15-20 GB"
echo ""

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
RESET='\033[0m'

# Function to check if model is already installed
check_model() {
    local model=$1
    if ollama list | grep -q "$model"; then
        return 0
    else
        return 1
    fi
}

# Function to pull model with progress
pull_model() {
    local model=$1
    local description=$2
    
    echo -e "\n${BLUE}Downloading $description...${RESET}"
    echo "Model: $model"
    
    if check_model "$model"; then
        echo -e "${YELLOW}✓ Already installed, skipping${RESET}"
        return 0
    fi
    
    if ollama pull "$model"; then
        echo -e "${GREEN}✓ Successfully installed $model${RESET}"
        return 0
    else
        echo -e "${RED}✗ Failed to install $model${RESET}"
        return 1
    fi
}

# Track results
INSTALLED=0
FAILED=0
SKIPPED=0

echo -e "${BLUE}Starting installation...${RESET}"

# 1. Gemma 2 - Available in multiple sizes
echo -e "\n${YELLOW}1. Gemma 2 Family${RESET}"
echo "Gemma 2 is Google's efficient model family with strong reasoning"
echo "Available sizes: 2B (1.6GB), 9B (5.5GB), 27B (16GB)"
echo ""
read -p "Which size? (2/9/27) [9]: " gemma_size
gemma_size=${gemma_size:-9}

case $gemma_size in
    2)
        if pull_model "gemma2:2b" "Gemma 2 2B - Ultra efficient"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    9)
        if pull_model "gemma2:9b" "Gemma 2 9B - Balanced performance"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    27)
        if pull_model "gemma2:27b" "Gemma 2 27B - Maximum capability"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    *)
        echo -e "${RED}Invalid size, skipping Gemma 2${RESET}"
        ((SKIPPED++))
        ;;
esac

# 2. Qwen 2.5 - Multilingual powerhouse
echo -e "\n${YELLOW}2. Qwen 2.5 Family${RESET}"
echo "Qwen 2.5 is Alibaba's model with excellent multilingual support"
echo "Available sizes: 0.5B (397MB), 1.5B (986MB), 3B (1.9GB), 7B (4.7GB), 14B (9.0GB), 32B (20GB)"
echo ""
read -p "Which size? (0.5/1.5/3/7/14/32) [7]: " qwen_size
qwen_size=${qwen_size:-7}

case $qwen_size in
    0.5)
        if pull_model "qwen2.5:0.5b" "Qwen 2.5 0.5B - Nano size"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    1.5)
        if pull_model "qwen2.5:1.5b" "Qwen 2.5 1.5B - Tiny but capable"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    3)
        if pull_model "qwen2.5:3b" "Qwen 2.5 3B - Small efficient"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    7)
        if pull_model "qwen2.5:7b" "Qwen 2.5 7B - Balanced"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    14)
        if pull_model "qwen2.5:14b" "Qwen 2.5 14B - High performance"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    32)
        if pull_model "qwen2.5:32b" "Qwen 2.5 32B - Maximum capability"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    *)
        echo -e "${RED}Invalid size, skipping Qwen 2.5${RESET}"
        ((SKIPPED++))
        ;;
esac

# 3. Phi-3 - Microsoft's efficient model
echo -e "\n${YELLOW}3. Phi-3 Family${RESET}"
echo "Phi-3 is Microsoft's ultra-efficient model optimized for speed"
echo "Available sizes: mini (2.3GB), medium (7.9GB)"
echo ""
read -p "Which size? (mini/medium) [mini]: " phi_size
phi_size=${phi_size:-mini}

case $phi_size in
    mini)
        if pull_model "phi3:mini" "Phi-3 Mini - Fast and efficient"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    medium)
        if pull_model "phi3:medium" "Phi-3 Medium - Balanced"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    *)
        echo -e "${RED}Invalid size, skipping Phi-3${RESET}"
        ((SKIPPED++))
        ;;
esac

# 4. Optional: Additional specialized models
echo -e "\n${YELLOW}4. Optional Specialized Models${RESET}"
echo "Would you like to install any specialized models?"
echo "  a) Starcoder2 (3B/7B/15B) - Code generation"
echo "  b) Granite-code (3B/8B/20B/34B) - IBM's code model"
echo "  c) Solar (10.7B) - Upstage's efficient model"
echo "  d) Command-R (35B) - Cohere's RAG-optimized model"
echo "  e) Skip optional models"
echo ""
read -p "Choose (a/b/c/d/e) [e]: " optional_choice
optional_choice=${optional_choice:-e}

case $optional_choice in
    a)
        read -p "Starcoder2 size (3/7/15) [3]: " sc_size
        sc_size=${sc_size:-3}
        if pull_model "starcoder2:${sc_size}b" "Starcoder2 ${sc_size}B - Code specialist"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    b)
        read -p "Granite-code size (3/8/20/34) [8]: " gc_size
        gc_size=${gc_size:-8}
        if pull_model "granite-code:${gc_size}b" "Granite-code ${gc_size}B - IBM code model"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    c)
        if pull_model "solar:10.7b" "Solar 10.7B - Efficient general model"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    d)
        if pull_model "command-r:35b" "Command-R 35B - RAG optimized"; then
            ((INSTALLED++))
        else
            ((FAILED++))
        fi
        ;;
    e)
        echo "Skipping optional models"
        ;;
esac

# Summary
echo -e "\n${BLUE}=========================================${RESET}"
echo -e "${BLUE}Installation Summary${RESET}"
echo -e "${BLUE}=========================================${RESET}"
echo -e "Installed: ${GREEN}$INSTALLED${RESET}"
echo -e "Failed: ${RED}$FAILED${RESET}"
echo -e "Skipped: ${YELLOW}$SKIPPED${RESET}"

# Show current models
echo -e "\n${BLUE}Current Ollama Models:${RESET}"
ollama list

# Calculate diversity score
echo -e "\n${BLUE}Model Diversity Analysis:${RESET}"
TOTAL_MODELS=$(ollama list | tail -n +2 | wc -l)
LLAMA_MODELS=$(ollama list | tail -n +2 | grep -i llama | wc -l)
NON_LLAMA=$((TOTAL_MODELS - LLAMA_MODELS))

if [ $TOTAL_MODELS -gt 0 ]; then
    DIVERSITY_PERCENT=$((NON_LLAMA * 100 / TOTAL_MODELS))
    echo "Total models: $TOTAL_MODELS"
    echo "Llama-based: $LLAMA_MODELS"
    echo "Non-Llama: $NON_LLAMA"
    echo -e "Diversity score: ${GREEN}$DIVERSITY_PERCENT%${RESET} non-Llama models"
    
    if [ $DIVERSITY_PERCENT -lt 10 ]; then
        echo -e "${RED}⚠️  Low diversity - consider adding more non-Llama models${RESET}"
    elif [ $DIVERSITY_PERCENT -lt 25 ]; then
        echo -e "${YELLOW}📊 Moderate diversity - getting better${RESET}"
    else
        echo -e "${GREEN}✅ Good diversity - well balanced model ecosystem${RESET}"
    fi
fi

echo -e "\n${GREEN}✅ Installation complete!${RESET}"
echo ""
echo "Next steps:"
echo "1. Run cleanup script to remove duplicates: ./cleanup_duplicate_models.sh"
echo "2. Create custom models using new base LLMs: ./create_diverse_models.sh"
echo "3. Update Mirador chains to use new models"