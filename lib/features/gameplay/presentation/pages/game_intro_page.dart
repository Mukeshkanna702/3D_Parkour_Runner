import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../splash/presentation/widgets/splash_background_canvas.dart';

class GameIntroPage extends StatefulWidget {
  const GameIntroPage({super.key});

  @override
  State<GameIntroPage> createState() => _GameIntroPageState();
}

class _GameIntroPageState extends State<GameIntroPage> {
  int _countdown = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
      } else {
        timer.cancel();
        context.go(AppRoutes.gameplay);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060913),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Cinematic Drone Camera Fly-Through
          const SplashBackgroundCanvas(),

          // 2. Mission Start & Countdown Overlay
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.neonPink,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'MISSION START',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3.0,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'REACH EXTRACTION POINT',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4.0,
                    color: Colors.white,
                    shadows: [Shadow(color: AppColors.neonBlue, blurRadius: 25)],
                  ),
                ),

                const SizedBox(height: 25),

                // Giant Animated Countdown Digit
                Text(
                  '$_countdown',
                  style: const TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    color: AppColors.neonBlue,
                    shadows: [
                      Shadow(color: AppColors.neonBlue, blurRadius: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
