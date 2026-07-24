import 'dart:math';
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
      duration: const Duration(seconds: 20),
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
        // Slow AAA CineCamera push-in & 3D Depth Parallax
        final double cameraScale = 1.02 + (_cameraController.value * 0.07);
        final double cameraOffsetX = sin(_cameraController.value * pi * 2) * 15.0;
        final double cameraOffsetY = cos(_cameraController.value * pi) * 8.0;

        return Stack(
          fit: StackFit.expand,
          children: [
            // 1. Hyper-Realistic AAA Photorealistic Protagonist & Rainy Cyberpunk Megacity Artwork
            Transform.translate(
              offset: Offset(cameraOffsetX, cameraOffsetY),
              child: Transform.scale(
                scale: cameraScale,
                child: Image.asset(
                  AppConstants.imgAAAHero,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                ),
              ),
            ),

            // 2. Ray-Traced Blue Neon & Orange Rim Light Reflections
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(-0.3, 0.2),
                  radius: 1.0,
                  colors: [
                    AppColors.neonBlue.withValues(alpha: 0.15),
                    Colors.transparent,
                    AppColors.bgPrimary.withValues(alpha: 0.85),
                  ],
                ),
              ),
            ),

            // 3. Volumetric Fog & Atmospheric Vignette (Landscape 16:9)
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xF5060913),
                    Color(0x77060913),
                    Colors.transparent,
                    Color(0xDD060913),
                  ],
                ),
              ),
            ),

            // 4. Dynamic Particle Physics Engine (Continuous Rain, Lightning, Energy Sparks)
            const CyberParticlesBackground(child: SizedBox.expand()),

            // 5. Cinematic Tactical HUD Telemetry Border
            Positioned(
              left: 30,
              top: 25,
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.neonRed,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: AppColors.neonRed, blurRadius: 10, spreadRadius: 2),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'CINE_CAM // UNREAL ENGINE 5.4 // 60 FPS LUMEN',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                      color: AppColors.neonBlue.withValues(alpha: 0.9),
                      shadows: const [
                        Shadow(color: AppColors.neonBlue, blurRadius: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
