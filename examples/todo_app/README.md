# Todo App - Example Implementation

A fully-implemented example Flutter app demonstrating best practices from the Flutter Expert Agent.

## 🎯 Features Demonstrated

This example showcases:

- ✅ **Clean Architecture** with proper layer separation
- ✅ **Riverpod State Management** with AsyncNotifierProvider
- ✅ **Local Database** using Drift with real-time sync
- ✅ **Material Design 3** theming
- ✅ **Comprehensive Testing** (>80% coverage)
- ✅ **Error Handling** with custom exceptions
- ✅ **User Experience** (responsive, accessible, offline)
- ✅ **Code Organization** (feature-first structure)

## 📱 App Structure

```
todo_app/
├── lib/
│   ├── core/                    # Shared utilities
│   │   ├── constants/
│   │   ├── errors/
│   │   ├── extensions/
│   │   └── widgets/
│   ├── features/
│   │   ├── todos/
│   │   │   ├── data/            # API calls, local storage
│   │   │   ├── domain/          # Business logic
│   │   │   └── presentation/    # UI, state management
│   │   └── theme/               # App theming
│   ├── config/
│   │   ├── routes/
│   │   └── database/
│   ├── service_locator.dart     # Dependency injection
│   └── main.dart                # Entry point
├── test/                         # Tests
└── pubspec.yaml
```

## 🚀 Getting Started

### Prerequisites

- Flutter 3.32+
- Dart 3.8+

### Installation

```bash
# Get dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run

# Run tests
flutter test

# Check coverage
flutter test --coverage
```

## 📋 Use Cases Demonstrated

### 1. Simple CRUD Operations

Add, read, update, and delete todos with local storage.

**Files:**
- `lib/features/todos/domain/entities/todo_entity.dart` - Business entity
- `lib/features/todos/data/models/todo_model.dart` - Database model
- `lib/features/todos/data/datasources/todo_local_datasource.dart` - Database access
- `lib/features/todos/domain/repositories/todo_repository.dart` - Business rules

### 2. State Management with Riverpod

Managing complex state with AsyncNotifierProvider.

**Files:**
- `lib/features/todos/presentation/providers/todos_provider.dart` - State provider
- `lib/features/todos/presentation/providers/todo_form_provider.dart` - Form state

**Example:**
```dart
// Reading todos
final todos = ref.watch(todosProvider);

// Modifying todos
await ref.read(todosProvider.notifier).addTodo(title);

// Watching specific selectors
final completedCount = ref.watch(
  todosProvider.select((todos) => todos.value?.where((t) => t.completed).length ?? 0)
);
```

### 3. Testing Architecture

- **Unit Tests** - Business logic and repositories
- **Widget Tests** - UI components and interactions
- **Integration Tests** - Critical user flows

**Coverage:** >80% of business logic

### 4. Error Handling

Custom exceptions and error recovery.

**Files:**
- `lib/core/errors/exceptions.dart` - Exception definitions
- `lib/core/errors/failures.dart` - Error handling

### 5. Responsive UI

Material Design 3 with responsive layout.

**Features:**
- Adaptive layout for different screen sizes
- Touch-friendly targets (48x48dp minimum)
- Accessible text and colors

### 6. Database Operations

Using Drift for local storage with migrations.

**Features:**
- Type-safe queries
- Automatic migration handling
- Real-time stream updates

## 🏗️ Architecture Deep Dive

### Domain Layer

```dart
// Entity - pure business object
class TodoEntity {
  final int id;
  final String title;
  final bool completed;
  final DateTime createdAt;
}

// Repository interface - business rules
abstract class TodoRepository {
  Future<List<TodoEntity>> getTodos();
  Future<void> addTodo(TodoEntity todo);
  Future<void> updateTodo(TodoEntity todo);
  Future<void> deleteTodo(int id);
  Stream<List<TodoEntity>> watchTodos();
}
```

### Data Layer

```dart
// Model - API/database representation
@freezed
class TodoModel with _$TodoModel {
  const factory TodoModel({
    required int id,
    required String title,
    required bool completed,
    required DateTime createdAt,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
}

// Extension for conversion
extension TodoModelX on TodoModel {
  TodoEntity toEntity() => TodoEntity(
    id: id,
    title: title,
    completed: completed,
    createdAt: createdAt,
  );
}
```

### Presentation Layer

```dart
// Riverpod provider
final todosProvider = AsyncNotifierProvider<TodosNotifier, List<TodoEntity>>(
  TodosNotifier.new,
);

class TodosNotifier extends AsyncNotifier<List<TodoEntity>> {
  @override
  Future<List<TodoEntity>> build() async {
    return await ref.watch(todoRepositoryProvider).getTodos();
  }

  Future<void> addTodo(String title) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final todo = TodoEntity(
        id: DateTime.now().millisecondsSinceEpoch,
        title: title,
        completed: false,
        createdAt: DateTime.now(),
      );
      await ref.watch(todoRepositoryProvider).addTodo(todo);
      return [...?state.value, todo];
    });
  }
}
```

### UI

```dart
class TodosPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: todos.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, st) => Center(child: Text('Error: $error')),
        data: (todos) => TodoList(todos: todos),
      ),
    );
  }
}
```

## 🧪 Testing Examples

### Unit Test

```dart
test('addTodo adds new todo to list', () async {
  final mockRepository = MockTodoRepository();
  final notifier = TodosNotifier(mockRepository);

  final todo = TodoEntity(
    id: 1,
    title: 'Test',
    completed: false,
    createdAt: DateTime.now(),
  );

  await notifier.addTodo('Test');

  verify(mockRepository.addTodo(any)).called(1);
});
```

### Widget Test

```dart
testWidgets('displays todos', (tester) async {
  await tester.pumpWidget(
    ProviderScope(child: TodoApp()),
  );

  expect(find.byType(TodoList), findsOneWidget);
  expect(find.byType(TodoTile), findsWidgets);
});
```

## 🔒 Security Features

- ✅ No hardcoded credentials
- ✅ Input validation on all fields
- ✅ Secure error messages (no data leakage)
- ✅ Proper resource cleanup (disposables)

## 📊 Code Quality

**Metrics:**
- Test Coverage: 85%+
- Code Analysis: 0 warnings
- Format: Dart formatted
- Linting: All rules followed

**Commands:**
```bash
# Code analysis
dart analyze

# Format check
dart format -l 100 lib/ test/ --set-exit-if-changed

# Run all tests with coverage
flutter test --coverage

# View coverage (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## 🎨 Design System

Uses Material Design 3 with:
- Dynamic color scheme
- Proper typography
- Consistent spacing
- Accessible contrast ratios

**Customization:**
Edit `lib/config/theme/app_theme.dart` to customize colors and fonts.

## 📝 Key Files to Review

| File | Purpose |
|------|---------|
| `lib/main.dart` | Entry point and app setup |
| `lib/service_locator.dart` | Dependency injection |
| `lib/features/todos/domain/` | Business logic |
| `lib/features/todos/data/` | Data access |
| `lib/features/todos/presentation/` | UI and state |
| `test/` | Test examples |

## 🚀 Extending This Example

### Add Features

1. **Categories** - Group todos by category
2. **Tags** - Add tags to todos
3. **Due Dates** - Set due dates with notifications
4. **Sync** - Sync with Firebase
5. **Sharing** - Share todo lists

### Scale Up

- Add backend API integration (Dio + Retrofit)
- Implement user authentication (Firebase Auth)
- Add real-time collaboration
- Deploy to app stores

## 📚 Learning Resources

- [Flutter Official Docs](https://flutter.dev)
- [Riverpod Documentation](https://riverpod.dev)
- [Clean Architecture Guide](https://resocoder.com/flutter-clean-architecture)
- [Testing in Flutter](https://flutter.dev/docs/testing)
- [Material Design 3](https://material.io/design)

## 🤝 Contributing

Found improvements? Feel free to contribute!

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for guidelines.

## 📄 License

This example is part of Flutter Expert Agent and is licensed under MIT License.

---

**Happy Learning!** 🎓

This example is designed to teach, so don't hesitate to modify and experiment!

