#!/usr/bin/env bash
# Test for file_reviewer

echo "Testing file_reviewer..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR=~/ai_framework_git/tests/results/file_reviewer_${TIMESTAMP}
mkdir -p $OUTPUT_DIR

# Appropriate prompt for documentation model
PROMPT="Create comprehensive documentation for the following Node.js API module:

```javascript
const express = require('express');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const rateLimit = require('express-rate-limit');

const router = express.Router();
const JWT_SECRET = process.env.JWT_SECRET || 'default_secret';
const SALT_ROUNDS = 10;

// Rate limiting middleware
const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5, // 5 requests per window
  message: { error: 'Too many login attempts, please try again later' }
});

// User registration endpoint
router.post('/register', async (req, res) => {
  try {
    const { username, email, password } = req.body;
    
    // Validate input
    if (!username || !email || !password) {
      return res.status(400).json({ error: 'All fields are required' });
    }
    
    // Check if user already exists
    const existingUser = await db.findUserByEmail(email);
    if (existingUser) {
      return res.status(409).json({ error: 'User already exists' });
    }
    
    // Hash password
    const hashedPassword = await bcrypt.hash(password, SALT_ROUNDS);
    
    // Create new user
    const newUser = await db.createUser({
      username,
      email,
      password: hashedPassword
    });
    
    res.status(201).json({ message: 'User registered successfully', userId: newUser.id });
  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// User login endpoint
router.post('/login', loginLimiter, async (req, res) => {
  try {
    const { email, password } = req.body;
    
    // Validate input
    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password are required' });
    }
    
    // Find user
    const user = await db.findUserByEmail(email);
    if (!user) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    
    // Check password
    const passwordMatch = await bcrypt.compare(password, user.password);
    if (!passwordMatch) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    
    // Generate tokens
    const accessToken = jwt.sign(
      { userId: user.id, email: user.email },
      JWT_SECRET,
      { expiresIn: '1h' }
    );
    
    const refreshToken = jwt.sign(
      { userId: user.id },
      JWT_SECRET,
      { expiresIn: '7d' }
    );
    
    // Save refresh token
    await db.saveRefreshToken(user.id, refreshToken);
    
    res.json({
      accessToken,
      refreshToken,
      expiresIn: 3600 // 1 hour in seconds
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

// Token refresh endpoint
router.post('/refresh-token', async (req, res) => {
  try {
    const { refreshToken } = req.body;
    
    if (!refreshToken) {
      return res.status(400).json({ error: 'Refresh token is required' });
    }
    
    // Verify refresh token
    const decoded = jwt.verify(refreshToken, JWT_SECRET);
    
    // Check if token exists in database
    const tokenExists = await db.findRefreshToken(decoded.userId, refreshToken);
    if (!tokenExists) {
      return res.status(401).json({ error: 'Invalid refresh token' });
    }
    
    // Generate new access token
    const accessToken = jwt.sign(
      { userId: decoded.userId },
      JWT_SECRET,
      { expiresIn: '1h' }
    );
    
    res.json({
      accessToken,
      expiresIn: 3600 // 1 hour in seconds
    });
  } catch (error) {
    if (error.name === 'JsonWebTokenError' || error.name === 'TokenExpiredError') {
      return res.status(401).json({ error: 'Invalid or expired token' });
    }
    
    console.error('Token refresh error:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;
```

Include the following in your documentation:
1. Overview of the API's purpose and functionality
2. Detailed endpoint documentation with parameters, return values, and error responses
3. Authentication flow explanation
4. Rate limiting behavior
5. Security considerations
6. Usage examples
7. Dependencies and requirements"

# Run test with appropriate prompt for this model type
curl -s -X POST http://localhost:11434/api/generate \
  -d "{\"model\": \"file_reviewer\", \"prompt\": \"$PROMPT\", \"stream\": false}" \
  > "$OUTPUT_DIR/response.json"

# Extract response
cat "$OUTPUT_DIR/response.json" | tr '\n' ' ' | sed 's/.*"response":"//g' | sed 's/"}.*//g' > "$OUTPUT_DIR/output.txt"

# Log test metadata
echo "Model: file_reviewer" > "$OUTPUT_DIR/metadata.txt"
echo "Timestamp: $(date)" >> "$OUTPUT_DIR/metadata.txt"
echo "Prompt: $PROMPT" >> "$OUTPUT_DIR/metadata.txt"
echo "Response size: $(wc -c < $OUTPUT_DIR/output.txt) bytes" >> "$OUTPUT_DIR/metadata.txt"
DURATION=$(cat "$OUTPUT_DIR/response.json" | grep -o '"total_duration":[0-9]*' | cut -d':' -f2)
echo "Response time: $DURATION nanoseconds" >> "$OUTPUT_DIR/metadata.txt"

echo "Test completed. Results in $OUTPUT_DIR"