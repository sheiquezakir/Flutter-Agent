# Flutter Expert Agent - Usage Guide

Complete guide on how to use the Flutter Expert Agent for building production-grade applications.

## Table of Contents

1. [Quick Start](#quick-start)
2. [Invoking the Agent](#invoking-the-agent)
3. [Use Cases](#use-cases)
4. [Best Results](#best-results)
5. [Examples](#examples)
6. [Tips & Tricks](#tips--tricks)

## Quick Start

### Prerequisites

- Flutter 3.32+ installed
- Dart 3.8+ installed
- Understanding of Clean Architecture basics
- Basic knowledge of Riverpod or state management

### Basic Invocation

When working with the agent, provide clear context:

```
I need to create a new Flutter app for [app purpose].
It should be built with Clean Architecture, Riverpod, and include:
- [Feature 1]
- [Feature 2]
- [Feature 3]

Target platforms: iOS, Android, Web
Design system: Material Design 3
Security: OWASP compliant with certificate pinning
```

## Invoking the Agent

### Via Claude Code

Use the Flutter Expert Agent skill:

```
/use flutter-expert

Create a new Flutter app with authentication, user profiles, and offline support.
```

### For Security Audits

Invoke the security auditor:

```
/use flutter-security-auditor

Audit my Flutter app for OWASP Mobile Top 10 vulnerabilities.
Check files in lib/ for security issues.
```

## Use Cases

### 1. New App Scaffolding

**When to use:** Starting a new Flutter project from scratch

**What to provide:**
- App purpose and target users
- Platforms (iOS, Android, Web, Desktop)
- Key features
- Performance requirements
- Security/compliance needs

**Example:**
```
I'm building a social media app called "ConnectHub" for iOS, Android, and Web.

Key features:
- User authentication (email/phone)
- User profiles with image upload
- Real-time messaging
- Notifications
- Offline support

This will serve 100K+ users. Security is critical.
```

**What the agent delivers:**
1. Full project structure with Clean Architecture
2. Riverpod state management setup
3. API client configuration
4. Database schema and setup
5. Authentication flow
6. Sample features with tests
7. CI/CD configuration
8. Security hardening

---

### 2. Security Code Review

**When to use:** Audit existing code for vulnerabilities

**What to provide:**
- Description of security concerns
- Files/paths to audit
- What compliance standards matter (GDPR, HIPAA, etc.)

**Example:**
```
I need a security audit of my Flutter app.

Concerns:
- Authentication token storage
- API data encryption
- Certificate pinning implementation
- OWASP Mobile Top 10 compliance

Key files:
- lib/features/auth/
- lib/core/networking/
- lib/features/profile/
```

**What the agent delivers:**
1. OWASP M1-M10 vulnerability scan
2. Hardcoded secrets detection
3. Insecure storage patterns
4. Network security issues
5. Input validation gaps
6. Compliance scoring
7. Prioritized fixes with code examples

---

### 3. Feature Development

**When to use:** Add new features to existing app

**What to provide:**
- Feature description and requirements
- Data flow and user interactions
- State management needs
- API endpoints (if applicable)

**Example:**
```
Add a payment feature to my Flutter app.

Requirements:
- Support Stripe and Apple Pay
- Secure transaction storage
- Order history with offline access
- Transaction notifications

The app uses Riverpod for state management.
Tech stack: Drift database, Dio for API, Firebase for notifications.
```

**What the agent delivers:**
1. Feature structure (data, domain, presentation layers)
2. Riverpod providers for state management
3. API integration code
4. UI components with tests
5. Error handling
6. Security best practices implementation

---

### 4. Code Modernization

**When to use:** Upgrade or refactor existing code

**What to provide:**
- Current architecture/state management
- What needs upgrading
- Target architecture

**Example:**
```
I have a 2-year-old Flutter app built with Provider and some legacy patterns.

Current issues:
- Provider causing excessive rebuilds
- No Clean Architecture
- Weak error handling
- Poor test coverage (10%)

Goal: Migrate to Riverpod + Clean Architecture
Maintain all functionality, add proper testing.
```

**What the agent delivers:**
1. Migration plan with phases
2. Architecture refactoring steps
3. Riverpod provider setup
4. Tests for each layer
5. Deprecation guide for old patterns

---

### 5. Performance Optimization

**When to use:** Improve app performance

**What to provide:**
- Performance bottlenecks
- Affected areas
- Constraints (APK size, memory, etc.)

**Example:**
```
My Flutter app is slow with large lists and complex animations.

Issues:
- List with 1000+ items causing jank
- Complex CustomPaint animations
- APK size is 120MB
- Memory usage spikes to 500MB

Need: Performance optimization advice and implementation
```

**What the agent delivers:**
1. Performance analysis
2. Optimization techniques (const, lazy loading, etc.)
3. Memory leak prevention
4. Asset optimization
5. Profiling guidance

---

## Best Results

### 1. Provide Complete Context

**Good:**
```
I need to build a fitness tracking app with:
- User authentication
- Workout tracking with GPS
- Social features (follow, share)
- Offline support for workouts
- Analytics integration

Constraints:
- Team of 3 developers
- 3-month deadline
- Target: iOS 14.5+, Android 8.0+
```

**Bad:**
```
Build me a fitness app.
```

### 2. Specify Technology Preferences

**Good:**
```
I prefer:
- State management: Riverpod
- Database: Drift for local storage
- Networking: Dio with Retrofit
- Testing: Mockito for mocks
```

**Bad:**
```
Use whatever you think is best.
```

### 3. Clarify Security Requirements

**Good:**
```
Security requirements:
- GDPR compliant (user data collection)
- Certificate pinning for API calls
- End-to-end encryption for messages
- Biometric authentication support
```

**Bad:**
```
Make it secure.
```

### 4. Share Constraints

**Good:**
```
Constraints:
- APK size: max 50MB
- Target audience: 100K users
- Performance: 60fps on mid-range devices
- No external backend infrastructure
```

**Bad:**
```
No constraints, make it perfect.
```

## Examples

### Example 1: Starting a Weather App

**Your request:**
```
I'm starting a weather app called "SkyForecast".

Features:
- Current weather display
- 7-day forecast
- Location search
- Favorite locations
- Weather alerts
- Offline mode

Tech preferences:
- Clean Architecture
- Riverpod state management
- Material Design 3
- Firebase for notifications
- Local SQLite database

Target: iOS 14+, Android 8+
Security: Standard app security (no sensitive data)
```

**Agent's response will include:**
1. Complete project structure scaffolding
2. pubspec.yaml with all dependencies
3. Riverpod provider setup
4. API integration (OpenWeatherMap or similar)
5. Database schema
6. Feature modules for each requirement
7. Error handling and offline support
8. CI/CD configuration
9. Tests for critical paths

### Example 2: Security Audit Request

**Your request:**
```
Please audit my Flutter e-commerce app for security vulnerabilities.

Current implementation:
- Firebase Authentication
- Stripe payment integration
- User profiles with images
- Product catalog
- Order management

Concerns:
- Storing auth tokens
- Payment security
- Image upload handling
- SQL injection prevention
- Data encryption

Compliance: GDPR + PCI DSS (for payments)
```

**Agent's response will include:**
1. OWASP Mobile Top 10 scan report
2. Hardcoded credentials check
3. Storage security assessment
4. Network security verification
5. Input validation review
6. Payment security analysis
7. Compliance checklist (GDPR, PCI DSS)
8. Priority-ordered fixes
9. Code examples for fixes
10. Implementation timeline

### Example 3: Feature Development

**Your request:**
```
Add in-app notifications to my Flutter app.

Requirements:
- Push notifications (Firebase Cloud Messaging)
- Local notifications (when app is foreground)
- Notification history/archive
- Different notification types (order, promo, system)
- Offline queuing of notifications

Current tech stack:
- Riverpod for state management
- Clean Architecture
- Drift database
- Firebase backend

Timeline: 2 weeks
```

**Agent's response will include:**
1. Feature layer structure (data, domain, presentation)
2. Notification service implementation
3. Riverpod providers for notification state
4. UI components (notification center, history)
5. Tests (unit, widget, integration)
6. Security considerations
7. Error handling
8. Implementation checklist

## Tips & Tricks

### 1. Iterative Development

Don't ask for everything at once. Instead:

```
Step 1: Set up Clean Architecture and Riverpod
Step 2: Add authentication
Step 3: Build user profile feature
Step 4: Add product catalog
...
```

This allows for better incremental feedback and testing.

### 2. Ask for Explanations

```
I understand the code, but can you explain:
1. Why we use AsyncNotifierProvider for this?
2. How error handling flows through the layers?
3. Why we separate local and remote data sources?
```

### 3. Request Security Review

After implementing features:

```
Here's my implementation of [feature].
Can you review it for:
- Security vulnerabilities
- Memory leaks
- Performance issues
- Testing gaps
```

### 4. Get Design System Customization

```
I need to customize Material Design 3 for my brand.

Brand colors:
- Primary: #FF6B35
- Secondary: #004E89
- Tertiary: #F7931E

Custom typography:
- Font: Inter
- Headlines: Bold
- Body: Regular
```

### 5. Request Performance Profiling

```
My app is slow in this scenario:
[Describe the scenario]

Help me:
1. Profile the performance
2. Identify bottlenecks
3. Optimize the code
```

### 6. Ask for Testing Strategy

```
How should I test:
1. Complex Riverpod state logic
2. API interactions with error cases
3. Database operations
4. Widget interactions with async data
```

## Common Questions

### Q: Should I use BLoC or Riverpod?

**A:** The agent recommends Riverpod as primary because:
- Less boilerplate
- Compile-time safety
- No BuildContext required
- Better scoping system

However, BLoC is suitable for:
- Large enterprise apps with many developers
- When you need strict event-driven architecture
- Teams familiar with BLoC pattern

### Q: How much test coverage do I need?

**A:** Target >80% coverage with focus on:
- All business logic (domain layer)
- All user interactions (widget tests)
- Critical features (integration tests)

Less important: Simple getters/setters, trivial widgets

### Q: When should I use local database vs cloud?

**A:** Use Drift (local) for:
- Offline support
- Large dataset access (faster than network)
- User preferences
- Cache

Use Cloud Firestore for:
- Real-time collaboration
- User data sync across devices
- Scalable backend

Consider both for most apps: Cloud as source of truth, local as cache.

### Q: How do I handle authentication properly?

**A:** Best practices:
1. Use Firebase Auth or similar
2. Store tokens in FlutterSecureStorage
3. Implement token refresh
4. Never store passwords
5. Use HTTPS + certificate pinning
6. Implement logout properly (clear all data)

### Q: What's the minimum APK size I should aim for?

**A:** For typical Flutter apps:
- Baseline: 20-30MB (Flutter engine + framework)
- Simple app: 30-50MB
- Medium app: 50-80MB
- Complex app: 80-120MB

Optimize: Use code shrinking, image compression, asset splitting.

## Getting Help

### Within Claude Code

```
@flutter-expert

1. I'm stuck on [specific issue]
2. Can you help me debug?
3. How do I solve [problem]?
```

### Provide Minimal Reproducible Example

```
I have a bug in my Riverpod provider.

Code:
```dart
final userProvider = AsyncNotifierProvider<UserNotifier, User>(...);
```

Issue: Provider doesn't refresh when called
Expected: Provider should fetch fresh data
Actual: Shows cached data

How do I fix this?
```
```

### Ask for Code Review

Paste your code and ask:
```
Can you review this for:
1. Security issues
2. Performance problems
3. Memory leaks
4. Testing gaps
5. Clean Architecture violations
```

## Next Steps

Now that you understand the agent:

1. **Start with a simple feature** - Get familiar with the workflow
2. **Review generated code** - Understand the patterns
3. **Run the tests** - Verify everything works
4. **Customize to your needs** - Adapt based on requirements
5. **Scale up** - Add more complex features

Happy building! 🚀

