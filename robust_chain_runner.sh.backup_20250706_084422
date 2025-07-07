


run_chain_with_retry() {
    local prompt="$1"
    shift
    local models="$@"
    local max_retries=2
    local retry_count=0
    
    while [ $retry_count -lt $max_retries ]; do
        echo "Attempt $((retry_count + 1)) of $max_retries..."
        
        
        timeout 300 mirador-ez chain "$prompt" $models
        
        if [ $? -eq 0 ]; then
            echo "Chain completed successfully!"
            return 0
        else
            echo "Chain failed or timed out. Retrying..."
            retry_count=$((retry_count + 1))
            sleep 5
        fi
    done
    
    echo "Chain failed after $max_retries attempts"
    return 1
}


if [ $
    echo "Usage: $0 \"prompt\" model1 model2 ..."
    exit 1
fi


run_chain_with_retry "$@"
