# API Architecture Diagram

Visual representation of the API layer architecture.

## 🏗️ Complete Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         USER INTERFACE                          │
│                                                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐        │
│  │ LoginScreen  │  │ TaskScreen   │  │ ProfileScreen│        │
│  │ (UI Widget)  │  │ (UI Widget)  │  │ (UI Widget)  │        │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘        │
│         │                  │                  │                 │
│         │ ref.watch()      │ ref.watch()      │ ref.watch()    │
│         ▼                  ▼                  ▼                 │
└─────────────────────────────────────────────────────────────────┘
          │                  │                  │
          │                  │                  │
┌─────────────────────────────────────────────────────────────────┐
│                      UI PROVIDER LAYER                          │
│                    (State Management)                           │
│                                                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐        │
│  │ AuthProvider │  │ TaskList     │  │ ProfileData  │        │
│  │ (AsyncNotif) │  │ Provider     │  │ Provider     │        │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘        │
│         │                  │                  │                 │
│         │ ref.read()       │ ref.read()       │ ref.read()     │
│         ▼                  ▼                  ▼                 │
└─────────────────────────────────────────────────────────────────┘
          │                  │                  │
          │                  │                  │
┌─────────────────────────────────────────────────────────────────┐
│                     REPOSITORY LAYER                            │
│                  (Business Logic & Validation)                  │
│                                                                 │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────┐ │
│  │ AuthRepository   │  │ TaskRepository   │  │ UserRepository│ │
│  │ • Validation     │  │ • Validation     │  │ • Validation  │ │
│  │ • Token mgmt     │  │ • Error handling │  │ • Caching     │ │
│  │ • Error transform│  │ • Business rules │  │ • Logic       │ │
│  └──────┬───────────┘  └──────┬───────────┘  └──────┬────────┘ │
│         │                      │                      │          │
│         ▼                      ▼                      ▼          │
└─────────────────────────────────────────────────────────────────┘
          │                      │                      │
          │                      │                      │
┌─────────────────────────────────────────────────────────────────┐
│                       SERVICE LAYER                             │
│                    (API Communication)                          │
│                                                                 │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────┐ │
│  │ AuthService      │  │ TaskService      │  │ UserService  │ │
│  │ • login()        │  │ • getTasks()     │  │ • getUser()  │ │
│  │ • signup()       │  │ • createTask()   │  │ • update()   │ │
│  │ • logout()       │  │ • deleteTask()   │  │ • delete()   │ │
│  └──────┬───────────┘  └──────┬───────────┘  └──────┬────────┘ │
│         │                      │                      │          │
│         │                      │                      │          │
│         └──────────────────────┴──────────────────────┘          │
│                                │                                 │
│                                ▼                                 │
└─────────────────────────────────────────────────────────────────┘
                                 │
                                 │
┌─────────────────────────────────────────────────────────────────┐
│                        API CLIENT LAYER                         │
│                       (HTTP Wrapper)                            │
│                                                                 │
│  ┌─────────────────────────────────────────────────────┐       │
│  │                    ApiClient                        │       │
│  │                                                     │       │
│  │  Generic Methods:                                  │       │
│  │  • get<T>(path, params)                           │       │
│  │  • post<T>(path, data)                            │       │
│  │  • put<T>(path, data)                             │       │
│  │  • delete(path)                                   │       │
│  │                                                     │       │
│  │  Interceptors:                                     │       │
│  │  ┌─────────────────┐  ┌────────────────────┐     │       │
│  │  │ AuthInterceptor │  │ LoggingInterceptor │     │       │
│  │  │ • Attach token  │  │ • Log requests    │     │       │
│  │  │ • Skip public   │  │ • Log responses   │     │       │
│  │  └─────────────────┘  └────────────────────┘     │       │
│  │                                                     │       │
│  │  Error Handling:                                   │       │
│  │  DioException → Custom Exceptions                 │       │
│  └─────────────────┬───────────────────────────────┘       │
│                    │                                         │
└─────────────────────────────────────────────────────────────────┘
                     │                    │
                     │                    │
          ┌──────────┴──────────┐    ┌───┴────────────┐
          │                     │    │                │
          ▼                     ▼    ▼                │
┌─────────────────┐   ┌──────────────────────┐      │
│  AuthStorage    │   │    Environment       │      │
│  (Encrypted)    │   │    Configuration     │      │
│                 │   │                      │      │
│ • FlutterSecure │   │ • Dev: api-dev.url  │      │
│   Storage       │   │ • Prod: api.url     │      │
│ • Save token    │   │ • Timeouts          │      │
│ • Get token     │   │ • Logging enabled   │      │
│ • Delete token  │   │                      │      │
└─────────────────┘   └──────────────────────┘      │
                                                      │
                      ┌───────────────────────────────┘
                      │
                      ▼
            ┌──────────────────┐
            │   Dio (HTTP)     │
            │                  │
            │ • Make requests  │
            │ • Handle timeout │
            │ • Retry logic    │
            └────────┬─────────┘
                     │
                     ▼
            ┌──────────────────┐
            │   Backend API    │
            │                  │
            │ • Process request│
            │ • Return data    │
            └──────────────────┘
```

---

## 🔄 Request Flow

### Authenticated Request (e.g., Get Tasks)

```
1. UI calls:
   final tasks = ref.watch(taskListProvider);

2. TaskListProvider executes:
   taskRepository.fetchAllTasks()

3. TaskRepository calls:
   taskService.getTasks()

4. TaskService calls:
   apiClient.get<List<Task>>('/tasks', requiresAuth: true)

5. ApiClient triggers AuthInterceptor:
   - Get token from AuthStorage
   - Attach: Authorization: Bearer {token}

6. ApiClient makes HTTP request via Dio:
   GET https://api.homekru.com/api/v1/tasks
   Headers: { Authorization: Bearer abc123... }

7. Backend processes request and returns data

8. Response flows back:
   Backend → Dio → ApiClient → TaskService →
   TaskRepository → TaskListProvider → UI

9. UI displays tasks
```

### Unauthenticated Request (e.g., Login)

```
1. User enters email/password

2. UI calls:
   ref.read(authProvider.notifier).login(email, password)

3. AuthProvider calls:
   authRepository.login(email, password)

4. AuthRepository:
   - Validates inputs
   - Calls: authService.login(LoginRequest(...))

5. AuthService calls:
   apiClient.post('/auth/login', requiresAuth: false)

6. ApiClient triggers AuthInterceptor:
   - Checks requiresAuth: false
   - Checks endpoint: /auth/login (public)
   - SKIPS token attachment

7. ApiClient makes HTTP request via Dio:
   POST https://api.homekru.com/api/v1/auth/login
   Body: { email: "user@email.com", password: "..." }
   (NO Authorization header)

8. Backend returns:
   { accessToken: "abc123", user: {...} }

9. Response flows back:
   Backend → Dio → ApiClient → AuthService → AuthRepository

10. AuthRepository saves token:
    authStorage.saveToken(response.accessToken)

11. AuthProvider updates state with user data

12. UI navigates to home screen
```

---

## 📦 Dependency Graph

```
UI Widget
    ↓ depends on
UI Provider (Riverpod)
    ↓ depends on
Repository
    ↓ depends on
Service
    ↓ depends on
ApiClient
    ├─ depends on → AuthStorage
    └─ depends on → Environment Config
```

**Key Point:** Each layer only depends on the layer directly below it!

---

## 🎯 Layer Boundaries

### ✅ ALLOWED Dependencies

```
UI → UI Provider ✓
UI Provider → Repository ✓
Repository → Service ✓
Service → ApiClient ✓
ApiClient → AuthStorage ✓
ApiClient → Dio ✓
```

### ❌ FORBIDDEN Dependencies

```
UI → Repository ✗ (Skip provider layer)
UI → Service ✗ (Too deep)
Repository → ApiClient ✗ (Skip service layer)
Repository → Dio ✗ (Must use service)
Service → AuthStorage ✗ (Use ApiClient)
UI Provider → Service ✗ (Must use repository)
```

---

## 🔐 Authentication Flow

```
┌─────────────────────────────────────────────────────────┐
│                    Login Flow                           │
└─────────────────────────────────────────────────────────┘

User Input (email, password)
        ↓
    AuthProvider.login()
        ↓
    AuthRepository.login()
        ├─ Validate email/password
        └─ Call AuthService.login()
                ↓
        ApiClient.post('/auth/login', requiresAuth: false)
                ↓
        AuthInterceptor checks:
        ├─ requiresAuth? NO
        ├─ Public endpoint? YES (/auth/login)
        └─ Skip token attachment
                ↓
        HTTP POST to /auth/login
        (No Authorization header)
                ↓
        Backend responds:
        { accessToken: "...", user: {...} }
                ↓
        AuthRepository.saveToken()
                ↓
        AuthStorage.saveToken() (Encrypted)
                ↓
        Token stored securely
                ↓
        User logged in ✓


┌─────────────────────────────────────────────────────────┐
│              Authenticated Request Flow                 │
└─────────────────────────────────────────────────────────┘

User views Task List
        ↓
    TaskListProvider.build()
        ↓
    TaskRepository.fetchAllTasks()
        ↓
    TaskService.getTasks()
        ↓
    ApiClient.get('/tasks', requiresAuth: true)
        ↓
    AuthInterceptor checks:
    ├─ requiresAuth? YES
    ├─ Public endpoint? NO
    └─ Attach token
        ├─ Get: AuthStorage.getToken()
        └─ Add header: Authorization: Bearer {token}
                ↓
        HTTP GET to /tasks
        (WITH Authorization header)
                ↓
        Backend validates token
                ↓
        Backend responds with tasks
                ↓
        Tasks displayed to user ✓


┌─────────────────────────────────────────────────────────┐
│                   Logout Flow                           │
└─────────────────────────────────────────────────────────┘

User taps Logout
        ↓
    AuthProvider.logout()
        ↓
    AuthRepository.logout()
        ├─ Call AuthService.logout() (optional)
        └─ Delete token
                ↓
        AuthStorage.deleteToken()
                ↓
        Token removed from storage
                ↓
        AuthProvider clears state
                ↓
        User redirected to Login ✓
```

---

## 🔄 Error Flow

```
Backend Error (e.g., 404)
        ↓
    Dio throws DioException
        ↓
    ApiClient._handleError()
        ├─ Check error.type
        ├─ Check statusCode
        └─ Transform to custom exception
                ↓
    Throw ClientException("Not found")
        ↓
    Service catches (or lets bubble)
        ↓
    Repository catches
        ├─ Log.e('Error', error: e)
        └─ Rethrow or transform
                ↓
    UI Provider catches
        ├─ state = AsyncValue.error(e)
        └─ UI shows error
                ↓
    UI.when(error: ...)
        ├─ Check error type
        └─ Show appropriate message
                ↓
    User sees friendly error message
```

---

## 📁 File Organization

```
lib/
├── core/
│   ├── config/
│   │   └── environment_config.dart          [Environment settings]
│   ├── network/
│   │   ├── api_client.dart                  [HTTP wrapper]
│   │   ├── api_provider.dart                [ApiClient provider]
│   │   ├── interceptors/
│   │   │   ├── auth_interceptor.dart        [Token attachment]
│   │   │   └── logging_interceptor.dart     [Request logging]
│   │   └── exceptions/
│   │       ├── api_exception.dart           [Base exception]
│   │       ├── network_exception.dart       [Connection errors]
│   │       ├── server_exception.dart        [5xx errors]
│   │       ├── client_exception.dart        [4xx errors]
│   │       └── unauthorized_exception.dart  [401 errors]
│   └── storage/
│       ├── auth_storage.dart                [Storage interface]
│       ├── auth_storage_impl.dart           [Implementation]
│       └── auth_storage_provider.dart       [Provider]
│
└── features/
    └── {feature_name}/
        ├── data/
        │   ├── models/                       [Freezed models]
        │   │   ├── {model}.dart
        │   │   ├── {model}.freezed.dart     [Generated]
        │   │   └── {model}.g.dart           [Generated]
        │   ├── services/                     [API calls]
        │   │   ├── {feature}_service.dart
        │   │   ├── {feature}_service_provider.dart
        │   │   └── {feature}_service_provider.g.dart [Generated]
        │   └── repositories/                 [Business logic]
        │       ├── {feature}_repository.dart
        │       ├── {feature}_repository_provider.dart
        │       └── {feature}_repository_provider.g.dart [Generated]
        └── ui/
            ├── providers/                    [State management]
            │   ├── {feature}_provider.dart
            │   └── {feature}_provider.g.dart [Generated]
            └── screens/                      [UI widgets]
                └── {feature}_screen.dart
```

---

## 🎨 Color Legend

```
🟦 BLUE   = User Interface Layer (UI Widgets)
🟩 GREEN  = State Management Layer (Riverpod Providers)
🟨 YELLOW = Business Logic Layer (Repositories)
🟧 ORANGE = API Communication Layer (Services)
🟥 RED    = HTTP Layer (ApiClient, Dio)
⬛ BLACK  = Infrastructure (Storage, Config)
```

---

## 📊 Data Flow Summary

```
Request:  UI → Provider → Repository → Service → ApiClient → Dio → Backend
Response: Backend → Dio → ApiClient → Service → Repository → Provider → UI
```

**Each layer transforms data:**
- **UI**: User actions → Function calls
- **Provider**: Function calls → Repository calls + State management
- **Repository**: Requests → Validated requests + Error handling
- **Service**: Validated requests → API calls + Response mapping
- **ApiClient**: API calls → HTTP requests + Error transformation
- **Dio**: HTTP requests → Network requests

---

## 🔑 Key Design Principles

1. **Single Responsibility**: Each layer has ONE job
2. **Dependency Direction**: Always flows downward, never up
3. **Interface Segregation**: Layers depend on interfaces, not implementations
4. **Error Boundaries**: Each layer handles its own type of errors
5. **Testability**: Each layer can be tested independently
6. **Scalability**: Easy to add new features without touching existing code

---

**Last Updated:** January 2026
