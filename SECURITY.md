# 🔒 Mirador Security Guidelines

## Overview
This document outlines security measures implemented to protect sensitive data and maintain privacy.

## Multi-Layer Protection Strategy

### 1. Prevention Layer (.gitignore)
- 245+ exclusion patterns
- Multi-pattern matching for sensitive data
- Recursive directory exclusion
- Case-insensitive pattern matching

### 2. Detection Layer (Pre-commit Hook)
- Automated scanning before every commit
- Pattern matching for:
  - Personal identifiers
  - Financial information
  - API credentials
  - Family member names
- Filename and content validation

### 3. Obfuscation Layer
- Generic naming conventions for sensitive operations
- Separation of configuration from code
- Environment variable usage

### 4. Misdirection Layer
- Honeypot files to detect unauthorized access
- Decoy directories for security monitoring
- False trails for malicious actors

## Security Patterns

### Personal Data Protection
```
*humana*        # Employer references
*401k*          # Financial accounts
*salary*        # Compensation data
*aurora*        # Family members
matthew_*       # Personal identifiers
```

### Credential Protection
```
*.env           # Environment files
*api_key*       # API credentials
*secret*        # Secret keys
*token*         # Access tokens
*.pem/*.key     # Certificates
```

### Output Sanitization
- Chain outputs with personal context auto-excluded
- Memory database protected
- Conversation logs filtered

## Incident Response

If sensitive data is accidentally committed:

1. **Immediate Actions**
   ```bash
   # Remove from latest commit
   git reset HEAD~1
   
   # Or use BFG Repo-Cleaner for history
   bfg --delete-files <filename>
   git push --force
   ```

2. **Credential Rotation**
   - Change ALL exposed credentials immediately
   - Assume permanent compromise
   - Update security monitoring

3. **Audit Trail**
   - Document the incident
   - Review how it bypassed protections
   - Update patterns to prevent recurrence

## Best Practices

### For Development
- Always use environment variables for secrets
- Create `.env.example` with dummy values
- Test pre-commit hooks regularly
- Review git status before committing

### For Configuration
```bash
# Good: Using environment variable
API_KEY = os.getenv('MIRADOR_API_KEY')

# Bad: Hardcoded secret
API_KEY = 'sk-actual-key-here'
```

### For Documentation
- Never include real examples of sensitive data
- Use placeholders like `<YOUR_API_KEY>`
- Separate public docs from private notes

## Monitoring

### Git Hook Validation
```bash
# Test pre-commit hook
echo "test humana data" > test.txt
git add test.txt
git commit -m "test"  # Should fail
```

### Regular Audits
```bash
# Search for potential leaks
git log -p | grep -i -E "(api_key|password|token|secret)"

# Check large files
find . -type f -size +1M | grep -v ".git"
```

## Advanced Techniques

### 1. File Encryption
For extremely sensitive data, use GPG encryption:
```bash
# Encrypt
gpg -c sensitive_file.txt

# Decrypt
gpg -d sensitive_file.txt.gpg
```

### 2. Commit Signing
```bash
# Configure GPG signing
git config --global user.signingkey <YOUR_KEY_ID>
git config --global commit.gpgsign true
```

### 3. Repository Monitoring
- Enable GitHub secret scanning
- Use git-secrets tool
- Regular dependency audits

## Emergency Contacts

For security incidents:
1. Rotate all credentials
2. Force push cleaned history
3. Document in `security_incidents.log`

Remember: **Prevention > Detection > Response**

---

*This security configuration is designed to protect personal and financial information while maintaining usability for legitimate development.*