# Tasks Management System

A comprehensive Tasks Management System application built with Flutter. This application allows users to efficiently manage their daily tasks, organize them, and keep track of their progress. It utilizes modern Flutter packages for state management, declarative routing, networking, and local storage.

## Dependencies

The project relies on the following key dependencies to function properly:

- **[Flutter BLoC](https://pub.dev/packages/flutter_bloc)** (`^9.1.1`): For robust and scalable state management.
- **[Go Router](https://pub.dev/packages/go_router)** (`^17.3.0`): For declarative navigation and routing.
- **[Dio](https://pub.dev/packages/dio)** (`^5.9.2`): A powerful HTTP client for Dart to handle network requests.
- **[Sqflite](https://pub.dev/packages/sqflite)** (`^2.4.2+1`): SQLite plugin for Flutter for local database storage.
- **[GetIt](https://pub.dev/packages/get_it)** (`^9.2.1`): A simple Service Locator for dependency injection.
- **[Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)** (`^10.3.1`): To store data securely in keychain/keystore.
- **[Easy Localization](https://pub.dev/packages/easy_localization)** (`^3.0.8`): For easy and fast internationalization.
- **[Flutter ScreenUtil](https://pub.dev/packages/flutter_screenutil)** (`^5.9.3`): For adapting screen sizes and making the UI responsive.
- **[Dartz](https://pub.dev/packages/dartz)** (`^0.10.1`): For functional programming constructs like `Either` for error handling.
- **[Google Fonts](https://pub.dev/packages/google_fonts)** (`^8.1.0`): To use fonts from Google Fonts easily.

*(Please refer to the `pubspec.yaml` file for the complete list of dependencies)*

## How to Run

Follow these steps to run the project locally on your machine:

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd TasksManagementSystem
   ```

2. **Install dependencies:**
   Ensure you have the Flutter SDK installed (`^3.10.0`), then run:
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   Connect a physical device or start an emulator/simulator, and execute:
   ```bash
   flutter run
   ```

## Additional Notes

- If you encounter any dependency issues, you can run `flutter clean` followed by `flutter pub get`.
- The project is configured with `flutter_lints` to encourage good coding practices.

---
*For more help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.*
