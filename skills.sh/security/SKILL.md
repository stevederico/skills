---
name: security
description: OWASP Top 10 vulnerability detection and secure coding practices
license: MIT
version: 1.0.0
---

# Security Skill

Elite web application security specialist focused on identifying and preventing security vulnerabilities with emphasis on OWASP Top 10.

## When to Use This Skill

Activate this skill when:
- Reviewing code for security vulnerabilities
- Auditing authentication/authorization implementations
- Validating input sanitization and output encoding
- Checking for exposed secrets and credentials
- Ensuring secure API design
- Auditing database query patterns for injection
- Reviewing client-side code for XSS attacks
- Assessing security headers and configurations

Do NOT use when:
- Adding features (use frontend/backend skills)
- General code cleanup (use reviewer skill)
- Writing documentation (use docs skill)
- Non-security bug fixes (use debug skill)

## Priority Matrix

| Priority | Category | Rules |
|----------|----------|-------|
| CRITICAL | Injection & XSS | S01-S04 |
| HIGH | Authentication & Access, External API Safety | S05-S09 |
| MEDIUM | Configuration & Secrets | S10-S13 |
| LOW | Logging & Headers | S14-S17 |

## Core Principles

### Priority: CRITICAL

**[S01] SQL Injection Prevention**
- NEVER concatenate user input into SQL queries
- Always use parameterized queries: `db.query('SELECT * FROM users WHERE id = ?', [userId])`
- Validate input types before database operations
- Use prepared statements for all database queries

**[S02] NoSQL Injection Prevention**
- Always validate and cast input types: `const email = String(req.body.email)`
- Never pass raw request objects directly to database queries
- Use strict equality operators in queries: `{ $eq: value }`
- Never use `$where` with user input

**[S03] Command Injection Prevention**
- Avoid shell commands with user input entirely if possible
- If unavoidable, use strict allowlist validation
- Never use `eval()` or `Function()` with user input
- Prefer library APIs over shell commands

**[S04] Cross-Site Scripting (XSS) Prevention**
- React escapes by default - this is GOOD
- Never use `dangerouslySetInnerHTML` without sanitization
- If you must use it, sanitize with DOMPurify first
- Server-side: Encode output before sending to client
- Never trust user input in HTML contexts

### Priority: HIGH

**[S05] Broken Access Control**
- Always verify user authorization before allowing access to resources
- Check ownership: `if (req.user.id !== resource.ownerId) return 403`
- Never trust client-side access control
- Implement authorization at the API level
- Prevent Insecure Direct Object References (IDOR)

**[S06] Authentication Best Practices**
- Use bcrypt, scrypt, or Argon2 for password hashing (never MD5/SHA1)
- Implement rate limiting on authentication endpoints (5 attempts per 15 min)
- Use cryptographically secure random session IDs
- Set httpOnly and secure flags on session cookies
- Regenerate session ID after login
- Implement absolute and idle timeouts

**[S07] Password Requirements**
- Minimum 12 characters
- Mix of uppercase, lowercase, numbers, symbols
- Check against common password lists
- No password in URL or logs
- Store only hashed passwords, never plaintext

**[S08] Session Management**
- Use httpOnly cookies for session tokens (not localStorage)
- Set secure flag (HTTPS only)
- Set sameSite attribute ('strict' or 'lax')
- Implement session timeout
- Invalidate sessions on logout

**[S09] External API Safety (MANDATORY)**
- Respect rate limits; exponential backoff on 429/5xx (1s->2s->4s->8s, max 3-5 retries)
- Never loop without throttling; never call batch endpoints in a loop
- Log rate limit headers from responses
- Circuit breaker after 3 consecutive external API failures
- Read API docs before writing any integration

### Priority: MEDIUM

**[S10] Secrets Management**
- Never commit .env files to version control
- Never hardcode API keys, tokens, or credentials
- Store secrets in environment variables
- Never log secrets or credentials
- Rotate secrets regularly
- Use different secrets per environment

**[S11] File Restrictions - NEVER Read/Modify**
- `.env` files
- Files matching `*/config/secrets.*`
- Files with `.pem` extension
- Any files containing API keys, tokens, or credentials

**[S12] Security Headers Required**
```javascript
res.setHeader('X-Content-Type-Options', 'nosniff')
res.setHeader('X-Frame-Options', 'DENY')
res.setHeader('X-XSS-Protection', '1; mode=block')
res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains')
res.setHeader('Content-Security-Policy', "default-src 'self'")
```

**[S13] Error Handling**
- Never expose stack traces to users
- Log errors server-side for debugging
- Return generic error messages to clients: `{ error: "Internal server error" }`
- Don't leak system details in error messages

### Priority: LOW

**[S14] Security Logging**
- Log authentication attempts (success and failure)
- Log authorization failures
- Log input validation failures
- Log configuration changes
- Log account modifications

**[S15] Never Log**
- Passwords or password hashes
- Session tokens or API keys
- Credit card numbers
- Personal identification numbers
- Any secrets or credentials

**[S16] CORS Configuration**
```javascript
// BAD: Permissive CORS
app.use(cors({ origin: '*' }))

// GOOD: Restricted CORS
app.use(cors({
  origin: ['https://yourdomain.com'],
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}))
```

**[S17] CSRF Protection**
- Use CSRF tokens for state-changing operations
- Implement SameSite cookie attribute
- Verify Origin/Referer headers
- Use custom headers for API calls

## OWASP Top 10 Coverage

### 1. Broken Access Control
- Missing authorization checks on API endpoints
- Insecure Direct Object References (IDOR)
- Path traversal vulnerabilities

### 2. Cryptographic Failures
- Weak password hashing algorithms
- Sensitive data over HTTP
- Hard-coded encryption keys

### 3. Injection
- SQL injection in database queries
- NoSQL injection in MongoDB queries
- Command injection in shell commands

### 4. Insecure Design
- Missing security controls in architecture
- Lack of defense in depth
- Insecure default configurations

### 5. Security Misconfiguration
- Default credentials in use
- Verbose error messages exposing system details
- Missing security headers

### 6. Vulnerable Components
- Outdated packages with known vulnerabilities
- Unused dependencies increasing attack surface

### 7. Authentication Failures
- Weak password requirements
- Missing rate limiting
- Predictable session IDs

### 8. Data Integrity Failures
- Unsigned software updates
- Insecure deserialization
- Missing integrity checks

### 9. Logging Failures
- Missing logs for security events
- Logs containing sensitive data
- No alerting for suspicious activity

### 10. Server-Side Request Forgery (SSRF)
- User-controlled URLs in fetch requests
- Missing URL validation
- No allowlist for external requests

## Input Validation

```javascript
// Validate all inputs
function validateEmail(email) {
  if (typeof email !== 'string') return false
  if (email.length > 255) return false
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  return regex.test(email)
}

// Sanitize inputs
const username = req.body.username.trim().substring(0, 50)
```

## Rate Limiting

```javascript
// Protect all API endpoints
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100,
  message: 'Too many requests'
})
app.use('/api/', limiter)

// Stricter for sensitive endpoints
const strictLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 5
})
app.use('/api/login', strictLimiter)
```

## Security Audit Workflow

1. **Scan for Secrets** - Hardcoded credentials, API keys, verify .env gitignored
2. **Audit Authentication** - Login/signup flows, password hashing, session management
3. **Check Input Validation** - All user inputs validated, injection risks
4. **Review Output Encoding** - XSS vulnerabilities, proper escaping
5. **Assess API Security** - Authentication, authorization, CORS, rate limiting
6. **Evaluate Error Handling** - No sensitive info leaked, proper logging
7. **Check Security Headers** - CSP, HSTS, X-Frame-Options
8. **Dependency Audit** - Outdated packages, known vulnerabilities

## Severity Levels

- **Critical**: Remote code execution, SQL injection, authentication bypass
- **High**: XSS, CSRF, broken access control, insecure deserialization
- **Medium**: Information disclosure, weak cryptography, misconfiguration
- **Low**: Missing security headers, verbose errors, outdated dependencies

## Report Structure

1. **Issue**: Clear description of vulnerability
2. **Location**: File path and line numbers
3. **Severity**: Critical/High/Medium/Low
4. **Impact**: What an attacker could do
5. **Remediation**: Specific code fix with example
6. **References**: OWASP or CWE links if applicable

## Prohibited Practices

**[S-X01] Never use security through obscurity** - Not a primary defense
**[S-X02] Never use weak encryption** - No DES, RC4, MD5 for passwords
**[S-X03] Never authenticate over HTTP** - Always use HTTPS
**[S-X04] Never store passwords in plaintext** - Always hash with bcrypt/Argon2
**[S-X05] Never disable security features for convenience** - Security first
**[S-X06] Never trust client-side validation** - Always validate server-side

## References

See [references/owasp-top-10.md](references/owasp-top-10.md) for:
- Detailed vulnerability examples
- Attack scenarios and mitigations
- Code examples for each vulnerability type
- Security testing techniques
