# Homekru Owner Project Architecture

This document outlines the architecture and folder structure of this project. Following this structure will help maintain consistency, scalability, and code organization across the application.

## Overview

This project follows a feature-first architecture with clear separation of concerns. The structure is designed to be modular, testable, and maintainable as the project grows.

## Folder Structure

```
lib/
├── core/
├── shared/
└── features/
```

## Core Directory

The `core/` directory contains application-wide configurations, utilities, and services that are fundamental to the app's operation.

### Core Subdirectories

- **theme/** - Application theme configuration including colors, text styles, and custom theme data
- **l10n/** - Localization files and internationalization setup for multi-language support
- **constants/** - Global constants such as API endpoints, app-wide static values, and configuration keys
- **router/** - Navigation and routing configuration (e.g., GoRouter setup)
- **storage/** - Local storage implementations (SharedPreferences, Hive, Secure Storage, etc.)
- **services/** - Core application services like authentication, logging, analytics, and crash reporting
- **network/** - HTTP client setup, API interceptors, and network-related configurations
- **config/** - Environment configurations, app initialization logic, and dependency injection setup

## Shared Directory

The `shared/` directory contains reusable components that are used across multiple features.

### Shared Subdirectories

- **widgets/** - Common UI components used throughout the app (custom buttons, cards, dialogs, etc.)
- **utils/** - Utility functions and helper classes (formatters, validators, extensions, etc.)

You can extend this directory with additional subdirectories as needed:

- **models/** - Shared data models
- **repositories/** - Shared repository implementations
- **services/** - Shared business logic services

## Features Directory

The `features/` directory organizes code by feature or module. Each feature is self-contained and follows a layered architecture.

### Feature Structure

```
features/
└── {{feature_name}}/
    ├── data/
    ├── domain/
    └── ui/
```

### Feature Layers

#### 1. Data Layer (`data/`)

Handles data operations and external data sources.

- **models/** - Data Transfer Objects (DTOs) and JSON serialization models using Freezed
- **repositories/** - Repository implementations that fetch data from various sources
- **services/** - Feature-specific services for API calls, database operations, etc.

#### 2. Domain Layer (`domain/`) - Optional

Contains business logic and domain entities. Use this layer when you need clear separation between business rules and data representation.

- **entity/** - Pure Dart objects representing business entities (independent of data sources), can use Freezed for immutability
- **use_cases/** - Business logic and use cases that operate on entities

**When to use:** For complex features with significant business logic, or when following Clean Architecture principles strictly.

#### 3. UI Layer (`ui/`)

Handles presentation logic and user interface.

- **providers/** - Business logic and state management using Riverpod (StateNotifier, AsyncNotifier, etc.)
- **views/** - Screen/page widgets that represent complete views
- **widgets/** - Feature-specific reusable widgets used only within this feature

## Architecture Principles

### Feature Independence

Each feature should be as independent as possible. Features should not directly depend on other features. Use the `shared/` directory for cross-feature dependencies.

### Layer Separation

- **UI Layer** depends on Providers
- **Providers** depend on Repositories/UseCases
- **Repositories** depend on Services and Models
- **Domain Layer** (when used) should have no dependencies on other layers

### Naming Conventions

**Features:** Use descriptive, lowercase names with underscores

```
features/
├── authentication/
├── user_profile/
└── product_catalog/
```

**Files:** Follow Dart naming conventions

- Classes: `PascalCase`
- Files: `snake_case.dart`
- Constants: `camelCase` or `SCREAMING_SNAKE_CASE` for compile-time constants

## State Management with Riverpod

This project uses **Riverpod** for state management. Riverpod provides compile-time safety, better testability, and improved developer experience compared to traditional Provider.

### Provider Types

Choose the appropriate provider type based on your needs:

- **Provider** - For immutable/computed values
- **StateProvider** - For simple state (primitive values)
- **StateNotifierProvider** - For complex state with multiple methods
- **FutureProvider** - For async operations (one-time)
- **StreamProvider** - For streams of data
- **NotifierProvider** - New Riverpod syntax (Riverpod 2.0+)
- **AsyncNotifierProvider** - For async state with Notifier syntax

### Hooks Integration

This project also uses **Flutter Hooks** for widget lifecycle management and state:

- **useState** - Local widget state
- **useEffect** - Side effects and lifecycle
- **useMemoized** - Cached computations
- **useTextEditingController** - Text field controllers
- **useAnimationController** - Animation management

## Data Models with Freezed

This project uses **Freezed** for immutable data models. Freezed dramatically reduces boilerplate code while providing powerful features for data classes.

### Why Freezed?

- ✅ **Immutability** - Prevents accidental state mutations
- ✅ **Code Generation** - Eliminates boilerplate for `copyWith`, `==`, `hashCode`, and `toString`
- ✅ **JSON Serialization** - Seamless integration with `json_serializable`
- ✅ **Union Types** - Support for sealed classes and pattern matching
- ✅ **Type Safety** - Compile-time guarantees

### When to Use Freezed

**Use Freezed for:**
- Data models in the `data/models/` directory (DTOs)
- Domain entities in the `domain/entity/` directory
- State classes for complex state management
- Response/Request models for API communication

**Don't use Freezed for:**
- Simple widgets
- Utility classes with methods
- Classes that need to be mutable

### Freezed Model Example

```dart
// features/todo/data/models/todo_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel with _$TodoModel {
  const factory TodoModel({
    required String id,
    required String title,
    @Default(false) bool isCompleted,
    DateTime? createdAt,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
}
```

### Freezed with Custom Methods

For domain entities that need business logic:

```dart
// features/todo/domain/entity/todo_entity.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_entity.freezed.dart';

@freezed
class TodoEntity with _$TodoEntity {
  const TodoEntity._(); // Private constructor for custom methods

  const factory TodoEntity({
    required String id,
    required String title,
    required bool isCompleted,
    DateTime? dueDate,
  }) = _TodoEntity;

  // Custom business logic methods
  bool get isOverdue {
    if (dueDate == null || isCompleted) return false;
    return DateTime.now().isAfter(dueDate!);
  }

  String get statusText {
    if (isCompleted) return 'Completed';
    if (isOverdue) return 'Overdue';
    return 'Pending';
  }
}
```

### Freezed Union Types (Optional)

For handling multiple states or types:

```dart
// features/todo/ui/providers/todo_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_state.freezed.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState.initial() = _Initial;
  const factory TodoState.loading() = _Loading;
  const factory TodoState.loaded(List<TodoModel> todos) = _Loaded;
  const factory TodoState.error(String message) = _Error;
}

// Usage in provider:
@riverpod
class TodoNotifier extends _$TodoNotifier {
  @override
  TodoState build() => const TodoState.initial();

  Future<void> loadTodos() async {
    state = const TodoState.loading();

    try {
      final todos = await ref.read(todoRepositoryProvider).getTodos();
      state = TodoState.loaded(todos);
    } catch (e) {
      state = TodoState.error(e.toString());
    }
  }
}

// In UI:
state.when(
  initial: () => Text('Start loading'),
  loading: () => CircularProgressIndicator(),
  loaded: (todos) => TodoList(todos),
  error: (message) => ErrorWidget(message),
);
```

### Model to Entity Conversion

When using both models and entities, create extension methods for conversion:

```dart
// features/todo/data/models/todo_model.dart
extension TodoModelX on TodoModel {
  TodoEntity toEntity() => TodoEntity(
    id: id,
    title: title,
    isCompleted: isCompleted,
    dueDate: createdAt,
  );
}

// features/todo/domain/entity/todo_entity.dart
extension TodoEntityX on TodoEntity {
  TodoModel toModel() => TodoModel(
    id: id,
    title: title,
    isCompleted: isCompleted,
    createdAt: dueDate,
  );
}
```

## Getting Started

### Adding a New Feature

1. Create a new folder under `features/` with your feature name
2. Create the three main directories: `data/`, `domain/` (optional), and `ui/`
3. Add subdirectories as needed within each layer
4. Implement your feature following the layer separation principles

### Example: Creating a "Todo" Feature

```
features/
└── todo/
    ├── data/
    │   ├── models/
    │   │   ├── todo_model.dart
    │   │   ├── todo_model.freezed.dart    (generated)
    │   │   └── todo_model.g.dart          (generated)
    │   ├── repositories/
    │   │   └── todo_repository.dart
    │   └── services/
    │       └── todo_api_service.dart
    ├── domain/
    │   ├── entity/
    │   │   ├── todo_entity.dart
    │   │   └── todo_entity.freezed.dart   (generated)
    │   └── use_cases/
    │       └── create_todo_use_case.dart
    └── ui/
        ├── providers/
        │   ├── todo_provider.dart
        │   └── todo_provider.g.dart       (generated)
        ├── views/
        │   └── todo_list_view.dart
        └── widgets/
            └── todo_item_widget.dart
```

### Example Code Structure

#### Data Layer - Model with Freezed

```dart
// features/todo/data/models/todo_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel with _$TodoModel {
  const factory TodoModel({
    required String id,
    required String title,
    @Default(false) bool isCompleted,
    DateTime? createdAt,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
}
```

#### Data Layer - Repository

```dart
// features/todo/data/repositories/todo_repository.dart
class TodoRepository {
  final TodoApiService _apiService;

  TodoRepository(this._apiService);

  Future<List<TodoModel>> getTodos() async {
    return await _apiService.fetchTodos();
  }

  Future<void> createTodo(TodoModel todo) async {
    await _apiService.createTodo(todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await _apiService.updateTodo(todo);
  }
}

// Repository provider
@riverpod
TodoRepository todoRepository(TodoRepositoryRef ref) {
  return TodoRepository(ref.read(todoApiServiceProvider));
}
```

#### UI Layer - Provider (Riverpod 2.0+ Syntax)

```dart
// features/todo/ui/providers/todo_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoNotifier extends _$TodoNotifier {
  @override
  FutureOr<List<TodoModel>> build() async {
    // Initialize state by loading todos
    return await ref.read(todoRepositoryProvider).getTodos();
  }

  Future<void> addTodo(String title) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final newTodo = TodoModel(
        id: DateTime.now().toString(),
        title: title,
        isCompleted: false,
      );
      await ref.read(todoRepositoryProvider).createTodo(newTodo);
      return await ref.read(todoRepositoryProvider).getTodos();
    });
  }

  Future<void> toggleTodo(String id) async {
    state = await AsyncValue.guard(() async {
      final todos = state.value ?? [];
      final updatedTodos = todos.map((todo) {
        if (todo.id == id) {
          // Using Freezed's copyWith
          return todo.copyWith(isCompleted: !todo.isCompleted);
        }
        return todo;
      }).toList();

      final updatedTodo = updatedTodos.firstWhere((t) => t.id == id);
      await ref.read(todoRepositoryProvider).updateTodo(updatedTodo);

      return updatedTodos;
    });
  }
}
```

#### UI Layer - View with Hooks

```dart
// features/todo/ui/views/todo_list_view.dart
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoListView extends HookConsumerWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoNotifierProvider);
    final textController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: todosAsync.when(
        data: (todos) => ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) => TodoItemWidget(
            todo: todos[index],
            onToggle: () => ref
                .read(todoNotifierProvider.notifier)
                .toggleTodo(todos[index].id),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (textController.text.isNotEmpty) {
            ref.read(todoNotifierProvider.notifier).addTodo(textController.text);
            textController.clear();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

## Best Practices

### 1. Keep features isolated

Avoid dependencies between features. Use the `shared/` directory for cross-feature code.

### 2. Centralize navigation

Define all routes in `core/router/` using GoRouter.

### 3. Reuse when appropriate

Move reusable code to `shared/` to avoid duplication across features.

### 4. Keep UI thin

Business logic belongs in providers or use cases, not in widgets. Widgets should only display data and handle user input.

### 5. Use code generation

This project uses code generation for both Riverpod and Freezed. Run this command during development:

```bash
# Watch mode (recommended for active development)
flutter pub run build_runner watch --delete-conflicting-outputs

# One-time generation
flutter pub run build_runner build --delete-conflicting-outputs
```

### 6. Leverage Freezed's copyWith

When you need to update immutable objects, use Freezed's generated `copyWith` method:

```dart
// Update a single field
final updatedTodo = todo.copyWith(isCompleted: true);

// Update multiple fields
final updatedTodo = todo.copyWith(
  title: 'New Title',
  isCompleted: true,
);
```

### 7. Use const constructors

Freezed generates const constructors. Use them for better performance:

```dart
const todo = TodoModel(
  id: '1',
  title: 'Sample',
  isCompleted: false,
);
```

### 8. Leverage Hooks for local state

Use Flutter Hooks for widget-local state and lifecycle:

```dart
final controller = useTextEditingController();
final isEnabled = useState(false);

useEffect(() {
  // Runs on mount
  return () {
    // Cleanup on unmount
  };
}, []);
```

### 9. Document complex logic

Add comments and documentation for non-obvious implementations.

### 10. Handle loading and error states

Always handle AsyncValue states properly:

```dart
asyncValue.when(
  data: (data) => DataWidget(data),
  loading: () => LoadingWidget(),
  error: (error, stack) => ErrorWidget(error),
);
```

### 11. Use meaningful default values

When using Freezed, provide sensible defaults with `@Default()`:

```dart
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    @Default(false) bool isActive,
    @Default([]) List<String> roles,
    @Default('user') String accountType,
  }) = _UserModel;
}
```

## Code Generation Dependencies

Add these dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  # State Management
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0

  # Immutable Models
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

  # Hooks
  flutter_hooks: ^0.20.0
  hooks_riverpod: ^2.4.0

dev_dependencies:
  # Code Generation
  build_runner: ^2.4.6
  riverpod_generator: ^2.3.0
  freezed: ^2.4.5
  json_serializable: ^6.7.1
```

## Additional Resources

- [Riverpod Documentation](https://riverpod.dev/)
- [Freezed Documentation](https://pub.dev/packages/freezed)
- [Flutter Hooks Documentation](https://pub.dev/packages/flutter_hooks)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [JSON Serializable Documentation](https://pub.dev/packages/json_serializable)

## Questions or Issues?

If you have questions about this architecture or suggestions for improvements, please reach out to the team lead or create an issue in the project repository.

---

**Last Updated**: 25 December 2025