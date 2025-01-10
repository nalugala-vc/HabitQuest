# HabitQuest 🎯

A gamified habit tracking application built with Flutter that helps users build and maintain positive habits through engaging gameplay elements and progress tracking.

## Features ✨

- **Authentication**
  - Google Sign-in integration
  - Secure email/password authentication

- **Habit Management**
  - Create and manage daily/weekly habits
  - Smart habit validation (prevents marking habits for incorrect days)
  - Visual progress tracking with heatmap calendar
  - Customizable reminders for each habit

- **Gamification**
  - Unlock achievement badges
  - Track progress with visual heatmaps
  - Streak tracking and milestone celebrations

- **Cross-Platform**
  - Responsive design for both mobile and web
  - Dark/Light theme support
  - Seamless sync across devices

## Video Walkthrough

Here's a walkthrough of implemented app:


## Tech Stack 🛠️

- Flutter for cross-platform development
- Firebase Backend (Authentication, Firestore, Storage)
- GetX for state management
- Firebase Cloud Messaging for push notifications

## Getting Started 🚀

### Prerequisites

- Flutter (Latest Version)
- Firebase Account
- Android Studio/VS Code
- Git

### Setup Instructions

1. Clone the repository
```bash
git clone [your-repo-link]
cd habitquest
```

2. Firebase Setup
- Create a new Firebase project
- Enable Authentication (Google Sign-in)
- Set up Firestore Database
- Download `google-services.json` for Android
- Download `GoogleService-Info.plist` for iOS
- Add Firebase web configuration for web support

3. Configure Google Sign-in
- Create OAuth 2.0 Client ID in Google Cloud Console
- Add SHA-1 and SHA-256 fingerprints to Firebase project

4. Install dependencies
```bash
flutter pub get
```

5. Run the app
```bash
flutter run
```

## Key Dependencies 📦

### Core Dependencies
```yaml
firebase_core: ^3.9.0
firebase_auth: ^5.3.1
cloud_firestore: ^5.4.4
firebase_storage: ^12.3.4
get: ^4.6.6
google_sign_in: ^6.2.2
shared_preferences: ^2.0.15
```
Firebase services for backend operations, GetX for state management, and local storage for data persistence.

### UI Components
```yaml
google_fonts: ^6.2.1
flutter_svg: ^2.0.7
heroicons: ^0.11.0
flutter_slidable: ^3.0.0
flutter_heatmap_calendar: ^1.0.5
easy_date_timeline: ^1.1.3
```
Modern UI components for a polished user experience and interactive features.

### Notifications
```yaml
firebase_messaging: ^15.2.0
flutter_local_notifications: ^18.0.1
```
Comprehensive notification system supporting both push and local notifications.

### Development & Testing
```yaml
flutter_native_splash: ^2.4.4
test: ^1.24.0
flutter_driver:
  sdk: flutter
```
Tools for development, testing, and app presentation.

## Firebase Offline Support 🔄

HabitQuest leverages Firebase's built-in offline persistence features:
- Automatic data synchronization when network connection is restored
- Offline data access for uninterrupted app usage
- Real-time updates when online
- Cross-device synchronization with conflict resolution
- Optimized data caching for better performance

## Project Structure 📁

```
lib/
├── api/
├── auth/
├── common/
├── core/
│   ├── controllers/
│   └── di/
├── home/
├── models/
├── notifications/
├── profile/
├── services/
├── streaks/
├── test_driver/
├── utils/
└── main.dart
```

## Features Implementation Details 🔍

### Authentication
- Secure Google Sign-in implementation
- Email/password authentication with validation
- Persistent user sessions
- Cross-platform authentication support

### Habit Tracking
- Daily and weekly habit support
- Custom reminder settings per habit
- Progress visualization through heatmaps
- Streak tracking and milestone achievements

### Data Persistence
- Firebase Firestore for cloud storage
- Shared Preferences for local data
- Automatic sync between devices
- Offline support with data persistence

## License 📄

[Your License]

## Acknowledgments 🙏

- Firebase Team for the excellent BaaS solution
- Flutter Team for the amazing framework
- Open source community for various packages used in this project