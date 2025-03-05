# Home Asset Management App

A Flutter application for managing homes and their assets. This app allows users to create and track homes with their essential assets, such as appliances, HVAC systems, and more.

## Features

- Create, view, edit, and delete homes with valid US addresses
- Add assets to homes from a predefined list
- Remove assets from homes
- Search through assets when adding to a home
- Visual categorization of different asset types

## Tech Stack

- Flutter with Material 3 design
- Bloc/Cubit pattern for state management
- Freezed for immutable data models
- Go Router for navigation
- Formz for form validation
- In-memory data storage

## Getting Started

### Prerequisites

- Flutter SDK (Version ^3.5.4)
- Dart SDK
- Android Studio / Xcode (for running on emulators or physical devices)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/classy-bear/home_asset_management.git
cd home_asset_management
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

The project follows a domain-driven design with a clear separation of concerns:

- `/lib/domain/`: Contains the core business logic and models
  - `/models/`: Data models like Home and Asset using Freezed for immutability
  - `/repositories/`: Repository interfaces defining the data access contracts

- `/lib/data/`: Implements the repositories defined in the domain layer
  - `/repositories/`: Contains implementations like InMemoryHomeRepository

- `/lib/cubits/`: State management using the Bloc/Cubit pattern
  - `/home/`: Manages state for home listing and operations
  - `/home_form/`: Manages state for home creation/editing forms

- `/lib/modules/`: UI components organized by feature
  - `/screens/`: Main screens like HomeListScreen and HomeFormScreen
  - `/widgets/`: Reusable UI components

- `/lib/router.dart`: Application routing using Go Router
- `/lib/main.dart`: Entry point of the application

## Design Choices & Trade-offs

### State Management
The application uses the Bloc/Cubit pattern for state management, providing a clear separation of concerns and making the codebase more maintainable and testable. Flutter_bloc provides a concise API for implementing this pattern.

### Model Implementation
Models are implemented using Freezed for immutability, which provides:
- Immutable data structures
- Built-in equality checks
- Serialization/deserialization (toJson/fromJson)
- Pattern matching with copyWith functionality

### Form Validation
Formz is used for form validation, providing a structured approach to input validation and form state management.

### Navigation
Go Router is used for declarative routing, supporting deep linking and nested navigation with a clean API.

### Data Storage
For this implementation, an in-memory repository is used with predefined assets. In a production environment, this would be replaced with a persistent storage solution (SQLite, Firestore, etc.).

### UI/UX
The application follows Material 3 design principles with a clean, intuitive interface including:
- Slidable list items for quick actions
- Visual categorization of assets by type
- Search functionality for asset selection
- Validation for home addresses

## Running Tests

The project includes both unit tests and widget tests:

```bash
# Run all tests
flutter test

# Run specific test files
flutter test test/domain/models/home_test.dart
flutter test test/modules/screens/home_list_screen_test.dart
```

## Potential Improvements

- Add authentication for multi-user support
- Implement persistent storage
- Add asset service history tracking
- Allow for custom asset creation
- Add reminders for asset maintenance
- Implement barcode/QR scanning for asset identification

## License

This project is licensed under the MIT License - see the LICENSE file for details.
