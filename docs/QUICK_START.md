# Quick Start Guide

Get started with the Flutter Expert Agent in 5 minutes! 🚀

## Prerequisites

- Flutter 3.32+
- Dart 3.8+
- Git
- Code editor (VS Code, Android Studio, etc.)

## Option 1: Use with Claude Code (Recommended)

### Step 1: Access the Agent

In Claude Code or Claude interface:

```
/use flutter-expert

I want to create a new Flutter app for [your purpose].

Key features needed:
- [Feature 1]
- [Feature 2]
- [Feature 3]

Target platforms: iOS, Android
Design: Material Design 3
```

### Step 2: Follow the Agent's Guidance

The agent will:
1. Ask clarifying questions
2. Generate project structure
3. Provide implementation examples
4. Give security recommendations
5. Setup testing framework

### Step 3: Implement Locally

```bash
# Copy generated code to your machine
# Install dependencies
flutter pub get

# Run tests
flutter test

# Start developing
flutter run
```

## Option 2: Use Templates Directly

### Step 1: Clone the Repository

```bash
git clone https://github.com/YourUsername/flutter-expert-agent.git
cd flutter-expert-agent
```

### Step 2: Copy Clean Architecture Template

```bash
# Copy the template
cp -r .claude/templates/flutter/clean_architecture my-new-app
cd my-new-app

# Install dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 3: Customize

1. Update `pubspec.yaml`:
   - Change `name` from `flutter_clean_app` to your app name
   - Update version and description

2. Update `lib/main.dart`:
   - Change app title
   - Add your Firebase config

3. Update `lib/config/service_locator.dart`:
   - Add your API base URL
   - Register your repositories and services

### Step 4: Add Your Features

Create your first feature:

```bash
# Create feature structure
mkdir -p lib/features/your_feature/{data,domain,presentation}

# Follow FEATURE_STRUCTURE.md for the pattern
cat .claude/templates/flutter/clean_architecture/FEATURE_STRUCTURE.md
```

### Step 5: Test

```bash
# Run all tests
flutter test

# Check coverage
flutter test --coverage
```

### Step 6: Run

```bash
flutter run
```

## Option 3: Use Example Project

### Learn from Todo App Example

```bash
cd examples/todo_app

# Get dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run

# Explore the code and understand the patterns
```

## Next Steps

### 1. Read Documentation

Key documents to read:

- **For Understanding the Agent**: [AGENT_USAGE.md](./.claude/docs/AGENT_USAGE.md)
- **For Best Practices**: [flutter-guidelines.md](./.claude/docs/flutter-guidelines.md)
- **For Architecture**: [FEATURE_STRUCTURE.md](./.claude/templates/flutter/clean_architecture/FEATURE_STRUCTURE.md)
- **For Security**: [flutter-security-auditor.md](./.claude/skills/flutter-security-auditor.md)

### 2. Customize Your App

Update branding and configuration:

```dart
// lib/config/theme/app_theme.dart
static const Color _seedColor = Colors.blue; // Your brand color
```

### 3. Add Features

Follow the feature structure to add your features:

```dart
// Feature structure:
lib/features/
├── your_feature/
│   ├── data/
│   │   ├── datasources/
│   │   ├── models/
│   │   └── repositories/
│   ├── domain/
│   │   ├── entities/
│   │   ├── repositories/
│   │   └── usecases/
│   └── presentation/
│       ├── providers/
│       ├── pages/
│       └── widgets/
```

### 4. Setup CI/CD

Copy the CI/CD configuration:

```bash
# For GitHub Actions
cp .claude/templates/flutter/cicd/github_actions_flutter.yml \
   .github/workflows/flutter-ci.yml

# For Codemagic
cp .claude/templates/flutter/cicd/codemagic.yaml codemagic.yaml
```

### 5. Implement Security

Add security features:

```dart
// Secure storage
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// See: .claude/templates/flutter/security/secure_storage_setup.dart

// Certificate pinning
// See: .claude/templates/flutter/security/certificate_pinning.dart
```

### 6. Test Thoroughly

```bash
# Run tests with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### 7. Build for Release

```bash
# Android APK
flutter build apk --release --obfuscate --split-debug-info=./symbols

# Android App Bundle (for Play Store)
flutter build appbundle --release --obfuscate --split-debug-info=./symbols

# iOS (requires Xcode)
flutter build ios --release --obfuscate --split-debug-info=./symbols
```

## Common Commands

### Development

```bash
# Get dependencies
flutter pub get

# Run app
flutter run

# Run app on specific device
flutter run -d <device-id>

# Debug mode
flutter run --debug

# Profile mode (performance testing)
flutter run --profile

# Release mode
flutter run --release
```

### Code Generation

```bash
# Generate code once
flutter pub run build_runner build

# Watch for changes and auto-generate
flutter pub run build_runner watch

# Clean and regenerate
flutter pub run build_runner build --delete-conflicting-outputs
```

### Testing

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/specific_test.dart

# Run tests with coverage
flutter test --coverage

# Watch tests (re-run on changes)
flutter test --watch
```

### Code Quality

```bash
# Analyze code
dart analyze

# Format code
dart format -l 100 lib/ test/

# Check formatting without changing
dart format -l 100 lib/ test/ --set-exit-if-changed

# Audit dependencies
dart pub audit
```

### Building

```bash
# Build APK
flutter build apk

# Build App Bundle
flutter build appbundle

# Build iOS
flutter build ios

# Build Web
flutter build web

# Build Windows
flutter build windows

# Build macOS
flutter build macos

# Build Linux
flutter build linux
```

## Troubleshooting

### Issue: "pub get" fails

```bash
# Clean and try again
flutter clean
flutter pub get
```

### Issue: Build fails

```bash
# Clean everything
flutter clean
dart pub cache clean
flutter pub get

# Regenerate code
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: Code generation not working

```bash
# Watch for changes (better than build)
flutter pub run build_runner watch
```

### Issue: Tests failing

```bash
# Run tests with verbose output
flutter test --verbose

# Run specific test
flutter test test/path/to/test.dart

# Run tests with debugging
flutter test --start-paused
```

## Getting Help

### Documentation

- 📖 [Flutter Official Docs](https://flutter.dev)
- 📖 [Riverpod Docs](https://riverpod.dev)
- 📖 [Dart Docs](https://dart.dev)

### Community

- 💬 [GitHub Discussions](https://github.com/YourUsername/flutter-expert-agent/discussions)
- 🐛 [GitHub Issues](https://github.com/YourUsername/flutter-expert-agent/issues)
- 💻 [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)

### Agent Help

```
/use flutter-expert

I'm stuck on [specific issue]. Can you help?
[Provide context and code if applicable]
```

## What's Next?

1. **Explore Examples**: Review the Todo App example
2. **Read Guidelines**: Check flutter-guidelines.md
3. **Build Features**: Implement your app features
4. **Test**: Write comprehensive tests (>80% coverage)
5. **Security**: Review security checklist
6. **Deploy**: Setup CI/CD and deployment
7. **Monitor**: Add crash reporting and analytics

---

**Congratulations! You're ready to build amazing Flutter apps! 🎉**

For more detailed guidance, use the Flask Expert Agent or check the full documentation.

