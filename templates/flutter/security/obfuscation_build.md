# Obfuscation & Secure Build Configuration

Security best practices for hardening your Flutter app builds.

## What is Obfuscation?

Obfuscation makes your app harder to reverse engineer by:
- Renaming classes, methods, and variables to meaningless names
- Removing debugging symbols
- Shrinking code size
- Making logic harder to follow

**Important:** Obfuscation is NOT encryption. It only makes reverse engineering harder, not impossible.

## Android Obfuscation

### 1. Using R8 (Built-in to Flutter)

#### Enable Obfuscation in Release Build

```bash
# Build with obfuscation
flutter build apk --release --obfuscate --split-debug-info=./symbols

# Or for app bundle (recommended for Play Store)
flutter build appbundle --release --obfuscate --split-debug-info=./symbols

# Or for Android release
flutter build android --release --obfuscate --split-debug-info=./symbols
```

**What this does:**
- `--obfuscate`: Renames classes, methods, variables
- `--split-debug-info`: Separates debug symbols (don't ship with app)

### 2. Configure ProGuard/R8 Rules

Create `android/app/proguard-rules.pro`:

```proguard
# Keep Flutter-related classes
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.view.** { *; }

# Keep your main Application class
-keep class com.example.app.MainActivity { *; }

# Keep native method names
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep custom exceptions
-keep class com.example.app.errors.** { *; }
-keep class com.example.app.exceptions.** { *; }

# Keep Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Keep serialization classes (Freezed, JSON)
-keep class **.model.** { *; }
-keep class **.entity.** { *; }
-keep class **.response.** { *; }
-keep @interface com.google.gson.annotations.SerializedName { *; }

# Remove logging in production (optional)
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
}

# Keep public API
-keep public class com.example.app.** {
    public <methods>;
}

# Optimization
-optimizationpasses 5
-dontusemixedcaseclassnames
-verbose
```

Update `android/app/build.gradle`:

```gradle
android {
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true           // Enable R8
            shrinkResources true         // Remove unused resources
            proguardFiles getDefaultProguardFile('proguard-android.txt'),
                          'proguard-rules.pro'
        }
        debug {
            minifyEnabled false
        }
    }
}
```

### 3. Verify Obfuscation

```bash
# Extract APK
unzip app-release.apk -d extracted_apk

# Check if strings are obfuscated
strings extracted_apk/classes.dex | grep -E "^(a|b|c|d)$"

# If you see single-letter names, obfuscation worked!
```

## iOS Obfuscation

iOS doesn't require additional obfuscation as App Store Connect automatically bitcode processing.

However, follow these best practices:

### 1. Strip Debug Symbols

Update `ios/Podfile`:

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
    end
  end
end
```

### 2. Enable Bitcode

In Xcode:
1. Select project
2. Build Settings
3. Search "Bitcode"
4. Set "Enable Bitcode" = YES

## Debug Symbols Management

### 1. Extract and Store Symbols

```bash
# When building with --split-debug-info
flutter build appbundle --release --obfuscate --split-debug-info=./symbols

# Symbols are in ./symbols/arm64-v8a/app.so.symbols
# Store these SECURELY for crash reporting deobfuscation
```

### 2. Use Symbols for Deobfuscation

When crash reporting shows obfuscated stack traces:

```bash
# Deobfuscate using stored symbols
# For Flutter crashes, use: flutter symbolize-android
flutter symbolize-android \
  --input=/path/to/crash_stacktrace.txt \
  --android-build-file=/path/to/app-release.apk \
  --android-symbols-file=./symbols/arm64-v8a/app.so.symbols
```

### 3. Firebase Crashlytics Integration

Setup in your Flutter app:

```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enable Crashlytics for non-debug builds
  if (!kDebugMode) {
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    // Pass all uncaught errors to Crashlytics
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  runApp(const MyApp());
}
```

## Application Signing

### Android Signing

#### Generate Key Store

```bash
keytool -genkey -v -keystore ~/app.jks -keyalg RSA -keysize 2048 -validity 10000 -alias app-key

# Follow prompts to set:
# - Password (store securely!)
# - Name
# - Organizational unit
# - Organization
# - City/Locality
# - State/Province
# - Country code
```

#### Configure Signing in `android/key.properties`

```properties
storeFile=../app.jks
storePassword=<keystore-password>
keyAlias=app-key
keyPassword=<key-password>
```

#### Update `android/app/build.gradle`

```gradle
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile file(keystoreProperties['storeFile'])
        storePassword keystoreProperties['storePassword']
    }
}

buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```

#### Build Signed Release APK

```bash
flutter build apk --release --obfuscate --split-debug-info=./symbols
```

### iOS Signing

Use Xcode or fastlane:

```bash
# Using fastlane
cd ios
fastlane produce -u your-apple-id@example.com

# Automatic signing
cd ../
flutter build ios --release
```

## Build Configuration for Production

### CI/CD Integration

Create `build_scripts/release_build.sh`:

```bash
#!/bin/bash

set -e

APP_NAME="MyApp"
VERSION="1.0.0"
BUILD_NUMBER="1"

echo "🔨 Building $APP_NAME v$VERSION (build $BUILD_NUMBER)..."

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Generate code (if using build_runner)
flutter pub run build_runner build --delete-conflicting-outputs

# Build APK
echo "📱 Building APK..."
flutter build apk \
  --release \
  --obfuscate \
  --split-debug-info=./build/symbols \
  --build-name=$VERSION \
  --build-number=$BUILD_NUMBER

# Build App Bundle for Play Store
echo "📦 Building App Bundle..."
flutter build appbundle \
  --release \
  --obfuscate \
  --split-debug-info=./build/symbols \
  --build-name=$VERSION \
  --build-number=$BUILD_NUMBER

echo "✅ Build complete!"
echo "📁 APK: build/app/outputs/flutter-apk/app-release.apk"
echo "📁 Bundle: build/app/outputs/bundle/release/app-release.aab"
echo "📁 Symbols: build/symbols/"
```

## Security Checklist Before Release

- [ ] Enable obfuscation in release build
- [ ] Extract and store debug symbols securely
- [ ] Sign APK with release keystore
- [ ] Remove all debug logging
- [ ] Remove hardcoded credentials
- [ ] Verify certificate pinning is active
- [ ] Test app on real device
- [ ] Run security scan (lint)
- [ ] Enable code shrinking (minifyEnabled)
- [ ] Enable resource shrinking (shrinkResources)
- [ ] Configure ProGuard/R8 rules
- [ ] Test crash reporting with obfuscated traces
- [ ] Verify no sensitive data in logs
- [ ] Check app size (target <50MB)
- [ ] Test offline functionality
- [ ] Verify secure storage works
- [ ] Test SSL pinning

## Build Size Optimization

### Check APK Size

```bash
# Analyze APK
analyze_apk() {
  local apk_path=$1
  unzip -l "$apk_path" | grep -E "\.so|\.dex" | sort -k4 -rn | head -20
}

analyze_apk build/app/outputs/flutter-apk/app-release.apk
```

### Reduce Size

1. **Remove unused assets**
   ```bash
   flutter build apk --release --split-per-abi
   ```

2. **Enable ProGuard shrinking**
   ```gradle
   minifyEnabled true
   shrinkResources true
   ```

3. **Use WebP for images**
   - Tools: ImageMagick, ffmpeg
   - Saves 25-35% vs PNG

4. **Split APK by ABI**
   ```bash
   flutter build apk --release --split-per-abi
   # Creates separate APKs for arm64, armv7, x86
   ```

## Monitoring Release Builds

### Firebase Crashlytics Dashboard

1. Setup Crashlytics (see above)
2. Monitor crashes at: https://console.firebase.google.com
3. Use stored symbols for deobfuscation
4. Track crash-free user percentage
5. Alert on new crash patterns

## Best Practices Summary

✅ **Always:**
- Obfuscate release builds
- Separate and secure debug symbols
- Sign all builds
- Remove debug logging
- Use environment variables for config
- Monitor crashes and errors

❌ **Never:**
- Hardcode credentials
- Log sensitive data
- Ship debug APK to production
- Disable minification
- Forget to extract symbols
- Use weak signing keys

