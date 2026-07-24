import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const Scaffold(
        backgroundColor: Color(0xFF060913),
        body: Center(
          child: Text(
            'MAIN MENU / HOME PLACEHOLDER\n(Awaiting User Approval of Login Screen)',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF00F0FF), fontFamily: 'Orbitron', fontSize: 18),
          ),
        ),
      ),
    ),
  ],
);
