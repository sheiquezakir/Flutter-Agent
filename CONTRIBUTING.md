# Contributing to Flutter Expert Agent

Thank you for your interest in contributing to the Flutter Expert Agent! We welcome contributions from everyone. This document provides guidelines and instructions for contributing.

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [Getting Started](#getting-started)
3. [Types of Contributions](#types-of-contributions)
4. [Development Setup](#development-setup)
5. [Submission Guidelines](#submission-guidelines)
6. [Quality Standards](#quality-standards)
7. [Pull Request Process](#pull-request-process)
8. [Code Review](#code-review)

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## Getting Started

### Prerequisites

- Flutter 3.32+ and Dart 3.8+
- Git
- GitHub account
- Code editor (VS Code, Android Studio, etc.)

### Fork and Clone

```bash
# Fork the repository on GitHub
# Clone your fork
git clone https://github.com/YourUsername/flutter-expert-agent.git
cd flutter-expert-agent

# Add upstream remote
git remote add upstream https://github.com/OriginalAuthor/flutter-expert-agent.git

# Create a feature branch
git checkout -b feature/your-feature-name
```

## Types of Contributions

### 1. Documentation

Documentation is crucial! We welcome:

- **Corrections** - Fix typos, clarify confusing sections
- **Translations** - Help translate docs to other languages
- **Examples** - Add code examples or clarify existing ones
- **Guides** - Create tutorials or how-to guides
- **Improvements** - Better organization or structure

**How to contribute:**
```bash
# Edit .md files in docs/ or .claude/docs/
# Test that links work
# Submit PR with clear description
```

### 2. Code Templates

Improve the project templates and scaffolding:

- **Architecture** - Better Clean Architecture patterns
- **Security** - New security implementations
- **Features** - New example features
- **Patterns** - Reusable code patterns

**Requirements:**
- Follows existing code style
- Documented with comments
- Includes test example
- Tested and working
- Follows OWASP guidelines

### 3. Example Projects

Create new example apps demonstrating concepts:

- **E-commerce** - Product catalog, checkout, payments
- **Social Media** - Messaging, notifications, real-time
- **Healthcare** - HIPAA compliance, sensitive data
- **Finance** - PCI DSS compliance, transactions

**Requirements:**
- Complete, runnable project
- >80% test coverage
- Clean Architecture
- Well documented
- Security best practices

### 4. Bug Reports

Found a bug? Help us fix it:

```bash
# Use GitHub Issues -> New Issue -> Bug Report
# Include:
1. Description of the bug
2. Steps to reproduce
3. Expected behavior
4. Actual behavior
5. Your environment (Flutter version, OS, etc.)
6. Code snippet if applicable
```

### 5. Feature Requests

Have an idea? Let us know:

```bash
# Use GitHub Issues -> New Issue -> Feature Request
# Include:
1. Clear description of the feature
2. Why it would be useful
3. Example use case
4. Possible implementation approach
5. Any related issues
```

### 6. Security Improvements

Help keep the project secure:

- **Vulnerability Reports** - Report security issues privately
- **Security Improvements** - Better security patterns
- **Compliance** - New compliance guidelines
- **Best Practices** - Security best practices

**Important:** For security vulnerabilities, see [SECURITY.md](SECURITY.md) - please report privately first!

### 7. Performance Improvements

Optimize and improve performance:

- **Profiling** - Identify performance bottlenecks
- **Optimization** - Improve algorithm efficiency
- **Memory** - Reduce memory footprint
- **Startup** - Faster app launch times

## Development Setup

### Local Development

```bash
# Get dependencies
flutter pub get

# Generate code (if needed)
flutter pub run build_runner build --delete-conflicting-outputs

# Run tests
flutter test

# Check code quality
dart analyze
dart format -l 100 lib/

# Check for security issues
dart pub audit
```

### IDE Setup

**VS Code:**
```json
{
  "extensions": [
    "Dart-Code.dart-code",
    "Dart-Code.flutter",
    "soywod.flutter-tree"
  ]
}
```

**Android Studio:**
- Install Flutter plugin
- Install Dart plugin
- Restart IDE

## Submission Guidelines

### Branch Naming

Use descriptive branch names:

```
feature/description              # New features
fix/description                  # Bug fixes
docs/description                 # Documentation
security/description             # Security improvements
test/description                 # Test improvements
```

### Commit Messages

Write clear, descriptive commit messages:

```bash
# Good
git commit -m "feat: add certificate pinning implementation

- Implement SHA256 pinning for API calls
- Add validation interceptor
- Include setup documentation
- Add security tests"

# Bad
git commit -m "update"
git commit -m "fix bug"
```

### PR Title Format

```
[Type]: Brief description

Types: feat, fix, docs, security, test, refactor, perf
```

Examples:
- `[feat]: Add E2E encryption for messages`
- `[fix]: Fix token refresh on 401 response`
- `[docs]: Add Firebase setup guide`
- `[security]: Implement certificate pinning`
- `[test]: Add integration tests for auth flow`

## Quality Standards

### Code Style

Follow Flutter and Dart conventions:

```dart
// ✅ Good
class UserRepository {
  final ApiClient apiClient;

  UserRepository({required this.apiClient});

  Future<User> getUser(String id) async {
    // Implementation
  }
}

// ❌ Bad
class user_repo {
  ApiClient api;

  getUser(id){
    // Implementation
  }
}
```

### Documentation

- Add doc comments to public APIs
- Include code examples
- Explain "why" not just "what"
- Keep docs up-to-date

```dart
/// Fetches user data from the API.
///
/// Throws [ApiException] if the request fails.
///
/// Example:
/// ```dart
/// final user = await repository.getUser('123');
/// print(user.email);
/// ```
Future<User> getUser(String id) async { ... }
```

### Testing

- Aim for >80% code coverage
- Test happy paths and error cases
- Use meaningful test names
- Mock external dependencies

```dart
test('getUser returns user data', () async {
  // Arrange
  const userId = '123';
  final mockUser = User(id: userId, name: 'John');
  when(mockApi.getUser(userId)).thenAnswer((_) async => mockUser);

  // Act
  final result = await repository.getUser(userId);

  // Assert
  expect(result, mockUser);
  verify(mockApi.getUser(userId)).called(1);
});
```

### Security

- No hardcoded credentials
- Use secure storage for sensitive data
- Input validation on all external data
- Follow OWASP guidelines
- Run `dart pub audit`

### Performance

- Use const constructors
- Lazy load when possible
- Profile before optimizing
- Document performance implications

## Pull Request Process

### Before Submitting

1. **Update from main**
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Run tests**
   ```bash
   flutter test --coverage
   ```

3. **Check code quality**
   ```bash
   dart analyze
   dart format -l 100 lib/ --set-exit-if-changed
   ```

4. **Security check**
   ```bash
   dart pub audit
   ```

### Submitting PR

1. Push to your fork: `git push origin feature/your-feature`
2. Open PR on GitHub
3. Fill out PR template completely
4. Link related issues
5. Request reviewers

### PR Template

```markdown
## Description
[Brief description of changes]

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation
- [ ] Security improvement
- [ ] Performance improvement

## Related Issues
Closes #[issue number]

## Changes Made
- [Change 1]
- [Change 2]
- [Change 3]

## Testing
- [ ] Added/updated tests
- [ ] All tests passing
- [ ] Coverage >80%

## Security
- [ ] No hardcoded secrets
- [ ] Input validation added
- [ ] OWASP guidelines followed

## Screenshots (if applicable)
[Add screenshots/videos]

## Checklist
- [ ] My code follows the style guidelines
- [ ] I have performed a self-review
- [ ] I have commented complex areas
- [ ] I have updated documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix/feature works
- [ ] New and existing unit tests pass locally
```

## Code Review

### What Reviewers Look For

1. **Correctness** - Does it work? Does it solve the problem?
2. **Quality** - Is the code clean and well-organized?
3. **Security** - Are OWASP guidelines followed?
4. **Performance** - Is it efficient?
5. **Tests** - Is coverage adequate?
6. **Documentation** - Is it clear and complete?

### Responding to Feedback

- Be open to suggestions
- Ask clarifying questions
- Update code based on feedback
- Thank reviewers for their time
- Don't take criticism personally

### Getting Your PR Merged

Your PR will be merged when:
- ✅ All CI checks pass
- ✅ Code review approved
- ✅ Conflicts resolved
- ✅ Meets quality standards

## Tips for Success

### 1. Start Small
Begin with small contributions to understand the process.

### 2. Communicate
Open an issue first to discuss major changes.

### 3. Read Documentation
Understand the architecture and guidelines.

### 4. Test Thoroughly
Test on real devices when possible.

### 5. Be Patient
Review takes time - be patient and kind.

### 6. Keep Learning
Study merged PRs to learn from others.

## Recognition

Contributors are recognized through:
- GitHub contributors page
- CONTRIBUTORS.md file
- Release notes for significant contributions
- Monthly community highlights

## Getting Help

- **Questions?** Check [FAQ.md](docs/FAQ.md) or open a discussion
- **Stuck?** Ask in GitHub Discussions
- **Issues?** Open a GitHub Issue
- **Security?** See [SECURITY.md](SECURITY.md)

## Resources

- [Flutter Development Guide](https://flutter.dev/docs)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [Clean Architecture](https://resocoder.com/flutter-clean-architecture)
- [Riverpod Documentation](https://riverpod.dev)
- [OWASP Mobile Top 10](https://owasp.org/www-project-mobile-top-10/)

## Thank You

Thank you for contributing to make Flutter development better for everyone! 🙏

Your contributions, big or small, help build an amazing community.

---

Happy contributing! 🚀

