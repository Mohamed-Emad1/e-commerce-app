# Kshk - E-Commerce Mobile Application

A modern, feature-rich e-commerce mobile application built with Flutter, implementing clean architecture principles and state management with BLoC pattern.

## 📱 Overview

Kshk is a comprehensive e-commerce platform that provides users with a seamless shopping experience. The application features product browsing, cart management, multiple payment integrations, user authentication, and multi-language support.

## ✨ Key Features

### 🛍️ Shopping Experience
- **Product Catalog**: Browse and search through a curated collection of products
- **Detailed Product Views**: View comprehensive product information including images, descriptions, sizes, and colors
- **Shopping Cart**: Add, remove, and manage items with real-time cart updates
- **Favorites**: Save and manage favorite products for quick access

### 🔐 Authentication & User Management
- **Email/Password Authentication**: Secure user registration and login
- **Social Authentication**: Sign in with Google and Facebook
- **Firebase Integration**: Robust backend authentication with Firebase Auth
- **User Profile Management**: Edit profile information and upload profile images

### 💳 Payment Integration
- **Multiple Payment Methods**:
  - Stripe Payment Gateway
  - PayPal Integration
  - Paymob (Local Payment Provider)
  - Cash on Delivery
- **Secure Checkout**: Multi-step checkout process with address and payment validation
- **Order Management**: Place and track orders with Firebase Firestore

### 🌐 Localization & Theming
- **Multi-Language Support**: English and Arabic localization
- **Dark Mode**: Toggle between light and dark themes
- **Responsive UI**: Adaptive layouts for different screen sizes

### 📦 Additional Features
- **Onboarding Flow**: Intuitive first-time user experience
- **Address Management**: Save and manage multiple delivery addresses with Hive local storage
- **Image Caching**: Optimized image loading with cached network images
- **Skeleton Loading**: Enhanced UX with skeleton screens during data fetching

## 🏗️ Architecture

The application follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                          # Core utilities and shared resources
│   ├── Services/                  # Service layer implementations
│   │   ├── firebase_auth_service.dart
│   │   ├── fire_store_service.dart
│   │   ├── payment_service.dart
│   │   ├── paymob_service/
│   │   └── srtipe_servcie/
│   ├── cubits/                    # Global state management
│   │   ├── darkmode/
│   │   └── language_cubit/
│   ├── utils/                     # Utilities and helpers
│   │   ├── app_router.dart
│   │   ├── constants.dart
│   │   ├── themes/
│   │   ├── models/
│   │   └── helper_functions/
│   └── widgets/                   # Reusable widgets
│
├── features/                      # Feature modules
│   ├── auth/                      # Authentication feature
│   │   ├── data/                  # Data layer (models, data sources)
│   │   ├── domain/                # Domain layer (entities, repositories)
│   │   └── presentation/          # Presentation layer (UI, cubits)
│   │
│   ├── home/                      # Home & Product browsing
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── cart/                      # Shopping cart & checkout
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── profile/                   # User profile management
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── onboarding/                # Onboarding screens
│       └── presentation/
│
├── generated/                     # Generated localization files
├── l10n/                          # Localization resources
└── main.dart                      # Application entry point
```

### Architecture Layers

1. **Presentation Layer**: UI components, BLoC/Cubit state management
2. **Domain Layer**: Business logic, entities, repository interfaces
3. **Data Layer**: Repository implementations, data sources, models

## 🛠️ Tech Stack

### Core Framework
- **Flutter SDK**: ^3.9.0
- **Dart**: Latest stable version

### State Management
- **flutter_bloc**: ^9.1.1 - BLoC pattern implementation
- **provider**: ^6.1.5+1 - Additional state management

### Backend & Database
- **Firebase Core**: ^4.1.1
- **Firebase Auth**: ^6.1.0 - User authentication
- **Cloud Firestore**: ^6.0.2 - NoSQL database
- **Hive**: ^2.2.3 - Local storage
- **Hive Flutter**: ^1.1.0

### Payment Integrations
- **flutter_stripe**: ^12.0.2 - Stripe payment gateway
- **flutter_paypal_payment**: ^1.0.8 - PayPal integration
- **Custom Paymob Integration** - Local payment provider

### Social Authentication
- **google_sign_in**: ^6.2.2
- **flutter_facebook_auth**: ^7.1.2

### Navigation & Routing
- **go_router**: ^16.2.4 - Declarative routing

### UI & UX
- **cached_network_image**: ^3.4.1 - Image caching
- **flutter_svg**: ^2.2.1 - SVG support
- **skeletonizer**: ^2.1.0+1 - Skeleton loading screens
- **modal_progress_hud_nsn**: ^0.5.1 - Loading indicators

### Localization
- **flutter_localizations**: SDK - Internationalization support
- **intl**: Latest - Date/number formatting

### Utilities
- **get_it**: ^8.2.0 - Dependency injection
- **dio**: ^5.9.0 - HTTP client
- **shared_preferences**: ^2.5.3 - Key-value storage
- **image_picker**: ^1.2.0 - Image selection
- **url_launcher**: ^6.3.2 - URL handling
- **uuid**: ^4.5.1 - Unique ID generation
- **crypto**: ^3.0.6 - Cryptographic functions
- **dartz**: ^0.10.1 - Functional programming

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.9.0)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Firebase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd kshk
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android and iOS apps to your Firebase project
   - Download and place configuration files:
     - `google-services.json` in `android/app/`
     - `GoogleService-Info.plist` in `ios/Runner/`
   - Run Firebase CLI configuration:
     ```bash
     flutterfire configure
     ```

4. **Configure API Keys**
   - Update `lib/core/api_keys.dart` with your API keys:
     - Stripe Publishable Key
     - PayPal credentials
     - Paymob API keys

5. **Generate Localization Files**
   ```bash
   flutter gen-l10n
   ```

6. **Generate Hive Adapters**
   ```bash
   flutter packages pub run build_runner build
   ```

7. **Run the application**
   ```bash
   flutter run
   ```

## 🔧 Configuration

### Payment Gateway Setup

#### Stripe
1. Create a Stripe account at [stripe.com](https://stripe.com)
2. Get your publishable key from the dashboard
3. Update `ApiKeys.stripePublishableKey` in `lib/core/api_keys.dart`

#### PayPal
1. Create a PayPal developer account
2. Create a REST API app
3. Configure credentials in the payment service

#### Paymob
1. Register at [Paymob](https://paymob.com)
2. Get API keys and integration IDs
3. Update configuration in `lib/core/Services/paymob_service/`

### Firebase Setup

1. **Authentication**: Enable Email/Password, Google, and Facebook sign-in methods
2. **Firestore**: Set up collections for users, products, and orders
3. **Security Rules**: Configure appropriate Firestore security rules

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 🌍 Localization

The app supports multiple languages:
- English (en)
- Arabic (ar)

Localization files are located in `lib/l10n/`:
- `intl_en.arb` - English translations
- `intl_ar.arb` - Arabic translations

To add a new language:
1. Create a new `.arb` file in `lib/l10n/`
2. Add translations
3. Run `flutter gen-l10n`

## 🎨 Theming

The application supports both light and dark themes:
- Theme files: `lib/core/utils/themes/`
- Toggle theme: Settings screen or profile section
- Persistent theme preference using SharedPreferences

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📦 Build

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is private and not published to pub.dev.

## 👥 Contact & Support

For questions or support, please contact the me.

## 🔐 Security

- Never commit API keys or sensitive credentials
- Use environment variables for production builds
- Follow Firebase security best practices
- Implement proper authentication checks

## 📝 Version

Current Version: **1.0.0+1**

---

**Built with ❤️ using Flutter**
