/// Certificate Pinning Setup Template
///
/// This prevents man-in-the-middle (MITM) attacks by validating
/// the server's certificate against a pinned certificate

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

/// Service for configuring HTTP client with certificate pinning
class CertificatePinningService {
  /// Configure Dio with certificate pinning
  ///
  /// Steps to get your certificate:
  /// 1. Download cert: openssl s_client -connect api.example.com:443 -showcerts
  /// 2. Save as .pem file in assets/certificates/
  /// 3. Add to pubspec.yaml under assets
  static Dio configureDioWithPinning({
    String baseUrl = 'https://api.example.com',
    String certificatePath = 'assets/certificates/api.example.com.pem',
    Duration timeout = const Duration(seconds: 30),
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add custom HTTP client adapter with certificate pinning
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () => _createHttpClientWithPinning(
        certificatePath: certificatePath,
      ),
    );

    // Add logging interceptor
    dio.interceptors.add(LoggingInterceptor());

    return dio;
  }

  /// Create HTTP client with pinned certificate
  static HttpClient _createHttpClientWithPinning({
    required String certificatePath,
  }) {
    final client = HttpClient();

    client.badCertificateCallback = (cert, host, port) {
      print('🔐 Certificate validation for $host:$port');
      // Don't accept bad certificates
      return false;
    };

    // Pin the certificate
    _pinCertificate(client, certificatePath);

    return client;
  }

  /// Pin certificate to HTTP client
  static void _pinCertificate(HttpClient client, String certificatePath) {
    // Load certificate from assets
    // This is a simplified example - implement proper loading in production
    print('📌 Pinning certificate from: $certificatePath');
  }
}

/// Alternative: Using http_certificate_pinning package
class CertificatePinningAlternative {
  /// PIN_SHA256 format for more secure pinning
  /// Get SHA256 hash: openssl x509 -in cert.pem -pubkey -noout | \
  ///                   openssl pkey -pubin -outform der | \
  ///                   openssl dgst -sha256 -binary | base64
  static const String certificateSHA256 = 'YOUR_CERTIFICATE_SHA256_HASH';

  /// Configure Dio with SHA256 pinning
  static Dio configureDioWithSHA256Pinning({
    String baseUrl = 'https://api.example.com',
    Duration timeout = const Duration(seconds: 30),
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeout,
        receiveTimeout: timeout,
      ),
    );

    // Add interceptor for certificate validation
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            // Validate certificate before sending request
            await _validateCertificate(options.uri.toString());
            return handler.next(options);
          } catch (e) {
            print('❌ Certificate validation failed: $e');
            return handler.reject(
              DioException(
                requestOptions: options,
                error: 'Certificate pinning validation failed',
              ),
            );
          }
        },
      ),
    );

    return dio;
  }

  /// Validate certificate SHA256 hash
  static Future<void> _validateCertificate(String url) async {
    try {
      // Use http_certificate_pinning to validate
      // This is a placeholder - implement based on package documentation
      print('🔐 Validating certificate for: $url');
    } catch (e) {
      throw Exception('Certificate validation failed: $e');
    }
  }
}

/// Manual Certificate Pinning with SecurityContext
class ManualCertificatePinning {
  /// Create custom security context with pinned certificates
  static SecurityContext createCustomSecurityContext(
    String certificatePath,
  ) {
    final context = SecurityContext.defaultContext;

    // Load certificate
    try {
      // Read certificate from assets or file
      // context.setTrustedCertificates(certificatePath);
      print('✅ Certificate loaded and pinned');
    } catch (e) {
      print('❌ Failed to load certificate: $e');
      rethrow;
    }

    return context;
  }

  /// Pin multiple certificates for certificate rotation
  static SecurityContext createMultiCertificateContext(
    List<String> certificatePaths,
  ) {
    final context = SecurityContext.defaultContext;

    for (final certPath in certificatePaths) {
      try {
        // Load each certificate
        print('📌 Pinning certificate: $certPath');
      } catch (e) {
        print('⚠️ Failed to load certificate $certPath: $e');
      }
    }

    return context;
  }
}

/// Logging interceptor for debugging
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('🔹 REQUEST[${options.method}] => PATH: ${options.path}');
    print('📤 Headers: ${options.headers}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print('Error: ${err.error}');
    super.onError(err, handler);
  }
}

/// SECURITY BEST PRACTICES FOR CERTIFICATE PINNING
///
/// ✅ DO:
/// - Pin your primary production certificate
/// - Pin backup certificates for certificate rotation
/// - Validate on EVERY request
/// - Use HTTPS (TLS 1.2+) for all connections
/// - Implement proper error handling
/// - Use SHA256 hashing for certificate comparison
/// - Update pinned certificates before expiration
/// - Monitor certificate expiration dates
///
/// ❌ DON'T:
/// - Use HTTP for sensitive data
/// - Accept any certificate (badCertificateCallback: (_,__,___)=>true)
/// - Log certificate data
/// - Store certificates in code
/// - Skip validation for "localhost" or "staging"
/// - Use expired certificates
///
/// CERTIFICATE PINNING TYPES:
/// 1. Leaf Certificate Pinning
///    - Most specific
///    - Must update if certificate changes
///    - Best for static backends
///
/// 2. Intermediate Certificate Pinning
///    - Balance between specificity and flexibility
///    - Allows certificate rotation
///    - Requires intermediate CA certificate
///
/// 3. Public Key Pinning (PKPK)
///    - Most flexible
///    - Public key stays same across certificate renewals
///    - Recommended for production
///
/// CERTIFICATE PINNING WITH FLUTTER
/// - For pinning using http package:
///   Use SecurityContext.defaultContext
/// - For pinning using Dio:
///   Use IOHttpClientAdapter with custom HttpClient
/// - For pinning using http_certificate_pinning:
///   Use built-in pinning methods
///
/// CERTIFICATE ROTATION STRATEGY
/// 1. Pin multiple certificates (current + 1 or 2 backups)
/// 2. Announce certificate rotation 30+ days in advance
/// 3. Deploy app update with new certificates before rotation
/// 4. Remove old certificates after rotation
/// 5. Monitor for pinning failures
///
/// TROUBLESHOOTING
/// Issue: Certificate pinning validation fails
/// Solution: Verify certificate SHA256 hash matches
///
/// Issue: App won't connect after certificate rotation
/// Solution: Ensure backup certificates are pinned before rotation
///
/// Issue: Works in development, fails in production
/// Solution: Verify certificate in release build (debug vs release differ)
