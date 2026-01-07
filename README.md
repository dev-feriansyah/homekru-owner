# HomeKru Owner

A Flutter application for household management, allowing owners to manage helpers, assign tasks, track attendance, and monitor household operations.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.7.0)
- Dart SDK
- Android Studio / VS Code
- iOS development setup (for iOS builds)

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd homekru_owner
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   # For development
   flutter run

   # For specific platform
   flutter run -d android
   flutter run -d ios
   flutter run -d chrome  # for web
   ```

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📦 Key Dependencies

### Core Dependencies

- **flutter**: ^3.7.0 - Flutter SDK
- **provider**: ^6.1.5 - State management solution
- **go_router**: ^16.2.0 - Declarative routing
- **shared_preferences**: ^2.5.3 - Local data persistence
- **http**: ^1.4.0 - HTTP client for API calls

### UI & Design

- **flutter_screenutil**: ^5.9.3 - Responsive screen adaptation
- **google_fonts**: ^6.3.1 - Custom font integration
- **flutter_svg**: ^2.2.0 - SVG image support
- **cached_network_image**: ^3.4.1 - Optimized network images
- **smooth_page_indicator**: ^1.2.1 - Page indicators for onboarding

### Navigation & Drawer

- **awesome_drawer_bar**: ^1.2.1 - Enhanced drawer functionality
- **flutter_zoom_drawer**: ^3.2.0 - Zoom-style navigation drawer

### Forms & Input

- **flutter_otp_text_field**: ^1.1.1 - OTP input fields
- **dropdown_search**: ^6.0.2 - Searchable dropdown widgets
- **image_picker**: ^1.2.0 - Camera and gallery image selection

### Charts & Analytics

- **syncfusion_flutter_charts**: ^31.1.19 - Professional charts and graphs
- **dotted_border**: ^3.1.0 - Decorative borders

### Icons & UI Elements

- **ionicons**: ^0.2.1 - Ionic icon set
- **eva_icons_flutter**: ^3.0.0 - Eva icon collection

### Utilities

- **intl**: ^0.20.2 - Internationalization and date formatting

## 🏗️ Architecture Overview

This project follows a feature-first architecture with clean separation of concerns:

```
lib/
├── core/          → App-wide configurations and utilities
├── shared/        → Reusable components across features
└── features/      → Feature modules (auth, tasks, attendance, etc.)
```

For detailed architecture documentation, see [ARCHITECTURE.md.](./docs/ARCHITECTURE.md)

## 📡 API Documentation

The app uses a **global API layer** built with Dio, clean architecture, and Riverpod for state management.

### 📚 Documentation

- **[API Developer Guide](./docs/api/API_DEVELOPER_GUIDE.md)** - Complete guide for developers (start here!)
- **[API Quick Reference](./docs/api/API_QUICK_REFERENCE.md)** - Quick copy-paste examples and templates

### 🚀 Quick Start with API

```dart
// 1. Create a model (Freezed)
@freezed
sealed class MyModel with _$MyModel {
  const factory MyModel({required String id, required String name}) = _MyModel;
  factory MyModel.fromJson(Map<String, dynamic> json) => _$MyModelFromJson(json);
}

// 2. Create a service (API calls)
class MyService {
  Future<MyModel> getData() => _apiClient.get<MyModel>('/endpoint', ...);
}

// 3. Create a repository (business logic)
class MyRepository {
  Future<MyModel> fetchData() => _service.getData();
}

// 4. Use in UI with Riverpod
final data = ref.watch(myProvider);
```

**Need help?** Check the [API Developer Guide](./docs/api/API_DEVELOPER_GUIDE.md) for detailed tutorials.

### 🎯 Key Features

- ✅ **Smart Authentication** - Auto-attach tokens to authenticated requests
- ✅ **Type-Safe Models** - Using Freezed 3.x with sealed classes
- ✅ **Error Handling** - Custom exceptions for different error scenarios
- ✅ **Clean Architecture** - Clear separation: UI → Provider → Repository → Service → ApiClient
- ✅ **Environment Config** - Separate dev/prod configurations
- ✅ **Encrypted Storage** - Secure token storage with FlutterSecureStorage

**Generate code:** `dart run build_runner build --delete-conflicting-outputs`

## 🌍 Localization Migration

### Status

We are gradually migrating from `AppStrings` constants to proper localization using `context.l10n`.

**Current state:**

- ✅ Localization infrastructure set up (Phase 1 complete)
- ⏳ AppStrings usage being replaced opportunistically
- 📋 ~19 files still use AppStrings

### When Working on Features

**If you encounter `AppStrings.xxx` usage:**

1. Replace it with `context.l10n.xxx`
2. Ensure BuildContext is available
3. Add import: `import 'package:homekru_owner/core/l10n/l10n_helper.dart';`
4. Remove old import: `import 'package:homekru_owner/core/constants/app_strings.dart';`
5. Test in both English and Indonesian

### Migration Patterns

#### ✅ Simple Replacement (Most Common)

```dart
// Before:
Text(AppStrings.helperOverview)

// After:
Text(context.l10n.helperOverview)
```

#### ⚠️ Form Validators (Special Case)

If you encounter validators using AppStrings:

```dart
// Before:
validator: (value) {
  if (value?.isEmpty ?? true) {
    return AppStrings.pleaseEnterEmail;  // ❌ No BuildContext
  }
  return null;
}

// After - Capture context before validator:
Widget build(BuildContext context) {
  final l10n = context.l10n;

  return TextFormField(
    validator: (value) {
      if (value?.isEmpty ?? true) {
        return l10n.pleaseEnterEmail;  // ✅ Uses captured context
      }
      return null;
    },
  );
}
```

#### ℹ️ Const Parameters (Rare Case)

If you see const default parameters with AppStrings:

```dart
// Before:
const MyWidget({
  this.title = AppStrings.defaultTitle,  // ❌ Compile-time constant required
})

// After - Make nullable, set default in build():
const MyWidget({
  this.title,  // ✅ Nullable
})

@override
Widget build(BuildContext context) {
  final displayTitle = title ?? context.l10n.defaultTitle;
  // use displayTitle
}
```

### Guidelines

**Don't:**

- ❌ Remove `AppStrings` class yet (other files still use it)
- ❌ Mass-replace without testing
- ❌ Forget to test in both languages

**Do:**

- ✅ Migrate files as you work on them
- ✅ Test language switching
- ✅ Ask questions if you hit edge cases
- ✅ Update this README when AppStrings is fully removed

## ✨ Main Features

### 🏠 Household Management

- **Create Household**: Set up and configure household settings
- **Co-owner Management**: Add and manage multiple household owners
- **Home Setup**: Initial configuration and room management
- **Subscription Management**: Handle premium features and billing

### 👥 Helper & Member Management

- **Add Helpers**: Onboard domestic helpers with detailed profiles
- **Helper Profiles**: Manage helper information, photos, and documents
- **Live-in vs Non-live-in**: Different management modes for helper types
- **Member Overview**: Comprehensive view of all household members
- **Day-off Eligibility**: Track and manage helper time-off requests

### 📋 Task Management System

- **Task Creation**: Create detailed household tasks with descriptions
- **Task Assignment**: Assign tasks to specific helpers or members
- **Task Tracking**: Monitor task progress and completion status
- **Task Categories**: Organize tasks by type (cleaning, cooking, maintenance, etc.)
- **Recurring Tasks**: Set up daily, weekly, or monthly recurring tasks
- **Task Analytics**: Visual charts showing task distribution and completion rates

### ⏰ Attendance & Time Tracking

- **Daily Attendance**: Track helper check-in/check-out times
- **Attendance History**: View historical attendance records
- **Overtime Tracking**: Monitor and calculate overtime hours
- **Attendance Analytics**: Generate attendance reports and statistics
- **Time-based Deductions**: Automatic salary adjustments based on attendance

### 📊 Analytics & Reporting

- **Dashboard Analytics**: Real-time household statistics and insights
- **Task Distribution Charts**: Visual representation of task allocation
- **Performance Metrics**: Helper performance tracking and evaluation
- **Attendance Reports**: Detailed attendance and punctuality reports
- **Financial Reports**: Salary, deductions, and overtime calculations

### 💰 Financial Management

- **Salary Management**: Track helper salaries and payment schedules
- **Deduction Tracking**: Manage salary deductions for various reasons
- **Overtime Calculations**: Automatic overtime pay calculations
- **Payment History**: Maintain records of all financial transactions

### 🔔 Communication & Notifications

- **Push Notifications**: Real-time alerts for important events
- **Task Reminders**: Automated reminders for pending tasks
- **Attendance Alerts**: Notifications for late arrivals or absences
- **System Updates**: App updates and feature announcements

### ⚙️ Settings & Customization

- **Profile Management**: User profile editing and photo updates
- **Theme Customization**: Light/dark mode and color preferences
- **Notification Settings**: Customize notification preferences
- **Privacy Controls**: Manage data privacy and sharing settings
- **Help & Support**: In-app help documentation and support contact

### 🔐 Authentication & Security

- **Secure Login**: Email/password authentication with OTP verification
- **Password Recovery**: Forgot password functionality with email reset
- **Account Creation**: New user registration with household setup
- **Data Security**: Encrypted data storage and secure API communications

### 📱 Multi-Platform Support

- **Android**: Native Android app with Material Design
- **iOS**: Native iOS app with Cupertino design elements
- **Responsive Design**: Adaptive UI for different screen sizes
- **Cross-platform Consistency**: Unified experience across all platforms
