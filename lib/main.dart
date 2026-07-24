import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/routes/app_router.dart';
import 'core/services/service_locator.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Force Fullscreen Immersive Sticky Mode & Landscape Orientation Lock for AAA Game Mode
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Setup Service Locator (GetIt Dependency Injection)
  setupServiceLocator();

  runApp(const SkyRushApp());
}

class SkyRushApp extends StatelessWidget {
  const SkyRushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SKYRUSH: NEON ESCAPE',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
