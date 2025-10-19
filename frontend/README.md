# Transportation System - Flutter Frontend

A Flutter mobile application for tracking shipments to warehouses and stores.

## Features

- Track shipments in real-time
- View shipment details and history
- Manage warehouses and stores
- Search shipments by tracking number
- View shipment status updates

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Install dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

### Configuration

Update the API endpoint in `lib/config/api_config.dart` to point to your backend server.

## Project Structure

```
lib/
  ├── main.dart                 # Application entry point
  ├── config/                   # Configuration files
  ├── models/                   # Data models
  ├── services/                 # API services
  ├── providers/                # State management
  ├── screens/                  # UI screens
  ├── widgets/                  # Reusable widgets
  └── utils/                    # Utility functions
```

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```
