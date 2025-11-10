# Plugin Testing Guide

Comprehensive testing procedures for the Flutter Expert Agent Claude Code plugin.

## Quick Test

Run these commands to verify everything works:

```bash
# 1. Add marketplace
/plugin marketplace add sheiquezakir/Flutter-Agent

# 2. Install plugin
/plugin install flutter-agent

# 3. Test flutter-expert skill
Ask Claude: "I need to build a Flutter app with authentication"
Expected: Flutter Expert skill activates

# 4. Test flutter-security-auditor skill
Ask Claude: "Can you audit my app for OWASP vulnerabilities?"
Expected: Security Auditor skill activates

# 5. Verify installation
/plugin
Expected: flutter-agent in the list, status: enabled
```

**Result:** If all these work, the plugin is installed correctly ✅

## Detailed Testing

### Test 1: Plugin Installation

**Objective:** Verify plugin can be installed successfully

**Steps:**

```bash
/plugin marketplace add sheiquezakir/Flutter-Agent
```

**Expected Output:**
- No errors
- Marketplace added to plugin configuration

**Steps:**

```bash
/plugin install flutter-agent
```

**Expected Output:**
- "flutter-agent installed"  or similar success message
- No errors

**Verification:**

```bash
/plugin
```

**Expected Output:**
- `flutter-agent` listed
- Status: `enabled` or `active`

---

### Test 2: Flutter Expert Skill Activation

**Objective:** Verify flutter-expert skill activates appropriately

**Test Case 2a: Build New App**

```
Ask Claude:
I need to build a Flutter app with:
- User authentication
- Real-time messaging
- Offline support
- Material Design 3

What's the recommended architecture?
```

**Expected Result:**
- Skill activates automatically
- Claude mentions Clean Architecture, Riverpod, security considerations
- Provides concrete recommendations

**Test Case 2b: Architecture Question**

```
Ask Claude:
How do I implement Clean Architecture in Flutter?
```

**Expected Result:**
- Skill activates
- Provides detailed architecture explanation
- Shows folder structure
- Gives code examples

**Test Case 2c: Riverpod Question**

```
Ask Claude:
I'm confused about Riverpod state management. Can you explain?
```

**Expected Result:**
- Skill activates
- Explains Riverpod concepts
- Shows provider types with examples
- Discusses when to use each

**Test Case 2d: Security Question**

```
Ask Claude:
How do I securely store API tokens in Flutter?
```

**Expected Result:**
- Skill activates
- Discusses FlutterSecureStorage
- Shows implementation example
- Mentions OWASP compliance

---

### Test 3: Flutter Security Auditor Skill Activation

**Objective:** Verify security auditor activates when needed

**Test Case 3a: Security Audit Request**

```
Ask Claude:
Can you audit my Flutter app for security vulnerabilities?

Here's my code:
[Paste Flutter code with intentional vulnerabilities]
```

**Expected Result:**
- Security Auditor skill activates
- Identifies vulnerabilities
- References OWASP Mobile Top 10
- Provides fixes with examples

**Test Case 3b: OWASP Compliance**

```
Ask Claude:
Is my app OWASP Mobile Top 10 compliant?

My app has:
- Firebase authentication
- Encrypted local storage
- HTTPS with certificate pinning
```

**Expected Result:**
- Security Auditor activates
- Checks compliance for M1-M10
- Identifies gaps
- Recommends fixes

**Test Case 3c: Compliance Documentation**

```
Ask Claude:
Help me document GDPR compliance for my Flutter app
```

**Expected Result:**
- Security Auditor activates
- Generates compliance checklist
- Shows implementation examples
- Provides documentation template

---

### Test 4: Skill Coordination

**Objective:** Verify skills work together

**Test:**

```
Ask Claude:
Build me a Flutter app with:
- Authentication (secure token storage)
- Real-time chat
- Offline support
- OWASP compliance

Use Clean Architecture and Riverpod
```

**Expected Result:**
- flutter-expert activates for architecture guidance
- flutter-security-auditor activates for security
- Both coordinate seamlessly
- Comprehensive solution provided
- Security built-in from the start

---

### Test 5: Template Access

**Objective:** Verify templates are accessible through the plugin

**Test Case 5a: Request Template**

```
Ask Claude:
Can you show me the Clean Architecture template?
```

**Expected Result:**
- Template is accessible
- Shows complete file structure
- Includes example code
- References documentation

**Test Case 5b: Use Template**

```
Ask Claude:
Use the clean architecture template to scaffold a new app
```

**Expected Result:**
- Claude provides project structure
- Includes pubspec.yaml
- Shows main.dart setup
- Provides first feature example

**Test Case 5c: Copy Template Files**

```
Ask Claude:
Copy the Clean Architecture template to my current project
```

**Expected Result:**
- Files can be accessed
- Can be copied/pasted
- No permission errors
- Complete structure provided

---

### Test 6: Documentation Access

**Objective:** Verify docs are accessible

**Test:**

```
Ask Claude:
Show me the best practices for Flutter testing
```

**Expected Result:**
- Guidelines documentation loads
- Provides testing pyramid approach
- Shows code examples
- Links to examples folder

---

### Test 7: Error Handling

**Objective:** Verify graceful error handling

**Test Case 7a: No Activation Needed**

```
Ask Claude:
Tell me about Python programming
```

**Expected Result:**
- Skill does NOT activate (Flutter not relevant)
- Claude answers normally
- No errors

**Test Case 7b: Missing Information**

```
Ask Claude:
I have a Flutter problem but I can't describe it
```

**Expected Result:**
- Skill activates (Flutter mentioned)
- Claude asks clarifying questions
- Helps gather needed information
- Doesn't fail

**Test Case 7c: Complex Request**

```
Ask Claude:
Build me a complete e-commerce app with:
- Product catalog
- User authentication
- Shopping cart
- Payments
- Push notifications
- Multi-language support
- Dark mode
- And it must be OWASP compliant
```

**Expected Result:**
- Handles complexity well
- Breaks down into steps
- Provides architecture
- Addresses all requirements
- Security considerations included

---

## Performance Testing

### Test 8: Skill Activation Speed

**Objective:** Verify skills activate promptly

**Steps:**

1. Ask a Flutter question
2. Note the time before skill activates
3. First activation: ~2-5 seconds (expected, skill loads metadata)
4. Subsequent activations: <1 second (expected, cached)

**Expected Result:**
- First use: reasonable delay
- Subsequent uses: fast
- No timeout errors
- Consistent behavior

---

## Integration Testing

### Test 9: Multiple Projects

**Objective:** Verify plugin works across different projects

**Steps:**

1. Create Project A
2. Install flutter-agent
3. Ask Flutter question
4. Verify skill activates

5. Create Project B
6. Ask Flutter question (without re-installing)
7. Verify skill is still available

**Expected Result:**
- Plugin available globally
- Works in all projects
- No re-installation needed

---

### Test 10: Marketplace Operations

**Objective:** Verify marketplace management works

**Test Case 10a: List Marketplaces**

```bash
/plugin marketplace list
```

**Expected Result:**
- flutter-agent-marketplace listed
- Shows source repository
- No errors

**Test Case 10b: Update Plugin**

```bash
/plugin marketplace update sheiquezakir/Flutter-Agent
```

**Expected Result:**
- Updates marketplace metadata
- No errors
- Checks for updates

**Test Case 10c: Enable/Disable**

```bash
/plugin disable flutter-agent
/plugin enable flutter-agent
```

**Expected Result:**
- Plugin disables successfully
- Plugin enables successfully
- Skill availability changes accordingly

---

## Manual Testing Checklist

Use this checklist for comprehensive manual testing:

```
Installation & Discovery
☐ Plugin marketplace adds without errors
☐ Plugin installs without errors
☐ /plugin shows flutter-agent as installed
☐ Plugin status shows enabled

Flutter Expert Skill
☐ Activates when asking about Flutter apps
☐ Activates when asking about Clean Architecture
☐ Activates when asking about Riverpod
☐ Activates when asking about Flutter security
☐ Provides code examples
☐ Mentions best practices
☐ Explains architectural decisions

Security Auditor Skill
☐ Activates when asking about OWASP
☐ Activates when asking for security audits
☐ Activates when asking about compliance
☐ Identifies vulnerabilities
☐ Provides fixes
☐ Mentions all M1-M10 when relevant
☐ Restricted to Read, Grep, Glob tools only

Templates & Docs
☐ Clean Architecture template accessible
☐ Security templates accessible
☐ CI/CD templates accessible
☐ Guidelines documentation accessible
☐ Examples accessible

Coordination
☐ Both skills activate when both needed
☐ No conflicts between skills
☐ Results are coordinated

Performance
☐ First activation: <5 seconds
☐ Subsequent activations: <1 second
☐ No timeout errors
☐ No memory issues

Error Handling
☐ Handles missing context gracefully
☐ Asks clarifying questions when needed
☐ Doesn't break on unexpected input
☐ Provides helpful error messages

Global Availability
☐ Plugin works in Project A
☐ Plugin works in Project B
☐ No re-installation needed
☐ Configuration persistent
```

---

## Automated Testing

For CI/CD, you can create automated tests:

```bash
#!/bin/bash
# Test plugin installation and basic functionality

set -e

echo "Testing Flutter Agent Plugin..."

# 1. Test marketplace add
/plugin marketplace add sheiquezakir/Flutter-Agent && echo "✓ Marketplace added"

# 2. Test plugin install
/plugin install flutter-agent && echo "✓ Plugin installed"

# 3. Test plugin list
/plugin | grep -q flutter-agent && echo "✓ Plugin listed"

# 4. Test skill activation (manual verification needed)
echo "✓ All automated tests passed"
echo "⚠ Manual skill activation tests still needed"
```

---

## Troubleshooting Test Failures

### Skill Not Activating

**Check:**
1. Is plugin installed? `/plugin` should list flutter-agent
2. Is plugin enabled? Run `/plugin enable flutter-agent`
3. Is question about Flutter? Skills only activate for relevant topics
4. Try reloading Claude Code

### Templates Not Accessible

**Check:**
1. Is plugin installed correctly?
2. Try accessing through different methods
3. Check plugin version: `/plugin marketplace list`
4. Verify with `flutter-expert` directly

### Performance Issues

**Check:**
1. First activation is slower (normal)
2. Subsequent activations should be fast
3. Check Claude Code logs for errors
4. Verify network connectivity

### Tool Restrictions

**Check security auditor:**
- Can read files? ✓ (Read tool)
- Can search code? ✓ (Grep tool)
- Can find files? ✓ (Glob tool)
- Cannot modify files? ✓ (restricted by design)

---

## Testing Results Template

Document your testing:

```markdown
## Plugin Test Report

**Date:** YYYY-MM-DD
**Tester:** Name
**Plugin Version:** 1.2.0

### Results

| Test | Status | Notes |
|------|--------|-------|
| Installation | ✓ PASS | |
| Flutter Expert | ✓ PASS | Activates correctly |
| Security Auditor | ✓ PASS | Identifies vulnerabilities |
| Templates | ✓ PASS | All accessible |
| Performance | ✓ PASS | First: 3s, After: <1s |
| Global Availability | ✓ PASS | Works across projects |

### Issues Found
None

### Recommendations
Ready for production use
```

---

## Support

If tests fail:
1. Check [PLUGIN_INSTALLATION.md](PLUGIN_INSTALLATION.md) troubleshooting
2. Report issue: https://github.com/sheiquezakir/Flutter-Agent/issues
3. Include test results and Claude Code version

**All tests passing?** The plugin is ready to use! 🚀
