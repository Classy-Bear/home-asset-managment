# Home Asset Management App

A Flutter application for managing homes and their assets. This app allows users to create and track homes with their essential assets, such as appliances, HVAC systems, and more.

## Features

- Create, view, edit, and delete homes with valid [US addresses](https://en.wikipedia.org/wiki/Postal_address_verification#:~:text=An%20address%20must%20be%20complete,and%20state%20names%20are%20added.)
- Add assets to homes from a predefined list
- Remove assets from homes
- Search through assets when adding to a home
- Visual categorization of different asset types
- Persistent storage of homes and assets

## Tech Stack

- Flutter with Material 3 design
- Bloc/Cubit pattern for state management
- HydratedBloc for persistent state storage
- Freezed for immutable data models
- Go Router for navigation
- Formz for form validation

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

- `/lib/presentation/`: UI components organized by feature
  - `/screens/`: Main screens like HomeListScreen and HomeFormScreen
  - `/widgets/`: Reusable UI components

- `/lib/router.dart`: Application routing using Go Router
- `/lib/main.dart`: Entry point of the application

## Design Choices & Trade-offs

### State Management
The application uses the Bloc/Cubit pattern with HydratedBloc for state management, providing:
- Clear separation of concerns
- Persistent state across app restarts
- Simplified state restoration
- Testable state management

### Model Implementation
Models are implemented using Freezed for immutability, which provides:
- Immutable data structures
- Built-in equality checks
- Serialization/deserialization (toJson/fromJson)
- Pattern matching with copyWith functionality

### Form Validation
Formz is used for form validation, providing a structured approach to input validation and form state management.

### Navigation
Go Router (v13.2.0) is used for declarative routing, supporting deep linking and nested navigation with a clean API.

### Data Storage
The application follows the [key-value data persistent storage architecture pattern](https://docs.flutter.dev/app-architecture/design-patterns/key-value-data) as recommended in Flutter's official documentation:

- Implements a clean separation between presentation and data layers
- Uses repositories as the single source of truth for data
- Employs service classes to abstract third-party dependencies 
- Provides observable data streams for reactive UI updates

The implementation uses HydratedBloc for persistent storage, offering:
- State persistence across app restarts
- Automatic serialization and deserialization
- Fallback to in-memory storage when needed

### UI/UX
The application follows Material 3 design principles with a clean, intuitive interface including:
- Slidable list items for quick actions (flutter_slidable v3.0.1)
- Visual categorization of assets by type
- Search functionality for asset selection
- Validation for home addresses
- Google Fonts integration for improved typography

## Production-Ready Best Practices

This project implements industry-standard best practices for production-ready Flutter applications:

### Architecture
- Follows the official [key-value data persistent storage architecture pattern](https://docs.flutter.dev/app-architecture/design-patterns/key-value-data) from Flutter documentation
- Implements a proper separation of concerns (presentation, domain, data layers)
- Uses dependency injection for better testability and flexibility
- Applies SOLID principles for robust, maintainable code

### Maintainability
- Uses strict linting rules with customized analysis_options.yaml
- Comprehensive code documentation including class-level, method-level and complex logic comments
- Small, focused Dart files (< 300 lines) to improve readability and maintainability
- Consistent naming conventions and code style throughout the codebase
- Structured project organization with feature-based folders

### Testability
- Comprehensive test suite with high coverage percentage
- Unit tests for business logic and data layers
- Widget tests for UI components
- Automated test runs in CI/CD pipeline

## Test Coverage

This project includes comprehensive test coverage using Flutter's test framework along with bloc_test and mocktail for mocking dependencies.

### Running Tests with Coverage

You can run tests with coverage and view the results in your browser using the provided script:

```bash
./run_tests_with_coverage.sh
```

This script:
1. Runs all tests with the `--coverage` flag
2. Generates HTML reports using lcov
3. Opens the coverage report in your default browser

### CI/CD Integration

Test coverage is automatically checked in the CI/CD pipeline using GitHub Actions. The workflow:
- Runs on every push to the main branch and pull requests
- Generates coverage reports
- Uploads the coverage report as an artifact
- Uploads the coverage data to Codecov

### Writing New Tests

When adding new features, follow these guidelines for test coverage:
- Create unit tests for all domain models and repositories
- Use bloc_test for testing cubits
- Mock external dependencies using mocktail
- Write widget tests for complex UI components

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Firebase Hosting Deployment

This application can be deployed to Firebase Hosting, which provides fast and secure hosting for your web app.

> **Note:** For the most up-to-date and comprehensive instructions, please follow the official Flutter-Firebase Hosting guide at: https://firebase.google.com/docs/hosting/flutter

### Prerequisites

1. Install Firebase CLI tools:
```bash
npm install -g firebase-tools
```

2. Login to Firebase:
```bash
firebase login
```

3. Initialize your Firebase project (if you haven't already):
```bash
firebase init
```
During initialization:
- Select "Hosting: Configure files for Firebase Hosting"
- Select your Firebase project or create a new one
- Specify "build/web" as your public directory
- Configure as a single-page app: Yes
- Set up automatic builds and deploys: No

### Deployment

You can deploy to Firebase Hosting using the provided script:

```bash
./deploy_to_firebase.sh
```

This script will:
1. Build your Flutter web app with the release configuration
2. Deploy the built app to Firebase Hosting

### Manual Deployment

If you prefer to deploy manually, follow these steps:

1. Build your Flutter web app:
```bash
flutter build web --release
```

2. Deploy to Firebase Hosting:
```bash
firebase deploy --only hosting
```

### Firebase Configuration

The web app is configured to use Firebase services through the Firebase SDK included in the `web/index.html` file. After initializing your Firebase project, you'll need to update the Firebase configuration in the web/index.html file with your own Firebase project details.

You can find your Firebase configuration in the Firebase Console:
1. Go to your [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Click on the web app icon (</>) to register a new web app if you haven't already
4. Copy the configuration object and replace the placeholder in the `web/index.html` file
