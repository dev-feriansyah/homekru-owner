# Homekru Owner API Documentation

Welcome to the API documentation for the Homekru Owner Flutter application!

## 📚 Documentation Overview

We have three main documents to help you work with our API:

### 1. [API Developer Guide](./API_DEVELOPER_GUIDE.md) - **Start Here!**
**For:** New developers joining the project

**What's inside:**
- 📖 Complete guide to understanding the API architecture
- 🎯 Step-by-step tutorials for common tasks
- 💡 Best practices and design patterns
- 🐛 Troubleshooting guide
- 📝 Detailed explanations with context

**Read this if you:**
- Are new to the project
- Want to understand how things work
- Need detailed explanations
- Are learning the architecture

---

### 2. [API Quick Reference](./API_QUICK_REFERENCE.md) - **Quick Copy-Paste**
**For:** Developers who know the basics and need quick examples

**What's inside:**
- ⚡ Ready-to-use code templates
- 📋 Copy-paste examples for common tasks
- 🔧 Common commands cheatsheet
- ✅ Feature creation checklist

**Use this when you:**
- Need to create a new feature quickly
- Want to copy a working example
- Need a quick reminder of syntax
- Are looking for a specific code snippet

---

### 3. [API Implementation Summary](../API_IMPLEMENTATION_SUMMARY.md) - **Technical Overview**
**For:** Technical leads, architects, or anyone reviewing the implementation

**What's inside:**
- 📁 Complete file structure
- 🏗️ Architecture decisions
- ✅ Implementation checklist
- 🔄 Next steps and future enhancements

**Read this if you:**
- Need to review the implementation
- Want to understand design decisions
- Are planning future features
- Need a high-level overview

---

## 🚀 Quick Start

### For New Developers

1. **First, read:** [API Developer Guide](./API_DEVELOPER_GUIDE.md) - Overview section
2. **Then, try:** Follow the "Quick Start" section to make your first API call
3. **Keep handy:** Bookmark [Quick Reference](./API_QUICK_REFERENCE.md) for daily use

### For Experienced Developers

1. **Jump to:** [Quick Reference](./API_QUICK_REFERENCE.md)
2. **Copy template:** Use the file structure and code templates
3. **Run:** `dart run build_runner build --delete-conflicting-outputs`
4. **Done!** Your feature is ready

---

## 📖 What You'll Learn

### Understanding the Architecture

Our API follows a **clean architecture** pattern with clear layers:

```
UI → UI Provider → Repository → Service → ApiClient
```

Each layer has a specific responsibility:
- **UI**: Display data, handle user input
- **UI Provider**: Manage state (loading, error, data)
- **Repository**: Business logic, validation
- **Service**: Make API calls
- **ApiClient**: HTTP communication

### Creating Features

You'll learn how to:
1. ✅ Define data models with Freezed
2. ✅ Create services for API calls
3. ✅ Add business logic in repositories
4. ✅ Manage state with Riverpod
5. ✅ Handle errors gracefully
6. ✅ Integrate with UI

---

## 🔍 Find What You Need

### I want to...

**Understand how the API works**
→ Read [Developer Guide - Architecture](./API_DEVELOPER_GUIDE.md#architecture)

**Make my first API call**
→ Read [Developer Guide - Quick Start](./API_DEVELOPER_GUIDE.md#quick-start)

**Create a new feature**
→ Copy from [Quick Reference - Creating a New Feature](./API_QUICK_REFERENCE.md#creating-a-new-feature)

**Handle errors properly**
→ Read [Developer Guide - Error Handling](./API_DEVELOPER_GUIDE.md#error-handling)

**Implement authentication**
→ Read [Developer Guide - Authentication](./API_DEVELOPER_GUIDE.md#authentication)

**See code examples**
→ Browse [Quick Reference](./API_QUICK_REFERENCE.md)

**Understand design decisions**
→ Read [Implementation Summary - Design Decisions](../API_IMPLEMENTATION_SUMMARY.md#design-decisions)

**Troubleshoot issues**
→ Read [Developer Guide - Troubleshooting](./API_DEVELOPER_GUIDE.md#troubleshooting)

---

## 🛠️ Essential Commands

```bash
# Generate code after creating models/providers
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate)
dart run build_runner watch --delete-conflicting-outputs

# Check for errors
flutter analyze

# Full rebuild
flutter clean && flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

---

## 📋 Common Tasks

### Create a New Feature

1. Create model (Freezed)
2. Create service (API calls)
3. Create repository (business logic)
4. Create UI provider (state management)
5. Run code generation
6. Integrate with UI

**Detailed guide:** [Developer Guide - Creating New Features](./API_DEVELOPER_GUIDE.md#creating-new-features)

**Quick template:** [Quick Reference - File Structure](./API_QUICK_REFERENCE.md#file-structure-template)

### Handle Authentication

- Login → Token saved automatically
- Requests → Token attached automatically
- Logout → Token deleted automatically

**Details:** [Developer Guide - Authentication](./API_DEVELOPER_GUIDE.md#authentication)

### Handle Errors

Use try-catch with specific exceptions:

```dart
try {
  await repository.someMethod();
} on NetworkException {
  showError('Check your connection');
} on UnauthorizedException {
  navigateToLogin();
}
```

**Full guide:** [Developer Guide - Error Handling](./API_DEVELOPER_GUIDE.md#error-handling)

---

## 💡 Key Concepts

### Models (Freezed)
Immutable data classes with JSON serialization

```dart
@freezed
sealed class User with _$User {
  const factory User({
    required String id,
    required String name,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

### Services
Make API calls, no business logic

```dart
class UserService {
  Future<User> getUser() => _apiClient.get<User>('/user', ...);
}
```

### Repositories
Business logic, validation, error handling

```dart
class UserRepository {
  Future<User> updateName(String name) {
    if (name.isEmpty) throw ApiException('Name required');
    return _service.updateUser({'name': name});
  }
}
```

### UI Providers
State management with Riverpod

```dart
@riverpod
class UserData extends _$UserData {
  @override
  Future<User> build() async {
    return await ref.read(userRepositoryProvider).getCurrentUser();
  }
}
```

---

## 🎯 Best Practices

1. ✅ **Use type-safe models** - Always use Freezed models, not `Map<String, dynamic>`
2. ✅ **Validate in repositories** - Not in services or UI
3. ✅ **Keep services simple** - Just make API calls, no logic
4. ✅ **Use AsyncValue in UI** - For automatic loading/error handling
5. ✅ **Log errors** - Always log in repositories with `Log.e()`
6. ✅ **Set requiresAuth correctly** - `false` for login/signup, `true` for others

**Full list:** [Developer Guide - Best Practices](./API_DEVELOPER_GUIDE.md#best-practices)

---

## 🆘 Getting Help

### Something not working?

1. **Check for errors:** Run `flutter analyze`
2. **Regenerate code:** `dart run build_runner build --delete-conflicting-outputs`
3. **Clean and rebuild:** `flutter clean && flutter pub get`
4. **Read troubleshooting:** [Developer Guide - Troubleshooting](./API_DEVELOPER_GUIDE.md#troubleshooting)

### Common Issues

- **"Target of URI hasn't been generated"** → Run build_runner
- **401 errors on API calls** → Check if token is saved
- **"Undefined name provider"** → Check if `.g.dart` file exists
- **Freezed errors** → Make sure to use `sealed class`

---

## 📚 Additional Resources

- **Architecture Details:** [Implementation Summary](../API_IMPLEMENTATION_SUMMARY.md)
- **Existing Examples:**
  - Auth feature: `lib/features/auth/`
  - Task feature: `lib/features/task/`

---

## 🎓 Learning Path

### Day 1: Understanding
- Read [Developer Guide - Overview](./API_DEVELOPER_GUIDE.md#overview)
- Understand the architecture
- Review existing code in `lib/features/auth/`

### Day 2: Practice
- Follow [Quick Start](./API_DEVELOPER_GUIDE.md#quick-start)
- Make your first API call
- Run code generation

### Day 3: Build
- Create a simple feature using [Quick Reference](./API_QUICK_REFERENCE.md)
- Implement CRUD operations
- Add error handling

### Day 4: Master
- Study [Best Practices](./API_DEVELOPER_GUIDE.md#best-practices)
- Review [Common Patterns](./API_DEVELOPER_GUIDE.md#common-patterns)
- Help others!

---

## 📝 Feedback

Found something confusing? Want to improve the docs?

- Open an issue
- Submit a pull request
- Talk to the team

---

**Happy Coding! 🚀**

Last Updated: January 2026
