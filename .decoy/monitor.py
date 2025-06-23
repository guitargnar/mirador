#!/usr/bin/env python3
"""
Honeypot monitoring script
Logs access attempts to decoy files
"""

import os
import datetime
import hashlib

def log_access(filename):
    """Log access attempts to honeypot files"""
    timestamp = datetime.datetime.now().isoformat()
    user = os.environ.get('USER', 'unknown')
    
    # Create hash of system info for tracking
    system_hash = hashlib.sha256(
        f"{user}{os.environ.get('HOSTNAME', 'unknown')}".encode()
    ).hexdigest()[:8]
    
    log_entry = f"[{timestamp}] Access detected: {filename} by {system_hash}\n"
    
    # Log to hidden file
    with open('.security_monitor.log', 'a') as f:
        f.write(log_entry)
    
    return True

if __name__ == "__main__":
    # This script intentionally does nothing visible
    # It's a decoy to detect unauthorized execution
    pass