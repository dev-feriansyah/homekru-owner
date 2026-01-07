# API Developer Guide

Welcome to the Homekru Owner API documentation! This guide will help you understand and work with our API layer.

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Architecture](#architecture)
- [Making API Calls](#making-api-calls)
- [Authentication](#authentication)
- [Error Handling](#error-handling)
- [Creating New Features](#creating-new-features)
- [Best Practices](#best-practices)
- [Common Patterns](#common-patterns)
- [Troubleshooting](#troubleshooting)

---

## Overview

Our app uses a **layered architecture** with clear separation of concerns:

```
UI (Screens/Widgets)
    ↓
UI Providers (State Management)
    ↓
Repositories (Business Logic)
    ↓
Services (API Calls)
    ↓
ApiClient (HTTP Layer)
```

**Key Principles:**
- UI never talks to services directly
- Repositories contain business logic and validation
- Services only make API calls (no logic)
- ApiClient handles all HTTP communication

---

## Quick Start

### Making Your First API Call

**1. Define your model** (using Freezed):

```dart
// lib/features/your_feature/data/models/user_profile.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
sealed class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String name,
    required String email,
    String? avatar,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
```

**2. Create a service** (makes API calls):

```dart
// lib/features/your_feature/data/services/profile_service.dart
import 'package:homekru_owner/core/network/api_client.dart';
import '../models/user_profile.dart';

class ProfileService {
  final ApiClient _apiClient;

  ProfileService(this._apiClient);

  Future<UserProfile> getUserProfile() async {
    return await _apiClient.get<UserProfile>(
      '/profile',
      requiresAuth: true,
      fromJson: (data) => UserProfile.fromJson(data),
    );
  }
}
```

**3. Create a provider for the service:**

```dart
// lib/features/your_feature/data/services/profile_service_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:homekru_owner/core/network/api_provider.dart';
import 'profile_service.dart';

part 'profile_service_provider.g.dart';

@riverpod
ProfileService profileService(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProfileService(apiClient);
}
```

**4. Use it in your UI:**

```dart
// In your screen
class ProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileService = ref.watch(profileServiceProvider);

    return FutureBuilder(
      future: profileService.getUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('Hello, ${snapshot.data!.name}');
        }
        return CircularProgressIndicator();
      },
    );
  }
}
```

**5. Run code generation:**

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## Architecture

### Layer Responsibilities

#### 1. **UI Layer** (Screens/Widgets)
**What it does:** Display data and handle user interactions

```dart
class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(myDataProvider);

    return dataAsync.when(
      data: (data) => SuccessView(data),
      loading: () => LoadingView(),
      error: (error, stack) => ErrorView(error),
    );
  }
}
```

#### 2. **UI Provider Layer** (State Management)
**What it does:** Manage UI state, loading, and errors

```dart
@riverpod
class UserData extends _$UserData {
  @override
  Future<User> build() async {
    final repository = ref.read(userRepositoryProvider);
    return await repository.getCurrentUser();
  }

  Future<void> updateName(String newName) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(userRepositoryProvider);
      return await repository.updateUserName(newName);
    });
  }
}
```

#### 3. **Repository Layer** (Business Logic)
**What it does:** Validation, business rules, error transformation

```dart
class UserRepository {
  final UserService _service;

  UserRepository(this._service);

  Future<User> updateUserName(String newName) async {
    // Validation
    if (newName.isEmpty) {
      throw ApiException('Name cannot be empty');
    }
    if (newName.length < 3) {
      throw ApiException('Name must be at least 3 characters');
    }

    // Make API call
    try {
      return await _service.updateUser({'name': newName});
    } on ApiException catch (e) {
      Log.e('Failed to update name', error: e);
      rethrow;
    }
  }
}
```

#### 4. **Service Layer** (API Calls)
**What it does:** Make HTTP requests, no business logic

```dart
class UserService {
  final ApiClient _apiClient;

  UserService(this._apiClient);

  Future<User> updateUser(Map<String, dynamic> data) async {
    return await _apiClient.put<User>(
      '/user',
      data: data,
      requiresAuth: true,
      fromJson: (json) => User.fromJson(json),
    );
  }
}
```

---

## Making API Calls

### GET Request

```dart
Future<List<Task>> getTasks() async {
  return await _apiClient.get<List<Task>>(
    '/tasks',
    queryParameters: {'status': 'active'},
    requiresAuth: true,
    fromJson: (data) => (data as List)
        .map((json) => Task.fromJson(json))
        .toList(),
  );
}
```

### POST Request

```dart
Future<Task> createTask(CreateTaskRequest request) async {
  return await _apiClient.post<Task>(
    '/tasks',
    data: request.toJson(),
    requiresAuth: true,
    fromJson: (data) => Task.fromJson(data),
  );
}
```

### PUT Request

```dart
Future<Task> updateTask(String id, Map<String, dynamic> updates) async {
  return await _apiClient.put<Task>(
    '/tasks/$id',
    data: updates,
    requiresAuth: true,
    fromJson: (data) => Task.fromJson(data),
  );
}
```

### DELETE Request

```dart
Future<void> deleteTask(String id) async {
  await _apiClient.delete(
    '/tasks/$id',
    requiresAuth: true,
  );
}
```

### Public Endpoints (No Auth)

```dart
Future<LoginResponse> login(String email, String password) async {
  return await _apiClient.post<LoginResponse>(
    '/auth/login',
    data: {'email': email, 'password': password},
    requiresAuth: false, // ← Important!
    fromJson: (data) => LoginResponse.fromJson(data),
  );
}
```

---

## Authentication

### How It Works

1. **Login** → Token saved to encrypted storage
2. **Subsequent requests** → Token automatically attached
3. **Logout** → Token deleted from storage

### Login Flow

```dart
// 1. User enters credentials
Future<void> handleLogin(String email, String password) async {
  try {
    // 2. Call auth provider
    await ref.read(authProvider.notifier).login(email, password);

    // 3. Token is automatically saved
    // 4. Navigate to home
    context.go('/home');
  } on UnauthorizedException {
    showError('Invalid credentials');
  } on NetworkException {
    showError('No internet connection');
  }
}
```

### Making Authenticated Requests

Just set `requiresAuth: true` (or omit it, since it's the default):

```dart
// Token is automatically attached by AuthInterceptor
final tasks = await _apiClient.get<List<Task>>(
  '/tasks',
  requiresAuth: true, // Default is true
  fromJson: (data) => ...,
);
```

### Public Endpoints

For endpoints that should NOT have auth token (login, signup, etc.):

```dart
final response = await _apiClient.post<LoginResponse>(
  '/auth/login',
  data: credentials,
  requiresAuth: false, // ← Don't attach token
  fromJson: (data) => ...,
);
```

### Logout

```dart
Future<void> logout() async {
  await ref.read(authProvider.notifier).logout();
  // Token is deleted, user redirected to login
}
```

---

## Error Handling

### Error Types

Our API layer uses custom exceptions for different error scenarios:

| Exception | When It Happens | How to Handle |
|-----------|----------------|---------------|
| `NetworkException` | No internet, timeout | Show "Check your connection" |
| `UnauthorizedException` | 401 status code | Redirect to login |
| `ClientException` | 4xx errors (404, 400, etc.) | Show error message from server |
| `ServerException` | 5xx errors | Show "Server error, try again" |
| `ApiException` | Generic errors | Show generic error message |

### Handling Errors in UI

```dart
class TaskListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskListProvider);

    return tasksAsync.when(
      data: (tasks) => TaskListView(tasks),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        // Handle different error types
        if (error is UnauthorizedException) {
          return LoginRequiredView();
        } else if (error is NetworkException) {
          return NoInternetView();
        } else if (error is ServerException) {
          return ServerErrorView();
        } else {
          return ErrorView(error.toString());
        }
      },
    );
  }
}
```

### Handling Errors in Repository

```dart
class TaskRepository {
  Future<Task> createTask(CreateTaskRequest request) async {
    try {
      return await _service.createTask(request);
    } on NetworkException {
      // Let it propagate to UI
      rethrow;
    } on ApiException catch (e) {
      // Log the error
      Log.e('Failed to create task', error: e);
      // Transform if needed
      throw ApiException('Unable to create task. Please try again.');
    }
  }
}
```

### Try-Catch with Specific Exceptions

```dart
Future<void> handleSubmit() async {
  try {
    await repository.createTask(taskData);
    showSuccess('Task created!');
  } on NetworkException {
    showError('Check your internet connection');
  } on UnauthorizedException {
    showError('Please login again');
    navigateToLogin();
  } on ClientException catch (e) {
    // Server validation error
    showError(e.message);
  } on ServerException {
    showError('Server error. Please try again later.');
  } catch (e) {
    showError('An unexpected error occurred');
  }
}
```

---

## Creating New Features

Follow these steps to add a new feature with API integration:

### Step 1: Create Models

```dart
// lib/features/my_feature/data/models/my_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_model.freezed.dart';
part 'my_model.g.dart';

@freezed
sealed class MyModel with _$MyModel {
  const factory MyModel({
    required String id,
    required String name,
    String? description,
  }) = _MyModel;

  factory MyModel.fromJson(Map<String, dynamic> json) =>
      _$MyModelFromJson(json);
}
```

### Step 2: Create Service

```dart
// lib/features/my_feature/data/services/my_service.dart
import 'package:homekru_owner/core/network/api_client.dart';
import '../models/my_model.dart';

class MyService {
  final ApiClient _apiClient;

  MyService(this._apiClient);

  Future<List<MyModel>> getAll() async {
    return await _apiClient.get<List<MyModel>>(
      '/my-endpoint',
      requiresAuth: true,
      fromJson: (data) => (data as List)
          .map((json) => MyModel.fromJson(json))
          .toList(),
    );
  }

  Future<MyModel> create(Map<String, dynamic> data) async {
    return await _apiClient.post<MyModel>(
      '/my-endpoint',
      data: data,
      requiresAuth: true,
      fromJson: (data) => MyModel.fromJson(data),
    );
  }
}
```

### Step 3: Create Service Provider

```dart
// lib/features/my_feature/data/services/my_service_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:homekru_owner/core/network/api_provider.dart';
import 'my_service.dart';

part 'my_service_provider.g.dart';

@riverpod
MyService myService(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return MyService(apiClient);
}
```

### Step 4: Create Repository

```dart
// lib/features/my_feature/data/repositories/my_repository.dart
import 'package:homekru_owner/core/network/exceptions/api_exception.dart';
import 'package:homekru_owner/shared/utils/logger.dart';
import '../models/my_model.dart';
import '../services/my_service.dart';

class MyRepository {
  final MyService _service;

  MyRepository(this._service);

  Future<List<MyModel>> fetchAll() async {
    try {
      return await _service.getAll();
    } on ApiException catch (e) {
      Log.e('Failed to fetch items', error: e);
      rethrow;
    }
  }

  Future<MyModel> createNew({
    required String name,
    String? description,
  }) async {
    // Validation
    if (name.isEmpty) {
      throw ApiException('Name is required');
    }

    try {
      final data = {
        'name': name,
        if (description != null) 'description': description,
      };
      return await _service.create(data);
    } on ApiException catch (e) {
      Log.e('Failed to create item', error: e);
      rethrow;
    }
  }
}
```

### Step 5: Create Repository Provider

```dart
// lib/features/my_feature/data/repositories/my_repository_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/my_service_provider.dart';
import 'my_repository.dart';

part 'my_repository_provider.g.dart';

@riverpod
MyRepository myRepository(Ref ref) {
  final service = ref.watch(myServiceProvider);
  return MyRepository(service);
}
```

### Step 6: Create UI Provider

```dart
// lib/features/my_feature/ui/providers/my_list_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/my_model.dart';
import '../../data/repositories/my_repository_provider.dart';

part 'my_list_provider.g.dart';

@riverpod
class MyList extends _$MyList {
  @override
  Future<List<MyModel>> build() async {
    final repository = ref.read(myRepositoryProvider);
    return await repository.fetchAll();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(myRepositoryProvider);
      return await repository.fetchAll();
    });
  }

  Future<void> create(String name, String? description) async {
    final repository = ref.read(myRepositoryProvider);
    await repository.createNew(name: name, description: description);
    await refresh();
  }
}
```

### Step 7: Use in UI

```dart
// lib/features/my_feature/ui/screens/my_screen.dart
class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(myListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('My Feature')),
      body: itemsAsync.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.description ?? ''),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorView(error),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref.read(myListProvider.notifier).create(
            'New Item',
            'Description',
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
```

### Step 8: Generate Code

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## Best Practices

### 1. Always Use Type-Safe Models

❌ **Don't:**
```dart
Future<Map<String, dynamic>> getUser() async {
  return await _apiClient.get('/user');
}
```

✅ **Do:**
```dart
Future<UserModel> getUser() async {
  return await _apiClient.get<UserModel>(
    '/user',
    fromJson: (data) => UserModel.fromJson(data),
  );
}
```

### 2. Put Validation in Repositories

❌ **Don't:** Validate in UI or Service
```dart
// In UI
if (email.isEmpty) showError('Email required');
```

✅ **Do:** Validate in Repository
```dart
// In Repository
Future<void> updateEmail(String email) async {
  if (email.isEmpty) {
    throw ApiException('Email is required');
  }
  if (!email.contains('@')) {
    throw ApiException('Invalid email format');
  }
  await _service.updateEmail(email);
}
```

### 3. Keep Services Simple

❌ **Don't:** Add business logic in services
```dart
class TaskService {
  Future<Task> createTask(Map<String, dynamic> data) async {
    // ❌ Don't validate here
    if (data['title']?.isEmpty ?? true) {
      throw ApiException('Title required');
    }
    return await _apiClient.post(...);
  }
}
```

✅ **Do:** Services only make API calls
```dart
class TaskService {
  Future<Task> createTask(Map<String, dynamic> data) async {
    // ✅ Just make the API call
    return await _apiClient.post<Task>(
      '/tasks',
      data: data,
      fromJson: (json) => Task.fromJson(json),
    );
  }
}
```

### 4. Use AsyncValue in UI

❌ **Don't:** Manage loading/error states manually
```dart
bool isLoading = true;
String? error;
List<Task>? tasks;

void loadTasks() async {
  setState(() => isLoading = true);
  try {
    tasks = await repository.fetchTasks();
  } catch (e) {
    error = e.toString();
  } finally {
    setState(() => isLoading = false);
  }
}
```

✅ **Do:** Use Riverpod AsyncValue
```dart
final tasksAsync = ref.watch(taskListProvider);

return tasksAsync.when(
  data: (tasks) => TaskListView(tasks),
  loading: () => LoadingView(),
  error: (error, stack) => ErrorView(error),
);
```

### 5. Log Errors

Always log errors in repositories:

```dart
try {
  return await _service.createTask(data);
} on ApiException catch (e) {
  Log.e('Failed to create task', error: e, tag: 'TaskRepository');
  rethrow;
}
```

### 6. Don't Expose Implementation Details

❌ **Don't:** Return service/API objects
```dart
Future<Response> getUserData() => _apiClient.get('/user');
```

✅ **Do:** Return domain models
```dart
Future<User> getUserData() async {
  return await _apiClient.get<User>(
    '/user',
    fromJson: (data) => User.fromJson(data),
  );
}
```

---

## Common Patterns

### Pattern 1: List with Pull-to-Refresh

```dart
@riverpod
class TaskList extends _$TaskList {
  @override
  Future<List<Task>> build() async {
    return await _fetchTasks();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchTasks);
  }

  Future<List<Task>> _fetchTasks() async {
    final repository = ref.read(taskRepositoryProvider);
    return await repository.fetchAllTasks();
  }
}

// In UI
RefreshIndicator(
  onRefresh: () => ref.read(taskListProvider.notifier).refresh(),
  child: ListView(...),
)
```

### Pattern 2: Pagination

```dart
@riverpod
class TaskList extends _$TaskList {
  int _page = 1;
  List<Task> _allTasks = [];
  bool _hasMore = true;

  @override
  Future<List<Task>> build() async {
    return await _loadPage(1);
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;

    final repository = ref.read(taskRepositoryProvider);
    final newTasks = await repository.fetchTasks(page: _page + 1);

    if (newTasks.isEmpty) {
      _hasMore = false;
    } else {
      _page++;
      _allTasks.addAll(newTasks);
      state = AsyncValue.data(_allTasks);
    }
  }

  Future<List<Task>> _loadPage(int page) async {
    final repository = ref.read(taskRepositoryProvider);
    _allTasks = await repository.fetchTasks(page: page);
    _page = page;
    return _allTasks;
  }
}
```

### Pattern 3: Optimistic Updates

```dart
Future<void> toggleTaskComplete(String taskId) async {
  final oldState = state.value;

  // Optimistically update UI
  state = AsyncValue.data(
    oldState!.map((task) {
      if (task.id == taskId) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }
      return task;
    }).toList(),
  );

  try {
    // Make API call
    final repository = ref.read(taskRepositoryProvider);
    await repository.toggleComplete(taskId);
  } catch (e) {
    // Revert on error
    state = AsyncValue.data(oldState);
    rethrow;
  }
}
```

### Pattern 4: Search/Filter

```dart
@riverpod
class TaskList extends _$TaskList {
  String _searchQuery = '';
  String? _statusFilter;

  @override
  Future<List<Task>> build() async {
    return await _fetchTasks();
  }

  Future<void> search(String query) async {
    _searchQuery = query;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchTasks);
  }

  Future<void> filterByStatus(String? status) async {
    _statusFilter = status;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_fetchTasks);
  }

  Future<List<Task>> _fetchTasks() async {
    final repository = ref.read(taskRepositoryProvider);
    return await repository.fetchTasks(
      search: _searchQuery.isEmpty ? null : _searchQuery,
      status: _statusFilter,
    );
  }
}
```

---

## Troubleshooting

### Build Runner Errors

**Problem:** `Target of URI hasn't been generated`

**Solution:** Run code generation:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Authentication Errors

**Problem:** 401 errors on authenticated endpoints

**Solution:** Check if token is saved:
```dart
final storage = ref.read(authStorageProvider);
final token = await storage.getToken();
print('Token: $token');
```

### Freezed Model Errors

**Problem:** `Missing concrete implementations`

**Solution:** Make sure class is `sealed`:
```dart
@freezed
sealed class MyModel with _$MyModel { // ← sealed keyword
  const factory MyModel({...}) = _MyModel;
  factory MyModel.fromJson(Map<String, dynamic> json) => ...;
}
```

### Provider Not Found

**Problem:** `Undefined name 'myProvider'`

**Solution:**
1. Check if `.g.dart` file exists
2. Check if `part 'filename.g.dart'` is at the top
3. Run `dart run build_runner build`

### Network Errors in Dev

**Problem:** Getting `NetworkException` even though internet works

**Solution:** Check if dev API URL is correct in `environment_config.dart`

---

## Configuration

### Changing API Base URL

Edit `lib/core/config/environment_config.dart`:

```dart
static String get baseUrl {
  switch (AppFlavor.appFlavor) {
    case Flavor.dev:
      return 'https://your-dev-api.com';  // ← Update here
    case Flavor.prod:
      return 'https://your-prod-api.com'; // ← Update here
  }
}
```

### Changing Timeouts

In the same file:

```dart
static Duration get connectTimeout => const Duration(seconds: 30);
static Duration get receiveTimeout => const Duration(seconds: 30);
```

### Disabling Logging

Logging is automatically disabled in production. To disable in dev:

```dart
static bool get enableApiLogging {
  return false; // Set to false
}
```

---

## Need Help?

- **API not working?** Check error messages in logs
- **Build issues?** Run `flutter clean && flutter pub get`
- **Model errors?** Make sure to run `dart run build_runner build`
- **Authentication issues?** Verify token is being saved and attached

For more examples, look at existing features:
- `lib/features/auth/` - Complete authentication example
- `lib/features/task/` - CRUD operations example

---

**Last Updated:** January 2026
