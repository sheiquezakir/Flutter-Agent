# Flutter Security Auditor Skill

Specialized security expert for comprehensive Flutter application audits.

## What This Skill Does

Identifies security vulnerabilities and ensures OWASP Mobile Top 10 compliance:

- 🔐 **Vulnerability Scanning** - Detect security weaknesses
- 📋 **OWASP Compliance** - All M1-M10 vulnerabilities covered
- 🔍 **Code Review** - Security-focused analysis
- 📊 **Risk Assessment** - Prioritized findings
- 📝 **Compliance Reports** - GDPR, CCPA, HIPAA documentation
- 🛠️ **Fix Recommendations** - Actionable solutions with code examples

## When It Activates

Claude automatically activates this skill when you ask about:
- Security audits for Flutter apps
- OWASP Mobile vulnerabilities
- Secure storage implementation
- Certificate pinning
- Authentication security
- Data encryption
- Compliance requirements
- Security best practices

## How It Works

Just ask about security for your Flutter app:

**Example:**
```
Can you audit my Flutter app for security vulnerabilities?

I'm concerned about:
- How I'm storing user data
- API authentication
- GDPR compliance

The app has: user auth, messaging, file uploads
```

Claude will automatically activate this skill and provide a comprehensive security audit.

## What You Get

- **OWASP M1-M10 Scan** - All top 10 vulnerabilities checked
- **Hardcoded Secrets Detection** - Find exposed credentials
- **Insecure Storage Audit** - Check data protection
- **Network Security Review** - HTTPS & certificate pinning
- **Compliance Report** - GDPR, CCPA, HIPAA status
- **Risk Prioritization** - Critical to Low severity
- **Fix Guide** - Code examples for each issue

## OWASP Mobile Top 10 Coverage

✅ **M1** - Improper Credential Usage
✅ **M2** - Inadequate Supply Chain Security
✅ **M3** - Insecure Authentication/Authorization
✅ **M4** - Insufficient Input/Output Validation
✅ **M5** - Insecure Communication
✅ **M6** - Inadequate Privacy Controls
✅ **M7** - Insufficient Binary Protections
✅ **M8** - Security Misconfiguration
✅ **M9** - Insecure Data Storage
✅ **M10** - Insecure Extraneous Functionality

## Security Patterns It Detects

- Hardcoded credentials (API keys, passwords, tokens)
- Insecure storage (SharedPreferences, unencrypted files)
- Weak authentication (no token refresh, weak validation)
- Missing input validation
- Unencrypted network calls (HTTP instead of HTTPS)
- Debug code in production
- Missing certificate pinning
- Outdated dependencies with CVEs
- PII in logs
- No code obfuscation

## Compliance Standards

- **GDPR** - General Data Protection Regulation
- **CCPA** - California Consumer Privacy Act
- **HIPAA** - Healthcare data protection
- **PCI DSS** - Payment card security
- **SOC 2** - Security compliance

## Related Skills

- **flutter-expert** - For implementing security fixes

## Resources

- [OWASP Mobile Top 10](https://owasp.org/www-project-mobile-top-10/)
- [GDPR Compliance](https://gdpr-info.eu/)
- [Flutter Security](https://flutter.dev/docs/testing/security-guide)
- [Secure Coding](https://owasp.org/www-community/attacks/)

---

**This skill is part of the Flutter Expert Agent system.**
See [`flutter-agent/README.md`](../../README.md) for full documentation.
