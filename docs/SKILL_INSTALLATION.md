# Skill Installation - Technical Guide for Developers

Deep-dive technical guide for developers who want to understand, customize, or create Claude Code skills.

## Table of Contents

1. [How Claude Code Skills Work](#how-claude-code-skills-work)
2. [File Structure & Conventions](#file-structure--conventions)
3. [Skill Anatomy](#skill-anatomy)
4. [Creating Custom Skills](#creating-custom-skills)
5. [Skill Discovery & Loading](#skill-discovery--loading)
6. [Debugging Skills](#debugging-skills)
7. [Skill Best Practices](#skill-best-practices)

## How Claude Code Skills Work

### Architecture Overview

```
Claude Code Interface
         ↓
    /use command parser
         ↓
    .claude/skills/ discovery
         ↓
    Load .md skill file
         ↓
    Claude processes skill prompt
         ↓
    Skill activated with full capabilities
```

### Skill Execution Flow

1. **Discovery Phase**
   - Claude Code looks for `.claude/skills/` directory
   - Scans for `.md` files
   - Indexes available skills

2. **Invocation Phase**
   - User types `/use skill-name`
   - Claude finds matching skill file
   - Loads entire file content as context

3. **Execution Phase**
   - Claude processes the skill content
   - Uses instructions to guide responses
   - Skill remains active for the conversation

4. **Context Phase**
   - Skill provides specialized knowledge
   - Guides Claude's behavior
   - Influences all subsequent responses

### Token Efficiency

**Key principle**: Skills follow MCP-inspired progressive capability loading

```
Without Skill:
- Load all documentation manually
- User provides context in messages
- Inefficient token usage
- ~150,000+ tokens for setup

With Skill:
- Pre-loaded in context
- Claude understands immediately
- Efficient token usage
- ~2,000 tokens for skill + query
```

**Result**: ~98% token savings!

## File Structure & Conventions

### Standard Layout

```
project-root/
├── .claude/                           # Claude configuration directory
│   ├── skills/                        # User-defined skills
│   │   ├── flutter-expert.md          # Main skill
│   │   ├── flutter-security-auditor.md # Secondary skill
│   │   └── your-custom-skill.md       # Your skills
│   ├── templates/                     # Code templates
│   ├── docs/                          # Documentation
│   └── settings.local.json            # Local configuration
├── lib/
├── test/
└── pubspec.yaml
```

### Naming Conventions

**Skill file naming:**

```
✅ Good:
- flutter-expert.md (lowercase, hyphens)
- security-auditor.md
- api-integration-helper.md

❌ Bad:
- FlutterExpert.md (uppercase)
- flutter_expert.md (underscores)
- Flutter Expert.md (spaces)
```

**Directory conventions:**

```
✅ Good:
- .claude/skills/
- .claude/templates/
- .claude/docs/

❌ Bad:
- .claude/Skill/
- .claude/template/
- claude/skills/
```

## Skill Anatomy

### Basic Skill Structure

```markdown
# [Skill Name] - [Short Description]

Brief introduction (2-3 sentences)

## Your Role

What you are and what you do

## Capabilities

Key abilities and features

## Best Practices

Important guidelines

## How to Use

Usage examples and patterns

## Advanced Topics

Complex scenarios

---

**Note:** Encouragement or context
```

### Flutter Expert Skill Example

```markdown
# Flutter Expert Agent - Master Skill

You are an elite Flutter development agent...

## Core Identity

You are a **Flutter Expert Agent** specialized in:
- ✅ Full app scaffolding
- ✅ Security-first development
- ...

## Technology Stack

Latest Versions (2025):
- Flutter 3.32 with Dart 3.8
- Riverpod 2.x
- ...
```

### Key Sections

**1. Title & Description**
```markdown
# [Skill Name] - [Brief Description]
```

**2. Role Definition**
```markdown
## Your Role

Start with: "You are a..."
Define expertise and purpose
```

**3. Capabilities**
```markdown
## What You Can Do

- Capability 1
- Capability 2
- Capability 3
```

**4. Context & Knowledge**
```markdown
## Technology Stack / Domain Knowledge

Current versions, best practices, standards
```

**5. Instructions & Patterns**
```markdown
## How You Work

Step-by-step instruction flow
Processing patterns
Decision trees
```

**6. Examples**
```markdown
## Examples

Real-world usage examples
Code snippets
Expected interactions
```

## Creating Custom Skills

### Step 1: Define Your Skill

**Ask yourself:**
- What is this skill's purpose?
- Who will use it?
- What knowledge does it provide?
- What problems does it solve?

**Example:**
```
Purpose: Help developers integrate payment systems
Audience: Flutter developers
Knowledge: Stripe, Apple Pay, Google Pay, payment security
Problems solved: Payment integration, security, testing
```

### Step 2: Structure the Skill

Create `.claude/skills/payment-integration.md`:

```markdown
# Payment Integration Expert - Flutter

You are a specialized payment systems expert for Flutter applications.

## Your Expertise

- Stripe integration
- Apple Pay & Google Pay
- Payment security
- PCI compliance
- Testing payment flows
- Error handling & recovery

## Technology Stack

- Stripe Flutter SDK
- pay package
- Firebase Payments
- TLS 1.2+
- PCI DSS 3.2.1

## How You Help

When a developer asks about payment integration:

1. **Understand the requirement**
   - Which payment provider?
   - Platform requirements (iOS, Android, Web)?
   - Compliance needs?

2. **Provide architecture**
   - Secure implementation patterns
   - Best practices
   - Common pitfalls

3. **Generate code**
   - Complete, tested implementations
   - Error handling
   - Security checks

## Security Checklist

Always verify:
- ✅ No hardcoded API keys
- ✅ Secure token storage
- ✅ Proper error messages
- ✅ HTTPS only
- ✅ Input validation

## Example Request

User: "How do I integrate Stripe into my Flutter app?"

Your response should cover:
1. Architecture overview
2. Dependencies needed
3. Step-by-step implementation
4. Security considerations
5. Testing approach
```

### Step 3: Test Your Skill

```bash
# 1. Save the skill file
.claude/skills/payment-integration.md

# 2. In Claude Code, try:
/use payment-integration

How do I add Stripe to my Flutter app?
```

### Step 4: Refine & Improve

Based on testing:
- Clarify unclear sections
- Add more examples
- Fix incorrect information
- Expand coverage

## Skill Discovery & Loading

### Search Paths

Claude Code looks for skills in (in order):

```
1. Project-local: ./.claude/skills/
2. User-local: ~/.config/claude/skills/ (macOS/Linux)
3. User-local: %APPDATA%\Claude\skills (Windows)
4. System-wide: /etc/claude/skills (Linux)
```

### File Discovery

```python
# Pseudocode for skill discovery
def find_skills(search_paths):
    skills = {}
    for path in search_paths:
        if os.path.exists(path):
            for file in os.listdir(path):
                if file.endswith('.md'):
                    skill_name = file[:-3]  # Remove .md
                    skills[skill_name] = os.path.join(path, file)
    return skills
```

### Skill Name Resolution

When you type `/use flutter-expert`:

```
1. Look for "flutter-expert.md"
2. If not found, try:
   - "flutter_expert.md"
   - "FlutterExpert.md"
   - "flutter-expert.txt"
3. If still not found, search in parent directories
4. If found: Load and activate
5. If not found: Error message
```

### Name Matching

```
/use flutter-expert       ✅ Matches: flutter-expert.md
/use flutter             ❓ Matches: flutter-expert.md (if unique)
/use flutter-security    ✅ Matches: flutter-security-auditor.md
/use security            ❓ Ambiguous if multiple match
```

## Debugging Skills

### Enable Debug Logging

Create `.claude/settings.local.json`:

```json
{
  "debug": true,
  "logging": {
    "level": "verbose",
    "file": ".claude/debug.log"
  },
  "skills": {
    "verbose": true
  }
}
```

### Common Issues & Solutions

#### Issue: Skill not loading

**Debug steps:**

```bash
# 1. Verify file exists
ls -la .claude/skills/your-skill.md

# 2. Check file permissions
chmod 644 .claude/skills/your-skill.md

# 3. Verify file format
file .claude/skills/your-skill.md
# Should output: text file

# 4. Check for encoding issues
file -i .claude/skills/your-skill.md
# Should output: charset=utf-8
```

**Common causes:**
- File in wrong location (not in `.claude/skills/`)
- Incorrect file extension (not `.md`)
- Permission issues
- Invalid UTF-8 encoding
- File is corrupted

#### Issue: Skill loads but doesn't work correctly

**Debug steps:**

1. **Check skill content**
   ```bash
   # View first 50 lines
   head -50 .claude/skills/your-skill.md
   ```

2. **Verify markdown formatting**
   ```markdown
   ✅ Should start with # Title
   ✅ Should have ## sections
   ❌ Should not have YAML front matter
   ❌ Should not have Python/code fences at top level
   ```

3. **Test basic functionality**
   ```
   /use your-skill

   What are your capabilities?
   ```

4. **Check for instruction conflicts**
   - If skill instructions conflict with global Claude instructions
   - Remove conflicting sections

#### Issue: Multiple skills interfering

**Solution:**

```markdown
# Clear Skill Boundaries

In your skill, add:

## Scope & Limitations

This skill focuses on [specific area].

For other areas, defer to:
- General Claude capabilities
- Other specialized skills
- User's expertise

Never try to:
- Answer questions outside expertise
- Contradict other skills
- Override user preferences
```

### Skill Validation Checklist

```bash
# Create validate_skills.sh
#!/bin/bash

echo "Validating skills..."

for skill in .claude/skills/*.md; do
    echo "Checking: $skill"

    # Check file encoding
    if file -i "$skill" | grep -q "utf-8"; then
        echo "  ✅ UTF-8 encoding"
    else
        echo "  ❌ Encoding issue"
    fi

    # Check for title
    if head -1 "$skill" | grep -q "^#"; then
        echo "  ✅ Has title"
    else
        echo "  ❌ Missing title"
    fi

    # Check for sections
    if grep -q "^##"; then
        echo "  ✅ Has sections"
    else
        echo "  ⚠️ No sections"
    fi

    # Line count
    lines=$(wc -l < "$skill")
    echo "  📊 Lines: $lines"
done
```

## Skill Best Practices

### Do's ✅

```markdown
✅ Start with clear role definition
   "You are a [expertise] expert..."

✅ Use clear section headers
   ## Capabilities
   ## Best Practices
   ## Examples

✅ Provide concrete examples
   with real code snippets

✅ Be specific about constraints
   "Always use HTTPS for..."
   "Never hardcode..."

✅ Include security considerations
   for domain-specific topics

✅ Reference documentation
   with links and citations

✅ Use formatting effectively
   - Bullets for lists
   - Code blocks for snippets
   - Tables for comparisons

✅ Keep it focused
   One primary purpose
   Related but distinct skills
```

### Don'ts ❌

```markdown
❌ Don't use YAML front matter
   (unless skill framework supports it)

❌ Don't include executable code
   at the top level
   (put in examples section)

❌ Don't exceed 10,000 lines
   (breaks efficiency)

❌ Don't duplicate other skills
   (coordinate with other skills)

❌ Don't include personal opinions
   (stick to facts and best practices)

❌ Don't use skills as instructions
   to modify system behavior
   (let Claude decide)

❌ Don't hardcode user requirements
   (ask clarifying questions)
```

### Skill Size Guidelines

```
Optimal: 2,000 - 5,000 lines
Good:    5,000 - 8,000 lines
Large:   8,000 - 10,000 lines
Too Big: >10,000 lines (refactor into multiple skills)

Flutter Expert: ~1,900 lines ✅ Optimal
Security Audit: ~1,100 lines ✅ Optimal
```

### Version Management

Add version tracking to your skill:

```markdown
# Your Skill - Description

**Version:** 1.0.0
**Last Updated:** 2025-01-10
**Flutter:** 3.32+
**Dart:** 3.8+

## Changelog

### v1.0.0 (2025-01-10)
- Initial release
- Core capabilities
- Documentation

### v0.9.0 (2025-01-05)
- Beta release
- Feedback collection
```

### Skill Documentation

Within your skill, include:

```markdown
## How to Use This Skill

### Basic Usage
```
/use skill-name

Your question or request here
```

### Advanced Usage
```
/use skill-name

Detailed context and requirements...
[Specific code or configuration]
```

### See Also
- Related skills
- External documentation
- Learning resources
```

## Advanced: Skill Composition

### Combining Skills

Multiple skills can work together:

```
/use flutter-expert
Also use flutter-security-auditor

I need to build a banking app...
```

### Skill Hierarchy

```
Primary Skill: flutter-expert
  ├─ Delegates to: flutter-security-auditor
  ├─ References: flutter-guidelines.md
  └─ Uses templates from: .claude/templates/
```

### Cross-Skill References

In your skill, reference others:

```markdown
## Related Skills

For security questions, see:
- `/use flutter-security-auditor`

For architecture patterns:
- `.claude/docs/flutter-guidelines.md`

For complete examples:
- `examples/todo_app/`
```

---

## Resources

- **Claude Code Docs**: https://docs.claude.com/en/docs/claude-code/
- **Markdown Guide**: https://www.markdownguide.org/
- **Flutter Best Practices**: https://flutter.dev/docs/testing
- **OWASP Guidelines**: https://owasp.org/

---

**Happy skill creation! 🎉**

For questions, see main [INSTALLATION.md](../INSTALLATION.md) or [CONTRIBUTING.md](../CONTRIBUTING.md).

