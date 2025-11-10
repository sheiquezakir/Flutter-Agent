/// Secure Storage Setup Template
///
/// This template demonstrates how to properly store sensitive data
/// following OWASP Mobile Security Guidelines

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

/// Service for managing secure storage of sensitive data
///
/// Storage locations:
/// - iOS: Keychain Services (encrypted by default)
/// - Android: EncryptedSharedPreferences (using Android Keystore)
class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();

  factory SecureStorageService() => _instance;

  SecureStorageService._internal();

  final _storage = const FlutterSecureStorage(
    aOptions: _androidOptions,
    iOptions: _iosOptions,
  );

  // Android: Use EncryptedSharedPreferences
  static const _androidOptions = AndroidOptions(
    resetOnError: true,
    keyCipherAlgorithm: KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
    storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
  );

  // iOS: Use Keychain Services
  static const _iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_available_when_unlocked_this_device_only,
  );

  /// Save sensitive string (e.g., auth token)
  ///
  /// Example:
  /// ```dart
  /// await secureStorage.saveAuthToken('eyJhbGc...');
  /// ```
  Future<void> saveAuthToken(String token) async {
    try {
      await _storage.write(
        key: 'auth_token',
        value: token,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
    } catch (e) {
      throw SecureStorageException('Failed to save auth token: $e');
    }
  }

  /// Retrieve auth token
  ///
  /// Returns null if token doesn't exist
  Future<String?> getAuthToken() async {
    try {
      return await _storage.read(
        key: 'auth_token',
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
    } catch (e) {
      throw SecureStorageException('Failed to read auth token: $e');
    }
  }

  /// Save sensitive data (generic)
  ///
  /// Example:
  /// ```dart
  /// await secureStorage.save('api_key', apiKeyValue);
  /// ```
  Future<void> save(String key, String value) async {
    if (key.isEmpty || value.isEmpty) {
      throw SecureStorageException('Key and value cannot be empty');
    }

    try {
      // Validate that we're not saving sensitive data types
      _validateKey(key);

      await _storage.write(
        key: key,
        value: value,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
    } catch (e) {
      throw SecureStorageException('Failed to save secure data: $e');
    }
  }

  /// Retrieve sensitive data
  Future<String?> read(String key) async {
    try {
      return await _storage.read(
        key: key,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
    } catch (e) {
      throw SecureStorageException('Failed to read secure data: $e');
    }
  }

  /// Delete sensitive data
  Future<void> delete(String key) async {
    try {
      await _storage.delete(
        key: key,
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
    } catch (e) {
      throw SecureStorageException('Failed to delete secure data: $e');
    }
  }

  /// Clear all secure storage (use on logout)
  ///
  /// Example:
  /// ```dart
  /// await secureStorage.clearAll();
  /// ```
  Future<void> clearAll() async {
    try {
      await _storage.deleteAll(
        aOptions: _androidOptions,
        iOptions: _iosOptions,
      );
    } catch (e) {
      throw SecureStorageException('Failed to clear secure storage: $e');
    }
  }

  /// Validate that we're not storing passwords directly
  ///
  /// Note: Passwords should NEVER be stored. Instead:
  /// 1. Store auth tokens (with refresh mechanism)
  /// 2. Use Firebase Auth or OAuth
  /// 3. Never store passwords locally
  void _validateKey(String key) {
    final lowerKey = key.toLowerCase();

    if (lowerKey.contains('password')) {
      throw SecureStorageException(
        'WARNING: Do not store passwords! Use auth tokens or OAuth instead.',
      );
    }

    if (key.isEmpty || key.length > 100) {
      throw SecureStorageException('Key must be between 1 and 100 characters');
    }
  }
}

/// Exception for secure storage errors
class SecureStorageException implements Exception {
  final String message;

  SecureStorageException(this.message);

  @override
  String toString() => 'SecureStorageException: $message';
}

/// Setup secure storage in dependency injection
///
/// Call this in your service_locator.dart:
/// ```dart
/// getIt.registerSingleton<SecureStorageService>(SecureStorageService());
/// ```

/// Example usage in a repository
class AuthRepositorySecureExample {
  final SecureStorageService _secureStorage;

  AuthRepositorySecureExample({required SecureStorageService secureStorage})
      : _secureStorage = secureStorage;

  /// Save auth response (following OAuth 2.0 best practices)
  Future<void> saveAuthResponse({
    required String accessToken,
    required String? refreshToken,
    required DateTime expiresAt,
  }) async {
    try {
      // Save tokens
      await _secureStorage.save('access_token', accessToken);

      if (refreshToken != null) {
        await _secureStorage.save('refresh_token', refreshToken);
      }

      // Save expiry time (not sensitive, can use regular storage)
      // await localStorage.save('token_expires_at', expiresAt.toIso8601String());

      print('✅ Auth tokens saved securely');
    } catch (e) {
      print('❌ Failed to save auth response: $e');
      rethrow;
    }
  }

  /// Retrieve auth token
  Future<String?> getAccessToken() async {
    try {
      return await _secureStorage.read('access_token');
    } catch (e) {
      print('❌ Failed to retrieve access token: $e');
      return null;
    }
  }

  /// Logout - clear all sensitive data
  Future<void> logout() async {
    try {
      await _secureStorage.delete('access_token');
      await _secureStorage.delete('refresh_token');
      print('✅ Auth tokens cleared on logout');
    } catch (e) {
      print('❌ Failed to clear auth tokens: $e');
      rethrow;
    }
  }
}

/// SECURITY BEST PRACTICES CHECKLIST
///
/// ✅ DO:
/// - Use FlutterSecureStorage for all sensitive data
/// - Store auth tokens (not passwords)
/// - Implement token refresh mechanism
/// - Clear storage on logout
/// - Use appropriate access restrictions (iOS Keychain options)
/// - Handle exceptions gracefully (no sensitive data in error messages)
/// - Encrypt data at rest
/// - Use HTTPS for all network calls
/// - Implement certificate pinning
///
/// ❌ DON'T:
/// - Store passwords locally
/// - Use SharedPreferences for sensitive data (plain text!)
/// - Hardcode credentials
/// - Log sensitive data
/// - Send sensitive data unencrypted over network
/// - Store API keys in code
/// - Use weak encryption algorithms
/// - Ignore errors silently
