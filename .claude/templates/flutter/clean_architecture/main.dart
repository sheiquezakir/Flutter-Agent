import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'config/theme/app_theme.dart';
import 'config/routes/app_router.dart';
import 'config/service_locator.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Setup service locator (dependency injection)
  await configureDependencies();

  // Initialize Sentry for crash reporting
  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_SENTRY_DSN';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions
      options.tracesSampleRate = 1.0;
      // Set `trackHttpClient` to true if the SDK should be registered as an http client decorator
      options.trackHttpClient = true;
    },
    appRunner: () => runApp(
      const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Flutter Clean App',
      // Material Design 3 with dynamic theming
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Localization
      localizationsDelegates: const [
        // Add your localization delegates here
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        // Add more locales as needed
      ],

      // Router configuration
      routerConfig: appRouter,

      // Disable debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}
