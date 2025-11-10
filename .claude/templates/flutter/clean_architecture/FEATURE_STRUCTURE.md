# Feature Structure - Clean Architecture with Riverpod

This template shows how to structure a complete feature following Clean Architecture and Riverpod best practices.

## Directory Structure

```
lib/
├── features/
│   ├── authentication/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── auth_local_datasource.dart
│   │   │   │   └── auth_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart
│   │   │   │   └── auth_response_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── user_entity.dart
│   │   │   │   └── auth_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── login_usecase.dart
│   │   │       ├── logout_usecase.dart
│   │   │       └── get_current_user_usecase.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── auth_provider.dart
│   │       │   └── login_provider.dart
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   └── register_page.dart
│   │       └── widgets/
│   │           ├── login_form.dart
│   │           └── auth_error_widget.dart
│   └── home/
│       ├── data/
│       ├── domain/
│       └── presentation/
```

## Example Implementation

### 1. Domain Layer (Business Logic)

#### Entity (user_entity.dart)
```dart
class UserEntity {
  final String id;
  final String email;
  final String name;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
  });
}
```

#### Repository Interface (auth_repository.dart)
```dart
abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String email, String password, String name);
  Future<void> logout();
  Future<UserEntity?> getCurrentUser();
  Stream<UserEntity?> authStateChanges();
}
```

#### Use Case (login_usecase.dart)
```dart
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Result<UserEntity, Exception>> call(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return Result.error(ValidationException('Empty credentials'));
      }

      final user = await repository.login(email, password);
      return Result.ok(user);
    } catch (e) {
      return Result.error(Exception('Login failed: $e'));
    }
  }
}
```

### 2. Data Layer (API & Local Storage)

#### Model (user_model.dart)
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    required DateTime createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelX on UserModel {
  UserEntity toEntity() => UserEntity(
    id: id,
    email: email,
    name: name,
    createdAt: createdAt,
  );
}
```

#### Remote Data Source (auth_remote_datasource.dart)
```dart
abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Login failed');
      }

      return UserModel.fromJson(response.data['user']);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    // Similar implementation
    throw UnimplementedError();
  }
}
```

#### Local Data Source (auth_local_datasource.dart)
```dart
abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> saveToken(String token) =>
      secureStorage.write(key: 'auth_token', value: token);

  @override
  Future<String?> getToken() =>
      secureStorage.read(key: 'auth_token');

  @override
  Future<void> deleteToken() =>
      secureStorage.delete(key: 'auth_token');
}
```

#### Repository Implementation (auth_repository_impl.dart)
```dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserEntity> login(String email, String password) async {
    final userModel = await remoteDataSource.login(email, password);

    // Save token to secure storage
    // await localDataSource.saveToken(token);

    return userModel.toEntity();
  }

  @override
  Future<void> logout() async {
    await localDataSource.deleteToken();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    // Fetch from local cache or API
    return null;
  }

  @override
  Stream<UserEntity?> authStateChanges() {
    // Return stream of auth state changes
    throw UnimplementedError();
  }
}
```

### 3. Presentation Layer (UI & State Management with Riverpod)

#### State Provider (auth_provider.dart)
```dart
import 'package:riverpod/riverpod.dart';

// Result type for async operations
@freezed
class AsyncResult<T> with _$AsyncResult<T> {
  const factory AsyncResult.loading() = _Loading;
  const factory AsyncResult.success(T data) = _Success;
  const factory AsyncResult.error(String message) = _Error;
}

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
});

// Current user provider
final currentUserProvider = FutureProvider<UserEntity?>((ref) async {
  final repository = ref.watch(authRepositoryProvider);
  return repository.getCurrentUser();
});

// Auth state stream provider
final authStateProvider = StreamProvider<UserEntity?>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges();
});
```

#### Login State Provider (login_provider.dart)
```dart
// Login notifier with full control
class LoginNotifier extends AsyncNotifier<UserEntity> {
  @override
  Future<UserEntity> build() async {
    // Initialize with current user
    final repository = ref.watch(authRepositoryProvider);
    return repository.getCurrentUser() ??
        (throw Exception('Not authenticated'));
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();

    final repository = ref.watch(authRepositoryProvider);
    state = await AsyncValue.guard(() =>
        repository.login(email, password));

    // Refresh current user provider
    ref.refresh(currentUserProvider);
  }

  Future<void> logout() async {
    final repository = ref.watch(authRepositoryProvider);
    await repository.logout();
    state = const AsyncValue.error('Not authenticated', StackTrace.empty);
    ref.refresh(currentUserProvider);
  }
}

final loginProvider = AsyncNotifierProvider<LoginNotifier, UserEntity>(
  LoginNotifier.new,
);

// Simple login form state
final loginFormStateProvider = StateProvider.family<bool, String>((ref, field) {
  return false; // Track if field has error
});
```

### 4. Presentation Layer (UI Widgets)

#### Login Page (login_page.dart)
```dart
class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: loginState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(loginProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (_) => const LoginForm(),
      ),
    );
  }
}
```

#### Login Form Widget (login_form.dart)
```dart
class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Email',
              label: Text('Email'),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
              label: Text('Password'),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: loginState.isLoading
                ? null
                : () async {
                    await ref.read(loginProvider.notifier).login(
                          _emailController.text,
                          _passwordController.text,
                        );
                  },
            child: loginState.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Login'),
          ),
        ],
      ),
    );
  }
}
```

## Testing Structure

### Unit Test (login_usecase_test.dart)
```dart
void main() {
  group('LoginUseCase', () {
    late MockAuthRepository mockRepository;
    late LoginUseCase loginUseCase;

    setUp(() {
      mockRepository = MockAuthRepository();
      loginUseCase = LoginUseCase(repository: mockRepository);
    });

    test('should return user when login succeeds', () async {
      // Arrange
      const testUser = UserEntity(
        id: '1',
        email: 'test@example.com',
        name: 'Test User',
        createdAt: '2025-01-01',
      );

      when(mockRepository.login('test@example.com', 'password'))
          .thenAnswer((_) async => testUser);

      // Act
      final result = await loginUseCase('test@example.com', 'password');

      // Assert
      expect(result.isOk, true);
      expect(result.ok, testUser);
      verify(mockRepository.login('test@example.com', 'password')).called(1);
    });

    test('should return error when credentials are empty', () async {
      // Act
      final result = await loginUseCase('', '');

      // Assert
      expect(result.isError, true);
      verifyNever(mockRepository.login(any, any));
    });
  });
}
```

### Widget Test (login_form_test.dart)
```dart
void main() {
  group('LoginForm', () {
    testWidgets('should show loading indicator when submitting', (tester) async {
      await tester.pumpWidget(
        ProviderContainer(
          child: MaterialApp(
            home: Scaffold(
              body: LoginForm(),
            ),
          ),
        ),
      );

      // Enter credentials
      await tester.enterText(find.byType(TextField).first, 'test@example.com');
      await tester.enterText(find.byType(TextField).last, 'password');

      // Submit
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpWidget(const SizedBox());

      // Verify loading
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
```

## Key Points

1. **Separation of Concerns**: Each layer has distinct responsibilities
2. **Dependency Rule**: Dependencies point inward (UI → Domain ← Data)
3. **Testability**: Each layer is independently testable with mocks
4. **Riverpod Providers**: Manage state and side effects cleanly
5. **Error Handling**: Proper Result types for operations
6. **Type Safety**: Freezed for immutable data models
7. **Async Handling**: AsyncNotifier for complex operations
8. **Security**: Sensitive data in secure storage, no exposure in code
