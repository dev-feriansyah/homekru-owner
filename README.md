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

For detailed architecture documentation, see [ARCHITECTURE.md.](./ARCHITECTURE.md)

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
