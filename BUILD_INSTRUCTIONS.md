# Ternak In Flutter App - Build and Test Instructions

## Prerequisites

1. Install Flutter SDK (>=3.0.0)
   - Download from: https://flutter.dev/docs/get-started/install
   - Add Flutter to your PATH
   - Run `flutter doctor` to verify installation

2. Install Dart SDK (comes with Flutter)

3. Install Android Studio (for Android development)
   - Install Android SDK (API 21+)
   - Setup Android Emulator or connect physical device

4. Install Xcode (for iOS development on macOS)
   - iOS 12.0+ required

## Setup Instructions

### 1. Get Dependencies

```bash
cd /path/to/ternak-in
flutter pub get
```

This will download all required packages:
- GetX (state management)
- Dio (HTTP client)
- SharedPreferences (local storage)
- Google Fonts
- intl (internationalization)

### 2. Generate Launcher Icons (Optional)

```bash
# Add flutter_launcher_icons to dev_dependencies in pubspec.yaml
# Then run:
flutter pub run flutter_launcher_icons:main
```

### 3. Run the App

#### On Android
```bash
flutter run
```

#### On iOS (macOS only)
```bash
cd ios
pod install
cd ..
flutter run
```

#### Specific device
```bash
flutter devices                    # List available devices
flutter run -d <device-id>        # Run on specific device
```

### 4. Build Release Version

#### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

#### Android App Bundle
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

#### iOS
```bash
flutter build ios --release
# Then open ios/Runner.xcworkspace in Xcode to archive
```

## Testing

### Run Analyzer
```bash
flutter analyze
```

### Run Tests (if test files exist)
```bash
flutter test
```

### Hot Reload (during development)
- Press `r` in terminal for hot reload
- Press `R` in terminal for hot restart
- Press `q` to quit

## Project Structure Verification

Verify the following structure exists:

```
ternak-in/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   └── app_constants.dart
│   │   ├── themes/
│   │   │   └── app_theme.dart
│   │   ├── errors/
│   │   │   ├── exceptions.dart
│   │   │   └── error_handler.dart
│   │   ├── network/
│   │   │   └── dio_client.dart
│   │   └── utils/
│   │       └── storage_service.dart
│   ├── data/
│   │   ├── models/
│   │   │   ├── analytics_model.dart
│   │   │   ├── chat_message_model.dart
│   │   │   ├── livestock_model.dart
│   │   │   └── user_model.dart
│   │   └── services/
│   │       └── api_service.dart
│   ├── features/
│   │   ├── dashboard/
│   │   │   ├── bindings/
│   │   │   ├── controllers/
│   │   │   └── views/
│   │   ├── analytics/
│   │   │   ├── bindings/
│   │   │   ├── controllers/
│   │   │   └── views/
│   │   ├── chat/
│   │   │   ├── bindings/
│   │   │   ├── controllers/
│   │   │   └── views/
│   │   └── profile/
│   │       ├── bindings/
│   │       ├── controllers/
│   │       └── views/
│   ├── routes/
│   │   ├── app_pages.dart
│   │   ├── main_navigation_controller.dart
│   │   └── main_navigation_view.dart
│   └── main.dart
├── android/
├── ios/
├── pubspec.yaml
└── analysis_options.yaml
```

## Features to Test

### 1. Dashboard
- Launch app (should show Dashboard by default)
- Verify livestock cards display with mock data
- Test filter chips (All, Cattle, Goat, Chicken, Sheep)
- Test refresh by pulling down
- Verify summary cards show correct totals
- Tap on livestock card to see details snackbar

### 2. Analytics
- Navigate to Analytics tab
- Verify metrics cards display
- Test period selector (Daily, Weekly, Monthly, Yearly)
- Check trend indicators (up/down arrows)
- Verify insights section displays
- Test refresh functionality

### 3. Chat
- Navigate to Chat tab
- Verify existing messages load
- Type a message and send
- Verify message appears in chat
- Verify auto-reply appears after delay
- Check message timestamps
- Verify scroll behavior

### 4. Profile
- Navigate to Profile tab
- Verify user information displays
- Test Edit Profile button
- Test Change Password button
- Toggle Notifications switch
- Test Help & Support button
- Test About button
- Test Logout button and confirmation dialog

### 5. Navigation
- Test bottom navigation bar
- Verify active tab highlighting
- Test center FAB (Floating Action Button)
- Verify smooth transitions between tabs

### 6. Error Handling
- Verify network error messages (simulate by modifying API service)
- Test loading states
- Verify snackbar messages display correctly

## Known Issues / Notes

1. **Launcher Icons**: Placeholder icons are used. Generate proper icons using flutter_launcher_icons package.

2. **Mock Data**: The app uses mock data from ApiService. Replace with real API endpoints by updating the baseUrl in AppConstants and implementing actual API calls in ApiService.

3. **Images**: The assets/images/ directory is empty. Add images as needed for your app.

4. **Authentication**: Currently no authentication flow. Add login/signup screens if needed.

5. **Database**: Uses SharedPreferences for simple storage. Consider using Hive, SQLite, or other databases for complex data.

## Performance Optimization

- GetX controllers use lazy initialization
- Obx widgets for granular rebuilds
- ListView.builder for efficient scrolling
- RefreshIndicator for pull-to-refresh

## Troubleshooting

### Issue: "Failed to resolve: com.android.support"
**Solution**: Ensure `android.useAndroidX=true` is in gradle.properties

### Issue: "CocoaPods not installed"
**Solution**: Run `sudo gem install cocoapods` on macOS

### Issue: "MissingPluginException"
**Solution**: Run `flutter clean && flutter pub get` then restart

### Issue: Dependency conflicts
**Solution**: 
```bash
flutter pub upgrade
flutter clean
flutter pub get
```

## Additional Resources

- Flutter Documentation: https://flutter.dev/docs
- GetX Documentation: https://pub.dev/packages/get
- Dio Documentation: https://pub.dev/packages/dio
- Material Design 3: https://m3.material.io/

## Support

For issues or questions, create an issue in the GitHub repository.
