# Ternak In

A Flutter livestock management application built with GetX, Dio, and Clean Architecture.

## Features

- 📊 **Dashboard**: Overview of livestock with filtering capabilities
- 📈 **Analytics**: Performance metrics and insights
- 💬 **Support Chat**: Real-time chat with support team
- 👤 **Profile**: User account management

## Architecture

The app follows **Clean Architecture** principles with a **feature-first** structure:

```
lib/
├── core/               # Core utilities and configurations
│   ├── constants/      # App constants
│   ├── themes/         # App themes
│   ├── errors/         # Error handling
│   ├── network/        # Network layer (Dio)
│   └── utils/          # Utility classes
├── data/              # Data layer
│   ├── models/        # Data models
│   ├── services/      # API services
│   └── repositories/  # Repositories
├── features/          # Feature modules
│   ├── dashboard/
│   ├── analytics/
│   ├── chat/
│   └── profile/
└── routes/            # App routing
```

## Tech Stack

- **State Management**: GetX
- **HTTP Client**: Dio with interceptors
- **Local Storage**: SharedPreferences
- **UI Components**: Material Design 3
- **Fonts**: Google Fonts

## Requirements

- Flutter SDK: >=3.0.0
- Android: API 21+ (Android 5.0+)
- iOS: 12.0+

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/thesantoso/ternak-in.git
cd ternak-in
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Key Features

### Clean Architecture
- Separation of concerns with layers
- SOLID principles
- Dependency injection with GetX

### Reactive UI
- Obx widgets for reactive state management
- Real-time UI updates
- Efficient rebuilds

### Error Handling
- Centralized error handling
- User-friendly error messages
- Dio interceptors for network errors

### Modern UI
- Material Design 3
- Card-based layouts
- Bottom navigation with center FAB
- Custom theme system

## License

MIT License