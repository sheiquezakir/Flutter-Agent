# 🚀 Flutter Expert Agent

> Production-grade Flutter development agent with Clean Architecture, Riverpod, OWASP security, and AI-powered code generation inspired by Anthropic's MCP.

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.32%2B-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.8%2B-blue.svg)](https://dart.dev)
[![GitHub Stars](https://img.shields.io/github/stars/YourUsername/flutter-expert-agent?style=social)](https://github.com/YourUsername/flutter-expert-agent)
[![GitHub Forks](https://img.shields.io/github/forks/YourUsername/flutter-expert-agent?style=social)](https://github.com/YourUsername/flutter-expert-agent)

## ✨ What is This?

A comprehensive **Flutter development agent** and **knowledge system** for building world-class mobile applications. It combines:

- ✅ **Clean Architecture** patterns with proper layer separation
- ✅ **Riverpod state management** (compile-safe, minimal boilerplate)
- ✅ **Security-First** development (OWASP Mobile Top 10 compliant)
- ✅ **Multi-Design System** support (Material Design 3, Cupertino, Custom)
- ✅ **Production-Ready** CI/CD (GitHub Actions, Codemagic)
- ✅ **Code Generation** (Freezed, Injectable, Retrofit)
- ✅ **Comprehensive Testing** (>80% coverage target)
- ✅ **Performance Optimized** (const widgets, lazy loading, Impeller)
- ✅ **Context-Efficient** (MCP-inspired progressive capability loading)

## 📦 Installation

Choose one method to get started:

### Method 1: Clone Full Repository (Recommended)

```bash
git clone https://github.com/sheiquezakir/Flutter-Agent.git
cd Flutter-Agent
# Skills are ready to use!
/use flutter-expert
```

### Method 2: Copy to Your Project

```bash
# Clone repository (if you haven't)
git clone https://github.com/sheiquezakir/Flutter-Agent.git

# Copy skills to your project
cp -r Flutter-Agent/.claude your-project/
cd your-project
/use flutter-expert
```

### Method 3: Global Installation

```bash
# macOS/Linux
mkdir -p ~/.config/claude/skills
cp -r Flutter-Agent/.claude/skills/* ~/.config/claude/skills/

# Windows (PowerShell)
Copy-Item "Flutter-Agent\.claude\skills\*" "$env:APPDATA\Claude\skills" -Recurse

# Now available in all projects!
/use flutter-expert
```

**📖 [Full Installation Guide](INSTALLATION.md)** - Step-by-step instructions for all platforms

## 🎯 Quick Start

### Step 0: Install (Choose Method Above)

### Step 1: Use with Claude Code

```bash
/use flutter-expert

# Describe your app:
I need to build a social media app with:
- User authentication
- Feed with real-time updates
- Image uploads
- Notifications
- Offline support

Target: iOS, Android, Web
```

### Step 2: Use Templates Directly

```bash
# Copy the clean architecture template
cp -r .claude/templates/flutter/clean_architecture my-app
cd my-app
flutter pub get
flutter run
```

### Step 3: Follow the Documentation

- **Installation**: See [INSTALLATION.md](INSTALLATION.md)
- **Getting Started**: See [QUICK_START.md](docs/QUICK_START.md)
- **Using the Agent**: See [AGENT_USAGE.md](.claude/docs/AGENT_USAGE.md)
- **Best Practices**: See [flutter-guidelines.md](.claude/docs/flutter-guidelines.md)

## 📁 Project Structure

```
flutter-expert-agent/
├── .claude/
│   ├── skills/                    # AI Agent skills
│   │   ├── flutter-expert.md      # Main expert agent
│   │   └── flutter-security-auditor.md  # Security scanning
│   ├── templates/                 # Production templates
│   │   ├── flutter/
│   │   │   ├── clean_architecture/  # Project structure
│   │   │   ├── security/            # Security implementations
│   │   │   └── cicd/                # CI/CD workflows
│   │   └── docs/
│   └── docs/                      # Technical guides
├── examples/
│   └── todo_app/                  # Example implementation
├── docs/                          # Public documentation
├── LICENSE                        # MIT License
├── README.md                      # This file
├── CONTRIBUTING.md                # How to contribute
└── CODE_OF_CONDUCT.md            # Community guidelines
```

## 🏆 Key Features

### Clean Architecture + Riverpod

Built-in scaffolding for industry-standard architecture:

```dart
// Domain Layer - Business Logic
abstract class UserRepository {
  Future<User> getUser(String id);
}

// Presentation Layer - State Management with Riverpod
final userProvider = FutureProvider<User>((ref) async {
  return await ref.watch(userRepositoryProvider).getUser('123');
});

// UI Layer - Widget
class UserProfile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    // Build UI...
  }
}
```

### Security First

OWASP Mobile Top 10 compliance built-in:

- ✅ M1: Secure credential management
- ✅ M2: Supply chain security
- ✅ M3: Secure authentication
- ✅ M4: Input validation
- ✅ M5: HTTPS + Certificate pinning
- ✅ M6: Privacy by default
- ✅ M7: Code obfuscation
- ✅ M8: Secure configuration
- ✅ M9: Encrypted storage
- ✅ M10: No debug backdoors

### Multi-Platform

- 📱 **iOS** - Keychain, App Store ready
- 🤖 **Android** - KeyStore, Play Store ready
- 🌐 **Web** - Responsive, PWA-capable
- 🖥️ **Desktop** - macOS, Windows, Linux support

### Production-Ready

- 🧪 Test suite with >80% coverage target
- 🔄 Automated CI/CD (GitHub Actions, Codemagic)
- 📊 Crash reporting (Firebase Crashlytics, Sentry)
- 📈 Performance monitoring
- 🔐 Security scanning
- 📦 App store deployment automation

## 📖 Documentation

### For Users

| Document | Purpose |
|----------|---------|
| [QUICK_START.md](docs/QUICK_START.md) | 5-minute setup guide |
| [AGENT_USAGE.md](.claude/docs/AGENT_USAGE.md) | Complete agent usage guide |
| [FAQ.md](docs/FAQ.md) | Frequently asked questions |

### For Developers

| Document | Purpose |
|----------|---------|
| [flutter-guidelines.md](.claude/docs/flutter-guidelines.md) | Complete best practices reference |
| [ARCHITECTURE.md](docs/ARCHITECTURE.md) | Architecture deep-dive |
| [FEATURE_STRUCTURE.md](.claude/templates/flutter/clean_architecture/FEATURE_STRUCTURE.md) | Feature implementation patterns |

### For DevOps

| Document | Purpose |
|----------|---------|
| [github_actions_flutter.yml](.claude/templates/flutter/cicd/github_actions_flutter.yml) | GitHub Actions CI/CD |
| [codemagic.yaml](.claude/templates/flutter/cicd/codemagic.yaml) | Codemagic CI/CD |
| [obfuscation_build.md](.claude/templates/flutter/security/obfuscation_build.md) | Build & security hardening |

## 🔒 Security

This agent is built with security-first principles:

- **OWASP Compliance** - All OWASP Mobile Top 10 addressed
- **Secure Storage** - FlutterSecureStorage by default
- **Certificate Pinning** - Network security hardening
- **Code Obfuscation** - Production build hardening
- **Security Audit** - Built-in vulnerability scanning
- **Compliance Ready** - GDPR, CCPA, HIPAA templates

See [OWASP Guidelines](.claude/skills/flutter-security-auditor.md) for details.

## 🧪 Testing

Three-tier testing approach:

```
      Integration Tests (5-10%)  ← Full user flows
           ↓
       Widget Tests (20-30%)     ← UI interactions
           ↓
       Unit Tests (60-70%)       ← Business logic

           Target: >80% Coverage
```

Complete test examples included in templates.

## ⚡ Performance

Optimizations built-in:

- Const constructors and widget composition
- Lazy loading and ListView.builder
- Memory leak prevention (proper disposal)
- Asset optimization (WebP, compression)
- Impeller rendering engine support
- APK size reduction (<50MB target)

See [Performance Guide](.claude/docs/flutter-guidelines.md#performance) for details.

## 🚀 CI/CD

Automated workflows for:

- 🔍 Code analysis and linting
- 🧪 Automated testing
- 📦 APK & App Bundle builds
- 🍎 iOS distribution
- 🔐 Security scanning
- 🎯 Play Store & App Store publishing

Both GitHub Actions and Codemagic configurations included.

## 💡 Examples

### Simple Todo App

A fully-implemented example demonstrating:
- Clean Architecture
- Riverpod state management
- Drift database
- Material Design 3
- Comprehensive tests

```bash
cd examples/todo_app
flutter pub get
flutter run
```

More examples coming soon!

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### How to Contribute

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Areas We Need Help

- ✨ More example apps
- 📝 Additional documentation
- 🔍 Code review and feedback
- 🐛 Bug reports and fixes
- 💬 Community discussions

## 📚 Learning Resources

- **Flutter Official**: https://flutter.dev
- **Riverpod Docs**: https://riverpod.dev
- **Clean Architecture**: https://resocoder.com/flutter-clean-architecture
- **OWASP Mobile**: https://owasp.org/www-project-mobile-top-10/
- **Material Design 3**: https://material.io/design

## ❓ FAQ

**Q: Can I use this for production apps?**
A: Yes! This is production-grade code with security, testing, and performance built-in.

**Q: Do I need Claude Code to use this?**
A: No. Templates and docs work standalone. Claude Code integration enhances the experience.

**Q: Is this suitable for beginners?**
A: Yes, with learning curve. Start with the Simple Todo example, then explore.

**Q: What's the maintenance plan?**
A: Regular updates for Flutter versions, security patches, and community feedback.

More FAQs in [FAQ.md](docs/FAQ.md).

## 📞 Support

- 💬 **GitHub Discussions** - Ask questions and discuss ideas
- 🐛 **GitHub Issues** - Report bugs or request features
- 📧 **Email** - Contact for security vulnerabilities
- 💻 **Discord** - Join our community (coming soon)

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

Built with inspiration from:
- **Anthropic's MCP** - Code execution patterns and efficiency
- **Flutter Team** - Amazing framework and tools
- **Open Source Community** - Countless libraries and patterns
- **Security Experts** - OWASP guidelines and best practices

## 🌟 Show Your Support

If this project helps you build amazing Flutter apps, consider:
- ⭐ **Star** the repository
- 🍴 **Fork** for your use cases
- 💬 **Share** with other developers
- 🐛 **Report** issues and suggest improvements
- 📝 **Contribute** your expertise

## 📈 Roadmap

- [x] Core agent and skills
- [x] Clean Architecture templates
- [x] Security implementations
- [x] CI/CD configurations
- [x] Best practices guide
- [ ] Todo app example
- [ ] E-commerce example
- [ ] Firebase integration examples
- [ ] Real-time collaboration app
- [ ] Video tutorials
- [ ] VS Code extension

## 📞 Contact

- **Issues & Discussions**: [GitHub](https://github.com/YourUsername/flutter-expert-agent)
- **Security Reports**: [SECURITY.md](SECURITY.md)

---

**Built with ❤️ for building the best Flutter apps**

Made possible by [Anthropic Claude](https://claude.ai) and the amazing Flutter community.

