# Flutter Development Guidelines - 2025

Complete reference for building production-grade Flutter applications.

## Table of Contents

1. [Architecture & Patterns](#architecture--patterns)
2. [State Management](#state-management)
3. [Code Quality](#code-quality)
4. [Testing](#testing)
5. [Performance](#performance)
6. [Accessibility](#accessibility)
7. [Localization](#localization)
8. [Offline Support](#offline-support)
9. [Common Patterns](#common-patterns)
10. [Troubleshooting](#troubleshooting)

## Architecture & Patterns

### Clean Architecture Layers

```
Presentation Layer (UI, Widgets, State Management)
        ↓
Domain Layer (Entities, Use Cases, Repository Interfaces)
        ↓
Data Layer (DTOs, Data Sources, Repository Implementations)
```

**Rules:**
- No external dependencies in Domain layer
- Domain depends on nothing
- Presentation and Data both depend on Domain
- Always code to interfaces (repositories, data sources)

### Feature-First Organization

```
lib/
  features/
    authentication/
    home/
    profile/
    settings/
  core/         # Shared across features
    constants/
    errors/
    extensions/
    utils/
    widgets/
```

**Benefits:**
- Easy to add/remove features
- Reduced build time (better tree-shaking)
- Clear dependencies
- Team scaling (features = independent teams)

### Dependency Injection with get_it

```dart
// Setup in main()
await configureDependencies();

// In classes
class MyRepository {
  final apiClient = getIt<Dio>();
}

// Testing
setUp(() {
  getIt.reset();
  getIt.registerSingleton<Dio>(MockDio());
});
```

## State Management

### Riverpod Patterns

#### 1. Reading Data (FutureProvider)

```dart
// Simple data fetch
final userProvider = FutureProvider<User>((ref) async {
  return await getIt<UserRepository>().getUser();
});

// Use in widget
final user = ref.watch(userProvider);
user.when(
  loading: () => const CircularProgressIndicator(),
  error: (err, st) => Text('Error: $err'),
  data: (user) => Text(user.name),
);
```

#### 2. Mutable State (StateProvider)

```dart
// Simple counter
final counterProvider = StateProvider((ref) => 0);

// Use
ref.watch(counterProvider); // Read
ref.read(counterProvider.notifier).state++; // Modify
```

#### 3. Complex State (AsyncNotifierProvider)

```dart
class TodoNotifier extends AsyncNotifier<List<Todo>> {
  @override
  Future<List<Todo>> build() async {
    return await getIt<TodoRepository>().getTodos();
  }

  Future<void> addTodo(String title) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final todo = await getIt<TodoRepository>().createTodo(title);
      return [...?state.value, todo];
    });
  }
}

final todoProvider = AsyncNotifierProvider<TodoNotifier, List<Todo>>(
  TodoNotifier.new,
);
```

#### 4. Parameterized Providers (Family)

```dart
// Get specific user
final userProvider = FutureProvider.family<User, String>((ref, userId) async {
  return await getIt<UserRepository>().getUser(userId);
});

// Use
ref.watch(userProvider('user123'));
```

#### 5. Combining Providers

```dart
// Derived state
final favoriteCountProvider = Provider<int>((ref) {
  final todos = ref.watch(todoProvider).value ?? [];
  return todos.where((t) => t.isFavorite).length;
});
```

### Testing Riverpod Providers

```dart
test('returns user data', () async {
  final container = ProviderContainer();

  final result = await container.read(userProvider.future);

  expect(result.name, 'John Doe');
});

test('counter increments', () async {
  final container = ProviderContainer();

  final before = container.read(counterProvider);
  container.read(counterProvider.notifier).state++;
  final after = container.read(counterProvider);

  expect(after, before + 1);
});
```

## Code Quality

### Naming Conventions

```dart
// ❌ Bad
class uSER {}
var x = 5;
void fn() {}

// ✅ Good
class User {}
var numberOfItems = 5;
void fetchUserData() {}
```

### File Organization

```dart
// One public class per file, with extensions in same file
class User {
  // Implementation
}

extension UserX on User {
  // Extensions
}
```

### Constants

```dart
// Avoid magic numbers
// ❌ Bad
if (price > 100) ...

// ✅ Good
const double premiumThreshold = 100;
if (price > premiumThreshold) ...

// Use sealed classes for constants
sealed class Constants {
  static const String apiBaseUrl = 'https://api.example.com';
  static const Duration networkTimeout = Duration(seconds: 30);
}
```

### Error Handling

```dart
// Use try-catch for specific exceptions
try {
  await apiCall();
} on TimeoutException catch (e) {
  print('Request timed out');
} on FormatException catch (e) {
  print('Invalid format');
} on SocketException catch (e) {
  print('No internet connection');
} catch (e) {
  print('Unknown error: $e');
}

// Create custom exceptions
class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}
```

### Null Safety

```dart
// ❌ Bad
String getName() {
  return null; // Error!
}

// ✅ Good
String? getName() => null;
String getName() => 'default';

// Type promotion
void process(Object? value) {
  if (value is String) {
    print(value.length); // String, no ?
  }
}

// Null coalescing
final name = user?.name ?? 'Unknown';

// Late initialization
late final String name; // Must be set before use
```

## Testing

### Test Structure (AAA Pattern)

```dart
test('counter increments when button pressed', () {
  // Arrange
  final counter = Counter();

  // Act
  counter.increment();

  // Assert
  expect(counter.value, 1);
});
```

### Unit Test Example

```dart
void main() {
  group('User Validation', () {
    test('should validate email format', () {
      expect(
        UserValidator.isValidEmail('test@example.com'),
        true,
      );
      expect(
        UserValidator.isValidEmail('invalid.email'),
        false,
      );
    });
  });
}
```

### Widget Test Example

```dart
testWidgets('displays user name', (WidgetTester tester) async {
  // Arrange
  const user = User(name: 'John', email: 'john@example.com');

  // Act
  await tester.pumpWidget(
    MaterialApp(
      home: UserProfile(user: user),
    ),
  );

  // Assert
  expect(find.text('John'), findsOneWidget);
});
```

### Mocking with Mockito

```dart
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  test('loads user on init', () async {
    final mockRepository = MockUserRepository();
    final user = User(name: 'John', email: 'john@example.com');

    when(mockRepository.getUser()).thenAnswer((_) async => user);

    final result = await mockRepository.getUser();

    expect(result.name, 'John');
    verify(mockRepository.getUser()).called(1);
  });
}
```

### Test Coverage Goal: >80%

```bash
# Generate coverage report
flutter test --coverage

# View coverage (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Performance

### Widget Optimization

```dart
// ✅ Use const whenever possible
const MyWidget(
  child: Text('Hello'),
);

// ✅ Split large widgets into smaller ones
class ComplexWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderSection(), // Separate widget
        BodySection(),   // Separate widget
        FooterSection(), // Separate widget
      ],
    );
  }
}

// ✅ Use ListView.builder for long lists
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemTile(item: items[index]),
)

// ❌ Avoid rebuilding entire list
ListView(
  children: items.map((item) => ItemTile(item: item)).toList(),
)
```

### Memory Management

```dart
// Always dispose resources
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription = stream.listen((_) {});
  }

  @override
  void dispose() {
    subscription.cancel(); // ✅ Clean up
    super.dispose();
  }
}
```

### Image Optimization

```dart
// ✅ Cache images
Image.network(
  'https://example.com/image.jpg',
  cacheHeight: 200,
  cacheWidth: 200,
)

// ✅ Use appropriate formats
// PNG: Graphics, transparency
// JPG: Photos, complex scenes
// WebP: Best compression (modern)

// ✅ Compress before uploading
// Use tools: ImageMagick, TinyPNG API
```

### Profiling

```bash
# Record performance timeline
flutter run --profile

# Open DevTools
dart devtools

# Monitor:
# - Frame rendering time (target: <16ms for 60fps)
# - Memory usage
# - CPU usage
# - Janky frames
```

## Accessibility

### Semantic Labels

```dart
// ❌ Bad
IconButton(
  icon: Icon(Icons.close),
  onPressed: () {},
)

// ✅ Good
IconButton(
  icon: Icon(Icons.close),
  onPressed: () {},
  tooltip: 'Close dialog',
  semanticLabel: 'Close',
)
```

### Text Contrast

```dart
// ✅ Aim for 4.5:1 contrast ratio minimum
Text(
  'Important text',
  style: TextStyle(
    color: Colors.black87, // Dark on light
    fontSize: 14,
  ),
)
```

### Touch Targets

```dart
// ✅ Minimum 48x48dp
SizedBox(
  width: 48,
  height: 48,
  child: IconButton(icon: Icon(Icons.add)),
)
```

### Screen Reader Support

```dart
// ✅ Add meaningful labels
Semantics(
  label: 'Subscribe button',
  enabled: true,
  button: true,
  onTap: () {},
  child: GestureDetector(
    onTap: () {},
    child: const Text('Subscribe'),
  ),
)
```

## Localization

### Setup i18n

1. Add to pubspec.yaml:
```yaml
dependencies:
  intl: ^0.19.0

dev_dependencies:
  intl_translation: ^0.18.0
```

2. Create `l10n/intl_en.arb`:
```json
{
  "hello": "Hello, {name}!",
  "itemCount": "{count, plural, =0{No items} one{1 item} other{{count} items}}"
}
```

3. Generate translations:
```bash
flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/**/*.dart
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-symbolic-links --output-localization-file=messages_all.dart lib/l10n/intl_*.arb
```

### Usage

```dart
// In UI
Text(AppLocalizations.of(context)!.hello('John'))

// Pluralization
Text(AppLocalizations.of(context)!.itemCount(5))
```

## Offline Support

### Caching Strategy

```dart
// ✅ Cache GET requests
final cachedResponse = await localDatabase.getCache(url);
if (cachedResponse != null && !isCacheStale(cachedResponse)) {
  return cachedResponse;
}

final response = await dio.get(url);
await localDatabase.saveCache(url, response);
return response;
```

### Sync Strategy

```dart
// Queue operations while offline
class OfflineSyncManager {
  Future<void> queueOperation(Operation operation) async {
    await database.insertOperation(operation);
  }

  Future<void> syncPendingOperations() async {
    final operations = await database.getPendingOperations();
    for (final op in operations) {
      try {
        await executeOperation(op);
        await database.deleteOperation(op.id);
      } catch (e) {
        // Retry later
      }
    }
  }
}
```

## Common Patterns

### Singleton Service

```dart
class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;

  AuthService._internal();

  // Implementation
}
```

### Repository Pattern

```dart
abstract class UserRepository {
  Future<User> getUser(String id);
  Future<void> saveUser(User user);
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  @override
  Future<User> getUser(String id) async {
    try {
      return await remoteDataSource.getUser(id);
    } catch (e) {
      return await localDataSource.getUser(id);
    }
  }
}
```

### Provider Pattern (Riverpod)

```dart
// Repository
final userRepositoryProvider = Provider((ref) => UserRepositoryImpl());

// Use case
final getUserUseCase = Provider((ref) {
  return GetUserUseCase(ref.watch(userRepositoryProvider));
});

// State
final userProvider = FutureProvider((ref) async {
  return ref.watch(getUserUseCase).call();
});
```

## Troubleshooting

### Common Issues

#### State not updating

```dart
// ❌ Mutating state directly
state.items.add(newItem); // Won't notify listeners

// ✅ Create new list
state = [...state, newItem];

// ✅ Or with Freezed
state = state.copyWith(items: [...state.items, newItem]);
```

#### Providers not rebuilding

```dart
// ❌ Watching entire provider
ref.watch(provider); // Rebuilds on any change

// ✅ Watch specific property with select
ref.watch(provider.select((data) => data.name)); // Only rebuilds if name changes
```

#### Memory leaks

```dart
// ❌ Subscription not cancelled
void initState() {
  super.initState();
  stream.listen((_) {}); // Never cancelled!
}

// ✅ Cancel in dispose
@override
void dispose() {
  _subscription.cancel();
  super.dispose();
}
```

### Getting Help

- **Official Docs**: https://flutter.dev
- **Riverpod Docs**: https://riverpod.dev
- **Stack Overflow**: Tag `flutter`
- **GitHub Issues**: https://github.com/flutter/flutter/issues

