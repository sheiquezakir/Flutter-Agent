# 🚀 Flutter Expert Agent - Complete Implementation

## Overview

This is a **production-grade Flutter development agent** built on Anthropic's MCP (Model Context Protocol) principles, featuring:

- ✅ **Clean Architecture** with Riverpod state management
- ✅ **Security-First** development (OWASP Mobile Top 10 compliant)
- ✅ **Multi-Design System** support (Material Design 3, Cupertino, Custom)
- ✅ **Automated Testing** (>80% coverage target)
- ✅ **Production-Ready** CI/CD (GitHub Actions, Codemagic)
- ✅ **Code Generation** (Freezed, Injectable, Retrofit)
- ✅ **Performance Optimized** (const widgets, lazy loading, Impeller)
- ✅ **Context-Efficient** (98% token reduction like MCP article)

## 📁 Project Structure

```
.claude/
├── skills/
│   ├── flutter-expert.md              # Main agent skill
│   └── flutter-security-auditor.md    # Security scanning
├── templates/
│   ├── flutter/
│   │   ├── clean_architecture/
│   │   │   ├── pubspec.yaml
│   │   │   ├── main.dart
│   │   │   ├── service_locator.dart
│   │   │   ├── app_theme.dart
│   │   │   └── FEATURE_STRUCTURE.md
│   │   ├── security/
│   │   │   ├── secure_storage_setup.dart
│   │   │   ├── certificate_pinning.dart
│   │   │   └── obfuscation_build.md
│   │   └── cicd/
│   │       ├── github_actions_flutter.yml
│   │       └── codemagic.yaml
└── docs/
    ├── flutter-guidelines.md          # Best practices reference
    ├── AGENT_USAGE.md                 # How to use the agent
    └── FLUTTER_AGENT_README.md        # This file
```

## 🎯 Quick Start

### 1. Invoke the Main Skill

```bash
# Use the Flutter expert skill
/use flutter-expert

# Then describe your app:
I need to build a mobile banking app with:
- Secure authentication
- Transaction history
- Money transfers
- Biometric support
- Offline balance viewing

Target: iOS, Android
Timeline: 3 months
```

### 2. For Security Audits

```bash
/use flutter-security-auditor

# Then provide:
I need to audit my Flutter e-commerce app for vulnerabilities.
Focus on: Payment handling, authentication, data storage
Compliance: GDPR, PCI DSS
```

### 3. Access Templates & Docs

```bash
# View best practices
cat .claude/docs/flutter-guidelines.md

# See feature structure examples
cat .claude/templates/flutter/clean_architecture/FEATURE_STRUCTURE.md

# Check CI/CD setup
cat .claude/templates/flutter/cicd/github_actions_flutter.yml
```

## 🏗️ Architecture Overview

### Clean Architecture Layers

```
┌─────────────────────────────────┐
│   Presentation (UI/Riverpod)    │
│  - Widgets, Pages, Providers    │
└──────────────┬──────────────────┘
               │
┌──────────────▼──────────────────┐
│   Domain (Business Logic)       │
│  - Entities, UseCases, Repos    │
└──────────────┬──────────────────┘
               │
┌──────────────▼──────────────────┐
│   Data (API & Local Storage)    │
│  - DataSources, Models, Repos   │
└─────────────────────────────────┘
```

### Riverpod State Management

```dart
// Read-only data
final userProvider = FutureProvider<User>((ref) async {
  return await repository.getUser();
});

// Mutable state
final counterProvider = StateProvider((ref) => 0);

// Complex state with methods
class TodoNotifier extends AsyncNotifier<List<Todo>> {
  @override
  Future<List<Todo>> build() async { ... }

  Future<void> addTodo(String title) async { ... }
}

final todosProvider = AsyncNotifierProvider<TodoNotifier, List<Todo>>(
  TodoNotifier.new,
);
```

## 🔒 Security Features

### Built-in Security

1. **OWASP Mobile Top 10 Compliance**
   - M1: Secure credential management (no hardcoding)
   - M2: Supply chain security (dependency auditing)
   - M3: Secure authentication (token refresh)
   - M4: Input validation on all fields
   - M5: HTTPS + certificate pinning
   - M6: Privacy by default (minimal data collection)
   - M7: Code obfuscation for production
   - M8: Secure configuration
   - M9: Encrypted data storage
   - M10: No debug backdoors

2. **Secure Storage**
   - iOS: Keychain Services
   - Android: EncryptedSharedPreferences
   - Never use SharedPreferences for sensitive data

3. **Certificate Pinning**
   - Prevents man-in-the-middle attacks
   - Pinned SHA256 of certificates
   - Automatic validation on every request

4. **Code Obfuscation**
   - R8/ProGuard for Android
   - Debug symbols separated from APK
   - Protects against reverse engineering

## 📊 Testing Strategy

### Three-Tier Approach

```
      Integration Tests (5-10%)  ← Critical user flows
           ↓
       Widget Tests (20-30%)     ← UI interactions
           ↓
       Unit Tests (60-70%)       ← Business logic
```

**Target Coverage: >80%**

### Example Tests

```dart
// Unit test
test('counter increments', () {
  expect(counter.increment(), equals(1));
});

// Widget test
testWidgets('displays user name', (tester) async {
  await tester.pumpWidget(MyApp());
  expect(find.text('John'), findsOneWidget);
});

// Integration test
testWidgets('full login flow', (tester) async {
  await tester.enterText(find.byType(TextField).first, 'test@example.com');
  await tester.tap(find.byType(ElevatedButton));
  expect(find.byType(HomePage), findsOneWidget);
});
```

## 🚀 Performance Optimizations

### Widget Optimization

```dart
// ✅ Use const
const MyWidget(child: Text('Hello'));

// ✅ Lazy load lists
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemTile(item: items[index]),
)

// ✅ Split large widgets
HeaderSection(),  // Separate widget
BodySection(),    // Separate widget
FooterSection(),  // Separate widget
```

### Memory Management

```dart
@override
void dispose() {
  _subscription.cancel();     // Cancel streams
  _controller.dispose();      // Dispose controllers
  super.dispose();
}
```

### Asset Optimization

- WebP format for images (25-35% smaller)
- Compress vectors and icons
- Split APK by ABI (arm64, armv7, x86)
- Target APK size: <50MB

## 🛠️ CI/CD Workflows

### GitHub Actions

- ✅ Automated testing on push/PR
- ✅ Code analysis (format, lint)
- ✅ APK and App Bundle builds
- ✅ Firebase App Distribution
- ✅ Google Play Store publishing
- ✅ Security scanning with Trivy

### Codemagic

- ✅ iOS and Android builds
- ✅ App Store Connect deployment
- ✅ Google Play Store publishing
- ✅ Firebase App Distribution
- ✅ Slack/email notifications
- ✅ Scheduled nightly builds

**Setup:**
```bash
# GitHub Actions
cp .claude/templates/flutter/cicd/github_actions_flutter.yml \
   .github/workflows/flutter-ci.yml

# Codemagic
cp .claude/templates/flutter/cicd/codemagic.yaml codemagic.yaml
```

## 📱 Multi-Platform Support

### iOS
- Build with Xcode
- App Store distribution
- Keychain for secure storage
- Certificate pinning ready

### Android
- Build with Gradle
- Play Store distribution
- Android Keystore for secure storage
- ProGuard/R8 obfuscation

### Web
- Responsive design
- PWA capable
- Same codebase as mobile

### Desktop (macOS, Windows, Linux)
- Native look and feel
- Desktop-optimized UI
- Full feature parity

## 🎨 Design Systems

### Material Design 3

```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  ),
)
```

**Includes:**
- Dynamic theming
- Rounded rectangles (pill shapes)
- Smooth animations
- Material You compatibility

### iOS Cupertino

```dart
CupertinoApp(
  theme: CupertinoThemeData(
    primaryColor: CupertinoColors.activeBlue,
  ),
)
```

**Features:**
- Native iOS appearance
- Platform-specific interactions
- Haptic feedback

### Custom Theme System

Extend `app_theme.dart` for brand-specific theming:
- Custom color schemes
- Brand fonts
- Custom components
- Design tokens

## 📚 Documentation

### For Users
- `AGENT_USAGE.md` - How to use the agent
- `flutter-guidelines.md` - Best practices reference
- Feature examples in templates

### For Developers
- `FEATURE_STRUCTURE.md` - Architecture pattern examples
- Security templates with implementation
- CI/CD configuration examples
- Test examples

## 🔄 Dependency Injection

### Setup with get_it & injectable

```dart
// In service_locator.dart
@InjectableInit()
void configureDependencies() => getIt.init();

// In main.dart
await configureDependencies();

// In classes
class MyRepository {
  final api = getIt<Dio>();
}
```

### Environment-Specific Configuration

```dart
@Environment(Environment.dev)
@injectable
class DevApiClient extends ApiClient { ... }

@Environment(Environment.prod)
@injectable
class ProdApiClient extends ApiClient { ... }
```

## 🔐 Security Checklist

Before every release:

- [ ] No hardcoded credentials
- [ ] Certificate pinning enabled
- [ ] Secure storage for sensitive data
- [ ] Input validation on all fields
- [ ] HTTPS for all API calls
- [ ] Error messages don't leak sensitive info
- [ ] Obfuscation enabled
- [ ] Debug symbols extracted
- [ ] No debug logging in release
- [ ] ProGuard/R8 rules configured
- [ ] All tests passing
- [ ] Security scan completed
- [ ] App size optimized
- [ ] Crash reporting configured

## 🚨 Common Issues & Solutions

### Issue: State not updating in Riverpod

```dart
// ❌ Wrong
state.items.add(newItem);

// ✅ Correct
state = [...state.items, newItem];
```

### Issue: Memory leaks

```dart
// Always dispose resources
@override
void dispose() {
  subscription.cancel();
  controller.dispose();
  super.dispose();
}
```

### Issue: Certificate pinning validation fails

```bash
# Verify certificate SHA256
openssl x509 -in cert.pem -pubkey -noout | \
  openssl pkey -pubin -outform der | \
  openssl dgst -sha256 -binary | base64
```

## 📖 Learning Resources

- **Flutter Official**: https://flutter.dev
- **Riverpod Docs**: https://riverpod.dev
- **Clean Architecture**: https://resocoder.com/flutter-clean-architecture
- **Material Design 3**: https://material.io/design
- **OWASP Mobile**: https://owasp.org/www-project-mobile-top-10/
- **Google Play Console**: https://play.google.com/console
- **App Store Connect**: https://appstoreconnect.apple.com

## 🤝 Contributing to This Agent

The agent is built to be modular and extensible:

1. **Add new patterns** to `flutter-guidelines.md`
2. **Create new templates** for emerging best practices
3. **Improve security** implementations
4. **Add examples** for complex scenarios
5. **Share real-world** implementations

## 📝 License

This Flutter Expert Agent is provided as a reference implementation of Anthropic's MCP code execution patterns applied to Flutter development.

## 🎓 Key Principles

This agent embodies these principles:

1. **Security First** - OWASP compliance by default
2. **Architecture Excellence** - Clean Architecture + SOLID
3. **Testing Culture** - >80% coverage, TDD friendly
4. **Performance Matters** - Profiled and optimized
5. **User Experience** - Accessible, responsive, offline-capable
6. **Developer Experience** - Clear patterns, excellent DX
7. **Production Ready** - CI/CD, monitoring, error handling
8. **Continuous Learning** - Latest Flutter, best practices

## 🚀 Next Steps

1. **Start with a simple feature** - Get familiar with patterns
2. **Review generated code** - Understand the architecture
3. **Run the tests** - Verify everything works
4. **Customize to your needs** - Adapt based on requirements
5. **Scale up** - Add complex features
6. **Monitor in production** - Track errors, performance, user behavior

---

**Built with ❤️ for building the best Flutter apps**

Questions? Check `AGENT_USAGE.md` or ask the agent directly!
