# 🚀 Flutter Expert Agent

**AI-powered Flutter development with production-grade architecture, security, and best practices.**

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Flutter 3.32+](https://img.shields.io/badge/Flutter-3.32%2B-blue.svg)](https://flutter.dev)
[![Dart 3.8+](https://img.shields.io/badge/Dart-3.8%2B-blue.svg)](https://dart.dev)

## ⚡ What You Get

An intelligent Flutter development system that helps you build **production-grade apps** with:

- 🏗️ **Clean Architecture** - Professional project structure
- 🎨 **Riverpod State Management** - Modern, compile-safe state handling
- 🔒 **Security First** - OWASP Mobile Top 10 compliance built-in
- 🧪 **Testing Framework** - >80% code coverage from day one
- 🚀 **CI/CD Ready** - GitHub Actions + Codemagic configs
- 🎯 **Design Systems** - Material Design 3, Cupertino, custom themes
- 📱 **Multi-Platform** - iOS, Android, Web, Desktop support

## 🚀 Get Started in 3 Minutes

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/sheiquezakir/Flutter-Agent.git
cd Flutter-Agent
```

### 2️⃣ Use with Claude Code

Ask Claude naturally about your Flutter app:

```
I need to build a messaging app with:
- User authentication
- Real-time chat
- Image sharing
- Offline support
```

Claude automatically uses the Flutter Expert skill to help you build it.

### 3️⃣ Or Use Templates Directly

```bash
cp -r .claude/templates/flutter/clean_architecture my-app
cd my-app && flutter pub get && flutter run
```

**👉 [Full Setup Guide →](docs/QUICK_START.md)**

## 📚 Choose Your Path

**I want to...**

| Goal | Next Step |
|------|-----------|
| **Build a new app** | Read [Quick Start](docs/QUICK_START.md) |
| **See a complete example** | Run [Todo App Example](examples/todo_app) |
| **Learn best practices** | Check [Flutter Guidelines](.claude/docs/flutter-guidelines.md) |
| **Add security features** | See [Security Guide](SECURITY.md) |
| **Setup CI/CD** | View [CI/CD Templates](.claude/templates/flutter/cicd) |
| **Contribute** | Read [Contributing Guide](CONTRIBUTING.md) |

## 📁 What's Inside

```
Flutter-Agent/
├── .claude/
│   ├── skills/              # AI agent skills
│   │   ├── flutter-expert/     # Main development expert
│   │   └── flutter-security-auditor/  # Security scanning
│   ├── templates/           # Production-ready templates
│   │   ├── flutter/clean_architecture/
│   │   ├── flutter/security/
│   │   └── flutter/cicd/
│   └── docs/                # Technical guides
├── examples/
│   └── todo_app/            # Complete working example
└── docs/                    # Public documentation
```

## 🌟 Key Features at a Glance

### Architecture & Code Quality
- **Clean Architecture** with proper layer separation (domain, data, presentation)
- **Riverpod 2.x** for type-safe state management
- **Code Generation** - Freezed, Injectable, Retrofit
- **Linting & Formatting** - Automated code quality

### Security
- ✅ All **OWASP Mobile Top 10** vulnerabilities addressed
- ✅ **Secure storage** for sensitive data
- ✅ **Certificate pinning** for API calls
- ✅ **Code obfuscation** for release builds
- ✅ Built-in **vulnerability scanning**

### Testing & Quality
- 3-tier testing pyramid (unit → widget → integration)
- Target **>80% code coverage**
- Example tests for all patterns
- Firebase Crashlytics integration

### Deployment
- **GitHub Actions** - Automated testing and builds
- **Codemagic** - Flutter-native CI/CD
- **App Store & Play Store** - Automated deployment
- **Security scanning** - Pre-release security checks

## 💻 Simple Example

Here's how easy it is with this setup:

```dart
// State management with Riverpod
final userProvider = FutureProvider<User>((ref) async {
  return await ref.watch(userRepositoryProvider).getUser('123');
});

// Use it in your widget
class UserProfile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return user.when(
      data: (u) => Text(u.name),
      loading: () => CircularProgressIndicator(),
      error: (err, _) => Text('Error: $err'),
    );
  }
}
```

Everything is type-safe, testable, and production-ready from the start.

## 📖 Documentation

### Quick References
- **[Quick Start](docs/QUICK_START.md)** - 5-minute setup
- **[Installation](INSTALLATION.md)** - Detailed setup for all platforms
- **[Using the Agent](docs/AGENT_USAGE.md)** - How to work with Claude

### Deep Dives
- **[Flutter Guidelines](.claude/docs/flutter-guidelines.md)** - Best practices & patterns
- **[Security](SECURITY.md)** - OWASP compliance & security setup
- **[Contributing](CONTRIBUTING.md)** - How to contribute

### Examples & Templates
- **[Todo App Example](examples/todo_app)** - Complete working example
- **[Architecture Templates](.claude/templates/flutter/clean_architecture/)** - Ready-to-use structure
- **[CI/CD Templates](.claude/templates/flutter/cicd/)** - Deployment configs

## ❓ FAQ

**Q: Do I need Claude Code to use this?**
A: No! You can use the templates and examples standalone. Claude integration just makes it easier.

**Q: Is this production-ready?**
A: Yes! It includes testing, security, and deployment configurations.

**Q: Can beginners use this?**
A: Yes, but there's a learning curve. Start with the Todo example and build from there.

**Q: What Flutter versions are supported?**
A: Flutter 3.32+ with Dart 3.8+

**More questions?** See [FAQ](docs/FAQ.md)

## 🤝 Contributing

We'd love your help! Whether it's:
- 🐛 Bug fixes
- ✨ New features
- 📝 Better documentation
- 💡 Suggestions

See [Contributing Guide](CONTRIBUTING.md) to get started.

## 📄 License

MIT License - Use freely in your projects. See [LICENSE](LICENSE) for details.

---

**Built with ❤️ for building the best Flutter apps**

Made possible by [Anthropic Claude](https://claude.ai) and the amazing Flutter community.
