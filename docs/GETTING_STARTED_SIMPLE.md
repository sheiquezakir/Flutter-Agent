# Getting Started - The Simple Way

**Complete setup in 3 commands.** That's it! 🎯

## What This Does

The Flutter Expert Agent is an AI assistant that helps you build production-grade Flutter apps with:
- Professional architecture already set up
- Security best practices built-in
- Testing framework ready to go
- CI/CD automation included

## The Fastest Path

### Step 1: Get the Code

```bash
git clone https://github.com/sheiquezakir/Flutter-Agent.git
cd Flutter-Agent
```

### Step 2: Use the Template (Option A - Recommended)

```bash
cp -r .claude/templates/flutter/clean_architecture my-app
cd my-app
flutter pub get
flutter run
```

**Done!** Your app is running with professional architecture. 🚀

### Step 2: Use with Claude (Option B)

Open Claude Code and ask:

```
I need to build a todo app with:
- Add/delete todos
- Offline support
- Dark mode

Can you help me build this?
```

Claude uses the Flutter Expert skill to generate the code for you.

## What You Get

Your new app includes:

✅ **Clean Architecture** - Organized folders (data, domain, presentation)
✅ **Riverpod** - State management that prevents bugs
✅ **Security** - Secure storage for sensitive data
✅ **Tests** - Example tests you can copy
✅ **Material Design 3** - Modern UI ready to go
✅ **CI/CD** - GitHub Actions ready to use

## Next Steps

### 1. Customize Your App

Edit `lib/main.dart`:
```dart
const app_title = 'My Amazing App';  // Change this
```

### 2. Add Your Features

Create folders in `lib/features/`:
```
lib/features/
├── your_feature/
│   ├── data/
│   ├── domain/
│   └── presentation/
```

Check `FEATURE_STRUCTURE.md` for the pattern to follow.

### 3. Run Tests

```bash
flutter test
```

### 4. Build for Release

```bash
# iOS
flutter build ios --release

# Android
flutter build apk --release
```

## Common Questions

**Q: Do I need Claude Code?**
A: No! The template works on its own. Claude just makes it faster.

**Q: Is it really production-ready?**
A: Yes. It has testing, security, and deployment configs built-in.

**Q: What if I get stuck?**
A: Check:
- [Quick Start Guide](QUICK_START.md) - Detailed walkthrough
- [Flutter Guidelines](./../.claude/docs/flutter-guidelines.md) - Best practices
- [Examples](../examples/todo_app) - Complete working example

## Helpful Commands

```bash
# Install dependencies
flutter pub get

# Run your app
flutter run

# Run tests
flutter test

# Check code quality
dart analyze

# Format code
dart format lib/

# Build for Android
flutter build apk --release

# Build for iOS
flutter build ios --release
```

## File Structure Explained

```
my-app/
├── lib/
│   ├── main.dart              # App entry point
│   ├── config/                # App configuration
│   ├── core/                  # Shared code (errors, utils, constants)
│   └── features/              # Your app features
│       ├── feature_name/
│       │   ├── data/          # API, database, models
│       │   ├── domain/        # Business logic
│       │   └── presentation/  # UI, state management
├── test/                      # Unit & widget tests
├── pubspec.yaml               # Dependencies
└── README.md
```

Each folder has its own `README.md` explaining what goes there.

## Tips for Success

1. **Start Small** - Add one feature at a time
2. **Write Tests** - Test code as you build it (it's faster!)
3. **Use the Examples** - Copy patterns from the Todo app example
4. **Follow the Structure** - The folder organization prevents bugs
5. **Check Security** - Ask Claude to audit your security

## Want More Help?

- **Basic setup**: See [QUICK_START.md](QUICK_START.md)
- **Advanced topics**: Read [Flutter Guidelines](./../.claude/docs/flutter-guidelines.md)
- **Working example**: Run the [Todo App](../examples/todo_app)
- **Security**: Use the [Security Auditor Skill](./../.claude/skills/flutter-security-auditor/README.md)

---

**That's it! You're ready to build your Flutter app.** 🎉

Need help? Ask Claude or check the detailed guides above.
