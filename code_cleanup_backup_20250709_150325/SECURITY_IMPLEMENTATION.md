# Mirador Security Implementation

## Overview

Mirador implements defense-in-depth security architecture ensuring complete privacy and data protection through multiple layers:

1. **Local-Only Execution** - No external API calls or cloud dependencies
2. **Data Encryption** - All stored data encrypted at rest
3. **Access Control** - Multi-factor authentication and audit trails
4. **Sensitive Data Protection** - Pattern-based detection and redaction
5. **Tamper Detection** - Cryptographic integrity verification

## 1. Privacy-First Architecture

### Network Isolation

```python
class NetworkIsolation:
    def __init__(self):
        self.blocked_ports = [80, 443, 8080, 8443]
        self.blocked_hosts = [
            r'.*\.openai\.com',
            r'.*\.anthropic\.com',
            r'.*\.google\.com',
            r'.*\.microsoft\.com',
            r'.*api.*'
        ]
        self.firewall_rules = []
        
    def enforce_isolation(self):
        """
        Enforce complete network isolation for privacy
        """
        # Block outbound connections
        for port in self.blocked_ports:
            self._add_firewall_rule(
                direction='outbound',
                port=port,
                action='block'
            )
        
        # DNS filtering
        self._configure_dns_blocking()
        
        # Monitor network activity
        self._start_network_monitor()
        
    def _add_firewall_rule(self, direction: str, port: int, action: str):
        """
        Add firewall rule using pfctl (macOS)
        """
        rule = f"block {direction} proto tcp from any to any port {port}"
        subprocess.run(
            ['sudo', 'pfctl', '-f', '-'],
            input=rule.encode(),
            check=True
        )
        self.firewall_rules.append(rule)
    
    def _configure_dns_blocking(self):
        """
        Block DNS resolution for cloud services
        """
        hosts_content = []
        for pattern in self.blocked_hosts:
            # Add common variations
            hosts_content.extend([
                f"127.0.0.1 {pattern}",
                f"::1 {pattern}"
            ])
        
        # Update /etc/hosts
        with open('/etc/hosts', 'a') as f:
            f.write('\n# Mirador Privacy Protection\n')
            f.write('\n'.join(hosts_content))
    
    def verify_isolation(self) -> bool:
        """
        Verify no external connections possible
        """
        test_endpoints = [
            'https://api.openai.com',
            'https://api.anthropic.com',
            'https://www.google.com'
        ]
        
        for endpoint in test_endpoints:
            try:
                response = requests.get(endpoint, timeout=2)
                if response.status_code == 200:
                    raise SecurityError(f"External connection possible to {endpoint}")
            except (requests.ConnectionError, requests.Timeout):
                # Expected - connection should fail
                continue
                
        return True
```

### Local Model Verification

```python
class ModelIntegrity:
    def __init__(self):
        self.trusted_hashes = self._load_trusted_hashes()
        self.model_path = os.path.expanduser('~/.ollama/models')
        
    def verify_all_models(self) -> Dict[str, bool]:
        """
        Verify integrity of all local models
        """
        results = {}
        
        for model_name in os.listdir(self.model_path):
            model_file = os.path.join(self.model_path, model_name)
            
            # Calculate SHA256
            calculated_hash = self._calculate_file_hash(model_file)
            
            # Verify against trusted hash
            trusted_hash = self.trusted_hashes.get(model_name)
            
            if trusted_hash:
                results[model_name] = calculated_hash == trusted_hash
            else:
                # New model - add to pending verification
                results[model_name] = None
                self._log_new_model(model_name, calculated_hash)
        
        return results
    
    def _calculate_file_hash(self, filepath: str) -> str:
        """
        Calculate SHA256 hash of file
        """
        sha256_hash = hashlib.sha256()
        with open(filepath, "rb") as f:
            for byte_block in iter(lambda: f.read(4096), b""):
                sha256_hash.update(byte_block)
        return sha256_hash.hexdigest()
```

## 2. Data Encryption

### Storage Encryption

```python
from cryptography.fernet import Fernet
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
import base64
import os

class StorageEncryption:
    def __init__(self, password: str = None):
        self.key = self._derive_key(password)
        self.cipher = Fernet(self.key)
        
    def _derive_key(self, password: str = None) -> bytes:
        """
        Derive encryption key from password or hardware
        """
        if password:
            # Password-based key derivation
            kdf = PBKDF2HMAC(
                algorithm=hashes.SHA256(),
                length=32,
                salt=self._get_hardware_salt(),
                iterations=100000,
            )
            key = base64.urlsafe_b64encode(
                kdf.derive(password.encode())
            )
        else:
            # Hardware-based key (Apple Secure Enclave)
            key = self._get_hardware_key()
            
        return key
    
    def _get_hardware_salt(self) -> bytes:
        """
        Generate salt from hardware identifiers
        """
        import subprocess
        
        # Get hardware UUID (macOS)
        result = subprocess.run(
            ['system_profiler', 'SPHardwareDataType'],
            capture_output=True,
            text=True
        )
        
        hardware_uuid = None
        for line in result.stdout.split('\n'):
            if 'Hardware UUID' in line:
                hardware_uuid = line.split(':')[1].strip()
                break
        
        if not hardware_uuid:
            raise SecurityError("Cannot access hardware identifier")
            
        return hardware_uuid.encode()[:16]  # Use first 16 bytes as salt
    
    def encrypt_data(self, data: str) -> bytes:
        """
        Encrypt sensitive data
        """
        return self.cipher.encrypt(data.encode())
    
    def decrypt_data(self, encrypted_data: bytes) -> str:
        """
        Decrypt sensitive data
        """
        return self.cipher.decrypt(encrypted_data).decode()
    
    def encrypt_file(self, filepath: str):
        """
        Encrypt file in place
        """
        with open(filepath, 'rb') as f:
            file_data = f.read()
        
        encrypted_data = self.cipher.encrypt(file_data)
        
        with open(filepath + '.enc', 'wb') as f:
            f.write(encrypted_data)
        
        # Secure delete original
        self._secure_delete(filepath)
    
    def _secure_delete(self, filepath: str):
        """
        Securely overwrite and delete file
        """
        filesize = os.path.getsize(filepath)
        
        with open(filepath, 'ba+', buffering=0) as f:
            # Overwrite with random data 3 times
            for _ in range(3):
                f.seek(0)
                f.write(os.urandom(filesize))
                f.flush()
                os.fsync(f.fileno())
        
        # Remove file
        os.remove(filepath)
```

### Database Encryption

```python
import sqlite3
from sqlcipher3 import dbapi2 as sqlcipher

class EncryptedDatabase:
    def __init__(self, db_path: str, key: str):
        self.db_path = db_path
        self.key = key
        self.conn = None
        
    def connect(self):
        """
        Connect to encrypted SQLite database
        """
        self.conn = sqlcipher.connect(self.db_path)
        
        # Set encryption key
        self.conn.execute(f"PRAGMA key = '{self.key}'")
        
        # Verify encryption
        try:
            self.conn.execute("SELECT count(*) FROM sqlite_master")
        except sqlcipher.DatabaseError:
            raise SecurityError("Invalid encryption key")
        
        # Additional security settings
        self.conn.execute("PRAGMA cipher_page_size = 4096")
        self.conn.execute("PRAGMA kdf_iter = 64000")
        self.conn.execute("PRAGMA cipher_hmac_algorithm = HMAC_SHA512")
        
    def execute_secure(self, query: str, params: tuple = None):
        """
        Execute query with parameter binding (prevent SQL injection)
        """
        if not self.conn:
            self.connect()
            
        # Validate query doesn't contain dangerous operations
        dangerous_keywords = ['DROP', 'DELETE', 'TRUNCATE', 'ALTER']
        query_upper = query.upper()
        
        for keyword in dangerous_keywords:
            if keyword in query_upper and 'WHERE' not in query_upper:
                raise SecurityError(f"Dangerous operation {keyword} without WHERE clause")
        
        # Execute with parameter binding
        cursor = self.conn.cursor()
        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)
            
        return cursor
```

## 3. Sensitive Data Protection

### Pattern Detection and Redaction

```python
import re
from typing import List, Dict, Tuple

class SensitiveDataProtector:
    def __init__(self):
        self.patterns = self._compile_patterns()
        self.redaction_stats = defaultdict(int)
        
    def _compile_patterns(self) -> Dict[str, re.Pattern]:
        """
        Compile regex patterns for sensitive data
        """
        patterns = {
            'ssn': re.compile(r'\b\d{3}-\d{2}-\d{4}\b'),
            'credit_card': re.compile(r'\b\d{4}[\s-]?\d{4}[\s-]?\d{4}[\s-]?\d{4}\b'),
            'phone': re.compile(r'\b\d{3}[-.]?\d{3}[-.]?\d{4}\b'),
            'email': re.compile(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'),
            'address': re.compile(
                r'\b\d+\s+[A-Za-z\s]+\s+(Street|St|Avenue|Ave|Road|Rd|Boulevard|Blvd)\b',
                re.IGNORECASE
            ),
            'api_key': re.compile(r'\b(api[_-]?key|token)[\s:=]+[\w-]{20,}\b', re.IGNORECASE),
            'password': re.compile(
                r'\b(password|passwd|pwd)[\s:=]+[^\s]+\b', 
                re.IGNORECASE
            ),
            # Personal identifiers
            'company_id': re.compile(r'\b(company|employee)[\s_-]?(id|number)[\s:=]+\w+\b', re.IGNORECASE),
            'salary': re.compile(r'\$[\d,]+(?:\.\d{2})?\s*(?:salary|income|compensation)', re.IGNORECASE),
            '401k': re.compile(r'\b401k|retirement|pension\b.*\$[\d,]+', re.IGNORECASE),
            'aurora': re.compile(r'\bAurora\b(?:\s+Scott)?', re.IGNORECASE),
            'bank_account': re.compile(r'\b\d{9,12}\b'),  # Routing/account numbers
        }
        
        return patterns
    
    def scan_and_redact(self, text: str, context: str = None) -> Tuple[str, List[Dict]]:
        """
        Scan text for sensitive data and redact
        """
        redacted_text = text
        findings = []
        
        for pattern_name, pattern in self.patterns.items():
            matches = list(pattern.finditer(text))
            
            for match in matches:
                # Record finding
                findings.append({
                    'type': pattern_name,
                    'position': match.span(),
                    'context': text[max(0, match.start()-20):match.end()+20],
                    'severity': self._assess_severity(pattern_name, match.group())
                })
                
                # Redact based on type
                redaction = self._get_redaction(pattern_name, match.group())
                redacted_text = redacted_text.replace(match.group(), redaction)
                
                # Update stats
                self.redaction_stats[pattern_name] += 1
        
        return redacted_text, findings
    
    def _assess_severity(self, pattern_type: str, value: str) -> str:
        """
        Assess severity of sensitive data exposure
        """
        high_severity = ['ssn', 'credit_card', 'api_key', 'password', 'bank_account']
        medium_severity = ['salary', '401k', 'company_id', 'email']
        
        if pattern_type in high_severity:
            return 'HIGH'
        elif pattern_type in medium_severity:
            return 'MEDIUM'
        else:
            return 'LOW'
    
    def _get_redaction(self, pattern_type: str, value: str) -> str:
        """
        Get appropriate redaction for data type
        """
        redactions = {
            'ssn': '[SSN-REDACTED]',
            'credit_card': '[CC-REDACTED]',
            'phone': '[PHONE-REDACTED]',
            'email': '[EMAIL-REDACTED]',
            'address': '[ADDRESS-REDACTED]',
            'api_key': '[API-KEY-REDACTED]',
            'password': '[PASSWORD-REDACTED]',
            'company_id': '[EMPLOYEE-ID-REDACTED]',
            'salary': '[SALARY-REDACTED]',
            '401k': '[401K-REDACTED]',
            'aurora': '[FAMILY-MEMBER]',
            'bank_account': '[ACCOUNT-REDACTED]'
        }
        
        return redactions.get(pattern_type, '[REDACTED]')
```

### Pre-commit Hook Implementation

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Mirador Security Pre-commit Hook
# Prevents accidental commit of sensitive data

echo "🔒 Mirador Security Check..."

# Define sensitive patterns
SENSITIVE_PATTERNS=(
    "company"
    "401k"
    "salary"
    "matthew_"
    "\$[0-9]{2,}"
    "API_KEY"
    "SECRET"
    "PASSWORD"
    "Aurora Scott"
    "[0-9]{3}-[0-9]{2}-[0-9]{4}"  # SSN
)

# Files to check
FILES=$(git diff --cached --name-only --diff-filter=ACM | grep -E '\.(py|sh|md|txt|json|yaml|yml)$')

# Check each file
FOUND_SENSITIVE=0
for file in $FILES; do
    if [ -f "$file" ]; then
        for pattern in "${SENSITIVE_PATTERNS[@]}"; do
            if grep -Ei "$pattern" "$file" > /dev/null; then
                echo "❌ WARNING: Sensitive pattern '$pattern' found in $file"
                FOUND_SENSITIVE=1
                
                # Show context
                grep -Ein "$pattern" "$file" | head -3
            fi
        done
    fi
done

# Check for large files that might contain data
LARGE_FILES=$(git diff --cached --name-only --diff-filter=ACM | xargs -I {} sh -c 'if [ -f "{}" ] && [ $(stat -f%z "{}") -gt 1048576 ]; then echo "{}"; fi')

if [ ! -z "$LARGE_FILES" ]; then
    echo "❌ WARNING: Large files detected (>1MB):"
    echo "$LARGE_FILES"
    FOUND_SENSITIVE=1
fi

# Verify .gitignore is not being modified to expose sensitive data
if git diff --cached --name-only | grep -q "\.gitignore"; then
    echo "⚠️  NOTICE: .gitignore is being modified"
    echo "Verifying security patterns remain..."
    
    # Check if critical patterns are being removed
    CRITICAL_PATTERNS=("*company*" "*401k*" "*salary*" "matthew_*.json")
    for pattern in "${CRITICAL_PATTERNS[@]}"; do
        if ! git show :".gitignore" | grep -q "$pattern"; then
            echo "❌ BLOCKED: Critical security pattern '$pattern' removed from .gitignore"
            exit 1
        fi
    done
fi

if [ $FOUND_SENSITIVE -eq 1 ]; then
    echo ""
    echo "🛑 Commit blocked due to sensitive data detection."
    echo ""
    echo "Options:"
    echo "1. Remove sensitive data from files"
    echo "2. Add files to .gitignore"
    echo "3. Use 'git commit --no-verify' to bypass (NOT RECOMMENDED)"
    echo ""
    exit 1
fi

echo "✅ Security check passed"
```

## 4. Access Control

### Multi-Factor Authentication

```python
import pyotp
import qrcode
from datetime import datetime, timedelta
import json

class AccessControl:
    def __init__(self, config_path: str):
        self.config_path = config_path
        self.sessions = {}
        self.failed_attempts = defaultdict(list)
        self.lockout_threshold = 3
        self.lockout_duration = timedelta(minutes=15)
        
    def setup_2fa(self, user_id: str) -> str:
        """
        Set up 2FA for user
        """
        # Generate secret
        secret = pyotp.random_base32()
        
        # Create TOTP URI
        totp_uri = pyotp.totp.TOTP(secret).provisioning_uri(
            name=user_id,
            issuer_name='Mirador AI'
        )
        
        # Generate QR code
        qr = qrcode.QRCode(version=1, box_size=10, border=5)
        qr.add_data(totp_uri)
        qr.make(fit=True)
        
        # Save QR code
        qr_path = f"/tmp/mirador_2fa_{user_id}.png"
        img = qr.make_image(fill_color="black", back_color="white")
        img.save(qr_path)
        
        # Store secret securely
        self._store_secret(user_id, secret)
        
        return qr_path
    
    def verify_2fa(self, user_id: str, token: str) -> bool:
        """
        Verify 2FA token
        """
        # Check if user is locked out
        if self._is_locked_out(user_id):
            return False
        
        # Get user's secret
        secret = self._get_secret(user_id)
        if not secret:
            return False
        
        # Verify token
        totp = pyotp.TOTP(secret)
        is_valid = totp.verify(token, valid_window=1)
        
        # Track attempt
        if not is_valid:
            self.failed_attempts[user_id].append(datetime.now())
            
            # Check for lockout
            recent_failures = [
                attempt for attempt in self.failed_attempts[user_id]
                if datetime.now() - attempt < self.lockout_duration
            ]
            
            if len(recent_failures) >= self.lockout_threshold:
                self._trigger_lockout(user_id)
        else:
            # Clear failed attempts on success
            self.failed_attempts[user_id] = []
            
            # Create session
            self._create_session(user_id)
        
        return is_valid
    
    def _is_locked_out(self, user_id: str) -> bool:
        """
        Check if user is locked out
        """
        lockout_file = f"/tmp/mirador_lockout_{user_id}"
        
        if os.path.exists(lockout_file):
            with open(lockout_file, 'r') as f:
                lockout_data = json.load(f)
                
            lockout_until = datetime.fromisoformat(lockout_data['until'])
            
            if datetime.now() < lockout_until:
                return True
            else:
                # Lockout expired
                os.remove(lockout_file)
                
        return False
```

## 5. Audit and Compliance

### Tamper-Evident Logging

```python
import hashlib
import json
from datetime import datetime
from typing import Dict, Any

class TamperEvidentLog:
    def __init__(self, log_path: str):
        self.log_path = log_path
        self.current_hash = self._get_last_hash()
        
    def log_event(self, event_type: str, details: Dict[str, Any]):
        """
        Log security event with tamper detection
        """
        event = {
            'timestamp': datetime.now().isoformat(),
            'type': event_type,
            'details': details,
            'previous_hash': self.current_hash,
            'hash': None
        }
        
        # Calculate hash including previous hash
        event_string = json.dumps(event, sort_keys=True)
        event['hash'] = hashlib.sha256(event_string.encode()).hexdigest()
        
        # Write to log
        with open(self.log_path, 'a') as f:
            f.write(json.dumps(event) + '\n')
        
        # Update current hash
        self.current_hash = event['hash']
        
        # Trigger alerts for critical events
        if event_type in ['unauthorized_access', 'data_breach', 'tampering_detected']:
            self._trigger_security_alert(event)
    
    def verify_integrity(self) -> Tuple[bool, List[int]]:
        """
        Verify log hasn't been tampered with
        """
        if not os.path.exists(self.log_path):
            return True, []
        
        tampered_lines = []
        previous_hash = None
        
        with open(self.log_path, 'r') as f:
            for line_num, line in enumerate(f, 1):
                try:
                    event = json.loads(line.strip())
                    
                    # Verify previous hash matches
                    if event['previous_hash'] != previous_hash:
                        tampered_lines.append(line_num)
                        continue
                    
                    # Recalculate hash
                    stored_hash = event['hash']
                    event['hash'] = None
                    event_string = json.dumps(event, sort_keys=True)
                    calculated_hash = hashlib.sha256(event_string.encode()).hexdigest()
                    
                    # Verify hash matches
                    if calculated_hash != stored_hash:
                        tampered_lines.append(line_num)
                    
                    previous_hash = stored_hash
                    
                except (json.JSONDecodeError, KeyError):
                    tampered_lines.append(line_num)
        
        return len(tampered_lines) == 0, tampered_lines
    
    def _trigger_security_alert(self, event: Dict):
        """
        Trigger security alert for critical events
        """
        # Log to system log
        import syslog
        syslog.syslog(
            syslog.LOG_ALERT,
            f"MIRADOR SECURITY ALERT: {event['type']} - {json.dumps(event['details'])}"
        )
        
        # Create alert file
        alert_file = f"/tmp/mirador_alert_{event['hash'][:8]}.json"
        with open(alert_file, 'w') as f:
            json.dump(event, f, indent=2)
        
        # Set restrictive permissions
        os.chmod(alert_file, 0o600)
```

## 6. Security Monitoring

### Real-time Threat Detection

```python
class SecurityMonitor:
    def __init__(self):
        self.threat_patterns = self._load_threat_patterns()
        self.anomaly_detector = AnomalyDetector()
        self.monitoring_thread = None
        
    def start_monitoring(self):
        """
        Start real-time security monitoring
        """
        self.monitoring_thread = threading.Thread(
            target=self._monitor_loop,
            daemon=True
        )
        self.monitoring_thread.start()
    
    def _monitor_loop(self):
        """
        Main monitoring loop
        """
        while True:
            try:
                # Check file system integrity
                self._check_file_integrity()
                
                # Monitor process activity
                self._monitor_processes()
                
                # Check network connections
                self._check_network_activity()
                
                # Analyze access patterns
                self._analyze_access_patterns()
                
                # Sleep before next check
                time.sleep(10)
                
            except Exception as e:
                self._log_monitoring_error(e)
    
    def _check_file_integrity(self):
        """
        Monitor critical files for changes
        """
        critical_files = [
            '~/.ollama/models',
            '~/mirador/config',
            '~/mirador/data',
            '~/.ssh/authorized_keys'
        ]
        
        for file_path in critical_files:
            expanded_path = os.path.expanduser(file_path)
            
            if os.path.exists(expanded_path):
                # Check modification time
                mtime = os.path.getmtime(expanded_path)
                
                # Check against baseline
                if self._is_unexpected_modification(expanded_path, mtime):
                    self._trigger_file_alert(expanded_path, mtime)
    
    def _monitor_processes(self):
        """
        Monitor for suspicious processes
        """
        import psutil
        
        suspicious_patterns = [
            r'.*curl.*api.*',
            r'.*wget.*',
            r'.*nc\s+-.*',  # netcat
            r'.*python.*-m\s+http\.server',
            r'.*ssh.*-R.*'  # reverse tunnels
        ]
        
        for proc in psutil.process_iter(['pid', 'name', 'cmdline']):
            try:
                cmdline = ' '.join(proc.info['cmdline'] or [])
                
                for pattern in suspicious_patterns:
                    if re.match(pattern, cmdline):
                        self._investigate_process(proc)
                        
            except (psutil.NoSuchProcess, psutil.AccessDenied):
                continue
```

## 7. Decoy and Honeypot System

### Honeypot Implementation

```python
class HoneypotSystem:
    def __init__(self):
        self.honeypots = []
        self.trap_triggered = False
        
    def deploy_honeypots(self):
        """
        Deploy decoy files and services
        """
        honeypot_configs = [
            {
                'type': 'file',
                'path': '~/mirador/.env.production',
                'content': self._generate_fake_env()
            },
            {
                'type': 'file',
                'path': '~/mirador/config/api_keys.json',
                'content': self._generate_fake_api_keys()
            },
            {
                'type': 'file',
                'path': '~/Documents/passwords.txt',
                'content': self._generate_fake_passwords()
            },
            {
                'type': 'database',
                'path': '~/mirador/data/users.db',
                'content': self._generate_fake_database()
            }
        ]
        
        for config in honeypot_configs:
            self._create_honeypot(config)
            self._monitor_honeypot(config)
    
    def _generate_fake_env(self) -> str:
        """
        Generate convincing fake environment file
        """
        return """
# Production Environment Configuration
# DO NOT COMMIT THIS FILE

DATABASE_URL=postgresql://admin:xK9$mP2@localhost:5432/mirador_prod
REDIS_URL=redis://localhost:6379/0
SECRET_KEY=4f8c5e2a9b3d7f1e6c8a2b5d9e3f7a1c4b8d6e2a
API_KEY=sk-proj-aB3dE5fG7hJ9kL2mN4pQ6rS8tU0vW2xY4zA6bC8dE0fG2hJ4kL6mN8pQ0
OPENAI_API_KEY=sk-fake-key-do-not-use-in-production
STRIPE_SECRET_KEY=sk_live_4eC39HqL0xJ2kL5mN7pR9sT1uV3wX5yZ

# Security Settings
ENCRYPTION_KEY=aes256:7f3e9b2c5d8a1f6e4b9c7d2a5e8f3b6c9d2e5f8a1b4c7d0e3f6a9b2c5d8e1f4
TWO_FACTOR_ENABLED=true
SESSION_TIMEOUT=3600

# Monitoring
SENTRY_DSN=https://abc123@sentry.io/project
DATADOG_API_KEY=dd_api_abc123def456
"""
    
    def _create_honeypot(self, config: Dict):
        """
        Create honeypot file with monitoring
        """
        path = os.path.expanduser(config['path'])
        
        # Create directory if needed
        os.makedirs(os.path.dirname(path), exist_ok=True)
        
        # Write honeypot content
        with open(path, 'w') as f:
            f.write(config['content'])
        
        # Set enticing permissions
        os.chmod(path, 0o644)  # Readable but suspicious for sensitive file
        
        # Add to monitoring list
        self.honeypots.append({
            'path': path,
            'type': config['type'],
            'created': datetime.now(),
            'accessed': []
        })
    
    def _monitor_honeypot(self, config: Dict):
        """
        Monitor honeypot for access
        """
        path = os.path.expanduser(config['path'])
        
        # Set up file system watcher
        import watchdog.observers
        import watchdog.events
        
        class HoneypotHandler(watchdog.events.FileSystemEventHandler):
            def __init__(self, honeypot_system, honeypot_path):
                self.honeypot_system = honeypot_system
                self.honeypot_path = honeypot_path
                
            def on_accessed(self, event):
                if event.src_path == self.honeypot_path:
                    self.honeypot_system._honeypot_triggered(
                        self.honeypot_path,
                        'accessed'
                    )
            
            def on_modified(self, event):
                if event.src_path == self.honeypot_path:
                    self.honeypot_system._honeypot_triggered(
                        self.honeypot_path,
                        'modified'
                    )
        
        observer = watchdog.observers.Observer()
        observer.schedule(
            HoneypotHandler(self, path),
            os.path.dirname(path),
            recursive=False
        )
        observer.start()
    
    def _honeypot_triggered(self, path: str, action: str):
        """
        Handle honeypot trigger
        """
        self.trap_triggered = True
        
        # Log security event
        event = {
            'type': 'HONEYPOT_TRIGGERED',
            'path': path,
            'action': action,
            'timestamp': datetime.now().isoformat(),
            'process': self._get_accessing_process()
        }
        
        # Immediate response
        self._initiate_incident_response(event)
```

## Security Best Practices Summary

1. **Never Trust External Input**
   - Validate all inputs
   - Use parameterized queries
   - Sanitize file paths

2. **Defense in Depth**
   - Multiple security layers
   - Assume breach mindset
   - Regular security audits

3. **Least Privilege**
   - Minimal permissions
   - Role-based access
   - Time-limited sessions

4. **Encryption Everywhere**
   - Data at rest
   - Data in transit (local only)
   - Secure key management

5. **Monitoring and Response**
   - Real-time threat detection
   - Automated incident response
   - Comprehensive audit trails

6. **Privacy by Design**
   - Local-only processing
   - No telemetry
   - User-controlled data

---

*Security is not a feature, it's a fundamental design principle of Mirador.*