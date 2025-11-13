# Clean Architecture Documentation

## Overview

This Flutter application follows **Clean Architecture** principles with **BLoC** for state management and **get_it** for dependency injection. The architecture ensures separation of concerns, testability, and maintainability.

## Architecture Layers

### 1. **Presentation Layer** (`lib/features/fruits/presentation/`)

The UI layer that displays data to users and handles user interactions.

**Components:**
- **BLoC (Business Logic Component)**
  - `fruit_bloc.dart` - Manages application state
  - `fruit_event.dart` - Defines user actions/events
  - `fruit_state.dart` - Defines UI states (Initial, Loading, Loaded, Error)

- **Pages**
  - `home_page.dart` - Main screen displaying fruit list
  - `detail_page.dart` - Detailed view of a selected fruit

- **Widgets**
  - `fruit_card.dart` - Reusable fruit card component

**Responsibilities:**
- React to user interactions
- Display data from BLoC
- Navigate between screens
- Show loading/error states

### 2. **Domain Layer** (`lib/features/fruits/domain/`)

The core business logic layer, independent of external frameworks.

**Components:**
- **Entities**
  - `fruit.dart` - Pure business object representing a fruit
  - `nutrition.dart` - Pure business object for nutritional data

- **Repositories (Interfaces)**
  - `fruit_repository.dart` - Abstract contract for data operations

- **Use Cases**
  - `get_fruits.dart` - Encapsulates business rule for fetching fruits

**Responsibilities:**
- Define business entities
- Define repository contracts
- Implement business rules (use cases)
- Independent of external dependencies

### 3. **Data Layer** (`lib/features/fruits/data/`)

Handles data operations and implements domain repository contracts.

**Components:**
- **Models**
  - `fruit_model.dart` - Data model extending Fruit entity
  - `nutrition_model.dart` - Data model extending Nutrition entity

- **Data Sources**
  - `fruit_remote_data_source.dart` - API communication

- **Repository Implementations**
  - `fruit_repository_impl.dart` - Implements FruitRepository interface

**Responsibilities:**
- Fetch data from APIs
- Transform JSON to models
- Cache data (if needed)
- Implement repository contracts

### 4. **Core Layer** (`lib/core/`)

Shared utilities and abstractions used across the application.

**Components:**
- **Error Handling**
  - `exceptions.dart` - Data layer exceptions
  - `failures.dart` - Domain layer failures

- **Network**
  - `network_info.dart` - Internet connectivity checker

- **Use Cases**
  - `usecase.dart` - Base use case interface

- **Constants**
  - `strings.dart` - Application string constants

**Responsibilities:**
- Provide shared utilities
- Define base interfaces
- Error handling abstractions
- Network connectivity

## Data Flow

```
User Interaction
      ↓
  Presentation (BLoC)
      ↓
  Domain (Use Case)
      ↓
  Domain (Repository Interface)
      ↓
  Data (Repository Implementation)
      ↓
  Data (Remote Data Source)
      ↓
  External API
```

## Dependency Flow

```
Presentation → Domain ← Data
     ↓
   Core
```

**Rules:**
- Presentation depends on Domain
- Data depends on Domain
- Domain depends on nothing (pure business logic)
- All layers can depend on Core

## State Management (BLoC Pattern)

### Events
User actions that trigger state changes:
```dart
GetFruitsEvent - Fetches fruit list from API
```

### States
Different UI states:
```dart
FruitInitial - Initial state
FruitLoading - Fetching data
FruitLoaded - Data successfully loaded
FruitError - Error occurred
```

### Flow
```
User taps screen → Event dispatched → BLoC processes →
Use case executed → Repository called → Data fetched →
State emitted → UI rebuilds
```

## Dependency Injection (get_it)

All dependencies are registered in `injection_container.dart`:

```dart
// Presentation Layer (Factory - new instance each time)
FruitBloc

// Domain Layer (Lazy Singleton - created when needed)
GetFruits (Use Case)

// Data Layer (Lazy Singleton)
FruitRepository
FruitRemoteDataSource

// Core Layer (Lazy Singleton)
NetworkInfo

// External (Lazy Singleton)
http.Client
InternetConnection
```

## Error Handling

### Two-Level Error Handling:

1. **Exceptions (Data Layer)**
   - `ServerException` - API errors
   - `CacheException` - Local storage errors
   - `NetworkException` - Connection errors

2. **Failures (Domain Layer)**
   - `ServerFailure` - Server-side issues
   - `CacheFailure` - Cache issues
   - `NetworkFailure` - No internet connection

### Flow:
```
API Error → Exception thrown → Repository catches →
Converts to Failure → Returns Either<Failure, Data> →
BLoC handles → Emits Error state with message
```

## Testing Strategy

### Unit Tests
- **Domain Layer:** Test use cases and entities
- **Data Layer:** Test models, data sources, repositories
- **Presentation Layer:** Test BLoC logic

### Widget Tests
- Test individual widgets
- Test page interactions

### Integration Tests
- Test complete user flows
- Test API integration

## Key Benefits

1. **Separation of Concerns**
   - Each layer has a specific responsibility
   - Easy to locate and fix bugs

2. **Testability**
   - Mock dependencies easily
   - Test business logic independently
   - High code coverage possible

3. **Maintainability**
   - Changes in one layer don't affect others
   - Easy to add new features
   - Clear code organization

4. **Scalability**
   - Easy to add new features
   - Can grow without becoming messy
   - Team-friendly structure

5. **Independence**
   - Domain logic independent of frameworks
   - Can swap UI, database, or API easily
   - Future-proof architecture

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── strings.dart
│   ├── error/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/
│   │   └── network_info.dart
│   └── usecases/
│       └── usecase.dart
├── features/
│   └── fruits/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── fruit_remote_data_source.dart
│       │   ├── models/
│       │   │   ├── fruit_model.dart
│       │   │   └── nutrition_model.dart
│       │   └── repositories/
│       │       └── fruit_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── fruit.dart
│       │   │   └── nutrition.dart
│       │   ├── repositories/
│       │   │   └── fruit_repository.dart
│       │   └── usecases/
│       │       └── get_fruits.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── fruit_bloc.dart
│           │   ├── fruit_event.dart
│           │   └── fruit_state.dart
│           ├── pages/
│           │   ├── home_page.dart
│           │   └── detail_page.dart
│           └── widgets/
│               └── fruit_card.dart
├── app.dart
├── injection_container.dart
└── main.dart
```

## Dependencies

```yaml
# State Management
flutter_bloc: ^8.1.3
bloc: ^8.1.2

# Dependency Injection
get_it: ^7.6.4

# Functional Programming
dartz: ^0.10.1

# Value Equality
equatable: ^2.0.5

# Network
http: ^1.1.0
internet_connection_checker_plus: ^2.1.0

# UI
lottie: ^2.4.0
```

## Getting Started

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the App**
   ```bash
   flutter run
   ```

3. **Build for Production**
   ```bash
   flutter build apk  # Android
   flutter build ios  # iOS
   ```

## Adding New Features

To add a new feature following Clean Architecture:

1. **Create Feature Folder**
   ```
   lib/features/new_feature/
   ```

2. **Add Domain Layer**
   - Create entities
   - Define repository interface
   - Implement use cases

3. **Add Data Layer**
   - Create models
   - Implement data sources
   - Implement repository

4. **Add Presentation Layer**
   - Create BLoC (events, states, bloc)
   - Create pages and widgets

5. **Register Dependencies**
   - Add to `injection_container.dart`

## Resources

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC Documentation](https://bloclibrary.dev/)
- [get_it Documentation](https://pub.dev/packages/get_it)
- [Effective Dart Style Guide](https://dart.dev/guides/language/effective-dart)
