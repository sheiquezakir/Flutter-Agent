# Navigation Guide - Find What You Need

Too many documents? This guide helps you find exactly what you're looking for. 🧭

## 🎯 Quick Decision Tree

**Start here and follow the arrows:**

```
What do you want to do?
│
├─→ "Just get started NOW"
│   └─→ [Getting Started Simple](GETTING_STARTED_SIMPLE.md)
│
├─→ "Build a new app"
│   ├─ Learn best practices?
│   │  └─→ [Quick Start Guide](QUICK_START.md)
│   └─ Just give me templates
│      └─→ Copy from `.claude/templates/flutter/`
│
├─→ "I'm stuck on something"
│   ├─ Architecture questions?
│   │  └─→ [Flutter Guidelines](./../.claude/docs/flutter-guidelines.md)
│   ├─ Security questions?
│   │  └─→ [Security Guide](./../SECURITY.md)
│   └─ How do I test?
│      └─→ See Testing section in [Flutter Guidelines](./../.claude/docs/flutter-guidelines.md)
│
├─→ "I want to see code examples"
│   ├─ Complete working app?
│   │  └─→ [Todo App Example](./../examples/todo_app)
│   ├─ Feature patterns?
│   │  └─→ [Feature Structure](./../.claude/templates/flutter/clean_architecture/FEATURE_STRUCTURE.md)
│   └─ Security implementations?
│      └─→ [Security Templates](./../.claude/templates/flutter/security/)
│
├─→ "I want to use Claude Code"
│   └─→ [Agent Usage Guide](./../.claude/docs/AGENT_USAGE.md)
│
├─→ "I need CI/CD"
│   ├─ GitHub Actions?
│   │  └─→ [github_actions_flutter.yml](./../.claude/templates/flutter/cicd/github_actions_flutter.yml)
│   └─ Codemagic?
│      └─→ [codemagic.yaml](./../.claude/templates/flutter/cicd/codemagic.yaml)
│
├─→ "How do I deploy to App Store/Play Store?"
│   └─→ [CI/CD Templates](./../.claude/templates/flutter/cicd/)
│
└─→ "I want to contribute"
    └─→ [Contributing Guide](./../CONTRIBUTING.md)
```

## 📚 Organized by Use Case

### Just Starting Out?

1. **First time?** → [Getting Started Simple](GETTING_STARTED_SIMPLE.md) (5 min)
2. **More details?** → [Quick Start Guide](QUICK_START.md) (15 min)
3. **See an example?** → Run [Todo App](./../examples/todo_app)

### Building a New App

| What You Need | Document |
|---|---|
| Project structure setup | [Feature Structure](./../.claude/templates/flutter/clean_architecture/FEATURE_STRUCTURE.md) |
| Riverpod state management | [Flutter Guidelines](./../.claude/docs/flutter-guidelines.md#riverpod) |
| Material Design 3 theming | [Theme Configuration](./../.claude/templates/flutter/clean_architecture/) |
| Database setup (Drift) | [Flutter Guidelines](./../.claude/docs/flutter-guidelines.md#database) |
| API integration (Dio/Retrofit) | [Flutter Guidelines](./../.claude/docs/flutter-guidelines.md#api) |

### Security & Compliance

| Concern | Document |
|---|---|
| OWASP compliance | [Security Guide](./../SECURITY.md) |
| Secure storage | [Secure Storage Template](./../.claude/templates/flutter/security/secure_storage_setup.dart) |
| Certificate pinning | [Certificate Pinning Template](./../.claude/templates/flutter/security/certificate_pinning.dart) |
| Code obfuscation | [Obfuscation Build](./../.claude/templates/flutter/security/obfuscation_build.md) |
| GDPR/CCPA | [Security Guide](./../SECURITY.md) |

### Testing

| Level | Document |
|---|---|
| Unit tests | [Flutter Guidelines - Testing](./../.claude/docs/flutter-guidelines.md#testing) |
| Widget tests | [Feature Structure](./../.claude/templates/flutter/clean_architecture/FEATURE_STRUCTURE.md#testing) |
| Integration tests | [Flutter Guidelines](./../.claude/docs/flutter-guidelines.md#testing) |

### Performance

| Topic | Document |
|---|---|
| General optimization | [Flutter Guidelines - Performance](./../.claude/docs/flutter-guidelines.md#performance) |
| Build size reduction | [Obfuscation Build](./../.claude/templates/flutter/security/obfuscation_build.md) |
| Memory management | [Flutter Guidelines](./../.claude/docs/flutter-guidelines.md#performance) |

### Deployment & CI/CD

| Platform | Document |
|---|---|
| GitHub Actions | [github_actions_flutter.yml](./../.claude/templates/flutter/cicd/github_actions_flutter.yml) |
| Codemagic | [codemagic.yaml](./../.claude/templates/flutter/cicd/codemagic.yaml) |
| App Store/Play Store | [CI/CD Templates](./../.claude/templates/flutter/cicd/) |

### Using Claude Code

| Goal | Document |
|---|---|
| Overview | [Agent Usage Guide](./../.claude/docs/AGENT_USAGE.md) |
| Scaffolding apps | [Agent Usage - Scaffolding](./../.claude/docs/AGENT_USAGE.md#scaffolding) |
| Code reviews | [Agent Usage - Code Review](./../.claude/docs/AGENT_USAGE.md#code-review) |
| Building features | [Agent Usage - Features](./../.claude/docs/AGENT_USAGE.md#feature-development) |
| Migration help | [Agent Usage - Migration](./../.claude/docs/AGENT_USAGE.md#migration) |

## 📖 All Documents Explained

### Root Level (Main Repository)

| File | Purpose | Read Time |
|------|---------|-----------|
| **README.md** | Project overview | 5 min |
| **INSTALLATION.md** | How to install | 10 min |
| **SECURITY.md** | Security & compliance | 15 min |
| **CONTRIBUTING.md** | How to contribute | 10 min |
| **CHANGELOG.md** | What changed | 5 min |
| **LICENSE** | MIT License | 2 min |

### `/docs` Folder

| File | Purpose | Read Time |
|------|---------|-----------|
| **GETTING_STARTED_SIMPLE.md** | Super quick start | 5 min |
| **QUICK_START.md** | Detailed getting started | 15 min |
| **NAVIGATION_GUIDE.md** | This file! | 10 min |
| **SKILL_INSTALLATION.md** | Technical setup | 20 min |

### `/.claude/docs` Folder

| File | Purpose | Read Time |
|------|---------|-----------|
| **AGENT_USAGE.md** | Using Claude Code | 20 min |
| **flutter-guidelines.md** | Best practices bible | 45 min |
| **FLUTTER_AGENT_README.md** | System overview | 15 min |

### `/.claude/templates/flutter/clean_architecture`

| File | Purpose |
|------|---------|
| **pubspec.yaml** | All dependencies you need |
| **main.dart** | App entry point |
| **service_locator.dart** | Dependency injection setup |
| **app_theme.dart** | Material Design 3 theme |
| **FEATURE_STRUCTURE.md** | How to add new features |

### `/.claude/templates/flutter/security`

| File | Purpose |
|------|---------|
| **secure_storage_setup.dart** | Secure credential storage |
| **certificate_pinning.dart** | Network security |
| **obfuscation_build.md** | Production hardening |

### `/.claude/templates/flutter/cicd`

| File | Purpose |
|------|---------|
| **github_actions_flutter.yml** | GitHub automation |
| **codemagic.yaml** | Flutter-specific CI/CD |

### `/.claude/skills`

| Skill | Purpose |
|------|---------|
| **flutter-expert/** | Main development agent |
| **flutter-security-auditor/** | Security scanning |

### `/examples`

| Example | Purpose |
|---------|---------|
| **todo_app** | Complete working app |

## 🤔 Can't Find What You're Looking For?

1. **Check the FAQ** - [FAQ](FAQ.md)
2. **Search GitHub Issues** - Look for similar questions
3. **Ask Claude** - Ask the Flutter Expert skill directly
4. **Create an Issue** - We'll help and add it to docs

## ⚡ Speed Reference

**Need it in 5 minutes?**
→ [Getting Started Simple](GETTING_STARTED_SIMPLE.md)

**Need it in 15 minutes?**
→ [Quick Start Guide](QUICK_START.md)

**Need comprehensive learning?**
→ [Flutter Guidelines](./../.claude/docs/flutter-guidelines.md)

**Need a working example?**
→ Run [Todo App](./../examples/todo_app)

**Need security help?**
→ [Security Guide](./../SECURITY.md)

**Need deployment help?**
→ [CI/CD Templates](./../.claude/templates/flutter/cicd/)

---

**Pro Tip:** Bookmark this page! It saves a lot of time finding things. 📌
