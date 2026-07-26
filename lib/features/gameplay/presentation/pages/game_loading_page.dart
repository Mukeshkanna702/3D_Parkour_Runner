import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../splash/presentation/widgets/splash_background_canvas.dart';

class GameLoadingPage extends StatefulWidget {
  const GameLoadingPage({super.key});

  @override
  State<GameLoadingPage> createState() => _GameLoadingPageState();
}

class _GameLoadingPageState extends State<GameLoadingPage> {
  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {
        _progress += 0.02;
        if (_progress >= 1.0) {
          _progress = 1.0;
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              context.go(AppRoutes.intro);
            }
          });
        }
      });
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
          // 1. Cinematic Background
          const SplashBackgroundCanvas(),

          // 2. Loading Briefing Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'MISSION BRIEFING',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.0,
                      color: AppColors.neonBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'MAP: NEO TOKYO 2099 // SPIRE 09',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'OBJECTIVE: Reach the extraction point before NEXUS AI locks down the rooftop perimeter.',
                    style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 11,
                      color: AppColors.textMain.withValues(alpha: 0.9),
                    ),
                  ),

                  const Spacer(),

                  // Loading Tip
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.bgCard.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderNeon, width: 0.8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.lightbulb_outline, color: AppColors.neonYellow, size: 16),
                        SizedBox(width: 10),
                        Text(
                          'TACTICAL TIP: Double-tap Jump to perform Anti-Gravity High Vault across mag-rail gaps.',
                          style: TextStyle(
                            fontFamily: 'SpaceGrotesk',
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Progress Meter
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'COMPILING SHADERS & LUMEN GI...',
                            style: TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: AppColors.neonBlue,
                            ),
                          ),
                          Text(
                            '${(_progress * 100).toInt()}%',
                            style: const TextStyle(
                              fontFamily: 'Orbitron',
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: AppColors.neonBlue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: _progress,
                          minHeight: 8,
                          backgroundColor: Colors.black.withValues(alpha: 0.6),
                          color: AppColors.neonBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
