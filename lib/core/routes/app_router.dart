import 'package:go_router/go_router.dart';
import '../../features/gameplay/presentation/pages/game_intro_page.dart';
import '../../features/gameplay/presentation/pages/game_loading_page.dart';
import '../../features/gameplay/presentation/pages/gameplay_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String loading = '/loading';
  static const String intro = '/intro';
  static const String gameplay = '/gameplay';
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
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.loading,
      builder: (context, state) => const GameLoadingPage(),
    ),
    GoRoute(
      path: AppRoutes.intro,
      builder: (context, state) => const GameIntroPage(),
    ),
    GoRoute(
      path: AppRoutes.gameplay,
      builder: (context, state) => const GameplayPage(),
    ),
  ],
);
