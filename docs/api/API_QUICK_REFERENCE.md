# API Quick Reference

Quick copy-paste examples for common API tasks.

## Table of Contents

- [Creating a New Feature](#creating-a-new-feature)
- [Making API Calls](#making-api-calls)
- [Error Handling](#error-handling)
- [UI Integration](#ui-integration)
- [Common Commands](#common-commands)

---

## Creating a New Feature

### File Structure Template

```
lib/features/my_feature/
├── data/
│   ├── models/
│   │   └── my_model.dart
│   ├── services/
│   │   ├── my_service.dart
│   │   └── my_service_provider.dart
│   └── repositories/
│       ├── my_repository.dart
│       └── my_repository_provider.dart
└── ui/
    ├── providers/
    │   └── my_provider.dart
    └── screens/
        └── my_screen.dart
```

### 1. Model (Freezed)

```dart
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

### 2. Service

```dart
import 'package:homekru_owner/core/network/api_client.dart';
import '../models/my_model.dart';

class MyService {
  final ApiClient _apiClient;

  MyService(this._apiClient);

  Future<List<MyModel>> getAll() async {
    return await _apiClient.get<List<MyModel>>(
      '/endpoint',
      fromJson: (data) => (data as List)
          .map((json) => MyModel.fromJson(json))
          .toList(),
    );
  }

  Future<MyModel> getById(String id) async {
    return await _apiClient.get<MyModel>(
      '/endpoint/$id',
      fromJson: (data) => MyModel.fromJson(data),
    );
  }

  Future<MyModel> create(Map<String, dynamic> data) async {
    return await _apiClient.post<MyModel>(
      '/endpoint',
      data: data,
      fromJson: (data) => MyModel.fromJson(data),
    );
  }

  Future<MyModel> update(String id, Map<String, dynamic> data) async {
    return await _apiClient.put<MyModel>(
      '/endpoint/$id',
      data: data,
      fromJson: (data) => MyModel.fromJson(data),
    );
  }

  Future<void> delete(String id) async {
    await _apiClient.delete('/endpoint/$id');
  }
}
```

### 3. Service Provider

```dart
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

### 4. Repository

```dart
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

  Future<MyModel> fetchById(String id) async {
    try {
      return await _service.getById(id);
    } on ApiException catch (e) {
      Log.e('Failed to fetch item', error: e);
      rethrow;
    }
  }

  Future<MyModel> create({required String name, String? description}) async {
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

  Future<MyModel> update(String id, Map<String, dynamic> updates) async {
    try {
      return await _service.update(id, updates);
    } on ApiException catch (e) {
      Log.e('Failed to update item', error: e);
      rethrow;
    }
  }

  Future<void> remove(String id) async {
    try {
      await _service.delete(id);
    } on ApiException catch (e) {
      Log.e('Failed to delete item', error: e);
      rethrow;
    }
  }
}
```

### 5. Repository Provider

```dart
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

### 6. UI Provider

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/my_model.dart';
import '../../data/repositories/my_repository_provider.dart';

part 'my_provider.g.dart';

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
    await repository.create(name: name, description: description);
    await refresh();
  }

  Future<void> delete(String id) async {
    final repository = ref.read(myRepositoryProvider);
    await repository.remove(id);
    await refresh();
  }
}
```

### 7. UI Screen

```dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/my_provider.dart';

class MyScreen extends ConsumerWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(myListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Feature')),
      body: itemsAsync.when(
        data: (items) => RefreshIndicator(
          onRefresh: () => ref.read(myListProvider.notifier).refresh(),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text(item.description ?? ''),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await ref.read(myListProvider.notifier).delete(item.id);
                  },
                ),
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              ElevatedButton(
                onPressed: () => ref.invalidate(myListProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Show dialog to get input
          await ref.read(myListProvider.notifier).create(
            'New Item',
            'Description',
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

---

## Making API Calls

### GET - Single Item

```dart
Future<User> getUser(String id) async {
  return await _apiClient.get<User>(
    '/users/$id',
    fromJson: (data) => User.fromJson(data),
  );
}
```

### GET - List

```dart
Future<List<User>> getUsers() async {
  return await _apiClient.get<List<User>>(
    '/users',
    fromJson: (data) => (data as List)
        .map((json) => User.fromJson(json))
        .toList(),
  );
}
```

### GET - With Query Parameters

```dart
Future<List<Task>> getTasks({String? status, int? page}) async {
  return await _apiClient.get<List<Task>>(
    '/tasks',
    queryParameters: {
      if (status != null) 'status': status,
      if (page != null) 'page': page,
    },
    fromJson: (data) => (data as List)
        .map((json) => Task.fromJson(json))
        .toList(),
  );
}
```

### POST - Create

```dart
Future<Task> createTask(CreateTaskRequest request) async {
  return await _apiClient.post<Task>(
    '/tasks',
    data: request.toJson(),
    fromJson: (data) => Task.fromJson(data),
  );
}
```

### PUT - Update

```dart
Future<Task> updateTask(String id, Map<String, dynamic> updates) async {
  return await _apiClient.put<Task>(
    '/tasks/$id',
    data: updates,
    fromJson: (data) => Task.fromJson(data),
  );
}
```

### PATCH - Partial Update

```dart
Future<Task> patchTask(String id, Map<String, dynamic> updates) async {
  return await _apiClient.patch<Task>(
    '/tasks/$id',
    data: updates,
    fromJson: (data) => Task.fromJson(data),
  );
}
```

### DELETE

```dart
Future<void> deleteTask(String id) async {
  await _apiClient.delete('/tasks/$id');
}
```

### Public Endpoint (No Auth)

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

### File Upload

```dart
Future<UploadResponse> uploadFile(File file) async {
  final formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(file.path),
  });

  return await _apiClient.post<UploadResponse>(
    '/upload',
    data: formData,
    fromJson: (data) => UploadResponse.fromJson(data),
  );
}
```

---

## Error Handling

### Basic Try-Catch

```dart
try {
  final result = await repository.someMethod();
  showSuccess('Success!');
} on NetworkException {
  showError('Check your internet connection');
} on UnauthorizedException {
  showError('Please login again');
  navigateToLogin();
} on ClientException catch (e) {
  showError(e.message);
} on ServerException {
  showError('Server error. Please try again later.');
} on ApiException catch (e) {
  showError(e.message);
} catch (e) {
  showError('An unexpected error occurred');
}
```

### In UI with AsyncValue

```dart
return dataAsync.when(
  data: (data) => SuccessView(data),
  loading: () => LoadingView(),
  error: (error, stack) {
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
```

### Show Snackbar on Error

```dart
void handleError(Object error) {
  String message;

  if (error is NetworkException) {
    message = 'Check your internet connection';
  } else if (error is UnauthorizedException) {
    message = 'Please login again';
    // Navigate to login
  } else if (error is ClientException) {
    message = error.message;
  } else if (error is ServerException) {
    message = 'Server error. Please try again later.';
  } else {
    message = 'An error occurred';
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
```

---

## UI Integration

### Simple List Screen

```dart
class MyListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(myListProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Items')),
      body: itemsAsync.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(items[index].name),
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorView(error),
      ),
    );
  }
}
```

### List with Pull-to-Refresh

```dart
body: itemsAsync.when(
  data: (items) => RefreshIndicator(
    onRefresh: () => ref.read(myListProvider.notifier).refresh(),
    child: ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(items[index].name),
      ),
    ),
  ),
  loading: () => Center(child: CircularProgressIndicator()),
  error: (error, stack) => ErrorView(error),
),
```

### Form Submission

```dart
Future<void> handleSubmit() async {
  if (!formKey.currentState!.validate()) return;

  try {
    await ref.read(myProvider.notifier).create(
      name: nameController.text,
      description: descriptionController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Created successfully!')),
    );

    Navigator.pop(context);
  } catch (e) {
    handleError(e);
  }
}
```

### Delete with Confirmation

```dart
Future<void> handleDelete(String id) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Confirm Delete'),
      content: Text('Are you sure you want to delete this item?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Delete'),
        ),
      ],
    ),
  );

  if (confirmed == true) {
    try {
      await ref.read(myListProvider.notifier).delete(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deleted successfully')),
      );
    } catch (e) {
      handleError(e);
    }
  }
}
```

### Search

```dart
@riverpod
class MySearchableList extends _$MySearchableList {
  String _query = '';

  @override
  Future<List<MyModel>> build() async {
    return await _search();
  }

  Future<void> search(String query) async {
    _query = query;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_search);
  }

  Future<List<MyModel>> _search() async {
    final repository = ref.read(myRepositoryProvider);
    return await repository.search(_query);
  }
}

// In UI
TextField(
  onChanged: (value) {
    ref.read(mySearchableListProvider.notifier).search(value);
  },
  decoration: InputDecoration(
    hintText: 'Search...',
    prefixIcon: Icon(Icons.search),
  ),
),
```

---

## Common Commands

### Run Code Generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Watch Mode (Auto-regenerate)

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Clean Generated Files

```bash
dart run build_runner clean
```

### Analyze Code

```bash
flutter analyze
```

### Get Dependencies

```bash
flutter pub get
```

### Full Rebuild

```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

---

## Checklist for New Feature

- [ ] Create model with `@freezed` and `sealed class`
- [ ] Add `part 'filename.freezed.dart'` and `.g.dart`
- [ ] Create service with API methods
- [ ] Create service provider
- [ ] Create repository with validation
- [ ] Create repository provider
- [ ] Create UI provider with AsyncNotifier
- [ ] Run `dart run build_runner build`
- [ ] Create UI screen using `ConsumerWidget`
- [ ] Test error handling
- [ ] Test with no internet
- [ ] Test with invalid data

---

## Tips

1. **Always run code generation** after creating/modifying models or providers
2. **Use `sealed class`** for Freezed 3.x models
3. **Keep services simple** - just API calls, no logic
4. **Put validation in repositories** - not in services or UI
5. **Log errors** in repositories with `Log.e()`
6. **Use `AsyncValue.when()`** in UI for clean error handling
7. **Always set `requiresAuth: false`** for public endpoints
8. **Use `ref.watch()`** for reactive data, `ref.read()` for one-time reads

---

**Quick Access:**
- [Full Developer Guide](./API_DEVELOPER_GUIDE.md)
- [Architecture Details](../API_IMPLEMENTATION_SUMMARY.md)
