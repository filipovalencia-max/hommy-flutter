# Arquitectura Flutter - Hommy App

## 1. Visión General

Aplicación Flutter para móviles (iOS/Android) que refactoriza Web_Homyy manteniendo la misma base de datos Supabase.

## 2. Stack Tecnológico

| Componente | Tecnología |
|------------|------------|
| Framework | Flutter 3.x |
| Lenguaje | Dart 3.x |
| Estado | Riverpod 2.x |
| Backend | Supabase (misma DB) |
| Auth | Supabase Auth + Google OAuth |
| Realtime | Supabase Realtime |
| Navegación | GoRouter |
| UI | Material Design 3 |

## 3. Estructura de Proyecto

```
hommy_app/
├── lib/
│   ├── main.dart                 # Entry point
│   ├── app.dart                  # App configuration
│   ├── core/
│   │   ├── config/
│   │   │   └── supabase.dart     # Configuración Supabase
│   │   ├── constants/
│   │   │   ├── app_constants.dart
│   │   │   └── api_constants.dart
│   │   ├── theme/
│   │   │   ├── app_theme.dart
│   │   │   └── app_colors.dart
│   │   └── utils/
│   │       ├── extensions.dart
│   │       └── validators.dart
│   ├── data/
│   │   ├── models/
│   │   │   ├── user_model.dart
│   │   │   ├── worker_profile_model.dart
│   │   │   ├── service_model.dart
│   │   │   ├── booking_model.dart
│   │   │   ├── chat_model.dart
│   │   │   └── message_model.dart
│   │   ├── repositories/
│   │   │   ├── auth_repository.dart
│   │   │   ├── user_repository.dart
│   │   │   ├── service_repository.dart
│   │   │   ├── booking_repository.dart
│   │   │   └── chat_repository.dart
│   │   └── sources/
│   │       └── supabase_source.dart
│   ├── domain/
│   │   ├── entities/
│   │   │   └── ...
│   │   └── repositories/
│   │       └── (contratos)
│   ├── presentation/
│   │   ├── providers/
│   │   │   ├── auth_provider.dart
│   │   │   ├── user_provider.dart
│   │   │   ├── services_provider.dart
│   │   │   ├── chat_provider.dart
│   │   │   └── navigation_provider.dart
│   │   ├── pages/
│   │   │   ├── splash/
│   │   │   ├── auth/
│   │   │   │   ├── login_page.dart
│   │   │   │   ├── register_page.dart
│   │   │   │   └── reset_password_page.dart
│   │   │   ├── home/
│   │   │   │   └── home_page.dart
│   │   │   ├── user/
│   │   │   │   ├── profile_page.dart
│   │   │   │   ├── edit_profile_page.dart
│   │   │   │   ├── my_services_page.dart
│   │   │   │   ├── create_service_page.dart
│   │   │   │   ├── bookings_page.dart
│   │   │   │   ├── history_page.dart
│   │   │   │   └── notifications_page.dart
│   │   │   ├── worker/
│   │   │   │   ├── worker_profile_page.dart
│   │   │   │   ├── edit_worker_profile_page.dart
│   │   │   │   ├── search_workers_page.dart
│   │   │   │   ├── service_detail_page.dart
│   │   │   │   └── apply_page.dart
│   │   │   ├── chat/
│   │   │   │   ├── chats_list_page.dart
│   │   │   │   └── chat_page.dart
│   │   │   ├── admin/
│   │   │   │   └── admin_dashboard_page.dart
│   │   │   └── main_scaffold.dart
│   │   └── widgets/
│   │       ├── common/
│   │       │   ├── app_button.dart
│   │       │   ├── app_text_field.dart
│   │       │   ├── loading_widget.dart
│   │       │   └── error_widget.dart
│   │       ├── cards/
│   │       │   ├── service_card.dart
│   │       │   ├── worker_card.dart
│   │       │   ├── booking_card.dart
│   │       │   └── chat_preview_card.dart
│   │       └── dialogs/
│   └── services/
│       ├── auth_service.dart
│       ├── supabase_service.dart
│       └── notification_service.dart
├── assets/
│   └── images/
├── pubspec.yaml
└── README.md
```

## 4. Modelo de Datos (Flutter)

### UserModel
```dart
class UserModel {
  final String id;
  final String email;
  final String name;
  final String userType; // 'user' | 'worker'
  final String? phone;
  final DateTime? birthDate;
  final String? profilePictureUrl;
  final bool isActive;
  final double balance;
  final bool movilVerificado;
  final bool whatsappNotificationsEnabled;
}
```

### WorkerProfileModel
```dart
class WorkerProfileModel {
  final String id;
  final String userId;
  final String profession;
  final int experienceYears;
  final String? bio;
  final List<String> categories;
  final List<String> certifications;
  final double? hourlyRate;
  final double rating;
  final int totalServices;
  final bool isVerified;
  final bool isAvailable;
  final String? location;
}
```

### ServiceModel
```dart
class ServiceModel {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final String? categoryId;
  final String? location;
  final String status; // active, hired, in_progress, completed, cancelled
  final List<String> images;
  final String? completionPin;
  final double? escrowAmount;
  final double? workerFinalAmount;
  final String? workerId;
}
```

## 5. Gestión de Estado (Riverpod)

### Providers Principales

```dart
// Auth
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>

// User
final currentUserProvider = FutureProvider<UserModel?>
final userProfileProvider = FutureProvider.family<UserModel?, String>

// Worker
final workerProfileProvider = FutureProvider<WorkerProfileModel?>

// Services
final servicesProvider = FutureProvider<List<ServiceModel>>
final serviceDetailProvider = FutureProvider.family<ServiceModel?, String>

// Chat
final chatsProvider = StreamProvider<List<ChatModel>>
final messagesProvider = StreamProvider.family<List<MessageModel>, String>

// Bookings
final bookingsProvider = FutureProvider<List<BookingModel>>
```

## 6. Rutas de Navegación (GoRouter)

```dart
final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => SplashPage()),
    GoRoute(path: '/login', builder: (_, __) => LoginPage()),
    GoRoute(path: '/register', builder: (_, __) => RegisterPage()),
    GoRoute(path: '/home', builder: (_, __) => HomePage()),
    GoRoute(path: '/profile', builder: (_, __) => ProfilePage()),
    GoRoute(path: '/worker/:id', builder: (_, state) => WorkerProfilePage(id: state.pathParameters['id']!)),
    GoRoute(path: '/service/:id', builder: (_, state) => ServiceDetailPage(id: state.pathParameters['id']!)),
    GoRoute(path: '/chat/:id', builder: (_, state) => ChatPage(id: state.pathParameters['id']!)),
    // ... más rutas
  ],
)
```

## 7. Integración Supabase

### Cliente Supabase
```dart
final supabaseClient = SupabaseClient(
  'SUPABASE_URL',
  'SUPABASE_ANON_KEY',
);
```

### Tablas y对应aciones

| Tabla Supabase | Modelo Flutter |
|-----------------|----------------|
| profiles_v2 | UserModel |
| worker_profiles_v2 | WorkerProfileModel |
| services_v2 | ServiceModel |
| bookings_v2 | BookingModel |
| chats | ChatModel |
| chat_messages | MessageModel |

## 8. Autenticación

### Login Flow
1. Usuario ingresa email/password
2. Llama `supabase.auth.signInWithPassword()`
3. Guardar sesión en Riverpod
4. Redirigir a home

### Google OAuth
1. Usuario presiona "Google"
2. Llama `supabase.auth.signInWithOAuth(Google)`
3. Configurar redirect URL
4. Manejar callback

## 9. Realtime (Chat + Notificaciones)

### Suscripciones
```dart
// Chat messages
supabase.from('chat_messages').stream(pk: ['id']).listen(...)

// Notifications
supabase.from('notifications').stream(pk: ['id']).listen(...)
```

## 10. Seguridad

- Nunca hardcodear secretos
- Usar environment variables
- Row Level Security (RLS) de Supabase
- Validar datos en cliente y servidor

---

**Arquitecto**: Arquitecto de Solución  
**Fecha**: 2026-03-06  
**Estado**: Completado ✓
