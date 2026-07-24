import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class LoginHeroCharacter extends StatefulWidget {
  const LoginHeroCharacter({super.key});

  @override
  State<LoginHeroCharacter> createState() => _LoginHeroCharacterState();
}

class _LoginHeroCharacterState extends State<LoginHeroCharacter> with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _breathingController,
      builder: (context, child) {
        // Continuous idle breathing & subtle floating animation
        final double breathingOffsetY = sin(_breathingController.value * pi) * 6.0;
        final double scaleFactor = 1.0 + (_breathingController.value * 0.015);

        return Stack(
          alignment: Alignment.bottomLeft,
          children: [
            // 3D Full-Body Hero Character Render
            Transform.translate(
              offset: Offset(0, breathingOffsetY),
              child: Transform.scale(
                scale: scaleFactor,
                child: Image.asset(
                  AppConstants.imgHeroFullBodyLogin,
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.85,
                ),
              ),
            ),

            // Character Holographic Status Badge Overlay
            Positioned(
              left: 20,
              bottom: 40,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.bgCard.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.neonBlue.withValues(alpha: 0.6), width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonBlue.withValues(alpha: 0.2),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.shield, color: AppColors.neonBlue, size: 14),
                        SizedBox(width: 6),
                        Text(
                          'GHOST // AGE 22',
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'CLASS: CYBER NINJA  |  LVL 42  |  SUIT: NANO-V4',
                      style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: AppColors.neonPink.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
