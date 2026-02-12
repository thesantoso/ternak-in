# Ternak In - Architecture Documentation

## System Architecture

### Clean Architecture Layers

```
┌─────────────────────────────────────────────────────────────┐
│                        Presentation Layer                    │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐            │
│  │  Dashboard │  │ Analytics  │  │    Chat    │  Profile   │
│  │   Feature  │  │  Feature   │  │  Feature   │  Feature   │
│  │            │  │            │  │            │            │
│  │ - View     │  │ - View     │  │ - View     │  - View    │
│  │ - Controller│  │ - Controller│  │ - Controller│- Controller│
│  │ - Binding  │  │ - Binding  │  │ - Binding  │  - Binding │
│  └────────────┘  └────────────┘  └────────────┘            │
└─────────────────────────────────────────────────────────────┘
                           ↕
┌─────────────────────────────────────────────────────────────┐
│                         Data Layer                           │
│  ┌──────────────────────────────────────────────────────┐   │
│  │                    API Service                        │   │
│  │  - getLivestockData()                                │   │
│  │  - getAnalyticsData()                                │   │
│  │  - getUserProfile()                                  │   │
│  │  - getChatMessages()                                 │   │
│  │  - sendChatMessage()                                 │   │
│  └──────────────────────────────────────────────────────┘   │
│                           ↕                                  │
│  ┌──────────────────────────────────────────────────────┐   │
│  │                     Models                            │   │
│  │  - UserModel                                         │   │
│  │  - LivestockModel                                    │   │
│  │  - AnalyticsDataModel                                │   │
│  │  - ChatMessageModel                                  │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                           ↕
┌─────────────────────────────────────────────────────────────┐
│                         Core Layer                           │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐            │
│  │  Network   │  │   Storage  │  │   Error    │            │
│  │            │  │            │  │  Handling  │            │
│  │ DioClient  │  │  Storage   │  │  Error     │            │
│  │            │  │  Service   │  │  Handler   │            │
│  └────────────┘  └────────────┘  └────────────┘            │
│  ┌────────────┐  ┌────────────┐                            │
│  │ Constants  │  │   Themes   │                            │
│  │            │  │            │                            │
│  │ App        │  │   App      │                            │
│  │ Constants  │  │   Theme    │                            │
│  └────────────┘  └────────────┘                            │
└─────────────────────────────────────────────────────────────┘
```

## Data Flow

### Request Flow (User Action → API → UI Update)

```
User Interaction
      ↓
┌─────────────┐
│    View     │ (Obx Widget)
└─────────────┘
      ↓
┌─────────────┐
│ Controller  │ (GetX Controller)
│             │
│ - Validates │
│ - Updates   │
│   loading   │
└─────────────┘
      ↓
┌─────────────┐
│ API Service │
│             │
│ - Simulates │
│   delay     │
│ - Returns   │
│   mock data │
└─────────────┘
      ↓
┌─────────────┐
│ Controller  │
│             │
│ - Processes │
│   response  │
│ - Updates   │
│   state     │
└─────────────┘
      ↓
┌─────────────┐
│    View     │ (Auto rebuilds via Obx)
│             │
│ - Displays  │
│   data      │
└─────────────┘
```

### Error Handling Flow

```
Network Error
      ↓
┌─────────────┐
│ DioClient   │
│             │
│ - Catches   │
│   exception │
│ - Transforms│
│   to custom │
│   exception │
└─────────────┘
      ↓
┌─────────────┐
│ Controller  │
│             │
│ - Catches   │
│   in try/   │
│   catch     │
└─────────────┘
      ↓
┌─────────────┐
│ErrorHandler │
│             │
│ - Extracts  │
│   message   │
│ - Shows     │
│   snackbar  │
└─────────────┘
```

## Feature Structure

Each feature follows this consistent pattern:

```
features/
└── [feature_name]/
    ├── bindings/
    │   └── [feature]_binding.dart
    │       - Registers controller with GetX
    │       - Lazy initialization
    │
    ├── controllers/
    │   └── [feature]_controller.dart
    │       - Business logic
    │       - State management
    │       - API calls
    │       - Error handling
    │
    └── views/
        └── [feature]_view.dart
            - UI components
            - Obx reactive widgets
            - User interactions
```

## State Management with GetX

### Controller Lifecycle

```
App Start
    ↓
┌────────────────┐
│ Binding Init   │
│                │
│ Get.lazyPut()  │
└────────────────┘
    ↓
┌────────────────┐
│ View Access    │
│                │
│ Controller     │
│ instantiated   │
└────────────────┘
    ↓
┌────────────────┐
│ onInit()       │
│                │
│ - Load data    │
│ - Setup state  │
└────────────────┘
    ↓
┌────────────────┐
│ Active State   │
│                │
│ - User         │
│   interactions │
│ - State updates│
└────────────────┘
    ↓
┌────────────────┐
│ onClose()      │
│                │
│ - Cleanup      │
│ - Dispose      │
└────────────────┘
```

### Reactive Updates

```
State Change
    ↓
RxList/RxBool/etc updated
    ↓
Obx widget detects change
    ↓
Widget rebuilds automatically
```

## Navigation Architecture

```
MainNavigationView
    │
    ├── BottomAppBar
    │   ├── Dashboard Tab
    │   ├── Analytics Tab
    │   ├── [FAB Space]
    │   ├── Chat Tab
    │   └── Profile Tab
    │
    ├── FloatingActionButton (Center)
    │
    └── Body (Obx)
        └── _pages[currentIndex]
            ├── DashboardView
            ├── AnalyticsView
            ├── ChatView
            └── ProfileView
```

## Dependency Injection

```
main()
  ↓
initDependencies()
  ↓
  ├── StorageService (singleton)
  ├── DioClient (singleton)
  ├── ApiService (singleton)
  │
  └── Feature Bindings
      ├── DashboardBinding
      ├── AnalyticsBinding
      ├── ChatBinding
      └── ProfileBinding
```

## Network Layer

### Dio Client Configuration

```
DioClient
  │
  ├── Base Configuration
  │   ├── baseUrl: api.ternakin.com/api/v1
  │   ├── connectTimeout: 30s
  │   ├── receiveTimeout: 30s
  │   └── headers: JSON
  │
  ├── Interceptors
  │   ├── Request Interceptor
  │   │   ├── Add auth token
  │   │   └── Log request
  │   │
  │   ├── Response Interceptor
  │   │   └── Log response
  │   │
  │   ├── Error Interceptor
  │   │   ├── Transform errors
  │   │   ├── Handle status codes
  │   │   └── Create custom exceptions
  │   │
  │   └── Logging Interceptor
  │       └── Detailed logs
  │
  └── Methods
      ├── get()
      ├── post()
      ├── put()
      └── delete()
```

## Storage Layer

```
SharedPreferences
      ↕
StorageService
  │
  ├── Token Management
  │   ├── saveToken()
  │   ├── getToken()
  │   └── removeToken()
  │
  ├── User Data
  │   ├── saveUserId()
  │   ├── getUserId()
  │   ├── saveUserName()
  │   └── getUserName()
  │
  ├── Settings
  │   ├── saveThemeMode()
  │   └── getThemeMode()
  │
  └── Generic Methods
      ├── saveString/Int/Bool/Double()
      ├── getString/Int/Bool/Double()
      ├── remove()
      └── clear()
```

## Theme System

```
AppTheme
  │
  ├── Colors
  │   ├── Primary: #2E7D32 (Green)
  │   ├── Secondary: #66BB6A (Light Green)
  │   ├── Accent: #FF6F00 (Orange)
  │   ├── Background: #F5F5F5
  │   ├── Card: White
  │   └── Status Colors (Error, Success, Warning, Info)
  │
  ├── Typography (Google Fonts - Poppins)
  │   ├── Display styles (32-24px)
  │   ├── Headline styles (20px)
  │   ├── Title styles (18-16px)
  │   └── Body styles (16-12px)
  │
  └── Component Themes
      ├── AppBar
      ├── Card
      ├── Button
      ├── Input
      ├── FAB
      └── BottomNavigationBar
```

## UI Components Hierarchy

### Dashboard View
```
Scaffold
└── AppBar
└── Body (Obx)
    └── RefreshIndicator
        └── CustomScrollView
            ├── Summary Cards (Row)
            │   ├── Total Count Card
            │   └── Healthy Count Card
            │
            ├── Filter Chips (Horizontal Scroll)
            │   ├── All
            │   ├── Cattle
            │   ├── Goat
            │   ├── Chicken
            │   └── Sheep
            │
            └── Livestock List (SliverList)
                └── LivestockCard (foreach item)
                    ├── Avatar
                    ├── Title
                    ├── Count
                    ├── Health Badge
                    └── Last Checkup Date
```

### Analytics View
```
Scaffold
└── AppBar (with Period Selector)
└── Body (Obx)
    └── RefreshIndicator
        └── ListView
            ├── Header Section
            │
            ├── Metrics Grid (2x2)
            │   └── MetricCard (foreach metric)
            │       ├── Title
            │       ├── Value
            │       └── Trend Indicator
            │
            ├── Growth Trends Chart (placeholder)
            │
            └── Insights Card
                └── InsightItem (foreach insight)
```

### Chat View
```
Scaffold
└── AppBar
└── Column
    ├── Messages List (Expanded, Obx)
    │   └── ListView.builder
    │       └── MessageBubble (foreach message)
    │           ├── Avatar (left for support, right for user)
    │           ├── Message Container
    │           │   ├── Sender Name
    │           │   ├── Message Text
    │           │   └── Timestamp
    │           └── Rounded corners (dynamic based on sender)
    │
    └── Input Area (SafeArea)
        ├── TextField (message input)
        └── Send Button (CircleAvatar with icon)
```

### Profile View
```
Scaffold
└── AppBar
└── Body (Obx)
    └── RefreshIndicator
        └── ListView
            ├── Profile Header
            │   ├── Avatar (with camera button)
            │   ├── Name
            │   └── Role
            │
            ├── Account Information Card
            │   ├── Email Row
            │   ├── Phone Row
            │   └── User ID Row
            │
            ├── Actions Card
            │   ├── Edit Profile
            │   ├── Change Password
            │   ├── Notifications (with Switch)
            │   ├── Help & Support
            │   └── About
            │
            └── Logout Card (red themed)
```

## Performance Optimizations

1. **Lazy Loading**: Controllers initialized only when needed
2. **ListView.builder**: Efficient list rendering
3. **Obx Granularity**: Only affected widgets rebuild
4. **Image Optimization**: Asset optimization (when images added)
5. **Debouncing**: For search/filter operations (ready to implement)

## Security Considerations

1. **Token Storage**: Secure storage with SharedPreferences
2. **HTTPS**: Enforced in API client
3. **Input Validation**: In controllers before API calls
4. **Error Messages**: No sensitive info exposed
5. **Auth Interceptor**: Automatic token injection

## Scalability

The architecture supports:
- Adding new features (same structure)
- Switching to real API (update ApiService)
- Adding database (implement repository pattern)
- Adding authentication (extend DioClient)
- Multi-language support (intl package ready)
- Theming (theme system in place)

## Testing Strategy

```
Unit Tests
├── Controllers
│   ├── State changes
│   ├── API call handling
│   └── Error handling
│
├── Models
│   ├── JSON serialization
│   └── Data validation
│
└── Services
    ├── Storage operations
    └── API mocking

Widget Tests
├── View rendering
├── User interactions
├── Navigation
└── Reactive updates

Integration Tests
├── Full user flows
├── API integration
└── State persistence
```

This architecture provides a solid foundation for building a production-ready Flutter application with excellent maintainability, scalability, and testability.
