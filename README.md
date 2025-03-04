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
- BLoC pattern for state management
- Clean architecture principles
- In-memory data storage

## Getting Started

### Prerequisites

- Flutter SDK (Version ^3.5.4)
- Dart SDK
- Android Studio / Xcode (for running on emulators or physical devices)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/home_asset_management.git
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

The project follows a clean architecture approach:

- `/lib/domain`: Contains the core business logic, models, and repository interfaces
- `/lib/data`: Implements the repositories defined in the domain layer
- `/lib/presentation`: Contains the UI components (screens, widgets) and BLoC state management
- `/lib/core`: Houses utilities and shared functions

## Design Choices & Trade-offs

### State Management
I chose the BLoC pattern for state management as it provides a clear separation of concerns, making the codebase more maintainable and testable. Flutter_bloc provides a concise API for implementing the pattern.

### Data Storage
For this implementation, I used in-memory storage with predefined assets. In a production environment, this would be replaced with a persistent storage solution (SQLite, Firestore, etc.).

### UI/UX
I prioritized a clean, intuitive interface using Material 3 design principles. The app includes features like:
- Slidable list items for quick actions
- Visual categorization of assets by type
- Search functionality for asset selection
- Validation for home addresses

## Running Tests

Execute the tests using the following command:

```bash
flutter test
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
