import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/splash/splash_page.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/auth/register_page.dart';
import 'presentation/pages/auth/reset_password_page.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/user/profile_page.dart';
import 'presentation/pages/user/settings_page.dart';
import 'presentation/pages/user/notifications_page.dart';
import 'presentation/pages/user/payments_page.dart';
import 'presentation/pages/user/create_service_page.dart';
import 'presentation/pages/user/my_services_page.dart';
import 'presentation/pages/user/bookings_page.dart';
import 'presentation/pages/worker/search_workers_page.dart';
import 'presentation/pages/worker/worker_profile_page.dart';
import 'presentation/pages/service/service_detail_page.dart';
import 'presentation/pages/chat/chats_list_page.dart';
import 'presentation/pages/chat/chat_page.dart';

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashPage()),
    GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
    GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
    GoRoute(path: '/reset-password', builder: (_, __) => const ResetPasswordPage()),
    GoRoute(path: '/home', builder: (_, __) => const HomePage()),
    GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
    GoRoute(path: '/notifications', builder: (_, __) => const NotificationsPage()),
    GoRoute(path: '/payments', builder: (_, __) => const PaymentsPage()),
    GoRoute(path: '/create-service', builder: (_, __) => const CreateServicePage()),
    GoRoute(path: '/my-services', builder: (_, __) => const MyServicesPage()),
    GoRoute(path: '/bookings', builder: (_, __) => const BookingsPage()),
    GoRoute(path: '/workers', builder: (_, __) => const SearchWorkersPage()),
    GoRoute(path: '/worker/:id', builder: (context, state) => WorkerProfilePage(workerId: state.pathParameters['id']!)),
    GoRoute(path: '/service/:id', builder: (context, state) => ServiceDetailPage(serviceId: state.pathParameters['id']!)),
    GoRoute(path: '/chats', builder: (_, __) => const ChatsListPage()),
    GoRoute(path: '/chat/:id', builder: (context, state) => ChatPage(chatId: state.pathParameters['id']!)),
  ],
);

class HommyApp extends StatelessWidget {
  const HommyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hommy',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
