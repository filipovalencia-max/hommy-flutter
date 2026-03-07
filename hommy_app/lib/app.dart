import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/splash/splash_page.dart';
import 'presentation/pages/auth/login_page.dart';
import 'presentation/pages/auth/register_page.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/user/profile_page.dart';
import 'presentation/pages/user/bookings_page.dart';
import 'presentation/pages/user/create_service_page.dart';
import 'presentation/pages/worker/search_workers_page.dart';

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashPage()),
    GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
    GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
    GoRoute(path: '/home', builder: (_, __) => const HomePage()),
    GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
    GoRoute(path: '/bookings', builder: (_, __) => const BookingsPage()),
    GoRoute(path: '/create-service', builder: (_, __) => const CreateServicePage()),
    GoRoute(path: '/workers', builder: (_, __) => const SearchWorkersPage()),
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
