import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';

class SplashLogoReveal extends StatelessWidget {
  const SplashLogoReveal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // AAA Game Studio / Engine Telemetry Badge
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.neonBlue.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.6), width: 1),
              ),
              child: const Row(
                children: [
                  Icon(Icons.bolt, color: AppColors.neonBlue, size: 14),
                  SizedBox(width: 6),
                  Text(
                    'AAA CONSOLE QUALITY // 4K LUMEN',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                      color: AppColors.neonBlue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideX(begin: -0.2, end: 0.0, curve: Curves.easeOutCubic),

        const SizedBox(height: 12),

        // AAA Title Logo - SKYRUSH (Metallic Bevel Shader + Blue Energy Pulse)
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Color(0xFFB3F5FF), AppColors.neonBlue, Color(0xFF007799)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds),
          child: const Text(
            'SKYRUSH',
            style: TextStyle(
              fontFamily: 'Orbitron',
              fontSize: 58,
              fontWeight: FontWeight.w900,
              letterSpacing: 10.0,
              height: 1.0,
              color: Colors.white,
              shadows: [
                Shadow(color: AppColors.neonBlue, blurRadius: 40),
                Shadow(color: Colors.white, blurRadius: 10),
              ],
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 800.ms)
            .slideX(begin: -0.3, end: 0.0, curve: Curves.easeOutCubic)
            .shimmer(delay: 1.seconds, duration: 2.seconds, color: AppColors.neonBlue),

        const SizedBox(height: 6),

        // Subtitle Badge - NEON ESCAPE
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.neonPink.withValues(alpha: 0.35),
                    AppColors.neonPurple.withValues(alpha: 0.25),
                  ],
                ),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.neonPink, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neonPink.withValues(alpha: 0.5),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Text(
                'NEON ESCAPE',
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 7.0,
                  color: AppColors.neonPink,
                ),
              ),
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 300.ms, duration: 800.ms)
            .slideX(begin: -0.2, end: 0.0, curve: Curves.easeOutCubic),

        const SizedBox(height: 12),

        // Tagline - RUN BEYOND REALITY
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 3.5,
              height: 18,
              color: AppColors.neonOrange,
            ),
            const SizedBox(width: 10),
            Text(
              'RUN BEYOND REALITY',
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 4.0,
                color: AppColors.textMain.withValues(alpha: 0.95),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 600.ms, duration: 800.ms),
      ],
    );
  }
}
