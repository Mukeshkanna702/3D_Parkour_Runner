import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/cyber_particles.dart';

class SplashBackgroundCanvas extends StatefulWidget {
  const SplashBackgroundCanvas({super.key});

  @override
  State<SplashBackgroundCanvas> createState() => _SplashBackgroundCanvasState();
}

class _SplashBackgroundCanvasState extends State<SplashBackgroundCanvas> with SingleTickerProviderStateMixin {
  late AnimationController _cameraController;

  @override
  void initState() {
    super.initState();
    _cameraController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _cameraController,
      builder: (context, child) {
        // Slow cinematic camera push-in & slight pan
        final double scale = 1.0 + (_cameraController.value * 0.04);
        final double panX = (_cameraController.value - 0.5) * 15.0;

        return Stack(
          fit: StackFit.expand,
          children: [
            // 1. AAA Hero Image Canvas with Camera Motion
            Transform.translate(
              offset: Offset(panX, 0),
              child: Transform.scale(
                scale: scale,
                child: Image.asset(
                  AppConstants.imgAAAHero,
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                ),
              ),
            ),

            // 2. Volumetric Rain & Blue Neon Lighting Gradients
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x99060913),
                    Color(0x33060913),
                    Color(0xEE060913),
                  ],
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topRight,
                  radius: 1.2,
                  colors: [
                    AppColors.neonBlue.withValues(alpha: 0.15),
                    Colors.transparent,
                    AppColors.neonPink.withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),

            // 3. 60 FPS Rainy Particle Overlay
            const CyberParticlesBackground(child: SizedBox.shrink()),
          ],
        );
      },
    );
  }
}
